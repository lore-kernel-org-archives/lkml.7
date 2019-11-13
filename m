Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D62C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B37F22459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611546;
	bh=eJF2Lv1JO7SGTrNnwUZO9cfYP9zZZ6tpTHTU0INEZ64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R56f5XOO9hTR3lVPFxpj7u+8kcE/m5llr//ISBsWigbB8OZrEA72tU4RaW2T1FV08
	 xXkJDW53MMhMyfKkTLhH69MgQLmTe0LmmQvtFz2SwL4VvH/RUIW2027Xh+X11QdzVm
	 wKLxLewQe3PwY5bpz4UtJhNdCbOjm4WCd7vA9BSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfKMCTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:19:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbfKMBz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:55:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47773222CD;
        Wed, 13 Nov 2019 01:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610128;
        bh=eJF2Lv1JO7SGTrNnwUZO9cfYP9zZZ6tpTHTU0INEZ64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntoEW3NC7YBzzgdtWPpD4y+/WdXWizmVutsxPwqrBWlxgd/WGIGvWCfWdCr5UP01d
         JnsO63of80XtbEZE2aQY0cRSSd5+2ZR0c5gtqoXJTZ+4unSh/U8V/U8wYYMSJe+uKy
         RdTLTM9YzaLEtCOsM56S2DKRRaYc1KpJeJfYq7OI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 178/209] net: fix generic XDP to handle if eth header was mangled
Date:   Tue, 12 Nov 2019 20:49:54 -0500
Message-Id: <20191113015025.9685-178-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 2972495699320229b55b8e5065a310be5c81485b ]

XDP can modify (and resize) the Ethernet header in the packet.

There is a bug in generic-XDP, because skb->protocol and skb->pkt_type
are setup before reaching (netif_receive_)generic_xdp.

This bug was hit when XDP were popping VLAN headers (changing
eth->h_proto), as skb->protocol still contains VLAN-indication
(ETH_P_8021Q) causing invocation of skb_vlan_untag(skb), which corrupt
the packet (basically popping the VLAN again).

This patch catch if XDP changed eth header in such a way, that SKB
fields needs to be updated.

V2: on request from Song Liu, use ETH_HLEN instead of mac_len,
in __skb_push() as eth_type_trans() use ETH_HLEN in paired skb_pull_inline().

Fixes: d445516966dc ("net: xdp: support xdp generic on virtual devices")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index ddd8aab20adf2..3e8b468a9f264 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4296,6 +4296,9 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 	struct netdev_rx_queue *rxqueue;
 	void *orig_data, *orig_data_end;
 	u32 metalen, act = XDP_DROP;
+	__be16 orig_eth_type;
+	struct ethhdr *eth;
+	bool orig_bcast;
 	int hlen, off;
 	u32 mac_len;
 
@@ -4336,6 +4339,9 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 	xdp->data_hard_start = skb->data - skb_headroom(skb);
 	orig_data_end = xdp->data_end;
 	orig_data = xdp->data;
+	eth = (struct ethhdr *)xdp->data;
+	orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
+	orig_eth_type = eth->h_proto;
 
 	rxqueue = netif_get_rxqueue(skb);
 	xdp->rxq = &rxqueue->xdp_rxq;
@@ -4359,6 +4365,14 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 
 	}
 
+	/* check if XDP changed eth hdr such SKB needs update */
+	eth = (struct ethhdr *)xdp->data;
+	if ((orig_eth_type != eth->h_proto) ||
+	    (orig_bcast != is_multicast_ether_addr_64bits(eth->h_dest))) {
+		__skb_push(skb, ETH_HLEN);
+		skb->protocol = eth_type_trans(skb, skb->dev);
+	}
+
 	switch (act) {
 	case XDP_REDIRECT:
 	case XDP_TX:
-- 
2.20.1

