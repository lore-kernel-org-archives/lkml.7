Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FEEC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3110A217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfDSDHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:07:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727321AbfDSDHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:07:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 02900773988AFF2F3915;
        Fri, 19 Apr 2019 11:07:10 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 19 Apr 2019 11:06:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 08/12] net: hns3: Add support for netif message level settings
Date:   Fri, 19 Apr 2019 11:05:43 +0800
Message-ID: <1555643147-52407-9-git-send-email-tanhuazhong@huawei.com>
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

From: Yonglong Liu <liuyonglong@huawei.com>

This patch adds support for network interface message level
settings. The message level can be changed by module parameter
or ethtool.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  3 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 33 ++++++++++++++++++++--
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 18 ++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 29 +++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 20 +++++++++++++
 5 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 8fe2c8f..dce68d3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -590,6 +590,9 @@ struct hnae3_handle {
 
 	u8 netdev_flags;
 	struct dentry *hnae3_dbgfs;
+
+	/* Network interface message level enabled bits */
+	u32 msg_enable;
 };
 
 #define hnae3_set_field(origin, mask, shift, val) \
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4c96f94..142fe6e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -35,6 +35,13 @@ static const char hns3_driver_string[] =
 static const char hns3_copyright[] = "Copyright (c) 2017 Huawei Corporation.";
 static struct hnae3_client client;
 
