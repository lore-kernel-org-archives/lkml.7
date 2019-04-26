Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E650C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B565206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271775;
	bh=MUsu6C1AXJJT/dQqOs+c3R8t7raMG7RgWXRWpNtu3Wc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=grZsap6lSbsWvzm6Urjw1bhgFQMe39M+6OzBLzBIzVAsFYI3YQuoc9Xm3Gt/8eMlY
	 JMepQI2v9AAMdxRCLrdMMVA4k+vRjEtQNfg8sJClNj1PvDnM1eYNIuLLe5W6+Cw/BF
	 xWRyX0mliqy/2zre8SySQRyom9Tw40+Driw8AWJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDZJmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:42:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46508 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfDZJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=F7qc4KdXvf3X60KnwA5iF+EUj+YRQK9anyM7spbXra0=; b=nLlEZQPwLEsm
        kQy7Jd2HUVPz9jJ8Wds6t/mO7tqSkuQB9iewHcH78kb8YEvmd7OUAd+lOfnEgPuy28cYEQbw+D9Y8
        8KNvvmx/wOdmTumAriiDTMpiIX3zrTjxMCOyfmBoYvY1WZuROV/nnLVK0T0Kmnm6HblA4tRJC8NwW
        5EC8Q=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxLg-0003KT-AO; Fri, 26 Apr 2019 09:40:52 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 47DCB441D3B; Fri, 26 Apr 2019 10:40:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max8998: Factor out struct voltage_map_desc" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094051.47DCB441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8998: Factor out struct voltage_map_desc

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

From 0dceab33342d279130252b7c587142a7252a9324 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 14 Apr 2019 20:48:18 +0800
Subject: [PATCH] regulator: max8998: Factor out struct voltage_map_desc

The struct voltage_map_desc is used for storing min/max/step fileds, and
then setup the min_uV, uV_step and n_voltages fields for regulator_desc.
Introduce MAX8998_LINEAR_REG/MAX8998_OTHERS_REG macro to setup these filds
directly in regulator_desc to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8998.c | 294 +++++++-----------------------------
 1 file changed, 56 insertions(+), 238 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 43b69ebd086b..60599c3bb845 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -33,72 +33,6 @@ struct max8998_data {
 	unsigned int		buck2_idx;
 };
 
