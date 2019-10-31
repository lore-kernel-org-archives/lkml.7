Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2F8CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C428F2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfJaOJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:09:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfJaOJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:09:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F04048B2847776E73F45;
        Thu, 31 Oct 2019 22:08:58 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 22:08:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <agross@kernel.org>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc: qcom: smp2p: remove redundant print message.
Date:   Thu, 31 Oct 2019 22:05:02 +0800
Message-ID: <1572530702-27364-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() fails to get the irq, it will print an error.
hence it is no need to print an error again after platform_get_irq() return.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/soc/qcom/smp2p.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index c7300d5..07183d7 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -474,10 +474,8 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 		goto report_read_failure;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "unable to acquire smp2p interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	smp2p->mbox_client.dev = &pdev->dev;
 	smp2p->mbox_client.knows_txdone = true;
-- 
1.7.12.4

