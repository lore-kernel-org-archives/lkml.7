Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9D9C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D4F22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LhI1k0W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfIDEoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:44:08 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7354 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfIDEoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:44:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f41150000>; Tue, 03 Sep 2019 21:44:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 21:44:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Sep 2019 21:44:01 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:44:01 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 04:44:01 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f410d0002>; Tue, 03 Sep 2019 21:44:00 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: [PATCH V2 12/12] serial: tegra: Add PIO mode support
Date:   Wed, 4 Sep 2019 10:13:07 +0530
Message-ID: <1567572187-29820-13-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567572245; bh=J1M6+IiuhqgxwNSZ2ULOz27gvRiEAkWl9YhI69GQFv0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=LhI1k0W7d+5aXHVLPKWQqbZWMKgymWXGjTw2JthauEE7WgcE9YickGkx2Trh8g1U1
         7xMnkfyQC3MKrSn834baGtsfYrfTjmPu7WcraHckpIuQ17VUaZKlH+YEJA0M3bN9ZV
         WdlSAaqsTwyBr4I+cMXEhaSW+Hz1o5c3C4oskXcdj47Ba34ogKJCcS0JYKY+q87V3C
         Z56qdfgcy0lz3cGuehz8DMmeww0pZpLcaAH52FgTJsyl/8ivTvfezbOM+Yt0vxC7Uf
         wzy83pgeIatUMOLGZYMbx4O6cEgWIVFq3+kRWvJJy4Usak0ru2CNsyVwlK5qI6Xa/9
         pKPT7EE9tBWEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PIO mode support in receive and transmit path with RX interrupt
trigger of 16 bytes for Tegra194 and older chips.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 117 ++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d0fd417..2f59951 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -139,6 +139,8 @@ struct tegra_uart_port {
 	int					n_adjustable_baud_rates;
 	int					required_rate;
 	int					configured_rate;
+	bool					use_rx_pio;
+	bool					use_tx_pio;
 };
 
 static void tegra_uart_start_next_tx(struct tegra_uart_port *tup);
@@ -567,7 +569,7 @@ static void tegra_uart_start_next_tx(struct tegra_uart_port *tup)
 	if (!count)
 		return;
 
-	if (count < TEGRA_UART_MIN_DMA)
+	if (tup->use_tx_pio || count < TEGRA_UART_MIN_DMA)
 		tegra_uart_start_pio_tx(tup, count);
 	else if (BYTES_TO_ALIGN(tail) > 0)
 		tegra_uart_start_pio_tx(tup, BYTES_TO_ALIGN(tail));
@@ -800,6 +802,18 @@ static void tegra_uart_handle_modem_signal_change(struct uart_port *u)
 		uart_handle_cts_change(&tup->uport, msr & UART_MSR_CTS);
 }
 
