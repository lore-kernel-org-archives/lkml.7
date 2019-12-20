Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29BEC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EE521655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576847368;
	bh=1tziA3YCCjB3Mj2it3ep1rb5eCdLNiPTA2djASD0X6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=GDWY3Q1FWRGzEsEFK9jo66905kazNUc0Td7vOpwxEJrNjO9fuxJjfAQZDYe+0GZQG
	 HyYPVUcrMlIqlC3xHjLEwtK1zQZT3YYK6NSbl2B3sRWevdK7igS4iMdicUyNIVsM4F
	 w/WM5l6FadDnSdAm/s1WWSWqIJQUNWu1Zb9S9Tgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLTNJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:09:26 -0500
Received: from foss.arm.com ([217.140.110.172]:50694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbfLTNJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 08:09:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5DFB31B;
        Fri, 20 Dec 2019 05:09:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3580B3F719;
        Fri, 20 Dec 2019 05:09:24 -0800 (PST)
Date:   Fri, 20 Dec 2019 13:09:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Subject: Applied "regulator: bd71828: remove get_voltage operation" to the regulator tree
In-Reply-To: <20191219113444.GA28299@localhost.localdomain>
Message-Id: <applied-20191219113444.GA28299@localhost.localdomain>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd71828: remove get_voltage operation

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

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

From a14a0b5fc17901cdbc2e9d412e7ed4fbd75e284c Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Thu, 19 Dec 2019 13:34:44 +0200
Subject: [PATCH] regulator: bd71828: remove get_voltage operation

Simplify LDO6 voltage getting on BD71828 by removing the
get_voltage call-back and providing the fixed voltage in
regulator_desc instead

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Suggested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20191219113444.GA28299@localhost.localdomain
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd71828-regulator.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71828-regulator.c
index edba51da5661..b2fa17be4988 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -197,15 +197,9 @@ static const struct regulator_ops bd71828_ldo_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static int bd71828_ldo6_get_voltage(struct regulator_dev *rdev)
-{
-	return BD71828_LDO_6_VOLTAGE;
-}
-
 static const struct regulator_ops bd71828_ldo6_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
-	.get_voltage = bd71828_ldo6_get_voltage,
 	.is_enabled = regulator_is_enabled_regmap,
 };
 
@@ -697,6 +691,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.id = BD71828_LDO6,
 			.ops = &bd71828_ldo6_ops,
 			.type = REGULATOR_VOLTAGE,
+			.fixed_uV = BD71828_LDO_6_VOLTAGE,
 			.n_voltages = 1,
 			.enable_reg = BD71828_REG_LDO6_EN,
 			.enable_mask = BD71828_MASK_RUN_EN,
-- 
2.20.1

