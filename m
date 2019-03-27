Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6519C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB28208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="n+pYY9aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbfC0F5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:57:44 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17631 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbfC0F5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10d70000>; Tue, 26 Mar 2019 22:57:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:40 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:39 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:39 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10d10003>; Tue, 26 Mar 2019 22:57:39 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 22/26] spi: tegra114: add support for tuning clock delay
Date:   Tue, 26 Mar 2019 22:56:43 -0700
Message-ID: <1553666207-11414-22-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666263; bh=NkBXpKQJ407zfskKrIvF7fFzgILoKGcrrlOTed2L25U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=n+pYY9aa1xnP3miROvQHcG+A3IDpBfYygKziesyBFj5+MBdsGgI8v3y4USO9UM15f
         CqX4UU+hbR2Ozl57GVYChOydBnuZF4Bcl8GZ2a6eDSU2VLS43J/FSjZe5g1eMbJcC5
         vBv6RNHxvi2qrbiNizKPh7DblZxm5clO5pKRCnBJGqGIZsKi3sKaKVkuz4nTyd+2Xd
         jJ2CeEBByKjSnErYFhFhOR4B6rG4nO3OaxGW4bFiKF2h41fBPTyYfS4kpzJw80ssSx
         1JjbWYGewY9PsLrR4/px03HouMednHT7TNbjEuzUSzl5u8JAczy505Qf5prU5eWnzy
         YP6nhyWxk6u7g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra SPI controller has TX_CLK_TAP_DELAY and RX_CLK_TAP_DELAY in
COMMAND2 register to tune delay of the clock going out to external
device during transmit and also for the clock coming in from external
device during receive.

TX/RX clock tap delays may vary based on the trace lengths of the
platform design for each of the slaves on the SPI bus.

This patch adds support for configuring TX/RX clock delays specified
through device tree properties.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index e01962344bde..725d60364ec6 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -174,6 +174,8 @@ struct tegra_spi_client_data {
 	int cs_setup_clk_count;
 	int cs_hold_clk_count;
 	int cs_inactive_cycles;
+	int tx_clk_tap_delay;
+	int rx_clk_tap_delay;
 };
 
 struct tegra_spi_data {
@@ -215,8 +217,10 @@ struct tegra_spi_data {
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
+	u32					def_command2_reg;
 	u32					spi_cs_timing1;
 	u32					spi_cs_timing2;
+	u8					last_used_cs;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -780,7 +784,9 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
 	u32 command1;
+	u32 command2;
 	int req_mode;
+	u32 tx_tap = 0, rx_tap = 0;
 
 	if (speed != tspi->cur_speed) {
 		clk_set_rate(tspi->clk, speed);
@@ -843,7 +849,18 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
 		}
 
-		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
+		if (tspi->last_used_cs != spi->chip_select) {
+			if (cdata && cdata->tx_clk_tap_delay)
+				tx_tap = cdata->tx_clk_tap_delay;
+			if (cdata && cdata->rx_clk_tap_delay)
+				rx_tap = cdata->rx_clk_tap_delay;
+			command2 = SPI_TX_TAP_DELAY(tx_tap) |
+				   SPI_RX_TAP_DELAY(rx_tap);
+			if (command2 != tspi->def_command2_reg)
+				tegra_spi_writel(tspi, command2, SPI_COMMAND2);
+			tspi->last_used_cs = spi->chip_select;
+		}
+
 	} else {
 		command1 = tspi->command1_reg;
 		command1 &= ~SPI_BIT_LENGTH(~0);
@@ -923,6 +940,10 @@ static struct tegra_spi_client_data
 			     &cdata->cs_hold_clk_count);
 	of_property_read_u32(slave_np, "nvidia,cs-inactive-cycles",
 			     &cdata->cs_inactive_cycles);
+	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
+			     &cdata->tx_clk_tap_delay);
+	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
+			     &cdata->rx_clk_tap_delay);
 	return cdata;
 }
 
@@ -1379,6 +1400,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
 	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
+	tspi->def_command2_reg = tegra_spi_readl(tspi, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(&pdev->dev);
 	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
 				   tegra_spi_isr_thread, IRQF_ONESHOT,
@@ -1451,6 +1474,8 @@ static int tegra_spi_resume(struct device *dev)
 		return ret;
 	}
 	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	tegra_spi_writel(tspi, tspi->def_command2_reg, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(dev);
 
 	return spi_master_resume(master);
-- 
2.7.4

