Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2BCC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823E12086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738772;
	bh=F9f8+XQ9K6uxWrdp5WlnfE4VLwtyVaBH0OGVXCRB8DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cCSDmxjHVG9J+1yyRK2GSNRtSpvjDzh/siLkUOzHBx1UZ0Bmkm70tXiTkW2LLyytr
	 hcIk+KX/vofXjJ8iBvFDO/5cr72m9DKMzGB+BB/YoVpIbQypVqWOMA8zbHMlSQkYPJ
	 n1kKSpOw7L+FwCMC2trKN7hz4NKHvq++JpJQIbLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbfHBJdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390487AbfHBJdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:33:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73669217D7;
        Fri,  2 Aug 2019 09:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738417;
        bh=F9f8+XQ9K6uxWrdp5WlnfE4VLwtyVaBH0OGVXCRB8DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQ1GHBbUyBHl5fBsBkwVnIgE07e2ORLpZSZGEy2AA0GI2yJBGFJQC6oIbpLWjdDnn
         nZ5DT48784YaTP1aGSJbggwvp62ajH3Q7A1hYg4Z+dtjiLXrpaxckS8qLyOd3DQZSp
         XtHLQRqAjyWB15X+lsjeHhjBWH7044iyrHk3XvbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 088/158] ipv4: dont set IPv6 only flags to IPv4 addresses
Date:   Fri,  2 Aug 2019 11:28:29 +0200
Message-Id: <20190802092222.217259673@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit 2e60546368165c2449564d71f6005dda9205b5fb ]

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
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/devinet.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -67,6 +67,11 @@
 
 #include "fib_lookup.h"
 
+#define IPV6ONLY_FLAGS	\
+		(IFA_F_NODAD | IFA_F_OPTIMISTIC | IFA_F_DADFAILED | \
+		 IFA_F_HOMEADDRESS | IFA_F_TENTATIVE | \
+		 IFA_F_MANAGETEMPADDR | IFA_F_STABLE_PRIVACY)
+
 static struct ipv4_devconf ipv4_devconf = {
 	.data = {
 		[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1] = 1,
@@ -453,6 +458,9 @@ static int __inet_insert_ifa(struct in_i
 	ifa->ifa_flags &= ~IFA_F_SECONDARY;
 	last_primary = &in_dev->ifa_list;
 
+	/* Don't set IPv6 only flags to IPv4 addresses */
+	ifa->ifa_flags &= ~IPV6ONLY_FLAGS;
+
 	for (ifap = &in_dev->ifa_list; (ifa1 = *ifap) != NULL;
 	     ifap = &ifa1->ifa_next) {
 		if (!(ifa1->ifa_flags & IFA_F_SECONDARY) &&


