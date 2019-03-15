Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FC7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895C8218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfCOJXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:23:43 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:45822 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:23:42 -0400
X-IronPort-AV: E=Sophos;i="5.58,481,1544511600"; 
   d="scan'208";a="25412863"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Mar 2019 02:23:41 -0700
Received: from rob-ult-m50855.microchip.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Fri, 15 Mar 2019 02:23:40 -0700
From:   Razvan Stefanescu <razvan.stefanescu@microchip.com>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] tty/serial: atmel: Add is_half_duplex helper
Date:   Fri, 15 Mar 2019 11:23:33 +0200
Message-ID: <20190315092334.13246-2-razvan.stefanescu@microchip.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190315092334.13246-1-razvan.stefanescu@microchip.com>
References: <20190315092334.13246-1-razvan.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a helper function to check that a port needs to use half duplex
communication, replacing several occurrences of multi-line bit checking.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 05147fe24343..a6577b1c4461 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -231,6 +231,13 @@ static inline void atmel_uart_write_char(struct uart_port *port, u8 value)
 	__raw_writeb(value, port->membase + ATMEL_US_THR);
 }
 
+static inline int atmel_uart_is_half_duplex(struct uart_port *port)
+{
+	return ((port->rs485.flags & SER_RS485_ENABLED) &&
+		!(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
+		(port->iso7816.flags & SER_ISO7816_ENABLED);
+}
+
 #ifdef CONFIG_SERIAL_ATMEL_PDC
 static bool atmel_use_pdc_rx(struct uart_port *port)
 {
@@ -608,10 +615,10 @@ static void atmel_stop_tx(struct uart_port *port)
 	/* Disable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
 
-	if (((port->rs485.flags & SER_RS485_ENABLED) &&
-	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
-	    port->iso7816.flags & SER_ISO7816_ENABLED)
-		atmel_start_rx(port);
+	if (atmel_uart_is_half_duplex(port))
+		if (!atomic_read(&atmel_port->tasklet_shutdown))
+			atmel_start_rx(port);
+
 }
 
 /*
@@ -628,9 +635,7 @@ static void atmel_start_tx(struct uart_port *port)
 		return;
 
 	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
-		if (((port->rs485.flags & SER_RS485_ENABLED) &&
-		     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
-		    port->iso7816.flags & SER_ISO7816_ENABLED)
+		if (atmel_uart_is_half_duplex(port))
 			atmel_stop_rx(port);
 
 	if (atmel_use_pdc_tx(port))
@@ -928,9 +933,7 @@ static void atmel_complete_tx_dma(void *arg)
 	 */
 	if (!uart_circ_empty(xmit))
 		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
-	else if (((port->rs485.flags & SER_RS485_ENABLED) &&
-		  !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
-		 port->iso7816.flags & SER_ISO7816_ENABLED) {
+	else if (atmel_uart_is_half_duplex(port)) {
 		/* DMA done, stop TX, start RX for RS485 */
 		atmel_start_rx(port);
 	}
@@ -1508,9 +1511,7 @@ static void atmel_tx_pdc(struct uart_port *port)
 		atmel_uart_writel(port, ATMEL_US_IER,
 				  atmel_port->tx_done_mask);
 	} else {
-		if (((port->rs485.flags & SER_RS485_ENABLED) &&
-		     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
-		    port->iso7816.flags & SER_ISO7816_ENABLED) {
+		if (atmel_uart_is_half_duplex(port)) {
 			/* DMA done, stop TX, start RX for RS485 */
 			atmel_start_rx(port);
 		}
-- 
2.19.1

