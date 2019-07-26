Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7F8C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EE222CB9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154956;
	bh=Vl2JczSpl5+GItRq7QE1EzCi6nNwpumi/bsx7ruQJJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jC7QFuot6KX3crYUwpsBN39+YApDjt9J4amyYOk4zOkebm0ulFqe3f2e34bBjDG9d
	 Bsej+PWOw4Pb4WmgIeJ4rTx743aJaASQV5vH/z22M2UbBlasTyrDqOpsJJEzatChVG
	 H3bcx0jVnrKtaXlkolDH4lnH4sPR4vpaOpd0dOQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbfGZP3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388716AbfGZP3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:29:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9975122C7E;
        Fri, 26 Jul 2019 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154952;
        bh=Vl2JczSpl5+GItRq7QE1EzCi6nNwpumi/bsx7ruQJJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkkNu8UcTmUSDqqln+nawLm7bpbrNmw7HUtqEiAgxSMPLAY9e6k7IMVTFXShBGfVw
         IUgtB6y7U+U4VIUjToo79vgZOIWNok0Y64ygsC5sGenPoRFEUGioH2h+pNSnXPKepn
         vi8e/6fULtRDiVe7DgtzhcPVzQ3j2EjdhoICFCHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 05/62] ipv4: dont set IPv6 only flags to IPv4 addresses
Date:   Fri, 26 Jul 2019 17:24:17 +0200
Message-Id: <20190726152302.272064176@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
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
@@ -66,6 +66,11 @@
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
@@ -472,6 +477,9 @@ static int __inet_insert_ifa(struct in_i
 	ifa->ifa_flags &= ~IFA_F_SECONDARY;
 	last_primary = &in_dev->ifa_list;
 
+	/* Don't set IPv6 only flags to IPv4 addresses */
+	ifa->ifa_flags &= ~IPV6ONLY_FLAGS;
+
 	for (ifap = &in_dev->ifa_list; (ifa1 = *ifap) != NULL;
 	     ifap = &ifa1->ifa_next) {
 		if (!(ifa1->ifa_flags & IFA_F_SECONDARY) &&


