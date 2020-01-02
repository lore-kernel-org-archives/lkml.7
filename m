Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E45C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320C621835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004016;
	bh=pi/E5OK/dHkbntXNF3ItM8V+BH+oRqC2eUsc7jvXQOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bDz/jAYWeyYJzBYrvzhdFZRmTTZb0wWE8pU+U0YEBjPlaDkYJV6SgM7euiMzkKpuP
	 lkk4bqi8cviGBK92Dhzees7u4Dzb8uDcZLJD0F2ZauCIlOY1OoiTaPRVSWIAW3UZbL
	 eoUr5eUeRWswvESzQ9vfYQy6P2nn8BMd2hVzJYxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgABW0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:26:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbgABW0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:26:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDF7222C3;
        Thu,  2 Jan 2020 22:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004009;
        bh=pi/E5OK/dHkbntXNF3ItM8V+BH+oRqC2eUsc7jvXQOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4NIzgQ16egOpSR0+VoOZFM//4TgvJX8pJ9j9r0epf28nJhlCylLC82ZDxRHy6STH
         //YKADRuDO/TCXxl+MJnEsRZK5QesFknm26fPfYLY6r0YSStcGQH7pZcFM7SAq16JC
         yBzQMysWxG2wc39X4te0obMQaFlHaIVScp4SRvUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 84/91] vti: do not confirm neighbor when do pmtu update
Date:   Thu,  2 Jan 2020 23:08:06 +0100
Message-Id: <20200102220451.037924125@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 8247a79efa2f28b44329f363272550c1738377de ]

When do IPv6 tunnel PMTU update and calls __ip6_rt_update_pmtu() in the end,
we should not call dst_confirm_neigh() as there is no two-way communication.

Although vti and vti6 are immune to this problem because they are IFF_NOARP
interfaces, as Guillaume pointed. There is still no sense to confirm neighbour
here.

v5: Update commit description.
v4: No change.
v3: Do not remove dst_confirm_neigh, but add a new bool parameter in
    dst_ops.update_pmtu to control whether we should do neighbor confirm.
    Also split the big patch to small ones for each area.
v2: Remove dst_confirm_neigh in __ip6_rt_update_pmtu.

Reviewed-by: Guillaume Nault <gnault@redhat.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_vti.c  |    2 +-
 net/ipv6/ip6_vti.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -244,7 +244,7 @@ static netdev_tx_t vti_xmit(struct sk_bu
 
 	mtu = dst_mtu(dst);
 	if (skb->len > mtu) {
-		skb_dst_update_pmtu(skb, mtu);
+		skb_dst_update_pmtu_no_confirm(skb, mtu);
 		if (skb->protocol == htons(ETH_P_IP)) {
 			icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 				  htonl(mtu));
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -483,7 +483,7 @@ vti6_xmit(struct sk_buff *skb, struct ne
 
 	mtu = dst_mtu(dst);
 	if (skb->len > mtu) {
-		skb_dst_update_pmtu(skb, mtu);
+		skb_dst_update_pmtu_no_confirm(skb, mtu);
 
 		if (skb->protocol == htons(ETH_P_IPV6)) {
 			if (mtu < IPV6_MIN_MTU)


