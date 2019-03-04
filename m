Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF17C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A7620830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658033;
	bh=z5lo/ATgO0xpwOk/b9Biyo1ydT7I6IICS0RJ8dugxHw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ss90+KLt5ksfQBU0+0L//HDGbQ3rVpOUYvDgmzZnzemuogsln9MnoZJeteRUc9IDE
	 TntugwkN+PAvJIIKQjrin9bZLPIjqTzf6mHa29tstO8MG+gxvAaDClRar09aP7RaaR
	 HYbprAa/G+4JTpk7toJ/rylb/2gQnzlYbvGiTeb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCDAHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:07:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54714 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfCDAHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kUaF2KQQ1IUPrZSQSbWiXARXz/QPFYAXTw80ooO9uy4=; b=ptppGgsxvT+l
        lywBeU2EQy8aeTgzNVkP3mPyrpYuA2Sgj6iHr7ocarKzfqIUclFbXWNoX8Tf8qJEAqIGrIReBCFKq
        fIflziOJcnFkG8tnht/edM/vcXNh3zHol000ziq5CKJcEmjA5jrA+tZvGiomkpI1eouNDE94zEoJR
        DH73I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b8D-0007R0-Di; Mon, 04 Mar 2019 00:06:57 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CAE93440082; Mon,  4 Mar 2019 00:06:56 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: stm32-vrefbuf: add power management support" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000656.CAE93440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stm32-vrefbuf: add power management support

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From be5295f8a15fee6d92e78c822e9960c42638e32a Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Date: Thu, 28 Feb 2019 11:45:18 +0100
Subject: [PATCH] regulator: stm32-vrefbuf: add power management support

Add support for suspend/resume and runtime PM to stm32-vrefbuf driver.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stm32-vrefbuf.c | 121 ++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index e0a9c445ed67..ba2f24949dc9 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
+#include <linux/pm_runtime.h>
 
 /* STM32 VREFBUF registers */
 #define STM32_VREFBUF_CSR		0x00
@@ -25,9 +26,12 @@
 #define STM32_HIZ			BIT(1)
 #define STM32_ENVR			BIT(0)
 
