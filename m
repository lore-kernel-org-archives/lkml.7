Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7771EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466D1218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553180865;
	bh=Dq/r+ug7Inrp2R48buei3bsLh1b9+vW12RZk23N4nF4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vp7IB/u80KO4kxjqiXNUrQ0+zyhtJEXvCXE4tCBP/CE5aIZEOJp+L2cGT4QdnOD6B
	 u6P1uhpmtl3/3SHxSi/5b10I6FBktYqyZFaWXoMjG21THGN+eDlKb4+VZnIJGBvISj
	 wvxznAQxXG0mHgxBKR6pSQtB/CZw871qEdD2adOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfCUPHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:07:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48284 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfCUPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=waRRG2+DMMsz8543tvkDE5+53BWYMHmTxo0nz3ncA2k=; b=jDIVdbrA5QUZ
        wrRTchtKo4NgpLCACrQQ+4+A2X9nn3NM5S8SxUrUiIIbCotIlJ0xtwTOEznl4E02w9V/8pExHtfFa
        6VAay+HCebF+RGqHzF4mhm073A8CacWKqwVQx17tHzIEbBWorogpeF5iCEZNZlIJFPaAm4Xhks0U9
        mpJdQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6zI3-0005dX-It; Thu, 21 Mar 2019 15:07:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F40F311288EC; Thu, 21 Mar 2019 15:07:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps65217: Simplify linear range for selector 25-52" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190321150725.F40F311288EC@debutante.sirena.org.uk>
Date:   Thu, 21 Mar 2019 15:07:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65217: Simplify linear range for selector 25-52

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

From 689b9e025f0cbf2f537566f8334ab6fd937336ae Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 4 Mar 2019 12:41:33 +0800
Subject: [PATCH] regulator: tps65217: Simplify linear range for selector 25-52

The original code separates the selector 25-52 into 2 ranges on purpose
because DCDC1/DCDC3 only support up to 1.8V/1.5V in the old code.
Both DCDC1 and DCDC3 support up to 3.3V since commit b4c2e158a1e1
("regulator: tps65217: Allow DCDC1 and DCDC3 up to 3.3V"), so merge
25-30 and 31-52 ranges to one range.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65217-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index d84fab616abf..ada62f792258 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -58,8 +58,7 @@ static const unsigned int LDO1_VSEL_table[] = {
 
 static const struct regulator_linear_range tps65217_uv1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 24, 25000),
-	REGULATOR_LINEAR_RANGE(1550000, 25, 30, 50000),
-	REGULATOR_LINEAR_RANGE(1850000, 31, 52, 50000),
+	REGULATOR_LINEAR_RANGE(1550000, 25, 52, 50000),
 	REGULATOR_LINEAR_RANGE(3000000, 53, 55, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 56, 62, 0),
 };
-- 
2.20.1

