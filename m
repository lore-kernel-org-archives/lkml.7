Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A55C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D0E206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272043;
	bh=jdVv7uMKkzlK/fD2HC+XxfruvPNPEXqmdW/a2rhirAk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1O3LMJW4exIesLDa275HpapzzXlAV2stplkFByUCIo9f6HU7a8p1/2x8m3zlU6wSd
	 rYvZzP3S8HOgTRe/kAVqdmeuH9VdyhEu1Dp2PHQA7hR+02ktfA9r8PkFjSEqTG9Pk9
	 6U2qsiqPxKMS/RdNRoPuN4E1piB4qRQXQb28ipgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDZJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:47:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54754 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfDZJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3ZezLZJ+xVOAnD6C7TehXJb6gep3ZNmZ+t6tn5EJ1VM=; b=Iu6ZaD5/ogha
        Aj8taiY3Mx8bN+zk1KHU1IWeDeQXyUItpmSdQyaHI/3Vm7CyjXmfzYeQCS59+22kj6TP6glcRQWK5
        269Fx1l2skaYeiYYCtMBtmHOU5bjneZxkbTwIad4jq4W63mEJcAPNnD41JSp117/MPhbY8ITbPc0e
        5MKxc=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxQA-0003RO-7W; Fri, 26 Apr 2019 09:45:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id EE9F4441D3B; Fri, 26 Apr 2019 10:45:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab8500: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094528.EE9F4441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:45:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500: Constify regulator_ops

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

From 6d66d9952ec06f12197174018be76538150aea05 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 12 Apr 2019 22:11:57 +0800
Subject: [PATCH] regulator: ab8500: Constify regulator_ops

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab8500.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 83dba3fbfe0c..6b9a3463f1fd 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -510,7 +510,7 @@ static int ab8500_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops ab8500_regulator_volt_mode_ops = {
+static const struct regulator_ops ab8500_regulator_volt_mode_ops = {
 	.enable			= ab8500_regulator_enable,
 	.disable		= ab8500_regulator_disable,
 	.is_enabled		= ab8500_regulator_is_enabled,
@@ -522,7 +522,7 @@ static struct regulator_ops ab8500_regulator_volt_mode_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_volt_ops = {
+static const struct regulator_ops ab8500_regulator_volt_ops = {
 	.enable		= ab8500_regulator_enable,
 	.disable	= ab8500_regulator_disable,
 	.is_enabled	= ab8500_regulator_is_enabled,
@@ -531,7 +531,7 @@ static struct regulator_ops ab8500_regulator_volt_ops = {
 	.list_voltage	= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_mode_ops = {
+static const struct regulator_ops ab8500_regulator_mode_ops = {
 	.enable			= ab8500_regulator_enable,
 	.disable		= ab8500_regulator_disable,
 	.is_enabled		= ab8500_regulator_is_enabled,
@@ -541,14 +541,14 @@ static struct regulator_ops ab8500_regulator_mode_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_ops = {
+static const struct regulator_ops ab8500_regulator_ops = {
 	.enable			= ab8500_regulator_enable,
 	.disable		= ab8500_regulator_disable,
 	.is_enabled		= ab8500_regulator_is_enabled,
 	.list_voltage		= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_anamic_mode_ops = {
+static const struct regulator_ops ab8500_regulator_anamic_mode_ops = {
 	.enable		= ab8500_regulator_enable,
 	.disable	= ab8500_regulator_disable,
 	.is_enabled	= ab8500_regulator_is_enabled,
-- 
2.20.1

