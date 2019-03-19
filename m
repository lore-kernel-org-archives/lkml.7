Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615C1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391C520854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCSNUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:20:42 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:31053 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfCSNUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:20:40 -0400
X-IronPort-AV: E=Sophos;i="5.58,498,1544511600"; 
   d="scan'208";a="29630298"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Mar 2019 06:20:39 -0700
Received: from rob-ult-m50855.microchip.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Tue, 19 Mar 2019 06:20:39 -0700
From:   Razvan Stefanescu <razvan.stefanescu@microchip.com>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
CC:     Gil Weber <webergil@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] tty/serial: atmel: Add is_half_duplex helper
Date:   Tue, 19 Mar 2019 15:20:34 +0200
Message-ID: <20190319132035.18481-2-razvan.stefanescu@microchip.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190319132035.18481-1-razvan.stefanescu@microchip.com>
References: <20190319132035.18481-1-razvan.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a helper function to check that a port needs to use half duplex
communication, replacing several occurrences of multi-line bit checking.

Fixes: b389f173aaa1 ("tty/serial: atmel: RS485 half duplex w/DMA: enable
RX after TX is done")
Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
---
Changelog:
v2: 
  - remove extra check
  - add fix info

 drivers/tty/serial/atmel_serial.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 05147fe24343..b4b89a16a41b 100644
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
@@ -608,10 +615,9 @@ static void atmel_stop_tx(struct uart_port *port)
 	/* Disable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
 
-	if (((port->rs485.flags & SER_RS485_ENABLED) &&
-	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
-	    port->iso7816.flags & SER_ISO7816_ENABLED)
+	if (atmel_uart_is_half_duplex(port))
 		atmel_start_rx(port);
+
 }
 
 /*
@@ -628,9 +634,7 @@ static void atmel_start_tx(struct uart_port *port)
 		return;
 
 	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
-		if (((port->rs485.flags & SER_RS485_ENABLED) &&
-		     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
-		    port->iso7816.flags & SER_ISO7816_ENABLED)
+		if (atmel_uart_is_half_duplex(port))
 			atmel_stop_rx(port);
 
 	if (atmel_use_pdc_tx(port))
@@ -928,9 +932,7 @@ static void atmel_complete_tx_dma(void *arg)
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
@@ -1508,9 +1510,7 @@ static void atmel_tx_pdc(struct uart_port *port)
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

