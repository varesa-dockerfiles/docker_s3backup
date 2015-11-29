FROM centos

RUN yum update -y
RUN yum install -y git python python-setuptools

RUN bash -c "git clone https://github.com/pearltrees/s3cmd-modification || echo 'Workaround for broken symlinks in repo'"
WORKDIR /s3cmd-modification
RUN python setup.py install
WORKDIR /
RUN rm -rf /s3cmd-modification

ADD s3dockerbackup.sh /s3dockerbackup.sh

VOLUME /root/.s3cfg

CMD /s3dockerbackup.sh

