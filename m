Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B448EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C84B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368384;
	bh=jSfbDRBJTcVDcYUM5/94gF+Vsl1cRMW8o6nevomE220=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Afe8I1zR3OQQijONPxjzs05yp8sagqe2kVCxZ1j6oQetanezw9xrLmjMJO+kQh0+H
	 sqxjP1wnpddXqeRLKIr6kLU9shft7mygLzVkfyeF7Y7c8QgmIM8ezZd9YTTuRLTEjE
	 B+YvtmxDE4HqAjSpFN9EH4oc7OSmZBhQJ04hmuLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbfDDI7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbfDDI7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:59:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 749D920652;
        Thu,  4 Apr 2019 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368380;
        bh=jSfbDRBJTcVDcYUM5/94gF+Vsl1cRMW8o6nevomE220=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLaym5OK2v0hQtFJZOxzoZt/+Rd7apthueyBVxgVEiCZ7VfDCP/l6l1+rk1zbB9Qs
         T+JIK6/E55GaL3A3g6PKsqixK+LmlThA1ynI04ylN6UCLimRjNIeBTgu0bE0vH5Ate
         KcMvtBbd+cNBKfIItBHys+FOtEV4hmLPofgi3Ce0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 4.19 003/187] tty/serial: atmel: Add is_half_duplex helper
Date:   Thu,  4 Apr 2019 10:45:40 +0200
Message-Id: <20190404084603.265124773@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Razvan Stefanescu <razvan.stefanescu@microchip.com>

commit f3040983132bf3477acd45d2452a906e67c2fec9 upstream.

Use a helper function to check that a port needs to use half duplex
communication, replacing several occurrences of multi-line bit checking.

Fixes: b389f173aaa1 ("tty/serial: atmel: RS485 half duplex w/DMA: enable RX after TX is done")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/tty/serial/atmel_serial.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -225,6 +225,12 @@ static inline void atmel_uart_write_char
 	__raw_writeb(value, port->membase + ATMEL_US_THR);
 }
 
+static inline int atmel_uart_is_half_duplex(struct uart_port *port)
+{
+	return (port->rs485.flags & SER_RS485_ENABLED) &&
+		!(port->rs485.flags & SER_RS485_RX_DURING_TX);
+}
+
 #ifdef CONFIG_SERIAL_ATMEL_PDC
 static bool atmel_use_pdc_rx(struct uart_port *port)
 {
@@ -481,9 +487,9 @@ static void atmel_stop_tx(struct uart_po
 	/* Disable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
 
-	if ((port->rs485.flags & SER_RS485_ENABLED) &&
-	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+	if (atmel_uart_is_half_duplex(port))
 		atmel_start_rx(port);
+
 }
 
 /*
@@ -500,8 +506,7 @@ static void atmel_start_tx(struct uart_p
 		return;
 
 	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
-		if ((port->rs485.flags & SER_RS485_ENABLED) &&
-		    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		if (atmel_uart_is_half_duplex(port))
 			atmel_stop_rx(port);
 
 	if (atmel_use_pdc_tx(port))
@@ -799,8 +804,7 @@ static void atmel_complete_tx_dma(void *
 	 */
 	if (!uart_circ_empty(xmit))
 		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
-	else if ((port->rs485.flags & SER_RS485_ENABLED) &&
-		 !(port->rs485.flags & SER_RS485_RX_DURING_TX)) {
+	else if (atmel_uart_is_half_duplex(port)) {
 		/* DMA done, stop TX, start RX for RS485 */
 		atmel_start_rx(port);
 	}
@@ -1377,8 +1381,7 @@ static void atmel_tx_pdc(struct uart_por
 		atmel_uart_writel(port, ATMEL_US_IER,
 				  atmel_port->tx_done_mask);
 	} else {
-		if ((port->rs485.flags & SER_RS485_ENABLED) &&
-		    !(port->rs485.flags & SER_RS485_RX_DURING_TX)) {
+		if (atmel_uart_is_half_duplex(port)) {
 			/* DMA done, stop TX, start RX for RS485 */
 			atmel_start_rx(port);
 		}


