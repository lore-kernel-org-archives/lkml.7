Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38197C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C0321903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127400;
	bh=Pq0pvgfRWgNwv/eNOdIFPNnzLyE5PGkLeHz0Qnhk95k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XMdi8zC0DfCnw4DN4xWWNKrxZSXkEU/1e+KIyZw9Ft6KwRuJaPF3WOSa99QmxVkf/
	 z9ZnUxNteKynrz9wHOjEpFXeyVbBjQKokdE9G2GZx8WpMYqjDBu2g1JHsn+ikTw+sf
	 wXrJuZnLAcPR+WY6wDT5jOnUDO+HP4KChMPsP7eY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391379AbfDXRgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403873AbfDXRgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:32 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 908D721903;
        Wed, 24 Apr 2019 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127392;
        bh=Pq0pvgfRWgNwv/eNOdIFPNnzLyE5PGkLeHz0Qnhk95k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NED1N0iAmU/EyU2Vb5EgdZ9pGqSCGo+wtu9SHfPqWj7MmI0xjr5DVxexGmR3xSgRu
         djnpprnn7S/kglx33ZlHZTIh0uMeNQtQLAjLKxxAvtc2bO6avkwSYiqPmNYK8cMBDg
         b5uO0X1AOB/TTbWUbp3/sNlugIvg2pCJnWsyiRiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.0 030/115] net/mlx5e: Rx, Fixup skb checksum for packets with tail padding
Date:   Wed, 24 Apr 2019 19:09:26 +0200
Message-Id: <20190424170926.798289934@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit 0aa1d18615c163f92935b806dcaff9157645233a ]

When an ethernet frame with ip payload is padded, the padding octets are
not covered by the hardware checksum.

Prior to the cited commit, skb checksum was forced to be CHECKSUM_NONE
when padding is detected. After it, the kernel will try to trim the
padding bytes and subtract their checksum from skb->csum.

In this patch we fixup skb->csum for any ip packet with tail padding of
any size, if any padding found.
FCS case is just one special case of this general purpose patch, hence,
it is removed.

Fixes: 88078d98d1bb ("net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends"),
Cc: Eric Dumazet <edumazet@google.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   79 +++++++++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |    4 +
 3 files changed, 74 insertions(+), 15 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -713,17 +713,6 @@ static inline void mlx5e_enable_ecn(stru
 	rq->stats->ecn_mark += !!rc;
 }
 
