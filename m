Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A532146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491655;
	bh=ywRGNlCsVRrb6F70zKYexIH9iIKf49akhsC8rqNitDc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vxcLzn00kt+kwGmWKihdB7n91Sx3t2M8/W8Q31LsEANKz87FUeUTHJIty72KNRL6+
	 jlZXwKLb67Nbaj8/SKaYEJWlqL8RRVKlP0S7TM/WSIUQ0eOj81D+f7DShc7oOX6Xex
	 VWKuEQoF1U2282bLp1p0Z+kJjHLsQdDnlHQV6v6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfCMPky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:40:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50618 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfCMPjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+xAaR4iGsxnwhLF6voosLS84VrhOyAnHo9/V71zoIbA=; b=f4GZkqJ5eADK
        TRrEJlDvBrTj9XoKKMwgj0LtwHpUm6paDflI5VymsABk9TB3+N3Y1C+t9oD7uDnQv8d/KyAaWxQNq
        mYYEkwvFBy7V0/ElLrsIIO4hNG/iJUo1FM6RGxSoAKk6vVqNR3phIVaMNXGuenNQiBAF8nmjqGGii
        Chj+s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45yZ-0003TS-Vl; Wed, 13 Mar 2019 15:39:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4E53B1128B98; Wed, 13 Mar 2019 15:39:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9063: Fix notifier mutex lock warning" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190313153927.4E53B1128B98@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:39:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9063: Fix notifier mutex lock warning

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

From 29d40b4a5776ec4727c9f0e00a884423dd5e3366 Mon Sep 17 00:00:00 2001
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 26 Feb 2019 15:23:02 +0000
Subject: [PATCH] regulator: da9063: Fix notifier mutex lock warning

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: 69ca3e58d178 ("regulator: da9063: Add Dialog DA9063 voltage regulators support.")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9063-regulator.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2b0c7a85306a..d7bdb95b7602 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -615,9 +615,12 @@ static irqreturn_t da9063_ldo_lim_event(int irq, void *data)
 		if (regl->info->oc_event.reg != DA9063_REG_STATUS_D)
 			continue;
 
-		if (BIT(regl->info->oc_event.lsb) & bits)
+		if (BIT(regl->info->oc_event.lsb) & bits) {
+		        regulator_lock(regl->rdev);
 			regulator_notifier_call_chain(regl->rdev,
 					REGULATOR_EVENT_OVER_CURRENT, NULL);
+		        regulator_unlock(regl->rdev);
+		}
 	}
 
 	return IRQ_HANDLED;
-- 
2.20.1

