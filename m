Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E75C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C602070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="S1LaMBiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfDOVbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:31:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16554 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbfDOVbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:31:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4f8190000>; Mon, 15 Apr 2019 14:31:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 14:30:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 14:30:59 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 21:30:59 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 15 Apr 2019 21:30:59 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.253]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb4f8110000>; Mon, 15 Apr 2019 14:30:59 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V3 7/9] spi: tegra114: add support for hw based cs
Date:   Mon, 15 Apr 2019 14:30:32 -0700
Message-ID: <1555363834-32155-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555363865; bh=0NON5s93j3SFEupQQ7mO3GxrBWpVV7w+tKss+w5I8iU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=S1LaMBiRZqMQMEctjGKFTSeLeEHGQxBB6nwgRKk3NwMkbVUkib4UiaSuKL8DkztQX
         5I44rYFdMlGDoVL8wIvlvL3iUoWyrkVnGS06vBdfkchcqErHcCfYgyDVH3aTNaCUA1
         anRyeQH6jiizShPDBlgqNDmC93AtZwddcDyFTlVogVxT7iyZUtohc5thf1xxm+u0pj
         Lv4uBbPPZ+ndqyZvqubv5n+BH/bD/feYPJojhCLlaDGxxJVBJUE7GxePJT4fELIhlq
         WWzePegG1Z1D/KUgQKUJDJMrSZdkGf52KAbY6aCUGbzjDz/T44DFhrt1oco88j3+3B
         SsQ7dpIr9x9yg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra SPI controller supports both HW and SW based CS control
for SPI transfers.

This patch adds support for HW based CS control where CS is driven
to active state during the transfer and is driven inactive at the
end of the transfer directly by the HW.

This patch enables the use of HW based CS only for single transfers
without cs_change request.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 0b04eba242c0..732347d83366 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -193,6 +193,7 @@ struct tegra_spi_data {
 	unsigned				dma_buf_size;
 	unsigned				max_buf_size;
 	bool					is_curr_dma_xfer;
+	bool					use_hw_based_cs;
 
 	struct completion			rx_dma_complete;
 	struct completion			tx_dma_complete;
@@ -723,7 +724,8 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 }
 
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
-		struct spi_transfer *t, bool is_first_of_msg)
+		struct spi_transfer *t, bool is_first_of_msg,
+		bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	u32 speed = t->speed_hz;
@@ -784,11 +786,17 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		/* GPIO based chip select control */
 		spi_set_cs(spi, true);
 
-		command1 |= SPI_CS_SW_HW;
-		if (spi->mode & SPI_CS_HIGH)
-			command1 |= SPI_CS_SW_VAL;
-		else
-			command1 &= ~SPI_CS_SW_VAL;
+		if (is_single_xfer && !(t->cs_change)) {
+			tspi->use_hw_based_cs = true;
+			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
+		} else {
+			tspi->use_hw_based_cs = false;
+			command1 |= SPI_CS_SW_HW;
+			if (spi->mode & SPI_CS_HIGH)
+				command1 |= SPI_CS_SW_VAL;
+			else
+				command1 &= ~SPI_CS_SW_VAL;
+		}
 
 		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
 	} else {
@@ -905,11 +913,15 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 
 	/* GPIO based chip select control */
 	spi_set_cs(spi, false);
-	if (cs_val)
-		tspi->command1_reg |= SPI_CS_SW_VAL;
-	else
-		tspi->command1_reg &= ~SPI_CS_SW_VAL;
-	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+
+	if (!tspi->use_hw_based_cs) {
+		if (cs_val)
+			tspi->command1_reg |= SPI_CS_SW_VAL;
+		else
+			tspi->command1_reg &= ~SPI_CS_SW_VAL;
+		tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	}
+
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 }
 
@@ -936,16 +948,19 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	int ret;
 	bool skip = false;
+	int single_xfer;
 
 	msg->status = 0;
 	msg->actual_length = 0;
 
+	single_xfer = list_is_singular(&msg->transfers);
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		u32 cmd1;
 
 		reinit_completion(&tspi->xfer_completion);
 
-		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg);
+		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
+						    single_xfer);
 
 		if (!xfer->len) {
 			ret = 0;
-- 
2.7.4

