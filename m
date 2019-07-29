Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B5AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB435204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzBZ4AoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404193AbfG2T7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:59:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37900 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403833AbfG2TxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so19952088pgu.5;
        Mon, 29 Jul 2019 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pnK0if51KXMKhoheOjr16G8DGP2DVU3TWBFZUkwNGFE=;
        b=jzBZ4AoZyy9fVJ26Bz7HbZq3F3BqpbAqT0402mX50dD5LoUHqCq0xe3EqAwxSgr1Cz
         hgJ/NxfCPvfcz4bupq7O96j42+WeJ8tyanaXFga6M+hZ6ES++IIHcHkP/yrs1US8y0N2
         nxrEIcuaB0uu65dvUce/wchAPRbcbN9n8tcV4vBCZ+mGRr2wMCOYtXWpvl/Aon4RC6Xj
         TPHuqPbJztg5VIWhoHrYM0xc7XCH4PVnI+IbXqWruz3ref0BhLdkmxGamrtGa7C7vJtr
         Mu+m50JsVlqoNxLEXxyECRLH2WygEndWHln/jQO5e+eTEo6zroaJ8bVSqAbOWzLQvjPi
         MOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pnK0if51KXMKhoheOjr16G8DGP2DVU3TWBFZUkwNGFE=;
        b=AA8zi82x16tepb/VcvJMWq5mBIpuGxsKwcNM2VZeOYzF27Jc3/lBuPEO7hJZ7rhL5d
         6LNHM1Mub/+5M9b5Pvmdp1p3ZJlpQHkAUJCh8X6PRhBFsX9BzQIXY9MC3TSesCtAfUiA
         WK0IdM90SOAJh/VxhUmV7FZZJcReFSytX1HZqC9eBRAHlopZS4s4uhuWWldxwcBn3R+0
         BRi4p/dkbnYJBHkz/7+5CdMPa7jX/JgLNomKIe4SU6l3UHezfShsefAsJxPsCBV/HesB
         +Qe3ZiW77p/YqmrblqP+P+KcPqEE6mGLNotiL8RkZ/T/PiIysGoPj6lKvnnZATf5t5uF
         KWtg==
X-Gm-Message-State: APjAAAWe4y+x/5YSZ7ruM2CBrhqjuRnyJrgaUG7W2L+VcO3VykeodyiU
        npiRczI66JvlLp/6sB7imi9v9MYf
X-Google-Smtp-Source: APXvYqzHzZHnQ4GpnsxSqEXYJ+eqdJYtSYPAAgqk+n4/QxSPo629qG29kCAYi50R9Wbs/lQsKHwhOw==
X-Received: by 2002:a05:6a00:c7:: with SMTP id e7mr38170155pfj.52.1564429988105;
        Mon, 29 Jul 2019 12:53:08 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:07 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/24] tty: serial: fsl_lpuart: Introduce lpuart_stopped_or_empty()
Date:   Mon, 29 Jul 2019 12:52:18 -0700
Message-Id: <20190729195226.8862-17-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for

    uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)

appears in multiple places in the driver. Move it into a helper
function.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 7a0f96952291..a090b93211e3 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -451,6 +451,11 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 	dma_async_issue_pending(sport->dma_tx_chan);
 }
 
+static bool lpuart_stopped_or_empty(struct uart_port *port)
+{
+	return uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port);
+}
+
 static void lpuart_dma_tx_complete(void *arg)
 {
 	struct lpuart_port *sport = arg;
@@ -478,7 +483,7 @@ static void lpuart_dma_tx_complete(void *arg)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&sport->port))
+	if (!lpuart_stopped_or_empty(&sport->port))
 		lpuart_dma_tx(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -679,7 +684,7 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+	if (lpuart_stopped_or_empty(&sport->port)) {
 		lpuart_stop_tx(&sport->port);
 		return;
 	}
@@ -710,7 +715,7 @@ static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+	if (lpuart_stopped_or_empty(&sport->port)) {
 		lpuart32_stop_tx(&sport->port);
 		return;
 	}
@@ -738,14 +743,13 @@ static void lpuart_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned char temp;
 
 	temp = readb(port->membase + UARTCR2);
 	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
 
 	if (sport->lpuart_dma_tx_use) {
-		if (!uart_circ_empty(xmit) && !uart_tx_stopped(port))
+		if (!lpuart_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
 		if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
@@ -756,11 +760,10 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long temp;
 
 	if (sport->lpuart_dma_tx_use) {
-		if (!uart_circ_empty(xmit) && !uart_tx_stopped(port))
+		if (!lpuart_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
 		temp = lpuart32_read(port, UARTCTRL);
-- 
2.21.0

