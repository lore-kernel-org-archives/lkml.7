Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA38AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB5E20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsY423zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfHES5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:57:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44573 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbfHES52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:57:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so40068969pfe.11;
        Mon, 05 Aug 2019 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2TKHW6qqbT7z2PSO9m/5jJGypmXwkra4JjOIek7Nt0=;
        b=BsY423znX5i+8HR/dAf5A/0+UWekHtRM5aWUZePCsN9TXdd7FTO3mvP3u0mMGXjzRY
         IzSCaW23r8sx2pTMDBuVPqrXT1ra3gKlh6xrIUO02PJ7PocyOfK6iC6fTjrut3DEAa9S
         2WSOlypYWOGh5MOACyeoTlQR1LcpBftTjsVBbocpp9TgRBfl++gVTLATJzxqz0EXM7Ax
         AbaOESb0qj88doY+lYpyIhE4fbldTKcNZHXitdBmrXz2CHk8PhruGQbdBlTWku9gZiaf
         DOlrsntbm2DSpU3Nw/wCDDPGetcIRX0mJYIegbae4YAIzA8vQ/MKIMzY0NGWhDV6xlY9
         kPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2TKHW6qqbT7z2PSO9m/5jJGypmXwkra4JjOIek7Nt0=;
        b=joP3eZiJ+2vY7NjcbZ+DIRr4MvmGj4Nb6qvNsa0CiCRhb/OW010X1GWs/ogoDM8jN9
         HfVGkk/YLgtgYz6xOtTMjGGjTLS8wA6/nhvl0dMJhdq5I2i0Sur/XIUMov2ZjlNHXwml
         mk3wd/Ur5RcjjCZZjb8gG/ulG1GyxmYv3Equ0YLVJl4c8LLyRPdD5nnlSwesCtxSyXdw
         vP8hLl8yyiD1VqjDRhW+xmTJU+zjk9WDn4TIYQ59KDryeG/ZXrwC19cxriG25+csGwYL
         WngTjNJaJyh7nMhKkiSA0TV77KBK80vz9Eeiruo9NjLgaNVW9pESziOdg95aWXJNPqMX
         ypcw==
X-Gm-Message-State: APjAAAVdWu14V8lR7xWHtEP/qNInwP2FaPRsmFYUnP9fzf58G30Du2nk
        7UK+M9LKI4/dUfd0Z23kuIhtYiIg
X-Google-Smtp-Source: APXvYqy+83iaTcn0bCKCT7xMreHmZFFW2bt8kQqF4MRexFTOjkDr9SEPD8saIJJ4ZBsd7NCGQX+AMA==
X-Received: by 2002:a63:1f03:: with SMTP id f3mr108571910pgf.249.1565031446662;
        Mon, 05 Aug 2019 11:57:26 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k64sm16037959pgk.74.2019.08.05.11.57.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 11:57:25 -0700 (PDT)
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
Subject: [PATCH v3 1/6] tty: serial: fsl_lpuart: Introduce lpuart_tx_dma_startup()
Date:   Mon,  5 Aug 2019 11:56:56 -0700
Message-Id: <20190805185701.22863-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190805185701.22863-1-andrew.smirnov@gmail.com>
References: <20190805185701.22863-1-andrew.smirnov@gmail.com>
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
index 0e09e6dc5ccb..9da4529ee223 100644
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
@@ -2577,20 +2583,7 @@ static int lpuart_resume(struct device *dev)
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

