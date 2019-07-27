Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDED3C76190
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB144206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbfG0Fsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 01:48:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38886 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728213AbfG0FsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:48:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E5AF9F4842AC5873B92E;
        Sat, 27 Jul 2019 13:48:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sat, 27 Jul 2019 13:48:10 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <saeedm@mellanox.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V3 net-next 10/10] net: hns3: use dev_info() instead of pr_info()
Date:   Sat, 27 Jul 2019 13:46:12 +0800
Message-ID: <1564206372-42467-11-git-send-email-tanhuazhong@huawei.com>
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

dev_info() is more appropriate for printing messages when driver
initialization done, so switch to dev_info().

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 30a7074..4138780 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -8862,7 +8862,9 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hclge_state_init(hdev);
 	hdev->last_reset_time = jiffies;
 
-	pr_info("%s driver initialization finished.\n", HCLGE_DRIVER_NAME);
+	dev_info(&hdev->pdev->dev, "%s driver initialization finished.\n",
+		 HCLGE_DRIVER_NAME);
+
 	return 0;
 
 err_mdiobus_unreg:
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index a13a0e1..ae0e6a6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2695,7 +2695,8 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 	}
 
 	hdev->last_reset_time = jiffies;
-	pr_info("finished initializing %s driver\n", HCLGEVF_DRIVER_NAME);
+	dev_info(&hdev->pdev->dev, "finished initializing %s driver\n",
+		 HCLGEVF_DRIVER_NAME);
 
 	return 0;
 
-- 
2.7.4

