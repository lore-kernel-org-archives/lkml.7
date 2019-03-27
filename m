Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2707AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36912087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T8d7grJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbfC0F52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:57:28 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17608 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733086AbfC0F5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10c70000>; Tue, 26 Mar 2019 22:57:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 22:57:24 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:23 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:23 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:23 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10c10003>; Tue, 26 Mar 2019 22:57:22 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 13/26] spi: tegra114: add dual mode support
Date:   Tue, 26 Mar 2019 22:56:34 -0700
Message-ID: <1553666207-11414-13-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666247; bh=gLDxLguUtkZngVQg1d51ZG6XgZGuaEBgMnBe1HRDfsE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=T8d7grJL07T8ufERmYx7JmEtEBumKI5+SkakLzRr8UZo3xxwM2tUkNaTZ8F/8fR6i
         bCkSNSpB2ELs4teYtQjObVdHaLhE69JJbdsrxnnlvhaJ5C4Faaz//tolkSObP9ul51
         XmAHVEUYcwS1B/B+Kw9MJbKBdFNsFa6QOZWh3ghyiSKc4IATxRCPJxkh0Fhizy697G
         tF0l1QO41IVFAPxkEzMB9HiqphKdRMv2i8OCyMNOmiQ3zjNVYO1aNSf3PZz+JekPsE
         tUHVZ18/0Bws+YsYwk79jkAzD5XNJ20moHyjypjwmKLO7XncECakl0TCXJlxA8Ympb
         sjhlKawN5HZKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for dual mode SPI transfer.

Dual mode uses both MOSI and MISO lines in parallel where the data
is interleaved on MOSI and MISO lines increasing the throughput.

Packet from Tx FIFO is transmitted on both MOSI and MISO lines and
packet to Rx FIFO is received from both MOSI and MISO lines. Even
bits are transmitted or received on the MOSI data line and odd bits
are transmitted or received on the MISO data line.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index d39f7b05b824..335c594d5b74 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -787,6 +787,11 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 
 	total_fifo_words = tegra_spi_calculate_curr_xfer_param(spi, tspi, t);
 
+	if (t->rx_nbits == SPI_NBITS_DUAL || t->tx_nbits == SPI_NBITS_DUAL)
+		command1 |= SPI_BOTH_EN_BIT;
+	else
+		command1 &= ~SPI_BOTH_EN_BIT;
+
 	if (tspi->is_packed)
 		command1 |= SPI_PACKED;
 	else
@@ -1142,7 +1147,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			    SPI_TX_DUAL | SPI_RX_DUAL;
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->num_chipselect = MAX_CHIP_SELECT;
-- 
2.7.4

