Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3CCC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEF1208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271696;
	bh=cW0lDA5r5Uv9I57kipYaKSgJd6VwnuNQkbrIKhpZ644=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=s0vb/8Y72hGtNbZxCKa3QsP2ddxMGJW0Dsug7s96u53XSmp2ORQzpJJhEIom3rBov
	 FR1SZKNemOoF/iW1l8T4f62SRMYZd/uQQTE3ZOOFNio7UgEq1mk0F1gk/946X0VZNg
	 3yBLQjEexBs1kyCji+TuKtR/KrdeUxLS2BLOmibE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfDZJlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:41:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfDZJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=P1HzsiY8ltLKoCOmq+ypzycKoDnu9antRqrjPOiJdGw=; b=YobOYYjMvkgp
        3mWho3oyu98Sw/hnyBO3iGJh+u92GmW5mE78NsORbua4o7FT+WRnN1Z7e8C9OsG9sE5Emfm+QsS5i
        xugLR6Gu4Z4elXnDD5Mmi4IpePRXEQRmgXF4/qP7r7mVpSjt6PGcYQbiI9SuYvq2D/KQ2vsgcAGOa
        lkUVc=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxMG-0003Ld-5m; Fri, 26 Apr 2019 09:41:28 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CDF7C441D3B; Fri, 26 Apr 2019 10:41:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: db8500-prcmu: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094126.CDF7C441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:41:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: db8500-prcmu: Constify regulator_ops

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

From 1a18195a2c4e3da5e082ee297b176a71abb9161a Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 12 Apr 2019 09:54:19 +0800
Subject: [PATCH] regulator: db8500-prcmu: Constify regulator_ops

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/db8500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index 7cec535cf0bc..863bd3de42a7 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -75,7 +75,7 @@ static int db8500_regulator_is_enabled(struct regulator_dev *rdev)
 }
 
 /* db8500 regulator operations */
-static struct regulator_ops db8500_regulator_ops = {
+static const struct regulator_ops db8500_regulator_ops = {
 	.enable			= db8500_regulator_enable,
 	.disable		= db8500_regulator_disable,
 	.is_enabled		= db8500_regulator_is_enabled,
@@ -200,7 +200,7 @@ static int db8500_regulator_switch_is_enabled(struct regulator_dev *rdev)
 	return info->is_enabled;
 }
 
-static struct regulator_ops db8500_regulator_switch_ops = {
+static const struct regulator_ops db8500_regulator_switch_ops = {
 	.enable			= db8500_regulator_switch_enable,
 	.disable		= db8500_regulator_switch_disable,
 	.is_enabled		= db8500_regulator_switch_is_enabled,
-- 
2.20.1

