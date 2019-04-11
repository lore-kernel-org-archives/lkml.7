Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60119C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0A02133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfDKM1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:27:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbfDKM0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:26:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 484FDB0AB556A3C1FD45;
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
Subject: [PATCH net-next 01/12] net: hns3: fix VLAN initialization to be compatible with port base insert VLAN
Date:   Thu, 11 Apr 2019 20:25:20 +0800
Message-ID: <1554985531-1827-2-git-send-email-tanhuazhong@huawei.com>
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

This patch fixes VLAN initialization, in order to be compatible
with VLAN inserted base on port.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  7 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 79 +++++++++++++++-------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    | 21 ++++--
 3 files changed, 77 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 38b430f..f21932c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -147,6 +147,13 @@ enum hnae3_flr_state {
 	HNAE3_FLR_DONE,
 };
 
+enum hnae3_port_base_vlan_state {
+	HNAE3_PORT_BASE_VLAN_DISABLE,
+	HNAE3_PORT_BASE_VLAN_ENABLE,
+	HNAE3_PORT_BASE_VLAN_MODIFY,
+	HNAE3_PORT_BASE_VLAN_NOCHANGE,
+};
+
 struct hnae3_vector_info {
 	u8 __iomem *io_addr;
 	int vector;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 11d9739..cd7318b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1358,6 +1358,8 @@ static int hclge_alloc_vport(struct hclge_dev *hdev)
 		vport->back = hdev;
 		vport->vport_id = i;
 		vport->mps = HCLGE_MAC_DEFAULT_FRAME;
+		vport->port_base_vlan_cfg.state = HNAE3_PORT_BASE_VLAN_DISABLE;
+		vport->rxvlan_cfg.rx_vlan_offload_en = true;
 		INIT_LIST_HEAD(&vport->vlan_list);
 		INIT_LIST_HEAD(&vport->uc_mac_list);
 		INIT_LIST_HEAD(&vport->mc_mac_list);
@@ -6680,6 +6682,51 @@ static int hclge_set_vlan_rx_offload_cfg(struct hclge_vport *vport)
 	return status;
 }
 
