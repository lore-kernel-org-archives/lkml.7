Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3B2C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CD72089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271745;
	bh=K2ySgkkJ/vVyb5H6n7ZlgvywQ0H1fvKofiIswVl6OwA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aIJ9OpWJnDWqYXbeYhnZgDEpY5Hpqo7o+D/ijwFgHlG+w+q82hkrOCO3trSd4DxnI
	 aY2CYoTCRYgerL16Ak39BpxeuQLjziMetEsOap1G+UfXCy7pUXNVG3FhwUriO2+sO8
	 YuduRpyEPuqD4aDjcEPhF+FXVnx7ZGN+UgCE8OWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfDZJmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:42:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47442 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfDZJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3ohanWmhL3ADLMG2WPamJnmRoopc2IqEaIFGICbebAA=; b=F65+DhzwGQVh
        CENgZRuKphVpQt6ofbbFhrLcb2NNuGalvY4Cpx9v2cJEv/nVvndW6jgx27wgXuE8+UO2HewsRtKxr
        SKSCHmpJFhXY2mDaSydG9ox5GxT3zJ0jJZz172+76/D9GsOkUmnv+S7igKivPine65pli0kjtbGY0
        Q6vek=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxMC-0003LX-6p; Fri, 26 Apr 2019 09:41:24 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DBA0B441D3B; Fri, 26 Apr 2019 10:41:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: db8500-prcmu: Convert to use simplified DT parsing" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094122.DBA0B441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:41:22 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: db8500-prcmu: Convert to use simplified DT parsing

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

From 92722a8fac5349fa2f249dcb366c6083d193922f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 12 Apr 2019 09:54:20 +0800
Subject: [PATCH] regulator: db8500-prcmu: Convert to use simplified DT parsing

Use regulator core's simplified DT parsing code to simplify the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/db8500-prcmu.c | 139 ++++++++++---------------------
 1 file changed, 42 insertions(+), 97 deletions(-)

diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index 863bd3de42a7..c2a3ccfc510e 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -214,6 +214,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VAPE] = {
 		.desc = {
 			.name	= "db8500-vape",
+			.of_match = of_match_ptr("db8500_vape"),
 			.id	= DB8500_REGULATOR_VAPE,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -223,6 +224,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VARM] = {
 		.desc = {
 			.name	= "db8500-varm",
+			.of_match = of_match_ptr("db8500_varm"),
 			.id	= DB8500_REGULATOR_VARM,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -232,6 +234,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VMODEM] = {
 		.desc = {
 			.name	= "db8500-vmodem",
+			.of_match = of_match_ptr("db8500_vmodem"),
 			.id	= DB8500_REGULATOR_VMODEM,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -241,6 +244,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VPLL] = {
 		.desc = {
 			.name	= "db8500-vpll",
+			.of_match = of_match_ptr("db8500_vpll"),
 			.id	= DB8500_REGULATOR_VPLL,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -250,6 +254,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VSMPS1] = {
 		.desc = {
 			.name	= "db8500-vsmps1",
+			.of_match = of_match_ptr("db8500_vsmps1"),
 			.id	= DB8500_REGULATOR_VSMPS1,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -259,6 +264,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VSMPS2] = {
 		.desc = {
 			.name	= "db8500-vsmps2",
+			.of_match = of_match_ptr("db8500_vsmps2"),
 			.id	= DB8500_REGULATOR_VSMPS2,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -271,6 +277,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VSMPS3] = {
 		.desc = {
 			.name	= "db8500-vsmps3",
+			.of_match = of_match_ptr("db8500_vsmps3"),
 			.id	= DB8500_REGULATOR_VSMPS3,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -280,6 +287,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_VRF1] = {
 		.desc = {
 			.name	= "db8500-vrf1",
+			.of_match = of_match_ptr("db8500_vrf1"),
 			.id	= DB8500_REGULATOR_VRF1,
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -289,6 +297,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SVAMMDSP] = {
 		.desc = {
 			.name	= "db8500-sva-mmdsp",
+			.of_match = of_match_ptr("db8500_sva_mmdsp"),
 			.id	= DB8500_REGULATOR_SWITCH_SVAMMDSP,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -299,6 +308,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SVAMMDSPRET] = {
 		.desc = {
 			.name	= "db8500-sva-mmdsp-ret",
+			.of_match = of_match_ptr("db8500_sva_mmdsp_ret"),
 			.id	= DB8500_REGULATOR_SWITCH_SVAMMDSPRET,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -310,6 +320,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SVAPIPE] = {
 		.desc = {
 			.name	= "db8500-sva-pipe",
+			.of_match = of_match_ptr("db8500_sva_pipe"),
 			.id	= DB8500_REGULATOR_SWITCH_SVAPIPE,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -320,6 +331,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SIAMMDSP] = {
 		.desc = {
 			.name	= "db8500-sia-mmdsp",
+			.of_match = of_match_ptr("db8500_sia_mmdsp"),
 			.id	= DB8500_REGULATOR_SWITCH_SIAMMDSP,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -330,6 +342,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SIAMMDSPRET] = {
 		.desc = {
 			.name	= "db8500-sia-mmdsp-ret",
+			.of_match = of_match_ptr("db8500_sia_mmdsp_ret"),
 			.id	= DB8500_REGULATOR_SWITCH_SIAMMDSPRET,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -341,6 +354,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SIAPIPE] = {
 		.desc = {
 			.name	= "db8500-sia-pipe",
+			.of_match = of_match_ptr("db8500_sia_pipe"),
 			.id	= DB8500_REGULATOR_SWITCH_SIAPIPE,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -351,6 +365,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_SGA] = {
 		.desc = {
 			.name	= "db8500-sga",
+			.of_match = of_match_ptr("db8500_sga"),
 			.id	= DB8500_REGULATOR_SWITCH_SGA,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -361,6 +376,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_B2R2_MCDE] = {
 		.desc = {
 			.name	= "db8500-b2r2-mcde",
+			.of_match = of_match_ptr("db8500_b2r2_mcde"),
 			.id	= DB8500_REGULATOR_SWITCH_B2R2_MCDE,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -371,6 +387,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_ESRAM12] = {
 		.desc = {
 			.name	= "db8500-esram12",
+			.of_match = of_match_ptr("db8500_esram12"),
 			.id	= DB8500_REGULATOR_SWITCH_ESRAM12,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -382,6 +399,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_ESRAM12RET] = {
 		.desc = {
 			.name	= "db8500-esram12-ret",
+			.of_match = of_match_ptr("db8500_esram12_ret"),
 			.id	= DB8500_REGULATOR_SWITCH_ESRAM12RET,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -393,6 +411,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_ESRAM34] = {
 		.desc = {
 			.name	= "db8500-esram34",
+			.of_match = of_match_ptr("db8500_esram34"),
 			.id	= DB8500_REGULATOR_SWITCH_ESRAM34,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -404,6 +423,7 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	[DB8500_REGULATOR_SWITCH_ESRAM34RET] = {
 		.desc = {
 			.name	= "db8500-esram34-ret",
+			.of_match = of_match_ptr("db8500_esram34_ret"),
 			.id	= DB8500_REGULATOR_SWITCH_ESRAM34RET,
 			.ops	= &db8500_regulator_switch_ops,
 			.type	= REGULATOR_VOLTAGE,
@@ -414,113 +434,38 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 	},
 };
 
-static int db8500_regulator_register(struct platform_device *pdev,
-					struct regulator_init_data *init_data,
-					int id,
-					struct device_node *np)
+static int db8500_regulator_probe(struct platform_device *pdev)
 {
+	struct regulator_init_data *db8500_init_data;
 	struct dbx500_regulator_info *info;
 	struct regulator_config config = { };
-	int err;
-
-	/* assign per-regulator data */
-	info = &dbx500_regulator_info[id];
-	info->dev = &pdev->dev;
-
-	config.dev = &pdev->dev;
-	config.init_data = init_data;
-	config.driver_data = info;
-	config.of_node = np;
-
-	/* register with the regulator framework */
-	info->rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
-	if (IS_ERR(info->rdev)) {
-		err = PTR_ERR(info->rdev);
-		dev_err(&pdev->dev, "failed to register %s: err %i\n",
-			info->desc.name, err);
-		return err;
-	}
-
-	dev_dbg(rdev_get_dev(info->rdev),
-		"regulator-%s-probed\n", info->desc.name);
+	int err, i;
 
-	return 0;
-}
-
-static struct of_regulator_match db8500_regulator_matches[] = {
-	{ .name	= "db8500_vape",          .driver_data = (void *) DB8500_REGULATOR_VAPE, },
-	{ .name	= "db8500_varm",          .driver_data = (void *) DB8500_REGULATOR_VARM, },
-	{ .name	= "db8500_vmodem",        .driver_data = (void *) DB8500_REGULATOR_VMODEM, },
-	{ .name	= "db8500_vpll",          .driver_data = (void *) DB8500_REGULATOR_VPLL, },
-	{ .name	= "db8500_vsmps1",        .driver_data = (void *) DB8500_REGULATOR_VSMPS1, },
-	{ .name	= "db8500_vsmps2",        .driver_data = (void *) DB8500_REGULATOR_VSMPS2, },
-	{ .name	= "db8500_vsmps3",        .driver_data = (void *) DB8500_REGULATOR_VSMPS3, },
-	{ .name	= "db8500_vrf1",          .driver_data = (void *) DB8500_REGULATOR_VRF1, },
-	{ .name	= "db8500_sva_mmdsp",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSP, },
-	{ .name	= "db8500_sva_mmdsp_ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSPRET, },
-	{ .name	= "db8500_sva_pipe",      .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAPIPE, },
-	{ .name	= "db8500_sia_mmdsp",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSP, },
-	{ .name	= "db8500_sia_mmdsp_ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSPRET, },
-	{ .name	= "db8500_sia_pipe",      .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAPIPE, },
-	{ .name	= "db8500_sga",           .driver_data = (void *) DB8500_REGULATOR_SWITCH_SGA, },
-	{ .name	= "db8500_b2r2_mcde",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_B2R2_MCDE, },
-	{ .name	= "db8500_esram12",       .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12, },
-	{ .name	= "db8500_esram12_ret",   .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12RET, },
-	{ .name	= "db8500_esram34",       .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34, },
-	{ .name	= "db8500_esram34_ret",   .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34RET, },
-};
-
-static int
-db8500_regulator_of_probe(struct platform_device *pdev,
-			struct device_node *np)
-{
-	int i, err;
+	db8500_init_data = dev_get_platdata(&pdev->dev);
 
 	for (i = 0; i < ARRAY_SIZE(dbx500_regulator_info); i++) {
-		err = db8500_regulator_register(
-			pdev, db8500_regulator_matches[i].init_data,
-			i, db8500_regulator_matches[i].of_node);
-		if (err)
+		/* assign per-regulator data */
+		info = &dbx500_regulator_info[i];
+		info->dev = &pdev->dev;
+
+		config.driver_data = info;
+		config.dev = &pdev->dev;
+		if (db8500_init_data)
+			config.init_data = &db8500_init_data[i];
+
+		info->rdev = devm_regulator_register(&pdev->dev, &info->desc,
+						     &config);
+		if (IS_ERR(info->rdev)) {
+			err = PTR_ERR(info->rdev);
+			dev_err(&pdev->dev, "failed to register %s: err %i\n",
+				info->desc.name, err);
 			return err;
-	}
-
-	return 0;
-}
-
-static int db8500_regulator_probe(struct platform_device *pdev)
-{
-	struct regulator_init_data *db8500_init_data =
-					dev_get_platdata(&pdev->dev);
-	struct device_node *np = pdev->dev.of_node;
-	int i, err;
-
-	/* register all regulators */
-	if (np) {
-		err = of_regulator_match(&pdev->dev, np,
-					db8500_regulator_matches,
-					ARRAY_SIZE(db8500_regulator_matches));
-		if (err < 0) {
-			dev_err(&pdev->dev,
-				"Error parsing regulator init data: %d\n", err);
-			return err;
-		}
-
-		err = db8500_regulator_of_probe(pdev, np);
-		if (err)
-			return err;
-	} else {
-		for (i = 0; i < ARRAY_SIZE(dbx500_regulator_info); i++) {
-			err = db8500_regulator_register(pdev,
-							&db8500_init_data[i],
-							i, NULL);
-			if (err)
-				return err;
 		}
+		dev_dbg(&pdev->dev, "regulator-%s-probed\n", info->desc.name);
 	}
 
-	err = ux500_regulator_debug_init(pdev,
-					 dbx500_regulator_info,
-					 ARRAY_SIZE(dbx500_regulator_info));
+	ux500_regulator_debug_init(pdev, dbx500_regulator_info,
+				   ARRAY_SIZE(dbx500_regulator_info));
 	return 0;
 }
 
-- 
2.20.1

