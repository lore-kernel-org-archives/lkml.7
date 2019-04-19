Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26302C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF204217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfDSDHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:07:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727318AbfDSDHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:07:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 08E3B4D82F4C24D94F5A;
        Fri, 19 Apr 2019 11:07:10 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 19 Apr 2019 11:06:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 07/12] net: hns3: dump more information when tx timeout happens
Date:   Fri, 19 Apr 2019 11:05:42 +0800
Message-ID: <1555643147-52407-8-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
References: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

Currently we just print few information when tx timeout happens.
In order to find out the cause of timeout, this patch prints more
information about the packet statistics, tqp registers and
napi state.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  3 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 63 +++++++++++++++++++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 11 ++++
 4 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 681c175..8fe2c8f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -392,7 +392,8 @@ struct hnae3_ae_ops {
 	void (*update_stats)(struct hnae3_handle *handle,
 			     struct net_device_stats *net_stats);
 	void (*get_stats)(struct hnae3_handle *handle, u64 *data);
-
+	void (*get_mac_pause_stats)(struct hnae3_handle *handle, u64 *tx_cnt,
+				    u64 *rx_cnt);
 	void (*get_strings)(struct hnae3_handle *handle,
 			    u32 stringset, u8 *data);
 	int (*get_sset_count)(struct hnae3_handle *handle, int stringset);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 652b19d..4c96f94 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1628,9 +1628,15 @@ static int hns3_nic_change_mtu(struct net_device *netdev, int new_mtu)
 static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
+	struct hnae3_handle *h = hns3_get_handle(ndev);
 	struct hns3_enet_ring *tx_ring = NULL;
+	struct napi_struct *napi;
 	int timeout_queue = 0;
 	int hw_head, hw_tail;
+	int fbd_num, fbd_oft;
+	int ebd_num, ebd_oft;
+	int bd_num, bd_err;
+	int ring_en, tc;
 	int i;
 
 	/* Find the stopped queue the same way the stack does */
@@ -1658,20 +1664,63 @@ static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
 	priv->tx_timeout_count++;
 
 	tx_ring = priv->ring_data[timeout_queue].ring;
+	napi = &tx_ring->tqp_vector->napi;
+
+	netdev_info(ndev,
+		    "tx_timeout count: %llu, queue id: %d, SW_NTU: 0x%x, SW_NTC: 0x%x, napi state: %lu\n",
+		    priv->tx_timeout_count, timeout_queue, tx_ring->next_to_use,
+		    tx_ring->next_to_clean, napi->state);
+
+	netdev_info(ndev,
+		    "tx_pkts: %llu, tx_bytes: %llu, io_err_cnt: %llu, sw_err_cnt: %llu\n",
+		    tx_ring->stats.tx_pkts, tx_ring->stats.tx_bytes,
+		    tx_ring->stats.io_err_cnt, tx_ring->stats.sw_err_cnt);
+
+	netdev_info(ndev,
+		    "seg_pkt_cnt: %llu, tx_err_cnt: %llu, restart_queue: %llu, tx_busy: %llu\n",
+		    tx_ring->stats.seg_pkt_cnt, tx_ring->stats.tx_err_cnt,
+		    tx_ring->stats.restart_queue, tx_ring->stats.tx_busy);
+
+	/* When mac received many pause frames continuous, it's unable to send
+	 * packets, which may cause tx timeout
+	 */
+	if (h->ae_algo->ops->update_stats &&
+	    h->ae_algo->ops->get_mac_pause_stats) {
+		u64 tx_pause_cnt, rx_pause_cnt;
+
+		h->ae_algo->ops->update_stats(h, &ndev->stats);
+		h->ae_algo->ops->get_mac_pause_stats(h, &tx_pause_cnt,
+						     &rx_pause_cnt);
+		netdev_info(ndev, "tx_pause_cnt: %llu, rx_pause_cnt: %llu\n",
+			    tx_pause_cnt, rx_pause_cnt);
+	}
 
 	hw_head = readl_relaxed(tx_ring->tqp->io_base +
 				HNS3_RING_TX_RING_HEAD_REG);
 	hw_tail = readl_relaxed(tx_ring->tqp->io_base +
 				HNS3_RING_TX_RING_TAIL_REG);
+	fbd_num = readl_relaxed(tx_ring->tqp->io_base +
+				HNS3_RING_TX_RING_FBDNUM_REG);
+	fbd_oft = readl_relaxed(tx_ring->tqp->io_base +
+				HNS3_RING_TX_RING_OFFSET_REG);
+	ebd_num = readl_relaxed(tx_ring->tqp->io_base +
+				HNS3_RING_TX_RING_EBDNUM_REG);
+	ebd_oft = readl_relaxed(tx_ring->tqp->io_base +
+				HNS3_RING_TX_RING_EBD_OFFSET_REG);
+	bd_num = readl_relaxed(tx_ring->tqp->io_base +
+			       HNS3_RING_TX_RING_BD_NUM_REG);
+	bd_err = readl_relaxed(tx_ring->tqp->io_base +
+			       HNS3_RING_TX_RING_BD_ERR_REG);
+	ring_en = readl_relaxed(tx_ring->tqp->io_base + HNS3_RING_EN_REG);
+	tc = readl_relaxed(tx_ring->tqp->io_base + HNS3_RING_TX_RING_TC_REG);
+
 	netdev_info(ndev,
-		    "tx_timeout count: %llu, queue id: %d, SW_NTU: 0x%x, SW_NTC: 0x%x, HW_HEAD: 0x%x, HW_TAIL: 0x%x, INT: 0x%x\n",
-		    priv->tx_timeout_count,
-		    timeout_queue,
-		    tx_ring->next_to_use,
-		    tx_ring->next_to_clean,
-		    hw_head,
-		    hw_tail,
+		    "BD_NUM: 0x%x HW_HEAD: 0x%x, HW_TAIL: 0x%x, BD_ERR: 0x%x, INT: 0x%x\n",
+		    bd_num, hw_head, hw_tail, bd_err,
 		    readl(tx_ring->tqp_vector->mask_addr));
+	netdev_info(ndev,
+		    "RING_EN: 0x%x, TC: 0x%x, FBD_NUM: 0x%x FBD_OFT: 0x%x, EBD_NUM: 0x%x, EBD_OFT: 0x%x\n",
+		    ring_en, tc, fbd_num, fbd_oft, ebd_num, ebd_oft);
 
 	return true;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 025d0f7..f433c6d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -42,8 +42,10 @@ enum hns3_nic_state {
 #define HNS3_RING_TX_RING_HEAD_REG		0x0005C
 #define HNS3_RING_TX_RING_FBDNUM_REG		0x00060
 #define HNS3_RING_TX_RING_OFFSET_REG		0x00064
+#define HNS3_RING_TX_RING_EBDNUM_REG		0x00068
 #define HNS3_RING_TX_RING_PKTNUM_RECORD_REG	0x0006C
-
+#define HNS3_RING_TX_RING_EBD_OFFSET_REG	0x00070
+#define HNS3_RING_TX_RING_BD_ERR_REG		0x00074
 #define HNS3_RING_PREFETCH_EN_REG		0x0007C
 #define HNS3_RING_CFG_VF_NUM_REG		0x00080
 #define HNS3_RING_ASID_REG			0x0008C
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9b7bc22..7ac7602 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -699,6 +699,16 @@ static void hclge_get_stats(struct hnae3_handle *handle, u64 *data)
 	p = hclge_tqps_get_stats(handle, p);
 }
 
+static void hclge_get_mac_pause_stat(struct hnae3_handle *handle, u64 *tx_cnt,
+				     u64 *rx_cnt)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+
+	*tx_cnt = hdev->hw_stats.mac_stats.mac_tx_mac_pause_num;
+	*rx_cnt = hdev->hw_stats.mac_stats.mac_rx_mac_pause_num;
+}
+
 static int hclge_parse_func_status(struct hclge_dev *hdev,
 				   struct hclge_func_status_cmd *status)
 {
@@ -8522,6 +8532,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.set_mtu = hclge_set_mtu,
 	.reset_queue = hclge_reset_tqp,
 	.get_stats = hclge_get_stats,
+	.get_mac_pause_stats = hclge_get_mac_pause_stat,
 	.update_stats = hclge_update_stats,
 	.get_strings = hclge_get_strings,
 	.get_sset_count = hclge_get_sset_count,
-- 
2.7.4

