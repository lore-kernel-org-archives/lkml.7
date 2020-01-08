Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4423C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8C024679
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578499148;
	bh=sNYdg3a7Nx/ykfpjfUG2VmUw6tyVA1RT6Zlkiw8N0Ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=0PmWpGbRMtPWseDjz0nrdpwxP0bT8oiCI+S8zfyKN8WHEWXxGxPu87r9DCzOZSb9m
	 iEBPwLMvFleKLEamolK4jk6KlWE1lNsYaeyuuKmF97k/ib9O8TjOktrmiHvANY7PJl
	 WHQNmDx/+4DBy2n2gq2Rs/lr5XvfSeyFPhjMUkuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgAHP7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:59:07 -0500
Received: from foss.arm.com ([217.140.110.172]:46678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbgAHP7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92E9EDA7;
        Wed,  8 Jan 2020 07:59:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A67F3F534;
        Wed,  8 Jan 2020 07:59:02 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:59:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "regulator: mp8859: add driver" to the regulator tree
In-Reply-To: <20200106211633.2882-2-m.reichl@fivetechno.de>
Message-Id: <applied-20200106211633.2882-2-m.reichl@fivetechno.de>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mp8859: add driver

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

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

From 4444a1c10069e2f371fa497ba22feafafed5aada Mon Sep 17 00:00:00 2001
From: Markus Reichl <m.reichl@fivetechno.de>
Date: Mon, 6 Jan 2020 22:16:24 +0100
Subject: [PATCH] regulator: mp8859: add driver

The MP8859 from Monolithic Power Systems is a single output DC/DC
converter. The voltage can be controlled via I2C.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
Link: https://lore.kernel.org/r/20200106211633.2882-2-m.reichl@fivetechno.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp8859.c | 156 +++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 drivers/regulator/mp8859.c

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
new file mode 100644
index 000000000000..e804a5267301
--- /dev/null
+++ b/drivers/regulator/mp8859.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2019 five technologies GmbH
+// Author: Markus Reichl <m.reichl@fivetechno.de>
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/regulator/driver.h>
+#include <linux/regmap.h>
+
+
+#define VOL_MIN_IDX			0x00
+#define VOL_MAX_IDX			0x7ff
+
+/* Register definitions */
+#define MP8859_VOUT_L_REG		0    //3 lo Bits
+#define MP8859_VOUT_H_REG		1    //8 hi Bits
+#define MP8859_VOUT_GO_REG		2
+#define MP8859_IOUT_LIM_REG		3
+#define MP8859_CTL1_REG			4
+#define MP8859_CTL2_REG			5
+#define MP8859_RESERVED1_REG		6
+#define MP8859_RESERVED2_REG		7
+#define MP8859_RESERVED3_REG		8
+#define MP8859_STATUS_REG		9
+#define MP8859_INTERRUPT_REG		0x0A
+#define MP8859_MASK_REG			0x0B
+#define MP8859_ID1_REG			0x0C
+#define MP8859_MFR_ID_REG		0x27
+#define MP8859_DEV_ID_REG		0x28
+#define MP8859_IC_REV_REG		0x29
+
+#define MP8859_MAX_REG			0x29
+
+#define MP8859_GO_BIT			0x01
+
+
+static int mp8859_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	int ret;
+
+	ret = regmap_write(rdev->regmap, MP8859_VOUT_L_REG, sel & 0x7);
+
+	if (ret)
+		return ret;
+	ret = regmap_write(rdev->regmap, MP8859_VOUT_H_REG, sel >> 3);
+
+	if (ret)
+		return ret;
+	ret = regmap_update_bits(rdev->regmap, MP8859_VOUT_GO_REG,
+					MP8859_GO_BIT, 1);
+	return ret;
+}
+
+static int mp8859_get_voltage_sel(struct regulator_dev *rdev)
+{
+	unsigned int val_tmp;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MP8859_VOUT_H_REG, &val_tmp);
+
+	if (ret)
+		return ret;
+	val = val_tmp << 3;
+
+	ret = regmap_read(rdev->regmap, MP8859_VOUT_L_REG, &val_tmp);
+
+	if (ret)
+		return ret;
+	val |= val_tmp & 0x07;
+	return val;
+}
+
+static const struct regulator_linear_range mp8859_dcdc_ranges[] = {
+	REGULATOR_LINEAR_RANGE(0, VOL_MIN_IDX, VOL_MAX_IDX, 10000),
+};
+
+static const struct regmap_config mp8859_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MP8859_MAX_REG,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct regulator_ops mp8859_ops = {
+	.set_voltage_sel = mp8859_set_voltage_sel,
+	.get_voltage_sel = mp8859_get_voltage_sel,
+	.list_voltage = regulator_list_voltage_linear_range,
+};
+
+static const struct regulator_desc mp8859_regulators[] = {
+	{
+		.id = 0,
+		.type = REGULATOR_VOLTAGE,
+		.name = "mp8859_dcdc",
+		.of_match = of_match_ptr("mp8859_dcdc"),
+		.n_voltages = VOL_MAX_IDX + 1,
+		.linear_ranges = mp8859_dcdc_ranges,
+		.n_linear_ranges = 1,
+		.ops = &mp8859_ops,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int mp8859_i2c_probe(struct i2c_client *i2c)
+{
+	int ret;
+	struct regulator_config config = {.dev = &i2c->dev};
+	struct regmap *regmap = devm_regmap_init_i2c(i2c, &mp8859_regmap);
+	struct regulator_dev *rdev;
+
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+	rdev = devm_regulator_register(&i2c->dev, &mp8859_regulators[0],
+					&config);
+
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
+		dev_err(&i2c->dev, "failed to register %s: %d\n",
+			mp8859_regulators[0].name, ret);
+			return ret;
+		}
+	return 0;
+}
+
+static const struct of_device_id mp8859_dt_id[] = {
+	{.compatible =  "mps,mp8859"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mp8859_dt_id);
+
+static const struct i2c_device_id mp8859_i2c_id[] = {
+	{ "mp8859", },
+	{  },
+};
+MODULE_DEVICE_TABLE(i2c, mp8859_i2c_id);
+
+static struct i2c_driver mp8859_regulator_driver = {
+	.driver = {
+		.name = "mp8859",
+		.of_match_table = of_match_ptr(mp8859_dt_id),
+	},
+	.probe_new = mp8859_i2c_probe,
+	.id_table = mp8859_i2c_id,
+};
+
+module_i2c_driver(mp8859_regulator_driver);
+
+MODULE_DESCRIPTION("Monolithic Power Systems MP8859 voltage regulator driver");
+MODULE_AUTHOR("Markus Reichl <m.reichl@fivetechno.de>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

