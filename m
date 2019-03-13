Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C590C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CA62177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Z+AjPldy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfCMLCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:02:50 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17358 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMLCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:02:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c88e3540001>; Wed, 13 Mar 2019 04:02:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 04:02:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Mar 2019 04:02:43 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 11:02:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 11:02:42 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c88e34c0000>; Wed, 13 Mar 2019 04:02:42 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <will.deacon@arm.com>,
        <catalin.marinas@arm.com>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <maxime.ripard@bootlin.com>,
        <andy.gross@linaro.org>, <olof@lixom.net>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <stefan.wahren@i2se.com>,
        <ezequiel@collabora.com>, <marc.w.gonzalez@free.fr>,
        <christoffer.dall@arm.com>, <drjones@redhat.com>,
        <julien.thierry@arm.com>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/5] irqchip/gic-pm: add driver remove support
Date:   Wed, 13 Mar 2019 16:32:32 +0530
Message-ID: <1552474956-25513-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552474964; bh=lFM4iodDzzSOhvcV5necIx1hFwEUwfwAJPXaeRkAEYU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=Z+AjPldyAhUUUQMIPzcxXFtdgzKM4mJlxgKmtRZJ0O9SNMEZ7vUuQZEywONM0HRk8
         344MtvAM6acDDjqQQhC53eVem6s1qn+5kh11USDS5br1rJUfydr+XNdZxmgUg0ox/f
         jl02zVVaOG+mfyLE0cW0rjJxcgPx038Hi6ustu+1sp+Jrdbkg0XYhR+yZf8sBYA1uF
         wrwZwbk9D9a3/J2tuNTBfivUwFGOf+miwwkHLIQ7o0abh2mwGbmJQibwR24y1xViKA
         9dgOl0+XC8lNFKvUyCgfQluKuNTWYn83QB2aWN6wF5spGUmVCLB8mzkJT17YGmnq9j
         NKalaeakFnGAQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory patch for using irq-gic-pm driver as module and thus
implement remove() call for the driver. Details of remove() are as below,

 * pm_runtime_force_suspend() is added to balance runtime PM, otherwise
   following is seen: "agic-controller: Unbalanced pm_runtime_enable!"
 * Function gic_teardown() is exported from gic driver and called in remove
   to perform io unmap.
 * pm_clk_destroy() to free clock resources
 * irq is unmapped and freed with irq_dispose_mapping()

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/irqchip/irq-gic-pm.c    | 37 ++++++++++++++++++++++++++++++++-----
 drivers/irqchip/irq-gic.c       |  3 ++-
 include/linux/irqchip/arm-gic.h |  2 ++
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index ecafd29..56a785f 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -28,9 +28,15 @@ struct gic_clk_data {
 	const char *const *clocks;
 };
 
+struct gic_chip_pm {
+	struct gic_chip_data *chip_data;
+	int irq;
+};
+
 static int gic_runtime_resume(struct device *dev)
 {
-	struct gic_chip_data *gic = dev_get_drvdata(dev);
+	struct gic_chip_pm *chip_pm = dev_get_drvdata(dev);
+	struct gic_chip_data *gic = chip_pm->chip_data;
 	int ret;
 
 	ret = pm_clk_resume(dev);
@@ -54,7 +60,8 @@ static int gic_runtime_resume(struct device *dev)
 
 static int gic_runtime_suspend(struct device *dev)
 {
-	struct gic_chip_data *gic = dev_get_drvdata(dev);
+	struct gic_chip_pm *chip_pm = dev_get_drvdata(dev);
+	struct gic_chip_data *gic = chip_pm->chip_data;
 
 	gic_dist_save(gic);
 	gic_cpu_save(gic);
@@ -91,9 +98,14 @@ static int gic_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct gic_clk_data *data;
-	struct gic_chip_data *gic;
+	struct gic_chip_pm *chip_pm;
 	int ret, irq;
 
+	chip_pm = devm_kzalloc(dev, sizeof(struct gic_chip_pm),
+			       GFP_KERNEL);
+	if (!chip_pm)
+		return -ENOMEM;
+
 	data = of_device_get_match_data(&pdev->dev);
 	if (!data) {
 		dev_err(&pdev->dev, "no device match found\n");
@@ -116,14 +128,15 @@ static int gic_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto rpm_disable;
 
-	ret = gic_of_init_child(dev, &gic, irq);
+	ret = gic_of_init_child(dev, &chip_pm->chip_data, irq);
 	if (ret)
 		goto rpm_put;
 
-	platform_set_drvdata(pdev, gic);
+	platform_set_drvdata(pdev, chip_pm);
 
 	pm_runtime_put(dev);
 
+	chip_pm->irq = irq;
 	dev_info(dev, "GIC IRQ controller registered\n");
 
 	return 0;
@@ -139,6 +152,19 @@ static int gic_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int gic_remove(struct platform_device *pdev)
+{
+	struct gic_chip_pm *chip_pm = dev_get_drvdata(&pdev->dev);
+	struct gic_chip_data *gic = chip_pm->chip_data;
+
+	pm_runtime_force_suspend(&pdev->dev);
+	gic_teardown(gic);
+	pm_clk_destroy(&pdev->dev);
+	irq_dispose_mapping(chip_pm->irq);
+
+	return 0;
+}
+
 static const struct dev_pm_ops gic_pm_ops = {
 	SET_RUNTIME_PM_OPS(gic_runtime_suspend,
 			   gic_runtime_resume, NULL)
@@ -161,6 +187,7 @@ MODULE_DEVICE_TABLE(of, gic_match);
 
 static struct platform_driver gic_driver = {
 	.probe		= gic_probe,
+	.remove		= gic_remove,
 	.driver		= {
 		.name	= "gic",
 		.of_match_table	= gic_match,
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ba2a37a..f88018b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1259,7 +1259,7 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
 	__gic_init_bases(gic, irq_start, NULL);
 }
 
-static void gic_teardown(struct gic_chip_data *gic)
+void gic_teardown(struct gic_chip_data *gic)
 {
 	if (WARN_ON(!gic))
 		return;
@@ -1269,6 +1269,7 @@ static void gic_teardown(struct gic_chip_data *gic)
 	if (gic->raw_cpu_base)
 		iounmap(gic->raw_cpu_base);
 }
+EXPORT_SYMBOL_GPL(gic_teardown);
 
 #ifdef CONFIG_OF
 static int gic_cnt __initdata;
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 6261790..f790232 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -161,6 +161,8 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq);
 void gic_init(unsigned int nr, int start,
 	      void __iomem *dist , void __iomem *cpu);
 
+void gic_teardown(struct gic_chip_data *gic);
+
 int gicv2m_init(struct fwnode_handle *parent_handle,
 		struct irq_domain *parent);
 
-- 
2.7.4

