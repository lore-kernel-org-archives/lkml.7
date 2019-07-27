Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C7C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53FC20828
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbfG0Fsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 01:48:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2783 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728184AbfG0FsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:48:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 062D8CED9C6169735ACD;
        Sat, 27 Jul 2019 13:48:19 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sat, 27 Jul 2019 13:48:08 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <saeedm@mellanox.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V3 net-next 03/10] net: hns3: remove upgrade reset level when reset fail
Date:   Sat, 27 Jul 2019 13:46:05 +0800
Message-ID: <1564206372-42467-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564206372-42467-1-git-send-email-tanhuazhong@huawei.com>
References: <1564206372-42467-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, hclge_reset_err_handle() will assert a global reset
when the failing count is smaller than MAX_RESET_FAIL_CNT, which
will affect other running functions.

So this patch removes this upgrading, and uses re-scheduling reset
task to do it.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 28 +++++++---------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3fde5471..3c64d70 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3305,7 +3305,7 @@ static int hclge_reset_prepare_wait(struct hclge_dev *hdev)
 	return ret;
 }
 
-static bool hclge_reset_err_handle(struct hclge_dev *hdev, bool is_timeout)
+static bool hclge_reset_err_handle(struct hclge_dev *hdev)
 {
 #define MAX_RESET_FAIL_CNT 5
 
@@ -3322,20 +3322,11 @@ static bool hclge_reset_err_handle(struct hclge_dev *hdev, bool is_timeout)
 		return false;
 	} else if (hdev->reset_fail_cnt < MAX_RESET_FAIL_CNT) {
 		hdev->reset_fail_cnt++;
-		if (is_timeout) {
-			set_bit(hdev->reset_type, &hdev->reset_pending);
-			dev_info(&hdev->pdev->dev,
-				 "re-schedule to wait for hw reset done\n");
-			return true;
-		}
-
-		dev_info(&hdev->pdev->dev, "Upgrade reset level\n");
-		hclge_clear_reset_cause(hdev);
-		set_bit(HNAE3_GLOBAL_RESET, &hdev->default_reset_request);
-		mod_timer(&hdev->reset_timer,
-			  jiffies + HCLGE_RESET_INTERVAL);
-
-		return false;
+		set_bit(hdev->reset_type, &hdev->reset_pending);
+		dev_info(&hdev->pdev->dev,
+			 "re-schedule reset task(%d)\n",
+			 hdev->reset_fail_cnt);
+		return true;
 	}
 
 	hclge_clear_reset_cause(hdev);
@@ -3382,7 +3373,6 @@ static int hclge_reset_stack(struct hclge_dev *hdev)
 static void hclge_reset(struct hclge_dev *hdev)
 {
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(hdev->pdev);
-	bool is_timeout = false;
 	int ret;
 
 	/* Initialize ae_dev reset status as well, in case enet layer wants to
@@ -3410,10 +3400,8 @@ static void hclge_reset(struct hclge_dev *hdev)
 	if (ret)
 		goto err_reset;
 
-	if (hclge_reset_wait(hdev)) {
-		is_timeout = true;
+	if (hclge_reset_wait(hdev))
 		goto err_reset;
-	}
 
 	hdev->rst_stats.hw_reset_done_cnt++;
 
@@ -3465,7 +3453,7 @@ static void hclge_reset(struct hclge_dev *hdev)
 err_reset_lock:
 	rtnl_unlock();
 err_reset:
-	if (hclge_reset_err_handle(hdev, is_timeout))
+	if (hclge_reset_err_handle(hdev))
 		hclge_reset_task_schedule(hdev);
 }
 
-- 
2.7.4

