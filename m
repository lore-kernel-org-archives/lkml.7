Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7057C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C6A2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfIDJgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:36:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbfIDJgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:36:20 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 43C66A80CBE103D201F1;
        Wed,  4 Sep 2019 17:36:18 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 17:36:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <yuehaibing@huawei.com>, <mcgrof@kernel.org>, <swboyd@chromium.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: bdc: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 17:33:35 +0800
Message-ID: <20190904093335.22860-1-yuehaibing@huawei.com>
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
 drivers/usb/gadget/udc/bdc/bdc_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index cc4a16e..02a3a77 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -480,7 +480,6 @@ static void bdc_phy_exit(struct bdc *bdc)
 static int bdc_probe(struct platform_device *pdev)
 {
 	struct bdc *bdc;
-	struct resource *res;
 	int ret = -ENOMEM;
 	int irq;
 	u32 temp;
@@ -508,8 +507,7 @@ static int bdc_probe(struct platform_device *pdev)
 
 	bdc->clk = clk;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bdc->regs = devm_ioremap_resource(dev, res);
+	bdc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bdc->regs)) {
 		dev_err(dev, "ioremap error\n");
 		return -ENOMEM;
-- 
2.7.4


