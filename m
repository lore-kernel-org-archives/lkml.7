Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7D2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C292184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gaireg.de header.i=@gaireg.de header.b="QziBWQ1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfC2RpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:45:18 -0400
Received: from gaireg.de ([37.221.197.43]:35448 "EHLO gaireg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbfC2RpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:45:18 -0400
Received: from me.gaireg.de (unknown [194.8.217.178])
        by gaireg.de (Postfix) with ESMTPSA id 6DA4640FFFEC;
        Fri, 29 Mar 2019 18:45:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gaireg.de; s=mail;
        t=1553881514; bh=Y4JWry3TOjnN0yph0XRF9lnx+z1O0f9NlF5QZqp1mPU=;
        h=From:To:Cc:Subject:Date;
        b=QziBWQ1RUdfFF6os2tTGtyuw28whGcQ+Sxu3qh9aY6n/IR5kJr7vh4NQJHVzPmEA1
         fded7ear72jkDnBtunz8JYCBBdq2+Uta7WPZ6KZikqFKId0eunDUgUusFyrpQTm25F
         B/W4KU4KIGMITcpcEx0GKT8EelImFhq9745LCzWA=
From:   =?UTF-8?q?Randolph=20Maa=C3=9Fen?= <gaireg@gaireg.de>
To:     gaireg@gaireg.de
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: tegra20-slink: change chip select action order
Date:   Fri, 29 Mar 2019 18:44:11 +0100
Message-Id: <20190329174411.13832-1-gaireg@gaireg.de>
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
Reviewed-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
v2: fixed typo in comment: bevore -> before
---
 drivers/spi/spi-tegra20-slink.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 1427f343b39a..2d173fadeb19 100644
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
+	 * Writing to the command2 register before the command register prevents
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

