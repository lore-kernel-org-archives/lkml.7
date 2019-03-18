Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15659C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C506220850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920702;
	bh=/eYCo+k7YBEJDSuZNl4Gw7C+dSivzbDBGVff4LkWsx4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xfAjfSBQSUdZW2XOdhF6YyUmQTSmstUYyVHVLq/CacE3IK09cjb6HEMULY9J25SW6
	 6HIux2l2mRJJsSgjcpC5HSGPXDqC/nrUgAdoFVYfpJAbZRR8SrNSERhLuNoUDAJbiN
	 XgyO7l/Gib/jBb62P5e9kiPQslAmszXd/OrnFc88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfCROvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:51:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55014 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfCROvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vLhTM0rgS1GsKcCMz7ReBzf/KLDvB0oVbgv7yiGL66E=; b=ZQVDJ3mxdW53
        98pbs/o9OwSbkzOJbqbH1h3OMxndo78q7facWZ69lSRQCFmT4Er4pfQpU+uXNy77aJ4Uz8IIwM2Al
        4EVSiQl3AG5K9d0r/FqFePiuMM5TlI9fMiUeRii8jsQ6JcgS8dyjSs07GqL/ley4ci+uLEoL+InbD
        bo7wE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tbx-0005o4-S0; Mon, 18 Mar 2019 14:51:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 58D12112887B; Mon, 18 Mar 2019 14:51:33 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Steve Twiss <stwiss@opensource.diasemi.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9062: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190318145133.58D12112887B@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9062: Convert to use regulator_set/get_current_limit_regmap

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

