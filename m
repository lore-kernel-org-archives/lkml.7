Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364E1C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07641206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271649;
	bh=Bb/flsLYKCWvbjKKMK2/R1DqXM4FAh5yuGHoc3El168=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=S1lEuFLd1kJSborxvuH7wr9wdLCjztY0BBRc4Q4rusYZbO4Tj8T0FDsvGb89SeMr+
	 h18E7hGHYKUQs20l8epXNfJWj8STVy5zhzzL6nTR+PjZ1/Zx7ou+x4UjCtE+XEzBg1
	 /yDP4OI2PsdR7YU6tlnKUShmAFwMfw+P2AAwrvPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfDZJkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:40:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46226 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfDZJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HKuWBG4wvteGUtSok7lFBXe1h1ojTCken9rISdjcG9k=; b=RwgWgTyATAzu
        jUn4/66MB6CHyh9P8kqE005mN6bc1G4mNmW8tspQ+Uxqglp3pPO+XxMUx9dqe9O7IUinzmSoXdp1I
        L2tljLbbZtj92gs+k157CboP6F71BbN51qgCKaMuBDBuzFGWrVKIMy87IaKFld0ey5euUP6LF8ma4
        I0+Vk=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxLX-0003K2-GH; Fri, 26 Apr 2019 09:40:43 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 13C10441D3B; Fri, 26 Apr 2019 10:40:42 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps80031: Constify regulator_ops and tps80031_dcdc_voltages array" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094042.13C10441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:42 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps80031: Constify regulator_ops and tps80031_dcdc_voltages array

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

From 4b77a49cb82652488e35ed8d3809f33cedbad6dc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 16 Apr 2019 18:17:28 +0800
Subject: [PATCH] regulator: tps80031: Constify regulator_ops and
 tps80031_dcdc_voltages array

These regulator_ops variables and tps80031_dcdc_voltages array never need
to be modified, make them const so compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps80031-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index d97cd55b6850..8e65a13e2ef5 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -154,7 +154,7 @@ static int tps80031_reg_disable(struct regulator_dev *rdev)
 }
 
 /* DCDC voltages for the selector of 58 to 63 */
-static int tps80031_dcdc_voltages[4][5] = {
+static const int tps80031_dcdc_voltages[4][5] = {
 	{ 1350, 1500, 1800, 1900, 2100},
 	{ 1350, 1500, 1800, 1900, 2100},
 	{ 2084, 2315, 2778, 2932, 3241},
@@ -377,7 +377,7 @@ static int tps80031_vbus_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static struct regulator_ops tps80031_dcdc_ops = {
+static const struct regulator_ops tps80031_dcdc_ops = {
 	.list_voltage		= tps80031_dcdc_list_voltage,
 	.set_voltage_sel	= tps80031_dcdc_set_voltage_sel,
 	.get_voltage_sel	= tps80031_dcdc_get_voltage_sel,
@@ -386,7 +386,7 @@ static struct regulator_ops tps80031_dcdc_ops = {
 	.is_enabled	= tps80031_reg_is_enabled,
 };
 
-static struct regulator_ops tps80031_ldo_ops = {
+static const struct regulator_ops tps80031_ldo_ops = {
 	.list_voltage		= tps80031_ldo_list_voltage,
 	.map_voltage		= tps80031_ldo_map_voltage,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
@@ -396,18 +396,18 @@ static struct regulator_ops tps80031_ldo_ops = {
 	.is_enabled		= tps80031_reg_is_enabled,
 };
 
-static struct regulator_ops tps80031_vbus_sw_ops = {
+static const struct regulator_ops tps80031_vbus_sw_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= tps80031_vbus_enable,
 	.disable	= tps80031_vbus_disable,
 	.is_enabled	= tps80031_vbus_is_enabled,
 };
 
-static struct regulator_ops tps80031_vbus_hw_ops = {
+static const struct regulator_ops tps80031_vbus_hw_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 };
 
-static struct regulator_ops tps80031_ext_reg_ops = {
+static const struct regulator_ops tps80031_ext_reg_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= tps80031_reg_enable,
 	.disable	= tps80031_reg_disable,
-- 
2.20.1

