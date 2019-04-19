Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F27C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E15521736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfDSDHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:07:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbfDSDHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:07:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CFEA8B89289873B3C9CB;
        Fri, 19 Apr 2019 11:07:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 19 Apr 2019 11:07:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Yufeng Mo <moyufeng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: add function type check for debugfs help information
Date:   Fri, 19 Apr 2019 11:05:47 +0800
Message-ID: <1555643147-52407-13-git-send-email-tanhuazhong@huawei.com>
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

From: Yufeng Mo <moyufeng@huawei.com>

PF supports all debugfs command, but VF only supports part of
debugfs command. So VF should not show unsupported help information.

This patch adds a check for PF and PF to show the supportable help
information.

Signed-off-by: Yufeng Mo <moyufeng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 6 ++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 1532906..fc4917a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -239,6 +239,10 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "queue info [number]\n");
 	dev_info(&h->pdev->dev, "queue map\n");
 	dev_info(&h->pdev->dev, "bd info [q_num] <bd index>\n");
+
+	if (!hns3_is_phys_func(h->pdev))
+		return;
+
 	dev_info(&h->pdev->dev, "dump fd tcam\n");
 	dev_info(&h->pdev->dev, "dump tc\n");
 	dev_info(&h->pdev->dev, "dump tm map [q_num]\n");
@@ -344,6 +348,8 @@ static ssize_t hns3_dbg_cmd_write(struct file *filp, const char __user *buffer,
 		ret = hns3_dbg_bd_info(handle, cmd_buf);
 	else if (handle->ae_algo->ops->dbg_run_cmd)
 		ret = handle->ae_algo->ops->dbg_run_cmd(handle, cmd_buf);
+	else
+		ret = -EOPNOTSUPP;
 
 	if (ret)
 		hns3_dbg_help(handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 142fe6e..176d4b9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1764,7 +1764,7 @@ static const struct net_device_ops hns3_nic_netdev_ops = {
 	.ndo_set_vf_vlan	= hns3_ndo_set_vf_vlan,
 };
 
-static bool hns3_is_phys_func(struct pci_dev *pdev)
+bool hns3_is_phys_func(struct pci_dev *pdev)
 {
 	u32 dev_id = pdev->device;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index f433c6d..cec56a5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -663,6 +663,7 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv);
 int hns3_uninit_all_ring(struct hns3_nic_priv *priv);
 int hns3_nic_reset_all_ring(struct hnae3_handle *h);
 netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev);
+bool hns3_is_phys_func(struct pci_dev *pdev);
 int hns3_clean_rx_ring(
 		struct hns3_enet_ring *ring, int budget,
 		void (*rx_fn)(struct hns3_enet_ring *, struct sk_buff *));
-- 
2.7.4

