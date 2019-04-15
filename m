Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C58C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E332070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EkeMwzI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfDOVbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:31:08 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8837 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbfDOVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:31:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4f8050000>; Mon, 15 Apr 2019 14:30:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 14:31:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 14:31:04 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 21:31:04 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 15 Apr 2019 21:31:04 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.253]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb4f8160001>; Mon, 15 Apr 2019 14:31:03 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V3 9/9] spi: tegra114: add support for TX and RX trimmers
Date:   Mon, 15 Apr 2019 14:30:34 -0700
Message-ID: <1555363834-32155-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555363845; bh=HUq/OoZKqv8JT76CXlyWEa7tKgoLCJPhEBscAxa4Dj4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=EkeMwzI++pFl0X2oeN9j8fn/KlUp8u2FD75AqInbyGFQtG6hwbuaawyYsGfYR3KX+
         rYBN2Bfs2X5A72b3KDzA8Flk3ZfZadTKCUFI/013treKuMumu4nXxxTxrznHm4JFa+
         y/QX7yUdwFGxnq7bEgRjxgWFqFGP0n1XxRwy97uSEZ8G1Wzkfz91ir428RVPSr8N3d
         x8sjKj7WJ1pz/6MF2ePJ23QYtHepyEWmYFvHEwY8p9LH0GVn9H255MebchukRYkllO
         3BRsJE6GvdgIpBpaFfMFR6mG7eAdOIlcxFDiFe3dhOjl1Vw6IzmAj1Uemo5PBXT/1R
         H19L0mB6DIAcQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra SPI master controller has programmable trimmers to adjust the
data with respect to the clock.

These trimmers are programmed in TX_CLK_TAP_DELAY and RX_CLK_TAP_DELAY
fields of COMMAND2 register.

SPI TX trimmer is to adjust the outgoing data with respect to the
outgoing clock and SPI RX trimmer is to adjust the loopback clock with
respect to the incoming data from the slave device.

These trimmers vary based on trace lengths of the platform design for
each of the slaves on the SPI bus and optimal value programmed is from
the platform validation across PVT.

This patch adds support for configuring TX and RX clock delay trimmers
through the device tree properties.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 68 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 8476a38cf4fb..20a413aef133 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -169,6 +169,11 @@ struct tegra_spi_soc_data {
 	bool has_intr_mask_reg;
 };
 
+struct tegra_spi_client_data {
+	int tx_clk_tap_delay;
+	int rx_clk_tap_delay;
+};
+
 struct tegra_spi_data {
 	struct device				*dev;
 	struct spi_master			*master;
@@ -208,8 +213,10 @@ struct tegra_spi_data {
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
+	u32					def_command2_reg;
 	u32					spi_cs_timing1;
 	u32					spi_cs_timing2;
+	u8					last_used_cs;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -769,10 +776,13 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
 	u32 command1;
+	u32 command2;
 	int req_mode;
+	u32 tx_tap = 0, rx_tap = 0;
 
 	if (speed != tspi->cur_speed) {
 		clk_set_rate(tspi->clk, speed);
@@ -839,7 +849,18 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 				command1 &= ~SPI_CS_SW_VAL;
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
@@ -895,9 +916,42 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 	return ret;
 }
 
+static struct tegra_spi_client_data
+	*tegra_spi_parse_cdata_dt(struct spi_device *spi)
+{
+	struct tegra_spi_client_data *cdata;
+	struct device_node *slave_np;
+
+	slave_np = spi->dev.of_node;
+	if (!slave_np) {
+		dev_dbg(&spi->dev, "device node not found\n");
+		return NULL;
+	}
+
+	cdata = kzalloc(sizeof(*cdata), GFP_KERNEL);
+	if (!cdata)
+		return NULL;
+
+	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
+			     &cdata->tx_clk_tap_delay);
+	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
+			     &cdata->rx_clk_tap_delay);
+	return cdata;
+}
+
+static void tegra_spi_cleanup(struct spi_device *spi)
+{
+	struct tegra_spi_client_data *cdata = spi->controller_data;
+
+	spi->controller_data = NULL;
+	if (spi->dev.of_node)
+		kfree(cdata);
+}
+
 static int tegra_spi_setup(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	u32 val;
 	unsigned long flags;
 	int ret;
@@ -908,6 +962,11 @@ static int tegra_spi_setup(struct spi_device *spi)
 		spi->mode & SPI_CPHA ? "" : "~",
 		spi->max_speed_hz);
 
+	if (!cdata) {
+		cdata = tegra_spi_parse_cdata_dt(spi);
+		spi->controller_data = cdata;
+	}
+
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
@@ -1034,6 +1093,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			reset_control_assert(tspi->rst);
 			udelay(2);
 			reset_control_deassert(tspi->rst);
+			tspi->last_used_cs = master->num_chipselect + 1;
 			goto complete_xfer;
 		}
 
@@ -1089,6 +1149,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
+		tspi->last_used_cs = master->num_chipselect + 1;
 		return IRQ_HANDLED;
 	}
 
@@ -1164,6 +1225,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
+		tspi->last_used_cs = master->num_chipselect + 1;
 		return IRQ_HANDLED;
 	}
 
@@ -1351,6 +1413,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
 	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
+	tspi->def_command2_reg = tegra_spi_readl(tspi, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(&pdev->dev);
 	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
 				   tegra_spi_isr_thread, IRQF_ONESHOT,
@@ -1423,6 +1487,8 @@ static int tegra_spi_resume(struct device *dev)
 		return ret;
 	}
 	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	tegra_spi_writel(tspi, tspi->def_command2_reg, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(dev);
 
 	return spi_master_resume(master);
-- 
2.7.4

