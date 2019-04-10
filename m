Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04390C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D19217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554899223;
	bh=I8BxiUhAA4FAdpMo9K5V9h2j8od2JFLl2YTxhFPX3nU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XK+MWoyYaZbGXsil8cz6sC6JsgC+FRPP1QQSWAuNnCRP99RLesh2alS4gSHwbSPcy
	 5nC0DLHcweAHhOlFy2XyGNatBHp1Xe3oirh4sZyMkcrgNff0nxYEMfkERSGTBl24Nq
	 RXMEEw5WOGfFfSMLMItlyajTYFv9RNkm3aKi4v+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfDJM1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:27:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35676 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbfDJM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QbG6TVehOxvmLSmKg7kBE1f9BLeSxRMIzXjwwqLBKSw=; b=KeioA5KcLT/B
        OyvcuEMTFn/Dz9Vga/IcQM31plVynVdW09LKSaCZZ3tEPBDIKaD2Re9Q1lirm008i1Utir6rw51Xh
        ZxbbbZ/flxwNteLUs9H9AdLaqWG/o9/PDp1SB3l4Zt6z0KX9N0djbbD1lbWCNOKs5JOVnP+OIXvbu
        lStK0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hECJd-00007g-Ld; Wed, 10 Apr 2019 12:26:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 302351128ED2; Wed, 10 Apr 2019 13:26:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: hi655x: Constify regulators array" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190410122657.302351128ED2@debutante.sirena.org.uk>
Date:   Wed, 10 Apr 2019 13:26:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: hi655x: Constify regulators array

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

From 784816d46aae28f84a3ec5461b6cf69b6f02d62a Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 8 Apr 2019 20:09:32 +0800
Subject: [PATCH] regulator: hi655x: Constify regulators array

The regulators array should never need to be modified, make it const so
compiler can put it to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/hi655x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index bba24a6fdb1e..460ae70d8b04 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -158,7 +158,7 @@ static const struct regulator_ops hi655x_ldo_linear_ops = {
 	.ctrl_mask = cmask,                                      \
 }
 
-static struct hi655x_regulator regulators[] = {
+static const struct hi655x_regulator regulators[] = {
 	HI655X_LDO_LINEAR(LDO2, 0x72, 0x07, 0x29, 0x2a, 0x2b, 0x01,
 			  2500000, 8, 100000),
 	HI655X_LDO(LDO7, 0x78, 0x07, 0x29, 0x2a, 0x2b, 0x06, ldo7_voltages),
-- 
2.20.1

