Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D9C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27F6214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575988667;
	bh=hiqG73s0FfgJlanKoxcRRqMIQC1jsCBN06gULizwK5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C/KqJVB810m85bWkTdXdkV46uIUDcSE2HfNnv6GumqYlNYtuTC56W9oUMYD9wVFxm
	 MPNMt5e59Rca8iOzzOU8Dnco4CBUbI+4Rg5v0Bt/3U7K+5Axx3t6MzND7EmmUMx5v0
	 RJoYCwy5lULAzmCJSQCXRpKG44MU/jMBBUAlkDhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfLJOhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbfLJOhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:37:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A87D12077B;
        Tue, 10 Dec 2019 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988652;
        bh=hiqG73s0FfgJlanKoxcRRqMIQC1jsCBN06gULizwK5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bm7O0pOZrPlK5/U4l2nkbcPQbWieRX5703x1CFthL7hu5txzJQ0B162fX/3+vQv9X
         42kzdL0HwxC4SItQ8Pa8MgUVRMeoAa9VMH2/T6qIbJJSOpCis1Xtg0hfxrCAxopClc
         vOoSvg028GQxlu11EJVFfaYUr51oo1W8cbSNXQCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] tty: serial: samsung_tty: use standard debugging macros
Date:   Tue, 10 Dec 2019 15:37:03 +0100
Message-Id: <20191210143706.3928480-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dbg() macro for the driver is not needed at all, all drivers should
use the common dynamic debugging infrastructure, not roll their own.  So
delete the custom macro and convert the driver to use dev_dbg() instead,
providing a lot more information than the previous macro provided.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 78 ++++++++++++--------------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 37749f09066d..12f6b2872076 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -46,28 +46,6 @@
 #include <linux/of.h>
 #include <asm/irq.h>
 
-#if	defined(CONFIG_SERIAL_SAMSUNG_DEBUG) &&	\
-	!defined(MODULE)
-
-extern void printascii(const char *);
-
-__printf(1, 2)
-static void dbg(const char *fmt, ...)
-{
-	va_list va;
-	char buff[256];
-
-	va_start(va, fmt);
-	vscnprintf(buff, sizeof(buff), fmt, va);
-	va_end(va);
-
-	printascii(buff);
-}
-
-#else
-#define dbg(fmt, ...) do { if (0) no_printk(fmt, ##__VA_ARGS__); } while (0)
-#endif
-
 /* UART name and device definitions */
 
 #define S3C24XX_SERIAL_NAME	"ttySAC"
@@ -517,7 +495,7 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 	unsigned int received;
 
 	if (rx_enabled(port)) {
-		dbg("s3c24xx_serial_stop_rx: port=%p\n", port);
+		dev_dbg(port->dev, "stopping rx\n");
 		if (s3c24xx_serial_has_interrupt_mask(port))
 			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD,
 					S3C64XX_UINTM);
@@ -768,12 +746,13 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 		port->icount.rx++;
 
 		if (unlikely(uerstat & S3C2410_UERSTAT_ANY)) {
-			dbg("rxerr: port ch=0x%02x, rxs=0x%08x\n",
-			    ch, uerstat);
+			dev_dbg(port->dev,
+				"rxerr: port ch=0x%02x, rxs=0x%08x\n",
+				ch, uerstat);
 
 			/* check for break */
 			if (uerstat & S3C2410_UERSTAT_BREAK) {
-				dbg("break!\n");
+				dev_dbg(port->dev, "break!\n");
 				port->icount.brk++;
 				if (uart_handle_break(port))
 					continue; /* Ignore character */
@@ -1148,7 +1127,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 
 	ourport->rx_claimed = 1;
 
-	dbg("requesting tx irq...\n");
+	dev_dbg(port->dev, "requesting tx irq...\n");
 
 	tx_enabled(port) = 1;
 
@@ -1433,29 +1412,30 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 
 		if (cfg->has_fracval) {
 			udivslot = (div & 15);
-			dbg("fracval = %04x\n", udivslot);
+			dev_dbg(port->dev, "fracval = %04x\n", udivslot);
 		} else {
 			udivslot = udivslot_table[div & 15];
-			dbg("udivslot = %04x (div %d)\n", udivslot, div & 15);
+			dev_dbg(port->dev, "udivslot = %04x (div %d)\n",
+				udivslot, div & 15);
 		}
 	}
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
-		dbg("config: 5bits/char\n");
+		dev_dbg(port->dev, "config: 5bits/char\n");
 		ulcon = S3C2410_LCON_CS5;
 		break;
 	case CS6:
-		dbg("config: 6bits/char\n");
+		dev_dbg(port->dev, "config: 6bits/char\n");
 		ulcon = S3C2410_LCON_CS6;
 		break;
 	case CS7:
-		dbg("config: 7bits/char\n");
+		dev_dbg(port->dev, "config: 7bits/char\n");
 		ulcon = S3C2410_LCON_CS7;
 		break;
 	case CS8:
 	default:
-		dbg("config: 8bits/char\n");
+		dev_dbg(port->dev, "config: 8bits/char\n");
 		ulcon = S3C2410_LCON_CS8;
 		break;
 	}