+static int debug = -1;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, " Network interface message level setting");
+
+#define DEFAULT_MSG_LEVEL (NETIF_MSG_PROBE | NETIF_MSG_LINK | \
+			   NETIF_MSG_IFDOWN | NETIF_MSG_IFUP)
+
 /* hns3_pci_tbl - PCI Device ID Table
  *
  * Last entry must be all 0s
@@ -3737,6 +3744,21 @@ static void hns3_client_stop(struct hnae3_handle *handle)
 	handle->ae_algo->ops->client_stop(handle);
 }
 
+static void hns3_info_show(struct hns3_nic_priv *priv)
+{
+	struct hnae3_knic_private_info *kinfo = &priv->ae_handle->kinfo;
+
+	dev_info(priv->dev, "MAC address: %pM\n", priv->netdev->dev_addr);
+	dev_info(priv->dev, "Task queue pairs numbers: %d\n", kinfo->num_tqps);
+	dev_info(priv->dev, "RSS size: %d\n", kinfo->rss_size);
+	dev_info(priv->dev, "Allocated RSS size: %d\n", kinfo->req_rss_size);
+	dev_info(priv->dev, "RX buffer length: %d\n", kinfo->rx_buf_len);
+	dev_info(priv->dev, "Desc num per TX queue: %d\n", kinfo->num_tx_desc);
+	dev_info(priv->dev, "Desc num per RX queue: %d\n", kinfo->num_rx_desc);
+	dev_info(priv->dev, "Total number of enabled TCs: %d\n", kinfo->num_tc);
+	dev_info(priv->dev, "Max mtu size: %d\n", priv->netdev->max_mtu);
+}
+
 static int hns3_client_init(struct hnae3_handle *handle)
 {
 	struct pci_dev *pdev = handle->pdev;
@@ -3758,6 +3780,8 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->tx_timeout_count = 0;
 	set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
+	handle->msg_enable = netif_msg_init(debug, DEFAULT_MSG_LEVEL);
+
 	handle->kinfo.netdev = netdev;
 	handle->priv = (void *)priv;
 
@@ -3824,6 +3848,9 @@ static int hns3_client_init(struct hnae3_handle *handle)
 
 	set_bit(HNS3_NIC_STATE_INITED, &priv->state);
 
+	if (netif_msg_drv(handle))
+		hns3_info_show(priv);
+
 	return ret;
 
 out_client_start:
@@ -3898,11 +3925,13 @@ static void hns3_link_status_change(struct hnae3_handle *handle, bool linkup)
 	if (linkup) {
 		netif_carrier_on(netdev);
 		netif_tx_wake_all_queues(netdev);
-		netdev_info(netdev, "link up\n");
+		if (netif_msg_link(handle))
+			netdev_info(netdev, "link up\n");
 	} else {
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
-		netdev_info(netdev, "link down\n");
+		if (netif_msg_link(handle))
+			netdev_info(netdev, "link down\n");
 	}
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 59ef272..3ae1124 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1110,6 +1110,20 @@ static int hns3_set_phys_id(struct net_device *netdev,
 	return h->ae_algo->ops->set_led_id(h, state);
 }
 
+static u32 hns3_get_msglevel(struct net_device *netdev)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+
+	return h->msg_enable;
+}
+
+static void hns3_set_msglevel(struct net_device *netdev, u32 msg_level)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+
+	h->msg_enable = msg_level;
+}
+
 static const struct ethtool_ops hns3vf_ethtool_ops = {
 	.get_drvinfo = hns3_get_drvinfo,
 	.get_ringparam = hns3_get_ringparam,
@@ -1130,6 +1144,8 @@ static const struct ethtool_ops hns3vf_ethtool_ops = {
 	.get_regs_len = hns3_get_regs_len,
 	.get_regs = hns3_get_regs,
 	.get_link = hns3_get_link,
+	.get_msglevel = hns3_get_msglevel,
+	.set_msglevel = hns3_set_msglevel,
 };
 
 static const struct ethtool_ops hns3_ethtool_ops = {
@@ -1159,6 +1175,8 @@ static const struct ethtool_ops hns3_ethtool_ops = {
 	.get_regs_len = hns3_get_regs_len,
 	.get_regs = hns3_get_regs,
 	.set_phys_id = hns3_set_phys_id,
+	.get_msglevel = hns3_get_msglevel,
+	.set_msglevel = hns3_set_msglevel,
 };
 
 void hns3_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 7ac7602..3741c47 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7554,6 +7554,32 @@ static void hclge_get_mdix_mode(struct hnae3_handle *handle,
 		*tp_mdix = ETH_TP_MDI;
 }
 
+static void hclge_info_show(struct hclge_dev *hdev)
+{
+	struct device *dev = &hdev->pdev->dev;
+
+	dev_info(dev, "PF info begin:\n");
+
+	dev_info(dev, "Task queue pairs numbers: %d\n", hdev->num_tqps);
+	dev_info(dev, "Desc num per TX queue: %d\n", hdev->num_tx_desc);
+	dev_info(dev, "Desc num per RX queue: %d\n", hdev->num_rx_desc);
+	dev_info(dev, "Numbers of vports: %d\n", hdev->num_alloc_vport);
+	dev_info(dev, "Numbers of vmdp vports: %d\n", hdev->num_vmdq_vport);
+	dev_info(dev, "Numbers of VF for this PF: %d\n", hdev->num_req_vfs);
+	dev_info(dev, "HW tc map: %d\n", hdev->hw_tc_map);
+	dev_info(dev, "Total buffer size for TX/RX: %d\n", hdev->pkt_buf_size);
+	dev_info(dev, "TX buffer size for each TC: %d\n", hdev->tx_buf_size);
+	dev_info(dev, "DV buffer size for each TC: %d\n", hdev->dv_buf_size);
+	dev_info(dev, "This is %s PF\n",
+		 hdev->flag & HCLGE_FLAG_MAIN ? "main" : "not main");
+	dev_info(dev, "DCB %s\n",
+		 hdev->flag & HCLGE_FLAG_DCB_ENABLE ? "enable" : "disable");
+	dev_info(dev, "MQPRIO %s\n",
+		 hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE ? "enable" : "disable");
+
+	dev_info(dev, "PF info end.\n");
+}
+
 static int hclge_init_client_instance(struct hnae3_client *client,
 				      struct hnae3_ae_dev *ae_dev)
 {
@@ -7575,6 +7601,9 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 
 			hnae3_set_client_init_flag(client, ae_dev, 1);
 
+			if (netif_msg_drv(&hdev->vport->nic))
+				hclge_info_show(hdev);
+
 			if (hdev->roce_client &&
 			    hnae3_dev_roce_supported(hdev)) {
 				struct hnae3_client *rc = hdev->roce_client;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index ff2cdf9..ac06568 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2221,6 +2221,23 @@ static void hclgevf_misc_irq_uninit(struct hclgevf_dev *hdev)
 	hclgevf_free_vector(hdev, 0);
 }
 
+static void hclgevf_info_show(struct hclgevf_dev *hdev)
+{
+	struct device *dev = &hdev->pdev->dev;
+
+	dev_info(dev, "VF info begin:\n");
+
+	dev_info(dev, "Task queue pairs numbers: %d\n", hdev->num_tqps);
+	dev_info(dev, "Desc num per TX queue: %d\n", hdev->num_tx_desc);
+	dev_info(dev, "Desc num per RX queue: %d\n", hdev->num_rx_desc);
+	dev_info(dev, "Numbers of vports: %d\n", hdev->num_alloc_vport);
+	dev_info(dev, "HW tc map: %d\n", hdev->hw_tc_map);
+	dev_info(dev, "PF media type of this VF: %d\n",
+		 hdev->hw.mac.media_type);
+
+	dev_info(dev, "VF info end.\n");
+}
+
 static int hclgevf_init_client_instance(struct hnae3_client *client,
 					struct hnae3_ae_dev *ae_dev)
 {
@@ -2238,6 +2255,9 @@ static int hclgevf_init_client_instance(struct hnae3_client *client,
 
 		hnae3_set_client_init_flag(client, ae_dev, 1);
 
+		if (netif_msg_drv(&hdev->nic))
+			hclgevf_info_show(hdev);
+
 		if (hdev->roce_client && hnae3_dev_roce_supported(hdev)) {
 			struct hnae3_client *rc = hdev->roce_client;
 
-- 
2.7.4

