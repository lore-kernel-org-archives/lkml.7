Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C5EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AED520863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658013;
	bh=8ZeC9YrnB2K3lK+eEDsRaiLElTY10j/8t43oW0uEQTg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XRx1P2cEj0KL+MKuSavU/5/uX3k80PBQ8q1qsJVloBHQkr+yNSLu8SVwD25kRuFMl
	 8zeRbkic0Ecq54Q586KQFij7PGnUp6OoEyMJbbw4xYxbPhNmRUrBl0oPh3Sxriw6o2
	 ADy3bz296oPJLQ7j6gvHYjppWP6KKVuVPgY5290I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCDAGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCDAGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HwE5m3TNyS3gZIzZD8ZpwUvjPQY9O0VA3eGTpWB/J0I=; b=hsgdo5/Aebca
        x5O24NFW1S4iS6WUXqKQlI7yFgANe0iyDxuQweF6vSavhbiB0kWq1Z4v+jdLZRmv2IlnPJQ977Swv
        Mct6gzbcXEBPJmviPhY5ZZhoxzHvBsn8npsVQE1s1d1bbkhAt33iVJhKib5cpef2YnPalvhMP3tw4
        kwMyU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b83-0007QK-96; Mon, 04 Mar 2019 00:06:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 99F9F440082; Mon,  4 Mar 2019 00:06:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp872x: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000646.99F9F440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp872x: Convert to use regulator_set/get_current_limit_regmap

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

From 8918f068070010928b9a0ae85a9453936dba29a9 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Feb 2019 21:40:16 +0800
Subject: [PATCH] regulator: lp872x: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp872x.c | 70 ++++++--------------------------------
 1 file changed, 10 insertions(+), 60 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index f8f875bad7dd..ca95257ce252 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -353,64 +353,6 @@ static int lp872x_buck_get_voltage_sel(struct regulator_dev *rdev)
 	return val & LP872X_VOUT_M;
 }
 
-static int lp8725_buck_set_current_limit(struct regulator_dev *rdev,
-					int min_uA, int max_uA)
-{
-	struct lp872x *lp = rdev_get_drvdata(rdev);
-	enum lp872x_regulator_id buck = rdev_get_id(rdev);
-	int i;
-	u8 addr;
-
-	switch (buck) {
-	case LP8725_ID_BUCK1:
-		addr = LP8725_BUCK1_VOUT2;
-		break;
-	case LP8725_ID_BUCK2:
-		addr = LP8725_BUCK2_VOUT2;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	for (i = ARRAY_SIZE(lp8725_buck_uA) - 1; i >= 0; i--) {
-		if (lp8725_buck_uA[i] >= min_uA &&
-			lp8725_buck_uA[i] <= max_uA)
-			return lp872x_update_bits(lp, addr,
-						  LP8725_BUCK_CL_M,
-						  i << LP8725_BUCK_CL_S);
-	}
-
-	return -EINVAL;
-}
-
-static int lp8725_buck_get_current_limit(struct regulator_dev *rdev)
-{
-	struct lp872x *lp = rdev_get_drvdata(rdev);
-	enum lp872x_regulator_id buck = rdev_get_id(rdev);
-	u8 addr, val;
-	int ret;
-
-	switch (buck) {
-	case LP8725_ID_BUCK1:
-		addr = LP8725_BUCK1_VOUT2;
-		break;
-	case LP8725_ID_BUCK2:
-		addr = LP8725_BUCK2_VOUT2;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = lp872x_read_byte(lp, addr, &val);
-	if (ret)
-		return ret;
-
-	val = (val & LP8725_BUCK_CL_M) >> LP8725_BUCK_CL_S;
-
-	return (val < ARRAY_SIZE(lp8725_buck_uA)) ?
-			lp8725_buck_uA[val] : -EINVAL;
-}
-
 static int lp872x_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct lp872x *lp = rdev_get_drvdata(rdev);
@@ -513,8 +455,8 @@ static const struct regulator_ops lp8725_buck_ops = {
 	.enable_time = lp872x_regulator_enable_time,
 	.set_mode = lp872x_buck_set_mode,
 	.get_mode = lp872x_buck_get_mode,
-	.set_current_limit = lp8725_buck_set_current_limit,
-	.get_current_limit = lp8725_buck_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 static const struct regulator_desc lp8720_regulator_desc[] = {
@@ -712,6 +654,10 @@ static const struct regulator_desc lp8725_regulator_desc[] = {
 		.owner = THIS_MODULE,
 		.enable_reg = LP872X_GENERAL_CFG,
 		.enable_mask = LP8725_BUCK1_EN_M,
+		.curr_table = lp8725_buck_uA,
+		.n_current_limits = ARRAY_SIZE(lp8725_buck_uA),
+		.csel_reg = LP8725_BUCK1_VOUT2,
+		.csel_mask = LP8725_BUCK_CL_M,
 	},
 	{
 		.name = "buck2",
@@ -724,6 +670,10 @@ static const struct regulator_desc lp8725_regulator_desc[] = {
 		.owner = THIS_MODULE,
 		.enable_reg = LP872X_GENERAL_CFG,
 		.enable_mask = LP8725_BUCK2_EN_M,
+		.curr_table = lp8725_buck_uA,
+		.n_current_limits = ARRAY_SIZE(lp8725_buck_uA),
+		.csel_reg = LP8725_BUCK2_VOUT2,
+		.csel_mask = LP8725_BUCK_CL_M,
 	},
 };
 
-- 
2.20.1

