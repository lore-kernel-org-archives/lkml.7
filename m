Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F37C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A8520851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389759AbfFMPt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:49:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731698AbfFMJOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:14:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3EA0D12B51684788EC5D;
        Thu, 13 Jun 2019 17:14:14 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Jun 2019 17:14:07 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: add recovery for the H/W errors occurred before the HNS dev initialization
Date:   Thu, 13 Jun 2019 17:12:24 +0800
Message-ID: <1560417152-53050-5-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560417152-53050-1-git-send-email-tanhuazhong@huawei.com>
References: <1560417152-53050-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

This patch adds the recovery for the HNS H/W errors which occurred
before the driver initialization.

Reported-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d9863c30..6761d72 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3236,6 +3236,7 @@ static bool hclge_reset_err_handle(struct hclge_dev *hdev, bool is_timeout)
 
 		dev_info(&hdev->pdev->dev, "Upgrade reset level\n");
 		hclge_clear_reset_cause(hdev);
+		set_bit(HNAE3_GLOBAL_RESET, &hdev->default_reset_request);
 		mod_timer(&hdev->reset_timer,
 			  jiffies + HCLGE_RESET_INTERVAL);
 
@@ -3430,8 +3431,7 @@ static void hclge_reset_timer(struct timer_list *t)
 	struct hclge_dev *hdev = from_timer(hdev, t, reset_timer);
 
 	dev_info(&hdev->pdev->dev,
-		 "triggering global reset in reset timer\n");
-	set_bit(HNAE3_GLOBAL_RESET, &hdev->default_reset_request);
+		 "triggering reset in reset timer\n");
 	hclge_reset_event(hdev->pdev, NULL);
 }
 
@@ -8614,6 +8614,18 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	/* Log and clear the hw errors those already occurred */
 	hclge_handle_all_hns_hw_errors(ae_dev);
 
+	/* request delayed reset for the error recovery because an immediate
+	 * global reset on a PF affecting pending initialization of other PFs
+	 */
+	if (ae_dev->hw_err_reset_req) {
+		enum hnae3_reset_type reset_level;
+
+		reset_level = hclge_get_reset_level(ae_dev,
+						    &ae_dev->hw_err_reset_req);
+		hclge_set_def_reset_request(ae_dev, reset_level);
+		mod_timer(&hdev->reset_timer, jiffies + HCLGE_RESET_INTERVAL);
+	}
+
 	/* Enable MISC vector(vector0) */
 	hclge_enable_vector(&hdev->misc_vector, true);
 
-- 
2.7.4

