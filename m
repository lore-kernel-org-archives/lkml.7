Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A1FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEBC213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108917;
	bh=iXJ+Xw6mDe9nORYAECqQTPH002Lf2iz8JeUWAXdpO6I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mtosY/O5HAesVdtCpBz8QCGgRcoKZwJ+mRJ2kMoKcqmtvF1zpc+jX8TwTzSk3JzFV
	 oYSXmm0QUIm/BLVmE9QKBxQ7pPhUstq6xfnBVBjEAOvhciRgXU1BeoHeWq8RJiDqEi
	 Xrq/6F1C8F03qN/7GlWOvfeBvJjmGphSeT6mI52o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfDAIyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60524 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfDAIx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uT7Ad1ksubDJvVpITd+ebK4E6do3keyIsxx+FQcvFng=; b=fnxTMkna4Bac
        38qYtpd/zuDXJvJTp5HzpD50aUQvasQqoeBl3Z0EPOmk91CZuOPCl0gAqq9Sx4WmW531VUwe4Jpzu
        sSv8gb4j+8LJHZbBhu/umnPbqCIbkAV59dgkk3Cw9Vpctk7Hv7C9EvVlKSa20XoBqdkZY4/CTPfAf
        q0vDA=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAshU-0008Oo-E9; Mon, 01 Apr 2019 08:53:52 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 63E6F440083; Mon,  1 Apr 2019 09:53:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: as3722: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190401085349.63E6F440083@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:53:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: as3722: Convert to use regulator_set/get_current_limit_regmap

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

From ce0a383db3cd8ecd3a19d051de01cc14515e5683 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 27 Mar 2019 09:29:46 +0800
Subject: [PATCH] regulator: as3722: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/as3722-regulator.c | 212 ++++++++-------------------
 1 file changed, 60 insertions(+), 152 deletions(-)

diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index 7a315adbe6c4..4dda77417300 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -313,63 +313,10 @@ static const struct as3722_register_mapping as3722_reg_lookup[] = {
 	},
 };
 
-
-static const int as3722_ldo_current[] = { 150000, 300000 };
-static const int as3722_sd016_current[] = { 2500000, 3000000, 3500000 };
-
-static int as3722_current_to_index(int min_uA, int max_uA,
-		const int *curr_table, int n_currents)
-{
-	int i;
-
-	for (i = n_currents - 1; i >= 0; i--) {
-		if ((min_uA <= curr_table[i]) && (curr_table[i] <= max_uA))
-			return i;
-	}
-	return -EINVAL;
-}
-
-static int as3722_ldo_get_current_limit(struct regulator_dev *rdev)
-{
-	struct as3722_regulators *as3722_regs = rdev_get_drvdata(rdev);
-	struct as3722 *as3722 = as3722_regs->as3722;
-	int id = rdev_get_id(rdev);
-	u32 val;
-	int ret;
-
-	ret = as3722_read(as3722, as3722_reg_lookup[id].vsel_reg, &val);
-	if (ret < 0) {
-		dev_err(as3722_regs->dev, "Reg 0x%02x read failed: %d\n",
-			as3722_reg_lookup[id].vsel_reg, ret);
-		return ret;
-	}
-	if (val & AS3722_LDO_ILIMIT_MASK)
-		return 300000;
-	return 150000;
-}
-
-static int as3722_ldo_set_current_limit(struct regulator_dev *rdev,
-		int min_uA, int max_uA)
-{
-	struct as3722_regulators *as3722_regs = rdev_get_drvdata(rdev);
-	struct as3722 *as3722 = as3722_regs->as3722;
-	int id = rdev_get_id(rdev);
-	int ret;
-	u32 reg = 0;
-
-	ret = as3722_current_to_index(min_uA, max_uA, as3722_ldo_current,
-				ARRAY_SIZE(as3722_ldo_current));
-	if (ret < 0) {
-		dev_err(as3722_regs->dev,
-			"Current range min:max = %d:%d does not support\n",
-			min_uA, max_uA);
-		return ret;
-	}
-	if (ret)
-		reg = AS3722_LDO_ILIMIT_BIT;
-	return as3722_update_bits(as3722, as3722_reg_lookup[id].vsel_reg,
-			AS3722_LDO_ILIMIT_MASK, reg);
-}
+static const unsigned int as3722_ldo_current[] = { 150000, 300000 };
+static const unsigned int as3722_sd016_current[] = {
+	2500000, 3000000, 3500000
+};
 
 static const struct regulator_ops as3722_ldo0_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
