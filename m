Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBAB214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552325065;
	bh=xw2/qTapePECwqWQahtP8GDFFygFckLQT51mkfxDEDw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=pY+7xT3EcgXxJtNoapUR3QDAJ18XvRD38ivMy+2WSBjsgYBCZjois0PO2NQ5hugvD
	 ftTqsqah7rTif3qlZG+X8M4c4kgrxI7qJP7p2rXUtz+EXP907t9CPNZc/AeDSrlPCH
	 S8YqefBsX8cu85PsxRjro/GLKO8sLfhxIGt1G9Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfCKRYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:24:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51018 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfCKRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fopFGCtXNEBdeKtsnXb+sS4aQ15Gyklh0Tk9ehWpVWc=; b=IUu7CHsRGrV6
        2wQEcDnGgoztOyTzXyeWz8AHwR2jABLU/KyWSVDKUHhN3/B7ymqp19NUW8bqaqEBeQwZ0zuHwG+dC
        iXNFAN08nj0689DxaVGxSDwxcGYA6sdCwT99nIkCVLH8wn4HbjsjYlmjTCPeFgjJn2utpU6pvsQW6
        Li/NQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h3Oel-0005O4-LF; Mon, 11 Mar 2019 17:24:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2C00A1128896; Mon, 11 Mar 2019 17:24:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm8400: Get rid of wm8400_block_read/wm8400_set_bits functions" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190311172407.2C00A1128896@debutante.sirena.org.uk>
Date:   Mon, 11 Mar 2019 17:24:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm8400: Get rid of wm8400_block_read/wm8400_set_bits functions

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

From e08abeca39673e1045ca1e5a90bd7fef69d0fe8f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 27 Feb 2019 09:30:53 +0800
Subject: [PATCH] regulator: wm8400: Get rid of
 wm8400_block_read/wm8400_set_bits functions

The only user of wm8400_block_read/wm8400_set_bits functions is the
wm8400 regulator driver. At the context of all the callers, we can
use regmap_bulk_read/regmap_update_bits directly.
Thus remove wm8400_block_read/wm8400_set_bits functions.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/wm8400-core.c            |  6 ------
 drivers/regulator/wm8400-regulator.c | 17 ++++++++---------
 include/linux/mfd/wm8400-private.h   |  8 --------
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index 8a98a2fc74e1..7eab2bedad93 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -35,12 +35,6 @@ static bool wm8400_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-int wm8400_block_read(struct wm8400 *wm8400, u8 reg, int count, u16 *data)
-{
-	return regmap_bulk_read(wm8400->regmap, reg, data, count);
-}
-EXPORT_SYMBOL_GPL(wm8400_block_read);
-
 static int wm8400_register_codec(struct wm8400 *wm8400)
 {
 	const struct mfd_cell cell = {
diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index fb1837657b64..40c4e6628471 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -36,13 +36,12 @@ static const struct regulator_ops wm8400_ldo_ops = {
 
 static unsigned int wm8400_dcdc_get_mode(struct regulator_dev *dev)
 {
-	struct wm8400 *wm8400 = rdev_get_drvdata(dev);
+	struct regmap *rmap = rdev_get_regmap(dev);
 	int offset = (rdev_get_id(dev) - WM8400_DCDC1) * 2;
 	u16 data[2];
 	int ret;
 
-	ret = wm8400_block_read(wm8400, WM8400_DCDC1_CONTROL_1 + offset, 2,
-				data);
+	ret = regmap_bulk_read(rmap, WM8400_DCDC1_CONTROL_1 + offset, data, 2);
 	if (ret != 0)
 		return 0;
 
@@ -63,36 +62,36 @@ static unsigned int wm8400_dcdc_get_mode(struct regulator_dev *dev)
 
 static int wm8400_dcdc_set_mode(struct regulator_dev *dev, unsigned int mode)
 {
-	struct wm8400 *wm8400 = rdev_get_drvdata(dev);
+	struct regmap *rmap = rdev_get_regmap(dev);
 	int offset = (rdev_get_id(dev) - WM8400_DCDC1) * 2;
 	int ret;
 
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
 		/* Datasheet: active with force PWM */
-		ret = wm8400_set_bits(wm8400, WM8400_DCDC1_CONTROL_2 + offset,
+		ret = regmap_update_bits(rmap, WM8400_DCDC1_CONTROL_2 + offset,
 				      WM8400_DC1_FRC_PWM, WM8400_DC1_FRC_PWM);
 		if (ret != 0)
 			return ret;
 
-		return wm8400_set_bits(wm8400, WM8400_DCDC1_CONTROL_1 + offset,
+		return regmap_update_bits(rmap, WM8400_DCDC1_CONTROL_1 + offset,
 				       WM8400_DC1_ACTIVE | WM8400_DC1_SLEEP,
 				       WM8400_DC1_ACTIVE);
 
 	case REGULATOR_MODE_NORMAL:
 		/* Datasheet: active */
-		ret = wm8400_set_bits(wm8400, WM8400_DCDC1_CONTROL_2 + offset,
+		ret = regmap_update_bits(rmap, WM8400_DCDC1_CONTROL_2 + offset,
 				      WM8400_DC1_FRC_PWM, 0);
 		if (ret != 0)
 			return ret;
 
-		return wm8400_set_bits(wm8400, WM8400_DCDC1_CONTROL_1 + offset,
+		return regmap_update_bits(rmap, WM8400_DCDC1_CONTROL_1 + offset,
 				       WM8400_DC1_ACTIVE | WM8400_DC1_SLEEP,
 				       WM8400_DC1_ACTIVE);
 
 	case REGULATOR_MODE_IDLE:
 		/* Datasheet: standby */
-		return wm8400_set_bits(wm8400, WM8400_DCDC1_CONTROL_1 + offset,
+		return regmap_update_bits(rmap, WM8400_DCDC1_CONTROL_1 + offset,
 				       WM8400_DC1_ACTIVE | WM8400_DC1_SLEEP, 0);
 	default:
 		return -EINVAL;
diff --git a/include/linux/mfd/wm8400-private.h b/include/linux/mfd/wm8400-private.h
index 4ee908f5b834..43d0d307e2e3 100644
--- a/include/linux/mfd/wm8400-private.h
+++ b/include/linux/mfd/wm8400-private.h
@@ -923,12 +923,4 @@ struct wm8400 {
 #define WM8400_LINE_CMP_VTHD_SHIFT                   0  /* LINE_CMP_VTHD - [3:0] */
 #define WM8400_LINE_CMP_VTHD_WIDTH                   4  /* LINE_CMP_VTHD - [3:0] */
 
-int wm8400_block_read(struct wm8400 *wm8400, u8 reg, int count, u16 *data);
-
-static inline int wm8400_set_bits(struct wm8400 *wm8400, u8 reg,
-				  u16 mask, u16 val)
-{
-	return regmap_update_bits(wm8400->regmap, reg, mask, val);
-}
-
 #endif
-- 
2.20.1

