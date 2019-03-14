Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0853C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F3B2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578884;
	bh=e5e7P5GHnOlqYNAT0tdxUQQzP57QGqgZpVyi71kOiAc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0JrbG9asTbotYi5UJn0Uh2A/ETNo5GRwEHBILkz2wGBARfNWfTbsTnr5+slPMbC8C
	 S/x0tyDADnvaK++UU9Mqkss3H63LuDjIG+XM8MwgUOzfnbWAMdzPsGT2rI51dCX9Ns
	 OBr+CtYnCEIVqiYeq0klKrkv6m88W3+r6k2jkYFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfCNPyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:54:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfCNPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2U/nHxQb957iXFtrKt9XwjLATwUymYThlj8yuHq4mmg=; b=kihMcn/PCLEk
        smRsAwh1aoalzZPzl5MxmXFtTY+RawTF1b94pYXKTe1xz/U5loQZewhkagC7TWUwqOGuWiUblkcP/
        i0wq9VvHIBRskSp+PchEO2mgMm7qdk07RzYE4Y+X8EyyA5Knxp91hVT0hKKfAvTgMe6cVgVaTqUhq
        h/v6M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4Sgn-0002jz-LB; Thu, 14 Mar 2019 15:54:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1E5651126E64; Thu, 14 Mar 2019 15:54:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: palmas: Remove *rdev[PALMAS_NUM_REGS] from struct palmas_pmic" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190314155437.1E5651126E64@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:54:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: palmas: Remove *rdev[PALMAS_NUM_REGS] from struct palmas_pmic

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

From 74b060d6845f09a5b2db6df653a3c0e90d4fa560 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 10 Mar 2019 23:06:09 +0800
Subject: [PATCH] regulator: palmas: Remove *rdev[PALMAS_NUM_REGS] from struct
 palmas_pmic

This driver is using devm_regulator_register() so it is not necessary
to save *rdev for clean up. Actually the pmic->rdev[id] is not used now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/palmas-regulator.c | 12 ------------
 include/linux/mfd/palmas.h           |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 7fb9e8dd834e..f13c7c8b1061 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -991,9 +991,6 @@ static int palmas_ldo_registration(struct palmas_pmic *pmic,
 			return PTR_ERR(rdev);
 		}
 
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
-
 		/* Initialise sleep/init values from platform data */
 		if (pdata) {
 			reg_init = pdata->reg_init[id];
@@ -1101,9 +1098,6 @@ static int tps65917_ldo_registration(struct palmas_pmic *pmic,
 			return PTR_ERR(rdev);
 		}
 
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
-
 		/* Initialise sleep/init values from platform data */
 		if (pdata) {
 			reg_init = pdata->reg_init[id];
@@ -1288,9 +1282,6 @@ static int palmas_smps_registration(struct palmas_pmic *pmic,
 				pdev_name);
 			return PTR_ERR(rdev);
 		}
-
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
 	}
 
 	return 0;
@@ -1395,9 +1386,6 @@ static int tps65917_smps_registration(struct palmas_pmic *pmic,
 				pdev_name);
 			return PTR_ERR(rdev);
 		}
-
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
 	}
 
 	return 0;
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 75e5c8ff85fc..c34d5f0d34d7 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -553,7 +553,6 @@ struct palmas_pmic {
 	struct palmas *palmas;
 	struct device *dev;
 	struct regulator_desc desc[PALMAS_NUM_REGS];
-	struct regulator_dev *rdev[PALMAS_NUM_REGS];
 	struct mutex mutex;
 
 	int smps123;
-- 
2.20.1

