Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D96C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4400F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsDB1jjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfLSKhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:37:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40924 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSKhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:37:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so5051835wmi.5;
        Thu, 19 Dec 2019 02:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1gB7iNnQFJCsuG/WvNcC+2Q53m+FzSu0DP4obvOCjJI=;
        b=HsDB1jjv79Qvbzj4sVbmpKE2s+6x0BkFB2HWAegnySqf4wDotcps1mlM6OWLKCgm8h
         2FipPs05oNYG2/WCVecCfBiLF7rdjMvn5kZsTN8YsGVlb8taqN5WFls94294fRVopkzM
         uWSzenNVFCwcgCQotPpTc7oSh3JIklhnP/bmP4GVoOjHIKZUEblp51zikqJX46Wyknm3
         TlMd3ajVU64fUtW543BJPXv31Fho3MIuYPhcCE7KWJowURhbhU2jR3GdtgnSBqg0/UO4
         FSFoYUmdmiS/Dt4L0+HPVgw18KugoZkvzsPebVtLH9vcjKIBktiohD75cTFpYYQ2FT2O
         XyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1gB7iNnQFJCsuG/WvNcC+2Q53m+FzSu0DP4obvOCjJI=;
        b=SPn+Vb7lY+A72yky4mUDN+95ZHsb5kTdILDbHUc6tQiiaAtCoH6F3RvSKNM/q18hf5
         KGZtx+O++yNI0baePfZf/LDu7KMe840KGPuxl1sjXsOT4tBikaVAjhcrGPMzuq6X3wC+
         Sks9TNzzS4M9LNDWD+vLtjsfooZ7GDh49nUBMrlKhOEnUgpTn3XIGvvT/7GK4w74jXWM
         9hFdKJIBZQjND7U5HOjqGATMTAmiybHfOh9h8h/uUPmgwVI2tYtwc6bmNl9T/Qvvuve+
         Jc0TmxkFegSk5ImhpQeM37pySQwWdpXr66uGj9XuOVxo3eUGJjEZX3wVpy9Tvw/b7vYC
         H8AA==
X-Gm-Message-State: APjAAAVOLogPKBE6CtG6N/aI+CrtCnUlsoCk2F6tdJmakSixXKvbauTt
        h64iJ/VJRSWD2MTterXQYTaD1vZm9RI=
X-Google-Smtp-Source: APXvYqwE7X4zrw/Gd+azl43Ae2QvA/0UG/Z84gw/s4wBvZBkFFCfPXpUZjTrJ8oBZ/+xWFVIpeQxjg==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr9529780wmj.54.1576751853979;
        Thu, 19 Dec 2019 02:37:33 -0800 (PST)
Received: from localhost.localdomain (p5B3F677C.dip0.t-ipconnect.de. [91.63.103.124])
        by smtp.gmail.com with ESMTPSA id c68sm5735147wme.13.2019.12.19.02.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 02:37:33 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        heiko@sntech.de, shawnguo@kernel.org,
        laurent.pinchart@ideasonboard.com, icenowy@aosc.io,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/4] regulator: mpq7920: add mpq7920 regulator driver
Date:   Thu, 19 Dec 2019 11:37:20 +0100
Message-Id: <20191219103721.10935-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219103721.10935-1-sravanhome@gmail.com>
References: <20191219103721.10935-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding regulator driver for the device mpq7920.
The MPQ7920 PMIC device contains four DC-DC buck converters and
five regulators, is designed for automotive and accessed over I2C.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/regulator/Kconfig   |  10 +
 drivers/regulator/Makefile  |   1 +
 drivers/regulator/mpq7920.c | 376 ++++++++++++++++++++++++++++++++++++
 drivers/regulator/mpq7920.h |  72 +++++++
 4 files changed, 459 insertions(+)
 create mode 100644 drivers/regulator/mpq7920.c
 create mode 100644 drivers/regulator/mpq7920.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 74eb5af7295f..e10adc2e57da 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -600,6 +600,16 @@ config REGULATOR_MCP16502
 	  through the regulator interface. In addition it enables
 	  suspend-to-ram/standby transition.
 
