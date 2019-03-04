Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DDCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5E920830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551657994;
	bh=B6IsBw6sGfisdfkfCW7eMqgA9LWZfHyT7iLtmoorYU8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ffC5qmXKvo4U8BrZyYwd+e27n3AGSsrNwmKC1FKizi9fSzq7SklVbEp1C0/6l0ooO
	 exK7G06xEs0aRPHpQo35Ns8eHPPpAD39aE68xcuZjnYrTudu60SxJ9oKSLgks+vsyJ
	 FaXHLKtvfXCkz+O1YX1z48E7s6OndgfTFZ2/k4e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCDAGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCDAGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6aJPSZlassw+VKNHLnDs/4Z/2Sx72SmEGKSHxJIRZX4=; b=PMu33EsfMzTG
        ZOJVQ3LIK8vjj/aYB7Rx/mQDt7d8J+cNTqmtmJoRnjtS7tDzLFh7bZnpwSjYIdCSe5lMBkuVCAEfX
        frh/gRmzMVGXMkYY/yTEufdcjC9LNaKsle28li+TY1de7DOMqfICGdDOClpBWeSLZakOqut2Tya4g
        /fE/4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b7l-0007PR-F7; Mon, 04 Mar 2019 00:06:29 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CE0FC440082; Mon,  4 Mar 2019 00:06:28 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mc13xxx: Constify regulator_ops variables" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000628.CE0FC440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:28 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mc13xxx: Constify regulator_ops variables

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

From e5680c4de3eb3ea5538d11733a91ccef19badd69 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 1 Mar 2019 22:20:53 +0800
Subject: [PATCH] regulator: mc13xxx: Constify regulator_ops variables

These regulator_ops variables should never change, make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mc13783-regulator.c      | 4 ++--
 drivers/regulator/mc13892-regulator.c      | 8 ++++----
 drivers/regulator/mc13xxx-regulator-core.c | 4 ++--
 drivers/regulator/mc13xxx.h                | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index 887a1d1726ad..ab558b26cd7c 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -226,7 +226,7 @@ static const unsigned int mc13783_pwgtdrv_val[] = {
 	5500000,
 };
 
-static struct regulator_ops mc13783_gpo_regulator_ops;
+static const struct regulator_ops mc13783_gpo_regulator_ops;
 
 #define MC13783_DEFINE(prefix, name, node, reg, vsel_reg, voltages)	\
 	MC13xxx_DEFINE(MC13783_REG_, name, node, reg, vsel_reg, voltages, \
@@ -380,7 +380,7 @@ static int mc13783_gpo_regulator_is_enabled(struct regulator_dev *rdev)
 	return (val & mc13xxx_regulators[id].enable_bit) != 0;
 }
 
-static struct regulator_ops mc13783_gpo_regulator_ops = {
+static const struct regulator_ops mc13783_gpo_regulator_ops = {
 	.enable = mc13783_gpo_regulator_enable,
 	.disable = mc13783_gpo_regulator_disable,
 	.is_enabled = mc13783_gpo_regulator_is_enabled,
diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index b55894980066..a731e826a037 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -242,8 +242,8 @@ static const unsigned int mc13892_pwgtdrv[] = {
 	5000000,
 };
 
-static struct regulator_ops mc13892_gpo_regulator_ops;
-static struct regulator_ops mc13892_sw_regulator_ops;
+static const struct regulator_ops mc13892_gpo_regulator_ops;
+static const struct regulator_ops mc13892_sw_regulator_ops;
 
 
 #define MC13892_FIXED_DEFINE(name, node, reg, voltages)			\
@@ -387,7 +387,7 @@ static int mc13892_gpo_regulator_is_enabled(struct regulator_dev *rdev)
 }
 
 
-static struct regulator_ops mc13892_gpo_regulator_ops = {
+static const struct regulator_ops mc13892_gpo_regulator_ops = {
 	.enable = mc13892_gpo_regulator_enable,
 	.disable = mc13892_gpo_regulator_disable,
 	.is_enabled = mc13892_gpo_regulator_is_enabled,
@@ -479,7 +479,7 @@ static int mc13892_sw_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops mc13892_sw_regulator_ops = {
+static const struct regulator_ops mc13892_sw_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = mc13892_sw_regulator_set_voltage_sel,
diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index 2243138d8a58..8ff19150ca92 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -99,7 +99,7 @@ static int mc13xxx_regulator_get_voltage(struct regulator_dev *rdev)
 	return rdev->desc->volt_table[val];
 }
 
-struct regulator_ops mc13xxx_regulator_ops = {
+const struct regulator_ops mc13xxx_regulator_ops = {
 	.enable = mc13xxx_regulator_enable,
 	.disable = mc13xxx_regulator_disable,
 	.is_enabled = mc13xxx_regulator_is_enabled,
@@ -127,7 +127,7 @@ int mc13xxx_fixed_regulator_set_voltage(struct regulator_dev *rdev, int min_uV,
 }
 EXPORT_SYMBOL_GPL(mc13xxx_fixed_regulator_set_voltage);
 
-struct regulator_ops mc13xxx_fixed_regulator_ops = {
+const struct regulator_ops mc13xxx_fixed_regulator_ops = {
 	.enable = mc13xxx_regulator_enable,
 	.disable = mc13xxx_regulator_disable,
 	.is_enabled = mc13xxx_regulator_is_enabled,
diff --git a/drivers/regulator/mc13xxx.h b/drivers/regulator/mc13xxx.h
index a602b08d4c9e..ba7eff1070bd 100644
--- a/drivers/regulator/mc13xxx.h
+++ b/drivers/regulator/mc13xxx.h
@@ -53,8 +53,8 @@ static inline struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 }
 #endif
 
-extern struct regulator_ops mc13xxx_regulator_ops;
-extern struct regulator_ops mc13xxx_fixed_regulator_ops;
+extern const struct regulator_ops mc13xxx_regulator_ops;
+extern const struct regulator_ops mc13xxx_fixed_regulator_ops;
 
 #define MC13xxx_DEFINE(prefix, _name, _node, _reg, _vsel_reg, _voltages, _ops)	\
 	[prefix ## _name] = {				\
-- 
2.20.1

