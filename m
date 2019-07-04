Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E216C46486
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567C720828
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562257984;
	bh=GEnFJ/8txDVmOhxPRs32Kk+fQM7JlJ8sVP7gs2efdyE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wmBP9q7mYUxxfvyNe5L4kufykpiSNOlXIfkIHw+5YV8T1w50TFj1H4XudywuX6YJk
	 bv5IEzeUAisR8B42tdXr2PjfPOl7GrvkEaSeOBFwQp2pIRFgirMcQTT7C7cNAhu2tz
	 j0xL2kfWMm+uW09aeT6OlwNu77peGAz/D0v77USU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGDQc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:32:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfGDQc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zodjW5Kg1HRKcHIXz7+5/nzLctd0FssqPejVzR5xjNo=; b=ptdhzaPBmYoy
        Jgo0YKTkqnEIHLLsL39hKKC1MZ6bt7RFLUuZ+9/F6jEFUXbeV7USqwsLND37VKxs0UMVMwx2Sp3h8
        v4ZQ6akAS+yCStzYHNOYhcKEPbebAUPP6sj7+OdpJiiwknm+APgZHKPnRL5Zd+vPxJ4doNe/5K+vR
        XeDlI=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hj4fH-0001Hc-Vh; Thu, 04 Jul 2019 16:32:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2611D2742EB1; Thu,  4 Jul 2019 17:32:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: implement selector stepping" to the regulator tree
In-Reply-To: <20190703161035.31808-2-brgl@bgdev.pl>
X-Patchwork-Hint: ignore
Message-Id: <20190704163255.2611D2742EB1@ypsilon.sirena.org.uk>
Date:   Thu,  4 Jul 2019 17:32:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: implement selector stepping

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From 2da8d9473e20a2f6645dcb0cea4848a2c1e83af9 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 3 Jul 2019 18:10:34 +0200
Subject: [PATCH] regulator: implement selector stepping

Some regulators require that the requested voltage be reached gradually
by setting all or some of the intermediate values. Implement a new field
in the regulator description struct that allows users to specify the
number of selectors by which the regulator API should step when ramping
the voltage up/down.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Link: https://lore.kernel.org/r/20190703161035.31808-2-brgl@bgdev.pl
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c         | 63 ++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  6 +++
 2 files changed, 69 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9d3ed13b7f12..df82e2a8442a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3106,6 +3106,66 @@ static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
+static int _regulator_set_voltage_sel_step(struct regulator_dev *rdev,
+					   int uV, int new_selector)
+{
+	const struct regulator_ops *ops = rdev->desc->ops;
+	int diff, old_sel, curr_sel, ret;
+
+	/* Stepping is only needed if the regulator is enabled. */
+	if (!_regulator_is_enabled(rdev))
+		goto final_set;
+
+	if (!ops->get_voltage_sel)
+		return -EINVAL;
+
+	old_sel = ops->get_voltage_sel(rdev);
+	if (old_sel < 0)
+		return old_sel;
+
+	diff = new_selector - old_sel;
+	if (diff == 0)
+		return 0; /* No change needed. */
+
+	if (diff > 0) {
+		/* Stepping up. */
+		for (curr_sel = old_sel + rdev->desc->vsel_step;
+		     curr_sel < new_selector;
+		     curr_sel += rdev->desc->vsel_step) {
+			/*
+			 * Call the callback directly instead of using
+			 * _regulator_call_set_voltage_sel() as we don't
+			 * want to notify anyone yet. Same in the branch
+			 * below.
+			 */
+			ret = ops->set_voltage_sel(rdev, curr_sel);
+			if (ret)
+				goto try_revert;
+		}
+	} else {
+		/* Stepping down. */
+		for (curr_sel = old_sel - rdev->desc->vsel_step;
+		     curr_sel > new_selector;
+		     curr_sel -= rdev->desc->vsel_step) {
+			ret = ops->set_voltage_sel(rdev, curr_sel);
+			if (ret)
+				goto try_revert;
+		}
+	}
+
+final_set:
+	/* The final selector will trigger the notifiers. */
+	return _regulator_call_set_voltage_sel(rdev, uV, new_selector);
+
+try_revert:
+	/*
+	 * At least try to return to the previous voltage if setting a new
+	 * one failed.
+	 */
+	(void)ops->set_voltage_sel(rdev, old_sel);
+	return ret;
+}
+
 static int _regulator_set_voltage_time(struct regulator_dev *rdev,
 				       int old_uV, int new_uV)
 {
@@ -3179,6 +3239,9 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				selector = ret;
 				if (old_selector == selector)
 					ret = 0;
+				else if (rdev->desc->vsel_step)
+					ret = _regulator_set_voltage_sel_step(
+						rdev, best_val, selector);
 				else
 					ret = _regulator_call_set_voltage_sel(
 						rdev, best_val, selector);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 377da2357118..f0d7b0496e54 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -286,6 +286,11 @@ enum regulator_type {
  * @vsel_range_mask: Mask for register bitfield used for range selector
  * @vsel_reg: Register for selector when using regulator_regmap_X_voltage_
  * @vsel_mask: Mask for register bitfield used for selector
+ * @vsel_step: Specify the resolution of selector stepping when setting
+ *	       voltage. If 0, then no stepping is done (requested selector is
+ *	       set directly), if >0 then the regulator API will ramp the
+ *	       voltage up/down gradually each time increasing/decreasing the
+ *	       selector by the specified step value.
  * @csel_reg: Register for current limit selector using regmap set_current_limit
  * @csel_mask: Mask for register bitfield used for current limit selector
  * @apply_reg: Register for initiate voltage change on the output when
@@ -360,6 +365,7 @@ struct regulator_desc {
 	unsigned int vsel_range_mask;
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
+	unsigned int vsel_step;
 	unsigned int csel_reg;
 	unsigned int csel_mask;
 	unsigned int apply_reg;
-- 
2.20.1

