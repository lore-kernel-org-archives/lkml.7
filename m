Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F1C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39E821739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576591356;
	bh=O81sOC6P6muIaj47lPllNWcJ5u3GDbYzIlWiCGzIuA4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=STsR5yi383DK6rhWMy16u9MjPlhKtsRDQU89f5MSu3sJahF421m6GCtwG2SgrLe2D
	 uI35sv5S25qX8it+QSMBLEKCaW+5KfLFEFfXJ2Xe801o2IxJEvCsxQ2dmC+EKiJNdu
	 /HisY0BKdAuCGBG0Uinde+NrmCeewzkYznv3yeiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfLQOCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbfLQOCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:02:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149C120716;
        Tue, 17 Dec 2019 14:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576591354;
        bh=O81sOC6P6muIaj47lPllNWcJ5u3GDbYzIlWiCGzIuA4=;
        h=Date:From:To:Cc:Subject:From;
        b=ODZN+0uvrW6acll20weaVCyeqs9HVFqvRLiqHfNvDCa4FThq90+nJClZwO2xkBDpp
         efAquq+f0BmQMNB5dUZQXXDhcmZ6Tl8oSkWmW4udsnbizBb2oZAa57GCofO9rudI4/
         4xQCvjRjQZJ54CzMjNlfYTFKH3jlWKhlOxhSQ1hQ=
Date:   Tue, 17 Dec 2019 15:02:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kukjin Kim <kgene@kernel.org>, Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Safonov <dima@arista.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: samsung_tty: do not abuse the struct uart_port
 unused fields
Message-ID: <20191217140232.GA3489190@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The samsung_tty driver was trying to abuse the struct uart_port by using
two "empty" bytes for its own use.  That's not ok, and was found by
removing those fields from the structure.

Move the variables into the port-specific structure, which is where
everything else for this port already is.  There is no space wasted here
as there was an empty "hole" in the structure already for these bytes.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 46 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 2fd4f2de7083..5b5f249cbf1f 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -56,10 +56,6 @@
 #define S3C24XX_TX_DMA			2
 #define S3C24XX_RX_PIO			1
 #define S3C24XX_RX_DMA			2
-/* macros to change one thing to another */
-
-#define tx_enabled(port) ((port)->unused[0])
-#define rx_enabled(port) ((port)->unused[1])
 
 /* flag to ignore all characters coming in */
 #define RXSTAT_DUMMY_READ (0x10000000)
