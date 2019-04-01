Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BD8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A05021841
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108843;
	bh=oCB5mAY08QMPbJDcxAb/XldZIgiPt0YB2SO8RbDVJ+w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=QTxEgkFrM1bQSzv6Ynoh5DiaoTy/sazJrYmiicn4/eYHfAkG4b4uQ0Qg1wvtXoqvx
	 ermfJCOgWDdLIpY8UblvMRexy2tGDF6D8hkp9O31iz5HFKzvO7hZxuhEtTlvcp8tcM
	 wS/Fz0bAfgl+AD5RSEPJkfJQ1HrHx5eBo8coIahg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfDAIyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60558 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfDAIx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=m+7SrZ8XDtgtXxfCkruZk46t8DZh6WWq680w6aTE+88=; b=BLeoDCToeC/i
        X/JcuzZZmq+34PBR/6Oe6Armj51p7ZQFRMLGi1PIB/FkvOursaD6oRU/gz/SoR2VzG8lKR6EZQ4Cf
        mexDHs9aDneLvNn1ykU69vCpYUDZcP5vbo4G/KIhM8PC98NEPPuEtbj1S/DorjiuYXqynFSbPT47W
        go71U=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAshW-0008Os-Uy; Mon, 01 Apr 2019 08:53:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 11DBF440082; Mon,  1 Apr 2019 09:53:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps6507x: Convert to regulator core's simplified DT parsing code" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190401085352.11DBF440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:53:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps6507x: Convert to regulator core's simplified DT parsing code

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

From f979c08f762441188abb9be42689a72953efbbf7 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Mar 2019 20:02:25 +0800
Subject: [PATCH] regulator: tps6507x: Convert to regulator core's simplified
 DT parsing code

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps6507x-regulator.c | 107 +++++--------------------
 1 file changed, 19 insertions(+), 88 deletions(-)

diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index 4dbb22685539..a1b7fab91dd4 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -358,66 +358,20 @@ static const struct regulator_ops tps6507x_pmic_ops = {
 	.map_voltage = regulator_map_voltage_ascend,
 };
 
-static struct of_regulator_match tps6507x_matches[] = {
-	{ .name = "VDCDC1"},
-	{ .name = "VDCDC2"},
-	{ .name = "VDCDC3"},
-	{ .name = "LDO1"},
-	{ .name = "LDO2"},
-};
-
-static struct tps6507x_board *tps6507x_parse_dt_reg_data(
-		struct platform_device *pdev,
-		struct of_regulator_match **tps6507x_reg_matches)
+static int tps6507x_pmic_of_parse_cb(struct device_node *np,
+				     const struct regulator_desc *desc,
+				     struct regulator_config *config)
 {
-	struct tps6507x_board *tps_board;
-	struct device_node *np = pdev->dev.parent->of_node;
-	struct device_node *regulators;
-	struct of_regulator_match *matches;
-	struct regulator_init_data *reg_data;
-	int idx = 0, count, ret;
-
-	tps_board = devm_kzalloc(&pdev->dev, sizeof(*tps_board),
-					GFP_KERNEL);
-	if (!tps_board)
-		return NULL;
-
-	regulators = of_get_child_by_name(np, "regulators");
-	if (!regulators) {
-		dev_err(&pdev->dev, "regulator node not found\n");
-		return NULL;
-	}
-
-	count = ARRAY_SIZE(tps6507x_matches);
-	matches = tps6507x_matches;
-
-	ret = of_regulator_match(&pdev->dev, regulators, matches, count);
-	of_node_put(regulators);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Error parsing regulator init data: %d\n",
-			ret);
-		return NULL;
-	}
-
-	*tps6507x_reg_matches = matches;
-
-	reg_data = devm_kzalloc(&pdev->dev, (sizeof(struct regulator_init_data)
-					* TPS6507X_NUM_REGULATOR), GFP_KERNEL);
-	if (!reg_data)
-		return NULL;
-
-	tps_board->tps6507x_pmic_init_data = reg_data;
-
-	for (idx = 0; idx < count; idx++) {
-		if (!matches[idx].init_data || !matches[idx].of_node)
-			continue;
-
-		memcpy(&reg_data[idx], matches[idx].init_data,
-				sizeof(struct regulator_init_data));
+	struct tps6507x_pmic *tps = config->driver_data;
+	struct tps_info *info = tps->info[desc->id];
+	u32 prop;
+	int ret;
 
-	}
+	ret = of_property_read_u32(np, "ti,defdcdc_default", &prop);
+	if (!ret)
+		info->defdcdc_default = prop;
 
-	return tps_board;
+	return 0;
 }
 
 static int tps6507x_pmic_probe(struct platform_device *pdev)
@@ -425,14 +379,11 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 	struct tps6507x_dev *tps6507x_dev = dev_get_drvdata(pdev->dev.parent);
 	struct tps_info *info = &tps6507x_pmic_regs[0];
 	struct regulator_config config = { };
-	struct regulator_init_data *init_data;
+	struct regulator_init_data *init_data = NULL;
 	struct regulator_dev *rdev;
 	struct tps6507x_pmic *tps;
 	struct tps6507x_board *tps_board;
-	struct of_regulator_match *tps6507x_reg_matches = NULL;
 	int i;
-	int error;
-	unsigned int prop;
 
 	/**
 	 * tps_board points to pmic related constants
@@ -440,20 +391,8 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 	 */
 
 	tps_board = dev_get_platdata(tps6507x_dev->dev);
-	if (IS_ENABLED(CONFIG_OF) && !tps_board &&
-		tps6507x_dev->dev->of_node)
-		tps_board = tps6507x_parse_dt_reg_data(pdev,
-				&tps6507x_reg_matches);
-	if (!tps_board)
-		return -EINVAL;
-
-	/**
-	 * init_data points to array of regulator_init structures
-	 * coming from the board-evm file.
-	 */
-	init_data = tps_board->tps6507x_pmic_init_data;
-	if (!init_data)
-		return -EINVAL;
+	if (tps_board)
+		init_data = tps_board->tps6507x_pmic_init_data;
 
 	tps = devm_kzalloc(&pdev->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -467,13 +406,16 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 	for (i = 0; i < TPS6507X_NUM_REGULATOR; i++, info++, init_data++) {
 		/* Register the regulators */
 		tps->info[i] = info;
-		if (init_data->driver_data) {
+		if (init_data && init_data->driver_data) {
 			struct tps6507x_reg_platform_data *data =
 					init_data->driver_data;
-			tps->info[i]->defdcdc_default = data->defdcdc_default;
+			info->defdcdc_default = data->defdcdc_default;
 		}
 
 		tps->desc[i].name = info->name;
+		tps->desc[i].of_match = of_match_ptr(info->name);
+		tps->desc[i].regulators_node = of_match_ptr("regulators");
+		tps->desc[i].of_parse_cb = tps6507x_pmic_of_parse_cb;
 		tps->desc[i].id = i;
 		tps->desc[i].n_voltages = info->table_len;
 		tps->desc[i].volt_table = info->table;
@@ -485,17 +427,6 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 		config.init_data = init_data;
 		config.driver_data = tps;
 
-		if (tps6507x_reg_matches) {
-			error = of_property_read_u32(
-				tps6507x_reg_matches[i].of_node,
-					"ti,defdcdc_default", &prop);
-
-			if (!error)
-				tps->info[i]->defdcdc_default = prop;
-
-			config.of_node = tps6507x_reg_matches[i].of_node;
-		}
-
 		rdev = devm_regulator_register(&pdev->dev, &tps->desc[i],
 					       &config);
 		if (IS_ERR(rdev)) {
-- 
2.20.1