-static u32 mlx5e_get_fcs(const struct sk_buff *skb)
-{
-	const void *fcs_bytes;
-	u32 _fcs_bytes;
-
-	fcs_bytes = skb_header_pointer(skb, skb->len - ETH_FCS_LEN,
-				       ETH_FCS_LEN, &_fcs_bytes);
-
-	return __get_unaligned_cpu32(fcs_bytes);
-}
-
 static u8 get_ip_proto(struct sk_buff *skb, int network_depth, __be16 proto)
 {
 	void *ip_p = skb->data + network_depth;
@@ -734,6 +723,68 @@ static u8 get_ip_proto(struct sk_buff *s
 
 #define short_frame(size) ((size) <= ETH_ZLEN + ETH_FCS_LEN)
 
+#define MAX_PADDING 8
+
+static void
+tail_padding_csum_slow(struct sk_buff *skb, int offset, int len,
+		       struct mlx5e_rq_stats *stats)
+{
+	stats->csum_complete_tail_slow++;
+	skb->csum = csum_block_add(skb->csum,
+				   skb_checksum(skb, offset, len, 0),
+				   offset);
+}
+
+static void
+tail_padding_csum(struct sk_buff *skb, int offset,
+		  struct mlx5e_rq_stats *stats)
+{
+	u8 tail_padding[MAX_PADDING];
+	int len = skb->len - offset;
+	void *tail;
+
+	if (unlikely(len > MAX_PADDING)) {
+		tail_padding_csum_slow(skb, offset, len, stats);
+		return;
+	}
+
+	tail = skb_header_pointer(skb, offset, len, tail_padding);
+	if (unlikely(!tail)) {
+		tail_padding_csum_slow(skb, offset, len, stats);
+		return;
+	}
+
+	stats->csum_complete_tail++;
+	skb->csum = csum_block_add(skb->csum, csum_partial(tail, len, 0), offset);
+}
+
+static void
+mlx5e_skb_padding_csum(struct sk_buff *skb, int network_depth, __be16 proto,
+		       struct mlx5e_rq_stats *stats)
+{
+	struct ipv6hdr *ip6;
+	struct iphdr   *ip4;
+	int pkt_len;
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		ip4 = (struct iphdr *)(skb->data + network_depth);
+		pkt_len = network_depth + ntohs(ip4->tot_len);
+		break;
+	case htons(ETH_P_IPV6):
+		ip6 = (struct ipv6hdr *)(skb->data + network_depth);
+		pkt_len = network_depth + sizeof(*ip6) + ntohs(ip6->payload_len);
+		break;
+	default:
+		return;
+	}
+
+	if (likely(pkt_len >= skb->len))
+		return;
+
+	tail_padding_csum(skb, pkt_len, stats);
+}
+
 static inline void mlx5e_handle_csum(struct net_device *netdev,
 				     struct mlx5_cqe64 *cqe,
 				     struct mlx5e_rq *rq,
@@ -782,10 +833,8 @@ static inline void mlx5e_handle_csum(str
 			skb->csum = csum_partial(skb->data + ETH_HLEN,
 						 network_depth - ETH_HLEN,
 						 skb->csum);
-		if (unlikely(netdev->features & NETIF_F_RXFCS))
-			skb->csum = csum_block_add(skb->csum,
-						   (__force __wsum)mlx5e_get_fcs(skb),
-						   skb->len - ETH_FCS_LEN);
+
+		mlx5e_skb_padding_csum(skb, network_depth, proto, stats);
 		stats->csum_complete++;
 		return;
 	}
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -59,6 +59,8 @@ static const struct counter_desc sw_stat
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_csum_unnecessary) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_csum_none) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_csum_complete) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_csum_complete_tail) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_csum_complete_tail_slow) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_csum_unnecessary_inner) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_xdp_drop) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_xdp_redirect) },
@@ -151,6 +153,8 @@ void mlx5e_grp_sw_update_stats(struct ml
 		s->rx_removed_vlan_packets += rq_stats->removed_vlan_packets;
 		s->rx_csum_none	+= rq_stats->csum_none;
 		s->rx_csum_complete += rq_stats->csum_complete;
+		s->rx_csum_complete_tail += rq_stats->csum_complete_tail;
+		s->rx_csum_complete_tail_slow += rq_stats->csum_complete_tail_slow;
 		s->rx_csum_unnecessary += rq_stats->csum_unnecessary;
 		s->rx_csum_unnecessary_inner += rq_stats->csum_unnecessary_inner;
 		s->rx_xdp_drop     += rq_stats->xdp_drop;
@@ -1192,6 +1196,8 @@ static const struct counter_desc rq_stat
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, csum_complete) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, csum_complete_tail) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, csum_complete_tail_slow) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, csum_unnecessary) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, csum_unnecessary_inner) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, csum_none) },
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -71,6 +71,8 @@ struct mlx5e_sw_stats {
 	u64 rx_csum_unnecessary;
 	u64 rx_csum_none;
 	u64 rx_csum_complete;
+	u64 rx_csum_complete_tail;
+	u64 rx_csum_complete_tail_slow;
 	u64 rx_csum_unnecessary_inner;
 	u64 rx_xdp_drop;
 	u64 rx_xdp_redirect;
@@ -181,6 +183,8 @@ struct mlx5e_rq_stats {
 	u64 packets;
 	u64 bytes;
 	u64 csum_complete;
+	u64 csum_complete_tail;
+	u64 csum_complete_tail_slow;
 	u64 csum_unnecessary;
 	u64 csum_unnecessary_inner;
 	u64 csum_none;


