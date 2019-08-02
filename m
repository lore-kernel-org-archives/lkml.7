Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43C3C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC9A20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739535;
	bh=maFH+lZ97Q7cYs/7MGitG/H47gASfqsm+VozZzEakU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kf3cwp6ha08PQ48N2gC8lZ97xWOdpxpeMNWhmcyVPbgiJ75O8SBK2eahrMn4eqG7h
	 rcSimBM156hcZi5t1HZAfVPmwBoTnYr+kedNCd22xqM/ZaPlXrZLRvJzlFUbJ5X/+f
	 Wn4CFTtipNNDi9Yb6tTRUdf2AYMYuwFPwYozQ9hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405712AbfHBJwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392162AbfHBJwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:52:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E28B2064A;
        Fri,  2 Aug 2019 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739531;
        bh=maFH+lZ97Q7cYs/7MGitG/H47gASfqsm+VozZzEakU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCnBOVq5CVwcr2wKuT81u2mSbzwR0ZI6CGyyUrG9d+DnyoY42j55TUwYmqCZiNxGq
         Qsxxmnxv9BvicWqiAcFu1X/70nzVUC6VhIFGjJh9s5raJE4lYwPgItbzGTNzv2PwGf
         u+SOU/BKDeha/AwfXwhSWncMeDkicxutCzcW7gpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 188/223] serial: sh-sci: Fix TX DMA buffer flushing and workqueue races
Date:   Fri,  2 Aug 2019 11:36:53 +0200
Message-Id: <20190802092249.650244804@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8493eab02608b0e82f67b892aa72882e510c31d0 ]

When uart_flush_buffer() is called, the .flush_buffer() callback zeroes
the tx_dma_len field.  This may race with the work queue function
handling transmit DMA requests:

  1. If the buffer is flushed before the first DMA API call,
     dmaengine_prep_slave_single() may be called with a zero length,
     causing the DMA request to never complete, leading to messages
     like:

        rcar-dmac e7300000.dma-controller: Channel Address Error happen

     and, with debug enabled:

	sh-sci e6e88000.serial: sci_dma_tx_work_fn: ffff800639b55000: 0...0, cookie 126

     and DMA timeouts.

  2. If the buffer is flushed after the first DMA API call, but before
     the second, dma_sync_single_for_device() may be called with a zero
     length, causing the transmit data not to be flushed to RAM, and
     leading to stale data being output.

Fix this by:
  1. Letting sci_dma_tx_work_fn() return immediately if the transmit
     buffer is empty,
  2. Extending the critical section to cover all DMA preparational work,
     so tx_dma_len stays consistent for all of it,
  3. Using local copies of circ_buf.head and circ_buf.tail, to make sure
     they match the actual operation above.

Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Suggested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Link: https://lore.kernel.org/r/20190624123540.20629-2-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sh-sci.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8ec8b3bbaf25..ea35f5144237 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1291,6 +1291,7 @@ static void work_fn_tx(struct work_struct *work)
 	struct uart_port *port = &s->port;
 	struct circ_buf *xmit = &port->state->xmit;
 	dma_addr_t buf;
+	int head, tail;
 
 	/*
 	 * DMA is idle now.
@@ -1300,16 +1301,23 @@ static void work_fn_tx(struct work_struct *work)
 	 * consistent xmit buffer state.
 	 */
 	spin_lock_irq(&port->lock);
-	buf = s->tx_dma_addr + (xmit->tail & (UART_XMIT_SIZE - 1));
+	head = xmit->head;
+	tail = xmit->tail;
+	buf = s->tx_dma_addr + (tail & (UART_XMIT_SIZE - 1));
 	s->tx_dma_len = min_t(unsigned int,
-		CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
-		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE));
-	spin_unlock_irq(&port->lock);
+		CIRC_CNT(head, tail, UART_XMIT_SIZE),
+		CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE));
+	if (!s->tx_dma_len) {
+		/* Transmit buffer has been flushed */
+		spin_unlock_irq(&port->lock);
+		return;
+	}
 
 	desc = dmaengine_prep_slave_single(chan, buf, s->tx_dma_len,
 					   DMA_MEM_TO_DEV,
 					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
+		spin_unlock_irq(&port->lock);
 		dev_warn(port->dev, "Failed preparing Tx DMA descriptor\n");
 		/* switch to PIO */
 		sci_tx_dma_release(s, true);
@@ -1319,20 +1327,20 @@ static void work_fn_tx(struct work_struct *work)
 	dma_sync_single_for_device(chan->device->dev, buf, s->tx_dma_len,
 				   DMA_TO_DEVICE);
 
-	spin_lock_irq(&port->lock);
 	desc->callback = sci_dma_tx_complete;
 	desc->callback_param = s;
-	spin_unlock_irq(&port->lock);
 	s->cookie_tx = dmaengine_submit(desc);
 	if (dma_submit_error(s->cookie_tx)) {
+		spin_unlock_irq(&port->lock);
 		dev_warn(port->dev, "Failed submitting Tx DMA descriptor\n");
 		/* switch to PIO */
 		sci_tx_dma_release(s, true);
 		return;
 	}
 
+	spin_unlock_irq(&port->lock);
 	dev_dbg(port->dev, "%s: %p: %d...%d, cookie %d\n",
-		__func__, xmit->buf, xmit->tail, xmit->head, s->cookie_tx);
+		__func__, xmit->buf, tail, head, s->cookie_tx);
 
 	dma_async_issue_pending(chan);
 }
-- 
2.20.1



