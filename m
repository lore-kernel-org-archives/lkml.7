Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487E9C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D8B20879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920703;
	bh=7hvsg3W6cZFSpDhOSgE6pgO2P3oQS9AvJLGWKoJutJA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AUQt2I+arI8T4sKtPBluO1jn/b7ckP8h/NQ4+7nIEZyrHiV1hvZe9g9TkEk9MoLHy
	 vPD5Ns2L3ORxkoFtNBWDPTpC+X8DIAg/KbWmeZv2coGHySCB/xi1FkB5MKpD8B53Xl
	 nEtMfBY3P5w++Xn/l8hkAlGVQ40zRs0bzg1q5Qp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfCROvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:51:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55048 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfCROvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UT21Twp5dMsTNCeDlmSYhgNNkPhiE/8pkR5ogy5vw4U=; b=WYzJEFhKr8Re
        l+qOQv3BczMT6cMUlQoLq4Y9wQj/1hCrI+BTtxa5E/zaSlsV6TCMCpUwnNEs8eytLj2rtZLs+DuVy
        /v7gh8Pc1Hd5C8/Wa6OOU43iuNDG9RzQ/YLtSibYpRnuO3VKxJaMj95Ydv9175TR0EDAI86RFJvQL
        hIhNw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tbz-0005oA-In; Mon, 18 Mar 2019 14:51:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 07B39112887B; Mon, 18 Mar 2019 14:51:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp87565: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190318145135.07B39112887B@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp87565: Convert to use regulator_set/get_current_limit_regmap

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

From d0ccbe11773d39baed0cdec606ad6a008c2b19c7 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 1 Mar 2019 14:24:32 +0800
Subject: [PATCH] regulator: lp87565: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp87565-regulator.c | 47 ++++-----------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 0418e478c6dc..81eb4b890c0c 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -34,6 +34,10 @@
 			.ramp_delay		= _delay,		\
 			.linear_ranges		= _lr,			\
 			.n_linear_ranges	= ARRAY_SIZE(_lr),	\
+			.curr_table = lp87565_buck_uA,			\
+			.n_current_limits = ARRAY_SIZE(lp87565_buck_uA),\
+			.csel_reg = (_cr),				\
+			.csel_mask = LP87565_BUCK_CTRL_2_ILIM,		\
 		},							\
 		.ctrl2_reg = _cr,					\
 	}
@@ -102,44 +106,7 @@ static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
 	return 0;
 }
 
-static int lp87565_buck_set_current_limit(struct regulator_dev *rdev,
-					  int min_uA, int max_uA)
-{
-	int id = rdev_get_id(rdev);
-	struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
-	int i;
-
-	for (i = ARRAY_SIZE(lp87565_buck_uA) - 1; i >= 0; i--) {
-		if (lp87565_buck_uA[i] >= min_uA &&
-		    lp87565_buck_uA[i] <= max_uA)
-			return regmap_update_bits(lp87565->regmap,
-						  regulators[id].ctrl2_reg,
-						  LP87565_BUCK_CTRL_2_ILIM,
-						  i << __ffs(LP87565_BUCK_CTRL_2_ILIM));
-	}
-
-	return -EINVAL;
-}
-
-static int lp87565_buck_get_current_limit(struct regulator_dev *rdev)
-{
-	int id = rdev_get_id(rdev);
-	struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
-	int ret;
-	unsigned int val;
-
-	ret = regmap_read(lp87565->regmap, regulators[id].ctrl2_reg, &val);
-	if (ret)
-		return ret;
-
-	val = (val & LP87565_BUCK_CTRL_2_ILIM) >>
-	       __ffs(LP87565_BUCK_CTRL_2_ILIM);
-
-	return (val < ARRAY_SIZE(lp87565_buck_uA)) ?
-			lp87565_buck_uA[val] : -EINVAL;
-}
-
-/* Operations permitted on BUCK0, BUCK1 */
+/* Operations permitted on BUCKs */
 static const struct regulator_ops lp87565_buck_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
@@ -150,8 +117,8 @@ static const struct regulator_ops lp87565_buck_ops = {
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_ramp_delay		= lp87565_buck_set_ramp_delay,
-	.set_current_limit	= lp87565_buck_set_current_limit,
-	.get_current_limit	= lp87565_buck_get_current_limit,
+	.set_current_limit	= regulator_set_current_limit_regmap,
+	.get_current_limit	= regulator_get_current_limit_regmap,
 };
 
 static const struct lp87565_regulator regulators[] = {
-- 
2.20.1

