#Install Open JDK 1.8
sudo apt-get update
sudo apt install openjdk-8-jdk

#Install Maven
sudo apt-get update
sudo apt install maven

#Install Docker
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

#Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#Check All Installtions
java -version
mvn -version
docker --version
docker-compose --version

#Clone Hygieia api repository
git clone https://github.com/Hygieia/api.git
cd api

#Build api project
mvn clean package
docker build -t hygieia-api .
cd ..

#Clone Hygieia repository
git clone https://github.com/sourabhgupta385/Hygieia.git
cd Hygieia

#Build the Project
mvn clean install
cd ..

#Clone Jenkins Build Collector repo
git clone https://github.com/Hygieia/hygieia-build-jenkins-collector.git
cd hygieia-build-jenkins-collector

# Build Jenkins Build Collector
mvn install
cd ..

#Before running below commands, set all environment variables in docker-compose.yml file.

#Install Hygieia
cd Hygieia
sudo docker-compose up -d

#Check All containers
sudo docker-compose ps

#To bring down Hygieia setup
#sudo docker-compose down