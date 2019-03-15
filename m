Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75982218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552670379;
	bh=QzyYDPuJPtL1mq3awTKGRTam/CSuQrKjjbqA5yFRiiU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=iaHe2l3nXwPGiq1DT9snNkx/PlWFOsGmtvFfsafQ+8iosMKNIw+3+8Ym3Bj3GGtk0
	 24EQNSmw65i3sc6bi8/jf6wow98KEpuHPTltRJrdc3fMfCyAdJbVEW9VklcJSWGSO5
	 cPHp8md9caxZIY7xkziajDtfK/VDnrvtP14h4wqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfCORT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:19:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54192 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfCORT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kDulF47xHOanywE7GT3TZ1yXcBQoKY1x3dDQBafVivQ=; b=xl2BIALRtnXh
        YTydvb1SP+/JshdbmHP+0UIQAl6TveWU/0XAwrzaFMSZLjBkGdrEZwJnyILq9JhtBZgIv4DbHFj40
        /sPsDIZ2ny8Uhr9G/9Ejpiq9e98TI7meQMITwPXlelB+CnJVZ36nA/6b3bBgz7EnuamtJWpj5NNK6
        ExWDw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4qUQ-0002ey-2N; Fri, 15 Mar 2019 17:19:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 77A0E1126E81; Fri, 15 Mar 2019 17:19:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9052: Convert to regulator core's simplified DT parsing code" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190315171925.77A0E1126E81@debutante.sirena.org.uk>
Date:   Fri, 15 Mar 2019 17:19:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9052: Convert to regulator core's simplified DT parsing code

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

From 67ddc68a78b1b762a8799a8cd9c075c7edcd546a Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 12 Mar 2019 23:47:58 +0800
Subject: [PATCH] regulator: da9052: Convert to regulator core's simplified DT
 parsing code

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9052-regulator.c | 33 +++++-----------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index cefa3558236d..98d486372b8c 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -294,6 +294,8 @@ static const struct regulator_ops da9052_ldo_ops = {
 {\
 	.reg_desc = {\
 		.name = #_name,\
+		.of_match = of_match_ptr(#_name),\
+		.regulators_node = of_match_ptr("regulators"),\
 		.ops = &da9052_ldo_ops,\
 		.type = REGULATOR_VOLTAGE,\
 		.id = DA9052_ID_##_id,\
@@ -314,6 +316,8 @@ static const struct regulator_ops da9052_ldo_ops = {
 {\
 	.reg_desc = {\
 		.name = #_name,\
+		.of_match = of_match_ptr(#_name),\
+		.regulators_node = of_match_ptr("regulators"),\
 		.ops = &da9052_dcdc_ops,\
 		.type = REGULATOR_VOLTAGE,\
 		.id = DA9052_ID_##_id,\
@@ -417,36 +421,11 @@ static int da9052_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	config.dev = &pdev->dev;
+	config.dev = da9052->dev;
 	config.driver_data = regulator;
 	config.regmap = da9052->regmap;
-	if (pdata) {
+	if (pdata)
 		config.init_data = pdata->regulators[cell->id];
-	} else {
-#ifdef CONFIG_OF
-		struct device_node *nproot = da9052->dev->of_node;
-		struct device_node *np;
-
-		if (!nproot)
-			return -ENODEV;
-
-		nproot = of_get_child_by_name(nproot, "regulators");
-		if (!nproot)
-			return -ENODEV;
-
-		for_each_child_of_node(nproot, np) {
-			if (of_node_name_eq(np,
-					 regulator->info->reg_desc.name)) {
-				config.init_data = of_get_regulator_init_data(
-					&pdev->dev, np,
-					&regulator->info->reg_desc);
-				config.of_node = np;
-				break;
-			}
-		}
-		of_node_put(nproot);
-#endif
-	}
 
 	regulator->rdev = devm_regulator_register(&pdev->dev,
 						  &regulator->info->reg_desc,
-- 
2.20.1

