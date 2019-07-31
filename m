Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D175AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A075420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+Xf3lUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfGaRb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35714 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbfGaRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so32277087pfn.2;
        Wed, 31 Jul 2019 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkEZ06b+2pjJY+GWngQZPpWgfZ7FTlmFypQFjS2AHew=;
        b=K+Xf3lUZoinDumtRrh1bU50SQZOmMv880ajEJtPjI3u/WyG8dsNlquBb0zttdjAdEf
         AaYb8gJ+eNvDcmUkBjTLGCLotTMt+f2SvKnYBKdrXIf+yrRSJsJeOO9M9tb8pLIvbB5K
         lXqoas33Qcbz/KVTcSU7wrX+nrWrqJk3iLUSk/FqvVEZ8CGTeKN/XXelJ/CAAqheHJVW
         hFZhMsTgN1yXZOXvTr24OyddZcPSXnwJjFmeGMUmebm3cXk7LAPPJgdd7wtXTs5G+N/3
         8vP+vDoXPomFfYZPqO7R5FuFMvw07VtvJqD64XXUw35kk361CsU9lUBqRtGpTumGV/1F
         9tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkEZ06b+2pjJY+GWngQZPpWgfZ7FTlmFypQFjS2AHew=;
        b=sQGImQ2tHRny4+OBB7g91ewJTfh9PpgSGw3xtHwnnnc679Fvi0MxQp4pnq5VQH1soI
         OljdAqUPWpGxnV0qL8PpX3HeCpRi/MkeWnDl2AxWQnXtFTi5CNu3u7ziZCnlx52aUX5E
         CXjeA5sRVocaWHOJ02arT7isRYKP570seKcwWpLWRbnNYxPXLS/EYuxUoiEpz53RCZ+6
         RyWQP6H7pwFLNtMp4QGJNqdeaE/363Clh6SfQTf+V4Ql94Xn4NTl75xF0E/FKKw4vE+S
         aU6O7R3KZz+LyBsDCwp0U/RsXIvkYoJKLpsQ89xfHZ1omX8GpEZHUc1myD5Kr24/hGoH
         4YOQ==
X-Gm-Message-State: APjAAAU4RDDY4RJ2t8G8GANg7ZC6m3LoGmenQjJA0oMcLhpbPEDHZng4
        kQ8fTJD3W+kZ1sUSTOUPmx4bUHx+hkk=
X-Google-Smtp-Source: APXvYqzGXYXYxxdsSzsA7byfoGsoqzuWJb9BJJSff+/cBI0g7jx8vneW1POd/QOZrm+kHiimYulpeQ==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr48908361pfv.195.1564594283695;
        Wed, 31 Jul 2019 10:31:23 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:23 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/23] tty: serial: fls_lpuart: Split shared TX IRQ handler into two
Date:   Wed, 31 Jul 2019 10:30:30 -0700
Message-Id: <20190731173045.11718-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While sharing code for Tx interrupt handler between 8 and 32 bit
variant of the peripheral saves a bit of code duplication it also adds
quite a number of lpuart_is_32() checks which makes it harder to
understand. Move shared bits back into corresponding
lpuart*_transmit_buffer functions, split lpuart_txint into
lpuart_txint and lpuart32_txint so we can drop all extra
lpuart_is_32() check and make the code flow more linear.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 61 +++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 8657addbfd1c..ed6d3f836c93 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -663,6 +663,18 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 {
 	struct circ_buf *xmit = &sport->port.state->xmit;
 
+	if (sport->port.x_char) {
+		writeb(sport->port.x_char, sport->port.membase + UARTDR);
+		sport->port.icount.tx++;
+		sport->port.x_char = 0;
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+		lpuart_stop_tx(&sport->port);
+		return;
+	}
+
 	while (!uart_circ_empty(xmit) &&
 		(readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size)) {
 		writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
@@ -682,6 +694,18 @@ static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long txcnt;
 
+	if (sport->port.x_char) {
+		lpuart32_write(&sport->port, sport->port.x_char, UARTDATA);
+		sport->port.icount.tx++;
+		sport->port.x_char = 0;
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
+		lpuart32_stop_tx(&sport->port);
+		return;
+	}
+
 	txcnt = lpuart32_read(&sport->port, UARTWATER);
 	txcnt = txcnt >> UARTWATER_TXCNT_OFF;
 	txcnt &= UARTWATER_COUNT_MASK;
@@ -773,34 +797,10 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 
 static void lpuart_txint(struct lpuart_port *sport)
 {
-	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sport->port.lock, flags);
-	if (sport->port.x_char) {
-		if (lpuart_is_32(sport))
-			lpuart32_write(&sport->port, sport->port.x_char, UARTDATA);
-		else
-			writeb(sport->port.x_char, sport->port.membase + UARTDR);
-		sport->port.icount.tx++;
-		sport->port.x_char = 0;
-		goto out;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
-		if (lpuart_is_32(sport))
-			lpuart32_stop_tx(&sport->port);
-		else
-			lpuart_stop_tx(&sport->port);
-		goto out;
-	}
-
-	if (lpuart_is_32(sport))
-		lpuart32_transmit_buffer(sport);
-	else
-		lpuart_transmit_buffer(sport);
-
-out:
+	lpuart_transmit_buffer(sport);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
@@ -876,6 +876,15 @@ static void lpuart_rxint(struct lpuart_port *sport)
 	tty_flip_buffer_push(port);
 }
 
+static void lpuart32_txint(struct lpuart_port *sport)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+	lpuart32_transmit_buffer(sport);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+}
+
 static void lpuart32_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0;
@@ -967,7 +976,7 @@ static irqreturn_t lpuart32_int(int irq, void *dev_id)
 		lpuart32_rxint(sport);
 
 	if ((sts & UARTSTAT_TDRE) && !sport->lpuart_dma_tx_use)
-		lpuart_txint(sport);
+		lpuart32_txint(sport);
 
 	lpuart32_write(&sport->port, sts, UARTSTAT);
 	return IRQ_HANDLED;
-- 
2.21.0

