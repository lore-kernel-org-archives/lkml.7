Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E796C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAB7208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNXCeH0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfFQPuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:50:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45238 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfFQPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:50:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id s21so6026427pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=swE05brVXtK4K444C06Ee7EjL8AS/Iz3XKQck7SeOkQ=;
        b=zNXCeH0d5MSZ48Szd4E1IfUmCprVMeRqZeqnCoGUphntbzXQcv3HkNPwo21TENmxrC
         gdO/l70dCXWO1c1OfgNP1+r5auTbIVulw210l8401N2uvETaZ20ncCY+abtvfzR032Re
         b6FDCsj6BEtSgDZ8rnQgJYEUS29/0tm/NSrQ0N/3WKs2KyUAs6Zvh9iWiGgllyY7nZ8T
         BvonxTtt9v75Ycglh2mPjYQd5IYmM/JNzuq46QthbwQNEeQ3dUKZiD6bHbYmyxuLzAXV
         bBOl1DaLeYyRbDP3e8t0mo7oU3ycmzKXYmQ6R4g5RiriIq9Au6a6Qskx10/V3D3wT3NR
         8RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=swE05brVXtK4K444C06Ee7EjL8AS/Iz3XKQck7SeOkQ=;
        b=i/khTjGyBjpzz8P7hCL4nfD2PZfswvNfpNyu/8WJnNl5+/RLz94/45MqFjp0vMukp+
         Mtu7wwtIRPq09X8VEGqxckoOG3MJbrJ/mO1rw7xQzNiYPP/WDu/T/mHUTnKLu8koRmIE
         1xLhYzFK0VvPx4PDgqGPU1misEzmumz81MYDlwmiB4MG+MUpiqTJRwoNYDBOcMCk/0NV
         VH0WCqCUTvF+z/ajLNXuDw00QLYL8lovFarFgbGebrN/kLr1RvY4osYMXtGFeTtHoQyv
         Uauiwyf3P45Cd0I+8QHHtMORzdL3qlQU90dN/PCmVaTerEpIPgjCuqesUyjNoavQGDx0
         rp1g==
X-Gm-Message-State: APjAAAXP+91cEeWJ6I+fkGHLnnp0OCVFviZCvBbdb8BuEDUX00GoIKJG
        cCm+QRSH291mlnceVi2JVV2f
X-Google-Smtp-Source: APXvYqx89pAIH8GhhHl6NdhdHnZHdylSi6cdOFfImompjIRRNJ8ZZbXHsBMxh0BRJQagdvTln+LMdA==
X-Received: by 2002:a17:90a:216f:: with SMTP id a102mr27370280pje.29.1560786648652;
        Mon, 17 Jun 2019 08:50:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:629b:c246:9431:2a24:7932:6dba])
        by smtp.gmail.com with ESMTPSA id n2sm11023603pff.104.2019.06.17.08.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:50:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     afaerber@suse.de, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/4] regulator: Add regulator driver for ATC260x PMICs
Date:   Mon, 17 Jun 2019 21:20:10 +0530
Message-Id: <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator driver for Actions Semi ATC260x PMICs. This driver
supports 5 DC-DC converters and 10 LDO regulators found in ATC2609A
PMIC variant.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/regulator/Kconfig             |   8 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/atc260x-regulator.c | 389 ++++++++++++++++++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 drivers/regulator/atc260x-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 8553bdf87c1d..acaf447ecdc6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -166,6 +166,14 @@ config REGULATOR_AS3722
 	  AS3722 PMIC. This will enable support for all the software
 	  controllable DCDC/LDO regulators.
 
+config REGULATOR_ATC260X
+	tristate "Actions Semi ATC260x PMIC Regulators"
+	depends on MFD_ATC260X
+	help
+	  This driver provides support for the voltage regulators on the
+	  ATC260x PMICs. This will enable support for all the software
+	  controllable DCDC/LDO regulators.
+
 config REGULATOR_AXP20X
 	tristate "X-POWERS AXP20X PMIC Regulators"
 	depends on MFD_AXP20X
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 93f53840e8f1..600d01d082a3 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_REGULATOR_ARIZONA_LDO1) += arizona-ldo1.o
 obj-$(CONFIG_REGULATOR_ARIZONA_MICSUPP) += arizona-micsupp.o
 obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
+obj-$(CONFIG_REGULATOR_ATC260X) += atc260x-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
 obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
 obj-$(CONFIG_REGULATOR_BD70528) += bd70528-regulator.o
