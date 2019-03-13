Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DFFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E623D206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491566;
	bh=g/bydhW9A4mXmphbK0APWe84+T9K4ffWDqGvLU2rDds=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=OoMxyox6bfu12UoaUZCyxGmRa5XlVsoXryFQqYyrg8p6vD7hyK+zofdduYVVGh1Wk
	 XX4EKZJ62SdWAqJIBJ5hytHY28L/sltzbQhP2K7fNOYlcrx5sg2TDoemRsnusvC8Pb
	 wMUSXJ8Y2q7F8s3XCj/3zjdJkwIDsSS/QT4gx+rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCMPjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50246 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfCMPjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tGuE7jnTC5eNBI5aYEdOVkMx/xPaEDEesDAc7Iz6eK8=; b=hljFV7wTgo1T
        k98YgSXKNkoAkEnNja3ANvCzVc4Q0QJBIvuX0wz/9wsHG85Sm4jRXbAGip8pT7UmWPbHyewwZOhq9
        fefL6HMtpWT7oIJECn7s2R4eue8iB2bWbSak+EbNhCCtA3swPZ+2Tjaxt+nKrDs/gdOQzkUCpOG5e
        3a6yY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45yP-0003Sv-OO; Wed, 13 Mar 2019 15:39:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3B5B41128B97; Wed, 13 Mar 2019 15:39:17 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da903x: don't build with clang" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190313153917.3B5B41128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:39:17 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da903x: don't build with clang

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

From 0077aaaeeb69b5dcfe15a398e38d71bf28c9505d Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 7 Mar 2019 11:26:02 +0100
Subject: [PATCH] regulator: da903x: don't build with clang

The da903x driver produces an annoying false-positive warning
when built with clang:

drivers/regulator/da903x.c:395:2: error: division by zero is undefined [-Werror,-Wdivision-by-zero]
        DA9030_LDO(13, 2100, 2100, 0, INVAL, 0, 0, RCTL11, 3), /* fixed @2.1V */
        ^                          ~
drivers/regulator/da903x.c:359:2: note: expanded from macro 'DA9030_LDO'
        DA903x_LDO(DA9030, _id, min, max, step, vreg, shift, nbits, ereg, ebit)
        ^                                 ~~~~
drivers/regulator/da903x.c:320:39: note: expanded from macro 'DA903x_LDO'
                .n_voltages = (step) ? ((max - min) / step + 1) : 1,    \
                                                    ^ ~~~~
drivers/regulator/da903x.c:415:2: error: division by zero is undefined [-Werror,-Wdivision-by-zero]
        DA9034_LDO(5, 3100, 3100, 0, INVAL, 0, 0, OVER3, 7), /* fixed @3.1V */
        ^                         ~
drivers/regulator/da903x.c:356:2: note: expanded from macro 'DA9034_LDO'
        DA903x_LDO(DA9034, _id, min, max, step, vreg, shift, nbits, ereg, ebit)
        ^                                 ~~~~
drivers/regulator/da903x.c:320:39: note: expanded from macro 'DA903x_LDO'
                .n_voltages = (step) ? ((max - min) / step + 1) : 1,    \
                                                    ^ ~~~~

I already reported this as a bug in clang, but it may take a
while to fix it. As I have not been able to come up with any
reasonable workaround, I would just disable compilation here.

Link: https://bugs.llvm.org/show_bug.cgi?id=38789
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b7f249ee5e68..6d2651cd9887 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -223,6 +223,7 @@ config REGULATOR_CPCAP
 config REGULATOR_DA903X
 	tristate "Dialog Semiconductor DA9030/DA9034 regulators"
 	depends on PMIC_DA903X
+	depends on !CC_IS_CLANG # https://bugs.llvm.org/show_bug.cgi?id=38789
 	help
 	  Say y here to support the BUCKs and LDOs regulators found on
 	  Dialog Semiconductor DA9030/DA9034 PMIC.
-- 
2.20.1

