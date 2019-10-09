Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1F0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E55D20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfJIPED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:04:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729865AbfJIPEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:04:02 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 85C58CBB2DF5AD50A978;
        Wed,  9 Oct 2019 23:04:00 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 23:03:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <richardcochran@gmail.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ptp: ptp_dte: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 9 Oct 2019 23:03:25 +0800
Message-ID: <20191009150325.12736-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/ptp/ptp_dte.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_dte.c b/drivers/ptp/ptp_dte.c
index 0dcfdc8..82d31ba 100644
--- a/drivers/ptp/ptp_dte.c
+++ b/drivers/ptp/ptp_dte.c
@@ -240,14 +240,12 @@ static int ptp_dte_probe(struct platform_device *pdev)
 {
 	struct ptp_dte *ptp_dte;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 
 	ptp_dte = devm_kzalloc(dev, sizeof(struct ptp_dte), GFP_KERNEL);
 	if (!ptp_dte)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ptp_dte->regs = devm_ioremap_resource(dev, res);
+	ptp_dte->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ptp_dte->regs))
 		return PTR_ERR(ptp_dte->regs);
 
-- 
2.7.4