+static int hclge_vlan_offload_cfg(struct hclge_vport *vport,
+				  u16 port_base_vlan_state,
+				  u16 vlan_tag)
+{
+	int ret;
+
+	if (port_base_vlan_state == HNAE3_PORT_BASE_VLAN_DISABLE) {
+		vport->txvlan_cfg.accept_tag1 = true;
+		vport->txvlan_cfg.insert_tag1_en = false;
+		vport->txvlan_cfg.default_tag1 = 0;
+	} else {
+		vport->txvlan_cfg.accept_tag1 = false;
+		vport->txvlan_cfg.insert_tag1_en = true;
+		vport->txvlan_cfg.default_tag1 = vlan_tag;
+	}
+
+	vport->txvlan_cfg.accept_untag1 = true;
+	/* accept_tag2 and accept_untag2 are not supported on
+	 * pdev revision(0x20), new revision support them. The
+	 * This two fields can not be configured by user.
+	 */
+	vport->txvlan_cfg.accept_tag2 = true;
+	vport->txvlan_cfg.accept_untag2 = true;
+	vport->txvlan_cfg.insert_tag2_en = false;
+	vport->txvlan_cfg.default_tag2 = 0;
+
+	if (port_base_vlan_state == HNAE3_PORT_BASE_VLAN_DISABLE) {
+		vport->rxvlan_cfg.strip_tag1_en = false;
+		vport->rxvlan_cfg.strip_tag2_en =
+				vport->rxvlan_cfg.rx_vlan_offload_en;
+	} else {
+		vport->rxvlan_cfg.strip_tag1_en =
+				vport->rxvlan_cfg.rx_vlan_offload_en;
+		vport->rxvlan_cfg.strip_tag2_en = true;
+	}
+	vport->rxvlan_cfg.vlan1_vlan_prionly = false;
+	vport->rxvlan_cfg.vlan2_vlan_prionly = false;
+
+	ret = hclge_set_vlan_tx_offload_cfg(vport);
+	if (ret)
+		return ret;
+
+	return hclge_set_vlan_rx_offload_cfg(vport);
+}
+
 static int hclge_set_vlan_protocol_type(struct hclge_dev *hdev)
 {
 	struct hclge_rx_vlan_type_cfg_cmd *rx_req;
@@ -6770,34 +6817,14 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 		return ret;
 
 	for (i = 0; i < hdev->num_alloc_vport; i++) {
-		vport = &hdev->vport[i];
-		vport->txvlan_cfg.accept_tag1 = true;
-		vport->txvlan_cfg.accept_untag1 = true;
-
-		/* accept_tag2 and accept_untag2 are not supported on
-		 * pdev revision(0x20), new revision support them. The
-		 * value of this two fields will not return error when driver
-		 * send command to fireware in revision(0x20).
-		 * This two fields can not configured by user.
-		 */
-		vport->txvlan_cfg.accept_tag2 = true;
-		vport->txvlan_cfg.accept_untag2 = true;
+		u16 vlan_tag;
 
-		vport->txvlan_cfg.insert_tag1_en = false;
-		vport->txvlan_cfg.insert_tag2_en = false;
-		vport->txvlan_cfg.default_tag1 = 0;
-		vport->txvlan_cfg.default_tag2 = 0;
-
-		ret = hclge_set_vlan_tx_offload_cfg(vport);
-		if (ret)
-			return ret;
-
-		vport->rxvlan_cfg.strip_tag1_en = false;
-		vport->rxvlan_cfg.strip_tag2_en = true;
-		vport->rxvlan_cfg.vlan1_vlan_prionly = false;
-		vport->rxvlan_cfg.vlan2_vlan_prionly = false;
+		vport = &hdev->vport[i];
+		vlan_tag = vport->port_base_vlan_cfg.vlan_info.vlan_tag;
 
-		ret = hclge_set_vlan_rx_offload_cfg(vport);
+		ret = hclge_vlan_offload_cfg(vport,
+					     vport->port_base_vlan_cfg.state,
+					     vlan_tag);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index b57ac4b..4c7ea9f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -807,10 +807,11 @@ struct hclge_tx_vtag_cfg {
 
 /* VPort level vlan tag configuration for RX direction */
 struct hclge_rx_vtag_cfg {
-	bool strip_tag1_en;	/* Whether strip inner vlan tag */
-	bool strip_tag2_en;	/* Whether strip outer vlan tag */
-	bool vlan1_vlan_prionly;/* Inner VLAN Tag up to descriptor Enable */
-	bool vlan2_vlan_prionly;/* Outer VLAN Tag up to descriptor Enable */
+	u8 rx_vlan_offload_en;	/* Whether enable rx vlan offload */
+	u8 strip_tag1_en;	/* Whether strip inner vlan tag */
+	u8 strip_tag2_en;	/* Whether strip outer vlan tag */
+	u8 vlan1_vlan_prionly;	/* Inner VLAN Tag up to descriptor Enable */
+	u8 vlan2_vlan_prionly;	/* Outer VLAN Tag up to descriptor Enable */
 };
 
 struct hclge_rss_tuple_cfg {
@@ -829,6 +830,17 @@ enum HCLGE_VPORT_STATE {
 	HCLGE_VPORT_STATE_MAX
 };
 
+struct hclge_vlan_info {
+	u16 vlan_proto; /* so far support 802.1Q only */
+	u16 qos;
+	u16 vlan_tag;
+};
+
+struct hclge_port_base_vlan_config {
+	u16 state;
+	struct hclge_vlan_info vlan_info;
+};
+
 struct hclge_vport {
 	u16 alloc_tqps;	/* Allocated Tx/Rx queues */
 
@@ -845,6 +857,7 @@ struct hclge_vport {
 	u16 bw_limit;		/* VSI BW Limit (0 = disabled) */
 	u8  dwrr;
 
+	struct hclge_port_base_vlan_config port_base_vlan_cfg;
 	struct hclge_tx_vtag_cfg  txvlan_cfg;
 	struct hclge_rx_vtag_cfg  rxvlan_cfg;
 
-- 
2.7.4

