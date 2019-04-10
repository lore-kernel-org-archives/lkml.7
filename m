Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC29BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9748E217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554899234;
	bh=Tnnve3F7+qpUpDciIJOJSEkq5ly35RvXQXv825Ol13Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BHAGw8on0QBtgAbAdquC5QTWfEmVDm3hvwvVUMrpZIyOkfWN2q2WoJQPivMmbeDHI
	 F9dewgfZIpG1l2lB3/222CAwT26Z+pEXTGLt57wwKde/5pGFuEMAlxcqNGmT1S3L9G
	 Q1Ro01ix4DtSl9OuN0+KYzSH2TkHZzjeIec0TSz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfDJM1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:27:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35638 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfDJM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qLRR6MocEvwWUyzxtvfDaOfugWuwqcsAx6MPwRM7T1w=; b=ryYxxr5cHH24
        3e2rpKBajFoi/xkoy2mo8zxVYPV2vWXyGY871+/s6CSSYPmMvnrNqkjKZ34K3jJ/M+sAmyYvG8Y7M
        YhM5FHh75YNYm/xpmtCIUEaEDSAGX7vP64LoxhHGVkRM7yQisH1sIDeTcO9FnCqWk5YTY6jM5tpJV
        SlzFo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hECJc-00007V-3F; Wed, 10 Apr 2019 12:26:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7C4901128ED2; Wed, 10 Apr 2019 13:26:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: hi655x: Remove ctrl_mask field from struct hi655x_regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190410122655.7C4901128ED2@debutante.sirena.org.uk>
Date:   Wed, 10 Apr 2019 13:26:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: hi655x: Remove ctrl_mask field from struct hi655x_regulator

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

From 29e5cb657e2acdf902b0122ca58620ccd771f297 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 8 Apr 2019 20:09:33 +0800
Subject: [PATCH] regulator: hi655x: Remove ctrl_mask field from struct
 hi655x_regulator

The rdev->desc->enable_mask setting is always the same as
BIT(regulator->ctrl_mask), so just use rdev->desc->enable_mask instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/hi655x-regulator.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index 460ae70d8b04..6f6635daa026 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -28,7 +28,6 @@
 struct hi655x_regulator {
 	unsigned int disable_reg;
 	unsigned int status_reg;
-	unsigned int ctrl_mask;
 	struct regulator_desc rdesc;
 };
 
@@ -77,22 +76,18 @@ enum hi655x_regulator_id {
 static int hi655x_is_enabled(struct regulator_dev *rdev)
 {
 	unsigned int value = 0;
-
 	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
 
 	regmap_read(rdev->regmap, regulator->status_reg, &value);
-	return (value & BIT(regulator->ctrl_mask));
+	return (value & rdev->desc->enable_mask);
 }
 
 static int hi655x_disable(struct regulator_dev *rdev)
 {
-	int ret = 0;
-
 	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
 
-	ret = regmap_write(rdev->regmap, regulator->disable_reg,
-			   BIT(regulator->ctrl_mask));
-	return ret;
+	return regmap_write(rdev->regmap, regulator->disable_reg,
+			    rdev->desc->enable_mask);
 }
 
 static const struct regulator_ops hi655x_regulator_ops = {
@@ -132,7 +127,6 @@ static const struct regulator_ops hi655x_ldo_linear_ops = {
 	},                                                       \
 	.disable_reg = HI655X_BUS_ADDR(dreg),                    \
 	.status_reg = HI655X_BUS_ADDR(sreg),                     \
-	.ctrl_mask = cmask,                                      \
 }
 
 #define HI655X_LDO_LINEAR(_ID, vreg, vmask, ereg, dreg,          \
@@ -155,7 +149,6 @@ static const struct regulator_ops hi655x_ldo_linear_ops = {
 	},                                                       \
 	.disable_reg = HI655X_BUS_ADDR(dreg),                    \
 	.status_reg = HI655X_BUS_ADDR(sreg),                     \
-	.ctrl_mask = cmask,                                      \
 }
 
 static const struct hi655x_regulator regulators[] = {
-- 
2.20.1

