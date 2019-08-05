Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FFFC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E3820C01
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4JHJULw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfHETc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:32:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42827 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHETc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:32:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so40126169pff.9;
        Mon, 05 Aug 2019 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bqaCERVfOErLWAUCqjdIDZlNB1C8W2a9XoYcKYwSOQ=;
        b=h4JHJULw1FYqwvPfG0JWszPwH6b5fjvwZoFdQxSkKrVnzCQA6fmddVE5/yrg+b2RYF
         fTnjI8NwMId59dv6OcecGFRK6v26Uq+NXZuHJ84qUP/fs+0AqcRMayHR5lfn6c8F/9nJ
         mraFt2PXS+TdObu5ERby2PnKBECE0DftUAJnqBkjnQ961i421k728vUHN/RkfVT7BrPj
         DmIeJg9oTV2WoPF2s5GQFppotGNU/WN3C/p61Pn1psFhs6uszCHvFuNDwmLCzPl7J+Oc
         fD0VUm5k+5gP1vPmVM68+atzVYC3BiSj0c8oKHR6h59AJLhVjuO7IQLelgcA0gB+ALAl
         rmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bqaCERVfOErLWAUCqjdIDZlNB1C8W2a9XoYcKYwSOQ=;
        b=KO9HMcpGRYYDn2C/iVPrkE2P7GPv5DokGuhClh1hNiZPNhW2weqVzb34ldV6BL8HLX
         +d3umzOXk3k9f6IHSzTTyQCGbKi4rOlzv1Za9CpiVrzDbF/Qp078M4dAMEQuQ+zYt9rB
         QV7GdueESjQnnNF+iX2L/WyJYfr/I4wayoWe4hpqkr8s8WBc0DkemhfefoAbIFOKMd5i
         lRKXX+fezgHlrtmQP4JI+ulMYFL61d9+SvFQPG4x+eQBuI9bPDdK0xrBIUA8nbHtxXcN
         ASiCaW91ZIFSkUBsO6IgdHpQoLT+MECCmetnGq/Uv0xbh8wQ37J8mdCxGx5T7lz0yRMS
         t53w==
X-Gm-Message-State: APjAAAU4JuURGtPWMhRDLRVUeKzQizweRszjKCvNf+Txoo0dkSHUdN0F
        W9R5+lLA+dBxQzZZy9xTQhheKW+p
X-Google-Smtp-Source: APXvYqwaT7aeZyqQx8df26hPQ4yX2U3aGoTKFZSb07aoPyzon4BPqvrWu7iv1vPaenFmm+xjI3DUGg==
X-Received: by 2002:aa7:818b:: with SMTP id g11mr75425460pfi.122.1565033576252;
        Mon, 05 Aug 2019 12:32:56 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z68sm78525680pgz.88.2019.08.05.12.32.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 12:32:55 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Chris Healy <cphealy@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: Introduce uart_tx_stoppped_or_empty()
Date:   Mon,  5 Aug 2019 12:32:43 -0700
Message-Id: <20190805193243.18584-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vast majority of the serial drivers check for

    uart_tx_stopped(&p->port) || uart_circ_empty(xmit)

condition one or more times. Create a dedicated helper function and
convert drivers to use it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Looks like lpuart_stopped_or_empty() helper function I created for
fsl_lpuart.c can be useful in a lot of drivers, so this patch makes it
into a generic function.

