Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E54C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37A020848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005546;
	bh=m+bg6XXI3F0uyLMsrHSQ2CbN2ECiRxioO839FmuczGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qlMNPtoILcknefl0gCNBvC6qxbnZpfzdGCEywbIUpN0UQCtpvgh4zgjGkmx3vRiht
	 FFqp+sWHz398y5zTK0jCkejmBahh3C4Za65Ab8Ufyp1+m4wuLjiYvfL43Y80c4cXQu
	 c0mj+egA/F50wuEGPCy8/cG4IQoh8f5ZIX7EzmDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgABWwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbgABWW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:22:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A8A20863;
        Thu,  2 Jan 2020 22:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003776;
        bh=m+bg6XXI3F0uyLMsrHSQ2CbN2ECiRxioO839FmuczGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oi5oaZsuMeOep39GqyGArcIR7/95qQdnjf/f2DOujBw5a2rAWbZWzDSdJ2fI4hMvT
         ol96nbRoM/4NN3zezjquRa9u001BhbcOSqy6W53zxTh4SS5tkyf0e3LqjtJEhgQ61V
         /ZWgbvg7RwFlzuCSRe4/Yi7k8QPzf7JJSI05Dg6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 102/114] vti: do not confirm neighbor when do pmtu update
Date:   Thu,  2 Jan 2020 23:07:54 +0100
Message-Id: <20200102220039.477125871@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
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
@@ -235,7 +235,7 @@ static netdev_tx_t vti_xmit(struct sk_bu
 
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


