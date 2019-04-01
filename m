Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C55C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62336206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108852;
	bh=dS4EMvC9GbwGLaN+YQg5D45HiWjmlmvja2VcZmwbi8g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dZmLuVFOq6Sdt92E/KJKv2TpQYLZzx6oA8rREs856lFY4n0YDZ2bB7nq5jxPVKqYH
	 cdHPY7TjXIUpSwP7FO8YzJpMa7RZB/RgvaIe/VWa8uiEDp38Yu8OWgUyrJgW3z1F1d
	 +n+PtlBCflCPYSFPkwT74NLXGv86uXAzeaV1OdzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfDAIyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60892 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfDAIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XWuATvHyCMmDtMB+BU6H1MsMEa9rFtCjwqqObdK+bEQ=; b=bvVM4lG80tFs
        y0ariIAOzLHZlYieaBCt/tTKwnzBWvmHbr4JSaMXAjzqNayxrk7v3ppwOCLNXDW0YvpHBg9ugljcR
        oay8oMfRPU9k7t9NGXdTfY/KhCNUkgM3pnJGMRFh7JfRNjT0tF5wotR0BDQAkAJYE93v54uT6Ky8Z
        oTv50=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAshh-0008PK-5H; Mon, 01 Apr 2019 08:54:05 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 48E59440082; Mon,  1 Apr 2019 09:54:02 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: rc5t583: Get rid of struct rc5t583_regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190401085402.48E59440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:54:02 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rc5t583: Get rid of struct rc5t583_regulator

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

From c07608f737bd5ecf336b68427d4c9671283bf7b9 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 27 Mar 2019 19:54:13 +0800
Subject: [PATCH] regulator: rc5t583: Get rid of struct rc5t583_regulator

The struct rc5t583_regulator only has 2 members, the *rdev is no longer
used because this driver is using devm_regulator_register now. After remove
*rdev, only *reg_info left. We can use struct rc5t583_regulator_info
directly, so remove struct rc5t583_regulator.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rc5t583-regulator.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/rc5t583-regulator.c b/drivers/regulator/rc5t583-regulator.c
index 2ec51af43673..9446653e7a89 100644
--- a/drivers/regulator/rc5t583-regulator.c
+++ b/drivers/regulator/rc5t583-regulator.c
@@ -47,18 +47,13 @@ struct rc5t583_regulator_info {
 	struct regulator_desc	desc;
 };
 
-struct rc5t583_regulator {
-	struct rc5t583_regulator_info *reg_info;
-	struct regulator_dev	*rdev;
-};
-
 static int rc5t583_regulator_enable_time(struct regulator_dev *rdev)
 {
-	struct rc5t583_regulator *reg = rdev_get_drvdata(rdev);
+	struct rc5t583_regulator_info *reg_info = rdev_get_drvdata(rdev);
 	int vsel = regulator_get_voltage_sel_regmap(rdev);
 	int curr_uV = regulator_list_voltage_linear(rdev, vsel);
 
-	return DIV_ROUND_UP(curr_uV, reg->reg_info->enable_uv_per_us);
+	return DIV_ROUND_UP(curr_uV, reg_info->enable_uv_per_us);
 }
 
 static const struct regulator_ops rc5t583_ops = {
@@ -120,8 +115,6 @@ static int rc5t583_regulator_probe(struct platform_device *pdev)
 	struct rc5t583 *rc5t583 = dev_get_drvdata(pdev->dev.parent);
 	struct rc5t583_platform_data *pdata = dev_get_platdata(rc5t583->dev);
 	struct regulator_config config = { };
-	struct rc5t583_regulator *reg = NULL;
-	struct rc5t583_regulator *regs;
 	struct regulator_dev *rdev;
 	struct rc5t583_regulator_info *ri;
 	int ret;
@@ -132,18 +125,8 @@ static int rc5t583_regulator_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	regs = devm_kcalloc(&pdev->dev,
-			    RC5T583_REGULATOR_MAX,
-			    sizeof(struct rc5t583_regulator),
-			    GFP_KERNEL);
-	if (!regs)
-		return -ENOMEM;
-
-
 	for (id = 0; id < RC5T583_REGULATOR_MAX; ++id) {
-		reg = &regs[id];
 		ri = &rc5t583_reg_info[id];
-		reg->reg_info = ri;
 
 		if (ri->deepsleep_id == RC5T583_DS_NONE)
 			goto skip_ext_pwr_config;
@@ -163,7 +146,7 @@ static int rc5t583_regulator_probe(struct platform_device *pdev)
 skip_ext_pwr_config:
 		config.dev = &pdev->dev;
 		config.init_data = pdata->reg_init_data[id];
-		config.driver_data = reg;
+		config.driver_data = ri;
 		config.regmap = rc5t583->regmap;
 
 		rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
@@ -172,9 +155,7 @@ static int rc5t583_regulator_probe(struct platform_device *pdev)
 						ri->desc.name);
 			return PTR_ERR(rdev);
 		}
-		reg->rdev = rdev;
 	}
-	platform_set_drvdata(pdev, regs);
 	return 0;
 }
 
-- 
2.20.1

