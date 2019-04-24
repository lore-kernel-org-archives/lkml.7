Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6AAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728E7218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfDXDXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:23:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728333AbfDXDX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 23:23:28 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5903FD9FC120D7713225;
        Wed, 24 Apr 2019 11:23:25 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 11:23:16 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: handle the BD info on the last BD of the packet
Date:   Wed, 24 Apr 2019 11:21:58 +0800
Message-ID: <1556076127-61459-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556076127-61459-1-git-send-email-tanhuazhong@huawei.com>
References: <1556076127-61459-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The bdinfo handled in hns3_handle_bdinfo is only valid on the
last BD of the current packet, currently the bd info may be handled
based on the first BD if the packet has more than two BDs, which
may cause rx error.

This patch fixes it by using the last BD of the current packet in
hns3_handle_bdinfo.

Also, hns3_set_rx_skb_rss_type has used RSS hash value from the last
BD of the current packet, so remove the same last BD calculation in
hns3_set_rx_skb_rss_type and call it from hns3_handle_bdinfo.

Fixes: e55970950556 ("net: hns3: Add handling of GRO Pkts not fully RX'ed in NAPI poll")

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 38 +++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 6695b94..7dc281c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2697,36 +2697,37 @@ static int hns3_set_gro_and_checksum(struct hns3_enet_ring *ring,
 }
 
 static void hns3_set_rx_skb_rss_type(struct hns3_enet_ring *ring,
-				     struct sk_buff *skb)
+				     struct sk_buff *skb, u32 rss_hash)
 {
 	struct hnae3_handle *handle = ring->tqp->handle;
 	enum pkt_hash_types rss_type;
-	struct hns3_desc *desc;
-	int last_bd;
-
-	/* When driver handle the rss type, ring->next_to_clean indicates the
-	 * first descriptor of next packet, need -1 here.
-	 */
-	last_bd = (ring->next_to_clean - 1 + ring->desc_num) % ring->desc_num;
-	desc = &ring->desc[last_bd];
 
-	if (le32_to_cpu(desc->rx.rss_hash))
+	if (rss_hash)
 		rss_type = handle->kinfo.rss_type;
 	else
 		rss_type = PKT_HASH_TYPE_NONE;
 
-	skb_set_hash(skb, le32_to_cpu(desc->rx.rss_hash), rss_type);
+	skb_set_hash(skb, rss_hash, rss_type);
 }
 
-static int hns3_handle_bdinfo(struct hns3_enet_ring *ring, struct sk_buff *skb,
-			      struct hns3_desc *desc)
+static int hns3_handle_bdinfo(struct hns3_enet_ring *ring, struct sk_buff *skb)
 {
 	struct net_device *netdev = ring->tqp->handle->kinfo.netdev;
-	u32 bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
-	u32 l234info = le32_to_cpu(desc->rx.l234_info);
 	enum hns3_pkt_l2t_type l2_frame_type;
+	u32 bd_base_info, l234info;
+	struct hns3_desc *desc;
 	unsigned int len;
-	int ret;
+	int pre_ntc, ret;
+
+	/* bdinfo handled below is only valid on the last BD of the
+	 * current packet, and ring->next_to_clean indicates the first
+	 * descriptor of next packet, so need - 1 below.
+	 */
+	pre_ntc = ring->next_to_clean ? (ring->next_to_clean - 1) :
+					(ring->desc_num - 1);
+	desc = &ring->desc[pre_ntc];
+	bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
+	l234info = le32_to_cpu(desc->rx.l234_info);
 
 	/* Based on hw strategy, the tag offloaded will be stored at
 	 * ot_vlan_tag in two layer tag case, and stored at vlan_tag
@@ -2787,6 +2788,8 @@ static int hns3_handle_bdinfo(struct hns3_enet_ring *ring, struct sk_buff *skb,
 	u64_stats_update_end(&ring->syncp);
 
 	ring->tqp_vector->rx_group.total_bytes += len;
+
+	hns3_set_rx_skb_rss_type(ring, skb, le32_to_cpu(desc->rx.rss_hash));
 	return 0;
 }
 
@@ -2856,14 +2859,13 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 		       ALIGN(ring->pull_len, sizeof(long)));
 	}
 
-	ret = hns3_handle_bdinfo(ring, skb, desc);
+	ret = hns3_handle_bdinfo(ring, skb);
 	if (unlikely(ret)) {
 		dev_kfree_skb_any(skb);
 		return ret;
 	}
 
 	*out_skb = skb;
-	hns3_set_rx_skb_rss_type(ring, skb);
 
 	return 0;
 }
-- 
2.7.4

