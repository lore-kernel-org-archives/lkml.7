Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E289AC10F11
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDEF20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfDNBuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 21:50:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41914 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbfDNBtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 21:49:01 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2A8B46AF04941FC499C6;
        Sun, 14 Apr 2019 09:48:57 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Sun, 14 Apr 2019 09:48:50 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 06/12] net: hns3: add hns3_gro_complete for HW GRO process
Date:   Sun, 14 Apr 2019 09:47:40 +0800
Message-ID: <1555206466-44240-7-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555206466-44240-1-git-send-email-tanhuazhong@huawei.com>
References: <1555206466-44240-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When a GRO packet is received by driver, the cwr field in the
struct tcphdr needs to be checked to decide whether to set the
SKB_GSO_TCP_ECN for skb_shinfo(skb)->gso_type.

So this patch adds hns3_gro_complete to do that, and adds the
hns3_handle_bdinfo to handle the hns3_gro_complete and
hns3_rx_checksum.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 198 +++++++++++++++---------
 1 file changed, 123 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 60afa15..a67dfdd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2331,6 +2331,44 @@ static void hns3_nic_reuse_page(struct sk_buff *skb, int i,
 	}
 }
 
+static int hns3_gro_complete(struct sk_buff *skb)
+{
+	__be16 type = skb->protocol;
+	struct tcphdr *th;
+	int depth = 0;
+
+	while (type == htons(ETH_P_8021Q)) {
+		struct vlan_hdr *vh;
+
+		if ((depth + VLAN_HLEN) > skb_headlen(skb))
+			return -EFAULT;
+
+		vh = (struct vlan_hdr *)(skb->data + depth);
+		type = vh->h_vlan_encapsulated_proto;
+		depth += VLAN_HLEN;
+	}
+
+	if (type == htons(ETH_P_IP)) {
+		depth += sizeof(struct iphdr);
+	} else if (type == htons(ETH_P_IPV6)) {
+		depth += sizeof(struct ipv6hdr);
+	} else {
+		netdev_err(skb->dev,
+			   "Error: FW GRO supports only IPv4/IPv6, not 0x%04x, depth: %d\n",
+			   be16_to_cpu(type), depth);
+		return -EFAULT;
+	}
+
+	th = (struct tcphdr *)(skb->data + depth);
+	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
+	if (th->cwr)
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	return 0;
+}
+
 static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 			     u32 l234info, u32 bd_base_info)
 {
@@ -2345,12 +2383,6 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 	if (!(netdev->features & NETIF_F_RXCSUM))
 		return;
 
-	/* We MUST enable hardware checksum before enabling hardware GRO */
-	if (skb_shinfo(skb)->gso_size) {
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		return;
-	}
-
 	/* check if hardware has done checksum */
 	if (!(bd_base_info & BIT(HNS3_RXD_L3L4P_B)))
 		return;
@@ -2567,8 +2599,9 @@ static int hns3_add_frag(struct hns3_enet_ring *ring, struct hns3_desc *desc,
 	return 0;
 }
 
-static void hns3_set_gro_param(struct sk_buff *skb, u32 l234info,
-			       u32 bd_base_info)
+static int hns3_set_gro_and_checksum(struct hns3_enet_ring *ring,
+				     struct sk_buff *skb, u32 l234info,
+				     u32 bd_base_info)
 {
 	u16 gro_count;
 	u32 l3_type;
@@ -2576,12 +2609,11 @@ static void hns3_set_gro_param(struct sk_buff *skb, u32 l234info,
 	gro_count = hnae3_get_field(l234info, HNS3_RXD_GRO_COUNT_M,
 				    HNS3_RXD_GRO_COUNT_S);
 	/* if there is no HW GRO, do not set gro params */
-	if (!gro_count)
-		return;
+	if (!gro_count) {
+		hns3_rx_checksum(ring, skb, l234info, bd_base_info);
+		return 0;
+	}
 
-	/* tcp_gro_complete() will copy NAPI_GRO_CB(skb)->count
-	 * to skb_shinfo(skb)->gso_segs
-	 */
 	NAPI_GRO_CB(skb)->count = gro_count;
 
 	l3_type = hnae3_get_field(l234info, HNS3_RXD_L3ID_M,
@@ -2591,13 +2623,13 @@ static void hns3_set_gro_param(struct sk_buff *skb, u32 l234info,
 	else if (l3_type == HNS3_L3_TYPE_IPV6)
 		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
 	else
-		return;
+		return -EFAULT;
 
 	skb_shinfo(skb)->gso_size = hnae3_get_field(bd_base_info,
 						    HNS3_RXD_GRO_SIZE_M,
 						    HNS3_RXD_GRO_SIZE_S);
-	if (skb_shinfo(skb)->gso_size)
-		tcp_gro_complete(skb);
+
+	return  hns3_gro_complete(skb);
 }
 
 static void hns3_set_rx_skb_rss_type(struct hns3_enet_ring *ring,
@@ -2622,16 +2654,85 @@ static void hns3_set_rx_skb_rss_type(struct hns3_enet_ring *ring,
 	skb_set_hash(skb, le32_to_cpu(desc->rx.rss_hash), rss_type);
 }
 
-static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
-			     struct sk_buff **out_skb)
+static int hns3_handle_bdinfo(struct hns3_enet_ring *ring, struct sk_buff *skb,
+			      struct hns3_desc *desc)
 {
 	struct net_device *netdev = ring->tqp->handle->kinfo.netdev;
+	u32 bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
+	u32 l234info = le32_to_cpu(desc->rx.l234_info);
 	enum hns3_pkt_l2t_type l2_frame_type;
+	unsigned int len;
+	int ret;
+
+	/* Based on hw strategy, the tag offloaded will be stored at
+	 * ot_vlan_tag in two layer tag case, and stored at vlan_tag
+	 * in one layer tag case.
+	 */
+	if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX) {
+		u16 vlan_tag;
+
+		if (hns3_parse_vlan_tag(ring, desc, l234info, &vlan_tag))
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       vlan_tag);
+	}
+
+	if (unlikely(!(bd_base_info & BIT(HNS3_RXD_VLD_B)))) {
+		u64_stats_update_begin(&ring->syncp);
+		ring->stats.non_vld_descs++;
+		u64_stats_update_end(&ring->syncp);
+
+		return -EINVAL;
+	}
+
+	if (unlikely(!desc->rx.pkt_len || (l234info & (BIT(HNS3_RXD_TRUNCAT_B) |
+				  BIT(HNS3_RXD_L2E_B))))) {
+		u64_stats_update_begin(&ring->syncp);
+		if (l234info & BIT(HNS3_RXD_L2E_B))
+			ring->stats.l2_err++;
+		else
+			ring->stats.err_pkt_len++;
+		u64_stats_update_end(&ring->syncp);
+
+		return -EFAULT;
+	}
+
+	len = skb->len;
+
+	/* Do update ip stack process */
+	skb->protocol = eth_type_trans(skb, netdev);
+
+	/* This is needed in order to enable forwarding support */
+	ret = hns3_set_gro_and_checksum(ring, skb, l234info, bd_base_info);
+	if (unlikely(ret)) {
+		u64_stats_update_begin(&ring->syncp);
+		ring->stats.rx_err_cnt++;
+		u64_stats_update_end(&ring->syncp);
+		return ret;
+	}
+
+	l2_frame_type = hnae3_get_field(l234info, HNS3_RXD_DMAC_M,
+					HNS3_RXD_DMAC_S);
+
+	u64_stats_update_begin(&ring->syncp);
+	ring->stats.rx_pkts++;
+	ring->stats.rx_bytes += len;
+
+	if (l2_frame_type == HNS3_L2_TYPE_MULTICAST)
+		ring->stats.rx_multicast++;
+
+	u64_stats_update_end(&ring->syncp);
+
+	ring->tqp_vector->rx_group.total_bytes += len;
+	return 0;
+}
+
+static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
+			     struct sk_buff **out_skb)
+{
 	struct sk_buff *skb = ring->skb;
 	struct hns3_desc_cb *desc_cb;
 	struct hns3_desc *desc;
 	u32 bd_base_info;
-	u32 l234info;
 	int length;
 	int ret;
 
@@ -2691,62 +2792,12 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 		       ALIGN(ring->pull_len, sizeof(long)));
 	}
 
