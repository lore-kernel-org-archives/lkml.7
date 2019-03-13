Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B1D20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491674;
	bh=gfBLBOgd3rkssLOWLS4AldIYLJgeG+BJ3paH+ombBA8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=brYXZtD08xj5cVzcvpYB7qkVkiLbkD1B8xfCs2pz6USLpS4/tZx9vb2NYqRfyYTzt
	 lax4fI11SkfGYwB51VxnM0IM4q0t6TkZIOpf7VRFOJbsRGgibwjn4rrOkthdYG/GjH
	 WYVGDAtjT0UEhxD9QXFSZ/7j4sIboOPT+JZ66rjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfCMPlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:41:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50182 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfCMPjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NdGL8KOrKJe2hqkZlv8wZta21qCpcrxPXno/VI4WDCE=; b=Z6VQkiWrU/TH
        4CsitKQIxt2MMakmPYOcm2j3QEBVgQtQWQOI1dSYAWeAKjubFE+e9eP78lFgvlLMBaPwA/l3gMx7K
        PoA+fsTl3DDKyMgRAMenIESWTFlMCQw7bdnIs9N7gUTf1SO/5Rux98CZoo8ZMqEgNGzeuGzhKXvHi
        UQpS4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45yM-0003Sg-F9; Wed, 13 Mar 2019 15:39:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DBDA21128B97; Wed, 13 Mar 2019 15:39:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm831x isink: Fix notifier mutex lock warning" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190313153913.DBDA21128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:39:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm831x isink: Fix notifier mutex lock warning

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

From f7a621728a6a23bfd2c6ac4d3e42e1303aefde0f Mon Sep 17 00:00:00 2001
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 26 Feb 2019 15:51:28 +0000
Subject: [PATCH] regulator: wm831x isink: Fix notifier mutex lock warning

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: d4d6b722e780 ("regulator: Add WM831x ISINK support")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm831x-isink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index 6dd891d7eee3..11f351191dba 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -140,9 +140,11 @@ static irqreturn_t wm831x_isink_irq(int irq, void *data)
 {
 	struct wm831x_isink *isink = data;
 
+	regulator_lock(isink->regulator);
 	regulator_notifier_call_chain(isink->regulator,
 				      REGULATOR_EVENT_OVER_CURRENT,
 				      NULL);
+	regulator_unlock(isink->regulator);
 
 	return IRQ_HANDLED;
 }
-- 
2.20.1

