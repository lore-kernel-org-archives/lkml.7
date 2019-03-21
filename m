Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DEFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A2E218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553180855;
	bh=4I64GT/E/P9+GIBLyCSf6+qaOUxN2nDzQP4otzUBy0c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gwuGZon+81dIRSDJvSiWRD7iugZoVN4hjWqVxBf8Y1fx3D0OrG8t9pXhw27/tvYEB
	 C2Eq4uEZROXCkjq7P7vqO38S1w9n+z7zrFSDvgZof90PMXSOFdWnqqFdGTiKODbgAr
	 f2X0BDF7eQLAxgYFz5C9FQ6nbqzaSZrpBdryzapk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfCUPHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:07:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48184 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfCUPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5jLw+JbFqeiEDOAn4Vh8glY6dmp9kLQe8VKACAq9t2E=; b=TBFLQf0LDcD6
        UyJxODR/u6GYVzADKmi/2ZPIxGvUZQK1Xe97bslQW2Z0aEZ4gJhzROWAhSFvXxyCWDq2szt/e2WMI
        S9PSkUfe7DgJ3EXJ9YjWecv6A9YyZK+QZQaUia/UwJdOYT7hcTClnboMHF0p8siN8y4KCW1PQ1beW
        cb58I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6zI0-0005dY-BW; Thu, 21 Mar 2019 15:07:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AD76611288F0; Thu, 21 Mar 2019 15:07:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps65132: Constify tps65132_regulator_ops and tps_regs_desc" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190321150727.AD76611288F0@debutante.sirena.org.uk>
Date:   Thu, 21 Mar 2019 15:07:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65132: Constify tps65132_regulator_ops and tps_regs_desc

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

From 4e105e3b4bc6a1825aefc56f11951e1496a5bb3c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 21 Mar 2019 20:00:38 +0800
Subject: [PATCH] regulator: tps65132: Constify tps65132_regulator_ops and
 tps_regs_desc

The tps65132_regulator_ops and tps_regs_desc never need to be modified,
make them const so compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65132-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index 1f627e161b99..6e22f5ebba2e 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -117,7 +117,7 @@ static int tps65132_regulator_is_enabled(struct regulator_dev *rdev)
 	return 1;
 }
 
-static struct regulator_ops tps65132_regulator_ops = {
+static const struct regulator_ops tps65132_regulator_ops = {
 	.enable = tps65132_regulator_enable,
 	.disable = tps65132_regulator_disable,
 	.is_enabled = tps65132_regulator_is_enabled,
@@ -193,7 +193,7 @@ static int tps65132_of_parse_cb(struct device_node *np,
 		.owner = THIS_MODULE,			\
 	}
 
-static struct regulator_desc tps_regs_desc[TPS65132_MAX_REGULATORS] = {
+static const struct regulator_desc tps_regs_desc[TPS65132_MAX_REGULATORS] = {
 	TPS65132_REGULATOR_DESC(VPOS, outp),
 	TPS65132_REGULATOR_DESC(VNEG, outn),
 };
-- 
2.20.1

