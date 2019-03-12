Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B964A2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCLSni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:43:38 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:35654 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCLSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:43:37 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id n6ja1z00D3XaVaC016jaGz; Tue, 12 Mar 2019 19:43:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h3mNC-0004TT-4c; Tue, 12 Mar 2019 19:43:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h3mNC-0003aa-2Z; Tue, 12 Mar 2019 19:43:34 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: rspi: Fix register initialization while runtime-suspended
Date:   Tue, 12 Mar 2019 19:43:31 +0100
Message-Id: <20190312184331.13755-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RSPI/QSPI driver performs SPI controller register
initialization in its spi_operations.setup() callback, without calling
pm_runtime_get_sync() first, which may cause spurious failures.

So far this went unnoticed, as this SPI controller is typically used
with a single SPI NOR FLASH containing the boot loader:
  1. If the device's module clock is still enabled (left enabled by the
     bootloader, and not yet disabled by the clk_disable_unused() late
     initcall), register initialization succeeds,
  2. If the device's module clock is disabled, register writes don't
     seem to cause lock-ups or crashes.
     Data received in the first SPI message may be corrupted, though.
     Subsequent SPI messages seem to be OK.
     E.g. on r8a7791/koelsch, one bit is lost while receiving the 6th
     byte of the JEDEC ID for the s25fl512s FLASH, corrupting that byte
     and all later bytes.  But until commit a2126b0a010905e5 ("mtd:
     spi-nor: refine Spansion S25FL512S ID"), the 6th byte was not
     considered for FLASH identification.

Fix this by moving all initialization from the .setup() to the
.prepare_message() callback.  The latter is always called after the
device has been runtime-resumed by the SPI core.

This also makes the driver follow the rule that .setup() must not change
global driver state or register values, as that might break a transfer
in progress.

Fixes: 490c97747d5dc77d ("spi: rspi: Add runtime PM support, using spi core auto_runtime_pm")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a fix for v5.1-rc1, as a2126b0a010905e5 will be in v5.1-rc1.
---
 drivers/spi/spi-rspi.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 556870dcdf7995f8..b30fed824e6643a2 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -868,28 +868,6 @@ static int qspi_transfer_one(struct spi_controller *ctlr,
 	}
 }
 
-static int rspi_setup(struct spi_device *spi)
-{
-	struct rspi_data *rspi = spi_controller_get_devdata(spi->controller);
-
-	rspi->max_speed_hz = spi->max_speed_hz;
-
-	rspi->spcmd = SPCMD_SSLKP;
-	if (spi->mode & SPI_CPOL)
-		rspi->spcmd |= SPCMD_CPOL;
-	if (spi->mode & SPI_CPHA)
-		rspi->spcmd |= SPCMD_CPHA;
-
-	/* CMOS output mode and MOSI signal from previous transfer */
-	rspi->sppcr = 0;
-	if (spi->mode & SPI_LOOP)
-		rspi->sppcr |= SPPCR_SPLP;
-
-	set_config_register(rspi, 8);
-
-	return 0;
-}
-
 static u16 qspi_transfer_mode(const struct spi_transfer *xfer)
 {
 	if (xfer->tx_buf)
@@ -959,8 +937,24 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 				struct spi_message *msg)
 {
 	struct rspi_data *rspi = spi_controller_get_devdata(ctlr);
+	struct spi_device *spi = msg->spi;
 	int ret;
 
+	rspi->max_speed_hz = spi->max_speed_hz;
+
+	rspi->spcmd = SPCMD_SSLKP;
+	if (spi->mode & SPI_CPOL)
+		rspi->spcmd |= SPCMD_CPOL;
+	if (spi->mode & SPI_CPHA)
+		rspi->spcmd |= SPCMD_CPHA;
+
+	/* CMOS output mode and MOSI signal from previous transfer */
+	rspi->sppcr = 0;
+	if (spi->mode & SPI_LOOP)
+		rspi->sppcr |= SPPCR_SPLP;
+
+	set_config_register(rspi, 8);
+
 	if (msg->spi->mode &
 	    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)) {
 		/* Setup sequencer for messages with multiple transfer modes */
@@ -1267,7 +1261,6 @@ static int rspi_probe(struct platform_device *pdev)
 	init_waitqueue_head(&rspi->wait);
 
 	ctlr->bus_num = pdev->id;
-	ctlr->setup = rspi_setup;
 	ctlr->auto_runtime_pm = true;
 	ctlr->transfer_one = ops->transfer_one;
 	ctlr->prepare_message = rspi_prepare_message;
-- 
2.17.1