@@ -378,16 +325,16 @@ static const struct regulator_ops as3722_ldo0_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 };
 
 static const struct regulator_ops as3722_ldo0_extcntrl_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 };
 
 static int as3722_ldo3_set_tracking_mode(struct as3722_regulators *as3722_reg,
@@ -439,8 +386,8 @@ static const struct regulator_ops as3722_ldo6_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear_range,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 	.get_bypass = regulator_get_bypass_regmap,
 	.set_bypass = regulator_set_bypass_regmap,
 };
@@ -450,8 +397,8 @@ static const struct regulator_ops as3722_ldo6_extcntrl_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear_range,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 	.get_bypass = regulator_get_bypass_regmap,
 	.set_bypass = regulator_set_bypass_regmap,
 };
@@ -470,8 +417,8 @@ static const struct regulator_ops as3722_ldo_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear_range,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 };
 
 static const struct regulator_ops as3722_ldo_extcntrl_ops = {
@@ -479,8 +426,8 @@ static const struct regulator_ops as3722_ldo_extcntrl_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear_range,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 };
 
 static unsigned int as3722_sd_get_mode(struct regulator_dev *rdev)
@@ -538,85 +485,6 @@ static int as3722_sd_set_mode(struct regulator_dev *rdev,
 	return ret;
 }
 
