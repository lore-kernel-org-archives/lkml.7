Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31D5C282DA
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB1F2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfDNBt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 21:49:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41990 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbfDNBtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 21:49:04 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 46729A37B8DB338FFC5D;
        Sun, 14 Apr 2019 09:48:57 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Sun, 14 Apr 2019 09:48:49 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 02/12] net: hns3: fix VLAN offload handle for VLAN inserted by port
Date:   Sun, 14 Apr 2019 09:47:36 +0800
Message-ID: <1555206466-44240-3-git-send-email-tanhuazhong@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

Currently, in TX direction, driver implements the TX VLAN offload
by checking the VLAN header in skb, and filling it into TX descriptor.
Usually it works well, but if enable inserting VLAN header based on
port, it may conflict when out_tag field of TX descriptor is already
used, and cause RAS error.

In RX direction, hardware supports stripping max two VLAN headers.
For vlan_tci in skb can only store one VLAN tag, when RX VLAN offload
enabled, driver tells hardware to strip one VLAN header from RX
packet; when RX VLAN offload disabled, driver tells hardware not to
strip VLAN header from RX packet. Now if port based insert VLAN
enabled, all RX packets will have the port based VLAN header. This
header is useless for stack, driver needs to ask hardware to strip
it. Unfortunately, hardware can't drop this VLAN header, and always
fill it into RX descriptor, so driver has to identify and drop it.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 44 +++++++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 10 ++++-
 3 files changed, 52 insertions(+), 4 deletions(-)

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
index b53b091..ec16b94 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -963,6 +963,16 @@ static int hns3_fill_desc_vtags(struct sk_buff *skb,
 {
 #define HNS3_TX_VLAN_PRIO_SHIFT 13
 
+	struct hnae3_handle *handle = tx_ring->tqp->handle;
+
+	/* Since HW limitation, if port based insert VLAN enabled, only one VLAN
+	 * header is allowed in skb, otherwise it will cause RAS error.
+	 */
+	if (unlikely(skb_vlan_tagged_multi(skb) &&
+		     handle->port_base_vlan_state ==
+		     HNAE3_PORT_BASE_VLAN_ENABLE))
+		return -EINVAL;
+
 	if (skb->protocol == htons(ETH_P_8021Q) &&
 	    !(tx_ring->tqp->handle->kinfo.netdev->features &
 	    NETIF_F_HW_VLAN_CTAG_TX)) {
@@ -984,8 +994,16 @@ static int hns3_fill_desc_vtags(struct sk_buff *skb,
 		 * and use inner_vtag in one tag case.
 		 */
 		if (skb->protocol == htons(ETH_P_8021Q)) {
-			hns3_set_field(*out_vlan_flag, HNS3_TXD_OVLAN_B, 1);
-			*out_vtag = vlan_tag;
+			if (handle->port_base_vlan_state ==
+			    HNAE3_PORT_BASE_VLAN_DISABLE){
+				hns3_set_field(*out_vlan_flag,
+					       HNS3_TXD_OVLAN_B, 1);
+				*out_vtag = vlan_tag;
+			} else {
+				hns3_set_field(*inner_vlan_flag,
+					       HNS3_TXD_VLAN_B, 1);
+				*inner_vtag = vlan_tag;
+			}
 		} else {
 			hns3_set_field(*inner_vlan_flag, HNS3_TXD_VLAN_B, 1);
 			*inner_vtag = vlan_tag;
@@ -2390,6 +2408,7 @@ static bool hns3_parse_vlan_tag(struct hns3_enet_ring *ring,
 				struct hns3_desc *desc, u32 l234info,
 				u16 *vlan_tag)
 {
+	struct hnae3_handle *handle = ring->tqp->handle;
 	struct pci_dev *pdev = ring->tqp->handle->pdev;
 
 	if (pdev->revision == 0x20) {
@@ -2402,15 +2421,36 @@ static bool hns3_parse_vlan_tag(struct hns3_enet_ring *ring,
 
 #define HNS3_STRP_OUTER_VLAN	0x1
 #define HNS3_STRP_INNER_VLAN	0x2
+#define HNS3_STRP_BOTH		0x3
 
+	/* Hardware always insert VLAN tag into RX descriptor when
+	 * remove the tag from packet, driver needs to determine
+	 * reporting which tag to stack.
+	 */
 	switch (hnae3_get_field(l234info, HNS3_RXD_STRP_TAGP_M,
 				HNS3_RXD_STRP_TAGP_S)) {
 	case HNS3_STRP_OUTER_VLAN:
+		if (handle->port_base_vlan_state !=
+				HNAE3_PORT_BASE_VLAN_DISABLE)
+			return false;
+
 		*vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
 		return true;
 	case HNS3_STRP_INNER_VLAN:
+		if (handle->port_base_vlan_state !=
+				HNAE3_PORT_BASE_VLAN_DISABLE)
+			return false;
+
 		*vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
 		return true;
+	case HNS3_STRP_BOTH:
+		if (handle->port_base_vlan_state ==
+				HNAE3_PORT_BASE_VLAN_DISABLE)
+			*vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
+		else
+			*vlan_tag = le16_to_cpu(desc->rx.vlan_tag);
+
+		return true;
 	default:
 		return false;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 630f7f88..4bc2c07 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6915,10 +6915,16 @@ int hclge_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
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

