Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121FD2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578870;
	bh=GWp+XMOG3nz+SgIvr8m1htApixWbtNGRkkkizOMuXII=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JPwQkeW+UgF56MEfHm0LMHDZTAbCjWQ3ZSKhQF23aHYsjE8JD7LAzMdJupu05NbOb
	 E/eWlJK9/sxDhs+ws+s5mwvbs4xEVeh0GIo16pgNprobMKh50yTjpSxogAtA/2GLkv
	 3ezkr0WDcc7uR3rflmuvlxCRiwlrJwmoNCQ9F7LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfCNPy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:54:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36164 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfCNPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=au3dvNXzmjYN1ENUgBg2PdRM6Yahivow2cEMYRREeAM=; b=VuWlpp47vyot
        V85jkQ5Xe2KHOe0DlQ6Kwcp5kPNbMfXFTHJ7QOWDPr5CUMMEYl0kTyhBlRHfOiQ8Mlr9EReIml6uM
        2/GyTY8qji7F79fmRfc79yyqVLfUp3Aa4riOnIWQHrMmPcB3BLFPoqZOjc4z0p1mtY60xmAXkNnlT
        SHGJE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4Sga-0002jI-3n; Thu, 14 Mar 2019 15:54:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 94CE71126E64; Thu, 14 Mar 2019 15:54:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: pv88080: Fix notifier mutex lock warning" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190314155423.94CE71126E64@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:54:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pv88080: Fix notifier mutex lock warning

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

From 1867af94cfdf37fc70fe67b3d522e78352800196 Mon Sep 17 00:00:00 2001
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 26 Feb 2019 15:44:54 +0000
Subject: [PATCH] regulator: pv88080: Fix notifier mutex lock warning

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: 99cf3af5e2d5 ("regulator: pv88080: new regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pv88080-regulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index bdddacdbeb99..6279216fb254 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -345,9 +345,11 @@ static irqreturn_t pv88080_irq_handler(int irq, void *data)
 	if (reg_val & PV88080_E_VDD_FLT) {
 		for (i = 0; i < PV88080_MAX_REGULATORS; i++) {
 			if (chip->rdev[i] != NULL) {
+			        regulator_lock(chip->rdev[i]);
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_UNDER_VOLTAGE,
 					NULL);
+			        regulator_unlock(chip->rdev[i]);
 			}
 		}
 
@@ -362,9 +364,11 @@ static irqreturn_t pv88080_irq_handler(int irq, void *data)
 	if (reg_val & PV88080_E_OVER_TEMP) {
 		for (i = 0; i < PV88080_MAX_REGULATORS; i++) {
 			if (chip->rdev[i] != NULL) {
+			        regulator_lock(chip->rdev[i]);
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_OVER_TEMP,
 					NULL);
+			        regulator_unlock(chip->rdev[i]);
 			}
 		}
 
-- 
2.20.1

