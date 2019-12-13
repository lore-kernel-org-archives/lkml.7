Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5534CC50731
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AE224704
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfLMOET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:04:19 -0500
Received: from mail.sysgo.com ([176.9.12.79]:58710 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfLMOES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 09:04:18 -0500
From:   David Engraf <david.engraf@sysgo.com>
To:     richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Engraf <david.engraf@sysgo.com>
Subject: [PATCH v2] tty/serial: atmel: fix out of range clock divider handling
Date:   Fri, 13 Dec 2019 15:03:01 +0100
Message-Id: <20191213140301.16490-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1e2e3f63-84db-4b38-1bf1-85916116e0a2@sysgo.com>
References: <1e2e3f63-84db-4b38-1bf1-85916116e0a2@sysgo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MCK_DIV8 when the clock divider is > 65535. Unfortunately the mode
register was already written thus the clock selection is ignored.

Fix by doing the baud rate calulation before setting the mode.

Fixes: 5bf5635ac170 ("tty/serial: atmel: add fractional baud rate support")
Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 drivers/tty/serial/atmel_serial.c | 43 ++++++++++++++++---------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a8dc8af83f39..1ba9bc667e13 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2270,27 +2270,6 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		mode |= ATMEL_US_USMODE_NORMAL;
 	}
 
-	/* set the mode, clock divisor, parity, stop bits and data size */
-	atmel_uart_writel(port, ATMEL_US_MR, mode);
-
-	/*
-	 * when switching the mode, set the RTS line state according to the
-	 * new mode, otherwise keep the former state
-	 */
-	if ((old_mode & ATMEL_US_USMODE) != (mode & ATMEL_US_USMODE)) {
-		unsigned int rts_state;
-
-		if ((mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_HWHS) {
-			/* let the hardware control the RTS line */
-			rts_state = ATMEL_US_RTSDIS;
-		} else {
-			/* force RTS line to low level */
-			rts_state = ATMEL_US_RTSEN;
-		}
-
-		atmel_uart_writel(port, ATMEL_US_CR, rts_state);
-	}
-
 	/*
 	 * Set the baud rate:
 	 * Fractional baudrate allows to setup output frequency more
@@ -2317,6 +2296,28 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
 		atmel_uart_writel(port, ATMEL_US_BRGR, quot);
+
+	/* set the mode, clock divisor, parity, stop bits and data size */
+	atmel_uart_writel(port, ATMEL_US_MR, mode);
+
+	/*
+	 * when switching the mode, set the RTS line state according to the
+	 * new mode, otherwise keep the former state
+	 */
+	if ((old_mode & ATMEL_US_USMODE) != (mode & ATMEL_US_USMODE)) {
+		unsigned int rts_state;
+
+		if ((mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_HWHS) {
+			/* let the hardware control the RTS line */
+			rts_state = ATMEL_US_RTSDIS;
+		} else {
+			/* force RTS line to low level */
+			rts_state = ATMEL_US_RTSEN;
+		}
+
+		atmel_uart_writel(port, ATMEL_US_CR, rts_state);
+	}
+
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
 	atmel_port->tx_stopped = false;
-- 
2.17.1

