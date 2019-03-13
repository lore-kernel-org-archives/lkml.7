Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21FDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE66206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491626;
	bh=H8jN0XI148jCG9TUb/5w0QlT8aZKPT1eeOCoYWUBjPo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xB5eaDH1qRi9ocq1lPvcFUsPVPlK/DTRLlmnFQc8M0yEZlzjj87SeM5hyOFG2m5EM
	 lp7IJDCuYz/WANLKJ99dIGzaJgzSoktBX7f08AiSt0T5McJnOefquOvd6ak869JI2U
	 0mXUUETfS5SEuKRWTZVo+zPcLmooHjSjAdsaX1gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfCMPjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50846 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfCMPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NQq+mb9AR4o5fKhQhKch/g0wlcjQYWUfSQDFFlY9I8Y=; b=teMbPmVE3b1O
        UxviltwFSP/AHgo+Rex2qCqzQMnyGft8/pFmhogu12dWgeqjZ51ACF8WlEuUHobsl4RoooN0s/iD6
        lCmR6nVUZ9FFNWR0WC27zgXZhTR09aLuY0ZEB/mLFoxyp2u4Y22pgSg2G969v3dDNpMMtM8J37UkD
        CpajU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45yi-0003U1-Em; Wed, 13 Mar 2019 15:39:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B0EB91128B97; Wed, 13 Mar 2019 15:39:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9055: Fix notifier mutex lock warning" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190313153935.B0EB91128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:39:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9055: Fix notifier mutex lock warning

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

From 5e6afb3832bedf420dd8e4c5b32ed85117c5087d Mon Sep 17 00:00:00 2001
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 26 Feb 2019 14:59:59 +0000
Subject: [PATCH] regulator: da9055: Fix notifier mutex lock warning

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: f6130be652d0 ("regulator: DA9055 regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9055-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 3c6fac793658..3ade4b8d204e 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -487,8 +487,10 @@ static irqreturn_t da9055_ldo5_6_oc_irq(int irq, void *data)
 {
 	struct da9055_regulator *regulator = data;
 
+	regulator_lock(regulator->rdev);
 	regulator_notifier_call_chain(regulator->rdev,
 				      REGULATOR_EVENT_OVER_CURRENT, NULL);
+	regulator_unlock(regulator->rdev);
 
 	return IRQ_HANDLED;
 }
-- 
2.20.1