@@ -123,6 +119,8 @@ struct s3c24xx_uart_dma {
 struct s3c24xx_uart_port {
 	unsigned char			rx_claimed;
 	unsigned char			tx_claimed;
+	unsigned char			rx_enabled;
+	unsigned char			tx_enabled;
 	unsigned int			pm_level;
 	unsigned long			baudclk_rate;
 	unsigned int			min_dma_size;
@@ -223,6 +221,7 @@ static int s3c24xx_serial_has_interrupt_mask(struct uart_port *port)
 
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
 	unsigned int ucon, ufcon;
 	int count = 10000;
@@ -240,12 +239,13 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	ucon |= S3C2410_UCON_RXIRQMODE;
 	wr_regl(port, S3C2410_UCON, ucon);
 
-	rx_enabled(port) = 1;
+	ourport->rx_enabled = 1;
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void s3c24xx_serial_rx_disable(struct uart_port *port)
 {
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
 	unsigned int ucon;
 
@@ -255,7 +255,7 @@ static void s3c24xx_serial_rx_disable(struct uart_port *port)
 	ucon &= ~S3C2410_UCON_RXIRQMODE;
 	wr_regl(port, S3C2410_UCON, ucon);
 
-	rx_enabled(port) = 0;
+	ourport->rx_enabled = 0;
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -267,7 +267,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	struct dma_tx_state state;
 	int count;
 
-	if (!tx_enabled(port))
+	if (!ourport->tx_enabled)
 		return;
 
 	if (s3c24xx_serial_has_interrupt_mask(port))
@@ -287,7 +287,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 		port->icount.tx += count;
 	}
 
-	tx_enabled(port) = 0;
+	ourport->tx_enabled = 0;
 	ourport->tx_in_progress = 0;
 
 	if (port->flags & UPF_CONS_FLOW)
@@ -445,11 +445,11 @@ static void s3c24xx_serial_start_tx(struct uart_port *port)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	struct circ_buf *xmit = &port->state->xmit;
 
-	if (!tx_enabled(port)) {
+	if (!ourport->tx_enabled) {
 		if (port->flags & UPF_CONS_FLOW)
 			s3c24xx_serial_rx_disable(port);
 
-		tx_enabled(port) = 1;
+		ourport->tx_enabled = 1;
 		if (!ourport->dma || !ourport->dma->tx_chan)
 			s3c24xx_serial_start_tx_pio(ourport);
 	}
@@ -494,14 +494,14 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 	enum dma_status dma_status;
 	unsigned int received;
 
-	if (rx_enabled(port)) {
+	if (ourport->rx_enabled) {
 		dev_dbg(port->dev, "stopping rx\n");
 		if (s3c24xx_serial_has_interrupt_mask(port))
 			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD,
 					S3C64XX_UINTM);
 		else
 			disable_irq_nosync(ourport->rx_irq);
-		rx_enabled(port) = 0;
+		ourport->rx_enabled = 0;
 	}
 	if (dma && dma->rx_chan) {
 		dmaengine_pause(dma->tx_chan);
@@ -723,9 +723,9 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 		if (port->flags & UPF_CONS_FLOW) {
 			int txe = s3c24xx_serial_txempty_nofifo(port);
 
-			if (rx_enabled(port)) {
+			if (ourport->rx_enabled) {
 				if (!txe) {
-					rx_enabled(port) = 0;
+					ourport->rx_enabled = 0;
 					continue;
 				}
 			} else {
@@ -733,7 +733,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 					ufcon = rd_regl(port, S3C2410_UFCON);
 					ufcon |= S3C2410_UFCON_RESETRX;
 					wr_regl(port, S3C2410_UFCON, ufcon);
-					rx_enabled(port) = 1;
+					ourport->rx_enabled = 1;
 					return;
 				}
 				continue;
@@ -1084,7 +1084,7 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
 	if (ourport->tx_claimed) {
 		if (!s3c24xx_serial_has_interrupt_mask(port))
 			free_irq(ourport->tx_irq, ourport);
-		tx_enabled(port) = 0;
+		ourport->tx_enabled = 0;
 		ourport->tx_claimed = 0;
 		ourport->tx_mode = 0;
 	}
@@ -1093,7 +1093,7 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
 		if (!s3c24xx_serial_has_interrupt_mask(port))
 			free_irq(ourport->rx_irq, ourport);
 		ourport->rx_claimed = 0;
-		rx_enabled(port) = 0;
+		ourport->rx_enabled = 0;
 	}
 
 	/* Clear pending interrupts and mask all interrupts */
@@ -1115,7 +1115,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	int ret;
 
-	rx_enabled(port) = 1;
+	ourport->rx_enabled = 1;
 
 	ret = request_irq(ourport->rx_irq, s3c24xx_serial_rx_chars, 0,
 			  s3c24xx_serial_portname(port), ourport);
@@ -1129,7 +1129,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "requesting tx irq...\n");
 
-	tx_enabled(port) = 1;
+	ourport->tx_enabled = 1;
 
 	ret = request_irq(ourport->tx_irq, s3c24xx_serial_tx_chars, 0,
 			  s3c24xx_serial_portname(port), ourport);
@@ -1176,9 +1176,9 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	}
 
 	/* For compatibility with s3c24xx Soc's */
-	rx_enabled(port) = 1;
+	ourport->rx_enabled = 1;
 	ourport->rx_claimed = 1;
-	tx_enabled(port) = 0;
+	ourport->tx_enabled = 0;
 	ourport->tx_claimed = 1;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -2112,9 +2112,9 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 		if (s3c24xx_serial_has_interrupt_mask(port)) {
 			unsigned int uintm = 0xf;
 
-			if (tx_enabled(port))
+			if (ourport->tx_enabled)
 				uintm &= ~S3C64XX_UINTM_TXD_MSK;
-			if (rx_enabled(port))
+			if (ourport->rx_enabled)
 				uintm &= ~S3C64XX_UINTM_RXD_MSK;
 			clk_prepare_enable(ourport->clk);
 			if (!IS_ERR(ourport->baudclk))
-- 
2.24.1

