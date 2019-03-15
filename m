Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FFB21019
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552670373;
	bh=RAORQaYniy2ImQ1EuGnpG22JfXRCQ3pIRDMcQiQDbKM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bdgTA3OxRZLgb8WpkVajZrIVEBo5uUgMwH4r1fkqau6uQy/3xBfg1Bf3cQCABntfH
	 JxElBK9AmdJztRlckcX9X4e4YDMrQULRL0PeVEGGwPeAYIRX6i9K/KAA2KvNFr685/
	 sZN7DzzrT+PMwaod53ANOPNFUky2B9H5rHoZa8TE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfCORTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:19:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54254 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfCORT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VwVBZq/1ZciebtstBWsnZK95wL18nb/xYIog7wjT/Mg=; b=nUK4rsj4Dlq0
        3Ot5Tf6oJBCV2xLsAVg77CwU4EG7HOS2MbdHF/D1xFZmm0dCCX82O5x6os84zQrYDqcm1V40V98Vo
        sHOkD/GwjjtZ9Qt/oW3BLwtwKI67x1A/RUidaPibuYVFpFe8ZH7RTwsRcEm/ZLOBF5JcYmYoe/rTs
        EmHfI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4qUR-0002f7-Mi; Fri, 15 Mar 2019 17:19:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 278781126E81; Fri, 15 Mar 2019 17:19:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: 88pm800: Get rid of struct pm800_regulators" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190315171927.278781126E81@debutante.sirena.org.uk>
Date:   Fri, 15 Mar 2019 17:19:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: 88pm800: Get rid of struct pm800_regulators

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

From 6cabb8b7fc1428eb573f426a17a853d81227d095 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 14 Mar 2019 19:55:19 +0800
Subject: [PATCH] regulator: 88pm800: Get rid of struct pm800_regulators

The struct pm800_regulators only has 2 members: *chip and *map.
The pm800_data->chip is not used. The pm800_data->map is not necessary.
Thus remove the struct pm800_regulators.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/88pm800.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index 89bbd6e8bad1..9fd379732d18 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -77,11 +77,6 @@ struct pm800_regulator_info {
 	int max_ua;
 };
 
-struct pm800_regulators {
-	struct pm80x_chip *chip;
-	struct regmap *map;
-};
-
 /*
  * vreg - the buck regs string.
  * ereg - the string for the enable register.
@@ -235,7 +230,6 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 {
 	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct pm80x_platform_data *pdata = dev_get_platdata(pdev->dev.parent);
-	struct pm800_regulators *pm800_data;
 	struct regulator_config config = { };
 	struct regulator_init_data *init_data;
 	int i, ret;
@@ -252,18 +246,8 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
-	pm800_data = devm_kzalloc(&pdev->dev, sizeof(*pm800_data),
-					GFP_KERNEL);
-	if (!pm800_data)
-		return -ENOMEM;
-
-	pm800_data->map = chip->subchip->regmap_power;
-	pm800_data->chip = chip;
-
-	platform_set_drvdata(pdev, pm800_data);
-
 	config.dev = chip->dev;
-	config.regmap = pm800_data->map;
+	config.regmap = chip->subchip->regmap_power;
 	for (i = 0; i < PM800_ID_RG_MAX; i++) {
 		struct regulator_dev *regulator;
 
-- 
2.20.1

