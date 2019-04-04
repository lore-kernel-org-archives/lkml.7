Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14A7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F59B206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371858;
	bh=orIsEuPyTU9mJ0Pkc+x3IwhpkiEh3sF96UUwFFtKiXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CraVg+bTUH3ODIKDpk6RPifksuATvsgf4KqxfRuQ9GxZAt34o2Ys0+o0ho7YIXE/u
	 GJa2DLZfub05gzZiSksJnYRrrQhujKKDol20xlBMSyFokLMGRDYVip8carPeEMk8JX
	 e/Ygx0pZHRqVFDYI9s0X2SV07Glhh/+C5S5zKUQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfDDIuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbfDDIt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:49:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1973C2171F;
        Thu,  4 Apr 2019 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367796;
        bh=orIsEuPyTU9mJ0Pkc+x3IwhpkiEh3sF96UUwFFtKiXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWcBgCuueAcIhIUQ8bYTPMZoDFDDA/iUlpAB6FoX7GN2Rqi6gB0SAlsub34ZHxPUx
         fM2wqPBM3cHFb1LcItS29W+Jwg2BWjmpwcMQ05oV2Wt1dSFmNMjGq/7pw/P032V7xx
         gRbT//ydxV7hEaqe+l92lyFHq22OeXwKS35tun3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 4.9 05/91] tty/serial: atmel: Add is_half_duplex helper
Date:   Thu,  4 Apr 2019 10:46:49 +0200
Message-Id: <20190404084535.730559869@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -241,6 +241,12 @@ static inline void atmel_uart_write_char
 
 #endif
 
+static inline int atmel_uart_is_half_duplex(struct uart_port *port)
+{
+	return (port->rs485.flags & SER_RS485_ENABLED) &&
+		!(port->rs485.flags & SER_RS485_RX_DURING_TX);
+}
+
 #ifdef CONFIG_SERIAL_ATMEL_PDC
 static bool atmel_use_pdc_rx(struct uart_port *port)
 {
@@ -492,9 +498,9 @@ static void atmel_stop_tx(struct uart_po
 	/* Disable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
 
-	if ((port->rs485.flags & SER_RS485_ENABLED) &&
-	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+	if (atmel_uart_is_half_duplex(port))
 		atmel_start_rx(port);
+
 }
 
 /*
@@ -511,8 +517,7 @@ static void atmel_start_tx(struct uart_p
 		return;
 
 	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
-		if ((port->rs485.flags & SER_RS485_ENABLED) &&
-		    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		if (atmel_uart_is_half_duplex(port))
 			atmel_stop_rx(port);
 
 	if (atmel_use_pdc_tx(port))
@@ -809,8 +814,7 @@ static void atmel_complete_tx_dma(void *
 	 */
 	if (!uart_circ_empty(xmit))
 		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
-	else if ((port->rs485.flags & SER_RS485_ENABLED) &&
-		 !(port->rs485.flags & SER_RS485_RX_DURING_TX)) {
+	else if (atmel_uart_is_half_duplex(port)) {
 		/* DMA done, stop TX, start RX for RS485 */
 		atmel_start_rx(port);
 	}
@@ -1386,8 +1390,7 @@ static void atmel_tx_pdc(struct uart_por
 		atmel_uart_writel(port, ATMEL_US_IER,
 				  atmel_port->tx_done_mask);
 	} else {
-		if ((port->rs485.flags & SER_RS485_ENABLED) &&
-		    !(port->rs485.flags & SER_RS485_RX_DURING_TX)) {
+		if (atmel_uart_is_half_duplex(port)) {
 			/* DMA done, stop TX, start RX for RS485 */
 			atmel_start_rx(port);
 		}


