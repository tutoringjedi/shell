#!/bin/bash
set -x

############################################
# DSI CONSULTING INC. Project setup script #
############################################
# This script creates standard analysis and output directories
# for a new project. It also creates a README file with the
# project name and a brief description of the project.
# Then it unzips the raw data provided by the client.

if [ -d newproject ]; then
  echo "Recreating the newproject directory"
  rm -rf newproject
fi
mkdir newproject
cd newproject

mkdir analysis output
touch README.md
echo "# Project Name: DSI Consulting Inc." > README.md
touch analysis/main.py

# download client data
curl -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
unzip -q rawdata.zip

###########################################
# 1. Create a directory named data
mkdir data

# 2. Move the ./rawdata directory to ./data/raw
mv rawdata data/raw

# 3. List the contents of the ./data/raw directory
ls data/raw

# 4. Create the directory ./data/processed and sub-directories
mkdir -p data/processed/server_logs data/processed/user_logs data/processed/event_logs

# 5. Copy all server log files
cp data/raw/*server*.log data/processed/server_logs

# 6. Repeat for user and event logs
cp data/raw/*user_log*.log data/processed/user_logs
cp data/raw/*event*.log data/processed/event_logs

# 7. Remove files with ipaddr in the name
rm data/raw/*ipaddr*
rm data/processed/user_logs/*ipaddr* 2>/dev/null || true

# 8. Create inventory.txt
find data/processed -type f > data/inventory.txt

###########################################

echo "Project setup is complete!"
