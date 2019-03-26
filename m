Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8296C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED532075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gaireg.de header.i=@gaireg.de header.b="oDOtEMzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfCZOhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:37:12 -0400
Received: from gaireg.de ([37.221.197.43]:48286 "EHLO gaireg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731491AbfCZOhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:37:11 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Mar 2019 10:37:10 EDT
Received: from me.gaireg.de (unknown [194.8.217.178])
        by gaireg.de (Postfix) with ESMTPSA id 540AB40D1678;
        Tue, 26 Mar 2019 15:30:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gaireg.de; s=mail;
        t=1553610655; bh=bsU4c0juD7r0sMKJ0d8ZqZ4BLC0F1ZcheYyRYMs+rp0=;
        h=From:To:Cc:Subject:Date;
        b=oDOtEMzIL98EIEvNBl5Pr5C8BrP2Ygf+6MPPOIlDcg+qv/nna0XZpqfMdmiRBzl+H
         x4G9p8m2rmltN/S/uxTD3qqKZBnru4X6vmCCqPciHN/BXysFklrPh1sDwt8uKUSWXJ
         TRfTz7eS4iiAcYj3/qx2ImkwY4MBzjm0JuQcCYhE=
From:   =?UTF-8?q?Randolph=20Maa=C3=9Fen?= <gaireg@gaireg.de>
To:     gaireg@gaireg.de
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: tegra20-slink: change chip select action order
Date:   Tue, 26 Mar 2019 15:30:50 +0100
Message-Id: <20190326143050.26232-1-gaireg@gaireg.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To transfer via SPI the tegra20-slink driver first sets the command
register, which contains the chip select value, and after that the
command2 register, which contains the chip select line. This leads to a
small spike in the chip selct 0 line between the set of the value and
the selection of the chip select line.

This commit changes the order of the register writes so that first the
chip select line is chosen and then the value is set, removing the
spike.

Signed-off-by: Randolph Maaßen <gaireg@gaireg.de>
---
 drivers/spi/spi-tegra20-slink.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 1427f343b39a..6d4679126213 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -717,9 +717,6 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 	command2 = tspi->command2_reg;
 	command2 &= ~(SLINK_RXEN | SLINK_TXEN);
 
-	tegra_slink_writel(tspi, command, SLINK_COMMAND);
-	tspi->command_reg = command;
-
 	tspi->cur_direction = 0;
 	if (t->rx_buf) {
 		command2 |= SLINK_RXEN;
@@ -729,9 +726,18 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 		command2 |= SLINK_TXEN;
 		tspi->cur_direction |= DATA_DIR_TX;
 	}
+
+	/*
+	 * Writing to the command2 register bevore the command register prevents
+	 * a spike in chip_select line 0. This selects the chip_select line
+	 * before changing the chip_select value.
+	 */
 	tegra_slink_writel(tspi, command2, SLINK_COMMAND2);
 	tspi->command2_reg = command2;
 
+	tegra_slink_writel(tspi, command, SLINK_COMMAND);
+	tspi->command_reg = command;
+
 	if (total_fifo_words > SLINK_FIFO_DEPTH)
 		ret = tegra_slink_start_dma_based_transfer(tspi, t);
 	else
-- 
2.11.0

