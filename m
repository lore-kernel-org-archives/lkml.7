Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFE1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D47321905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126274;
	bh=QVyhPioUa5lmNvEIf7vChFK+1M3i3R5wyT007+FyYeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1AbAD2Kf12g2zH4Z+VrPm434pHPzrT9wOGLaaUSXjkVccair58J44WDg+LMtIyIkQ
	 gVayH3o/VMkDMK0vhmSo7+D31NfGWfjLHUt+rOEoYdVoCMJ/IpJTb9krccmnWM+Zyo
	 jyCwA9P0cMa30YSX2r1ffuTgTtKOcac3BbCpVIHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbfDXRRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388721AbfDXRRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:17:50 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506C22054F;
        Wed, 24 Apr 2019 17:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126269;
        bh=QVyhPioUa5lmNvEIf7vChFK+1M3i3R5wyT007+FyYeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J/KTIgek6DRR6w3+Sv1lyU8Yy94NQCyMXqrfCE85X4SB5TTQECuGDOsu6dLx/jVdK
         yOy9WzUGE9lEFR9u0eh8/N5Wp3gvv2ZNJuWNJw2pgtinQXFclF7dGLCAXHeOUjsV8t
         NMkSk36z5PvygqrF7RQXG5x8LCno+T2eIW36JqJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 4.4 009/168] tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped
Date:   Wed, 24 Apr 2019 19:07:33 +0200
Message-Id: <20190424170924.038041486@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
@@ -169,6 +169,8 @@ struct atmel_uart_port {
 	unsigned int		pending_status;
 	spinlock_t		lock_suspended;
 
+	bool			hd_start_rx;	/* can start RX during half-duplex operation */
+
 	int (*prepare_rx)(struct uart_port *port);
 	int (*prepare_tx)(struct uart_port *port);
 	void (*schedule_rx)(struct uart_port *port);
@@ -816,8 +818,13 @@ static void atmel_complete_tx_dma(void *
 	if (!uart_circ_empty(xmit))
 		tasklet_schedule(&atmel_port->tasklet);
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
@@ -1257,9 +1264,20 @@ atmel_handle_transmit(struct uart_port *
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
 		tasklet_schedule(&atmel_port->tasklet);
 	}
 }


