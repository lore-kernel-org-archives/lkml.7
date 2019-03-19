Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D566620857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553001244;
	bh=dslVCAR/Lt+48C/BTEF0s1iwDkCEZx9yweD4Swl49Nk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BCRErojXBr09ecWJ1Li9AZnccWcuM4B57odZmmNKtvpV1lork5iUUYQn1qsE9yCsh
	 JpsBGpXF7w/2j08PehGX1jTmk5BlQ3/bvkyBDcADaq17LQ7mXxjYEgvexZp0KIJGmf
	 ZxAN/YexpFslfW+Ttzy6YKvY9g04gjKF4Bi/rl1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfCSNOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:14:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49140 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfCSNNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=M4w7sC6Rp2zDsw5aXHSmY3GK0BBnNMRLvMbnxlegC4Q=; b=uUSiQDwWI2SF
        cSR/BR+RunGC1+X2nNrVk2kyCtrkNZQNv89jhKpiMWnF8vng5vJEXl4+L9Ch9X3eNADN4jAMzbflO
        qmRRuOUKaZ1yoQDToX2kCEJBCuZMBGCYo+Jnk4dxkctR3BtrFaCILYXYtJVl6OUOjTJKkhZDn1glJ
        +t5wQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6EYw-00039v-Pe; Tue, 19 Mar 2019 13:13:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6617111288DF; Tue, 19 Mar 2019 13:13:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: 88pm8607: Convert to regulator core's simplified DT parsing code" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190319131350.6617111288DF@debutante.sirena.org.uk>
Date:   Tue, 19 Mar 2019 13:13:50 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: 88pm8607: Convert to regulator core's simplified DT parsing code

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

From e66264273f5e2a6a12c558d78f829d1ea2383c5e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 19 Mar 2019 15:39:27 +0800
Subject: [PATCH] regulator: 88pm8607: Convert to regulator core's simplified
 DT parsing code

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/88pm8607.c | 43 ++++++++----------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 753a6a1b30c3..35d767aeeb57 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -235,6 +235,8 @@ static const struct regulator_ops pm8606_preg_ops = {
 {									\
 	.desc	= {							\
 		.name	= "PREG",					\
+		.of_match = of_match_ptr("PREG"),			\
+		.regulators_node = of_match_ptr("regulators"),		\
 		.ops	= &pm8606_preg_ops,				\
 		.type	= REGULATOR_CURRENT,				\
 		.id	= PM8606_ID_PREG,				\
@@ -249,6 +251,8 @@ static const struct regulator_ops pm8606_preg_ops = {
 {									\
 	.desc	= {							\
 		.name	= #vreg,					\
+		.of_match = of_match_ptr(#vreg),			\
+		.regulators_node = of_match_ptr("regulators"),		\
 		.ops	= &pm8607_regulator_ops,			\
 		.type	= REGULATOR_VOLTAGE,				\
 		.id	= PM8607_ID_##vreg,				\
@@ -270,6 +274,8 @@ static const struct regulator_ops pm8606_preg_ops = {
 {									\
 	.desc	= {							\
 		.name	= "LDO" #_id,					\
+		.of_match = of_match_ptr("LDO" #_id),			\
+		.regulators_node = of_match_ptr("regulators"),		\
 		.ops	= &pm8607_regulator_ops,			\
 		.type	= REGULATOR_VOLTAGE,				\
 		.id	= PM8607_ID_LDO##_id,				\
@@ -309,36 +315,6 @@ static struct pm8607_regulator_info pm8606_regulator_info[] = {
 	PM8606_PREG(PREREGULATORB, 5),
 };
 
-#ifdef CONFIG_OF
-static int pm8607_regulator_dt_init(struct platform_device *pdev,
-				    struct pm8607_regulator_info *info,
-				    struct regulator_config *config)
-{
-	struct device_node *nproot, *np;
-	nproot = pdev->dev.parent->of_node;
-	if (!nproot)
-		return -ENODEV;
-	nproot = of_get_child_by_name(nproot, "regulators");
-	if (!nproot) {
-		dev_err(&pdev->dev, "failed to find regulators node\n");
-		return -ENODEV;
-	}
-	for_each_child_of_node(nproot, np) {
-		if (of_node_name_eq(np, info->desc.name)) {
-			config->init_data =
-				of_get_regulator_init_data(&pdev->dev, np,
-							   &info->desc);
-			config->of_node = np;
-			break;
-		}
-	}
-	of_node_put(nproot);
-	return 0;
-}
-#else
-#define pm8607_regulator_dt_init(x, y, z)	(-1)
-#endif
-
 static int pm8607_regulator_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
@@ -373,12 +349,11 @@ static int pm8607_regulator_probe(struct platform_device *pdev)
 	if ((i == PM8607_ID_BUCK3) && chip->buck3_double)
 		info->slope_double = 1;
 
-	config.dev = &pdev->dev;
+	config.dev = chip->dev;
 	config.driver_data = info;
 
-	if (pm8607_regulator_dt_init(pdev, info, &config))
-		if (pdata)
-			config.init_data = pdata;
+	if (pdata)
+		config.init_data = pdata;
 
 	if (chip->id == CHIP_PM8607)
 		config.regmap = chip->regmap;
-- 
2.20.1