+#define STM32_VREFBUF_AUTO_SUSPEND_DELAY_MS	10
+
 struct stm32_vrefbuf {
 	void __iomem *base;
 	struct clk *clk;
+	struct device *dev;
 };
 
 static const unsigned int stm32_vrefbuf_voltages[] = {
@@ -38,9 +42,16 @@ static const unsigned int stm32_vrefbuf_voltages[] = {
 static int stm32_vrefbuf_enable(struct regulator_dev *rdev)
 {
 	struct stm32_vrefbuf *priv = rdev_get_drvdata(rdev);
-	u32 val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
+	u32 val;
 	int ret;
 
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
 	val = (val & ~STM32_HIZ) | STM32_ENVR;
 	writel_relaxed(val, priv->base + STM32_VREFBUF_CSR);
 
@@ -59,45 +70,95 @@ static int stm32_vrefbuf_enable(struct regulator_dev *rdev)
 		writel_relaxed(val, priv->base + STM32_VREFBUF_CSR);
 	}
 
+	pm_runtime_mark_last_busy(priv->dev);
+	pm_runtime_put_autosuspend(priv->dev);
+
 	return ret;
 }
 
 static int stm32_vrefbuf_disable(struct regulator_dev *rdev)
 {
 	struct stm32_vrefbuf *priv = rdev_get_drvdata(rdev);
-	u32 val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
+	u32 val;
+	int ret;
 
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
 	val = (val & ~STM32_ENVR) | STM32_HIZ;
 	writel_relaxed(val, priv->base + STM32_VREFBUF_CSR);
 
+	pm_runtime_mark_last_busy(priv->dev);
+	pm_runtime_put_autosuspend(priv->dev);
+
 	return 0;
 }
 
 static int stm32_vrefbuf_is_enabled(struct regulator_dev *rdev)
 {
 	struct stm32_vrefbuf *priv = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	ret = readl_relaxed(priv->base + STM32_VREFBUF_CSR) & STM32_ENVR;
 
-	return readl_relaxed(priv->base + STM32_VREFBUF_CSR) & STM32_ENVR;
+	pm_runtime_mark_last_busy(priv->dev);
+	pm_runtime_put_autosuspend(priv->dev);
+
+	return ret;
 }
 
 static int stm32_vrefbuf_set_voltage_sel(struct regulator_dev *rdev,
 					 unsigned sel)
 {
 	struct stm32_vrefbuf *priv = rdev_get_drvdata(rdev);
-	u32 val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
+	u32 val;
+	int ret;
 
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
 	val = (val & ~STM32_VRS) | FIELD_PREP(STM32_VRS, sel);
 	writel_relaxed(val, priv->base + STM32_VREFBUF_CSR);
 
+	pm_runtime_mark_last_busy(priv->dev);
+	pm_runtime_put_autosuspend(priv->dev);
+
 	return 0;
 }
 
 static int stm32_vrefbuf_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct stm32_vrefbuf *priv = rdev_get_drvdata(rdev);
-	u32 val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
+	u32 val;
+	int ret;
 
-	return FIELD_GET(STM32_VRS, val);
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
+	ret = FIELD_GET(STM32_VRS, val);
+
+	pm_runtime_mark_last_busy(priv->dev);
+	pm_runtime_put_autosuspend(priv->dev);
+
+	return ret;
 }
 
 static const struct regulator_ops stm32_vrefbuf_volt_ops = {
@@ -130,6 +191,7 @@ static int stm32_vrefbuf_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	priv->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
@@ -140,10 +202,17 @@ static int stm32_vrefbuf_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					 STM32_VREFBUF_AUTO_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = clk_prepare_enable(priv->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "clk prepare failed with error %d\n", ret);
-		return ret;
+		goto err_pm_stop;
 	}
 
 	config.dev = &pdev->dev;
@@ -161,10 +230,17 @@ static int stm32_vrefbuf_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, rdev);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 err_clk_dis:
 	clk_disable_unprepare(priv->clk);
+err_pm_stop:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 
 	return ret;
 }
@@ -174,12 +250,42 @@ static int stm32_vrefbuf_remove(struct platform_device *pdev)
 	struct regulator_dev *rdev = platform_get_drvdata(pdev);
 	struct stm32_vrefbuf *priv = rdev_get_drvdata(rdev);
 
+	pm_runtime_get_sync(&pdev->dev);
 	regulator_unregister(rdev);
 	clk_disable_unprepare(priv->clk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 
 	return 0;
 };
 
+static int __maybe_unused stm32_vrefbuf_runtime_suspend(struct device *dev)
+{
+	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct stm32_vrefbuf *priv = rdev_get_drvdata(rdev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_vrefbuf_runtime_resume(struct device *dev)
+{
+	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct stm32_vrefbuf *priv = rdev_get_drvdata(rdev);
+
+	return clk_prepare_enable(priv->clk);
+}
+
+static const struct dev_pm_ops stm32_vrefbuf_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(stm32_vrefbuf_runtime_suspend,
+			   stm32_vrefbuf_runtime_resume,
+			   NULL)
+};
+
 static const struct of_device_id stm32_vrefbuf_of_match[] = {
 	{ .compatible = "st,stm32-vrefbuf", },
 	{},
@@ -192,6 +298,7 @@ static struct platform_driver stm32_vrefbuf_driver = {
 	.driver = {
 		.name  = "stm32-vrefbuf",
 		.of_match_table = of_match_ptr(stm32_vrefbuf_of_match),
+		.pm = &stm32_vrefbuf_pm_ops,
 	},
 };
 module_platform_driver(stm32_vrefbuf_driver);
-- 
2.20.1