diff --git a/drivers/regulator/atc260x-regulator.c b/drivers/regulator/atc260x-regulator.c
new file mode 100644
index 000000000000..e9e11f2567b2
--- /dev/null
+++ b/drivers/regulator/atc260x-regulator.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Regulator driver for ATC260x PMICs
+ *
+ * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/mfd/atc260x/core.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+#define ATC2609A_DCDC_VSEL_MASK 0xff00
+#define ATC2609A_DCDC_MIN_UV 600000
+#define ATC2609A_DCDC_UV_STEP 6250
+#define ATC2609A_DCDC_NR_VOLT 256
+
+#define ATC2609A_LDO_VSEL_MASK0 0x003c
+#define ATC2609A_LDO_VSEL_MASK1 0x001e
+#define ATC2609A_LDO_VSEL_MASK2 0xe000
+#define ATC2609A_LDO_VSEL_RANGE_MASK 0x0020
+
+static const struct regulator_linear_range atc260x_ldo_voltage_ranges0[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0, 15, 100000),
+	REGULATOR_LINEAR_RANGE(2100000, 16, 28, 100000),
+};
+
+static const struct regulator_linear_range atc260x_ldo_voltage_ranges1[] = {
+	REGULATOR_LINEAR_RANGE(850000, 0, 15, 100000),
+	REGULATOR_LINEAR_RANGE(2100000, 16, 27, 100000),
+};
+
+static const unsigned int atc260x_ldo_voltage_range_sel[] = {
+	0x0, 0x1,
+};
+
+static const struct regulator_linear_range atc260x_dcdc_voltage_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 127, 6250),
+	REGULATOR_LINEAR_RANGE(1400000, 128, 232, 25000),
+};
+
+static const struct regulator_ops atc260x_reg_ops = {
+	.enable	= regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+static const struct regulator_ops atc260x_reg_fixed_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+static const struct regulator_ops atc260x_reg_range0_ops = {
+	.enable	= regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
+};
+
+static const struct regulator_ops atc260x_reg_range1_ops = {
+	.enable	= regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+static const struct regulator_desc atc2609a_reg[] = {
+	{
+		.name = "DCDC_REG0",
+		.supply_name = "vcc0",
+		.of_match = of_match_ptr("DCDC_REG0"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_DCDC0,
+		.ops = &atc260x_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = ATC2609A_DCDC_MIN_UV,
+		.uV_step = ATC2609A_DCDC_UV_STEP,
+		.n_voltages = ATC2609A_DCDC_NR_VOLT,
+		.vsel_reg = ATC2609A_PMU_DC0_CTL0,
+		.vsel_mask = ATC2609A_DCDC_VSEL_MASK,
+		.enable_reg = ATC2609A_PMU_DC_OSC,
+		.enable_mask = BIT(4),
+		.enable_time = 800,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "DCDC_REG1",
+		.supply_name = "vcc1",
+		.of_match = of_match_ptr("DCDC_REG1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_DCDC1,
+		.ops = &atc260x_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = ATC2609A_DCDC_MIN_UV,
+		.uV_step = ATC2609A_DCDC_UV_STEP,
+		.n_voltages = ATC2609A_DCDC_NR_VOLT,
+		.vsel_reg = ATC2609A_PMU_DC1_CTL0,
+		.vsel_mask = ATC2609A_DCDC_VSEL_MASK,
+		.enable_reg = ATC2609A_PMU_DC_OSC,
+		.enable_mask = BIT(5),
+		.enable_time = 800,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "DCDC_REG2",
+		.supply_name = "vcc2",
+		.of_match = of_match_ptr("DCDC_REG2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_DCDC2,
+		.ops = &atc260x_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = ATC2609A_DCDC_MIN_UV,
+		.uV_step = ATC2609A_DCDC_UV_STEP,
+		.n_voltages = ATC2609A_DCDC_NR_VOLT,
+		.vsel_reg = ATC2609A_PMU_DC2_CTL0,
+		.vsel_mask = ATC2609A_DCDC_VSEL_MASK,
+		.enable_reg = ATC2609A_PMU_DC_OSC,
+		.enable_mask = BIT(6),
+		.enable_time = 800,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "DCDC_REG3",
+		.supply_name = "vcc3",
+		.of_match = of_match_ptr("DCDC_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_DCDC3,
+		.ops = &atc260x_reg_range1_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 233,
+		.linear_ranges = atc260x_dcdc_voltage_ranges,
+		.n_linear_ranges = ARRAY_SIZE(atc260x_dcdc_voltage_ranges),
+		.vsel_reg = ATC2609A_PMU_DC3_CTL0,
+		.vsel_mask = ATC2609A_DCDC_VSEL_MASK,
+		.enable_reg = ATC2609A_PMU_DC_OSC,
+		.enable_mask = BIT(7),
+		.enable_time = 800,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "DCDC_REG4",
+		.supply_name = "vcc4",
+		.of_match = of_match_ptr("DCDC_REG4"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_DCDC4,
+		.ops = &atc260x_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = ATC2609A_DCDC_MIN_UV,
+		.uV_step = ATC2609A_DCDC_UV_STEP,
+		.n_voltages = ATC2609A_DCDC_NR_VOLT,
+		.vsel_reg = ATC2609A_PMU_DC4_CTL0,
+		.vsel_mask = ATC2609A_DCDC_VSEL_MASK,
+		.enable_reg = ATC2609A_PMU_DC_OSC,
+		.enable_mask = BIT(8),
+		.enable_time = 800,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "LDO_REG0",
+		.supply_name = "vcc5",
+		.of_match = of_match_ptr("LDO_REG0"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_LDO0,
+		.ops = &atc260x_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 2300000,
+		.uV_step = 100000,
+		.n_voltages = 12,
+		.vsel_reg = ATC2609A_PMU_LDO0_CTL0,
+		.vsel_mask = ATC2609A_LDO_VSEL_MASK0,
+		.enable_reg = ATC2609A_PMU_LDO0_CTL0,
+		.enable_mask = BIT(0),
+		.enable_time = 2000,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "LDO_REG1",
+		.supply_name = "vcc6",
+		.of_match = of_match_ptr("LDO_REG1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_LDO1,
+		.ops = &atc260x_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 2300000,
+		.uV_step = 100000,
+		.n_voltages = 12,
+		.vsel_reg = ATC2609A_PMU_LDO1_CTL0,
+		.vsel_mask = ATC2609A_LDO_VSEL_MASK0,
+		.enable_reg = ATC2609A_PMU_LDO1_CTL0,
+		.enable_mask = BIT(0),
+		.enable_time = 2000,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "LDO_REG2",
+		.supply_name = "vcc7",
+		.of_match = of_match_ptr("LDO_REG2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_LDO2,
+		.ops = &atc260x_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 2300000,
+		.uV_step = 100000,
+		.n_voltages = 12,
+		.vsel_reg = ATC2609A_PMU_LDO2_CTL0,
+		.vsel_mask = ATC2609A_LDO_VSEL_MASK0,
+		.enable_reg = ATC2609A_PMU_LDO2_CTL0,
+		.enable_mask = BIT(0),
+		.enable_time = 2000,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "LDO_REG3",
+		.supply_name = "vcc8",
+		.of_match = of_match_ptr("LDO_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_LDO3,
+		.ops = &atc260x_reg_range0_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = atc260x_ldo_voltage_ranges0,
+		.n_linear_ranges = ARRAY_SIZE(atc260x_ldo_voltage_ranges0),
+		.vsel_reg = ATC2609A_PMU_LDO3_CTL0,
+		.vsel_mask = ATC2609A_LDO_VSEL_MASK1,
+		.vsel_range_reg = ATC2609A_PMU_LDO3_CTL0,
+		.vsel_range_mask = ATC2609A_LDO_VSEL_RANGE_MASK,
+		.linear_range_selectors = atc260x_ldo_voltage_range_sel,
+		.enable_reg = ATC2609A_PMU_LDO3_CTL0,
+		.enable_mask = BIT(0),
+		.enable_time = 2000,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "LDO_REG4",
+		.supply_name = "vcc9",
+		.of_match = of_match_ptr("LDO_REG4"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_LDO4,
+		.ops = &atc260x_reg_range0_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = atc260x_ldo_voltage_ranges0,
+		.n_linear_ranges = ARRAY_SIZE(atc260x_ldo_voltage_ranges0),
+		.vsel_reg = ATC2609A_PMU_LDO4_CTL0,
+		.vsel_mask = ATC2609A_LDO_VSEL_MASK1,
+		.vsel_range_reg = ATC2609A_PMU_LDO4_CTL0,
+		.vsel_range_mask = ATC2609A_LDO_VSEL_RANGE_MASK,
+		.linear_range_selectors = atc260x_ldo_voltage_range_sel,
+		.enable_reg = ATC2609A_PMU_LDO4_CTL0,
+		.enable_mask = BIT(0),
+		.enable_time = 2000,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "LDO_REG5",
+		.supply_name = "vcc10",
+		.of_match = of_match_ptr("LDO_REG5"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_LDO5,
+		.ops = &atc260x_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 700000,
+		.uV_step = 100000,
+		.n_voltages = 16,
+		.vsel_reg = ATC2609A_PMU_LDO5_CTL0,
+		.vsel_mask = ATC2609A_LDO_VSEL_MASK1,
+		.enable_reg = ATC2609A_PMU_LDO5_CTL0,
+		.enable_mask = BIT(0),
+		.enable_time = 2000,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "LDO_REG6",
+		.supply_name = "vcc11",
+		.of_match = of_match_ptr("LDO_REG6"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_LDO6,
+		.ops = &atc260x_reg_range0_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = atc260x_ldo_voltage_ranges1,
+		.n_linear_ranges = ARRAY_SIZE(atc260x_ldo_voltage_ranges1),
+		.vsel_reg = ATC2609A_PMU_LDO6_CTL0,
+		.vsel_mask = ATC2609A_LDO_VSEL_MASK1,
+		.vsel_range_reg = ATC2609A_PMU_LDO6_CTL0,
+		.vsel_range_mask = ATC2609A_LDO_VSEL_RANGE_MASK,
+		.linear_range_selectors = atc260x_ldo_voltage_range_sel,
+		.enable_reg = ATC2609A_PMU_LDO6_CTL0,
+		.enable_mask = BIT(0),
+		.enable_time = 2000,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "LDO_REG7",
+		.supply_name = "vcc12",
+		.of_match = of_match_ptr("LDO_REG7"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_LDO7,
+		.ops = &atc260x_reg_range0_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = atc260x_ldo_voltage_ranges0,
+		.n_linear_ranges = ARRAY_SIZE(atc260x_ldo_voltage_ranges0),
+		.vsel_reg = ATC2609A_PMU_LDO7_CTL0,
+		.vsel_mask = ATC2609A_LDO_VSEL_MASK1,
+		.vsel_range_reg = ATC2609A_PMU_LDO7_CTL0,
+		.vsel_range_mask = ATC2609A_LDO_VSEL_RANGE_MASK,
+		.linear_range_selectors = atc260x_ldo_voltage_range_sel,
+		.enable_reg = ATC2609A_PMU_LDO7_CTL0,
+		.enable_mask = BIT(0),
+		.enable_time = 2000,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "LDO_REG8",
+		.supply_name = "vcc13",
+		.of_match = of_match_ptr("LDO_REG8"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_LDO8,
+		.ops = &atc260x_reg_range0_ops,
+		.type = REGULATOR_VOLTAGE,
+		.linear_ranges = atc260x_ldo_voltage_ranges0,
+		.n_linear_ranges = ARRAY_SIZE(atc260x_ldo_voltage_ranges0),
+		.vsel_reg = ATC2609A_PMU_LDO8_CTL0,
+		.vsel_mask = ATC2609A_LDO_VSEL_MASK1,
+		.vsel_range_reg = ATC2609A_PMU_LDO8_CTL0,
+		.vsel_range_mask = ATC2609A_LDO_VSEL_RANGE_MASK,
+		.linear_range_selectors = atc260x_ldo_voltage_range_sel,
+		.enable_reg = ATC2609A_PMU_LDO8_CTL0,
+		.enable_mask = BIT(0),
+		.enable_time = 2000,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "LDO_REG9",
+		.supply_name = "vcc14",
+		.of_match = of_match_ptr("LDO_REG9"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = ATC2609A_ID_LDO9,
+		.ops = &atc260x_reg_fixed_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 2600000,
+		.uV_step = 100000,
+		.n_voltages = 8,
+		.vsel_reg = ATC2609A_PMU_LDO9_CTL,
+		.vsel_mask = ATC2609A_LDO_VSEL_MASK2,
+		.enable_time = 2000,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int atc260x_regulator_probe(struct platform_device *pdev)
+{
+	struct atc260x *atc260x = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = atc260x->dev;
+	struct regulator_config config = {};
+	struct regulator_dev *atc260x_rdev;
+	const struct regulator_desc *regulators;
+	int i, nregulators;
+
+	switch (atc260x->type) {
+	case ATC2609A:
+		regulators = atc2609a_reg;
+		nregulators = ATC2609A_ID_MAX;
+		break;
+	default:
+		dev_err(dev, "unsupported ATC260X ID %d\n", atc260x->type);
+		return -EINVAL;
+	}
+
+	config.dev = dev;
+	config.regmap = atc260x->regmap;
+
+	/* Instantiate the regulators */
+	for (i = 0; i < nregulators; i++) {
+		atc260x_rdev = devm_regulator_register(&pdev->dev,
+						       &regulators[i], &config);
+		if (IS_ERR(atc260x_rdev)) {
+			dev_err(dev, "failed to register regulator: %d\n", i);
+			return PTR_ERR(atc260x_rdev);
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver atc260x_regulator_driver = {
+	.probe = atc260x_regulator_probe,
+	.driver = {
+		.name = "atc260x-regulator"
+	},
+};
+
+module_platform_driver(atc260x_regulator_driver);
+
+MODULE_DESCRIPTION("Regulator driver for ATC260x PMICs");
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

