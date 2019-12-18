Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A041EC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB322176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576699597;
	bh=OXKaT/XTd+57ftkZUvEGJQpN2GK06XAWK17DxN7c1zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=FqWM14egEIzc2eyfEahxC2oEOcwONk2WEUeYTjgkiKgwTgqO7aGQ5Hth0dLBmOTzB
	 F6LzyreO3df0U/bFfVduI0TkFC7a1atD8TEqytMT3tXk5MDMQK8+mHakENmJJx3+DG
	 YsGQLuoyB4McZlHRGnBlPJF0l1eQqkor3YhyklXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfLRUGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:06:36 -0500
Received: from foss.arm.com ([217.140.110.172]:59524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbfLRUGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:06:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9665A31B;
        Wed, 18 Dec 2019 12:06:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1112B3F67D;
        Wed, 18 Dec 2019 12:06:34 -0800 (PST)
Date:   Wed, 18 Dec 2019 20:06:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "regulator: axp20x: Fix AXP22x ELDO2 regulator enable bitmask" to the regulator tree
In-Reply-To: <20191218044720.21990-1-wens@kernel.org>
Message-Id: <applied-20191218044720.21990-1-wens@kernel.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: Fix AXP22x ELDO2 regulator enable bitmask

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From f40ddaa059fdfb472e3aeb733c6220d8e0633a47 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 18 Dec 2019 12:47:20 +0800
Subject: [PATCH] regulator: axp20x: Fix AXP22x ELDO2 regulator enable bitmask

A copy-paste error was introduced when bitmasks were converted to
macros, incorrectly setting the enable bitmask for ELDO2 to the one
for ELDO1 for the AXP22x units.

Fix it by using the correct macro.

On affected boards, ELDO1 and/or ELDO2 are used to power the camera,
which is currently unsupported.

Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20191218044720.21990-1-wens@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 989506bd90b1..fe369cba34fb 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -605,7 +605,7 @@ static const struct regulator_desc axp22x_regulators[] = {
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO1_MASK),
 	AXP_DESC(AXP22X, ELDO2, "eldo2", "eldoin", 700, 3300, 100,
 		 AXP22X_ELDO2_V_OUT, AXP22X_ELDO2_V_OUT_MASK,
-		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO1_MASK),
+		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO2_MASK),
 	AXP_DESC(AXP22X, ELDO3, "eldo3", "eldoin", 700, 3300, 100,
 		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO3_MASK),
-- 
2.20.1

