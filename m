Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC97C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D02920661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="onknNf+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfCFKll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:41:41 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11649 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbfCFKlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:41:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7fa3db0001>; Wed, 06 Mar 2019 02:41:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Mar 2019 02:41:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Mar 2019 02:41:39 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Mar
 2019 10:41:38 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 6 Mar 2019 10:41:39 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7fa3df0002>; Wed, 06 Mar 2019 02:41:38 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <mkumard@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/3] irqchip/gic-pm: use devm_clk_*() helpers
Date:   Wed, 6 Mar 2019 16:11:18 +0530
Message-ID: <1551868878-1131-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551868878-1131-1-git-send-email-spujar@nvidia.com>
References: <1551868878-1131-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551868891; bh=Qp/M0Ct3Oo0YiRVr0xnM8LvxXwBgpIbzfj5yKAhzP2o=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=onknNf+/beK5k7tlEnJbTJC0cfUCP5UBcEAw9ErBdS784aDTMpSVaesuaO91fBjNW
         6TFAxVrqr6DJj/Vdq6rdZPaEtxVwZLEaiNUzUEZdJIKj0q46YZSxLeCla86/UTjuts
         4eMDeQJLvo7tqRjURolEa0I/atgeIYgXgoJ0uZFZYHjpoTnBoMrwe8WDsfN+NcgcC4
         khr4Q+P3Yn+Odi54cFPpj5yoOrPC1FMWQLpXRHUIfeEh7YJYEqrRWUzcGaXpdQDW3H
         9cvxsx74uhMALhRaEN5EU1BTwOy0JzjgutFMHMw8rhbFRdO6jkHCksQjjjonusLu6k
         0+o0ZHuReVmaw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With pm_clk_*() usage, it is seen that clocks always remain ON. This
happens because clocks are managed by BPMP on Tegra devices and clock
enable/disable happens during prepare/unprepare phase. This patch
avoids use of pm_clk_*() and replaces it with devm_clk_*() helpers.

Suggested-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/irqchip/irq-gic-pm.c | 69 +++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index ecafd29..1690939 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -19,7 +19,6 @@
 #include <linux/of_irq.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/platform_device.h>
-#include <linux/pm_clock.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
@@ -28,14 +27,29 @@ struct gic_clk_data {
 	const char *const *clocks;
 };
 
+struct gic_chip_pm {
+	struct gic_chip_data *chip_data;
+	const struct gic_clk_data *clk_data;
+	struct clk **clk_handle;
+};
+
 static int gic_runtime_resume(struct device *dev)
 {
-	struct gic_chip_data *gic = dev_get_drvdata(dev);
-	int ret;
+	struct gic_chip_pm *chip_pm = dev_get_drvdata(dev);
+	struct gic_chip_data *gic = chip_pm->chip_data;
+	const struct gic_clk_data *data = chip_pm->clk_data;
+	int ret, i;
 
-	ret = pm_clk_resume(dev);
-	if (ret)
-		return ret;
+	for (i = 0; i < data->num_clocks; i++) {
+		ret = clk_prepare_enable(chip_pm->clk_handle[i]);
+		if (ret) {
+			while (--i >= 0)
+				clk_disable_unprepare(chip_pm->clk_handle[i]);
+
+			dev_err(dev, " clk_enable failed: %d\n", ret);
+			return ret;
+		}
+	}
 
 	/*
 	 * On the very first resume, the pointer to the driver data
@@ -54,33 +68,39 @@ static int gic_runtime_resume(struct device *dev)
 
 static int gic_runtime_suspend(struct device *dev)
 {
-	struct gic_chip_data *gic = dev_get_drvdata(dev);
+	struct gic_chip_pm *chip_pm = dev_get_drvdata(dev);
+	struct gic_chip_data *gic = chip_pm->chip_data;
+	const struct gic_clk_data *data = chip_pm->clk_data;
+	int i;
 
 	gic_dist_save(gic);
 	gic_cpu_save(gic);
 
-	return pm_clk_suspend(dev);
+	for (i = 0; i < data->num_clocks; i++)
+		clk_disable_unprepare(chip_pm->clk_handle[i]);
+
+	return 0;
 }
 
-static int gic_get_clocks(struct device *dev, const struct gic_clk_data *data)
+static int gic_get_clocks(struct device *dev, struct gic_chip_pm *chip_pm)
 {
 	unsigned int i;
-	int ret;
+	const struct gic_clk_data *data = chip_pm->clk_data;
 
 	if (!dev || !data)
 		return -EINVAL;
 
-	ret = pm_clk_create(dev);
-	if (ret)
-		return ret;
+	chip_pm->clk_handle = devm_kzalloc(dev, data->num_clocks *
+					   sizeof(struct clk *), GFP_KERNEL);
+	if (!chip_pm->clk_handle)
+		return -ENOMEM;
 
 	for (i = 0; i < data->num_clocks; i++) {
-		ret = of_pm_clk_add_clk(dev, data->clocks[i]);
-		if (ret) {
+		chip_pm->clk_handle[i] = devm_clk_get(dev, data->clocks[i]);
+		if (IS_ERR(chip_pm->clk_handle[i])) {
 			dev_err(dev, "failed to add clock %s\n",
 				data->clocks[i]);
-			pm_clk_destroy(dev);
-			return ret;
+			return PTR_ERR(chip_pm->clk_handle[i]);
 		}
 	}
 
@@ -91,14 +111,20 @@ static int gic_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct gic_clk_data *data;
-	struct gic_chip_data *gic;
+	struct gic_chip_pm *gic_chip_pm;
 	int ret, irq;
 
+	gic_chip_pm = devm_kzalloc(dev, sizeof(*gic_chip_pm), GFP_KERNEL);
+	if (!gic_chip_pm)
+		return -ENOMEM;
+
 	data = of_device_get_match_data(&pdev->dev);
 	if (!data) {
 		dev_err(&pdev->dev, "no device match found\n");
 		return -ENODEV;
 	}
+	gic_chip_pm->clk_data = data;
+	platform_set_drvdata(pdev, gic_chip_pm);
 
 	irq = irq_of_parse_and_map(dev->of_node, 0);
 	if (!irq) {
@@ -106,7 +132,7 @@ static int gic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = gic_get_clocks(dev, data);
+	ret = gic_get_clocks(dev, gic_chip_pm);
 	if (ret)
 		goto irq_dispose;
 
@@ -116,12 +142,10 @@ static int gic_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto rpm_disable;
 
-	ret = gic_of_init_child(dev, &gic, irq);
+	ret = gic_of_init_child(dev, &gic_chip_pm->chip_data, irq);
 	if (ret)
 		goto rpm_put;
 
-	platform_set_drvdata(pdev, gic);
-
 	pm_runtime_put(dev);
 
 	dev_info(dev, "GIC IRQ controller registered\n");
@@ -132,7 +156,6 @@ static int gic_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 rpm_disable:
 	pm_runtime_disable(dev);
-	pm_clk_destroy(dev);
 irq_dispose:
 	irq_dispose_mapping(irq);
 
-- 
2.7.4

