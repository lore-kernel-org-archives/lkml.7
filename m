Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A2D20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658043;
	bh=XqjseR9ocDOQrN7GfLXds6nWI9QqlDextXdqdzLWjig=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Y/4+Q7q2I5y8xD726mjLVh6rasPHa8Sw6o9scK/WMJkoGkjkf0XOP5w5tkS4p+hRu
	 ecS4cPxx/YsalJH6TviNH+IU7AIMK1gpi3kXqd7puq30szdQqDuaTQCGksV2ubO8z6
	 T3xWZh10W8tsBU3qq2ldY9HeHdjqcqmkCDYycOfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCDAGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54300 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCDAGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4nAXXDA3sq2tybVs0ayDLQFMeoSCVjMDk/sL3MTAyPU=; b=blNN6MQFs9YD
        xjn7NkLeuT8Vz6XplUnjHOfEJlPE4MZz5f6I2oz23SwSQfEftZiPR0d3dYN59vN0a5RswflGjpByb
        e03P2o44PbV3nz7Qyb3mCQo7lDWtGr74tLGfvTR4gz/0i0CZzfzIK12ZAGpHUI+WJibMD6MQax4sr
        lB2ck=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b81-0007QE-0H; Mon, 04 Mar 2019 00:06:45 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7518C440082; Mon,  4 Mar 2019 00:06:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp873x: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000644.7518C440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp873x: Convert to use regulator_set/get_current_limit_regmap

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

From be6230c3198b61e0b0bb1fc843a42a2e5546da36 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Feb 2019 21:40:17 +0800
Subject: [PATCH] regulator: lp873x: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp873x-regulator.c | 45 ++++------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index 70651fec8fd9..b55de293ca7a 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -39,6 +39,10 @@
 			.ramp_delay		= _delay,		\
 			.linear_ranges		= _lr,			\
 			.n_linear_ranges	= ARRAY_SIZE(_lr),	\
+			.curr_table	= lp873x_buck_uA,		\
+			.n_current_limits = ARRAY_SIZE(lp873x_buck_uA),	\
+			.csel_reg	= (_cr),			\
+			.csel_mask	= LP873X_BUCK0_CTRL_2_BUCK0_ILIM,\
 		},							\
 		.ctrl2_reg = _cr,					\
 	}
@@ -108,43 +112,6 @@ static int lp873x_buck_set_ramp_delay(struct regulator_dev *rdev,
 	return 0;
 }
 
-static int lp873x_buck_set_current_limit(struct regulator_dev *rdev,
-					 int min_uA, int max_uA)
-{
-	int id = rdev_get_id(rdev);
-	struct lp873x *lp873 = rdev_get_drvdata(rdev);
-	int i;
-
-	for (i = ARRAY_SIZE(lp873x_buck_uA) - 1; i >= 0; i--) {
-		if (lp873x_buck_uA[i] >= min_uA &&
-		    lp873x_buck_uA[i] <= max_uA)
-			return regmap_update_bits(lp873->regmap,
-						  regulators[id].ctrl2_reg,
-						  LP873X_BUCK0_CTRL_2_BUCK0_ILIM,
-						  i << __ffs(LP873X_BUCK0_CTRL_2_BUCK0_ILIM));
-	}
-
-	return -EINVAL;
-}
-
-static int lp873x_buck_get_current_limit(struct regulator_dev *rdev)
-{
-	int id = rdev_get_id(rdev);
-	struct lp873x *lp873 = rdev_get_drvdata(rdev);
-	int ret;
-	unsigned int val;
-
-	ret = regmap_read(lp873->regmap, regulators[id].ctrl2_reg, &val);
-	if (ret)
-		return ret;
-
-	val = (val & LP873X_BUCK0_CTRL_2_BUCK0_ILIM) >>
-	       __ffs(LP873X_BUCK0_CTRL_2_BUCK0_ILIM);
-
-	return (val < ARRAY_SIZE(lp873x_buck_uA)) ?
-			lp873x_buck_uA[val] : -EINVAL;
-}
-
 /* Operations permitted on BUCK0, BUCK1 */
 static const struct regulator_ops lp873x_buck01_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -156,8 +123,8 @@ static const struct regulator_ops lp873x_buck01_ops = {
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_ramp_delay		= lp873x_buck_set_ramp_delay,
-	.set_current_limit	= lp873x_buck_set_current_limit,
-	.get_current_limit	= lp873x_buck_get_current_limit,
+	.set_current_limit	= regulator_set_current_limit_regmap,
+	.get_current_limit	= regulator_get_current_limit_regmap,
 };
 
 /* Operations permitted on LDO0 and LDO1 */
-- 
2.20.1

