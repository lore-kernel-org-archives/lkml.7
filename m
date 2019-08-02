Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1516EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E764B2064A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403995AbfHBNBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:01:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbfHBNBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:01:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A6BF4CA39BF771809092;
        Fri,  2 Aug 2019 21:01:35 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 21:01:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: dwc3: keystone: use devm_platform_ioremap_resource() to simplify code
Date:   Fri, 2 Aug 2019 21:01:04 +0800
Message-ID: <20190802130104.62276-1-yuehaibing@huawei.com>
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
 drivers/usb/dwc3/dwc3-keystone.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index a69eb4a..1e14a6f 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -81,7 +81,6 @@ static int kdwc3_probe(struct platform_device *pdev)
 	struct device		*dev = &pdev->dev;
 	struct device_node	*node = pdev->dev.of_node;
 	struct dwc3_keystone	*kdwc;
-	struct resource		*res;
 	int			error, irq;
 
 	kdwc = devm_kzalloc(dev, sizeof(*kdwc), GFP_KERNEL);
@@ -92,8 +91,7 @@ static int kdwc3_probe(struct platform_device *pdev)
 
 	kdwc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	kdwc->usbss = devm_ioremap_resource(dev, res);
+	kdwc->usbss = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kdwc->usbss))
 		return PTR_ERR(kdwc->usbss);
 
-- 
2.7.4


