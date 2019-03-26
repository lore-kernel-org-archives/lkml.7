Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66601C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329412075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553611394;
	bh=MK63LAaMOEmafKNTp66YrZskr8PGaH5lwoDurIg9zKg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fhopssoCy3lJ3iN4jXCSWF3xajLrCTkWFpe9G+putFamWr/fhCNtluoO3Ce5iM9Dy
	 lchViX8/wvh+9nhFAl/b+McHV0AM0UMTyCIYisTknhM4S8OvM2rI8ruD3YV8QbgZKL
	 le4ycl76AmsPgKZICwupKfB0ySsJIi7V9uP4JZ0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfCZOnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:43:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36002 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbfCZOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ld7r/9j3uBVnLYfY9l0AmmGU8L0G1ZbodlEOxhMxJWA=; b=LweyP4vkFGwa
        UwRu5CiT1TcdQJDfC5JnmMOoY62flvVylRvxZJk2lTKYR5L1/GrHzWGLVfFIByt/Z/nIuf5BzT/TL
        3Y4ne6lBK/vkmWEQcJdZi72TnETe5LIZYmUz3La0RV5WX6ilX0XsCUVx8kjAPX4R0oDIiBX/3PdfR
        HddcA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8nI7-0007jG-KE; Tue, 26 Mar 2019 14:43:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C92E51121B57; Tue, 26 Mar 2019 14:43:02 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: sc2731: Constify regulators" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190326144302.C92E51121B57@debutante.sirena.org.uk>
Date:   Tue, 26 Mar 2019 14:43:02 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: sc2731: Constify regulators

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

From 883ce2421ed7fc1aaf94ff58d099e9a843345dfa Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 26 Mar 2019 07:57:39 +0800
Subject: [PATCH] regulator: sc2731: Constify regulators

The regulators array should never need to be modified, make it const so
compiler can put it to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/sc2731-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/sc2731-regulator.c b/drivers/regulator/sc2731-regulator.c
index eb2bdf060b7b..0f21f95c8981 100644
--- a/drivers/regulator/sc2731-regulator.c
+++ b/drivers/regulator/sc2731-regulator.c
@@ -146,7 +146,7 @@ static const struct regulator_ops sc2731_regu_linear_ops = {
 	.vsel_mask		= vmask,			\
 }
 
-static struct regulator_desc regulators[] = {
+static const struct regulator_desc regulators[] = {
 	SC2731_REGU_LINEAR(BUCK_CPU0, SC2731_POWER_PD_SW,
 			   SC2731_DCDC_CPU0_PD_MASK, SC2731_DCDC_CPU0_VOL,
 			   SC2731_DCDC_CPU0_VOL_MASK, 3125, 400000, 1996875),
-- 
2.20.1