@@ -1477,8 +1457,9 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	dbg("setting ulcon to %08x, brddiv to %d, udivslot %08x\n",
-	    ulcon, quot, udivslot);
+	dev_dbg(port->dev,
+		"setting ulcon to %08x, brddiv to %d, udivslot %08x\n",
+		ulcon, quot, udivslot);
 
 	wr_regl(port, S3C2410_ULCON, ulcon);
 	wr_regl(port, S3C2410_UBRDIV, quot);
@@ -1499,10 +1480,11 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	if (ourport->info->has_divslot)
 		wr_regl(port, S3C2443_DIVSLOT, udivslot);
 
-	dbg("uart: ulcon = 0x%08x, ucon = 0x%08x, ufcon = 0x%08x\n",
-	    rd_regl(port, S3C2410_ULCON),
-	    rd_regl(port, S3C2410_UCON),
-	    rd_regl(port, S3C2410_UFCON));
+	dev_dbg(port->dev,
+		"uart: ulcon = 0x%08x, ucon = 0x%08x, ufcon = 0x%08x\n",
+		rd_regl(port, S3C2410_ULCON),
+		rd_regl(port, S3C2410_UCON),
+		rd_regl(port, S3C2410_UFCON));
 
 	/*
 	 * Update the per-port timeout.
@@ -1877,7 +1859,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	port->uartclk = 1;
 
 	if (cfg->uart_flags & UPF_CONS_FLOW) {
-		dbg("s3c24xx_serial_init_port: enabling flow control\n");
+		dev_dbg(port->dev, "enabling flow control\n");
 		port->flags |= UPF_CONS_FLOW;
 	}
 
@@ -1889,7 +1871,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		return -EINVAL;
 	}
 
-	dbg("resource %pR)\n", res);
+	dev_dbg(port->dev, "resource %pR)\n", res);
 
 	port->membase = devm_ioremap(port->dev, res->start, resource_size(res));
 	if (!port->membase) {
@@ -1951,9 +1933,9 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		wr_regl(port, S3C64XX_UINTSP, 0xf);
 	}
 
-	dbg("port: map=%pa, mem=%p, irq=%d (%d,%d), clock=%u\n",
-	    &port->mapbase, port->membase, port->irq,
-	    ourport->rx_irq, ourport->tx_irq, port->uartclk);
+	dev_dbg(port->dev, "port: map=%pa, mem=%p, irq=%d (%d,%d), clock=%u\n",
+		&port->mapbase, port->membase, port->irq,
+		ourport->rx_irq, ourport->tx_irq, port->uartclk);
 
 	/* reset the fifos (and setup the uart) */
 	s3c24xx_serial_resetport(port, cfg);
@@ -2034,7 +2016,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	ourport->min_dma_size = max_t(int, ourport->port.fifosize,
 				    dma_get_cache_alignment());
 
-	dbg("%s: initialising port %p...\n", __func__, ourport);
+	dev_dbg(&pdev->dev, "%s: initialising port %p...\n", __func__, ourport);
 
 	ret = s3c24xx_serial_init_port(ourport, pdev);
 	if (ret < 0)
@@ -2048,7 +2030,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		}
 	}
 
-	dbg("%s: adding port\n", __func__);
+	dev_dbg(&pdev->dev, "%s: adding port\n", __func__);
 	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
 	platform_set_drvdata(pdev, &ourport->port);
 
@@ -2303,7 +2285,7 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 			rate = 1;
 
 		*baud = rate / (16 * (ubrdiv + 1));
-		dbg("calculated baud %d\n", *baud);
+		dev_dbg(port->dev, "calculated baud %d\n", *baud);
 	}
 
 }
@@ -2341,7 +2323,7 @@ s3c24xx_serial_console_setup(struct console *co, char *options)
 	else
 		s3c24xx_serial_get_options(port, &baud, &parity, &bits);
 
-	dbg("s3c24xx_serial_console_setup: baud %d\n", baud);
+	dev_dbg(port->dev, "baud %d\n", baud);
 
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
-- 
2.24.0

