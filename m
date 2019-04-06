Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA6CC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C082173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDFHou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:44:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbfDFHos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 03:44:48 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5D8584350896CAEB6D4D;
        Sat,  6 Apr 2019 15:44:46 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sat, 6 Apr 2019 15:44:39 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: add error handler for initializing command queue
Date:   Sat, 6 Apr 2019 15:43:34 +0800
Message-ID: <1554536616-24977-11-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554536616-24977-1-git-send-email-tanhuazhong@huawei.com>
References: <1554536616-24977-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error handler for the failure of command queue
initialization both PF and VF.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c   | 11 ++++++++---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 722bb31..cf7ff4a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -373,21 +373,26 @@ int hclge_cmd_init(struct hclge_dev *hdev)
 	 * reset may happen when lower level reset is being processed.
 	 */
 	if ((hclge_is_reset_pending(hdev))) {
-		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err_cmd_init;
 	}
 
 	ret = hclge_cmd_query_firmware_version(&hdev->hw, &version);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"firmware version query failed %d\n", ret);
-		return ret;
+		goto err_cmd_init;
 	}
 	hdev->fw_version = version;
 
 	dev_info(&hdev->pdev->dev, "The firmware version is %08x\n", version);
 
 	return 0;
+
+err_cmd_init:
+	set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+
+	return ret;
 }
 
 static void hclge_cmd_uninit_regs(struct hclge_hw *hw)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index 930b175..054556e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -357,8 +357,8 @@ int hclgevf_cmd_init(struct hclgevf_dev *hdev)
 	 * reset may happen when lower level reset is being processed.
 	 */
 	if (hclgevf_is_reset_pending(hdev)) {
-		set_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err_cmd_init;
 	}
 
 	/* get firmware version */
@@ -366,13 +366,18 @@ int hclgevf_cmd_init(struct hclgevf_dev *hdev)
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed(%d) to query firmware version\n", ret);
-		return ret;
+		goto err_cmd_init;
 	}
 	hdev->fw_version = version;
 
 	dev_info(&hdev->pdev->dev, "The firmware version is %08x\n", version);
 
 	return 0;
+
+err_cmd_init:
+	set_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
+
+	return ret;
 }
 
 static void hclgevf_cmd_uninit_regs(struct hclgevf_hw *hw)
-- 
2.7.4

