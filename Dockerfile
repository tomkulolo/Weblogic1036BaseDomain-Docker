FROM wise2c/weblogic1035:latest

MAINTAINER Alan Peng <peng.alan@gmail.com>

USER root

ENV CONFIG_JVM_ARGS '-Djava.security.egd=file:/dev/./urandom'

#Add create domain script
ADD create-wls-domain.py /

#Add entrypoint script
ADD entrypoint.sh /

RUN mv create-wls-domain.py /root/Oracle && \
         chmod +x /root/Oracle/create-wls-domain.py && \
         chmod +x /entrypoint.sh

WORKDIR /root/Oracle/Middleware

# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE 7001 5556

ENV PATH $PATH:/root/Oracle/Middleware/wlserver_10.3/common/bin:/root/Oracle/Middleware/user_projects/domains/base_domain/bin

CMD ["/entrypoint.sh"]
