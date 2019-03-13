Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EB9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D41206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491558;
	bh=dsFHWKjXC3Fj8Lrp7SfA7lg3l+hNLm8msdUZd5d+esI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ODeRv4dO6QV8QxvQi381JYUwnA7779pfm/rFWgM9pRPkGb33DYMvxGNpGvDmSHcRe
	 uaQjjiOYIfExRrHtb2/v/vaHMM73mPhoEQuV9MbE5/GfQ01JsIjZWwRGlakIucRS1a
	 rhxLU2r/K4XLLO2ezfYBoGS8K9dx8AkCYNSUiPi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCMPjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49976 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfCMPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SbFjb5Q5OX3/DtwV0XY2ZVhiipH9DMsQHZFXhqU8CnM=; b=VTRD9E+geVz4
        Zag6Og1qBDWqHg4NBcTKoA+EEbtWpnZpzImneHvArcynbp6cZMwlHfrnZF2v3iwNa+H0T4XfbbV0g
        B4lkeUguEylQEkBJIlHbWWReK27Qrlxh67ZYYfkdARpSLmJrg8TR1fyJuccttbC3Yb2wym17jgJmP
        uDl98=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45yF-0003S9-P1; Wed, 13 Mar 2019 15:39:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 28D4C1128B97; Wed, 13 Mar 2019 15:39:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm831x-isink: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190313153907.28D4C1128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:39:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm831x-isink: Convert to use regulator_set/get_current_limit_regmap

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

From d48acfd0377f901f348b6c48bdcc03723f19d9e7 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 13 Mar 2019 00:33:56 +0800
Subject: [PATCH] regulator: wm831x-isink: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/wm831x-core.c            |  2 +-
 drivers/regulator/wm831x-isink.c     | 45 +++++-----------------------
 include/linux/mfd/wm831x/regulator.h |  2 +-
 3 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index e70d35ef5c6d..e865a1fd4bd5 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -33,7 +33,7 @@
 /* Current settings - values are 2*2^(reg_val/4) microamps.  These are
  * exported since they are used by multiple drivers.
  */
-int wm831x_isinkv_values[WM831X_ISINK_MAX_ISEL + 1] = {
+const unsigned int wm831x_isinkv_values[WM831X_ISINK_MAX_ISEL + 1] = {
 	2,
 	2,
 	3,
diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index 5611890a724b..bdc521a6f048 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -92,48 +92,12 @@ static int wm831x_isink_is_enabled(struct regulator_dev *rdev)
 		return 0;
 }
 
-static int wm831x_isink_set_current(struct regulator_dev *rdev,
-				    int min_uA, int max_uA)
-{
-	struct wm831x_isink *isink = rdev_get_drvdata(rdev);
-	struct wm831x *wm831x = isink->wm831x;
-	int ret, i;
-
-	for (i = ARRAY_SIZE(wm831x_isinkv_values) - 1; i >= 0; i--) {
-		int val = wm831x_isinkv_values[i];
-		if (min_uA <= val && val <= max_uA) {
-			ret = wm831x_set_bits(wm831x, isink->reg,
-					      WM831X_CS1_ISEL_MASK, i);
-			return ret;
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int wm831x_isink_get_current(struct regulator_dev *rdev)
-{
-	struct wm831x_isink *isink = rdev_get_drvdata(rdev);
-	struct wm831x *wm831x = isink->wm831x;
-	int ret;
-
-	ret = wm831x_reg_read(wm831x, isink->reg);
-	if (ret < 0)
-		return ret;
-
-	ret &= WM831X_CS1_ISEL_MASK;
-	if (ret > WM831X_ISINK_MAX_ISEL)
-		ret = WM831X_ISINK_MAX_ISEL;
-
-	return wm831x_isinkv_values[ret];
-}
-
 static const struct regulator_ops wm831x_isink_ops = {
 	.is_enabled = wm831x_isink_is_enabled,
 	.enable = wm831x_isink_enable,
 	.disable = wm831x_isink_disable,
-	.set_current_limit = wm831x_isink_set_current,
-	.get_current_limit = wm831x_isink_get_current,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 static irqreturn_t wm831x_isink_irq(int irq, void *data)
@@ -189,10 +153,15 @@ static int wm831x_isink_probe(struct platform_device *pdev)
 	isink->desc.ops = &wm831x_isink_ops;
 	isink->desc.type = REGULATOR_CURRENT;
 	isink->desc.owner = THIS_MODULE;
+	isink->desc.curr_table = wm831x_isinkv_values,
+	isink->desc.n_current_limits = ARRAY_SIZE(wm831x_isinkv_values),
+	isink->desc.csel_reg = isink->reg,
+	isink->desc.csel_mask = WM831X_CS1_ISEL_MASK,
 
 	config.dev = pdev->dev.parent;
 	config.init_data = pdata->isink[id];
 	config.driver_data = isink;
+	config.regmap = wm831x->regmap;
 
 	isink->regulator = devm_regulator_register(&pdev->dev, &isink->desc,
 						   &config);
diff --git a/include/linux/mfd/wm831x/regulator.h b/include/linux/mfd/wm831x/regulator.h
index 955d30fc6a27..30c587a0624c 100644
--- a/include/linux/mfd/wm831x/regulator.h
+++ b/include/linux/mfd/wm831x/regulator.h
@@ -1213,6 +1213,6 @@
 #define WM831X_LDO1_OK_WIDTH                         1  /* LDO1_OK */
 
 #define WM831X_ISINK_MAX_ISEL 55
-extern int wm831x_isinkv_values[WM831X_ISINK_MAX_ISEL + 1];
+extern const unsigned int wm831x_isinkv_values[WM831X_ISINK_MAX_ISEL + 1];
 
 #endif
-- 
2.20.1

