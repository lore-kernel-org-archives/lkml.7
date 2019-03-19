Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6468BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3598C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553001237;
	bh=ZsDi3UdOSoac1DyNZ37Pe3ZabqbNL0nd8hMuLHTfzX8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1My2Q++OWgXt7dYcAMJIhfCi9a0UC5EEQj7LJfMNlfYwcZUC9c+bwuur2RAUqFeol
	 sWbH9r0IzyqoM+Z3U3v5rIAog5xdGwBxHqXJ4oNV/l1KcJ5s7cQrz6JgNcB+0c/m5B
	 PiLluH4pM8JtQnKGN5tOvh2eP0Rtap0S88mWmuO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCSNN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:13:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49110 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfCSNNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rbFBmc2+NnDfdMDJjatkH2gVgT9FD6ZHNkJscwF8z0w=; b=kzIBlIEwcVbh
        5QF2x/anwRgrfKusU704OltIudgG6jSGC9TbS/Cu3saGPCnljIuWrTOXDJZiaLIlknts+qVOQYsvS
        0ipdt+mW/9yRxjFHAyZEHo4llNiaQkPH76weYwGd5nGtOX/ur/mhlCuS1mZ7yMmNljMU2Pm8YuDnI
        xjC74=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6EYv-00039m-4P; Tue, 19 Mar 2019 13:13:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B443611288DF; Tue, 19 Mar 2019 13:13:48 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: Remove unneeded NULL test against rdev" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190319131348.B443611288DF@debutante.sirena.org.uk>
Date:   Tue, 19 Mar 2019 13:13:48 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: Remove unneeded NULL test against rdev

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

From 969697de7fa6eee12fbe216f9603708932a78c0d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 19 Mar 2019 11:36:07 +0800
Subject: [PATCH] regulator: axp20x: Remove unneeded NULL test against rdev

rdev won't be NULL in .enable callback.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index fba8f58ab769..8a366f66208e 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -437,9 +437,6 @@ static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
 	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
 	const struct regulator_desc *desc;
 
-	if (!rdev)
-		return -EINVAL;
-
 	desc = rdev->desc;
 
 	switch (axp20x->variant) {
-- 
2.20.1