Thanks,
Andrey Smirnov

 drivers/tty/serial/21285.c                  |  2 +-
 drivers/tty/serial/8250/8250_dma.c          |  2 +-
 drivers/tty/serial/8250/8250_omap.c         |  7 +++----
 drivers/tty/serial/amba-pl010.c             |  2 +-
 drivers/tty/serial/amba-pl011.c             |  6 +++---
 drivers/tty/serial/apbuart.c                |  2 +-
 drivers/tty/serial/atmel_serial.c           |  6 +++---
 drivers/tty/serial/clps711x.c               |  2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  2 +-
 drivers/tty/serial/digicolor-usart.c        |  2 +-
 drivers/tty/serial/dz.c                     |  2 +-
 drivers/tty/serial/efm32-uart.c             |  2 +-
 drivers/tty/serial/fsl_lpuart.c             | 15 +++++----------
 drivers/tty/serial/imx.c                    |  7 +++----
 drivers/tty/serial/ioc3_serial.c            |  2 +-
 drivers/tty/serial/ioc4_serial.c            |  2 +-
 drivers/tty/serial/lpc32xx_hs.c             |  2 +-
 drivers/tty/serial/max3100.c                |  6 ++----
 drivers/tty/serial/max310x.c                |  2 +-
 drivers/tty/serial/milbeaut_usio.c          |  2 +-
 drivers/tty/serial/mpc52xx_uart.c           |  2 +-
 drivers/tty/serial/mps2-uart.c              |  2 +-
 drivers/tty/serial/msm_serial.c             |  2 +-
 drivers/tty/serial/mux.c                    |  2 +-
 drivers/tty/serial/mvebu-uart.c             |  2 +-
 drivers/tty/serial/mxs-auart.c              |  4 ++--
 drivers/tty/serial/omap-serial.c            |  2 +-
 drivers/tty/serial/pch_uart.c               |  2 +-
 drivers/tty/serial/pnx8xxx_uart.c           |  2 +-
 drivers/tty/serial/pxa.c                    |  2 +-
 drivers/tty/serial/sa1100.c                 |  2 +-
 drivers/tty/serial/samsung.c                |  2 +-
 drivers/tty/serial/sb1250-duart.c           |  2 +-
 drivers/tty/serial/sc16is7xx.c              |  2 +-
 drivers/tty/serial/sccnxp.c                 |  2 +-
 drivers/tty/serial/serial_ks8695.c          |  2 +-
 drivers/tty/serial/serial_txx9.c            |  2 +-
 drivers/tty/serial/sifive.c                 |  2 +-
 drivers/tty/serial/sirfsoc_uart.c           |  4 ++--
 drivers/tty/serial/sn_console.c             |  2 +-
 drivers/tty/serial/sprd_serial.c            |  5 ++---
 drivers/tty/serial/stm32-usart.c            |  2 +-
 drivers/tty/serial/sunhv.c                  |  2 +-
 drivers/tty/serial/sunsab.c                 |  4 ++--
 drivers/tty/serial/timbuart.c               |  2 +-
 drivers/tty/serial/uartlite.c               |  2 +-
 drivers/tty/serial/ucc_uart.c               |  2 +-
 drivers/tty/serial/vr41xx_siu.c             |  2 +-
 drivers/tty/serial/vt8500_serial.c          |  2 +-
 drivers/tty/serial/zs.c                     |  2 +-
 include/linux/serial_core.h                 |  5 +++++
 51 files changed, 72 insertions(+), 77 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 32b3acf8150a..f46d5ee8cbb9 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -128,7 +128,7 @@ static irqreturn_t serial21285_tx_chars(int irq, void *dev_id)
 		port->x_char = 0;
 		goto out;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		serial21285_stop_tx(port);
 		goto out;
 	}
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 890fa7ddaa7f..65cc7bea62ef 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -69,7 +69,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	if (dma->tx_running)
 		return 0;
 