-	l234info = le32_to_cpu(desc->rx.l234_info);
-	bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
-
-	/* Based on hw strategy, the tag offloaded will be stored at
-	 * ot_vlan_tag in two layer tag case, and stored at vlan_tag
-	 * in one layer tag case.
-	 */
-	if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX) {
-		u16 vlan_tag;
-
-		if (hns3_parse_vlan_tag(ring, desc, l234info, &vlan_tag))
-			__vlan_hwaccel_put_tag(skb,
-					       htons(ETH_P_8021Q),
-					       vlan_tag);
-	}
-
-	if (unlikely(!(bd_base_info & BIT(HNS3_RXD_VLD_B)))) {
-		u64_stats_update_begin(&ring->syncp);
-		ring->stats.non_vld_descs++;
-		u64_stats_update_end(&ring->syncp);
-
-		dev_kfree_skb_any(skb);
-		return -EINVAL;
-	}
-
-	if (unlikely((!desc->rx.pkt_len) ||
-		     (l234info & (BIT(HNS3_RXD_TRUNCAT_B) |
-				  BIT(HNS3_RXD_L2E_B))))) {
-		u64_stats_update_begin(&ring->syncp);
-		if (l234info & BIT(HNS3_RXD_L2E_B))
-			ring->stats.l2_err++;
-		else
-			ring->stats.err_pkt_len++;
-		u64_stats_update_end(&ring->syncp);
-
+	ret = hns3_handle_bdinfo(ring, skb, desc);
+	if (unlikely(ret)) {
 		dev_kfree_skb_any(skb);
-		return -EFAULT;
+		return ret;
 	}
 
-
-	l2_frame_type = hnae3_get_field(l234info, HNS3_RXD_DMAC_M,
-					HNS3_RXD_DMAC_S);
-	u64_stats_update_begin(&ring->syncp);
-	if (l2_frame_type == HNS3_L2_TYPE_MULTICAST)
-		ring->stats.rx_multicast++;
-
-	ring->stats.rx_pkts++;
-	ring->stats.rx_bytes += skb->len;
-	u64_stats_update_end(&ring->syncp);
-
-	ring->tqp_vector->rx_group.total_bytes += skb->len;
-
-	/* This is needed in order to enable forwarding support */
-	hns3_set_gro_param(skb, l234info, bd_base_info);
-
-	hns3_rx_checksum(ring, skb, l234info, bd_base_info);
 	*out_skb = skb;
 	hns3_set_rx_skb_rss_type(ring, skb);
 
@@ -2758,7 +2809,6 @@ int hns3_clean_rx_ring(
 		void (*rx_fn)(struct hns3_enet_ring *, struct sk_buff *))
 {
 #define RCB_NOF_ALLOC_RX_BUFF_ONCE 16
-	struct net_device *netdev = ring->tqp->handle->kinfo.netdev;
 	int recv_pkts, recv_bds, clean_count, err;
 	int unused_count = hns3_desc_unused(ring) - ring->pending_buf;
 	struct sk_buff *skb = ring->skb;
@@ -2795,8 +2845,6 @@ int hns3_clean_rx_ring(
 			continue;
 		}
 
-		/* Do update ip stack process */
-		skb->protocol = eth_type_trans(skb, netdev);
 		rx_fn(ring, skb);
 		recv_bds += ring->pending_buf;
 		clean_count += ring->pending_buf;
-- 
2.7.4

