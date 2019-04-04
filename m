Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D263C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2244621734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367803;
	bh=BUhGl3KWnf8PiX+KzQP+NM0FQK9U41FNxo0fyq2YGgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tYtgatugLhEG+V9u/f+d/0rzdsrFZ64uRcZZL3gLDBYN2KVeWHJ9a5bP7ZNEOYiZi
	 OAr7JcBODtgJfvFeSVEgOiArCmjOuTwAyxobTvS+MMqtAzYy7da+11XNVwK+AqiENz
	 zF5z55xSoK6nuBvZS3LFBhI9CUjJ+JIu+iQTZCvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfDDIuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfDDIuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:50:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65042171F;
        Thu,  4 Apr 2019 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367799;
        bh=BUhGl3KWnf8PiX+KzQP+NM0FQK9U41FNxo0fyq2YGgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+VEMhbzLs3egYzUsro2EHV3eyRGR3w0MNIt+roApc2NnTBM62wKkMSwYF5GOJLnx
         5u3da47JbVqz2fmllhWnsUDw8u4jelvo084gJQAGkqWyai5tQeDEwEHJWpQtDLZjHq
         L01NnsIXufdPLCV+PuI47f3A3tLyy9x1SoUvapGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 4.9 06/91] tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped
Date:   Thu,  4 Apr 2019 10:46:50 +0200
Message-Id: <20190404084535.784149222@linuxfoundation.org>
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

commit 69646d7a3689fbe1a65ae90397d22ac3f1b8d40f upstream.

In half-duplex operation, RX should be started after TX completes.

If DMA is used, there is a case when the DMA transfer completes but the
TX FIFO is not emptied, so the RX cannot be restarted just yet.

Use a boolean variable to store this state and rearm TX interrupt mask
to be signaled again that the transfer finished. In interrupt transmit
handler this variable is used to start RX. A warning message is generated
if RX is activated before TX fifo is cleared.

Fixes: b389f173aaa1 ("tty/serial: atmel: RS485 half duplex w/DMA: enable
RX after TX is done")
Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/atmel_serial.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -175,6 +175,8 @@ struct atmel_uart_port {
 	unsigned int		pending_status;
 	spinlock_t		lock_suspended;
 
+	bool			hd_start_rx;	/* can start RX during half-duplex operation */
+
 	int (*prepare_rx)(struct uart_port *port);
 	int (*prepare_tx)(struct uart_port *port);
 	void (*schedule_rx)(struct uart_port *port);
@@ -815,8 +817,13 @@ static void atmel_complete_tx_dma(void *
 	if (!uart_circ_empty(xmit))
 		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
 	else if (atmel_uart_is_half_duplex(port)) {
-		/* DMA done, stop TX, start RX for RS485 */
-		atmel_start_rx(port);
+		/*
+		 * DMA done, re-enable TXEMPTY and signal that we can stop
+		 * TX and start RX for RS485
+		 */
+		atmel_port->hd_start_rx = true;
+		atmel_uart_writel(port, ATMEL_US_IER,
+				  atmel_port->tx_done_mask);
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -1261,9 +1268,20 @@ atmel_handle_transmit(struct uart_port *
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
 	if (pending & atmel_port->tx_done_mask) {
-		/* Either PDC or interrupt transmission */
 		atmel_uart_writel(port, ATMEL_US_IDR,
 				  atmel_port->tx_done_mask);
+
+		/* Start RX if flag was set and FIFO is empty */
+		if (atmel_port->hd_start_rx) {
+			if (!(atmel_uart_readl(port, ATMEL_US_CSR)
+					& ATMEL_US_TXEMPTY))
+				dev_warn(port->dev, "Should start RX, but TX fifo is not empty\n");
+
+			atmel_port->hd_start_rx = false;
+			atmel_start_rx(port);
+			return;
+		}
+
 		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
 	}
 }


