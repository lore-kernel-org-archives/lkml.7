Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1B3C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0BE206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271916;
	bh=pKnw5bX2kgm6adhTcrb5QWg6kn/GApkbivEw+41/awo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=d8Z2Jb9UfKk1n/UJKgKUA7CtWr5przfjHJbNLHChN+IKng2kLiC9MCcrK4HSu/hQL
	 +DoCoCPIUEokyQHKEratFwo4xIFXxuYRdeFfQRXaI/LZxG+fKHWrmUj5ptblrqDWPA
	 Xu/2MiO5YP9Rv9dqiUlnsRokxjN9/VTCwj9NtBbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfDZJpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:45:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54052 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDZJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+BLQkyGLUZnxrewmUmEBXg5WSq7bdWZ6ieFR2b1QTDA=; b=fEM90vNGrzXn
        A6cYoHbN4FBku0BY8zezZ2misK7fznmbSGU7LTIx++cWCZfnLSRrUeMm05WIXaA0Pn4+wBFQgusxz
        w6FJNK9Jp/ACFjm6L+xEqNaIXR6iQ6pwXXjD8tG/F/X6Q4Kpg98uj+lEBwrdf8NTx9AMBIoRjm6sf
        tOnBs=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxPr-0003Qm-4f; Fri, 26 Apr 2019 09:45:11 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0C90A441D3B; Fri, 26 Apr 2019 10:45:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps6524x: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094508.0C90A441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:45:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps6524x: Constify regulator_ops

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

From 357db0279a230e009d4440db71c497f3360311bc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 13 Apr 2019 15:30:01 +0800
Subject: [PATCH] regulator: tps6524x: Constify regulator_ops

The regulator_ops is never changed, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps6524x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index 67cac2682f50..c09223c34dbf 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -565,7 +565,7 @@ static int is_supply_enabled(struct regulator_dev *rdev)
 	return read_field(hw, &info->enable);
 }
 
-static struct regulator_ops regulator_ops = {
+static const struct regulator_ops regulator_ops = {
 	.is_enabled		= is_supply_enabled,
 	.enable			= enable_supply,
 	.disable		= disable_supply,
-- 
2.20.1