From 958e9b8265c7efca1ba8b61115f23bea319df212 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 4 Mar 2019 21:16:02 +0800
Subject: [PATCH] regulator: da9062: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Steve Twiss <stwiss@opensource.diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 125 +++++++--------------------
 1 file changed, 32 insertions(+), 93 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index bab88ddfc509..a7d929b7776a 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -53,16 +53,12 @@ enum {
 /* Regulator capabilities and registers description */
 struct da9062_regulator_info {
 	struct regulator_desc desc;
-	/* Current limiting */
-	unsigned int n_current_limits;
-	const int *current_limits;
 	/* Main register fields */
 	struct reg_field mode;
 	struct reg_field suspend;
 	struct reg_field sleep;
 	struct reg_field suspend_sleep;
 	unsigned int suspend_vsel_reg;
-	struct reg_field ilimit;
 	/* Event detection bit */
 	struct reg_field oc_event;
 };
@@ -78,7 +74,6 @@ struct da9062_regulator {
 	struct regmap_field			*suspend;
 	struct regmap_field			*sleep;
 	struct regmap_field			*suspend_sleep;
-	struct regmap_field			*ilimit;
 };
 
 /* Encapsulates all information for the regulators driver */
@@ -104,7 +99,7 @@ enum {
  * - DA9062_ID_[BUCK1|BUCK2|BUCK4]
  * Entry indexes corresponds to register values.
  */
-static const int da9062_buck_a_limits[] = {
+static const unsigned int da9062_buck_a_limits[] = {
 	 500000,  600000,  700000,  800000,  900000, 1000000, 1100000, 1200000,
 	1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000
 };
@@ -114,44 +109,11 @@ static const int da9062_buck_a_limits[] = {
  * - DA9062_ID_BUCK3
  * Entry indexes corresponds to register values.
  */
-static const int da9062_buck_b_limits[] = {
+static const unsigned int da9062_buck_b_limits[] = {
 	1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000, 2200000,
 	2300000, 2400000, 2500000, 2600000, 2700000, 2800000, 2900000, 3000000
 };
 
-static int da9062_set_current_limit(struct regulator_dev *rdev,
-				    int min_ua, int max_ua)
-{
-	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	const struct da9062_regulator_info *rinfo = regl->info;
-	int n, tval;
-
-	for (n = rinfo->n_current_limits - 1; n >= 0; n--) {
-		tval = rinfo->current_limits[n];
-		if (tval >= min_ua && tval <= max_ua)
-			return regmap_field_write(regl->ilimit, n);
-	}
-
-	return -EINVAL;
-}
-
-static int da9062_get_current_limit(struct regulator_dev *rdev)
-{
-	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	const struct da9062_regulator_info *rinfo = regl->info;
-	unsigned int sel;
-	int ret;
-
-	ret = regmap_field_read(regl->ilimit, &sel);
-	if (ret < 0)
-		return ret;
-
-	if (sel >= rinfo->n_current_limits)
-		sel = rinfo->n_current_limits - 1;
-
-	return rinfo->current_limits[sel];
-}
-
 static int da9062_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
@@ -395,8 +357,8 @@ static const struct regulator_ops da9062_buck_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
-	.set_current_limit	= da9062_set_current_limit,
-	.get_current_limit	= da9062_get_current_limit,
+	.set_current_limit	= regulator_set_current_limit_regmap,
+	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_mode		= da9062_buck_set_mode,
 	.get_mode		= da9062_buck_get_mode,
 	.get_status		= da9062_buck_get_status,
@@ -433,8 +395,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.min_uV = (300) * 1000,
 		.desc.uV_step = (10) * 1000,
 		.desc.n_voltages = ((1570) - (300))/(10) + 1,
-		.current_limits = da9062_buck_a_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.curr_table = da9062_buck_a_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_C,
+		.desc.csel_mask = DA9062AA_BUCK1_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK1_CONT,
 		.desc.enable_mask = DA9062AA_BUCK1_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK1_A,
@@ -457,10 +421,6 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_C,
-			__builtin_ffs((int)DA9062AA_BUCK1_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK1_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_BUCK2,
@@ -471,8 +431,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.min_uV = (800) * 1000,
 		.desc.uV_step = (20) * 1000,
 		.desc.n_voltages = ((3340) - (800))/(20) + 1,
-		.current_limits = da9062_buck_b_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_b_limits),
+		.desc.curr_table = da9062_buck_b_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_b_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_A,
+		.desc.csel_mask = DA9062AA_BUCK3_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK3_CONT,
 		.desc.enable_mask = DA9062AA_BUCK3_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK3_A,
@@ -495,10 +457,6 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_A,
-			__builtin_ffs((int)DA9062AA_BUCK3_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK3_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_BUCK3,
@@ -509,8 +467,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.min_uV = (530) * 1000,
 		.desc.uV_step = (10) * 1000,
 		.desc.n_voltages = ((1800) - (530))/(10) + 1,
-		.current_limits = da9062_buck_a_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.curr_table = da9062_buck_a_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_B,
+		.desc.csel_mask = DA9062AA_BUCK4_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK4_CONT,
 		.desc.enable_mask = DA9062AA_BUCK4_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK4_A,
@@ -533,10 +493,6 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_B,
-			__builtin_ffs((int)DA9062AA_BUCK4_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK4_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_LDO1,
@@ -679,8 +635,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.min_uV = (300) * 1000,
 		.desc.uV_step = (10) * 1000,
 		.desc.n_voltages = ((1570) - (300))/(10) + 1,
-		.current_limits = da9062_buck_a_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.curr_table = da9062_buck_a_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_C,
+		.desc.csel_mask = DA9062AA_BUCK1_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK1_CONT,
 		.desc.enable_mask = DA9062AA_BUCK1_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK1_A,
@@ -703,10 +661,6 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_C,
-			__builtin_ffs((int)DA9062AA_BUCK1_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK1_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK2,
@@ -717,8 +671,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.min_uV = (300) * 1000,
 		.desc.uV_step = (10) * 1000,
 		.desc.n_voltages = ((1570) - (300))/(10) + 1,
-		.current_limits = da9062_buck_a_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.curr_table = da9062_buck_a_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_C,
+		.desc.csel_mask = DA9062AA_BUCK2_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK2_CONT,
 		.desc.enable_mask = DA9062AA_BUCK2_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK2_A,
@@ -741,10 +697,6 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK2_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK2_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_C,
-			__builtin_ffs((int)DA9062AA_BUCK2_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK2_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK3,
@@ -755,8 +707,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.min_uV = (800) * 1000,
 		.desc.uV_step = (20) * 1000,
 		.desc.n_voltages = ((3340) - (800))/(20) + 1,
-		.current_limits = da9062_buck_b_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_b_limits),
+		.desc.curr_table = da9062_buck_b_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_b_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_A,
+		.desc.csel_mask = DA9062AA_BUCK3_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK3_CONT,
 		.desc.enable_mask = DA9062AA_BUCK3_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK3_A,
@@ -779,10 +733,6 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_A,
-			__builtin_ffs((int)DA9062AA_BUCK3_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK3_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK4,
@@ -793,8 +743,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.min_uV = (530) * 1000,
 		.desc.uV_step = (10) * 1000,
 		.desc.n_voltages = ((1800) - (530))/(10) + 1,
-		.current_limits = da9062_buck_a_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.curr_table = da9062_buck_a_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_B,
+		.desc.csel_mask = DA9062AA_BUCK4_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK4_CONT,
 		.desc.enable_mask = DA9062AA_BUCK4_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK4_A,
@@ -817,10 +769,6 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_B,
-			__builtin_ffs((int)DA9062AA_BUCK4_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK4_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_LDO1,
@@ -1065,15 +1013,6 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 				return PTR_ERR(regl->suspend_sleep);
 		}
 
-		if (regl->info->ilimit.reg) {
-			regl->ilimit = devm_regmap_field_alloc(
-					&pdev->dev,
-					chip->regmap,
-					regl->info->ilimit);
-			if (IS_ERR(regl->ilimit))
-				return PTR_ERR(regl->ilimit);
-		}
-
 		/* Register regulator */
 		memset(&config, 0, sizeof(config));
 		config.dev = chip->dev;
-- 
2.20.1

