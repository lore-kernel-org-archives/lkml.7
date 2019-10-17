Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE54FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E6421835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408043AbfJQHQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:16:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbfJQHQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:16:39 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 928A792B0572A31F7EC2;
        Thu, 17 Oct 2019 15:16:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 15:16:32 +0800
From:   Daode Huang <huangdaode@hisilicon.com>
To:     <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <tglx@linutronix.de>, <maz@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] use devm_platform_ioremap_resource() for irqchip drivers
Date:   Thu, 17 Oct 2019 15:13:43 +0800
Message-ID: <1571296423-208359-1-git-send-email-huangdaode@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daode Huang <huangdaode@hislicon.com>

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together

Signed-off-by: Daode Huang <huangdaode@hislicon.com>
---
 drivers/irqchip/irq-mvebu-icu.c   | 3 +--
 drivers/irqchip/irq-mvebu-pic.c   | 3 +--
 drivers/irqchip/irq-stm32-exti.c  | 3 +--
 drivers/irqchip/irq-ti-sci-inta.c | 3 +--
 drivers/irqchip/irq-ts4800.c      | 3 +--
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 547045d..ddf9b0d 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -357,8 +357,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 
 	icu->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	icu->base = devm_ioremap_resource(&pdev->dev, res);
+	icu->base = devm_platform_ioremap_resource(pdev, res);
 	if (IS_ERR(icu->base)) {
 		dev_err(&pdev->dev, "Failed to map icu base address.\n");
 		return PTR_ERR(icu->base);
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index eec6395..0c3520d 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -130,8 +130,7 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 	if (!pic)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pic->base = devm_ioremap_resource(&pdev->dev, res);
+	pic->base = devm_platform_ioremap_resource(pdev, res);
 	if (IS_ERR(pic->base))
 		return PTR_ERR(pic->base);
 
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index e00f2fa..7f5500e 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -849,8 +849,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (!host_data->chips_data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	host_data->base = devm_ioremap_resource(dev, res);
+	host_data->base = devm_platform_ioremap_resource(pdev, res);
 	if (IS_ERR(host_data->base)) {
 		dev_err(dev, "Unable to map registers\n");
 		return PTR_ERR(host_data->base);
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index ef4d625..d2ad3cc 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -567,8 +567,7 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 		return PTR_ERR(inta->global_event);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	inta->base = devm_ioremap_resource(dev, res);
+	inta->base = devm_platform_ioremap_resource(pdev, res);
 	if (IS_ERR(inta->base))
 		return -ENODEV;
 
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 2325fb3..f1cefa9 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -101,8 +101,7 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(&pdev->dev, res);
+	data->base = devm_platform_ioremap_resource(pdev, res);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-- 
2.8.1

