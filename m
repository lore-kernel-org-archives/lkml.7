Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD42C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D8C20811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578916;
	bh=iCcWqZTOFaYSDG0e8LMxOQo/0V0ET2PgvAmBTAxXx0A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Zy+O+IG1HGbc9iFnW5M6o0v+7Km7gdyBUT7jYQ4tct5viRQamxHbDNxI0olQBe05k
	 GqOQUfeee1zq0fjILN7sdZTecM70oWq+B8tTRmT25ACp/Z4cLftZSZvbTZL9GGtv+l
	 PFvOcKk3G2Cio7hlfzAfQxD9YSJu98APKcYsiUwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfCNPyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:54:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36384 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfCNPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lhiq78Xx/BO7sCW6XVz8LaJ4YnKcUhnVlL/dlC/hRMk=; b=h9A+iGjA/9ev
        AoJXP+C2RSkk6xiiztnev6FHDAJzeaxAxuJUE2CE8QqHO+51Nuz6kL17Kv7C+BdDZkju8ZSTfVU3b
        B6wq3uvwgMe08PQ/yFj/eOjshg+FZ3As1rHfDEisIOztlyLXxcl0WjYVRg30aIQaQBJRIpii4Oh84
        a8nCs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4Sgg-0002jh-Sv; Thu, 14 Mar 2019 15:54:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5019E1126E64; Thu, 14 Mar 2019 15:54:30 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: gpio: Convert to devm_regulator_register" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190314155430.5019E1126E64@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:54:30 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: gpio: Convert to devm_regulator_register

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

From 7cdc2ee7bf10705f737c22dcd4b002b87849badb Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 8 Mar 2019 14:15:28 +0800
Subject: [PATCH] regulator: gpio: Convert to devm_regulator_register

Use devm_regulator_register to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/gpio-regulator.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 6157001df0a4..967338bf1dc1 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -36,7 +36,6 @@
 
 struct gpio_regulator_data {
 	struct regulator_desc desc;
-	struct regulator_dev *dev;
 
 	struct gpio_desc **gpiods;
 	int nr_gpios;
@@ -233,6 +232,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct gpio_regulator_data *drvdata;
 	struct regulator_config cfg = { };
+	struct regulator_dev *rdev;
 	enum gpiod_flags gflags;
 	int ptr, ret, state, i;
 
@@ -326,9 +326,9 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg.ena_gpiod))
 		return PTR_ERR(cfg.ena_gpiod);
 
-	drvdata->dev = regulator_register(&drvdata->desc, &cfg);
-	if (IS_ERR(drvdata->dev)) {
-		ret = PTR_ERR(drvdata->dev);
+	rdev = devm_regulator_register(dev, &drvdata->desc, &cfg);
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
 		dev_err(dev, "Failed to register regulator: %d\n", ret);
 		return ret;
 	}
@@ -338,15 +338,6 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int gpio_regulator_remove(struct platform_device *pdev)
-{
-	struct gpio_regulator_data *drvdata = platform_get_drvdata(pdev);
-
-	regulator_unregister(drvdata->dev);
-
-	return 0;
-}
-
 #if defined(CONFIG_OF)
 static const struct of_device_id regulator_gpio_of_match[] = {
 	{ .compatible = "regulator-gpio", },
@@ -357,7 +348,6 @@ MODULE_DEVICE_TABLE(of, regulator_gpio_of_match);
 
 static struct platform_driver gpio_regulator_driver = {
 	.probe		= gpio_regulator_probe,
-	.remove		= gpio_regulator_remove,
 	.driver		= {
 		.name		= "gpio-regulator",
 		.of_match_table = of_match_ptr(regulator_gpio_of_match),
-- 
2.20.1

