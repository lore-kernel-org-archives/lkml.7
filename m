Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01605C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA4221841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103061;
	bh=x7C2YdOec7R9Ah9jNok1E2HxOFp02pJlmRbc55cZ13Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=plUZGeO9/B/rUCJVxLjsPaN/GIgVenkmr+b5U/KqP0eZgH7OedPLRWFm2XRn6K7B8
	 aegHvc+Ykg9Fffz8duT5n3iHUBzeS+Twa0ZUwY5xl/tL0eBD2jjrLiNcogcPz98Ohi
	 3vJDmdOgFu1pQo6bpYXIGCOcAiq2xtSap2+6kwn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfCTR35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:29:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44178 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfCTR3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/hjtR/7Ivj8kdslXqk5ALCvQ/YSfVkbeVVNOQQXaw2Q=; b=Mqnd2xfBmr5s
        p4ZHIuCmUmABDP8KHSrxeCpo2nKRsICaEfVOD9JDJpTUb4zGqE8vgqKb9Vuf77JLxld3uzLxKGBbH
        VyGPqNpOyehb5kzoBRnoX81KHwP0J6ZwmS2lgbrrkm548KhJpYUnA/FWmVayq+QRvm/aGvUfwygCC
        8lOUA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f2F-00019P-Hp; Wed, 20 Mar 2019 17:29:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 301501126E4C; Wed, 20 Mar 2019 17:29:51 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max8925: Convert to regulator core's simplified DT parsing code" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190320172951.301501126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:29:51 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8925: Convert to regulator core's simplified DT parsing code

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

From 6185de50e441c3e6809a00d4f525ad2c344031f5 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 20 Mar 2019 19:40:23 +0800
Subject: [PATCH] regulator: max8925: Convert to regulator core's simplified DT
 parsing code

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8925-regulator.c | 76 ++++-----------------------
 1 file changed, 9 insertions(+), 67 deletions(-)

diff --git a/drivers/regulator/max8925-regulator.c b/drivers/regulator/max8925-regulator.c
index 39b63ddefeb2..aed6727982cd 100644
--- a/drivers/regulator/max8925-regulator.c
+++ b/drivers/regulator/max8925-regulator.c
@@ -159,6 +159,8 @@ static const struct regulator_ops max8925_regulator_ldo_ops = {
 {								\
 	.desc	= {						\
 		.name	= "SDV" #_id,				\
+		.of_match = of_match_ptr("SDV" #_id),		\
+		.regulators_node = of_match_ptr("regulators"),	\
 		.ops	= &max8925_regulator_sdv_ops,		\
 		.type	= REGULATOR_VOLTAGE,			\
 		.id	= MAX8925_ID_SD##_id,			\
@@ -175,6 +177,8 @@ static const struct regulator_ops max8925_regulator_ldo_ops = {
 {								\
 	.desc	= {						\
 		.name	= "LDO" #_id,				\
+		.of_match = of_match_ptr("LDO" #_id),		\
+		.regulators_node = of_match_ptr("regulators"),	\
 		.ops	= &max8925_regulator_ldo_ops,		\
 		.type	= REGULATOR_VOLTAGE,			\
 		.id	= MAX8925_ID_LDO##_id,			\
@@ -187,34 +191,6 @@ static const struct regulator_ops max8925_regulator_ldo_ops = {
 	.enable_reg	= MAX8925_LDOCTL##_id,			\
 }
 
-#ifdef CONFIG_OF
-static struct of_regulator_match max8925_regulator_matches[] = {
-	{ .name	= "SDV1",},
-	{ .name = "SDV2",},
-	{ .name = "SDV3",},
-	{ .name = "LDO1",},
-	{ .name = "LDO2",},
-	{ .name = "LDO3",},
-	{ .name = "LDO4",},
-	{ .name = "LDO5",},
-	{ .name = "LDO6",},
-	{ .name = "LDO7",},
-	{ .name = "LDO8",},
-	{ .name = "LDO9",},
-	{ .name = "LDO10",},
-	{ .name = "LDO11",},
-	{ .name = "LDO12",},
-	{ .name = "LDO13",},
-	{ .name = "LDO14",},
-	{ .name = "LDO15",},
-	{ .name = "LDO16",},
-	{ .name = "LDO17",},
-	{ .name = "LDO18",},
-	{ .name = "LDO19",},
-	{ .name = "LDO20",},
-};
-#endif
-
 static struct max8925_regulator_info max8925_regulator_info[] = {
 	MAX8925_SDV(1, 637.5, 1425, 12.5),
 	MAX8925_SDV(2,   650, 2225,   25),
@@ -242,37 +218,6 @@ static struct max8925_regulator_info max8925_regulator_info[] = {
 	MAX8925_LDO(20, 750, 3900, 50),
 };
 
-#ifdef CONFIG_OF
-static int max8925_regulator_dt_init(struct platform_device *pdev,
-				    struct regulator_config *config,
-				    int ridx)
-{
-	struct device_node *nproot, *np;
-	int rcount;
-
-	nproot = pdev->dev.parent->of_node;
-	if (!nproot)
-		return -ENODEV;
-	np = of_get_child_by_name(nproot, "regulators");
-	if (!np) {
-		dev_err(&pdev->dev, "failed to find regulators node\n");
-		return -ENODEV;
-	}
-
-	rcount = of_regulator_match(&pdev->dev, np,
-				&max8925_regulator_matches[ridx], 1);
-	of_node_put(np);
-	if (rcount < 0)
-		return rcount;
-	config->init_data =	max8925_regulator_matches[ridx].init_data;
-	config->of_node = max8925_regulator_matches[ridx].of_node;
-
-	return 0;
-}
-#else
-#define max8925_regulator_dt_init(x, y, z)	(-1)
-#endif
-
 static int max8925_regulator_probe(struct platform_device *pdev)
 {
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
@@ -281,7 +226,7 @@ static int max8925_regulator_probe(struct platform_device *pdev)
 	struct max8925_regulator_info *ri;
 	struct resource *res;
 	struct regulator_dev *rdev;
-	int i, regulator_idx;
+	int i;
 
 	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
 	if (!res) {
@@ -290,10 +235,8 @@ static int max8925_regulator_probe(struct platform_device *pdev)
 	}
 	for (i = 0; i < ARRAY_SIZE(max8925_regulator_info); i++) {
 		ri = &max8925_regulator_info[i];
-		if (ri->vol_reg == res->start) {
-			regulator_idx = i;
+		if (ri->vol_reg == res->start)
 			break;
-		}
 	}
 
 	if (i == ARRAY_SIZE(max8925_regulator_info)) {
@@ -303,12 +246,11 @@ static int max8925_regulator_probe(struct platform_device *pdev)
 	}
 	ri->i2c = chip->i2c;
 
-	config.dev = &pdev->dev;
+	config.dev = chip->dev;
 	config.driver_data = ri;
 
-	if (max8925_regulator_dt_init(pdev, &config, regulator_idx))
-		if (pdata)
-			config.init_data = pdata;
+	if (pdata)
+		config.init_data = pdata;
 
 	rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
 	if (IS_ERR(rdev)) {
-- 
2.20.1

