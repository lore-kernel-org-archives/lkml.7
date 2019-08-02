Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E676CC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C330120679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436549AbfHBNsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:48:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728326AbfHBNsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:48:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 66BA2FA07B734FF7568F;
        Fri,  2 Aug 2019 21:48:34 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 21:48:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <zbr@ioremap.net>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <gregkh@linuxfoundation.org>,
        <rfontana@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] w1: mxc_w1: use devm_platform_ioremap_resource() to simplify code
Date:   Fri, 2 Aug 2019 21:48:19 +0800
Message-ID: <20190802134819.9088-1-yuehaibing@huawei.com>
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

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/w1/masters/mxc_w1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index c3b2095..1ca880e 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -92,7 +92,6 @@ static int mxc_w1_probe(struct platform_device *pdev)
 {
 	struct mxc_w1_device *mdev;
 	unsigned long clkrate;
-	struct resource *res;
 	unsigned int clkdiv;
 	int err;
 
@@ -120,8 +119,7 @@ static int mxc_w1_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev,
 			 "Incorrect time base frequency %lu Hz\n", clkrate);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mdev->regs = devm_ioremap_resource(&pdev->dev, res);
+	mdev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdev->regs)) {
 		err = PTR_ERR(mdev->regs);
 		goto out_disable_clk;
-- 
2.7.4


