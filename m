Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB36C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB02521473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266527;
	bh=1O8W/LoTJPiV29a4jIfiloaPeCUufbWNsrcD+C8EUBw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wu1ePH3uRgbeCarMha43t+ttSm+HCi9Bx10bQ1tjlWsb8tF5hmqQsnk4ht5xupmiG
	 BHykR1XsyhtFUDD4UjVjk40fH7/q3wxUKNlxAz2NfwbuTaSlKJUwFjqvsKz8+B9mEm
	 /0bOXbvyMs1Mbh0rceQ2qZ6nVDGYpWUiGdUW3sx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfDCEmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:42:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCEmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=oQZRBlJ2rttEEukWsIv+kTnYVMhMj+nyV2o5zqwTXZU=; b=crAwYgEmeltm
        EhHXFWBuFHLD2dwpLJwXVkCrsjq9SS3/PzNVCa6ATSDcp0gXgCWKURYXokvvwAM08XRziqJqOMOWw
        dy186Q64MkW4v9rJwKQ+l3SbOGmiXvH3ZSFjqWrPgWZduuA9z2wfaL/tBfWzHMF1bVy5pe1a/4Ofz
        ZKpmE=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXiq-0003zx-7x; Wed, 03 Apr 2019 04:42:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4D24C440082; Wed,  3 Apr 2019 05:41:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: twl: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190403044157.4D24C440082@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:41:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: twl: Constify regulator_ops

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

From 401861f51a470ef9b21c949b3c86aa525bd5e7dc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 3 Apr 2019 07:41:54 +0800
Subject: [PATCH] regulator: twl: Constify regulator_ops

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 402ea43c77d1..cdd81e1985ff 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -392,7 +392,7 @@ static int twl4030ldo_get_voltage_sel(struct regulator_dev *rdev)
 	return vsel;
 }
 
-static struct regulator_ops twl4030ldo_ops = {
+static const struct regulator_ops twl4030ldo_ops = {
 	.list_voltage	= twl4030ldo_list_voltage,
 
 	.set_voltage_sel = twl4030ldo_set_voltage_sel,
@@ -430,14 +430,14 @@ static int twl4030smps_get_voltage(struct regulator_dev *rdev)
 	return vsel * 12500 + 600000;
 }
 
-static struct regulator_ops twl4030smps_ops = {
+static const struct regulator_ops twl4030smps_ops = {
 	.set_voltage	= twl4030smps_set_voltage,
 	.get_voltage	= twl4030smps_get_voltage,
 };
 
 /*----------------------------------------------------------------------*/
 
-static struct regulator_ops twl4030fixed_ops = {
+static const struct regulator_ops twl4030fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 
 	.enable		= twl4030reg_enable,
-- 
2.20.1

