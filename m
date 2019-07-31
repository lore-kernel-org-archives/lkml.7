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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CE320C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY7Wa3xO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfGaRbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44802 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbfGaRbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so30765987plr.11;
        Wed, 31 Jul 2019 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fe1e3kNp25lcRWxyTAzM6XbZckb12GMMo4MJ2pZ50bw=;
        b=CY7Wa3xO8ZJUVGX+u8y4/nY/uLHRTRVtqRFmWGwPpwnaOsRq8279J0ZxsfiqX4nYwD
         grpC5aW0T67Ln+q3OQ1MgaHYiVgdzFkEGI2tR1DayevT1C95pjL8bu3WKMZlR9AAZLqu
         8Q/5Ln6cL4fQeP3Ov8tqQIOoG9nU5uvO2R3kNWn0D3x7krsaQ5LV8v+Uf5gsQfPRPXmV
         KQCwsqFukUwd/RN5II2U+Qr1jeHTRAiu6MJel2vaD+cIDuL+bavl8g8x8OhVTQbUillZ
         YQ11kS+lPSr7akBndGIyean9DYq4EbSPoWds5Ll+sSizZDOAYMEwXtZtHM7p+4t+TaCD
         eXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fe1e3kNp25lcRWxyTAzM6XbZckb12GMMo4MJ2pZ50bw=;
        b=OJC4ojQcvmG+F0BwTb+3fM97xrBsW2HpydQFBfOxhjBNRXCOODO5U+j9ZUFPWII5Qp
         Yc8CeXU1aula/zGTIy0JGdx6Vl1SknCTG9DoH9vnFkcfzYG0ne6R7gqzxvgp3efpe38R
         6+Uui2aUaVIBYf3KoiO/1mO88n0dvDeGuEeV324fi0i/YugxsXBlWwVx7jN+lJhPy/HU
         un06zV4uxBVMtPMNsqvL/GSEEjLBtbOax2TFWfkbj0oLZ6ZpDBJfEvLW1FiSsFAELBws
         TkhbtQURlbWGzRk0uU+RjM7l4fJSkGx0tnNl1sfcSHqYCG5Tzm4nLEHesHEfXL5twJMm
         lYdw==
X-Gm-Message-State: APjAAAW28+3jpBKuXE8/IcN1J9wGqdN/xmnRz78t0S0A8Eu7+Hyq4G/k
        U6GV8TSCrSqQhxiAlBKvZdUBXuT6rAY=
X-Google-Smtp-Source: APXvYqznoNGnTPF3/qlphW3XseItNBUGQshVTHQjX80E61ZzaGsy76lRDpEhtxk3xUj0i+ui6cSL0A==
X-Received: by 2002:a17:902:bf09:: with SMTP id bi9mr114175115plb.143.1564594303321;
        Wed, 31 Jul 2019 10:31:43 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:42 -0700 (PDT)
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
Subject: [PATCH v2 17/23] tty: serial: fsl_lpuart: Introduce lpuart_dma_shutdown()
Date:   Wed, 31 Jul 2019 10:30:39 -0700
Message-Id: <20190731173045.11718-18-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last steps of .shutdown() code are identical for lpuart and lpuart32
cases, so move it all into a standalone subroutine.

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
 drivers/tty/serial/fsl_lpuart.c | 42 ++++++++++++++-------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 2597a877d639..8cf10d12947f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1547,6 +1547,22 @@ static int lpuart32_startup(struct uart_port *port)
 	return 0;
 }
 
+static void lpuart_dma_shutdown(struct lpuart_port *sport)
+{
+	if (sport->lpuart_dma_rx_use) {
+		del_timer_sync(&sport->lpuart_timer);
+		lpuart_dma_rx_free(&sport->port);
+	}
+
+	if (sport->lpuart_dma_tx_use) {
+		if (wait_event_interruptible(sport->dma_wait,
+			!sport->dma_tx_in_progress) != false) {
+			sport->dma_tx_in_progress = false;
+			dmaengine_terminate_all(sport->dma_tx_chan);
+		}
+	}
+}
+
 static void lpuart_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -1563,18 +1579,7 @@ static void lpuart_shutdown(struct uart_port *port)
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (sport->lpuart_dma_rx_use) {
-		del_timer_sync(&sport->lpuart_timer);
-		lpuart_dma_rx_free(&sport->port);
-	}
-
-	if (sport->lpuart_dma_tx_use) {
-		if (wait_event_interruptible(sport->dma_wait,
-			!sport->dma_tx_in_progress) != false) {
-			sport->dma_tx_in_progress = false;
-			dmaengine_terminate_all(sport->dma_tx_chan);
-		}
-	}
+	lpuart_dma_shutdown(sport);
 }
 
 static void lpuart32_shutdown(struct uart_port *port)
@@ -1594,18 +1599,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (sport->lpuart_dma_rx_use) {
-		del_timer_sync(&sport->lpuart_timer);
-		lpuart_dma_rx_free(&sport->port);
-	}
-
-	if (sport->lpuart_dma_tx_use) {
-		if (wait_event_interruptible(sport->dma_wait,
-					     !sport->dma_tx_in_progress)) {
-			sport->dma_tx_in_progress = false;
-			dmaengine_terminate_all(sport->dma_tx_chan);
-		}
-	}
+	lpuart_dma_shutdown(sport);
 }
 
 static void
-- 
2.21.0