-static int as3722_sd016_get_current_limit(struct regulator_dev *rdev)
-{
-	struct as3722_regulators *as3722_regs = rdev_get_drvdata(rdev);
-	struct as3722 *as3722 = as3722_regs->as3722;
-	int id = rdev_get_id(rdev);
-	u32 val, reg;
-	int mask;
-	int ret;
-
-	switch (id) {
-	case AS3722_REGULATOR_ID_SD0:
-		reg = AS3722_OVCURRENT_REG;
-		mask = AS3722_OVCURRENT_SD0_TRIP_MASK;
-		break;
-	case AS3722_REGULATOR_ID_SD1:
-		reg = AS3722_OVCURRENT_REG;
-		mask = AS3722_OVCURRENT_SD1_TRIP_MASK;
-		break;
-	case AS3722_REGULATOR_ID_SD6:
-		reg = AS3722_OVCURRENT_DEB_REG;
-		mask = AS3722_OVCURRENT_SD6_TRIP_MASK;
-		break;
-	default:
-		return -EINVAL;
-	}
-	ret = as3722_read(as3722, reg, &val);
-	if (ret < 0) {
-		dev_err(as3722_regs->dev, "Reg 0x%02x read failed: %d\n",
-			reg, ret);
-		return ret;
-	}
-	val &= mask;
-	val >>= ffs(mask) - 1;
-	if (val == 3)
-		return -EINVAL;
-	return as3722_sd016_current[val];
-}
-
-static int as3722_sd016_set_current_limit(struct regulator_dev *rdev,
-		int min_uA, int max_uA)
-{
-	struct as3722_regulators *as3722_regs = rdev_get_drvdata(rdev);
-	struct as3722 *as3722 = as3722_regs->as3722;
-	int id = rdev_get_id(rdev);
-	int ret;
-	int val;
-	int mask;
-	u32 reg;
-
-	ret = as3722_current_to_index(min_uA, max_uA, as3722_sd016_current,
-				ARRAY_SIZE(as3722_sd016_current));
-	if (ret < 0) {
-		dev_err(as3722_regs->dev,
-			"Current range min:max = %d:%d does not support\n",
-			min_uA, max_uA);
-		return ret;
-	}
-
-	switch (id) {
-	case AS3722_REGULATOR_ID_SD0:
-		reg = AS3722_OVCURRENT_REG;
-		mask = AS3722_OVCURRENT_SD0_TRIP_MASK;
-		break;
-	case AS3722_REGULATOR_ID_SD1:
-		reg = AS3722_OVCURRENT_REG;
-		mask = AS3722_OVCURRENT_SD1_TRIP_MASK;
-		break;
-	case AS3722_REGULATOR_ID_SD6:
-		reg = AS3722_OVCURRENT_DEB_REG;
-		mask = AS3722_OVCURRENT_SD6_TRIP_MASK;
-		break;
-	default:
-		return -EINVAL;
-	}
-	ret <<= ffs(mask) - 1;
-	val = ret & mask;
-	return as3722_update_bits(as3722, reg, mask, val);
-}
-
 static bool as3722_sd0_is_low_voltage(struct as3722_regulators *as3722_regs)
 {
 	int err;
@@ -648,8 +516,8 @@ static const struct regulator_ops as3722_sd016_ops = {
 	.map_voltage = regulator_map_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_current_limit = as3722_sd016_get_current_limit,
-	.set_current_limit = as3722_sd016_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 	.get_mode = as3722_sd_get_mode,
 	.set_mode = as3722_sd_set_mode,
 };
@@ -659,8 +527,8 @@ static const struct regulator_ops as3722_sd016_extcntrl_ops = {
 	.map_voltage = regulator_map_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_current_limit = as3722_sd016_get_current_limit,
-	.set_current_limit = as3722_sd016_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 	.get_mode = as3722_sd_get_mode,
 	.set_mode = as3722_sd_set_mode,
 };
@@ -832,6 +700,13 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 			as3722_regs->desc[id].uV_step = 25000;
 			as3722_regs->desc[id].linear_min_sel = 1;
 			as3722_regs->desc[id].enable_time = 500;
+			as3722_regs->desc[id].curr_table = as3722_ldo_current;
+			as3722_regs->desc[id].n_current_limits =
+				ARRAY_SIZE(as3722_ldo_current);
+			as3722_regs->desc[id].csel_reg =
+				as3722_reg_lookup[id].vsel_reg;
+			as3722_regs->desc[id].csel_mask =
+				AS3722_LDO_ILIMIT_MASK;
 			break;
 		case AS3722_REGULATOR_ID_LDO3:
 			if (reg_config->ext_control)
@@ -870,6 +745,13 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 			as3722_regs->desc[id].linear_ranges = as3722_ldo_ranges;
 			as3722_regs->desc[id].n_linear_ranges =
 						ARRAY_SIZE(as3722_ldo_ranges);
+			as3722_regs->desc[id].curr_table = as3722_ldo_current;
+			as3722_regs->desc[id].n_current_limits =
+				ARRAY_SIZE(as3722_ldo_current);
+			as3722_regs->desc[id].csel_reg =
+				as3722_reg_lookup[id].vsel_reg;
+			as3722_regs->desc[id].csel_mask =
+				AS3722_LDO_ILIMIT_MASK;
 			break;
 		case AS3722_REGULATOR_ID_SD0:
 		case AS3722_REGULATOR_ID_SD1:
@@ -891,6 +773,25 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 			as3722_regs->desc[id].uV_step = 10000;
 			as3722_regs->desc[id].linear_min_sel = 1;
 			as3722_regs->desc[id].enable_time = 600;
+			as3722_regs->desc[id].curr_table = as3722_sd016_current;
+			as3722_regs->desc[id].n_current_limits =
+				ARRAY_SIZE(as3722_sd016_current);
+			if (id == AS3722_REGULATOR_ID_SD0) {
+				as3722_regs->desc[id].csel_reg =
+					AS3722_OVCURRENT_REG;
+				as3722_regs->desc[id].csel_mask =
+					AS3722_OVCURRENT_SD0_TRIP_MASK;
+			} else if (id == AS3722_REGULATOR_ID_SD1) {
+				as3722_regs->desc[id].csel_reg =
+					AS3722_OVCURRENT_REG;
+				as3722_regs->desc[id].csel_mask =
+					AS3722_OVCURRENT_SD1_TRIP_MASK;
+			} else if (id == AS3722_REGULATOR_ID_SD6) {
+				as3722_regs->desc[id].csel_reg =
+					AS3722_OVCURRENT_DEB_REG;
+				as3722_regs->desc[id].csel_mask =
+					AS3722_OVCURRENT_SD6_TRIP_MASK;
+			}
 			break;
 		case AS3722_REGULATOR_ID_SD2:
 		case AS3722_REGULATOR_ID_SD3:
@@ -914,6 +815,13 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 			as3722_regs->desc[id].linear_ranges = as3722_ldo_ranges;
 			as3722_regs->desc[id].n_linear_ranges =
 						ARRAY_SIZE(as3722_ldo_ranges);
+			as3722_regs->desc[id].curr_table = as3722_ldo_current;
+			as3722_regs->desc[id].n_current_limits =
+						ARRAY_SIZE(as3722_ldo_current);
+			as3722_regs->desc[id].csel_reg =
+						as3722_reg_lookup[id].vsel_reg;
+			as3722_regs->desc[id].csel_mask =
+						AS3722_LDO_ILIMIT_MASK;
 			break;
 		}
 		as3722_regs->desc[id].ops = ops;
-- 
2.20.1

