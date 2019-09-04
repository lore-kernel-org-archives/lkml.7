Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D5C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F771208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620674;
	bh=56xJezm7lAXrT8d3Ze0+Y4GyCi8LcSm62OVfEg/l9BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2DrReCja8F/BUcml9JQK54bOFCOyUoBG4xKlJke001KFJHNX42/c+c3+i5dA/t7Tc
	 u7mjEFPk9ZWEUR1c0cS4dhBiMZKp590DTpqW6ouGpsB7ySbrzCSwXc5PWKSDxGOHPd
	 kFaIpdxS4vT8mk5yXEzy+jcZdfsTqUpB2Vw2h7ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390236AbfIDSLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390218AbfIDSLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:11:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4849922CEA;
        Wed,  4 Sep 2019 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620667;
        bh=56xJezm7lAXrT8d3Ze0+Y4GyCi8LcSm62OVfEg/l9BY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J51wImASU42SVUzhdu4lCVUEQ7lKhr3ttJE4cLklKHJtNgJx+KDaBXn6jBZQhm+QJ
         +ZgUbKLKJ854LG8PL1QnStLUea3lRYAkDT/aqxXsHjKjF7nEezcuGGI8TCQTd7cadv
         mrvHOiQD3J+560rkon535VS1AO7UDxXMCvaF+mWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 049/143] ipv6/addrconf: allow adding multicast addr if IFA_F_MCAUTOJOIN is set
Date:   Wed,  4 Sep 2019 19:53:12 +0200
Message-Id: <20190904175315.989326532@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit f17f7648a49aa6728649ddf79bdbcac4f1970ce4 ]

In commit 93a714d6b53d ("multicast: Extend ip address command to enable
multicast group join/leave on") we added a new flag IFA_F_MCAUTOJOIN
to make user able to add multicast address on ethernet interface.

This works for IPv4, but not for IPv6. See the inet6_addr_add code.

static int inet6_addr_add()
{
	...
	if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
		ipv6_mc_config(net->ipv6.mc_autojoin_sk, true...)
	}

	ifp = ipv6_add_addr(idev, cfg, true, extack); <- always fail with maddr
	if (!IS_ERR(ifp)) {
		...
	} else if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
		ipv6_mc_config(net->ipv6.mc_autojoin_sk, false...)
	}
}

But in ipv6_add_addr() it will check the address type and reject multicast
address directly. So this feature is never worked for IPv6.

We should not remove the multicast address check totally in ipv6_add_addr(),
but could accept multicast address only when IFA_F_MCAUTOJOIN flag supplied.

v2: update commit description

Fixes: 93a714d6b53d ("multicast: Extend ip address command to enable multicast group join/leave on")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1045,7 +1045,8 @@ ipv6_add_addr(struct inet6_dev *idev, st
 	int err = 0;
 
 	if (addr_type == IPV6_ADDR_ANY ||
-	    addr_type & IPV6_ADDR_MULTICAST ||
+	    (addr_type & IPV6_ADDR_MULTICAST &&
+	     !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
 	    (!(idev->dev->flags & IFF_LOOPBACK) &&
 	     !netif_is_l3_master(idev->dev) &&
 	     addr_type & IPV6_ADDR_LOOPBACK))


