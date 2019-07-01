Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE387C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C840520652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfGAQIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:08:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37673 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfGAQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:08:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so14481351wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g8EI9dR5wqlWCjkgzqhV+VwB49xCmjs0uCx9m3RSdtw=;
        b=kuLSrq0RpAj7YtSaCqJJGP2qVb+GR4seLWwFKfTrMwI1giCR+KicTqXZKkwfKTnJnI
         8JNkxB2zuZpioDa6Ux3N3rCzkE7SG0H2l3kp5UITJsd4fuYEHSKf5+NLvQuE/vQGgGot
         QKdzCBj7wzerY1NPwSNpbW416z0eExUDALYQx06j4AV+5dLjgknRcX6UHvyBfU8VB6ZV
         LmYkTqPn9UcpgTWWWY3M/C40ot7HhP+WAQGM9lQX1bkvp19+fk7BZ/kc880BTk7R6JC4
         BgXrMLnT4q7eBpwIzLQTJR9L0QnZBhxZWNXa1YDImjBOk8EzLkJ/37WpIadSSvwTs3OQ
         kiPA==
X-Gm-Message-State: APjAAAWFdHN7zl/UIgse1zfGPoS8GdRnqbInpIcfDhDDdCkZFgNHGiw4
        OBqqK7lDDbrz5d0c1YyEbGFhsQ==
X-Google-Smtp-Source: APXvYqxUbiZ/v4dVNuVEoMvePPb3H+nzNZQ0LQC4vMLL5TD+V2lvaiwA+uC+fPxFaAPiV08eAmkzQg==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr19455477wrj.298.1561997289437;
        Mon, 01 Jul 2019 09:08:09 -0700 (PDT)
Received: from raver.teknoraver.net (net-188-216-18-190.cust.vodafonedsl.it. [188.216.18.190])
        by smtp.gmail.com with ESMTPSA id q193sm38329wme.8.2019.07.01.09.08.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 09:08:08 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Subject: [PATCH net] ipv4: don't set IPv6 only flags to IPv4 addresses
Date:   Mon,  1 Jul 2019 18:08:05 +0200
Message-Id: <20190701160805.32404-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the situation where an IPV6 only flag is applied to an IPv4 address:

    # ip addr add 192.0.2.1/24 dev dummy0 nodad home mngtmpaddr noprefixroute
    # ip -4 addr show dev dummy0
    2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
        inet 192.0.2.1/24 scope global noprefixroute dummy0
           valid_lft forever preferred_lft forever

Or worse, by sending a malicious netlink command:

    # ip -4 addr show dev dummy0
    2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
        inet 192.0.2.1/24 scope global nodad optimistic dadfailed home tentative mngtmpaddr noprefixroute stable-privacy dummy0
           valid_lft forever preferred_lft forever

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 net/ipv4/devinet.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c6bd0f7a020a..f40ccdcf4cfe 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -62,6 +62,11 @@
 #include <net/net_namespace.h>
 #include <net/addrconf.h>
 
+#define IPV6ONLY_FLAGS	\
+		(IFA_F_NODAD | IFA_F_OPTIMISTIC | IFA_F_DADFAILED | \
+		 IFA_F_HOMEADDRESS | IFA_F_TENTATIVE | \
+		 IFA_F_MANAGETEMPADDR | IFA_F_STABLE_PRIVACY)
+
 static struct ipv4_devconf ipv4_devconf = {
 	.data = {
 		[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1] = 1,
@@ -468,6 +473,9 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 	ifa->ifa_flags &= ~IFA_F_SECONDARY;
 	last_primary = &in_dev->ifa_list;
 
+	/* Don't set IPv6 only flags to IPv6 addresses */
+	ifa->ifa_flags &= ~IPV6ONLY_FLAGS;
+
 	for (ifap = &in_dev->ifa_list; (ifa1 = *ifap) != NULL;
 	     ifap = &ifa1->ifa_next) {
 		if (!(ifa1->ifa_flags & IFA_F_SECONDARY) &&
-- 
2.21.0

