Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F737C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604A32184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578879;
	bh=qE46AxFgc/L1JsLm3s/DLmpoCA1qTDT8zeqiMLm0DnY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=E+wGvPWzEJY2e7lIaxMKkpECKSv6pyiLocJ31HMnzyvf6WmWTrfJRVSmykCUQaga2
	 fh9XFPGN2nw0e1We8QxtPTUNTykjTMb4OxmnhKAXIJaZcFYHOk7vhNvV1PVRUcHW3P
	 KLO5+5RhKOi7kRplzjtdtyGanClVX6Ye3oSHABUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfCNPyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:54:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36254 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfCNPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vpqKQbtWAfkfjLyV/A9ZwEba1FnCfh+7G/9WCz/3iIg=; b=IuptS428hGpQ
        JFuPt78gC3J+sBmLYUDWUPv7DO8R5dbjcCzcJXeoz6Wdn1plkHTA0Df12V7Bob/AuIxNGZQYXiaXc
        vTYSeh1Mr/m5yATH1lCqMr+JE2ETmN5ZLp7No298F3OkBcozt34OQw0rl5F326F+1raIICEaDDuP3
        d13Ao=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4Sgb-0002jP-NE; Thu, 14 Mar 2019 15:54:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 45CA71126E64; Thu, 14 Mar 2019 15:54:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9062: Fix notifier mutex lock warning" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190314155425.45CA71126E64@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:54:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9062: Fix notifier mutex lock warning

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

From 978995def0f6030aa6b3b494682f673aca13881b Mon Sep 17 00:00:00 2001
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 26 Feb 2019 15:19:34 +0000
Subject: [PATCH] regulator: da9062: Fix notifier mutex lock warning

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: 4068e5182ada ("regulator: da9062: DA9062 regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index b064d8a19d4c..bab88ddfc509 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -974,8 +974,10 @@ static irqreturn_t da9062_ldo_lim_event(int irq, void *data)
 			continue;
 
 		if (BIT(regl->info->oc_event.lsb) & bits) {
+			regulator_lock(regl->rdev);
 			regulator_notifier_call_chain(regl->rdev,
 					REGULATOR_EVENT_OVER_CURRENT, NULL);
+			regulator_unlock(regl->rdev);
 			handled = IRQ_HANDLED;
 		}
 	}
-- 
2.20.1

