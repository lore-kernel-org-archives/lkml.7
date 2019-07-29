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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70DDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C44F2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9aqf5Sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403991AbfG2TxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:53:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42922 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390673AbfG2Tw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so27945846plb.9;
        Mon, 29 Jul 2019 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BLKrH6yfYRVtlbED/1g+zQ/Eo+y1POWWq9TySA+XoNI=;
        b=Q9aqf5SnxpInR3ZiTzw0Iz4tZq9j6ZQMihafdLE2wPDpGDH+dKT1JGsCAFwvPqF47A
         s//YZdHa0umn59qgZ3G6pc6GebPH4hczPAP5pM3rDJ1NwKEieymE9rISdsY5MFbYVsYc
         X0WWreRacgvRCjzA4EuGE8EdUf/0tte7fnSlIk3bKzO2I0IGwWFmgKfQ72X1mtWqJyKG
         LFJwWJsDSSpzPUyYR0c7xyJAIrAPBjqhUf386qc8hjAkzU9fZznTdcbvZIJhAz1LfLQb
         53dzdADCqLopRRgDG2LGSLRQ0gqWpiZNLjC9dkXdWfH2O4GJBPA30NWCCqmJO/39y7xT
         XLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BLKrH6yfYRVtlbED/1g+zQ/Eo+y1POWWq9TySA+XoNI=;
        b=YQRUG7bZ8gOOKoEefphWjivVc5WAcxuXXvImWgDDvIb95ph34qFzza1QN8zXwVhNES
         H15ISxsf3HCjT57kV+JXXCfwUbRCDUI7VHimAJQ9RZRD2LSzyMgBJmwN8GmNRaiBCJx1
         lOpMNhvoxehSEsp73VwyJPwVPJreT1F7opr9LdUf/ieUz3XYFWV9TD6bOr5priB0QRlB
         EcK46BwSr2tz2hVNqYghHUs1QMavBAl3lXKKUVLBprt9DwCB7itT44WWgilmXmLlmrpc
         iij1j9UIritsy0NkGx/w2b7nzLmnrKTupNNQj5DoHEhds9QtVwMxZJS8uRUy1g8iZfLG
         430A==
X-Gm-Message-State: APjAAAUP+kaFt01DaMYFXH8Ns4IN8y/OIxBfuge5TxEJVdizJ99EJCLf
        GGd0e2GcEhfUa2xPlXFDJ8WkzUAH
X-Google-Smtp-Source: APXvYqwhYMNljGFulP47mjc8k39EESJNlFKcboR3KavkXzdGmWkC3t2B/EKeyny8HS+HyT+Yc/dDEw==
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr110906263plp.47.1564429978130;
        Mon, 29 Jul 2019 12:52:58 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:57 -0700 (PDT)
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
Subject: [PATCH 09/24] tty: serial: fls_lpuart: Split shared TX IRQ handler into two
Date:   Mon, 29 Jul 2019 12:52:11 -0700
Message-Id: <20190729195226.8862-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
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
 drivers/tty/serial/fsl_lpuart.c | 61 +++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 1fe9b1b29a46..f87ea889ff86 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -662,6 +662,18 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
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
@@ -681,6 +693,18 @@ static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
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
@@ -772,34 +796,10 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 
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
 
@@ -875,6 +875,15 @@ static void lpuart_rxint(struct lpuart_port *sport)
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
@@ -966,7 +975,7 @@ static irqreturn_t lpuart32_int(int irq, void *dev_id)
 		lpuart32_rxint(sport);
 
 	if ((sts & UARTSTAT_TDRE) && !sport->lpuart_dma_tx_use)
-		lpuart_txint(sport);
+		lpuart32_txint(sport);
 
 	lpuart32_write(&sport->port, sts, UARTSTAT);
 	return IRQ_HANDLED;
-- 
2.21.0

