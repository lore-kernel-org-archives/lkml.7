Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF347C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F062133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920717;
	bh=e98sWoYQGK/HCXBzOZWzHAjKgWJNlnMzE0RixryzvO8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=I3s/lRtVu1ScUGDIDjJAYgyiznHiWX/cK4rZGUZIQuDu0WgIyMITlIcq2bY6UZkOe
	 2gYieOp3x6Fo56cIdZgWnLHRDqi6xdVY3Yh4X4GBB21atNGtQ5a1dKwoF7E+/v/zXq
	 ai3InR4z68A2nvQ2gk4hAKE/yXYlhy4jZbFRUHlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfCROv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:51:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55532 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfCROvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9rOGbeO5bA78+ovCm+XbTQZfN55F1YLtKTgoPkwRxhQ=; b=BdRx1dOqALn3
        YZQ4tAMhlXGj1F+yYZg22YAaPlKmec4FdbGg5NQ3r1+KW/2wfEbRHoXSOHcdJXlufTfa02fYoAVOO
        6KuuMOGlR/3ej95Wcny9CCyWAuHX/JFHC+WN/V+hjYXrGEJ1UySSu0PDX2mlbQtFc+MHQGqmNKS+v
        5pqK4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tcE-0005pJ-Jx; Mon, 18 Mar 2019 14:51:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0FD0B1128874; Mon, 18 Mar 2019 14:51:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: as3722: Remove *rdevs[] from struct as3722_regulators" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190318145150.0FD0B1128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:50 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: as3722: Remove *rdevs[] from struct as3722_regulators

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

From 4d92ac7bd9f8af387d387173b380f58ad6f98b51 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 16 Mar 2019 11:52:57 +0800
Subject: [PATCH] regulator: as3722: Remove *rdevs[] from struct
 as3722_regulators

Current code is using devm_regulator_register() so it is not necessary
to save as3722_regs->rdevs[id] for clean up.
The *rdevs[] is not used now, remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/as3722-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index e5fed289b52d..7a315adbe6c4 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -81,7 +81,6 @@ struct as3722_regulator_config_data {
 struct as3722_regulators {
 	struct device *dev;
 	struct as3722 *as3722;
-	struct regulator_dev *rdevs[AS3722_REGULATOR_ID_MAX];
 	struct regulator_desc desc[AS3722_REGULATOR_ID_MAX];
 	struct as3722_regulator_config_data
 			reg_config_data[AS3722_REGULATOR_ID_MAX];
@@ -929,7 +928,6 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		as3722_regs->rdevs[id] = rdev;
 		if (reg_config->ext_control) {
 			ret = regulator_enable_regmap(rdev);
 			if (ret < 0) {
-- 
2.20.1

