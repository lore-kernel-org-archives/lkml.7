Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FAAC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8501214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q7Q97fr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfHLL3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:29:34 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18504 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbfHLL3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:29:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514da40001>; Mon, 12 Aug 2019 04:29:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:29:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Aug 2019 04:29:29 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:29:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:29:29 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d950004>; Mon, 12 Aug 2019 04:29:28 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: [PATCH 14/14] serial: tegra: Add PIO mode support
Date:   Mon, 12 Aug 2019 16:58:23 +0530
Message-ID: <1565609303-27000-15-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609380; bh=Vxzh1OPXEktqHUn/3Dn+GZxJZNYtPAod90S85gBFsSM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=q7Q97fr7oHygJNXR9ZXtYtgeHND0m/QWtdVf8r+nzw61DZek/GGTPN3d3gYn6bt5W
         BZgY87TOlBP9qnc0QqEKcLRQpnZ7XCKruhs8pt0MtWr0h+XF7R2MFZKs+QQZ1wXg9Y
         Oy0MTAyj7jvS/TJjNXNjjwSPdumbXMpb/4zSLod6fPZvW1Z7/q7Tr6kzJhJJ3fDOeL
         xZ5FyUlq7jxZhijVDpIhvAUPQYAJeIfD50vOVrM8dv3p4U9nO1jaarnRfHyqSqylvQ
         mZbvp2lH1EliW1y4RAVeesVZBcRmo9ZTbVULbB9qXshfYzXY/ePydolMcI0hp9Ph5q
         R7ujtqWVi6Bhg==
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
index 3e02f27..6e5b418 100644
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
@@ -569,7 +571,7 @@ static void tegra_uart_start_next_tx(struct tegra_uart_port *tup)
 	if (!count)
 		return;
 
-	if (count < TEGRA_UART_MIN_DMA)
+	if (tup->use_tx_pio || count < TEGRA_UART_MIN_DMA)
 		tegra_uart_start_pio_tx(tup, count);
 	else if (BYTES_TO_ALIGN(tail) > 0)
 		tegra_uart_start_pio_tx(tup, BYTES_TO_ALIGN(tail));
@@ -802,6 +804,18 @@ static void tegra_uart_handle_modem_signal_change(struct uart_port *u)
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
@@ -815,7 +829,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 	while (1) {
 		iir = tegra_uart_read(tup, UART_IIR);
 		if (iir & UART_IIR_NO_INT) {
-			if (is_rx_int) {
+			if (!tup->use_rx_pio && is_rx_int) {
 				tegra_uart_handle_rx_dma(tup);
 				if (tup->rx_in_progress) {
 					ier = tup->ier_shadow;
@@ -843,7 +857,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 		case 4: /* End of data */
 		case 6: /* Rx timeout */
 		case 2: /* Receive */
-			if (!is_rx_int) {
+			if (!tup->use_rx_pio && !is_rx_int) {
 				is_rx_int = true;
 				/* Disable Rx interrupts */
 				ier = tup->ier_shadow;
@@ -853,6 +867,8 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 					UART_IER_RTOIE | TEGRA_UART_IER_EORD);
 				tup->ier_shadow = ier;
 				tegra_uart_write(tup, ier, UART_IER);
+			} else {
+				do_handle_rx_pio(tup);
 			}
 			break;
 
@@ -871,6 +887,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 static void tegra_uart_stop_rx(struct uart_port *u)
 {
 	struct tegra_uart_port *tup = to_tegra_uport(u);
+	struct tty_port *port = &tup->uport.state->port;
 	struct dma_tx_state state;
 	unsigned long ier;
 
@@ -888,9 +905,13 @@ static void tegra_uart_stop_rx(struct uart_port *u)
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
@@ -941,8 +962,10 @@ static void tegra_uart_hw_deinit(struct tegra_uart_port *tup)
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
@@ -987,10 +1010,14 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 */
 	tup->fcr_shadow = UART_FCR_ENABLE_FIFO;
 
-	if (tup->cdata->dma_burst_bytes == 8)
-		tup->fcr_shadow |= UART_FCR_R_TRIG_10;
-	else
-		tup->fcr_shadow |= UART_FCR_R_TRIG_01;
+	if (tup->use_rx_pio) {
+		tup->fcr_shadow |= UART_FCR_R_TRIG_11;
+	} else {
+		if (tup->cdata->dma_burst_bytes == 8)
+			tup->fcr_shadow |= UART_FCR_R_TRIG_10;
+		else
+			tup->fcr_shadow |= UART_FCR_R_TRIG_01;
+	}
 
 	tup->fcr_shadow |= TEGRA_UART_TX_TRIG_16B;
 	tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
@@ -1017,19 +1044,23 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
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
 
@@ -1051,7 +1082,12 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
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
@@ -1146,16 +1182,22 @@ static int tegra_uart_startup(struct uart_port *u)
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
@@ -1173,9 +1215,11 @@ static int tegra_uart_startup(struct uart_port *u)
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
 
@@ -1379,7 +1423,6 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
 	int count;
 	int n_entries;
 
-
 	port = of_alias_get_id(np, "serial");
 	if (port < 0) {
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", port);
@@ -1389,6 +1432,18 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
 
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

