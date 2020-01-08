Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A558FC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD5820880
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578499156;
	bh=e2h9n2OFQT5vk8U1eEWm9YSzLyfAP3ks7FVRDWAIFqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=fDRJfpdv+/HtzXqn7sDPmBhmt8mauQUeeCI1beCgFtKysUPRddt5eyOdrlp42piUj
	 FFL9fPuavHuK0qwCJxeBmyCMAlHWv1ga8iD3Et+81AP+pJgYw54cQJxXPBtkC5E0Hy
	 7giBgCpVQhhqF9K8+js6BoBjEaV1Yx3iM9dfAP2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgAHP7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:59:15 -0500
Received: from foss.arm.com ([217.140.110.172]:46712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbgAHP7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6A8FDA7;
        Wed,  8 Jan 2020 07:59:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 527823F534;
        Wed,  8 Jan 2020 07:59:12 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:59:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: Applied "spi: rspi: Add support for multiple native chip selects" to the spi tree
In-Reply-To: <20200102133822.29346-6-geert+renesas@glider.be>
Message-Id: <applied-20200102133822.29346-6-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rspi: Add support for multiple native chip selects

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From 9815ed8714d26560d09b41f906b96a97f9bc3e3f Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 2 Jan 2020 14:38:21 +0100
Subject: [PATCH] spi: rspi: Add support for multiple native chip selects

RSPI variants on some SuperH or R-Mobile SoCs support multiple native
chip selects. Add support for this by configuring the SSL Assert Signal
Setting.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200102133822.29346-6-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 9eabef3d6cc4..2f5a856a9319 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -159,7 +159,7 @@
 #define SPCMD_SPIMOD_DUAL	SPCMD_SPIMOD0
 #define SPCMD_SPIMOD_QUAD	SPCMD_SPIMOD1
 #define SPCMD_SPRW		0x0010	/* SPI Read/Write Access (Dual/Quad) */
-#define SPCMD_SSLA_MASK		0x0030	/* SSL Assert Signal Setting (RSPI) */
+#define SPCMD_SSLA(i)		((i) << 4)	/* SSL Assert Signal Setting */
 #define SPCMD_BRDV_MASK		0x000c	/* Bit Rate Division Setting */
 #define SPCMD_CPOL		0x0002	/* Clock Polarity Setting */
 #define SPCMD_CPHA		0x0001	/* Clock Phase Setting */
@@ -933,6 +933,9 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 	if (spi->mode & SPI_CPHA)
 		rspi->spcmd |= SPCMD_CPHA;
 
+	/* Configure slave signal to assert */
+	rspi->spcmd |= SPCMD_SSLA(spi->chip_select);
+
 	/* CMOS output mode and MOSI signal from previous transfer */
 	rspi->sppcr = 0;
 	if (spi->mode & SPI_LOOP)
-- 
2.20.1

