Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED4E20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553516546;
	bh=YSosRfbSiVh4WnRb59z4qFkq1+ikA0IKbLPafwzZYv0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EKB3DHrNsH3xaMBlfn6xH3+pnw+tbV/Tz7SguSCNMIF43NWAS2nqd6Or3ZyTkNFy6
	 Mcs1oA0/ks2s14+AZfWJWhRbinHZYZls0Ld2VilpR79lCm7zBCWgnj21u/ukWyhCpV
	 smswnfnyeWKNcoj456vofbjYWKHWFr8F+QbQNDc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfCYMWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:22:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730827AbfCYMWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JQMwwRlGkr3Q3l0/1niCaTTLBk5Gv6MjAGGHB1AlLCc=; b=sj8C692AGob7
        oiMeEePHk+dynqFlXfo4o2EwJD0bI8k8Z3aDPeDR0oxMdTilrUssB9npOHk+0n0mxg08d/FrV7F/G
        acGFBc5fak0B+3IVY5E4BdrhBdIE/7bTb5JAYU/hHjdQRwGAtsadr+3TF55tCa9sNpdOSahrWlRda
        rdpl4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8OcP-00024X-T1; Mon, 25 Mar 2019 12:22:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5B9B211288F3; Mon, 25 Mar 2019 12:22:21 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps65218: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190325122221.5B9B211288F3@debutante.sirena.org.uk>
Date:   Mon, 25 Mar 2019 12:22:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65218: Constify regulator_ops

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

From d1030b439934cbc23def17f88e60cfb35e2723ac Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 24 Mar 2019 10:05:42 +0800
Subject: [PATCH] regulator: tps65218: Constify regulator_ops

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65218-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 95708d34876b..7aed3fbffecc 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -162,7 +162,7 @@ static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
 }
 
 /* Operations permitted on DCDC1, DCDC2 */
-static struct regulator_ops tps65218_dcdc12_ops = {
+static const struct regulator_ops tps65218_dcdc12_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -176,7 +176,7 @@ static struct regulator_ops tps65218_dcdc12_ops = {
 };
 
 /* Operations permitted on DCDC3, DCDC4 and LDO1 */
-static struct regulator_ops tps65218_ldo1_dcdc34_ops = {
+static const struct regulator_ops tps65218_ldo1_dcdc34_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -245,7 +245,7 @@ static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
 	return ls3_currents[index];
 }
 
-static struct regulator_ops tps65218_ls23_ops = {
+static const struct regulator_ops tps65218_ls23_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -255,7 +255,7 @@ static struct regulator_ops tps65218_ls23_ops = {
 };
 
 /* Operations permitted on DCDC5, DCDC6 */
-static struct regulator_ops tps65218_dcdc56_pmic_ops = {
+static const struct regulator_ops tps65218_dcdc56_pmic_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
-- 
2.20.1

