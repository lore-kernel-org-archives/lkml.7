Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F58C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFAA2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272049;
	bh=AEEHKp4xDAhrIEiyCF1CAC3Pfg9I+HYS0irvYkfZJPw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EfQIqLnMVf94DJcjLKx1ORVJMoz/Xua4wVWgUjBNSgRW03CUdNoxpTqdN8rD+4vT1
	 UhONfWzjO4E11rJAbc4WwF1bdu1wOG88syMD6pZw+8ToOPJnGf3hFvTGDeII7A3hvt
	 yLuWWAsD9ZTKEaaLGKydPNab9pmE5b6fsmns950M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfDZJpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:45:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfDZJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=o6gY0tQXcvm0wrMlbeLmuMExil7Z8pjV26gUfnxQ5co=; b=RQsYvOe8l4vb
        yI/tJ5QL9OC09lM169WU7LJRt33TxNSvRJ0si3w97dk1AzQ0tuQBSSwl1jst47Nu+wVK97bnqn6yz
        1UMZA31QaTXGa9ngcmVyJsqvVK1uewuCO3bDaaS3Nz1qsQRpTyLNV9vSq41R2uBry15DtgBl9c15T
        nb5Lo=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxPZ-0003Q9-MD; Fri, 26 Apr 2019 09:44:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 878E0441D3B; Fri, 26 Apr 2019 10:44:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pascal Paillet <p.paillet@st.com>
Subject: Applied "regulator: Add support for stm32 power regulators" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094452.878E0441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:44:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Add support for stm32 power regulators

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

From 6cdae8173f6771977c3863bac7f1455c96bb1f6e Mon Sep 17 00:00:00 2001
From: Pascal PAILLET-LME <p.paillet@st.com>
Date: Mon, 15 Apr 2019 09:17:38 +0000
Subject: [PATCH] regulator: Add support for stm32 power regulators

Add support for 1V1 1V8 USB3V3 power regulators.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig     |   7 ++
 drivers/regulator/Makefile    |   1 +
 drivers/regulator/stm32-pwr.c | 190 ++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/regulator/stm32-pwr.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c4dc2bcafb56..6c37f0df9323 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -840,6 +840,13 @@ config REGULATOR_STM32_VREFBUF
 	  This driver can also be built as a module. If so, the module
 	  will be called stm32-vrefbuf.
 
+config REGULATOR_STM32_PWR
+	bool "STMicroelectronics STM32 PWR"
+	depends on ARCH_STM32 || COMPILE_TEST
+	help
+	  This driver supports internal regulators (1V1, 1V8, 3V3) in the
+	  STMicroelectronics STM32 chips.
+
 config REGULATOR_STPMIC1
 	tristate "STMicroelectronics STPMIC1 PMIC Regulators"
 	depends on MFD_STPMIC1
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 1169f8a27d91..93f53840e8f1 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_REGULATOR_SC2731) += sc2731-regulator.o
 obj-$(CONFIG_REGULATOR_SKY81452) += sky81452-regulator.o
 obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
+obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
 obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
 obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
