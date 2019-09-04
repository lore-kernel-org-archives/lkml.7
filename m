Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9E5C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D84722CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfIDJmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:42:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfIDJml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:42:41 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 462E6911F4944A47F3B0;
        Wed,  4 Sep 2019 17:42:40 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 17:42:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: gadget: pxa25x_udc: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 17:42:22 +0800
Message-ID: <20190904094222.23128-1-yuehaibing@huawei.com>
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
 drivers/usb/gadget/udc/pxa25x_udc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index d4be535..cfafdd9 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -2321,7 +2321,6 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
 	struct pxa25x_udc *dev = &memory;
 	int retval, irq;
 	u32 chiprev;
-	struct resource *res;
 
 	pr_info("%s: version %s\n", driver_name, DRIVER_VERSION);
 
@@ -2367,8 +2366,7 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dev->regs = devm_ioremap_resource(&pdev->dev, res);
+	dev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dev->regs))
 		return PTR_ERR(dev->regs);
 
-- 
2.7.4