+static void do_handle_rx_pio(struct tegra_uart_port *tup)
+{
+	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
+	struct tty_port *port = &tup->uport.state->port;
+
+	tegra_uart_handle_rx_pio(tup, port);
+	if (tty) {
+		tty_flip_buffer_push(port);
+		tty_kref_put(tty);
+	}
+}
+
 static irqreturn_t tegra_uart_isr(int irq, void *data)
 {
 	struct tegra_uart_port *tup = data;
@@ -813,7 +827,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 	while (1) {
 		iir = tegra_uart_read(tup, UART_IIR);
 		if (iir & UART_IIR_NO_INT) {
-			if (is_rx_int) {
+			if (!tup->use_rx_pio && is_rx_int) {
 				tegra_uart_handle_rx_dma(tup);
 				if (tup->rx_in_progress) {
 					ier = tup->ier_shadow;
@@ -841,7 +855,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 		case 4: /* End of data */
 		case 6: /* Rx timeout */
 		case 2: /* Receive */
-			if (!is_rx_int) {
+			if (!tup->use_rx_pio && !is_rx_int) {
 				is_rx_int = true;
 				/* Disable Rx interrupts */
 				ier = tup->ier_shadow;
@@ -851,6 +865,8 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 					UART_IER_RTOIE | TEGRA_UART_IER_EORD);
 				tup->ier_shadow = ier;
 				tegra_uart_write(tup, ier, UART_IER);
+			} else {
+				do_handle_rx_pio(tup);
 			}
 			break;
 
@@ -869,6 +885,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 static void tegra_uart_stop_rx(struct uart_port *u)
 {
 	struct tegra_uart_port *tup = to_tegra_uport(u);
+	struct tty_port *port = &tup->uport.state->port;
 	struct dma_tx_state state;
 	unsigned long ier;
 
@@ -886,9 +903,13 @@ static void tegra_uart_stop_rx(struct uart_port *u)
 	tup->ier_shadow = ier;
 	tegra_uart_write(tup, ier, UART_IER);
 	tup->rx_in_progress = 0;
-	dmaengine_terminate_all(tup->rx_dma_chan);
-	dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
-	tegra_uart_rx_buffer_push(tup, state.residue);
+	if (tup->rx_dma_chan && !tup->use_rx_pio) {
+		dmaengine_terminate_all(tup->rx_dma_chan);
+		dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
+		tegra_uart_rx_buffer_push(tup, state.residue);
+	} else {
+		tegra_uart_handle_rx_pio(tup, port);
+	}
 }
 
 static void tegra_uart_hw_deinit(struct tegra_uart_port *tup)
@@ -939,8 +960,10 @@ static void tegra_uart_hw_deinit(struct tegra_uart_port *tup)
 	tup->rx_in_progress = 0;
 	tup->tx_in_progress = 0;
 
-	tegra_uart_dma_channel_free(tup, true);
-	tegra_uart_dma_channel_free(tup, false);
+	if (!tup->use_rx_pio)
+		tegra_uart_dma_channel_free(tup, true);
+	if (!tup->use_tx_pio)
+		tegra_uart_dma_channel_free(tup, false);
 
 	clk_disable_unprepare(tup->uart_clk);
 }
@@ -985,10 +1008,14 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 */
 	tup->fcr_shadow = UART_FCR_ENABLE_FIFO;
 
-	if (tup->cdata->max_dma_burst_bytes == 8)
-		tup->fcr_shadow |= UART_FCR_R_TRIG_10;
-	else
-		tup->fcr_shadow |= UART_FCR_R_TRIG_01;
+	if (tup->use_rx_pio) {
+		tup->fcr_shadow |= UART_FCR_R_TRIG_11;
+	} else {
+		if (tup->cdata->max_dma_burst_bytes == 8)
+			tup->fcr_shadow |= UART_FCR_R_TRIG_10;
+		else
+			tup->fcr_shadow |= UART_FCR_R_TRIG_01;
+	}
 
 	tup->fcr_shadow |= TEGRA_UART_TX_TRIG_16B;
 	tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
@@ -1016,19 +1043,23 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 * (115200, N, 8, 1) so that the receive DMA buffer may be
 	 * enqueued
 	 */
-	tup->lcr_shadow = TEGRA_UART_DEFAULT_LSR;
 	ret = tegra_set_baudrate(tup, TEGRA_UART_DEFAULT_BAUD);
 	if (ret < 0) {
 		dev_err(tup->uport.dev, "Failed to set baud rate\n");
 		return ret;
 	}
-	tup->fcr_shadow |= UART_FCR_DMA_SELECT;
-	tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
+	if (!tup->use_rx_pio) {
+		tup->lcr_shadow = TEGRA_UART_DEFAULT_LSR;
+		tup->fcr_shadow |= UART_FCR_DMA_SELECT;
+		tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
 
-	ret = tegra_uart_start_rx_dma(tup);
-	if (ret < 0) {
-		dev_err(tup->uport.dev, "Not able to start Rx DMA\n");
-		return ret;
+		ret = tegra_uart_start_rx_dma(tup);
+		if (ret < 0) {
+			dev_err(tup->uport.dev, "Not able to start Rx DMA\n");
+			return ret;
+		}
+	} else {
+		tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
 	}
 	tup->rx_in_progress = 1;
 
@@ -1050,7 +1081,12 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 * both the EORD as well as RX_TIMEOUT - SW sees RX_TIMEOUT first
 	 * then the EORD.
 	 */
-	tup->ier_shadow = UART_IER_RLSI | UART_IER_RTOIE | TEGRA_UART_IER_EORD;
+	if (!tup->use_rx_pio)
+		tup->ier_shadow = UART_IER_RLSI | UART_IER_RTOIE |
+			TEGRA_UART_IER_EORD;
+	else
+		tup->ier_shadow = UART_IER_RLSI | UART_IER_RTOIE | UART_IER_RDI;
+
 	tegra_uart_write(tup, tup->ier_shadow, UART_IER);
 	return 0;
 }
@@ -1145,16 +1181,22 @@ static int tegra_uart_startup(struct uart_port *u)
 	struct tegra_uart_port *tup = to_tegra_uport(u);
 	int ret;
 
-	ret = tegra_uart_dma_channel_allocate(tup, false);
-	if (ret < 0) {
-		dev_err(u->dev, "Tx Dma allocation failed, err = %d\n", ret);
-		return ret;
+	if (!tup->use_tx_pio) {
+		ret = tegra_uart_dma_channel_allocate(tup, false);
+		if (ret < 0) {
+			dev_err(u->dev, "Tx Dma allocation failed, err = %d\n",
+				ret);
+			return ret;
+		}
 	}
 
-	ret = tegra_uart_dma_channel_allocate(tup, true);
-	if (ret < 0) {
-		dev_err(u->dev, "Rx Dma allocation failed, err = %d\n", ret);
-		goto fail_rx_dma;
+	if (!tup->use_rx_pio) {
+		ret = tegra_uart_dma_channel_allocate(tup, true);
+		if (ret < 0) {
+			dev_err(u->dev, "Rx Dma allocation failed, err = %d\n",
+				ret);
+			goto fail_rx_dma;
+		}
 	}
 
 	ret = tegra_uart_hw_init(tup);
@@ -1172,9 +1214,11 @@ static int tegra_uart_startup(struct uart_port *u)
 	return 0;
 
 fail_hw_init:
-	tegra_uart_dma_channel_free(tup, true);
+	if (!tup->use_rx_pio)
+		tegra_uart_dma_channel_free(tup, true);
 fail_rx_dma:
-	tegra_uart_dma_channel_free(tup, false);
+	if (!tup->use_tx_pio)
+		tegra_uart_dma_channel_free(tup, false);
 	return ret;
 }
 
@@ -1378,7 +1422,6 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
 	int count;
 	int n_entries;
 
-
 	port = of_alias_get_id(np, "serial");
 	if (port < 0) {
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", port);
@@ -1388,6 +1431,18 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
 
 	tup->enable_modem_interrupt = of_property_read_bool(np,
 					"nvidia,enable-modem-interrupt");
+
+	index = of_property_match_string(np, "dma-names", "rx");
+	if (index < 0) {
+		tup->use_rx_pio = true;
+		dev_info(&pdev->dev, "RX in PIO mode\n");
+	}
+	index = of_property_match_string(np, "dma-names", "tx");
+	if (index < 0) {
+		tup->use_tx_pio = true;
+		dev_info(&pdev->dev, "TX in PIO mode\n");
+	}
+
 	n_entries = of_property_count_u32_elems(np, "nvidia,adjust-baud-rates");
 	if (n_entries > 0) {
 		tup->n_adjustable_baud_rates = n_entries / 3;
-- 
2.7.4

