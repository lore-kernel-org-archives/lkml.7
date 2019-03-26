Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A969920866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553611425;
	bh=3+LQTfMEUKEIjwheYW8x+QHXbKr4VhBALoU+fHdI7Zc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2ZkM9z3XgVwdY4Ih1be9LLvpqSD2DnNyy8XTI95tZiVZbqxgcatt5zyI7hrVvnQop
	 mIHmst6y178Zo2oav95DfLMY99O9mJpTNEb0iUUBj8wjw4J/ViGT1k/0sA+qPkXvsx
	 6MDLmUSjqlQd4hX8y3sTviRpbc+qkT0hGZqzpsA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbfCZOno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:43:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35736 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731797AbfCZOnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GITRZ51JiJdNc+5VNmop2k6OCwE9B6UHEuBz1uRLO+Y=; b=RZt8Azlv5gGY
        cOCniHLEcoxsdHzsOhaMB6LeKfaSVA1Y9yBYG6rppbjhV4zw+xLODZc2L5w9YoeaXDiQnUEuSWOwh
        r3cAfj1p6tqu8w9KougzdFD+YalPHHSm5GZj2H+emdkF8BxeCHTfzsL7M5p4WZn2ZX8xxikfbG1VZ
        qluQQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8nI3-0007j5-Um; Tue, 26 Mar 2019 14:43:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7B2BF1121B57; Tue, 26 Mar 2019 14:42:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: act8865: Convert to regulator core's simplified DT parsing code" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190326144259.7B2BF1121B57@debutante.sirena.org.uk>
Date:   Tue, 26 Mar 2019 14:42:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8865: Convert to regulator core's simplified DT parsing code

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

From 253c9c79adbcf79350cb1ae1c801f8df00186455 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 22 Mar 2019 14:38:19 +0800
Subject: [PATCH] regulator: act8865: Convert to regulator core's simplified DT
 parsing code

