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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54204C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18007204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTQ1DvUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404326AbfG2T7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:59:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45089 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390871AbfG2TxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so27922994plr.12;
        Mon, 29 Jul 2019 12:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHzwZ4PX1CyQqKqFa1manFMJSSyWpDh2etgS1UT3Qtk=;
        b=oTQ1DvUMK3s2lPEsJm2ui35ZdHUMgwzP7d2IUsheJonATGnV/vlh5eatZ4sTv6r2et
         3D++tb4SCW4mCHzaqjXrGtdD1WTfOF1CkXFCvo1t344V1L+4v0zFFP1HWqDnu0EedYrh
         JtEliH1ly2w+Xk1Sy14IIpAaDpY4s53vBIIKK8vptht8V8TyqHEIrxlGeDcbk+1eykN+
         yu2BKfXBhgR2Inb9tXIhNY8ozmbOlRi257LkoSwgS7CHZSqifqU+2EML1TQoc9GyfgfT
         NDwM2q5Oy1K2zjDPfsNvZWA+6S0XLayWb+KJc0HcapMw1TciPRLgjhtopShshiZuFbNc
         pKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHzwZ4PX1CyQqKqFa1manFMJSSyWpDh2etgS1UT3Qtk=;
        b=ASFmUp+xQe1Jykv/TFOSyPTPAxq97MT5ZNZqgW+TPs3qUhmKcLXczlxDpSpvTYojMM
         gw1xHy2JuYY1WvyTHC0eCcT8J6bT8nNzu0sO2Egn7iraj7AftZ/qz0pUPlOJGUeSj2LO
         Zm6db348iKbyP0GIVty4bBIf8smjsDsrLEnzZQKvnfvWhavlpgcJCDikmf5gFap/Wnci
         D9b8oqeeml/9BAWX9PGUdRFTcLUKptqJT8a6Qg90eX5giZ9Z54Ahnfu+3tRwzz8RV5F2
         etHnMpfucp/loEVkrk2cZXH7ozl/zOwc4bwrp+35FUJhhatb6lpqpuT7pTiri8SfykPV
         wk7w==
X-Gm-Message-State: APjAAAWV8AULvl3Qc40rwSpzvjuKX/uBfOd+XRhfHkgTQssq7j+KmVMC
        Ao2KfgfzMHpieig0mhDsOLc6VI+I
X-Google-Smtp-Source: APXvYqyynPMs20pI8FktILzon7ZCI/RGIWCVQhpKYpK9HJ4Jk7AqPQd3Cw37jg0ffABpM4LWyzoy1A==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr110539168plb.295.1564429992253;
        Mon, 29 Jul 2019 12:53:12 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:11 -0700 (PDT)
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
Subject: [PATCH 19/24] tty: serial: fsl_lpuart: Introduce lpuart_tx_dma_startup()
Date:   Mon, 29 Jul 2019 12:52:21 -0700
Message-Id: <20190729195226.8862-20-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code configure DMA TX path in lpuart_startup(), lpuart32_startup() and
lpuart_resume() is doing exactly the same thing, so move it into a
standalone subroutine.

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
 drivers/tty/serial/fsl_lpuart.c | 53 ++++++++++++++-------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 2ad5750fe511..558acf29cbed 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1434,6 +1434,26 @@ static void rx_dma_timer_init(struct lpuart_port *sport)
 	add_timer(&sport->lpuart_timer);
 }
 
+static void lpuart_tx_dma_startup(struct lpuart_port *sport)
+{
+	u32 uartbaud;
+
+	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
+		init_waitqueue_head(&sport->dma_wait);
+		sport->lpuart_dma_tx_use = true;
+		if (lpuart_is_32(sport)) {
+			uartbaud = lpuart32_read(&sport->port, UARTBAUD);
+			lpuart32_write(&sport->port,
+				       uartbaud | UARTBAUD_TDMAE, UARTBAUD);
+		} else {
+			writeb(readb(sport->port.membase + UARTCR5) |
+				UARTCR5_TDMAS, sport->port.membase + UARTCR5);
+		}
+	} else {
+		sport->lpuart_dma_tx_use = false;
+	}
+}
+
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -1471,14 +1491,7 @@ static int lpuart_startup(struct uart_port *port)
 		sport->lpuart_dma_rx_use = false;
 	}
 
-	if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
-		init_waitqueue_head(&sport->dma_wait);
-		sport->lpuart_dma_tx_use = true;
-		temp = readb(port->membase + UARTCR5);
-		writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
-	} else {
-		sport->lpuart_dma_tx_use = false;
-	}
+	lpuart_tx_dma_startup(port);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
@@ -1522,14 +1535,7 @@ static int lpuart32_startup(struct uart_port *port)
 		sport->lpuart_dma_rx_use = false;
 	}
 
-	if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
-		init_waitqueue_head(&sport->dma_wait);
-		sport->lpuart_dma_tx_use = true;
-		temp = lpuart32_read(&sport->port, UARTBAUD);
-		lpuart32_write(&sport->port, temp | UARTBAUD_TDMAE, UARTBAUD);
-	} else {
-		sport->lpuart_dma_tx_use = false;
-	}
+	lpuart_tx_dma_startup(port);
 
 	if (sport->lpuart_dma_rx_use) {
 		/* RXWATER must be 0 */
@@ -2581,20 +2587,7 @@ static int lpuart_resume(struct device *dev)
 		}
 	}
 
-	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
-		init_waitqueue_head(&sport->dma_wait);
-		sport->lpuart_dma_tx_use = true;
-		if (lpuart_is_32(sport)) {
-			temp = lpuart32_read(&sport->port, UARTBAUD);
-			lpuart32_write(&sport->port,
-				       temp | UARTBAUD_TDMAE, UARTBAUD);
-		} else {
-			writeb(readb(sport->port.membase + UARTCR5) |
-				UARTCR5_TDMAS, sport->port.membase + UARTCR5);
-		}
-	} else {
-		sport->lpuart_dma_tx_use = false;
-	}
+	lpuart_tx_dma_startup(sport);
 
 	if (lpuart_is_32(sport)) {
 		if (sport->lpuart_dma_rx_use) {
-- 
2.21.0