new file mode 100644
index 000000000000..e434b26d4c8b
--- /dev/null
+++ b/drivers/regulator/stm32-pwr.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) STMicroelectronics 2019
+// Authors: Gabriel Fernandez <gabriel.fernandez@st.com>
+//          Pascal Paillet <p.paillet@st.com>.
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+/*
+ * Registers description
+ */
+#define REG_PWR_CR3 0x0C
+
+#define USB_3_3_EN BIT(24)
+#define USB_3_3_RDY BIT(26)
+#define REG_1_8_EN BIT(28)
+#define REG_1_8_RDY BIT(29)
+#define REG_1_1_EN BIT(30)
+#define REG_1_1_RDY BIT(31)
+
+/* list of supported regulators */
+enum {
+	PWR_REG11,
+	PWR_REG18,
+	PWR_USB33,
+	STM32PWR_REG_NUM_REGS
+};
+
+u32 ready_mask_table[STM32PWR_REG_NUM_REGS] = {
+	[PWR_REG11] = REG_1_1_RDY,
+	[PWR_REG18] = REG_1_8_RDY,
+	[PWR_USB33] = USB_3_3_RDY,
+};
+
+struct stm32_pwr_reg {
+	void __iomem *base;
+	const struct regulator_desc *desc;
+	u32 ready_mask;
+};
+
+int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
+{
+	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
+	u32 val;
+
+	val = readl_relaxed(priv->base + REG_PWR_CR3);
+
+	return (val & priv->ready_mask);
+}
+
+int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
+{
+	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
+	u32 val;
+
+	val = readl_relaxed(priv->base + REG_PWR_CR3);
+
+	return (val & priv->desc->enable_mask);
+}
+
+static int stm32_pwr_reg_enable(struct regulator_dev *rdev)
+{
+	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
+	int ret;
+	u32 val;
+
+	val = readl_relaxed(priv->base + REG_PWR_CR3);
+	val |= priv->desc->enable_mask;
+	writel_relaxed(val, priv->base + REG_PWR_CR3);
+
+	/* use an arbitrary timeout of 20ms */
+	ret = readx_poll_timeout(stm32_pwr_reg_is_ready, rdev, val, val,
+				 100, 20 * 1000);
+	if (ret)
+		dev_err(&rdev->dev, "regulator enable timed out!\n");
+
+	return ret;
+}
+
+static int stm32_pwr_reg_disable(struct regulator_dev *rdev)
+{
+	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
+	int ret;
+	u32 val;
+
+	val = readl_relaxed(priv->base + REG_PWR_CR3);
+	val &= ~priv->desc->enable_mask;
+	writel_relaxed(val, priv->base + REG_PWR_CR3);
+
+	/* use an arbitrary timeout of 20ms */
+	ret = readx_poll_timeout(stm32_pwr_reg_is_ready, rdev, val, !val,
+				 100, 20 * 1000);
+	if (ret)
+		dev_err(&rdev->dev, "regulator disable timed out!\n");
+
+	return ret;
+}
+
+static const struct regulator_ops stm32_pwr_reg_ops = {
+	.list_voltage	= regulator_list_voltage_linear,
+	.enable		= stm32_pwr_reg_enable,
+	.disable	= stm32_pwr_reg_disable,
+	.is_enabled	= stm32_pwr_reg_is_enabled,
+};
+
+#define PWR_REG(_id, _name, _volt, _en, _supply) \
+	[_id] = { \
+		.id = _id, \
+		.name = _name, \
+		.of_match = of_match_ptr(_name), \
+		.n_voltages = 1, \
+		.type = REGULATOR_VOLTAGE, \
+		.min_uV = _volt, \
+		.fixed_uV = _volt, \
+		.ops = &stm32_pwr_reg_ops, \
+		.enable_mask = _en, \
+		.owner = THIS_MODULE, \
+		.supply_name = _supply, \
+	} \
+
+static const struct regulator_desc stm32_pwr_desc[] = {
+	PWR_REG(PWR_REG11, "reg11", 1100000, REG_1_1_EN, "vdd"),
+	PWR_REG(PWR_REG18, "reg18", 1800000, REG_1_8_EN, "vdd"),
+	PWR_REG(PWR_USB33, "usb33", 3300000, USB_3_3_EN, "vdd_3v3_usbfs"),
+};
+
+static int stm32_pwr_regulator_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct stm32_pwr_reg *priv;
+	void __iomem *base;
+	struct regulator_dev *rdev;
+	struct regulator_config config = { };
+	int i, ret = 0;
+
+	base = of_iomap(np, 0);
+	if (IS_ERR(base)) {
+		dev_err(&pdev->dev, "Unable to map IO memory\n");
+		return PTR_ERR(base);
+	}
+
+	config.dev = &pdev->dev;
+
+	for (i = 0; i < STM32PWR_REG_NUM_REGS; i++) {
+		priv = devm_kzalloc(&pdev->dev, sizeof(struct stm32_pwr_reg),
+				    GFP_KERNEL);
+		if (!priv)
+			return -ENOMEM;
+		priv->base = base;
+		priv->desc = &stm32_pwr_desc[i];
+		priv->ready_mask = ready_mask_table[i];
+		config.driver_data = priv;
+
+		rdev = devm_regulator_register(&pdev->dev,
+					       &stm32_pwr_desc[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(&pdev->dev,
+				"Failed to register regulator: %d\n", ret);
+			break;
+		}
+	}
+	return ret;
+}
+
+static const struct of_device_id stm32_pwr_of_match[] = {
+	{ .compatible = "st,stm32mp1,pwr-reg", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_pwr_of_match);
+
+static struct platform_driver stm32_pwr_driver = {
+	.probe = stm32_pwr_regulator_probe,
+	.driver = {
+		.name  = "stm32-pwr-regulator",
+		.of_match_table = of_match_ptr(stm32_pwr_of_match),
+	},
+};
+module_platform_driver(stm32_pwr_driver);
+
+MODULE_DESCRIPTION("STM32MP1 PWR voltage regulator driver");
+MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

