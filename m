Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF225C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5F4206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271690;
	bh=5BGtr5FSnPaVIOUH+lM4TF35mFWmjxLjTOf5qbg3Uhc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=harKLBzk4DtQMa6vnsbgrgNmZMAkPXqwfetCo1JO2quyPfo/lFFXrHKGxs0Ap1M0o
	 8po8lO7c/kUYSYEX0M+Qyn15Orq0J5cITy8PEywGcawLT4xiNwKzipwKaMllS94Hd0
	 ZFuvXrpBQrAnLdoC7RLRVF4n4XTKA1Bo9vM9w73s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfDZJl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:41:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47408 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDZJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kJJ7X8ioZshO8HTrSNLCYRNrSMdqb6MfwaMtIScxi7M=; b=gFc5Y+kIEByZ
        +8U2ZKk37uxqlFKUipRWM4M1CMYakHJc0G0kIX4BXRWs3m1iFb2OZlbar3GVM/rGSiZ2R7/ZPrPPA
        Unh5Mom4CA9fHrnhxmzPAtMj+dWoywbycrmBmtU3L6xDFxsnND3LhazuyCRPjAq+txj9ZqAIP/Yrl
        +25D4=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxMA-0003LF-OB; Fri, 26 Apr 2019 09:41:22 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BF7E3441D3B; Fri, 26 Apr 2019 10:41:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab8500-ext: Convert to use simplified DT parsing" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094116.BF7E3441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:41:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500-ext: Convert to use simplified DT parsing

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

From 48cb9737edff831a6cd96bad7e9f9f612a7f3a9e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 12 Apr 2019 22:06:58 +0800
Subject: [PATCH] regulator: ab8500-ext: Convert to use simplified DT parsing

Use regulator core's simplified DT parsing code to simplify the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab8500-ext.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 89ddbabca2af..f232a7a90fd5 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -733,6 +733,7 @@ static struct ab8500_ext_regulator_info
 	[AB8500_EXT_SUPPLY1] = {
 		.desc = {
 			.name		= "VEXTSUPPLY1",
+			.of_match	= of_match_ptr("ab8500_ext1"),
 			.ops		= &ab8500_ext_regulator_ops,
 			.type		= REGULATOR_VOLTAGE,
 			.id		= AB8500_EXT_SUPPLY1,
@@ -750,6 +751,7 @@ static struct ab8500_ext_regulator_info
 	[AB8500_EXT_SUPPLY2] = {
 		.desc = {
 			.name		= "VEXTSUPPLY2",
+			.of_match	= of_match_ptr("ab8500_ext2"),
 			.ops		= &ab8500_ext_regulator_ops,
 			.type		= REGULATOR_VOLTAGE,
 			.id		= AB8500_EXT_SUPPLY2,
@@ -767,6 +769,7 @@ static struct ab8500_ext_regulator_info
 	[AB8500_EXT_SUPPLY3] = {
 		.desc = {
 			.name		= "VEXTSUPPLY3",
+			.of_match	= of_match_ptr("ab8500_ext3"),
 			.ops		= &ab8500_ext_regulator_ops,
 			.type		= REGULATOR_VOLTAGE,
 			.id		= AB8500_EXT_SUPPLY3,
@@ -783,31 +786,13 @@ static struct ab8500_ext_regulator_info
 	},
 };
 
-static struct of_regulator_match ab8500_ext_regulator_match[] = {
-	{ .name = "ab8500_ext1", .driver_data = (void *) AB8500_EXT_SUPPLY1, },
-	{ .name = "ab8500_ext2", .driver_data = (void *) AB8500_EXT_SUPPLY2, },
-	{ .name = "ab8500_ext3", .driver_data = (void *) AB8500_EXT_SUPPLY3, },
-};
-
 static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_regulator_platform_data *pdata = &ab8500_regulator_plat_data;
-	struct device_node *np = pdev->dev.of_node;
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	int i, err;
-
-	if (np) {
-		err = of_regulator_match(&pdev->dev, np,
-					 ab8500_ext_regulator_match,
-					 ARRAY_SIZE(ab8500_ext_regulator_match));
-		if (err < 0) {
-			dev_err(&pdev->dev,
-				"Error parsing regulator init data: %d\n", err);
-			return err;
-		}
-	}
+	int i;
 
 	if (!ab8500) {
 		dev_err(&pdev->dev, "null mfd parent\n");
@@ -843,10 +828,7 @@ static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 
 		config.dev = &pdev->dev;
 		config.driver_data = info;
-		config.of_node = ab8500_ext_regulator_match[i].of_node;
-		config.init_data = (np) ?
-			ab8500_ext_regulator_match[i].init_data :
-			&pdata->ext_regulator[i];
+		config.init_data = &pdata->ext_regulator[i];
 
 		/* register regulator with framework */
 		rdev = devm_regulator_register(&pdev->dev, &info->desc,
-- 
2.20.1

