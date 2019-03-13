Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79E8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9142420693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491640;
	bh=FzcosVBjhnbSKqIEcWLnXMxpWUQxNKe647sm5OwKHpU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sndrM+rmLNr06sv8o5cK549ZmQtnGnQNM10ilBW1ke2NR8mzqv6ZNPbXtd29Jf5rU
	 RedoW+LrcnSkEo9viGtK9rnXUAix6c4CmMaeOIAEXMLfhyTd2mMDTBBsbParpFMpXp
	 tbpv3AqihDAaMKUNelBWRWBhRt4XMnXicQpWjo5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCMPkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:40:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfCMPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3+0dQHJxtEFZjGNKgNnJRWKMNqsNBYVeEZ/liGzBjRU=; b=PkNNC+c/WUT4
        ZyuDJ/g4qp0FI9uM6m9agHiudTU/JHreM643pFQNgWCdp9nxgqydlw06hQbbmPyImLlTIdnsoSg9s
        6u4TW46YJi3mjDWpKkUqF9vKmf8BGdYO2SQV+oC7eeh4HLo/v+6ksNP0/FXtkwwcpNn/BBWvl/gUn
        wdJ94=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45yd-0003TQ-7u; Wed, 13 Mar 2019 15:39:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A01461128B97; Wed, 13 Mar 2019 15:39:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9211: Fix notifier mutex lock warning" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190313153925.A01461128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:39:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9211: Fix notifier mutex lock warning

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

From 65378de3359d30ebce44762d8b8027f372b5b1c4 Mon Sep 17 00:00:00 2001
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 26 Feb 2019 15:27:57 +0000
Subject: [PATCH] regulator: da9211: Fix notifier mutex lock warning

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: 1028a37daa14 ("regulator: da9211: new regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9211-regulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 109ee12d4362..4d7fe4819c1c 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -322,8 +322,10 @@ static irqreturn_t da9211_irq_handler(int irq, void *data)
 		goto error_i2c;
 
 	if (reg_val & DA9211_E_OV_CURR_A) {
+	        regulator_lock(chip->rdev[0]);
 		regulator_notifier_call_chain(chip->rdev[0],
 			REGULATOR_EVENT_OVER_CURRENT, NULL);
+	        regulator_unlock(chip->rdev[0]);
 
 		err = regmap_write(chip->regmap, DA9211_REG_EVENT_B,
 			DA9211_E_OV_CURR_A);
@@ -334,8 +336,10 @@ static irqreturn_t da9211_irq_handler(int irq, void *data)
 	}
 
 	if (reg_val & DA9211_E_OV_CURR_B) {
+	        regulator_lock(chip->rdev[1]);
 		regulator_notifier_call_chain(chip->rdev[1],
 			REGULATOR_EVENT_OVER_CURRENT, NULL);
+	        regulator_unlock(chip->rdev[1]);
 
 		err = regmap_write(chip->regmap, DA9211_REG_EVENT_B,
 			DA9211_E_OV_CURR_B);
-- 
2.20.1

