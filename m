Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA923C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912FA21855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578980;
	bh=1iFZ1kNnYpc/aUxAOYZpMXVGTWQfaQQEEF6REnzieSk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VTNslzmRUGh2GB4fkXFIjPIy5pT6qE5iFXKLJ2pSb7f/HvMumVy07hStxrkDlSQ4L
	 ytIQGPB17ik/FNdypKDml2Hf6Hcl2RMOQZ73pZ3rNCzCnrlmFkAjDdV+m1F/9SQuJ7
	 FtzH/NIyhbwCP6ZVFS2HcvMTZyZMUng92b1K+96E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCNPyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:54:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35494 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfCNPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vXVRXxL3rSCHYssJIDs839OhdVDn8xoOkDWc3SuQBew=; b=tzb94ErvNp4o
        lUGxbL1+a1EXNltsGrFzvXipMSM1PpElf3xufUkXiDAQwyFUhabvIjr9wXN4sdC2sVMX6JYZXGn5N
        W4UToPbsZYDcH7mrJYyMcWh2jwVR2W4gCnpFNrCL3NZuCJ1QI981TldWAGIe6Z9n26y8+QZGFDg/3
        nzkks=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4SgE-0002hh-DE; Thu, 14 Mar 2019 15:54:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E8B921126E64; Thu, 14 Mar 2019 15:53:56 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm8350: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190314155356.E8B921126E64@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:53:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm8350: Convert to use regulator_set/get_current_limit_regmap

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

From dfeb7a93bf3b26e6779e0b38b25877c0540652e6 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 13 Mar 2019 00:33:57 +0800
Subject: [PATCH] regulator: wm8350: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm8350-regulator.c | 81 ++++------------------------
 1 file changed, 11 insertions(+), 70 deletions(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index d1758a2bc769..0eb3f3a33caa 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -28,7 +28,7 @@
 #define WM8350_DCDC_MAX_VSEL 0x66
 
 /* Microamps */
-static const int isink_cur[] = {
+static const unsigned int isink_cur[] = {
 	4,
 	5,
 	6,
@@ -95,73 +95,6 @@ static const int isink_cur[] = {
 	223191
 };
 
-static int get_isink_val(int min_uA, int max_uA, u16 *setting)
-{
-	int i;
-
-	for (i = ARRAY_SIZE(isink_cur) - 1; i >= 0; i--) {
-		if (min_uA <= isink_cur[i] && max_uA >= isink_cur[i]) {
-			*setting = i;
-			return 0;
-		}
-	}
-	return -EINVAL;
-}
-
-static int wm8350_isink_set_current(struct regulator_dev *rdev, int min_uA,
-	int max_uA)
-{
-	struct wm8350 *wm8350 = rdev_get_drvdata(rdev);
-	int isink = rdev_get_id(rdev);
-	u16 val, setting;
-	int ret;
-
-	ret = get_isink_val(min_uA, max_uA, &setting);
-	if (ret != 0)
-		return ret;
-
-	switch (isink) {
-	case WM8350_ISINK_A:
-		val = wm8350_reg_read(wm8350, WM8350_CURRENT_SINK_DRIVER_A) &
-		    ~WM8350_CS1_ISEL_MASK;
-		wm8350_reg_write(wm8350, WM8350_CURRENT_SINK_DRIVER_A,
-				 val | setting);
-		break;
-	case WM8350_ISINK_B:
-		val = wm8350_reg_read(wm8350, WM8350_CURRENT_SINK_DRIVER_B) &
-		    ~WM8350_CS1_ISEL_MASK;
-		wm8350_reg_write(wm8350, WM8350_CURRENT_SINK_DRIVER_B,
-				 val | setting);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int wm8350_isink_get_current(struct regulator_dev *rdev)
-{
-	struct wm8350 *wm8350 = rdev_get_drvdata(rdev);
-	int isink = rdev_get_id(rdev);
-	u16 val;
-
-	switch (isink) {
-	case WM8350_ISINK_A:
-		val = wm8350_reg_read(wm8350, WM8350_CURRENT_SINK_DRIVER_A) &
-		    WM8350_CS1_ISEL_MASK;
-		break;
-	case WM8350_ISINK_B:
-		val = wm8350_reg_read(wm8350, WM8350_CURRENT_SINK_DRIVER_B) &
-		    WM8350_CS1_ISEL_MASK;
-		break;
-	default:
-		return 0;
-	}
-
-	return isink_cur[val];
-}
-
 /* turn on ISINK followed by DCDC */
 static int wm8350_isink_enable(struct regulator_dev *rdev)
 {
@@ -982,8 +915,8 @@ static const struct regulator_ops wm8350_ldo_ops = {
 };
 
 static const struct regulator_ops wm8350_isink_ops = {
-	.set_current_limit = wm8350_isink_set_current,
-	.get_current_limit = wm8350_isink_get_current,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 	.enable = wm8350_isink_enable,
 	.disable = wm8350_isink_disable,
 	.is_enabled = wm8350_isink_is_enabled,
@@ -1138,6 +1071,10 @@ static const struct regulator_desc wm8350_reg[NUM_WM8350_REGULATORS] = {
 		.irq = WM8350_IRQ_CS1,
 		.type = REGULATOR_CURRENT,
 		.owner = THIS_MODULE,
+		.curr_table = isink_cur,
+		.n_current_limits = ARRAY_SIZE(isink_cur),
+		.csel_reg = WM8350_CURRENT_SINK_DRIVER_A,
+		.csel_mask = WM8350_CS1_ISEL_MASK,
 	 },
 	{
 		.name = "ISINKB",
@@ -1146,6 +1083,10 @@ static const struct regulator_desc wm8350_reg[NUM_WM8350_REGULATORS] = {
 		.irq = WM8350_IRQ_CS2,
 		.type = REGULATOR_CURRENT,
 		.owner = THIS_MODULE,
+		.curr_table = isink_cur,
+		.n_current_limits = ARRAY_SIZE(isink_cur),
+		.csel_reg = WM8350_CURRENT_SINK_DRIVER_B,
+		.csel_mask = WM8350_CS2_ISEL_MASK,
 	 },
 };
 
-- 
2.20.1

