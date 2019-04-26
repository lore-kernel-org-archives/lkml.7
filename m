Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDC7C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B28208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271675;
	bh=k+ZzsoIWNxad8KMGhnYqBjQqMkPM/DXJRHs7XcGalTw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SuhdGGXlGy2IMsYpzdLUzTcaAoohdX0miVC4oN4xiNy8lXsZ1hNY8/kGn8cY7EMvd
	 WW4eEeEyVDjRPX0rsWMUG1C53bKyd3/O5EPsv8KCJgPn6U353LbCguZbJOX1QFok2M
	 ho2k/2G77opxmO/1vhDV5mwlcTm5EfUvUbzg2CnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfDZJlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:41:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfDZJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qCGmuSYmSH2D7vbtdW8oXv5UiMon8QxN9SaH2coDR5U=; b=C0LPmzMSQWh5
        zqj9lFIdpF4id0J0iI5wQnvg1r/YCTzZP9eVs3K7TvqxZQgX31KmA84eYcnvYfsYYFObTfkn1aEwv
        4tY18f15ymtpMKBlTPg4aZToRg5/X8JPuNFOGQGJN1lBwsBJGLMdqSyL+8RNUyxMyntI6/tcT380W
        d23ic=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxLx-0003Kr-Fy; Fri, 26 Apr 2019 09:41:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 44091441D3B; Fri, 26 Apr 2019 10:41:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65218: Convert to use regulator_get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094103.44091441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:41:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65218: Convert to use regulator_get_current_limit_regmap

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

From 7cfcecfb82afe81fdc94ec214f2ad3d83eb2a4ba Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 13 Apr 2019 10:29:07 +0800
Subject: [PATCH] regulator: tps65218: Convert to use
 regulator_get_current_limit_regmap

Use regulator_get_current_limit_regmap helper to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65218-regulator.c | 48 ++++++++++----------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 7aed3fbffecc..b72035610013 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -29,7 +29,8 @@
 #include <linux/mfd/tps65218.h>
 
 #define TPS65218_REGULATOR(_name, _of, _id, _type, _ops, _n, _vr, _vm, _er, \
-			   _em, _cr, _cm, _lr, _nlr, _delay, _fuv, _sr, _sm) \
+			   _em, _cr, _cm, _lr, _nlr, _delay, _fuv, _sr, _sm, \
+			   _ct, _ncl) \
 	{							\
 		.name			= _name,		\
 		.of_match		= _of,			\
@@ -42,6 +43,8 @@
 		.vsel_mask		= _vm,			\
 		.csel_reg		= _cr,			\
 		.csel_mask		= _cm,			\
+		.curr_table		= _ct,			\
+		.n_current_limits	= _ncl,			\
 		.enable_reg		= _er,			\
 		.enable_mask		= _em,			\
 		.volt_table		= NULL,			\
@@ -188,8 +191,7 @@ static const struct regulator_ops tps65218_ldo1_dcdc34_ops = {
 	.set_suspend_disable	= tps65218_pmic_set_suspend_disable,
 };
 
-static const int ls3_currents[] = { 100000, 200000, 500000, 1000000 };
-
+static const unsigned int ls3_currents[] = { 100000, 200000, 500000, 1000000 };
 
 static int tps65218_pmic_set_input_current_lim(struct regulator_dev *dev,
 					       int lim_uA)
@@ -229,29 +231,13 @@ static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
 				 TPS65218_PROTECT_L1);
 }
 
-static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
-{
-	int retval;
-	unsigned int index;
-	struct tps65218 *tps = rdev_get_drvdata(dev);
-
-	retval = regmap_read(tps->regmap, dev->desc->csel_reg, &index);
-	if (retval < 0)
-		return retval;
-
-	index = (index & dev->desc->csel_mask) >>
-					 __builtin_ctz(dev->desc->csel_mask);
-
-	return ls3_currents[index];
-}
-
 static const struct regulator_ops tps65218_ls23_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
 	.set_input_current_limit = tps65218_pmic_set_input_current_lim,
 	.set_current_limit	= tps65218_pmic_set_current_limit,
-	.get_current_limit	= tps65218_pmic_get_current_limit,
+	.get_current_limit	= regulator_get_current_limit_regmap,
 };
 
 /* Operations permitted on DCDC5, DCDC6 */
