Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D80C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98322075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553611422;
	bh=3LpxxbmZj6TjN1nObVmWvq3Sd5BDzpoO8lqTtO2msQA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Tp8Z5mQunEosS6BoyDIPiWLogRveH1biZT2GuxMxmFZhzAZPsBbd1cATgEofYFfye
	 8bfjDVKNyIf3RXU9bjnNZ2oXN1YmkHRGADL6ScNG9EgDqsF6xA2aFfjSMRpCJZztNe
	 8rJlYuQfL5lUBhpjYSZ/TQADljlnNSTr+9JM7Hz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfCZOnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:43:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35700 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbfCZOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OkRfarRKsXu8BMCMUSY38OjlAQCJMUyNygF2RDdInew=; b=slVUCeCv0nUX
        oTolQKPAlluwcaWVEU0pDRSM3b+AA5GySkNslCnsW7w6B/XVAj8hRXwznDnzAxMMuszwvrPCo/S1b
        CJ20Q3oFGWLW32BMPRf8B8CK6YNqRQAzKg5VpmBtg4nnYE14SzqpTU1l9UGltoEac3REFIQu4NCZQ
        NGMps=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8nI2-0007it-BV; Tue, 26 Mar 2019 14:42:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C4D701121B57; Tue, 26 Mar 2019 14:42:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: act8865: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190326144257.C4D701121B57@debutante.sirena.org.uk>
Date:   Tue, 26 Mar 2019 14:42:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8865: Constify regulator_ops

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

From 7cae255d2757eb085736be082df3ef4140846bc9 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 22 Mar 2019 14:38:20 +0800
Subject: [PATCH] regulator: act8865: Constify regulator_ops

The act8865_ops and act8865_ldo_ops never need to be modified,
make them const so compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8865-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index af8f201e67d7..19d9ee2dac1f 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -226,7 +226,7 @@ static const struct regulator_linear_range act8600_sudcdc_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(41400000, 248, 255, 0),
 };
 
-static struct regulator_ops act8865_ops = {
+static const struct regulator_ops act8865_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -236,7 +236,7 @@ static struct regulator_ops act8865_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops act8865_ldo_ops = {
+static const struct regulator_ops act8865_ldo_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
-- 
2.20.1

