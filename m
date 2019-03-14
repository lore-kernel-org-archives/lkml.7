Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD65C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFFB2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578883;
	bh=Z7gSD1cfhfeWzy9eFF6aNew+iatyRPjZC7Lzg4yYYKk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mS7Up4WD5vrZkfRYdKuOJsHuyFVL5FlCGaU1SsepqXILaj+0HKThMoYlf7k5Q4dwq
	 d2HC36bE2+DuEsrx6GgvE5ilsx/8mQ8lED3PsUI9j28oLtL9HpGF2aPftRbIaoRcSM
	 0edHnAYS4GT9nl+sfpptQ3BUYPWqnQ4f1YemvYZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfCNPym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:54:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36530 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfCNPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vwg+fTsjOHRkwc6pYQ+QdK2eEly5aPzVudr4+tuAEPE=; b=mEmclE+e1gOu
        MWCXQ264yWAxyGow0rMEzd1Zo+j5HXCQIMFf+tCxrHnDzyrxQdTClEb5hfklYvmjqXkt1AP17Ukqv
        0+k59BFngTmFW1K/PiptRYyOUJi3YZ9Aujsbg3AfXoQXy1Gq4OdTnFDFDH6jmTwJ8GDso6oj1vOqw
        clnm8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4Sgl-0002jt-S6; Thu, 14 Mar 2019 15:54:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6194E1126E64; Thu, 14 Mar 2019 15:54:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: ab3100: Remove ab3100_regulators_remove function" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190314155435.6194E1126E64@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:54:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab3100: Remove ab3100_regulators_remove function

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

From 5b60ee576a02cb6b2371dec085ef2623a7df77b9 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 7 Mar 2019 21:53:56 +0800
Subject: [PATCH] regulator: ab3100: Remove ab3100_regulators_remove function

Current code is using devm_regulator_register() so it is not necessary
to save reg->rdev for clean up. Remove *rdev from struct ab3100_regulator,
then ab3100_regulators_remove() can be removed as well.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab3100.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index de2644490f0d..c92966a79a7e 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -48,7 +48,6 @@
  * @regreg: regulator register number in the AB3100
  */
 struct ab3100_regulator {
-	struct regulator_dev *rdev;
 	struct device *dev;
 	struct ab3100_platform_data *plfdata;
 	u8 regreg;
@@ -545,8 +544,6 @@ static int ab3100_regulator_register(struct platform_device *pdev,
 		return err;
 	}
 
-	/* Then set a pointer back to the registered regulator */
-	reg->rdev = rdev;
 	return 0;
 }
 
@@ -609,18 +606,6 @@ static const u8 ab3100_reg_initvals[] = {
 	LDO_D_SETTING,
 };
 
-static int ab3100_regulators_remove(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; i < AB3100_NUM_REGULATORS; i++) {
-		struct ab3100_regulator *reg = &ab3100_regulators[i];
-
-		reg->rdev = NULL;
-	}
-	return 0;
-}
-
 static int
 ab3100_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
 {
@@ -647,10 +632,8 @@ ab3100_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
 			pdev, NULL, ab3100_regulator_matches[i].init_data,
 			ab3100_regulator_matches[i].of_node,
 			(unsigned long)ab3100_regulator_matches[i].driver_data);
-		if (err) {
-			ab3100_regulators_remove(pdev);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
@@ -709,10 +692,8 @@ static int ab3100_regulators_probe(struct platform_device *pdev)
 
 		err = ab3100_regulator_register(pdev, plfdata, NULL, NULL,
 						desc->id);
-		if (err) {
-			ab3100_regulators_remove(pdev);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
@@ -723,7 +704,6 @@ static struct platform_driver ab3100_regulators_driver = {
 		.name  = "ab3100-regulators",
 	},
 	.probe = ab3100_regulators_probe,
-	.remove = ab3100_regulators_remove,
 };
 
 static __init int ab3100_regulators_init(void)
-- 
2.20.1