+config REGULATOR_MPQ7920
+	tristate "Monolithic MPQ7920 PMIC"
+	depends on I2C && OF
+	select REGMAP_I2C
+	help
+	  Say y here to support the MPQ7920 PMIC. This will enable supports
+	  the software controllable 4 buck and 5 LDO regulators.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_MT6311
 	tristate "MediaTek MT6311 PMIC"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 2210ba56f9bd..fd11002507e4 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
 obj-$(CONFIG_REGULATOR_MCP16502) += mcp16502.o
+obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
new file mode 100644
index 000000000000..6c56183e654e
--- /dev/null
+++ b/drivers/regulator/mpq7920.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * mpq7920.c  -  mps mpq7920
+ *
+ * Copyright 2019 Monolithic Power Systems, Inc
+ *
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include "mpq7920.h"
+
+#define MPQ7920_BUCK_VOLT_RANGE \
+	((MPQ7920_VOLT_MAX - MPQ7920_BUCK_VOLT_MIN)/MPQ7920_VOLT_STEP + 1)
+#define MPQ7920_LDO_VOLT_RANGE \
+	((MPQ7920_VOLT_MAX - MPQ7920_LDO_VOLT_MIN)/MPQ7920_VOLT_STEP + 1)
+
+#define MPQ7920BUCK(_name, _id, _ilim)					\
+	[MPQ7920_BUCK ## _id] = {					\
+		.id = MPQ7920_BUCK ## _id,				\
+		.name = _name,						\
+		.ops = &mpq7920_buck_ops,				\
+		.min_uV = MPQ7920_BUCK_VOLT_MIN,			\
+		.uV_step = MPQ7920_VOLT_STEP,				\
+		.n_voltages = MPQ7920_BUCK_VOLT_RANGE,			\
+		.curr_table = _ilim,					\
+		.n_current_limits = ARRAY_SIZE(_ilim),			\
+		.csel_reg = MPQ7920_BUCK ##_id## _REG_C,		\
+		.csel_mask = MPQ7920_MASK_BUCK_ILIM,			\
+		.enable_reg = MPQ7920_REG_REGULATOR_EN,			\
+		.enable_mask = BIT(MPQ7920_REGULATOR_EN_OFFSET -	\
+					 MPQ7920_BUCK ## _id),		\
+		.vsel_reg = MPQ7920_BUCK ##_id## _REG_A,		\
+		.vsel_mask = MPQ7920_MASK_VREF,				\
+		.active_discharge_on	= MPQ7920_DISCHARGE_ON,		\
+		.active_discharge_reg	= MPQ7920_BUCK ##_id## _REG_B,	\
+		.active_discharge_mask	= MPQ7920_MASK_DISCHARGE,	\
+		.soft_start_reg		= MPQ7920_BUCK ##_id## _REG_C,	\
+		.soft_start_mask	= MPQ7920_MASK_SOFTSTART,	\
+		.owner			= THIS_MODULE,			\
+	}
+
+#define MPQ7920LDO(_name, _id, _ops, _ilim, _ilim_sz, _creg, _cmask)	\
+	[MPQ7920_LDO ## _id] = {					\
+		.id = MPQ7920_LDO ## _id,				\
+		.name = _name,						\
+		.ops = _ops,						\
+		.min_uV = MPQ7920_LDO_VOLT_MIN,				\
+		.uV_step = MPQ7920_VOLT_STEP,				\
+		.n_voltages = MPQ7920_LDO_VOLT_RANGE,			\
+		.vsel_reg = MPQ7920_LDO ##_id## _REG_A,			\
+		.vsel_mask = MPQ7920_MASK_VREF,				\
+		.curr_table = _ilim,					\
+		.n_current_limits = _ilim_sz,				\
+		.csel_reg = _creg,					\
+		.csel_mask = _cmask,					\
+		.enable_reg = (_id == 1) ? 0 : MPQ7920_REG_REGULATOR_EN,\
+		.enable_mask = BIT(MPQ7920_REGULATOR_EN_OFFSET -	\
+					MPQ7920_LDO ##_id + 1),		\
+		.active_discharge_on	= MPQ7920_DISCHARGE_ON,		\
+		.active_discharge_mask	= MPQ7920_MASK_DISCHARGE,	\
+		.active_discharge_reg	= MPQ7920_LDO ##_id## _REG_B,	\
+		.type			= REGULATOR_VOLTAGE,		\
+		.owner			= THIS_MODULE,			\
+	}
+
+enum mpq7920_regulators {
+	MPQ7920_BUCK1,
+	MPQ7920_BUCK2,
+	MPQ7920_BUCK3,
+	MPQ7920_BUCK4,
+	MPQ7920_LDO1, /* LDORTC */
+	MPQ7920_LDO2,
+	MPQ7920_LDO3,
+	MPQ7920_LDO4,
+	MPQ7920_LDO5,
+	MPQ7920_MAX_REGULATORS,
+};
+
+struct mpq7920_regulator_info {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator_dev *rdev[MPQ7920_MAX_REGULATORS];
+	struct regulator_desc *rdesc;
+};
+
+static const struct regmap_config mpq7920_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x25,
+};
+
+/* Current limits array (in uA)
+ * ILIM1 & ILIM3
+ */
+static const unsigned int mpq7920_I_limits1[] = {
+	4600000, 6600000, 7600000, 9300000
+};
+
+/* ILIM2 & ILIM4 */
+static const unsigned int mpq7920_I_limits2[] = {
+	2700000, 3900000, 5100000, 6100000
+};
+
+/* LDO4 & LDO5 */
+static const unsigned int mpq7920_I_limits3[] = {
+	300000, 700000
+};
+
+static int mpq7920_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay);
+
+/* RTCLDO not controllable, always ON */
+static const struct regulator_ops mpq7920_ldortc_ops = {
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+};
+
+static const struct regulator_ops mpq7920_ldo_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+};
+
+static const struct regulator_ops mpq7920_buck_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+	.set_soft_start		= regulator_set_soft_start_regmap,
+	.set_ramp_delay		= mpq7920_set_ramp_delay,
+};
+
+static struct regulator_desc mpq7920_regulators_desc[MPQ7920_MAX_REGULATORS] = {
+	MPQ7920BUCK("buck1", 1, mpq7920_I_limits1),
+	MPQ7920BUCK("buck2", 2, mpq7920_I_limits2),
+	MPQ7920BUCK("buck3", 3, mpq7920_I_limits1),
+	MPQ7920BUCK("buck4", 4, mpq7920_I_limits2),
+	MPQ7920LDO("ldortc", 1, &mpq7920_ldortc_ops, NULL, 0, 0, 0),
+	MPQ7920LDO("ldo2", 2, &mpq7920_ldo_ops, NULL, 0, 0, 0),
+	MPQ7920LDO("ldo3", 3, &mpq7920_ldo_ops, NULL, 0, 0, 0),
+	MPQ7920LDO("ldo4", 4, &mpq7920_ldo_ops, mpq7920_I_limits3,
+			ARRAY_SIZE(mpq7920_I_limits3), MPQ7920_LDO4_REG_B,
+			MPQ7920_MASK_LDO_ILIM),
+	MPQ7920LDO("ldo5", 5, &mpq7920_ldo_ops, mpq7920_I_limits3,
+			ARRAY_SIZE(mpq7920_I_limits3), MPQ7920_LDO5_REG_B,
+			MPQ7920_MASK_LDO_ILIM),
+};
+
+/*
+ * DVS ramp rate BUCK1 to BUCK4
+ * 00-01: Reserved
+ * 10: 8mV/us
+ * 11: 4mV/us
+ */
+static int mpq7920_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	unsigned int ramp_val = (ramp_delay <= 4000) ? 3 : 2;
+
+	return regmap_update_bits(rdev->regmap, MPQ7920_REG_CTL0,
+				  MPQ7920_MASK_DVS_SLEWRATE, ramp_val << 6);
+}
+
+static void mpq7920_parse_dt(struct device *dev,
+			 struct mpq7920_regulator_info *info)
+{
+	int ret, i;
+	struct device_node *np = dev->of_node;
+	uint8_t freq;
+	uint8_t time_slot;
+	uint8_t val[MPQ7920_BUCK4 + 1];
+	uint8_t var_time[MPQ7920_LDO5];
+	bool is_fixed_on_time = 0;
+	bool is_fixed_off_time = 0;
+
+	is_fixed_on_time = of_property_read_bool(np, "mps,fixed-on-time");
+	is_fixed_off_time = of_property_read_bool(np, "mps,fixed-off-time");
+	if (is_fixed_on_time || is_fixed_off_time) {
+		regmap_update_bits(info->regmap, MPQ7920_REG_CTL2,
+				MPQ7920_MASK_FIXED_TIME_SLOT,
+				~(is_fixed_on_time << 1 | is_fixed_off_time));
+	}
+
+	ret = of_property_read_u8(np, "mps,time-slot", &time_slot);
+	if (!ret) {
+		regmap_update_bits(info->regmap, MPQ7920_REG_CTL2,
+					MPQ7920_MASK_TIME_SLOT,
+					(time_slot & 3) << 2);
+	}
+
+	if (!is_fixed_on_time &&
+	    !of_property_read_u8_array(np, "mps,inc-on-time", var_time,
+					ARRAY_SIZE(var_time))) {
+
+		for (i = 0; i < MPQ7920_LDO5; i++) {
+			if (i <= MPQ7920_BUCK4) {
+				regmap_update_bits(info->regmap,
+					MPQ7920_BUCK1_REG_D + (i * 4),
+					MPQ7920_MASK_ON_TIME_SLOT,
+					var_time[i] & 0xF);
+			} else {
+				regmap_update_bits(info->regmap,
+					(MPQ7920_LDO2_REG_C +
+						((i - MPQ7920_LDO1) * 3)),
+					MPQ7920_MASK_ON_TIME_SLOT,
+					var_time[i] & 0xF);
+			}
+		}
+	}
+
+	if (!is_fixed_off_time &&
+	    !of_property_read_u8_array(np, "mps,inc-off-time", var_time,
+					ARRAY_SIZE(var_time))) {
+
+		for (i = 0; i < MPQ7920_LDO5; i++) {
+			if (i <= MPQ7920_BUCK4) {
+				regmap_update_bits(info->regmap,
+					MPQ7920_BUCK1_REG_D + (i * 4),
+					MPQ7920_MASK_OFF_TIME_SLOT,
+					(var_time[i] & 0xF) << 4);
+			} else {
+				regmap_update_bits(info->regmap,
+					(MPQ7920_LDO2_REG_C +
+						((i - MPQ7920_LDO1) * 3)),
+					MPQ7920_MASK_OFF_TIME_SLOT,
+					(var_time[i] & 0xF) << 4);
+			}
+		}
+	}
+
+	ret = of_property_read_u8_array(np, "mps,buck-softstart", val,
+					ARRAY_SIZE(val));
+	if (!ret) {
+		for (i = 0; i < ARRAY_SIZE(val); i++)
+			info->rdesc[i].soft_start_val_on = (val[i] & 3) << 2;
+	}
+
+	ret = of_property_read_u8_array(np, "mps,buck-ovp", val,
+					ARRAY_SIZE(val));
+	if (!ret) {
+		for (i = 0; i <= MPQ7920_BUCK4; i++) {
+			regmap_update_bits(info->regmap,
+					MPQ7920_BUCK1_REG_B + (i * 4),
+					BIT(6), val[i] << 6);
+		}
+	}
+
+	ret = of_property_read_u8_array(np, "mps,buck-phase-delay", val,
+					ARRAY_SIZE(val));
+	if (!ret) {
+		for (i = 0; i <= MPQ7920_BUCK4; i++) {
+			regmap_update_bits(info->regmap,
+					MPQ7920_BUCK1_REG_C + (i * 4),
+					MPQ7920_MASK_BUCK_PHASE_DEALY,
+					(val[i] & 3) << 4);
+		}
+	}
+
+	ret = of_property_read_u8(np, "mps,switch-freq", &freq);
+	if (!ret) {
+		regmap_update_bits(info->regmap, MPQ7920_REG_CTL0,
+					MPQ7920_MASK_SWITCH_FREQ,
+					(freq & 3) << 4);
+	}
+}
+
+static int mpq7920_regulator_register(struct mpq7920_regulator_info *info,
+				struct regulator_config *config)
+{
+	int i;
+	struct regulator_desc *rdesc;
+	struct regulator_ops *ops;
+
+	for (i = 0; i < MPQ7920_MAX_REGULATORS; i++) {
+		rdesc = &info->rdesc[i];
+		ops = rdesc->ops;
+		if (rdesc->curr_table) {
+			ops->get_current_limit =
+				regulator_get_current_limit_regmap;
+			ops->set_current_limit =
+				regulator_set_current_limit_regmap;
+		}
+
+		info->rdev[i] = devm_regulator_register(info->dev, rdesc,
+					 config);
+		if (IS_ERR(info->rdev))
+			return PTR_ERR(info->rdev);
+	}
+
+	return 0;
+}
+
+static int mpq7920_i2c_probe(struct i2c_client *client,
+				    const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct mpq7920_regulator_info *info;
+	struct regulator_config config = { 0 };
+	struct regmap *regmap;
+	int ret;
+
+	info = devm_kzalloc(dev, sizeof(struct mpq7920_regulator_info),
+				GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->dev = dev;
+	info->rdesc = mpq7920_regulators_desc;
+	regmap = devm_regmap_init_i2c(client, &mpq7920_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(regmap);
+	}
+
+	i2c_set_clientdata(client, info);
+	info->regmap = regmap;
+	if (client->dev.of_node)
+		mpq7920_parse_dt(&client->dev, info);
+
+	config.dev = info->dev;
+	config.regmap = regmap;
+	config.driver_data = info;
+
+	ret = mpq7920_regulator_register(info, &config);
+	if (ret < 0)
+		dev_err(dev, "Failed to register regulator!\n");
+
+	return ret;
+}
+
+static const struct of_device_id mpq7920_of_match[] = {
+	{ .compatible = "mps,mpq7920"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpq7920_of_match);
+
+static const struct i2c_device_id mpq7920_id[] = {
+	{ "mpq7920", },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, mpq7920_id);
+
+static struct i2c_driver mpq7920_regulator_driver = {
+	.driver = {
+		.name = "mpq7920",
+		.of_match_table = of_match_ptr(mpq7920_of_match),
+	},
+	.probe = mpq7920_i2c_probe,
+	.id_table = mpq7920_id,
+};
+module_i2c_driver(mpq7920_regulator_driver);
+
+MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
+MODULE_DESCRIPTION("MPQ7920 PMIC regulator driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/mpq7920.h b/drivers/regulator/mpq7920.h
new file mode 100644
index 000000000000..58c64e708f2e
--- /dev/null
+++ b/drivers/regulator/mpq7920.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * mpq7920.h  -  Regulator definitions for mpq7920
+ *
+ * Copyright 2019 Monolithic Power Systems, Inc
+ *
+ */
+
+#ifndef __MPQ7920_H__
+#define __MPQ7920_H__
+
+#define MPQ7920_REG_CTL0		0x00
+#define MPQ7920_REG_CTL1		0x01
+#define MPQ7920_REG_CTL2		0x02
+#define MPQ7920_BUCK1_REG_A		0x03
+#define MPQ7920_BUCK1_REG_B		0x04
+#define MPQ7920_BUCK1_REG_C		0x05
+#define MPQ7920_BUCK1_REG_D		0x06
+#define MPQ7920_BUCK2_REG_A		0x07
+#define MPQ7920_BUCK2_REG_B		0x08
+#define MPQ7920_BUCK2_REG_C		0x09
+#define MPQ7920_BUCK2_REG_D		0x0a
+#define MPQ7920_BUCK3_REG_A		0x0b
+#define MPQ7920_BUCK3_REG_B		0x0c
+#define MPQ7920_BUCK3_REG_C		0x0d
+#define MPQ7920_BUCK3_REG_D		0x0e
+#define MPQ7920_BUCK4_REG_A		0x0f
+#define MPQ7920_BUCK4_REG_B		0x10
+#define MPQ7920_BUCK4_REG_C		0x11
+#define MPQ7920_BUCK4_REG_D		0x12
+#define MPQ7920_LDO1_REG_A		0x13
+#define MPQ7920_LDO1_REG_B		0x0
+#define MPQ7920_LDO2_REG_A		0x14
+#define MPQ7920_LDO2_REG_B		0x15
+#define MPQ7920_LDO2_REG_C		0x16
+#define MPQ7920_LDO3_REG_A		0x17
+#define MPQ7920_LDO3_REG_B		0x18
+#define MPQ7920_LDO3_REG_C		0x19
+#define MPQ7920_LDO4_REG_A		0x1a
+#define MPQ7920_LDO4_REG_B		0x1b
+#define MPQ7920_LDO4_REG_C		0x1c
+#define MPQ7920_LDO5_REG_A		0x1d
+#define MPQ7920_LDO5_REG_B		0x1e
+#define MPQ7920_LDO5_REG_C		0x1f
+#define MPQ7920_REG_MODE		0x20
+#define MPQ7920_REG_REGULATOR_EN1	0x22
+#define MPQ7920_REG_REGULATOR_EN	0x22
+
+#define MPQ7920_MASK_VREF		0x7f
+#define MPQ7920_MASK_BUCK_ILIM		0xd0
+#define MPQ7920_MASK_LDO_ILIM		BIT(6)
+#define MPQ7920_MASK_DISCHARGE		BIT(5)
+#define MPQ7920_MASK_MODE		0xc0
+#define MPQ7920_MASK_SOFTSTART		0x0c
+#define MPQ7920_MASK_SWITCH_FREQ	0x30
+#define MPQ7920_MASK_BUCK_PHASE_DEALY	0x30
+#define MPQ7920_MASK_DVS_SLEWRATE	0xc0
+#define MPQ7920_MASK_TIME_SLOT		0x06
+#define MPQ7920_MASK_FIXED_TIME_SLOT	0x03
+#define MPQ7920_MASK_ON_TIME_SLOT	0x0F
+#define MPQ7920_MASK_OFF_TIME_SLOT	0xF0
+#define MPQ7920_DISCHARGE_ON		0x1
+
+#define MPQ7920_REGULATOR_EN_OFFSET	7
+
+/* values in mV */
+#define MPQ7920_BUCK_VOLT_MIN		400000
+#define MPQ7920_LDO_VOLT_MIN		650000
+#define MPQ7920_VOLT_MAX		3587500
+#define MPQ7920_VOLT_STEP		12500
+
+#endif /* __MPQ7920_H__ */
-- 
2.17.1

