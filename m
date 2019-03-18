Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7525A20879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920767;
	bh=/bdQJrNyUGScchP4+ksQgxgGvkr/kSCpi0om9KX5JZ0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xplUpbQkXZH7m0HhS3XB7LD+Ub7GGhTXi57pNhC5BqjolZf7uiQtLzNexKxvjD2NA
	 LgR+gW5WxC6J6+78uqifFmL39RtJX9oN7yhDDwstxv4aZjoG/4ojAbG17bhrnqw16p
	 5pnIWUOYiPbplN8Wju1UxA9OpA4781t2spDBd0gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfCROwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:52:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55276 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfCROvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NCDTVWXapxkxPTTLLByNXNQCEw6rUZAjONko8frJ4s0=; b=eD+YabjB+e83
        F78nq6232kgtFqrUctdY7SW0YbyyfYHXdHuZ1rdMAU/SHWqkbXRm5XZyQz+8x9bnyRTGrG8sXK9UG
        GJMZP2FCeeW8QrS51dL92bXPlm9Uwumt5xk98VHePiv7ouynF9/pjS1QWV2pXAavDTV2hE1bXCMnw
        nplzA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tc1-0005o3-9i; Mon, 18 Mar 2019 14:51:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A6B291128874; Mon, 18 Mar 2019 14:51:31 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Steve Twiss <stwiss@opensource.diasemi.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9063: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190318145131.A6B291128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:31 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9063: Convert to use regulator_set/get_current_limit_regmap

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

