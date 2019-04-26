Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038DEC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C557F2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271928;
	bh=A/GtMtdQZmsSqYaFvQWbVstuKbysiglHBQlafyO0tF0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=a/oZhsE+y/L1pPpu/b6SPxpQjslOKEVNDMR8ARB7d0vsIl4gZMx02v2r2oJjVXz24
	 JnfVWvTGTePPOOx1NHFGUfUuLdZRfv1Z86BXi6sLwHuQ42QoW7v2ekJogr6zPYoi5t
	 tznxpbybohny3Tg6oTn9GyNjIT2uozT0fKQk66Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfDZJp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:45:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54406 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfDZJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=p30AVwRBOVn8CBY400HfLGHKv50QuypTByEKhNpxn/Y=; b=aHleb5FYJ2FR
        +ge0vhSQ2akhzGhAdZyiZPEzF2Bnr66QP3W8NNEqL82GbaHyJyV8womsvGavvotHXJBdZMxkPEn1q
        ifdUhjgRgE2MJ8kjcUCQ/3zbZne/T2My7TICc7YzhTGEcOf6DsmVsbLd34cw6ajn4W3/uKR7UM/ig
        Eni8Q=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxQ3-0003RD-3e; Fri, 26 Apr 2019 09:45:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 04BC6441D3B; Fri, 26 Apr 2019 10:45:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab8500: Remove *regulator from struct ab8500_regulator_info" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094522.04BC6441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:45:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500: Remove *regulator from struct ab8500_regulator_info

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

From 7c6b8e3b9fe85af29b66478d585a0cffd6caa1df Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 12 Apr 2019 22:11:58 +0800
Subject: [PATCH] regulator: ab8500: Remove *regulator from struct
 ab8500_regulator_info

Current code is using devm_regulator_register() so we don't need to save
*regulator for clean up, use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab8500.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 6b9a3463f1fd..3fcb4cbaab02 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -44,7 +44,6 @@ struct ab8500_shared_mode {
  * struct ab8500_regulator_info - ab8500 regulator information
  * @dev: device pointer
  * @desc: regulator description
- * @regulator_dev: regulator device
  * @shared_mode: used when mode is shared between two regulators
  * @load_lp_uA: maximum load in idle (low power) mode
  * @update_bank: bank to control on/off
@@ -65,7 +64,6 @@ struct ab8500_shared_mode {
 struct ab8500_regulator_info {
 	struct device		*dev;
 	struct regulator_desc	desc;
-	struct regulator_dev	*regulator;
 	struct ab8500_shared_mode *shared_mode;
 	int load_lp_uA;
 	u8 update_bank;
@@ -1600,6 +1598,7 @@ static int ab8500_regulator_register(struct platform_device *pdev,
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_regulator_info *info = NULL;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 
 	/* assign per-regulator data */
 	info = &abx500_regulator.info[id];
@@ -1621,12 +1620,11 @@ static int ab8500_regulator_register(struct platform_device *pdev,
 	}
 
 	/* register regulator with framework */
-	info->regulator = devm_regulator_register(&pdev->dev, &info->desc,
-						&config);
-	if (IS_ERR(info->regulator)) {
+	rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
+	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "failed to register regulator %s\n",
 			info->desc.name);
-		return PTR_ERR(info->regulator);
+		return PTR_ERR(rdev);
 	}
 
 	return 0;
-- 
2.20.1