@@ -270,53 +256,57 @@ static const struct regulator_desc regulators[] = {
 			   TPS65218_CONTROL_DCDC1_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC1_EN, 0, 0, dcdc1_dcdc2_ranges,
 			   2, 4000, 0, TPS65218_REG_SEQ3,
-			   TPS65218_SEQ3_DC1_SEQ_MASK),
+			   TPS65218_SEQ3_DC1_SEQ_MASK, NULL, 0),
 	TPS65218_REGULATOR("DCDC2", "regulator-dcdc2", TPS65218_DCDC_2,
 			   REGULATOR_VOLTAGE, tps65218_dcdc12_ops, 64,
 			   TPS65218_REG_CONTROL_DCDC2,
 			   TPS65218_CONTROL_DCDC2_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC2_EN, 0, 0, dcdc1_dcdc2_ranges,
 			   2, 4000, 0, TPS65218_REG_SEQ3,
-			   TPS65218_SEQ3_DC2_SEQ_MASK),
+			   TPS65218_SEQ3_DC2_SEQ_MASK, NULL, 0),
 	TPS65218_REGULATOR("DCDC3", "regulator-dcdc3", TPS65218_DCDC_3,
 			   REGULATOR_VOLTAGE, tps65218_ldo1_dcdc34_ops, 64,
 			   TPS65218_REG_CONTROL_DCDC3,
 			   TPS65218_CONTROL_DCDC3_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC3_EN, 0, 0, ldo1_dcdc3_ranges, 2,
-			   0, 0, TPS65218_REG_SEQ4, TPS65218_SEQ4_DC3_SEQ_MASK),
+			   0, 0, TPS65218_REG_SEQ4, TPS65218_SEQ4_DC3_SEQ_MASK,
+			   NULL, 0),
 	TPS65218_REGULATOR("DCDC4", "regulator-dcdc4", TPS65218_DCDC_4,
 			   REGULATOR_VOLTAGE, tps65218_ldo1_dcdc34_ops, 53,
 			   TPS65218_REG_CONTROL_DCDC4,
 			   TPS65218_CONTROL_DCDC4_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC4_EN, 0, 0, dcdc4_ranges, 2,
-			   0, 0, TPS65218_REG_SEQ4, TPS65218_SEQ4_DC4_SEQ_MASK),
+			   0, 0, TPS65218_REG_SEQ4, TPS65218_SEQ4_DC4_SEQ_MASK,
+			   NULL, 0),
 	TPS65218_REGULATOR("DCDC5", "regulator-dcdc5", TPS65218_DCDC_5,
 			   REGULATOR_VOLTAGE, tps65218_dcdc56_pmic_ops, 1, -1,
 			   -1, TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC5_EN, 0,
 			   0, NULL, 0, 0, 1000000, TPS65218_REG_SEQ5,
-			   TPS65218_SEQ5_DC5_SEQ_MASK),
+			   TPS65218_SEQ5_DC5_SEQ_MASK, NULL, 0),
 	TPS65218_REGULATOR("DCDC6", "regulator-dcdc6", TPS65218_DCDC_6,
 			   REGULATOR_VOLTAGE, tps65218_dcdc56_pmic_ops, 1, -1,
 			   -1, TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC6_EN, 0,
 			   0, NULL, 0, 0, 1800000, TPS65218_REG_SEQ5,
-			   TPS65218_SEQ5_DC6_SEQ_MASK),
+			   TPS65218_SEQ5_DC6_SEQ_MASK, NULL, 0),
 	TPS65218_REGULATOR("LDO1", "regulator-ldo1", TPS65218_LDO_1,
 			   REGULATOR_VOLTAGE, tps65218_ldo1_dcdc34_ops, 64,
 			   TPS65218_REG_CONTROL_LDO1,
 			   TPS65218_CONTROL_LDO1_MASK, TPS65218_REG_ENABLE2,
 			   TPS65218_ENABLE2_LDO1_EN, 0, 0, ldo1_dcdc3_ranges,
 			   2, 0, 0, TPS65218_REG_SEQ6,
-			   TPS65218_SEQ6_LDO1_SEQ_MASK),
+			   TPS65218_SEQ6_LDO1_SEQ_MASK, NULL, 0),
 	TPS65218_REGULATOR("LS2", "regulator-ls2", TPS65218_LS_2,
 			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
 			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS2_EN,
 			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS2ILIM_MASK,
-			   NULL, 0, 0, 0, 0, 0),
+			   NULL, 0, 0, 0, 0, 0, ls3_currents,
+			   ARRAY_SIZE(ls3_currents)),
 	TPS65218_REGULATOR("LS3", "regulator-ls3", TPS65218_LS_3,
 			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
 			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS3_EN,
 			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS3ILIM_MASK,
-			   NULL, 0, 0, 0, 0, 0),
+			   NULL, 0, 0, 0, 0, 0, ls3_currents,
+			   ARRAY_SIZE(ls3_currents)),
 };
 
 static int tps65218_regulator_probe(struct platform_device *pdev)
-- 
2.20.1

