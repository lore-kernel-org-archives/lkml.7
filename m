Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAB6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6722075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266530;
	bh=08dptFQqF3LGoNK5nNEHT3v520ByC9lsmJv+a5Tzgh0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=jS3Hi5e4laHxSi7sBmboDBqjhw5/Dl7B0uI75O1hIS/xiif9238hxHTNN1AyrtZq3
	 7yU0GLD5zLT34eVHtmyTj941c2szmFklfge7TV9fXL44LXRaP+jiNGLGgEqKnIcvl2
	 cJ9yyrr73RLpKyQdfpH7qupiqR5ZIH8PiUEwkar0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfDCEmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:42:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39898 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfDCEmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bfqlZ8F5uTvYt/tOF+WGTvmV3f1KLzwspro0py/DlGE=; b=fNeiVSH3PpDf
        jPrie7LHmwSNHqz7HrZBA5MkcFAyAPjMz9AEndYS0kZnJk6p2hTTMAxqJVGFGXaJXW6wW5zPQRIJQ
        3iRw4I8oigq1dlb7LNP4xw/n/i33MR0+luHj58qCCeqaDCBEqq6g2FtEUScRFtIsVKjhZ8mwL6Wvr
        g/2mQ=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXit-000400-9c; Wed, 03 Apr 2019 04:42:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 01486440083; Wed,  3 Apr 2019 05:41:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lm363x: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190403044200.01486440083@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:41:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lm363x: Constify regulator_ops

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

From 55c083d89634d3325f9d9e0d20459c308a575620 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 2 Apr 2019 20:13:48 +0800
Subject: [PATCH] regulator: lm363x: Constify regulator_ops

The lm363x_boost_voltage_table_ops and lm363x_regulator_voltage_table_ops
never need to be modified, make them const so compiler can put them to
.rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lm363x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index ebec91b55ceb..e02fdd1dd092 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -82,13 +82,13 @@ static int lm363x_regulator_enable_time(struct regulator_dev *rdev)
 		return ENABLE_TIME_USEC * val;
 }
 
-static struct regulator_ops lm363x_boost_voltage_table_ops = {
+static const struct regulator_ops lm363x_boost_voltage_table_ops = {
 	.list_voltage     = regulator_list_voltage_linear,
 	.set_voltage_sel  = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel  = regulator_get_voltage_sel_regmap,
 };
 
-static struct regulator_ops lm363x_regulator_voltage_table_ops = {
+static const struct regulator_ops lm363x_regulator_voltage_table_ops = {
 	.list_voltage     = regulator_list_voltage_linear,
 	.set_voltage_sel  = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel  = regulator_get_voltage_sel_regmap,
-- 
2.20.1