-	if (uart_tx_stopped(&p->port) || uart_circ_empty(xmit)) {
+	if (uart_tx_stopped_or_empty(&p->port)) {
 		/* We have been called from __dma_tx_complete() */
 		serial8250_rpm_put_tx(p);
 		return 0;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index c68e2b3a1634..baf47a50e26d 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -920,7 +920,7 @@ static void omap_8250_dma_tx_complete(void *param)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&p->port);
 
-	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port)) {
+	if (!uart_tx_stopped_or_empty(&p->port)) {
 		int ret;
 
 		ret = omap_8250_tx_dma(p);
@@ -949,7 +949,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 
 	if (dma->tx_running)
 		return 0;
-	if (uart_tx_stopped(&p->port) || uart_circ_empty(xmit)) {
+	if (uart_tx_stopped_or_empty(&p->port)) {
 
 		/*
 		 * Even if no data, we need to return an error for the two cases
@@ -1071,8 +1071,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 	}
 	serial8250_modem_status(up);
 	if (status & UART_LSR_THRE && up->dma->tx_err) {
-		if (uart_tx_stopped(&up->port) ||
-		    uart_circ_empty(&up->port.state->xmit)) {
+		if (uart_tx_stopped_or_empty(&up->port)) {
 			up->dma->tx_err = 0;
 			serial8250_tx_chars(up);
 		} else  {
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2c37d11726ab..4b9f33a6c3af 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -179,7 +179,7 @@ static void pl010_tx_chars(struct uart_amba_port *uap)
 		uap->port.x_char = 0;
 		return;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port)) {
+	if (uart_tx_stopped_or_empty(&uap->port)) {
 		pl010_stop_tx(&uap->port);
 		return;
 	}
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3a7d1a66f79c..f132eafce704 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -570,8 +570,8 @@ static void pl011_dma_tx_callback(void *data)
 	 * a TX buffer completing, we must update the tx queued status to
 	 * get further refills (hence we check dmacr).
 	 */
-	if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
-	    uart_circ_empty(&uap->port.state->xmit)) {
+	if (!(dmacr & UART011_TXDMAE) ||
+	    uart_tx_stopped_or_empty(&uap->port)) {
 		uap->dmatx.queued = false;
 		spin_unlock_irqrestore(&uap->port.lock, flags);
 		return;
@@ -1402,7 +1402,7 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
 		uap->port.x_char = 0;
 		--count;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port)) {
+	if (uart_tx_stopped_or_empty(&uap->port)) {
 		pl011_stop_tx(&uap->port);
 		return false;
 	}
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 60cd133ffbbc..94faaaaf1a68 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -138,7 +138,7 @@ static void apbuart_tx_chars(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		apbuart_stop_tx(port);
 		return;
 	}
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 0b4f36905321..6888d11796a7 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -880,7 +880,7 @@ static void atmel_tx_chars(struct uart_port *port)
 		port->icount.tx++;
 		port->x_char = 0;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_tx_stopped_or_empty(port))
 		return;
 
 	while (atmel_uart_readl(port, ATMEL_US_CSR) &
@@ -981,7 +981,7 @@ static void atmel_tx_dma(struct uart_port *port)
 	if (atmel_port->desc_tx != NULL)
 		return;
 
-	if (!uart_circ_empty(xmit) && !uart_tx_stopped(port)) {
+	if (!uart_tx_stopped_or_empty(port)) {
 		/*
 		 * DMA is idle now.
 		 * Port xmit buffer is already mapped,
@@ -1514,7 +1514,7 @@ static void atmel_tx_pdc(struct uart_port *port)
 	/* disable PDC transmit */
 	atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
 
-	if (!uart_circ_empty(xmit) && !uart_tx_stopped(port)) {
+	if (!uart_tx_stopped_or_empty(port)) {
 		dma_sync_single_for_device(port->dev,
 					   pdc->dma_addr,
 					   pdc->dma_size,
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 061590795680..d60693d67b93 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -158,7 +158,7 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		if (s->tx_enabled) {
 			disable_irq_nosync(port->irq);
 			s->tx_enabled = 0;
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index de6d02f7abe2..273b7f55ec20 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -706,7 +706,7 @@ static int cpm_uart_tx_pump(struct uart_port *port)
 		return 1;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		cpm_uart_stop_tx(port);
 		return 0;
 	}
diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 13ac36e2da4f..f95bc4c72f2e 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -195,7 +195,7 @@ static void digicolor_uart_tx(struct uart_port *port)
 		goto out;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		digicolor_uart_stop_tx(port);
 		goto out;
 	}
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 7b57e840e255..2af667c2c051 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -271,7 +271,7 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
 		return;
 	}
 	/* If nothing to do or stopped or hardware stopped. */
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&dport->port)) {
+	if (uart_tx_stopped_or_empty(&dport->port)) {
 		spin_lock(&dport->port.lock);
 		dz_stop_tx(&dport->port);
 		spin_unlock(&dport->port.lock);
diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index d6b5e5463746..278814496b44 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -147,7 +147,7 @@ static void efm32_uart_tx_chars(struct efm32_uart_port *efm_port)
 			port->x_char = 0;
 			continue;
 		}
-		if (!uart_circ_empty(xmit) && !uart_tx_stopped(port)) {
+		if (!uart_tx_stopped_or_empty(port)) {
 			port->icount.tx++;
 			efm32_uart_write32(efm_port, xmit->buf[xmit->tail],
 					UARTn_TXDATA);
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 0e09e6dc5ccb..8e7a488f6f39 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -452,11 +452,6 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 	dma_async_issue_pending(sport->dma_tx_chan);
 }
 
-static bool lpuart_stopped_or_empty(struct uart_port *port)
-{
-	return uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port);
-}
-
 static void lpuart_dma_tx_complete(void *arg)
 {
 	struct lpuart_port *sport = arg;
@@ -484,7 +479,7 @@ static void lpuart_dma_tx_complete(void *arg)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	if (!lpuart_stopped_or_empty(&sport->port))
+	if (!uart_tx_stopped_or_empty(&sport->port))
 		lpuart_dma_tx(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -685,7 +680,7 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 		return;
 	}
 
-	if (lpuart_stopped_or_empty(&sport->port)) {
+	if (uart_tx_stopped_or_empty(&sport->port)) {
 		lpuart_stop_tx(&sport->port);
 		return;
 	}
@@ -716,7 +711,7 @@ static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 		return;
 	}
 
-	if (lpuart_stopped_or_empty(&sport->port)) {
+	if (uart_tx_stopped_or_empty(&sport->port)) {
 		lpuart32_stop_tx(&sport->port);
 		return;
 	}
@@ -750,7 +745,7 @@ static void lpuart_start_tx(struct uart_port *port)
 	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
 
 	if (sport->lpuart_dma_tx_use) {
-		if (!lpuart_stopped_or_empty(port))
+		if (!uart_tx_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
 		if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
@@ -764,7 +759,7 @@ static void lpuart32_start_tx(struct uart_port *port)
 	unsigned long temp;
 
 	if (sport->lpuart_dma_tx_use) {
-		if (!lpuart_stopped_or_empty(port))
+		if (!uart_tx_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
 		temp = lpuart32_read(port, UARTCTRL);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d9a73c7683ea..ae53bf73dd69 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -505,7 +505,7 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+	if (uart_tx_stopped_or_empty(&sport->port)) {
 		imx_uart_stop_tx(&sport->port);
 		return;
 	}
@@ -572,7 +572,7 @@ static void imx_uart_dma_tx_callback(void *data)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&sport->port);
 
-	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&sport->port))
+	if (!uart_tx_stopped_or_empty(&sport->port))
 		imx_uart_dma_tx(sport);
 	else if (sport->port.rs485.flags & SER_RS485_ENABLED) {
 		u32 ucr4 = imx_uart_readl(sport, UCR4);
@@ -693,8 +693,7 @@ static void imx_uart_start_tx(struct uart_port *port)
 			return;
 		}
 
-		if (!uart_circ_empty(&port->state->xmit) &&
-		    !uart_tx_stopped(port))
+		if (!uart_tx_stopped_or_empty(port))
 			imx_uart_dma_tx(sport);
 		return;
 	}
diff --git a/drivers/tty/serial/ioc3_serial.c b/drivers/tty/serial/ioc3_serial.c
index d8a1cdd6a53d..e9dd560c8510 100644
--- a/drivers/tty/serial/ioc3_serial.c
+++ b/drivers/tty/serial/ioc3_serial.c
@@ -906,7 +906,7 @@ static void transmit_chars(struct uart_port *the_port)
 	state = the_port->state;
 	tty = state->port.tty;
 
-	if (uart_circ_empty(&state->xmit) || uart_tx_stopped(the_port)) {
+	if (uart_tx_stopped_or_empty(the_port)) {
 		/* Nothing to do or hw stopped */
 		set_notification(port, N_ALL_OUTPUT, 0);
 		return;
diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index db5b979e5a0c..e6f7edb7cd89 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -1641,7 +1641,7 @@ static void transmit_chars(struct uart_port *the_port)
 	state = the_port->state;
 	tty = state->port.tty;
 
-	if (uart_circ_empty(&state->xmit) || uart_tx_stopped(the_port)) {
+	if (uart_tx_stopped_or_empty(the_port)) {
 		/* Nothing to do or hw stopped */
 		set_notification(port, N_ALL_OUTPUT, 0);
 		return;
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 7c67e3afbac7..a96df87c9c7a 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -292,7 +292,7 @@ static void __serial_lpc32xx_tx(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_tx_stopped_or_empty(port))
 		goto exit_tx;
 
 	/* Transfer data */
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 371569a0fd00..0be234ca88b3 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -289,8 +289,7 @@ static void max3100_work(struct work_struct *w)
 				tx = s->port.x_char;
 				s->port.icount.tx++;
 				s->port.x_char = 0;
-			} else if (!uart_circ_empty(xmit) &&
-				   !uart_tx_stopped(&s->port)) {
+			} else if (!uart_tx_stopped_or_empty(&s->port)) {
 				tx = xmit->buf[xmit->tail];
 				xmit->tail = (xmit->tail + 1) &
 					(UART_XMIT_SIZE - 1);
@@ -314,8 +313,7 @@ static void max3100_work(struct work_struct *w)
 	} while (!s->force_end_work &&
 		 !freezing(current) &&
 		 ((rx & MAX3100_R) ||
-		  (!uart_circ_empty(xmit) &&
-		   !uart_tx_stopped(&s->port))));
+		  !uart_tx_stopped_or_empty(&s->port)));
 
 	if (rxchars > 0)
 		tty_flip_buffer_push(&s->port.state->port);
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e6c48a99bd85..e88f0d59a208 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -757,7 +757,7 @@ static void max310x_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_tx_stopped_or_empty(port))
 		return;
 
 	/* Get length of data pending in circular buffer */
diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 949ab7efc4fc..ad99096dd2bc 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -91,7 +91,7 @@ static void mlb_usio_tx_chars(struct uart_port *port)
 		port->x_char = 0;
 		return;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		mlb_usio_stop_tx(port);
 		return;
 	}
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 3a75ee08d619..68308fc23501 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1450,7 +1450,7 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
 	}
 
 	/* Nothing to do ? */
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		mpc52xx_uart_stop_tx(port);
 		return 0;
 	}
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 587b42f754cb..98dbbf39d7f7 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -139,7 +139,7 @@ static void mps2_uart_tx_chars(struct uart_port *port)
 			continue;
 		}
 
-		if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+		if (uart_tx_stopped_or_empty(port))
 			break;
 
 		mps2_uart_write8(port, xmit->buf[xmit->tail], UARTn_DATA);
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 3657a24913fc..a575e720c4bc 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -885,7 +885,7 @@ static void msm_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		msm_stop_tx(port);
 		return;
 	}
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 00ce31e8d19a..deed59225178 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -194,7 +194,7 @@ static void mux_write(struct uart_port *port)
 		return;
 	}
 
-	if(uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if(uart_tx_stopped_or_empty(port)) {
 		mux_stop_tx(port);
 		return;
 	}
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index c12a12556339..f9266f4e7aaf 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -308,7 +308,7 @@ static void mvebu_uart_tx_chars(struct uart_port *port, unsigned int status)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		mvebu_uart_stop_tx(port);
 		return;
 	}
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 4c188f4079b3..2b42e82572b5 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -592,7 +592,7 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 		if (test_and_set_bit(MXS_AUART_DMA_TX_SYNC, &s->flags))
 			return;
 
-		while (!uart_circ_empty(xmit) && !uart_tx_stopped(&s->port)) {
+		while (!uart_tx_stopped_or_empty(&s->port)) {
 			size = min_t(u32, UART_XMIT_SIZE - i,
 				     CIRC_CNT_TO_END(xmit->head,
 						     xmit->tail,
@@ -625,7 +625,7 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 			s->port.x_char = 0;
 			continue;
 		}
-		if (!uart_circ_empty(xmit) && !uart_tx_stopped(&s->port)) {
+		if (!uart_tx_stopped_or_empty(&s->port)) {
 			s->port.icount.tx++;
 			mxs_write(xmit->buf[xmit->tail], s, REG_DATA);
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6420ae581a80..ec2116d2ed41 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -375,7 +375,7 @@ static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
 		up->port.x_char = 0;
 		return;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+	if (uart_tx_stopped_or_empty(&up->port)) {
 		serial_omap_stop_tx(&up->port);
 		return;
 	}
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6157213a8359..0a8151382041 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -800,7 +800,7 @@ static int pop_tx(struct eg20t_port *priv, int size)
 	struct uart_port *port = &priv->port;
 	struct circ_buf *xmit = &port->state->xmit;
 
-	if (uart_tx_stopped(port) || uart_circ_empty(xmit) || count >= size)
+	if (uart_tx_stopped_or_empty(port) || count >= size)
 		goto pop_tx_end;
 
 	do {
diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 223a9499104e..d5bed66d2736 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -260,7 +260,7 @@ static void pnx8xxx_tx_chars(struct pnx8xxx_port *sport)
 	 */
 	pnx8xxx_mctrl_check(sport);
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+	if (uart_tx_stopped_or_empty(&sport->port)) {
 		pnx8xxx_stop_tx(&sport->port);
 		return;
 	}
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 4932b674f7ef..d414a945860c 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -186,7 +186,7 @@ static void transmit_chars(struct uart_pxa_port *up)
 		up->port.x_char = 0;
 		return;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+	if (uart_tx_stopped_or_empty(&up->port)) {
 		serial_pxa_stop_tx(&up->port);
 		return;
 	}
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 8e618129e65c..7521d8c3f2b1 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -251,7 +251,7 @@ static void sa1100_tx_chars(struct sa1100_port *sport)
 	 */
 	sa1100_mctrl_check(sport);
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+	if (uart_tx_stopped_or_empty(&sport->port)) {
 		sa1100_stop_tx(&sport->port);
 		return;
 	}
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 83fd51607741..fb51bf567e7a 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -734,7 +734,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	 * stopped, disable the uart and exit
 	*/
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		s3c24xx_serial_stop_tx(port);
 		goto out;
 	}
diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 329aced26bd8..737cb33bd4a0 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -399,7 +399,7 @@ static void sbd_transmit_chars(struct sbd_port *sport)
 	}
 
 	/* If nothing to do or stopped or hardware stopped.  */
-	stop_tx = (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port));
+	stop_tx = uart_tx_stopped_or_empty(&sport->port);
 
 	/* Send char.  */
 	if (!stop_tx) {
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7d3ae31cc720..ef5695737022 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -643,7 +643,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_tx_stopped_or_empty(port))
 		return;
 
 	/* Get length of data pending in circular buffer */
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index d2b77aae42ae..e39722467a53 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -454,7 +454,7 @@ static void sccnxp_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		/* Disable TX if FIFO is empty */
 		if (sccnxp_port_read(port, SCCNXP_SR_REG) & SR_TXEMT) {
 			sccnxp_disable_irq(port, IMR_TXRDY);
diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index b461d791188c..e00cc7aeb7b3 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -214,7 +214,7 @@ static irqreturn_t ks8695uart_tx_chars(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	if (uart_tx_stopped(port) || uart_circ_empty(xmit)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		ks8695uart_stop_tx(port);
 		return IRQ_HANDLED;
 	}
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index d22ccb32aa9b..d0ff6bb47193 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -351,7 +351,7 @@ static inline void transmit_chars(struct uart_txx9_port *up)
 		up->port.x_char = 0;
 		return;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+	if (uart_tx_stopped_or_empty(&up->port)) {
 		serial_txx9_stop_tx(&up->port);
 		return;
 	}
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index d5f81b98e4d7..966760cbee17 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -308,7 +308,7 @@ static void __ssp_transmit_chars(struct sifive_serial_port *ssp)
 		ssp->port.x_char = 0;
 		return;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&ssp->port)) {
+	if (uart_tx_stopped_or_empty(&ssp->port)) {
 		sifive_serial_stop_tx(&ssp->port);
 		return;
 	}
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 38622f2a30a9..f076d510a52b 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -184,7 +184,7 @@ static void sirfsoc_uart_tx_with_dma(struct sirfsoc_uart_port *sirfport)
 
 	tran_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 	tran_start = (unsigned long)(xmit->buf + xmit->tail);
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port) ||
+	if (uart_tx_stopped_or_empty(port) ||
 			!tran_size)
 		return;
 	if (sirfport->tx_dma_state == TX_DMA_PAUSE) {
@@ -570,7 +570,7 @@ static irqreturn_t sirfsoc_uart_isr(int irq, void *dev_id)
 		if (sirfport->tx_dma_chan)
 			sirfsoc_uart_tx_with_dma(sirfport);
 		else {
-			if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+			if (uart_tx_stopped_or_empty(port)) {
 				spin_unlock(&port->lock);
 				return IRQ_HANDLED;
 			} else {
diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index 283493358a62..6efb0e90f13d 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -530,7 +530,7 @@ static void sn_transmit_chars(struct sn_cons_port *port, int raw)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&port->sc_port)) {
+	if (uart_tx_stopped_or_empty(&port->sc_port)) {
 		/* Nothing to do. */
 		ia64_sn_console_intr_disable(SAL_CONSOLE_INTR_XMIT);
 		return;
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 284709f61831..c48cd0523311 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -318,7 +318,6 @@ static void sprd_start_tx_dma(struct uart_port *port)
 {
 	struct sprd_uart_port *sp =
 		container_of(port, struct sprd_uart_port, port);
-	struct circ_buf *xmit = &port->state->xmit;
 
 	if (port->x_char) {
 		serial_out(port, SPRD_TXD, port->x_char);
@@ -327,7 +326,7 @@ static void sprd_start_tx_dma(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		sprd_stop_tx_dma(port);
 		return;
 	}
@@ -632,7 +631,7 @@ static inline void sprd_tx(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		sprd_stop_tx(port);
 		return;
 	}
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index df90747ee3a8..b466fac10ec7 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -427,7 +427,7 @@ static void stm32_transmit_chars(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		stm32_tx_interrupt_disable(port);
 		return;
 	}
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index f8503f8fc44e..28e1dff8c120 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -208,7 +208,7 @@ static void transmit_chars(struct uart_port *port)
 		return;
 
 	xmit = &port->state->xmit;
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_tx_stopped_or_empty(port))
 		return;
 
 	sunhv_ops->transmit_chars(port, xmit);
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 72131b5e132e..7cf5f154ad6f 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -255,7 +255,7 @@ static void transmit_chars(struct uart_sunsab_port *up,
 	set_bit(SAB82532_XPR, &up->irqflags);
 	sunsab_tx_idle(up);
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+	if (uart_tx_stopped_or_empty(&up->port)) {
 		up->interrupt_mask1 |= SAB82532_IMR1_XPR;
 		writeb(up->interrupt_mask1, &up->regs->w.imr1);
 		return;
@@ -442,7 +442,7 @@ static void sunsab_start_tx(struct uart_port *port)
 	struct circ_buf *xmit = &up->port.state->xmit;
 	int i;
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_tx_stopped_or_empty(port))
 		return;
 
 	up->interrupt_mask1 &= ~(SAB82532_IMR1_ALLS|SAB82532_IMR1_XPR);
diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 19d38b504e27..f3772e527ff7 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -122,7 +122,7 @@ static void timbuart_handle_tx_port(struct uart_port *port, u32 isr, u32 *ier)
 		container_of(port, struct timbuart_port, port);
 	struct circ_buf *xmit = &port->state->xmit;
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_tx_stopped_or_empty(port))
 		return;
 
 	if (port->x_char)
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b8b912b5a8b9..0ddd27ce055d 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -187,7 +187,7 @@ static int ulite_transmit(struct uart_port *port, int stat)
 		return 1;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_tx_stopped_or_empty(port))
 		return 0;
 
 	uart_out32(xmit->buf[xmit->tail], ULITE_TX, port);
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..0bb9f48880ff 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -356,7 +356,7 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 		return 1;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		qe_uart_stop_tx(port);
 		return 0;
 	}
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 6d106e33f842..942d982a26c9 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -388,7 +388,7 @@ static inline void transmit_chars(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		siu_stop_tx(port);
 		return;
 	}
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 3d58e9b34553..017ea0ad9029 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -202,7 +202,7 @@ static void handle_tx(struct uart_port *port)
 		port->icount.tx++;
 		port->x_char = 0;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+	if (uart_tx_stopped_or_empty(port)) {
 		vt8500_stop_tx(port);
 		return;
 	}
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index b03d3e458ea2..217ef08de0ea 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -620,7 +620,7 @@ static void zs_raw_transmit_chars(struct zs_port *zport)
 	}
 
 	/* If nothing to do or stopped or hardware stopped.  */
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&zport->port)) {
+	if (uart_tx_stopped_or_empty(&zport->port)) {
 		zs_raw_stop_tx(zport);
 		return;
 	}
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2b78cc734719..ba62e14c0275 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -436,6 +436,11 @@ static inline int uart_tx_stopped(struct uart_port *port)
 	return 0;
 }
 
+static inline bool uart_tx_stopped_or_empty(struct uart_port *port)
+{
+	return uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port);
+}
+
 static inline bool uart_cts_enabled(struct uart_port *uport)
 {
 	return !!(uport->status & UPSTAT_CTS_ENABLE);
-- 
2.21.0

