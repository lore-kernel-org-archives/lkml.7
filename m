Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EDAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFC92146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553516554;
	bh=GD/oSZScTP0QIUZsAdj8ZWjdACgzfdF8tH09RuelXPI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SquFZ4LgMICqeSkZ6WsI70O+JGKyd/w23K9APIrVdP/fusggA24d9d8C8ytotTC4o
	 3YSq3Huc91G4UYCnLpInn/3BRywTEjfonEMuYyu8a43bUuMfc1ZjEWE0v+yz6p71Xa
	 FKDDTT4k8bMbT3u/ELwB0jmvI/XoMq7NUw0tNeFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfCYMWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:22:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36550 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbfCYMWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GUpZ5JfxMEEgCMnkjgv+ubGx6YXQAhDQmG12/cckAl8=; b=YvFdcSSCtbd8
        zLDHFojO6LAavX9Vhrx+lXV+bk7G0EB1sEU0Hp59ACeiryOU7aOuMQU8s9u7UIAra1TrpaTiUPXUx
        Oc3akvqiCC5hO1eOp2580fqRPXljLJwTE96kDHIU5N2d2IS/Zae3+TqSjqMKhZE/UCZTMM4UeDHjR
        I/y84=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8OcR-00024f-LX; Mon, 25 Mar 2019 12:22:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1019F11288F3; Mon, 25 Mar 2019 12:22:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: uniphier: Fix build dependency" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190325122223.1019F11288F3@debutante.sirena.org.uk>
Date:   Mon, 25 Mar 2019 12:22:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: uniphier: Fix build dependency

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

From a71bcdfe6476b66cf6c632b1a4d0bdcb046e3d82 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 25 Mar 2019 18:59:19 +0800
Subject: [PATCH] regulator: uniphier: Fix build dependency

This driver does not use any syscon APIs, so remove MFD_SYSCON dependency.
Select REGMAP_MMIO since this driver uses devm_regmap_init_mmio().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6d2651cd9887..c4dc2bcafb56 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1011,7 +1011,8 @@ config REGULATOR_TWL4030
 config REGULATOR_UNIPHIER
 	tristate "UniPhier regulator driver"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && MFD_SYSCON
+	depends on OF
+	select REGMAP_MMIO
 	default ARCH_UNIPHIER
 	help
 	  Support for regulators implemented on Socionext UniPhier SoCs.
-- 
2.20.1

