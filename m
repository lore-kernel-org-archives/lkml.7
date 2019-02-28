Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED20C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE6B2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbfB1Kqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:46:34 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42648 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfB1Kqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:46:33 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SASVb1020557;
        Thu, 28 Feb 2019 11:45:34 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvtxc5de-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 11:45:34 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37B6834;
        Thu, 28 Feb 2019 10:45:34 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 13DA64FF2;
        Thu, 28 Feb 2019 10:45:34 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Feb 2019 11:45:33
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] regulator: stm32-vrefbuf: add power management support
Date:   Thu, 28 Feb 2019 11:45:18 +0100
Message-ID: <1551350718-19117-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for suspend/resume and runtime PM to stm32-vrefbuf driver.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/regulator/stm32-vrefbuf.c | 121 +++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index e0a9c44..ba2f249 100644
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
2.7.4