Use regulator core's simplified DT parsing code to simply the driver
implementation. With this conversion, also move the NULL test against pdata
in act8865_get_regulator_data() to the caller. This makes it clear the
code path to explicitly set init_data is for non-DT case only.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8865-regulator.c | 143 ++++----------------------
 1 file changed, 19 insertions(+), 124 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index e0239cf3f56d..af8f201e67d7 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -245,6 +245,8 @@ static struct regulator_ops act8865_ldo_ops = {
 #define ACT88xx_REG(_name, _family, _id, _vsel_reg, _supply)		\
 	[_family##_ID_##_id] = {					\
 		.name			= _name,			\
+		.of_match		= of_match_ptr(_name),		\
+		.regulators_node	= of_match_ptr("regulators"),	\
 		.supply_name		= _supply,			\
 		.id			= _family##_ID_##_id,		\
 		.type			= REGULATOR_VOLTAGE,		\
@@ -265,6 +267,8 @@ static const struct regulator_desc act8600_regulators[] = {
 	ACT88xx_REG("DCDC3", ACT8600, DCDC3, VSET, "vp3"),
 	{
 		.name = "SUDCDC_REG4",
+		.of_match = of_match_ptr("SUDCDC_REG4"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = ACT8600_ID_SUDCDC4,
 		.ops = &act8865_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -283,6 +287,8 @@ static const struct regulator_desc act8600_regulators[] = {
 	ACT88xx_REG("LDO8", ACT8600, LDO8, VSET, "inl"),
 	{
 		.name = "LDO_REG9",
+		.of_match = of_match_ptr("LDO_REG9"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = ACT8600_ID_LDO9,
 		.ops = &act8865_ldo_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -294,6 +300,8 @@ static const struct regulator_desc act8600_regulators[] = {
 	},
 	{
 		.name = "LDO_REG10",
+		.of_match = of_match_ptr("LDO_REG10"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = ACT8600_ID_LDO10,
 		.ops = &act8865_ldo_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -348,110 +356,6 @@ static const struct of_device_id act8865_dt_ids[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, act8865_dt_ids);
-
-static struct of_regulator_match act8846_matches[] = {
-	[ACT8846_ID_REG1]	= { .name = "REG1" },
-	[ACT8846_ID_REG2]	= { .name = "REG2" },
-	[ACT8846_ID_REG3]	= { .name = "REG3" },
-	[ACT8846_ID_REG4]	= { .name = "REG4" },
-	[ACT8846_ID_REG5]	= { .name = "REG5" },
-	[ACT8846_ID_REG6]	= { .name = "REG6" },
-	[ACT8846_ID_REG7]	= { .name = "REG7" },
-	[ACT8846_ID_REG8]	= { .name = "REG8" },
-	[ACT8846_ID_REG9]	= { .name = "REG9" },
-	[ACT8846_ID_REG10]	= { .name = "REG10" },
-	[ACT8846_ID_REG11]	= { .name = "REG11" },
-	[ACT8846_ID_REG12]	= { .name = "REG12" },
-};
-
-static struct of_regulator_match act8865_matches[] = {
-	[ACT8865_ID_DCDC1]	= { .name = "DCDC_REG1"},
-	[ACT8865_ID_DCDC2]	= { .name = "DCDC_REG2"},
-	[ACT8865_ID_DCDC3]	= { .name = "DCDC_REG3"},
-	[ACT8865_ID_LDO1]	= { .name = "LDO_REG1"},
-	[ACT8865_ID_LDO2]	= { .name = "LDO_REG2"},
-	[ACT8865_ID_LDO3]	= { .name = "LDO_REG3"},
-	[ACT8865_ID_LDO4]	= { .name = "LDO_REG4"},
-};
-
-static struct of_regulator_match act8600_matches[] = {
-	[ACT8600_ID_DCDC1]	= { .name = "DCDC_REG1"},
-	[ACT8600_ID_DCDC2]	= { .name = "DCDC_REG2"},
-	[ACT8600_ID_DCDC3]	= { .name = "DCDC_REG3"},
-	[ACT8600_ID_SUDCDC4]	= { .name = "SUDCDC_REG4"},
-	[ACT8600_ID_LDO5]	= { .name = "LDO_REG5"},
-	[ACT8600_ID_LDO6]	= { .name = "LDO_REG6"},
-	[ACT8600_ID_LDO7]	= { .name = "LDO_REG7"},
-	[ACT8600_ID_LDO8]	= { .name = "LDO_REG8"},
-	[ACT8600_ID_LDO9]	= { .name = "LDO_REG9"},
-	[ACT8600_ID_LDO10]	= { .name = "LDO_REG10"},
-};
-
-static int act8865_pdata_from_dt(struct device *dev,
-				 struct act8865_platform_data *pdata,
-				 unsigned long type)
-{
-	int matched, i, num_matches;
-	struct device_node *np;
-	struct act8865_regulator_data *regulator;
-	struct of_regulator_match *matches;
-
-	switch (type) {
-	case ACT8600:
-		matches = act8600_matches;
-		num_matches = ARRAY_SIZE(act8600_matches);
-		break;
-	case ACT8846:
-		matches = act8846_matches;
-		num_matches = ARRAY_SIZE(act8846_matches);
-		break;
-	case ACT8865:
-		matches = act8865_matches;
-		num_matches = ARRAY_SIZE(act8865_matches);
-		break;
-	default:
-		dev_err(dev, "invalid device id %lu\n", type);
-		return -EINVAL;
-	}
-
-	np = of_get_child_by_name(dev->of_node, "regulators");
-	if (!np) {
-		dev_err(dev, "missing 'regulators' subnode in DT\n");
-		return -EINVAL;
-	}
-
-	matched = of_regulator_match(dev, np, matches, num_matches);
-	of_node_put(np);
-	if (matched <= 0)
-		return matched;
-
-	pdata->regulators = devm_kcalloc(dev,
-					 num_matches,
-					 sizeof(struct act8865_regulator_data),
-					 GFP_KERNEL);
-	if (!pdata->regulators)
-		return -ENOMEM;
-
-	pdata->num_regulators = num_matches;
-	regulator = pdata->regulators;
-
-	for (i = 0; i < num_matches; i++) {
-		regulator->id = i;
-		regulator->name = matches[i].name;
-		regulator->init_data = matches[i].init_data;
-		regulator->of_node = matches[i].of_node;
-		regulator++;
-	}
-
-	return 0;
-}
-#else
-static inline int act8865_pdata_from_dt(struct device *dev,
-					struct act8865_platform_data *pdata,
-					unsigned long type)
-{
-	return 0;
-}
 #endif
 
 static struct act8865_regulator_data *act8865_get_regulator_data(
@@ -459,9 +363,6 @@ static struct act8865_regulator_data *act8865_get_regulator_data(
 {
 	int i;
 
-	if (!pdata)
-		return NULL;
-
 	for (i = 0; i < pdata->num_regulators; i++) {
 		if (pdata->regulators[i].id == id)
 			return &pdata->regulators[i];
@@ -484,7 +385,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 			      const struct i2c_device_id *i2c_id)
 {
 	const struct regulator_desc *regulators;
-	struct act8865_platform_data pdata_of, *pdata;
+	struct act8865_platform_data *pdata = NULL;
 	struct device *dev = &client->dev;
 	int i, ret, num_regulators;
 	struct act8865 *act8865;
@@ -493,9 +394,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 	int off_reg, off_mask;
 	int voltage_select = 0;
 
-	pdata = dev_get_platdata(dev);
-
-	if (dev->of_node && !pdata) {
+	if (dev->of_node) {
 		const struct of_device_id *id;
 
 		id = of_match_device(of_match_ptr(act8865_dt_ids), dev);
@@ -509,6 +408,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 						   NULL);
 	} else {
 		type = i2c_id->driver_data;
+		pdata = dev_get_platdata(dev);
 	}
 
 	switch (type) {
@@ -543,14 +443,6 @@ static int act8865_pmic_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	if (dev->of_node && !pdata) {
-		ret = act8865_pdata_from_dt(dev, &pdata_of, type);
-		if (ret < 0)
-			return ret;
-
-		pdata = &pdata_of;
-	}
-
 	act8865 = devm_kzalloc(dev, sizeof(struct act8865), GFP_KERNEL);
 	if (!act8865)
 		return -ENOMEM;
@@ -577,17 +469,20 @@ static int act8865_pmic_probe(struct i2c_client *client,
 	for (i = 0; i < num_regulators; i++) {
 		const struct regulator_desc *desc = &regulators[i];
 		struct regulator_config config = { };
-		struct act8865_regulator_data *rdata;
 		struct regulator_dev *rdev;
 
 		config.dev = dev;
 		config.driver_data = act8865;
 		config.regmap = act8865->regmap;
 
-		rdata = act8865_get_regulator_data(desc->id, pdata);
-		if (rdata) {
-			config.init_data = rdata->init_data;
-			config.of_node = rdata->of_node;
+		if (pdata) {
+			struct act8865_regulator_data *rdata;
+
+			rdata = act8865_get_regulator_data(desc->id, pdata);
+			if (rdata) {
+				config.init_data = rdata->init_data;
+				config.of_node = rdata->of_node;
+			}
 		}
 
 		rdev = devm_regulator_register(dev, desc, &config);
-- 
2.20.1

