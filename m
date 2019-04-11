Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E81CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68552133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDKM2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:28:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726517AbfDKM0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:26:45 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0EA49642E68B9E784DCB;
        Thu, 11 Apr 2019 20:26:43 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:26:33 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 02/12] net: hns3: fix VLAN offload handle for VLAN inserted by port
Date:   Thu, 11 Apr 2019 20:25:21 +0800
Message-ID: <1554985531-1827-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
References: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

When port based VLAN enabled, hardware will insert VLAN automatically
when send packets, driver needs to fill the VLAN from skb or from
port to different areas in TX BD. For RX packets, hardware can
strip two VLAN headers, and fill them into RX BD, driver needs
to identify which one should be send to skb, and drop the port
based VLAN id.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 54 +++++++++++++++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 10 +++-
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index f21932c..681c175 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -585,6 +585,8 @@ struct hnae3_handle {
 
 	u32 numa_node_mask;	/* for multi-chip support */
 
+	enum hnae3_port_base_vlan_state port_base_vlan_state;
+
 	u8 netdev_flags;
 	struct dentry *hnae3_dbgfs;
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b53b091..04eca3a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -963,6 +963,16 @@ static int hns3_fill_desc_vtags(struct sk_buff *skb,
 {
 #define HNS3_TX_VLAN_PRIO_SHIFT 13
 
+	struct hnae3_handle *handle = tx_ring->tqp->handle;
+
+	/* By hw limitation, if port base insert vlan enabled, only one vlan
+	 * header is allowed in skb; otherwise it will cause ras error.
+	 */
+	if (unlikely(skb_vlan_tagged_multi(skb) &&
+		     handle->port_base_vlan_state ==
+		     HNAE3_PORT_BASE_VLAN_ENABLE))
+		return -EINVAL;
+
 	if (skb->protocol == htons(ETH_P_8021Q) &&
 	    !(tx_ring->tqp->handle->kinfo.netdev->features &
 	    NETIF_F_HW_VLAN_CTAG_TX)) {
@@ -984,10 +994,18 @@ static int hns3_fill_desc_vtags(struct sk_buff *skb,
 		 * and use inner_vtag in one tag case.
 		 */
 		if (skb->protocol == htons(ETH_P_8021Q)) {
-			hns3_set_field(*out_vlan_flag, HNS3_TXD_OVLAN_B, 1);
-			*out_vtag = vlan_tag;
+			if (handle->port_base_vlan_state ==
+			    HNAE3_PORT_BASE_VLAN_DISABLE){
+				hnae3_set_bit(*out_vlan_flag, HNS3_TXD_OVLAN_B,
+					      1);
+				*out_vtag = vlan_tag;
+			} else {
+				hnae3_set_bit(*inner_vlan_flag, HNS3_TXD_VLAN_B,
+					      1);
+				*inner_vtag = vlan_tag;
+			}
 		} else {
-			hns3_set_field(*inner_vlan_flag, HNS3_TXD_VLAN_B, 1);
+			hnae3_set_bit(*inner_vlan_flag, HNS3_TXD_VLAN_B, 1);
 			*inner_vtag = vlan_tag;
 		}
 	} else if (skb->protocol == htons(ETH_P_8021Q)) {
@@ -2390,6 +2408,7 @@ static bool hns3_parse_vlan_tag(struct hns3_enet_ring *ring,
 				struct hns3_desc *desc, u32 l234info,
 				u16 *vlan_tag)
 {
+	struct hnae3_handle *handle = ring->tqp->handle;
 	struct pci_dev *pdev = ring->tqp->handle->pdev;
 
 	if (pdev->revision == 0x20) {
@@ -2402,14 +2421,37 @@ static bool hns3_parse_vlan_tag(struct hns3_enet_ring *ring,
 
 #define HNS3_STRP_OUTER_VLAN	0x1
 #define HNS3_STRP_INNER_VLAN	0x2
+#define HNS3_STRP_BOTH		0x3
 
+	/* Hardware always insert vlan tag into rx descriptor when
+	 * remove the tag from packet, driver needs to determin
+	 * reporting which tag to stack.
+	 */
 	switch (hnae3_get_field(l234info, HNS3_RXD_STRP_TAGP_M,
 				HNS3_RXD_STRP_TAGP_S)) {
 	case HNS3_STRP_OUTER_VLAN:
-		*vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
-		return true;
+		if (handle->port_base_vlan_state ==
+				HNAE3_PORT_BASE_VLAN_DISABLE) {
+			*vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
+			return true;
+		}
+
+		return false;
 	case HNS3_STRP_INNER_VLAN:
-		*vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
+		if (handle->port_base_vlan_state ==
+				HNAE3_PORT_BASE_VLAN_DISABLE) {
+			*vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
+			return true;
+		}
+
+		return false;
+	case HNS3_STRP_BOTH:
+		if (handle->port_base_vlan_state ==
+				HNAE3_PORT_BASE_VLAN_DISABLE)
+			*vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
+		else
+			*vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
+
 		return true;
 	default:
 		return false;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index cd7318b..1f3c41d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6914,10 +6914,16 @@ int hclge_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 
-	vport->rxvlan_cfg.strip_tag1_en = false;
-	vport->rxvlan_cfg.strip_tag2_en = enable;
+	if (vport->port_base_vlan_cfg.state == HNAE3_PORT_BASE_VLAN_DISABLE) {
+		vport->rxvlan_cfg.strip_tag1_en = false;
+		vport->rxvlan_cfg.strip_tag2_en = enable;
+	} else {
+		vport->rxvlan_cfg.strip_tag1_en = enable;
+		vport->rxvlan_cfg.strip_tag2_en = true;
+	}
 	vport->rxvlan_cfg.vlan1_vlan_prionly = false;
 	vport->rxvlan_cfg.vlan2_vlan_prionly = false;
+	vport->rxvlan_cfg.rx_vlan_offload_en = enable;
 
 	return hclge_set_vlan_rx_offload_cfg(vport);
 }
-- 
2.7.4

