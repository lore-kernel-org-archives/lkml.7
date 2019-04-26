Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F101C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F14C2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271718;
	bh=Tnnve3F7+qpUpDciIJOJSEkq5ly35RvXQXv825Ol13Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=em7quN1fUJ+ZlxlfmBpFi3BjYVhU61+M4YnE/yo/V1UMw9ieq9m83PeksPwuHbd0h
	 DK4Q9LsCQoIqr7tYPwiTpFpicsnOb/nACFsIumDjlHLKig4bYASzd0tvzT5SBtDu/u
	 fkY4A1Ulw4yWw32ZFVzwY7X5j6TwVM/enaeExTsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDZJl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:41:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48332 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfDZJlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qLRR6MocEvwWUyzxtvfDaOfugWuwqcsAx6MPwRM7T1w=; b=ujgKj/YgiaPS
        EQKMRJMzFsfoMiK+ewfJ3SYcor+nJANco1QT0EqrBBY7bIMF8jCp1RUEgHue3+SKm8NGdMaSbdgAt
        LwMVuwieZlukCj4/49cBsuSdLC6SA9vTXLLvbOK9dUJEBsdj31CpS6AwWntdkfbmWJPxKeXjK6fTh
        jstAk=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxMf-0003MH-Di; Fri, 26 Apr 2019 09:41:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DEC5D441D3C; Fri, 26 Apr 2019 10:41:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: hi655x: Remove ctrl_mask field from struct hi655x_regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094151.DEC5D441D3C@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:41:51 +0100 (BST)
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

