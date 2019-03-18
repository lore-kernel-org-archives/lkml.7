Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0412C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E0C20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920711;
	bh=VkG6ufwtJ/zhnA65491ht4Rabjirz5I9HzFMHEtvdPU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vhRpmbVbW5gGdfE5s3HKRvfHFBmqPqAQrDpSHeDPMyR4X2Fxxd7IXvzS/PYDRlg4g
	 CCSIkH1ruY+xv+XB/Bot0uzUGZgBUVWvsWZI2VAyuATyJ7lDQQy/agTUNt+gkA1Pag
	 2SX0UBhhAcY7Ahs+ZXB15dR/VYj4iv5bjDJKDosI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfCROvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:51:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55406 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfCROvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GeAAkNqw4J9anL/FbZpqW+gWqxWqTaXKhfjPjsO9MtQ=; b=jESbaTOqrTlt
        Lmix1BP36B5BDLlb7PySvXDCeo8QjjvQJrI5PKgi7U/B+fmHbb/B2Xd7t25mXOPndmPjLu2CBluG8
        7mUUu42H8ghzYsmJpxKwttIvlg+fSU9ogCGND+moi10JuxxgnkpXdHRcfJX09+0suDo3cOZrQ6HlH
        VnZa8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tc9-0005ow-Gk; Mon, 18 Mar 2019 14:51:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 02EB41128874; Mon, 18 Mar 2019 14:51:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: as3711: Remove struct as3711_regulator_info and as3711_regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190318145145.02EB41128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: as3711: Remove struct as3711_regulator_info and as3711_regulator

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

From f668a1db0b30c62c2256cdcb2411c2630eb0e2f6 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 6 Mar 2019 09:01:02 +0800
Subject: [PATCH] regulator: as3711: Remove struct as3711_regulator_info and
 as3711_regulator

This driver does not really need struct as3711_regulator_info and
struct as3711_regulator, remove them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/as3711-regulator.c | 37 ++++++----------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/as3711-regulator.c b/drivers/regulator/as3711-regulator.c
index f7fe218bb3e4..ece88103f2fd 100644
--- a/drivers/regulator/as3711-regulator.c
+++ b/drivers/regulator/as3711-regulator.c
@@ -17,14 +17,6 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/slab.h>
 
-struct as3711_regulator_info {
-	struct regulator_desc	desc;
-};
-
-struct as3711_regulator {
-	struct as3711_regulator_info *reg_info;
-};
-
 /*
  * The regulator API supports 4 modes of operataion: FAST, NORMAL, IDLE and
  * STANDBY. We map them in the following way to AS3711 SD1-4 DCDC modes:
@@ -129,7 +121,6 @@ static const struct regulator_linear_range as3711_dldo_ranges[] = {
 
 #define AS3711_REG(_id, _en_reg, _en_bit, _vmask, _sfx)			   \
 	[AS3711_REGULATOR_ ## _id] = {					   \
-	.desc = {							   \
 		.name = "as3711-regulator-" # _id,			   \
 		.id = AS3711_REGULATOR_ ## _id,				   \
 		.n_voltages = (_vmask + 1),				   \
@@ -142,10 +133,9 @@ static const struct regulator_linear_range as3711_dldo_ranges[] = {
 		.enable_mask = BIT(_en_bit),				   \
 		.linear_ranges = as3711_ ## _sfx ## _ranges,		   \
 		.n_linear_ranges = ARRAY_SIZE(as3711_ ## _sfx ## _ranges), \
-	},								   \
 }
 
-static struct as3711_regulator_info as3711_reg_info[] = {
+static const struct regulator_desc as3711_reg_desc[] = {
 	AS3711_REG(SD_1, SD_CONTROL, 0, 0x7f, sd),
 	AS3711_REG(SD_2, SD_CONTROL, 1, 0x7f, sd),
 	AS3711_REG(SD_3, SD_CONTROL, 2, 0x7f, sd),
@@ -161,7 +151,7 @@ static struct as3711_regulator_info as3711_reg_info[] = {
 	/* StepUp output voltage depends on supplying regulator */
 };
 
-#define AS3711_REGULATOR_NUM ARRAY_SIZE(as3711_reg_info)
+#define AS3711_REGULATOR_NUM ARRAY_SIZE(as3711_reg_desc)
 
 static struct of_regulator_match
 as3711_regulator_matches[AS3711_REGULATOR_NUM] = {
@@ -215,11 +205,8 @@ static int as3711_regulator_probe(struct platform_device *pdev)
 	struct as3711_regulator_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct as3711 *as3711 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = {.dev = &pdev->dev,};
-	struct as3711_regulator *reg = NULL;
-	struct as3711_regulator *regs;
 	struct device_node *of_node[AS3711_REGULATOR_NUM] = {};
 	struct regulator_dev *rdev;
-	struct as3711_regulator_info *ri;
 	int ret;
 	int id;
 
@@ -236,30 +223,20 @@ static int as3711_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
-	regs = devm_kcalloc(&pdev->dev,
-			    AS3711_REGULATOR_NUM,
-			    sizeof(struct as3711_regulator),
-			    GFP_KERNEL);
-	if (!regs)
-		return -ENOMEM;
-
-	for (id = 0, ri = as3711_reg_info; id < AS3711_REGULATOR_NUM; ++id, ri++) {
-		reg = &regs[id];
-		reg->reg_info = ri;
-
+	for (id = 0; id < AS3711_REGULATOR_NUM; id++) {
 		config.init_data = pdata->init_data[id];
-		config.driver_data = reg;
 		config.regmap = as3711->regmap;
 		config.of_node = of_node[id];
 
-		rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
+		rdev = devm_regulator_register(&pdev->dev, &as3711_reg_desc[id],
+					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "Failed to register regulator %s\n",
-				ri->desc.name);
+				as3711_reg_desc[id].name);
 			return PTR_ERR(rdev);
 		}
 	}
-	platform_set_drvdata(pdev, regs);
+
 	return 0;
 }
 
-- 
2.20.1