From 5b1f537e49830321a23d1c72f9f6e925ce3a672e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 4 Mar 2019 21:16:03 +0800
Subject: [PATCH] regulator: da9063: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Steve Twiss <stwiss@opensource.diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9063-regulator.c | 107 +++++++--------------------
 1 file changed, 28 insertions(+), 79 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index d7bdb95b7602..c5d1ae5265ab 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -38,17 +38,12 @@
 struct da9063_regulator_info {
 	struct regulator_desc desc;
 
-	/* Current limiting */
-	unsigned	n_current_limits;
-	const int	*current_limits;
-
 	/* DA9063 main register fields */
 	struct reg_field mode;		/* buck mode of operation */
 	struct reg_field suspend;
 	struct reg_field sleep;
 	struct reg_field suspend_sleep;
 	unsigned int suspend_vsel_reg;
-	struct reg_field ilimit;
 
 	/* DA9063 event detection bit */
 	struct reg_field oc_event;
@@ -73,15 +68,18 @@ struct da9063_regulator_info {
 	.suspend_vsel_reg = DA9063_REG_V##regl_name##_B
 
 /* Macros for voltage DC/DC converters (BUCKs) */
-#define DA9063_BUCK(chip, regl_name, min_mV, step_mV, max_mV, limits_array) \
+#define DA9063_BUCK(chip, regl_name, min_mV, step_mV, max_mV, limits_array, \
+		    creg, cmask) \
 	.desc.id = chip##_ID_##regl_name, \
 	.desc.name = __stringify(chip##_##regl_name), \
 	.desc.ops = &da9063_buck_ops, \
 	.desc.min_uV = (min_mV) * 1000, \
 	.desc.uV_step = (step_mV) * 1000, \
 	.desc.n_voltages = ((max_mV) - (min_mV))/(step_mV) + 1, \
-	.current_limits = limits_array, \
-	.n_current_limits = ARRAY_SIZE(limits_array)
+	.desc.csel_reg = (creg), \
+	.desc.csel_mask = (cmask), \
+	.desc.curr_table = limits_array, \
+	.desc.n_current_limits = ARRAY_SIZE(limits_array)
 
 #define DA9063_BUCK_COMMON_FIELDS(regl_name) \
 	.desc.enable_reg = DA9063_REG_##regl_name##_CONT, \
@@ -112,7 +110,6 @@ struct da9063_regulator {
 	struct regmap_field			*suspend;
 	struct regmap_field			*sleep;
 	struct regmap_field			*suspend_sleep;
-	struct regmap_field			*ilimit;
 };
 
 /* Encapsulates all information for the regulators driver */
@@ -134,65 +131,32 @@ enum {
 
 /* Current limits array (in uA) for BCORE1, BCORE2, BPRO.
    Entry indexes corresponds to register values. */
-static const int da9063_buck_a_limits[] = {
+static const unsigned int da9063_buck_a_limits[] = {
 	 500000,  600000,  700000,  800000,  900000, 1000000, 1100000, 1200000,
 	1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000
 };
 
 /* Current limits array (in uA) for BMEM, BIO, BPERI.
    Entry indexes corresponds to register values. */
-static const int da9063_buck_b_limits[] = {
+static const unsigned int da9063_buck_b_limits[] = {
 	1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000, 2200000,
 	2300000, 2400000, 2500000, 2600000, 2700000, 2800000, 2900000, 3000000
 };
 
 /* Current limits array (in uA) for merged BCORE1 and BCORE2.
    Entry indexes corresponds to register values. */
-static const int da9063_bcores_merged_limits[] = {
+static const unsigned int da9063_bcores_merged_limits[] = {
 	1000000, 1200000, 1400000, 1600000, 1800000, 2000000, 2200000, 2400000,
 	2600000, 2800000, 3000000, 3200000, 3400000, 3600000, 3800000, 4000000
 };
 
 /* Current limits array (in uA) for merged BMEM and BIO.
    Entry indexes corresponds to register values. */
-static const int da9063_bmem_bio_merged_limits[] = {
+static const unsigned int da9063_bmem_bio_merged_limits[] = {
 	3000000, 3200000, 3400000, 3600000, 3800000, 4000000, 4200000, 4400000,
 	4600000, 4800000, 5000000, 5200000, 5400000, 5600000, 5800000, 6000000
 };
 
-static int da9063_set_current_limit(struct regulator_dev *rdev,
-							int min_uA, int max_uA)
-{
-	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	const struct da9063_regulator_info *rinfo = regl->info;
-	int n, tval;
-
-	for (n = rinfo->n_current_limits - 1; n >= 0; n--) {
-		tval = rinfo->current_limits[n];
-		if (tval >= min_uA && tval <= max_uA)
-			return regmap_field_write(regl->ilimit, n);
-	}
-
-	return -EINVAL;
-}
-
-static int da9063_get_current_limit(struct regulator_dev *rdev)
-{
-	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	const struct da9063_regulator_info *rinfo = regl->info;
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
 static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
@@ -434,8 +398,8 @@ static const struct regulator_ops da9063_buck_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
-	.set_current_limit	= da9063_set_current_limit,
-	.get_current_limit	= da9063_get_current_limit,
+	.set_current_limit	= regulator_set_current_limit_regmap,
+	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_mode		= da9063_buck_set_mode,
 	.get_mode		= da9063_buck_get_mode,
 	.get_status		= da9063_buck_get_status,
@@ -465,69 +429,61 @@ static const struct regulator_ops da9063_ldo_ops = {
 static const struct da9063_regulator_info da9063_regulator_info[] = {
 	{
 		DA9063_BUCK(DA9063, BCORE1, 300, 10, 1570,
-			    da9063_buck_a_limits),
+			    da9063_buck_a_limits,
+			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE1_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_C,
-				 DA9063_BCORE1_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BCORE2, 300, 10, 1570,
-			    da9063_buck_a_limits),
+			    da9063_buck_a_limits,
+			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE2_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE2),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE2_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_C,
-				 DA9063_BCORE2_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BPRO, 530, 10, 1800,
-			    da9063_buck_a_limits),
+			    da9063_buck_a_limits,
+			    DA9063_REG_BUCK_ILIM_B, DA9063_BPRO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPRO),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBPRO_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_B,
-				 DA9063_BPRO_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM, 800, 20, 3340,
-			    da9063_buck_b_limits),
+			    da9063_buck_b_limits,
+			    DA9063_REG_BUCK_ILIM_A, DA9063_BMEM_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BMEM),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBMEM_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_A,
-				 DA9063_BMEM_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BIO, 800, 20, 3340,
-			    da9063_buck_b_limits),
+			    da9063_buck_b_limits,
+			    DA9063_REG_BUCK_ILIM_A, DA9063_BIO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BIO),
 		.suspend = BFIELD(DA9063_REG_DVC_2, DA9063_VBIO_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_A,
-				 DA9063_BIO_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BPERI, 800, 20, 3340,
-			    da9063_buck_b_limits),
+			    da9063_buck_b_limits,
+			    DA9063_REG_BUCK_ILIM_B, DA9063_BPERI_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPERI),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBPERI_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_B,
-				 DA9063_BPERI_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BCORES_MERGED, 300, 10, 1570,
-			    da9063_bcores_merged_limits),
+			    da9063_bcores_merged_limits,
+			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		/* BCORES_MERGED uses the same register fields as BCORE1 */
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE1_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_C,
-				 DA9063_BCORE1_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM_BIO_MERGED, 800, 20, 3340,
-			    da9063_bmem_bio_merged_limits),
+			    da9063_bmem_bio_merged_limits,
+			    DA9063_REG_BUCK_ILIM_A, DA9063_BMEM_ILIM_MASK),
 		/* BMEM_BIO_MERGED uses the same register fields as BMEM */
 		DA9063_BUCK_COMMON_FIELDS(BMEM),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBMEM_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_A,
-				 DA9063_BMEM_ILIM_MASK),
 	},
 	{
 		DA9063_LDO(DA9063, LDO3, 900, 20, 3440),
@@ -864,13 +820,6 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 				return PTR_ERR(regl->suspend_sleep);
 		}
 
-		if (regl->info->ilimit.reg) {
-			regl->ilimit = devm_regmap_field_alloc(&pdev->dev,
-					da9063->regmap, regl->info->ilimit);
-			if (IS_ERR(regl->ilimit))
-				return PTR_ERR(regl->ilimit);
-		}
-
 		/* Register regulator */
 		memset(&config, 0, sizeof(config));
 		config.dev = &pdev->dev;
-- 
2.20.1

