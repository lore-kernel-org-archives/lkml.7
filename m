Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D51C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654AC206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491659;
	bh=OYqpqCGjhWBGqba9M3R05S0p97R1oSp847nk+ME2Y84=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VnfeoD23RRymQd3086+hM7IzFRNyBVjVTBU9TEcKoB0SAzlvj0XQ+5LU3fNp+4yg7
	 ZiNazB4rXHnHOLz9iFSAfYxBbzccwM7OJGtGZp/dTFfHfaiQuYHnMSRAOPp7EFQk5Y
	 ylzuEbi7S2RU3oVuqUGi+JX1Ffy9WOkCA/tKotzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfCMPjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfCMPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=A4vtzUc/vZ68Bm3zo1w2rT3Xtu1Cv8Rpn+yK+FUrBWs=; b=exZoCA6Ul8/5
        tBH9xoOIwA4JVkOAVmBaV7ydHa3uXZL0yIZco9N2nQuI6dZ2DPwLmdWblODIa2psZAYIr1vKTrhC2
        yCM71DiqcFpU/TsQ2gXR4yLSM5sEt/2N43ARnOk/+oi47SXlOLbkR6H6R7JCdsNIcmNLNwtDYnbyJ
        0j45w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45yW-0003TI-KX; Wed, 13 Mar 2019 15:39:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EFC9B1128B97; Wed, 13 Mar 2019 15:39:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp8755: Fix notifier mutex lock warning" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190313153923.EFC9B1128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:39:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp8755: Fix notifier mutex lock warning

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

From 89b2758c192c35068b07766a6830433bfbdc1f44 Mon Sep 17 00:00:00 2001
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 26 Feb 2019 15:32:18 +0000
Subject: [PATCH] regulator: lp8755: Fix notifier mutex lock warning

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: b59320cc5a5e ("regulator: lp8755: new driver for LP8755")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp8755.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 14fd38807134..2e16a6ab491d 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -372,10 +372,13 @@ static irqreturn_t lp8755_irq_handler(int irq, void *data)
 	for (icnt = 0; icnt < LP8755_BUCK_MAX; icnt++)
 		if ((flag0 & (0x4 << icnt))
 		    && (pchip->irqmask & (0x04 << icnt))
-		    && (pchip->rdev[icnt] != NULL))
+		    && (pchip->rdev[icnt] != NULL)) {
+			regulator_lock(pchip->rdev[icnt]);
 			regulator_notifier_call_chain(pchip->rdev[icnt],
 						      LP8755_EVENT_PWR_FAULT,
 						      NULL);
+			regulator_unlock(pchip->rdev[icnt]);
+		}
 
 	/* read flag1 register */
 	ret = lp8755_read(pchip, 0x0E, &flag1);
@@ -389,18 +392,24 @@ static irqreturn_t lp8755_irq_handler(int irq, void *data)
 	/* send OCP event to all regulator devices */
 	if ((flag1 & 0x01) && (pchip->irqmask & 0x01))
 		for (icnt = 0; icnt < LP8755_BUCK_MAX; icnt++)
-			if (pchip->rdev[icnt] != NULL)
+			if (pchip->rdev[icnt] != NULL) {
+				regulator_lock(pchip->rdev[icnt]);
 				regulator_notifier_call_chain(pchip->rdev[icnt],
 							      LP8755_EVENT_OCP,
 							      NULL);
+				regulator_unlock(pchip->rdev[icnt]);
+			}
 
 	/* send OVP event to all regulator devices */
 	if ((flag1 & 0x02) && (pchip->irqmask & 0x02))
 		for (icnt = 0; icnt < LP8755_BUCK_MAX; icnt++)
-			if (pchip->rdev[icnt] != NULL)
+			if (pchip->rdev[icnt] != NULL) {
+				regulator_lock(pchip->rdev[icnt]);
 				regulator_notifier_call_chain(pchip->rdev[icnt],
 							      LP8755_EVENT_OVP,
 							      NULL);
+				regulator_unlock(pchip->rdev[icnt]);
+			}
 	return IRQ_HANDLED;
 
 err_i2c:
-- 
2.20.1