-struct voltage_map_desc {
-	int min;
-	int max;
-	int step;
-};
-
-/* Voltage maps in uV*/
-static const struct voltage_map_desc ldo23_voltage_map_desc = {
-	.min = 800000,	.step = 50000,	.max = 1300000,
-};
-static const struct voltage_map_desc ldo456711_voltage_map_desc = {
-	.min = 1600000,	.step = 100000,	.max = 3600000,
-};
-static const struct voltage_map_desc ldo8_voltage_map_desc = {
-	.min = 3000000,	.step = 100000,	.max = 3600000,
-};
-static const struct voltage_map_desc ldo9_voltage_map_desc = {
-	.min = 2800000,	.step = 100000,	.max = 3100000,
-};
-static const struct voltage_map_desc ldo10_voltage_map_desc = {
-	.min = 950000,	.step = 50000,	.max = 1300000,
-};
-static const struct voltage_map_desc ldo1213_voltage_map_desc = {
-	.min = 800000,	.step = 100000,	.max = 3300000,
-};
-static const struct voltage_map_desc ldo1415_voltage_map_desc = {
-	.min = 1200000,	.step = 100000,	.max = 3300000,
-};
-static const struct voltage_map_desc ldo1617_voltage_map_desc = {
-	.min = 1600000,	.step = 100000,	.max = 3600000,
-};
-static const struct voltage_map_desc buck12_voltage_map_desc = {
-	.min = 750000,	.step = 25000,	.max = 1525000,
-};
-static const struct voltage_map_desc buck3_voltage_map_desc = {
-	.min = 1600000,	.step = 100000,	.max = 3600000,
-};
-static const struct voltage_map_desc buck4_voltage_map_desc = {
-	.min = 800000,	.step = 100000,	.max = 2300000,
-};
-
-static const struct voltage_map_desc *ldo_voltage_map[] = {
-	NULL,
-	NULL,
-	&ldo23_voltage_map_desc,	/* LDO2 */
-	&ldo23_voltage_map_desc,	/* LDO3 */
-	&ldo456711_voltage_map_desc,	/* LDO4 */
-	&ldo456711_voltage_map_desc,	/* LDO5 */
-	&ldo456711_voltage_map_desc,	/* LDO6 */
-	&ldo456711_voltage_map_desc,	/* LDO7 */
-	&ldo8_voltage_map_desc,		/* LDO8 */
-	&ldo9_voltage_map_desc,		/* LDO9 */
-	&ldo10_voltage_map_desc,	/* LDO10 */
-	&ldo456711_voltage_map_desc,	/* LDO11 */
-	&ldo1213_voltage_map_desc,	/* LDO12 */
-	&ldo1213_voltage_map_desc,	/* LDO13 */
-	&ldo1415_voltage_map_desc,	/* LDO14 */
-	&ldo1415_voltage_map_desc,	/* LDO15 */
-	&ldo1617_voltage_map_desc,	/* LDO16 */
-	&ldo1617_voltage_map_desc,	/* LDO17 */
-	&buck12_voltage_map_desc,	/* BUCK1 */
-	&buck12_voltage_map_desc,	/* BUCK2 */
-	&buck3_voltage_map_desc,	/* BUCK3 */
-	&buck4_voltage_map_desc,	/* BUCK4 */
-};
-
 static int max8998_get_enable_register(struct regulator_dev *rdev,
 					int *reg, int *shift)
 {
@@ -400,7 +334,6 @@ static int max8998_set_voltage_buck_time_sel(struct regulator_dev *rdev,
 {
 	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
 	struct i2c_client *i2c = max8998->iodev->i2c;
-	const struct voltage_map_desc *desc;
 	int buck = rdev_get_id(rdev);
 	u8 val = 0;
 	int difference, ret;
@@ -408,8 +341,6 @@ static int max8998_set_voltage_buck_time_sel(struct regulator_dev *rdev,
 	if (buck < MAX8998_BUCK1 || buck > MAX8998_BUCK4)
 		return -EINVAL;
 
-	desc = ldo_voltage_map[buck];
-
 	/* Voltage stabilization */
 	ret = max8998_read_reg(i2c, MAX8998_REG_ONOFF4, &val);
 	if (ret)
@@ -420,7 +351,7 @@ static int max8998_set_voltage_buck_time_sel(struct regulator_dev *rdev,
 	if (max8998->iodev->type == TYPE_MAX8998 && !(val & MAX8998_ENRAMP))
 		return 0;
 
-	difference = (new_selector - old_selector) * desc->step / 1000;
+	difference = (new_selector - old_selector) * rdev->desc->uV_step / 1000;
 	if (difference > 0)
 		return DIV_ROUND_UP(difference, (val & 0x0f) + 1);
 
@@ -454,158 +385,53 @@ static const struct regulator_ops max8998_others_ops = {
 	.disable		= max8998_ldo_disable,
 };
 
-static struct regulator_desc regulators[] = {
-	{
-		.name		= "LDO2",
-		.id		= MAX8998_LDO2,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO3",
-		.id		= MAX8998_LDO3,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO4",
-		.id		= MAX8998_LDO4,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO5",
-		.id		= MAX8998_LDO5,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO6",
-		.id		= MAX8998_LDO6,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO7",
-		.id		= MAX8998_LDO7,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO8",
-		.id		= MAX8998_LDO8,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO9",
-		.id		= MAX8998_LDO9,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO10",
-		.id		= MAX8998_LDO10,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO11",
-		.id		= MAX8998_LDO11,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO12",
-		.id		= MAX8998_LDO12,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO13",
-		.id		= MAX8998_LDO13,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO14",
-		.id		= MAX8998_LDO14,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO15",
-		.id		= MAX8998_LDO15,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO16",
-		.id		= MAX8998_LDO16,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "LDO17",
-		.id		= MAX8998_LDO17,
-		.ops		= &max8998_ldo_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "BUCK1",
-		.id		= MAX8998_BUCK1,
-		.ops		= &max8998_buck_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "BUCK2",
-		.id		= MAX8998_BUCK2,
-		.ops		= &max8998_buck_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "BUCK3",
-		.id		= MAX8998_BUCK3,
-		.ops		= &max8998_buck_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "BUCK4",
-		.id		= MAX8998_BUCK4,
-		.ops		= &max8998_buck_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "EN32KHz-AP",
-		.id		= MAX8998_EN32KHZ_AP,
-		.ops		= &max8998_others_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "EN32KHz-CP",
-		.id		= MAX8998_EN32KHZ_CP,
-		.ops		= &max8998_others_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "ENVICHG",
-		.id		= MAX8998_ENVICHG,
-		.ops		= &max8998_others_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "ESAFEOUT1",
-		.id		= MAX8998_ESAFEOUT1,
-		.ops		= &max8998_others_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
-	}, {
-		.name		= "ESAFEOUT2",
-		.id		= MAX8998_ESAFEOUT2,
-		.ops		= &max8998_others_ops,
-		.type		= REGULATOR_VOLTAGE,
-		.owner		= THIS_MODULE,
+#define MAX8998_LINEAR_REG(_name, _ops, _min, _step, _max) \
+	{ \
+		.name = #_name, \
+		.id = MAX8998_##_name, \
+		.ops = _ops, \
+		.min_uV = (_min), \
+		.uV_step = (_step), \
+		.n_voltages = ((_max) - (_min)) / (_step) + 1, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
 	}
+
+#define MAX8998_OTHERS_REG(_name, _id) \
+	{ \
+		.name = #_name, \
+		.id = _id, \
+		.ops = &max8998_others_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+	}
+
+static const struct regulator_desc regulators[] = {
+	MAX8998_LINEAR_REG(LDO2, &max8998_ldo_ops, 800000, 50000, 1300000),
+	MAX8998_LINEAR_REG(LDO3, &max8998_ldo_ops, 800000, 50000, 1300000),
+	MAX8998_LINEAR_REG(LDO4, &max8998_ldo_ops, 1600000, 100000, 3600000),
+	MAX8998_LINEAR_REG(LDO5, &max8998_ldo_ops, 1600000, 100000, 3600000),
+	MAX8998_LINEAR_REG(LDO6, &max8998_ldo_ops, 1600000, 100000, 3600000),
+	MAX8998_LINEAR_REG(LDO7, &max8998_ldo_ops, 1600000, 100000, 3600000),
+	MAX8998_LINEAR_REG(LDO8, &max8998_ldo_ops, 3000000, 100000, 3600000),
+	MAX8998_LINEAR_REG(LDO9, &max8998_ldo_ops, 2800000, 100000, 3100000),
+	MAX8998_LINEAR_REG(LDO10, &max8998_ldo_ops, 950000, 50000, 1300000),
+	MAX8998_LINEAR_REG(LDO11, &max8998_ldo_ops, 1600000, 100000, 3600000),
+	MAX8998_LINEAR_REG(LDO12, &max8998_ldo_ops, 800000, 100000, 3300000),
+	MAX8998_LINEAR_REG(LDO13, &max8998_ldo_ops, 800000, 100000, 3300000),
+	MAX8998_LINEAR_REG(LDO14, &max8998_ldo_ops, 1200000, 100000, 3300000),
+	MAX8998_LINEAR_REG(LDO15, &max8998_ldo_ops, 1200000, 100000, 3300000),
+	MAX8998_LINEAR_REG(LDO16, &max8998_ldo_ops, 1600000, 100000, 3600000),
+	MAX8998_LINEAR_REG(LDO17, &max8998_ldo_ops, 1600000, 100000, 3600000),
+	MAX8998_LINEAR_REG(BUCK1, &max8998_buck_ops, 750000, 25000, 1525000),
+	MAX8998_LINEAR_REG(BUCK2, &max8998_buck_ops, 750000, 25000, 1525000),
+	MAX8998_LINEAR_REG(BUCK3, &max8998_buck_ops, 1600000, 100000, 3600000),
+	MAX8998_LINEAR_REG(BUCK4, &max8998_buck_ops, 800000, 100000, 2300000),
+	MAX8998_OTHERS_REG(EN32KHz-AP, MAX8998_EN32KHZ_AP),
+	MAX8998_OTHERS_REG(EN32KHz-CP, MAX8998_EN32KHZ_CP),
+	MAX8998_OTHERS_REG(ENVICHG, MAX8998_ENVICHG),
+	MAX8998_OTHERS_REG(ESAFEOUT1, MAX8998_ESAFEOUT1),
+	MAX8998_OTHERS_REG(ESAFEOUT2, MAX8998_ESAFEOUT2),
 };
 
 static int max8998_pmic_dt_parse_dvs_gpio(struct max8998_dev *iodev,
@@ -796,9 +622,11 @@ static int max8998_pmic_probe(struct platform_device *pdev)
 
 		/* Set predefined values for BUCK1 registers */
 		for (v = 0; v < ARRAY_SIZE(pdata->buck1_voltage); ++v) {
+			int index = MAX8998_BUCK1 - MAX8998_LDO2;
+
 			i = 0;
-			while (buck12_voltage_map_desc.min +
-			       buck12_voltage_map_desc.step*i
+			while (regulators[index].min_uV +
+			       regulators[index].uV_step * i
 			       < pdata->buck1_voltage[v])
 				i++;
 
@@ -824,9 +652,11 @@ static int max8998_pmic_probe(struct platform_device *pdev)
 
 		/* Set predefined values for BUCK2 registers */
 		for (v = 0; v < ARRAY_SIZE(pdata->buck2_voltage); ++v) {
+			int index = MAX8998_BUCK2 - MAX8998_LDO2;
+
 			i = 0;
-			while (buck12_voltage_map_desc.min +
-			       buck12_voltage_map_desc.step*i
+			while (regulators[index].min_uV +
+			       regulators[index].uV_step * i
 			       < pdata->buck2_voltage[v])
 				i++;
 
@@ -839,18 +669,7 @@ static int max8998_pmic_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < pdata->num_regulators; i++) {
-		const struct voltage_map_desc *desc;
-		int id = pdata->regulators[i].id;
-		int index = id - MAX8998_LDO2;
-
-		desc = ldo_voltage_map[id];
-		if (desc && regulators[index].ops != &max8998_others_ops) {
-			int count = (desc->max - desc->min) / desc->step + 1;
-
-			regulators[index].n_voltages = count;
-			regulators[index].min_uV = desc->min;
-			regulators[index].uV_step = desc->step;
-		}
+		int index = pdata->regulators[i].id - MAX8998_LDO2;
 
 		config.dev = max8998->dev;
 		config.of_node = pdata->regulators[i].reg_node;
@@ -867,7 +686,6 @@ static int max8998_pmic_probe(struct platform_device *pdev)
 		}
 	}
 
-
 	return 0;
 }
 
-- 
2.20.1

