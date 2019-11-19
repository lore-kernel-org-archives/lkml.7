Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA75C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690FA22310
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKSCbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:31:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726952AbfKSCba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:31:30 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A8EBCE325C28F5C1A14;
        Tue, 19 Nov 2019 10:31:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 19 Nov 2019 10:31:19 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net] net: hns3: fix a wrong reset interrupt status mask
Date:   Tue, 19 Nov 2019 10:31:48 +0800
Message-ID: <1574130708-30767-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to hardware user manual, bits5~7 in register
HCLGE_MISC_VECTOR_INT_STS means reset interrupts status,
but HCLGE_RESET_INT_M is defined as bits0~2 now. So it
will make hclge_reset_err_handle() read the wrong reset
interrupt status.

This patch fixes it and prints out the register value.

Fixes: 2336f19d7892 ("net: hns3: check reset interrupt status when reset fails")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 10 +++++++---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c052bb3..731cda0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3555,14 +3555,18 @@ static bool hclge_reset_err_handle(struct hclge_dev *hdev)
 {
 #define MAX_RESET_FAIL_CNT 5
 
+	u32 msix_sts_reg;
+
+	msix_sts_reg = hclge_read_dev(&hdev->hw, HCLGE_MISC_VECTOR_INT_STS);
+
 	if (hdev->reset_pending) {
 		dev_info(&hdev->pdev->dev, "Reset pending %lu\n",
 			 hdev->reset_pending);
 		return true;
-	} else if (hclge_read_dev(&hdev->hw, HCLGE_MISC_VECTOR_INT_STS) &
-		   HCLGE_RESET_INT_M) {
+	} else if (msix_sts_reg & HCLGE_RESET_INT_M) {
 		dev_info(&hdev->pdev->dev,
-			 "reset failed because new reset interrupt\n");
+			 "fail to reset, new reset interrupt is 0x%x\n",
+			 msix_sts_reg);
 		hclge_clear_reset_cause(hdev);
 		return false;
 	} else if (hdev->rst_stats.reset_fail_cnt < MAX_RESET_FAIL_CNT) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 59b8243..615cde1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -166,7 +166,7 @@ enum HLCGE_PORT_TYPE {
 #define HCLGE_GLOBAL_RESET_BIT		0
 #define HCLGE_CORE_RESET_BIT		1
 #define HCLGE_IMP_RESET_BIT		2
-#define HCLGE_RESET_INT_M		GENMASK(2, 0)
+#define HCLGE_RESET_INT_M		GENMASK(7, 5)
 #define HCLGE_FUN_RST_ING		0x20C00
 #define HCLGE_FUN_RST_ING_B		0
 
-- 
2.7.4

