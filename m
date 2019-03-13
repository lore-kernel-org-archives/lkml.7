Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434D5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052A42184E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NwSBe20F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfCMLDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:03:09 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19121 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMLDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:03:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c88e3600000>; Wed, 13 Mar 2019 04:02:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 04:03:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Mar 2019 04:03:07 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 11:03:07 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 11:03:07 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 11:03:07 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c88e3650000>; Wed, 13 Mar 2019 04:03:06 -0700
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
Subject: [PATCH 4/5] irqchip/gic-pm: use devm_clk_*() helpers
Date:   Wed, 13 Mar 2019 16:32:35 +0530
Message-ID: <1552474956-25513-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552474956-25513-1-git-send-email-spujar@nvidia.com>
References: <1552474956-25513-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552474976; bh=04X6neOwTgsy9qylFJ/SLXjSvMLl1XVlTBhianiVr9Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=NwSBe20FF1qLfpfKHgX63lXZ61+OPYEuif6VEgcal3FFpDldBgGZu+ZeegHFJKSt9
         jrQYaUz1CqVUCOKfGexXXL9meswpatgnIqWAkVb2bc6INucN3DKGtuoZADTte7AfqL
         PAbzvUwQ1eJTeV2dAIi4VmFcg0wNe4Mx7dz8NfQxGdP780XNFbuzmBB+mhcH4CYL6X
         t8it3gM/VAAiBrs67Mnt9H6dAerVfocSRspfovqlqCJhAj3HXxWRp0Z56lFFNFaiTN
         pMkAyqy+t1uz5g8qVpdinkU9/zvWhYeHFgf/yjKduC6QqZqSVsg+Bh6/FNOtylPySw
         fsAgYUF+EiGlw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq-gic-pm driver is using pm_clk_*() interface to manage clock resources.
With this, clocks always remain ON. This happens on Tegra devices which use
BPMP co-processor to manage clocks, where clocks are enabled during prepare
phase. This is necessary because calls to BPMP are always blocking. When
pm_clk_*() interface is used on such devices, clock prepare count is not
balanced till driver remove() gets executed and hence clocks are seen ON
always. This patch replaces pm_clk_*() with devm_clk_*() framework.

Suggested-by: Mohan Kumar D <mkumard@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
---
 drivers/irqchip/irq-gic-pm.c | 52 +++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index cde9714..b5405df 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -19,7 +19,6 @@
 #include <linux/of_irq.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/platform_device.h>
-#include <linux/pm_clock.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
@@ -30,6 +29,8 @@ struct gic_clk_data {
 
 struct gic_chip_pm {
 	struct gic_chip_data *chip_data;
+	const struct gic_clk_data *clk_data;
+	struct clk **clk_handle;
 	int irq;
 };
 
@@ -37,11 +38,19 @@ static int gic_runtime_resume(struct device *dev)
 {
 	struct gic_chip_pm *chip_pm = dev_get_drvdata(dev);
 	struct gic_chip_data *gic = chip_pm->chip_data;
-	int ret;
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
@@ -62,32 +71,37 @@ static int gic_runtime_suspend(struct device *dev)
 {
 	struct gic_chip_pm *chip_pm = dev_get_drvdata(dev);
 	struct gic_chip_data *gic = chip_pm->chip_data;
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
 
@@ -111,6 +125,8 @@ static int gic_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "no device match found\n");
 		return -ENODEV;
 	}
+	chip_pm->clk_data = data;
+	platform_set_drvdata(pdev, chip_pm);
 
 	irq = irq_of_parse_and_map(dev->of_node, 0);
 	if (!irq) {
@@ -118,7 +134,7 @@ static int gic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = gic_get_clocks(dev, data);
+	ret = gic_get_clocks(dev, chip_pm);
 	if (ret)
 		goto irq_dispose;
 
@@ -132,8 +148,6 @@ static int gic_probe(struct platform_device *pdev)
 	if (ret)
 		goto rpm_put;
 
-	platform_set_drvdata(pdev, chip_pm);
-
 	pm_runtime_put(dev);
 
 	chip_pm->irq = irq;
@@ -145,7 +159,6 @@ static int gic_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 rpm_disable:
 	pm_runtime_disable(dev);
-	pm_clk_destroy(dev);
 irq_dispose:
 	irq_dispose_mapping(irq);
 
@@ -159,7 +172,6 @@ static int gic_remove(struct platform_device *pdev)
 
 	pm_runtime_force_suspend(&pdev->dev);
 	gic_teardown(gic);
-	pm_clk_destroy(&pdev->dev);
 	irq_dispose_mapping(chip_pm->irq);
 
 	return 0;
-- 
2.7.4

