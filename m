Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C166FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8244F217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jUF8tTZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfDEAOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:14:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7985 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbfDEAOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69de30001>; Thu, 04 Apr 2019 17:14:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 17:14:38 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:38 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:38 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:38 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69ded0002>; Thu, 04 Apr 2019 17:14:37 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 20/20] spi: tegra114: add support for tuning TX and RX trimmers
Date:   Thu, 4 Apr 2019 17:14:19 -0700
Message-ID: <1554423259-26056-20-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423267; bh=TwouggVeMPsgAhGqqdJ7Vu2KWWDLYedIJzL83FfHC5s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jUF8tTZcGsK/bMxQRPibbgsYItdfw713OShHYWvI/sWfiFjaKUhKDoYxdQKyBFKh6
         PJgcEhtP3mZdwYdS0x9dJGnulmgxIaa7xe/t42Wv51t49JzZURFGWNKDC11r7fkpDe
         PlHV9srJsBFrpN784JALPtdZnohb+LOk5tGM5V2OOQf6xbNpXarpLFRWM/HEHqfENa
         4tfA6khJYZ6swuZXNNVVb6hPtZR9TnHXSQatgTaWi3/jq7XkProLMwD8D2YI14zMVE
         swtBeo/VzGpJbAOyrwM6w/xx76IcEVEyg7vKiXx3VBUFz7d609VbW+xGGLNgWPGz1a
         0k/1VA3mY/WoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra SPI controller has TX_CLK_TAP_DELAY and RX_CLK_TAP_DELAY in
COMMAND2 register to tune the delay of the clock going out to external
device during transmit and also for the clock coming in from external
device during receive.

TX/RX clock tap delays may vary based on the trace lengths of the
platform design for each of the slaves on the SPI bus.

This patch adds support for configuring TX/RX clock delays specified
through device tree properties.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 63 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 34dee28554ef..9854e6fbddff 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -170,6 +170,11 @@ struct tegra_spi_soc_data {
 	bool has_intr_mask_reg;
 };
 
+struct tegra_spi_client_data {
+	int tx_clk_tap_delay;
+	int rx_clk_tap_delay;
+};
+
 struct tegra_spi_client_state {
 	bool cs_gpio_valid;
 };
@@ -213,8 +218,10 @@ struct tegra_spi_data {
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
+	u32					def_command2_reg;
 	u32					spi_cs_timing1;
 	u32					spi_cs_timing2;
+	u8					last_used_cs;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -774,11 +781,13 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	struct tegra_spi_client_state *cstate = spi->controller_state;
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
-	u32 command1;
+	u32 command1, command2;
 	int req_mode;
+	u32 tx_tap = 0, rx_tap = 0;
 
 	if (speed != tspi->cur_speed) {
 		clk_set_rate(tspi->clk, speed);
@@ -848,6 +857,18 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 			gpio_set_value(spi->cs_gpio, val);
 		}
 
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
 		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
 	} else {
 		command1 = tspi->command1_reg;
@@ -904,19 +925,47 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
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
 static void tegra_spi_cleanup(struct spi_device *spi)
 {
 	struct tegra_spi_client_state *cstate = spi->controller_state;
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 
 	spi->controller_state = NULL;
 	if (cstate && cstate->cs_gpio_valid)
 		gpio_free(spi->cs_gpio);
 	kfree(cstate);
+	spi->controller_data = NULL;
+	if (spi->dev.of_node)
+		kfree(cdata);
 }
 
 static int tegra_spi_setup(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	struct tegra_spi_client_state *cstate = spi->controller_state;
 	u32 val;
 	unsigned long flags;
@@ -935,6 +984,11 @@ static int tegra_spi_setup(struct spi_device *spi)
 		spi->controller_state = cstate;
 	}
 
+	if (!cdata) {
+		cdata = tegra_spi_parse_cdata_dt(spi);
+		spi->controller_data = cdata;
+	}
+
 	if (spi->master->cs_gpios && gpio_is_valid(spi->cs_gpio)) {
 		if (!cstate->cs_gpio_valid) {
 			int gpio_flag = GPIOF_OUT_INIT_HIGH;
@@ -1084,6 +1138,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			reset_control_assert(tspi->rst);
 			udelay(2);
 			reset_control_deassert(tspi->rst);
+			tspi->last_used_cs = master->num_chipselect + 1;
 			goto complete_xfer;
 		}
 
@@ -1139,6 +1194,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
+		tspi->last_used_cs = master->num_chipselect + 1;
 		return IRQ_HANDLED;
 	}
 
@@ -1214,6 +1270,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
+		tspi->last_used_cs = master->num_chipselect + 1;
 		return IRQ_HANDLED;
 	}
 
@@ -1402,6 +1459,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
 	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
+	tspi->def_command2_reg = tegra_spi_readl(tspi, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(&pdev->dev);
 	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
 				   tegra_spi_isr_thread, IRQF_ONESHOT,
@@ -1474,6 +1533,8 @@ static int tegra_spi_resume(struct device *dev)
 		return ret;
 	}
 	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	tegra_spi_writel(tspi, tspi->def_command2_reg, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(dev);
 
 	return spi_master_resume(master);
-- 
2.7.4

