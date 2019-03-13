Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42EA206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491662;
	bh=3vosEVn19NY46+11FCjyHyO6jAus324/NKY67XUMK2I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=jbnq0/DEEy9oiwEXLehyhHikggvBQEML6wscXA6dINWbHD0ptQD1xOwF3WkLYYLzm
	 PIiUC0Dx+20uH3pXe29Og+IErzGPw6wYzsPoK98keAamx0qgXnzhcq57VfduwEW9D3
	 PUTvzEk/OgGBmBpkw9DY2/11WGeJCL+NVAFMcWa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCMPj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50398 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfCMPjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gCAb2oLKzO2npBX3IR/hO0e1fl4uvXgZEkkvF+gK21U=; b=bR5lVw/y8cDj
        ITq4kv8UWxAJCD7npR0ieY1+1Q+zyXv1sjAZui4RT/fNzqtpUMYTRWx7WxKhvijmdnKKmK5KQl76G
        tQ/BOEKGyvP0/gKkfTmZRNPJeJwetLQdtUC7+UXkbELBbCmySfwe1azSL5b1WM4KndxbYabPA1Zd5
        CX4HY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45yU-0003TC-OK; Wed, 13 Mar 2019 15:39:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 42FB71128B97; Wed, 13 Mar 2019 15:39:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: ltc3589: Fix notifier mutex lock warning" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190313153922.42FB71128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:39:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ltc3589: Fix notifier mutex lock warning

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

From f132da2534ec6599c78c4adcef15340cff2e9dd9 Mon Sep 17 00:00:00 2001
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 26 Feb 2019 15:35:35 +0000
Subject: [PATCH] regulator: ltc3589: Fix notifier mutex lock warning

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: 3eb2c7ecb7ea ("regulator: Add LTC3589 support")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ltc3589.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 63f724f260ef..75089b037b72 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -419,16 +419,22 @@ static irqreturn_t ltc3589_isr(int irq, void *dev_id)
 
 	if (irqstat & LTC3589_IRQSTAT_THERMAL_WARN) {
 		event = REGULATOR_EVENT_OVER_TEMP;
-		for (i = 0; i < LTC3589_NUM_REGULATORS; i++)
+		for (i = 0; i < LTC3589_NUM_REGULATORS; i++) {
+		        regulator_lock(ltc3589->regulators[i]);
 			regulator_notifier_call_chain(ltc3589->regulators[i],
 						      event, NULL);
+		        regulator_unlock(ltc3589->regulators[i]);
+		}
 	}
 
 	if (irqstat & LTC3589_IRQSTAT_UNDERVOLT_WARN) {
 		event = REGULATOR_EVENT_UNDER_VOLTAGE;
-		for (i = 0; i < LTC3589_NUM_REGULATORS; i++)
+		for (i = 0; i < LTC3589_NUM_REGULATORS; i++) {
+		        regulator_lock(ltc3589->regulators[i]);
 			regulator_notifier_call_chain(ltc3589->regulators[i],
 						      event, NULL);
+		        regulator_unlock(ltc3589->regulators[i]);
+		}
 	}
 
 	/* Clear warning condition */
-- 
2.20.1

