Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF2FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D664A20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfCJGss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 01:48:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbfCJGss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 01:48:48 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9AFA95C5316F36977C78;
        Sun, 10 Mar 2019 14:48:43 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 10 Mar 2019 14:48:37 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net] net: hns3: fix to stop multiple HNS reset due to the AER changes
Date:   Sun, 10 Mar 2019 14:47:51 +0800
Message-ID: <1552200471-47492-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

The commit bfcb79fca19d
("PCI/ERR: Run error recovery callbacks for all affected devices")
affected the non-fatal error recovery logic for the HNS and RDMA devices.
This is because each HNS PF under PCIe bus receive callbacks
from the AER driver when an error is reported for one of the PF.
This causes unwanted PF resets because
the HNS decides which PF to reset based on the reset type set.
The HNS error handling code sets the reset type based on the hw error
type detected.

This patch provides fix for the above issue for the recovery of
the hw errors in the HNS and RDMA devices.

This patch needs backporting to the kernel v5.0+

Fixes: 332fbf576579 ("net: hns3: add handling of hw ras errors using new set of commands")
Reported-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h            | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c        | 4 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 9 +++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 66d7a8b..38b430f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -194,6 +194,7 @@ struct hnae3_ae_dev {
 	const struct hnae3_ae_ops *ops;
 	struct list_head node;
 	u32 flag;
+	u8 override_pci_need_reset; /* fix to stop multiple reset happening */
 	enum hnae3_dev_type dev_type;
 	enum hnae3_reset_type reset_type;
 	void *priv;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0d1ae15..1c1f17e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1850,7 +1850,9 @@ static pci_ers_result_t hns3_slot_reset(struct pci_dev *pdev)
 
 	/* request the reset */
 	if (ae_dev->ops->reset_event) {
-		ae_dev->ops->reset_event(pdev, NULL);
+		if (!ae_dev->override_pci_need_reset)
+			ae_dev->ops->reset_event(pdev, NULL);
+
 		return PCI_ERS_RESULT_RECOVERED;
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 1feceff..1f52d11 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1317,8 +1317,10 @@ pci_ers_result_t hclge_handle_hw_ras_error(struct hnae3_ae_dev *ae_dev)
 		hclge_handle_all_ras_errors(hdev);
 	} else {
 		if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
-		    hdev->pdev->revision < 0x21)
+		    hdev->pdev->revision < 0x21) {
+			ae_dev->override_pci_need_reset = 1;
 			return PCI_ERS_RESULT_RECOVERED;
+		}
 	}
 
 	if (status & HCLGE_RAS_REG_ROCEE_ERR_MASK) {
@@ -1327,8 +1329,11 @@ pci_ers_result_t hclge_handle_hw_ras_error(struct hnae3_ae_dev *ae_dev)
 	}
 
 	if (status & HCLGE_RAS_REG_NFE_MASK ||
-	    status & HCLGE_RAS_REG_ROCEE_ERR_MASK)
+	    status & HCLGE_RAS_REG_ROCEE_ERR_MASK) {
+		ae_dev->override_pci_need_reset = 0;
 		return PCI_ERS_RESULT_NEED_RESET;
+	}
+	ae_dev->override_pci_need_reset = 1;
 
 	return PCI_ERS_RESULT_RECOVERED;
 }
-- 
2.7.4

