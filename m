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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC273C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BC420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDApek5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfGaRbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33270 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbfGaRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so30720684plo.0;
        Wed, 31 Jul 2019 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzHPGLWn9YAZeMfUP9wZ8+hi2KbJByZMqWft6xcBdjs=;
        b=cDApek5SNTpHRkrL9nv4WXq+miRX/KUgL20NuLVkivqq4y7KqU5u1PwacNlYGiuIEH
         IZyELSsvoqE3GM87B0DsLim8I4kVXaYvp8aum3I7GqLz/dv2HGW4KXIZi+3828giyEpi
         ZTqRKyX6ep2bcmWJLjn8kQ1Ma4Up4p2xsisYHEDCfvfbQhA6d5CB+04BPDKjfwjl3kEq
         6qE1fPflQv6MrXXlPD/qTcdTHASouO6Vmvk6EOenhFQ21qv0YcPu9zqu17JhqNbZpOiK
         9i3dPM/4FDbc9s4LGecHzgEvaoOe0IL9e09kg27KKSFmKWz8BuOKx8syQ3JH+CzxIGyJ
         D+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzHPGLWn9YAZeMfUP9wZ8+hi2KbJByZMqWft6xcBdjs=;
        b=Mk4Prg3L67Qs9GBHmkNzcb1GwM0U4EWfE+kwvLb2goWlybOZ9VnurwKVfjGGrND+Se
         FYwYq0eTFu73FzeDrngHqM8cbJmUj35iovauD55G3IDYhgo0ePkf1dPrU0egLcMmTBOy
         7TFP2Hqutc8Zqx6aZQWUGy08i3uinB6ZdYFcu+sZXB5p44WaObk9NN2bK5GQcpiMxa4n
         dOoGhoKCExbEkqnVQNJ0KAA6iEQLfQJCQxpVLaSezcD8vPnF4B9uossspGIXdHqpDdsd
         JzWM5eVabp6iKFDuRHcrvPywb/MxEwhkCvvhlVCzkXL5kOVAIfLLjGMo3HbUisQ77UzV
         gNMg==
X-Gm-Message-State: APjAAAVstN83Zpp3GKK7uNC1JxBon66TasoyCHo+SSifJ55tIVkoJokr
        mdF9+S7nflXb1QKTGuRYB1dyqge313g=
X-Google-Smtp-Source: APXvYqzI3tdMGdKmk95UGoKc5b4eqiPCFY+jL8QyUVd3dEpZo2DnsjbwoiwMxPjKYEdoRi4txleWSA==
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr123352699plo.211.1564594305608;
        Wed, 31 Jul 2019 10:31:45 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:44 -0700 (PDT)
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
Subject: [PATCH v2 18/23] tty: serial: fsl_lpuart: Introduce lpuart_tx_dma_startup()
Date:   Wed, 31 Jul 2019 10:30:40 -0700
Message-Id: <20190731173045.11718-19-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
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
index 8cf10d12947f..5f2dc43676f7 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1435,6 +1435,26 @@ static void rx_dma_timer_init(struct lpuart_port *sport)
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
+	lpuart_tx_dma_startup(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
@@ -1521,14 +1534,7 @@ static int lpuart32_startup(struct uart_port *port)
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
+	lpuart_tx_dma_startup(sport);
 
 	if (sport->lpuart_dma_rx_use) {
 		/* RXWATER must be 0 */
@@ -2579,20 +2585,7 @@ static int lpuart_resume(struct device *dev)
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

