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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D45C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4CE21734
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exn7B7an"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfHES5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:57:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46934 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfHES5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:57:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so2989259pgt.13;
        Mon, 05 Aug 2019 11:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WT066rnvh5uQXR2ltMlpOV9a5E867cJV8j39JLKtN0=;
        b=exn7B7an67HxIvtTwadhTE1oFn0pygr97EM7i5e87Q++9RnUdbffJ3v+GZKRn6L63P
         V6ESkgVq1UOFDik9frMxth8YFXJ59et50LsE3CR1VVJVGrYIuh9TjLKHacLNvor7YCoI
         tXlCWY6a1KzUgADWmGWOeS3cULSrNJroJJN5yKNKiC3Oncafb0JEeTsfNmDVs8iGzw/L
         4McybRKz0wDWn/efCibkC5bEoGALp6ifYmJYXOuc5ZT7x+FAbXb2x+YvWq9pZlNr/a/L
         6XAVH3wTS6z8wkyWmP6GghNTHGyyR3xtSsKtuFxXqUiks/mcPhBLddTwH3gy8Lz5dgLj
         h9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WT066rnvh5uQXR2ltMlpOV9a5E867cJV8j39JLKtN0=;
        b=Qyo4FkmhiFYuXAfZOYMqX59HgaQLBzcgwEJNvYw0hg50OA/u64si5GjmJ2DYkPekas
         tUdQTgkbXzlY6PCeocTsvXmFPr4rZsLSKhd78GX3V+iYAaXBWMEv9n9UwaXZEqnx7sH9
         1U08OE0L6KDhR1lyrxoCBW5CJYSm5mFA5iK6b3KMIGLSlxHMd8Vx1z803n+H58hhNJi8
         vYMvo67VQe518YR/ycspM1fUJohBuPAtBShckFQGa907nV5OA33YV7FaOV/qDiokJxEd
         dvnyyXLx9E35f4zUuku532izXom2hNVbh14xrilfUvPhmbc5IBktyoxbdKJXXwFhkFMn
         1oAQ==
X-Gm-Message-State: APjAAAXYZYUTevE3P7kedXCGzXCEEj50VI/C+RN3a4Trq+HWu4qodqBz
        qVChGutihGLa0g43z38YRtCL+PfO
X-Google-Smtp-Source: APXvYqyzE69WY5M2psyQWq/JVAfTpnE9tE2OyRbvrxZTFwrGJVeD84YSWNYWvnFg0Q9VnGE82lGxcQ==
X-Received: by 2002:aa7:9dcd:: with SMTP id g13mr76106032pfq.204.1565031449284;
        Mon, 05 Aug 2019 11:57:29 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k64sm16037959pgk.74.2019.08.05.11.57.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 11:57:28 -0700 (PDT)
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
Subject: [PATCH v3 3/6] tty: serial: fsl_lpuart: Introduce lpuart32_configure()
Date:   Mon,  5 Aug 2019 11:56:58 -0700
Message-Id: <20190805185701.22863-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190805185701.22863-1-andrew.smirnov@gmail.com>
References: <20190805185701.22863-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code doing final steps of TX/RX configuration in lpuart32_startup()
and lpuart_resume() is identical, so move it into a standalone
subroutine.

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
 drivers/tty/serial/fsl_lpuart.c | 48 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 4b59801a0a0c..1286daa1be79 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1502,6 +1502,24 @@ static int lpuart_startup(struct uart_port *port)
 	return 0;
 }
 
+static void lpuart32_configure(struct lpuart_port *sport)
+{
+	unsigned long temp;
+
+	if (sport->lpuart_dma_rx_use) {
+		/* RXWATER must be 0 */
+		temp = lpuart32_read(&sport->port, UARTWATER);
+		temp &= ~(UARTWATER_WATER_MASK << UARTWATER_RXWATER_OFF);
+		lpuart32_write(&sport->port, temp, UARTWATER);
+	}
+	temp = lpuart32_read(&sport->port, UARTCTRL);
+	if (!sport->lpuart_dma_rx_use)
+		temp |= UARTCTRL_RIE;
+	if (!sport->lpuart_dma_tx_use)
+		temp |= UARTCTRL_TIE;
+	lpuart32_write(&sport->port, temp, UARTCTRL);
+}
+
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -1530,18 +1548,7 @@ static int lpuart32_startup(struct uart_port *port)
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(sport);
 
-	if (sport->lpuart_dma_rx_use) {
-		/* RXWATER must be 0 */
-		temp = lpuart32_read(&sport->port, UARTWATER);
-		temp &= ~(UARTWATER_WATER_MASK << UARTWATER_RXWATER_OFF);
-		lpuart32_write(&sport->port, temp, UARTWATER);
-	}
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	if (!sport->lpuart_dma_rx_use)
-		temp |= UARTCTRL_RIE;
-	if (!sport->lpuart_dma_tx_use)
-		temp |= UARTCTRL_TIE;
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	lpuart32_configure(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 	return 0;
@@ -2579,21 +2586,8 @@ static int lpuart_resume(struct device *dev)
 
 	lpuart_tx_dma_startup(sport);
 
-	if (lpuart_is_32(sport)) {
-		if (sport->lpuart_dma_rx_use) {
-			/* RXWATER must be 0 */
-			temp = lpuart32_read(&sport->port, UARTWATER);
-			temp &= ~(UARTWATER_WATER_MASK <<
-				  UARTWATER_RXWATER_OFF);
-			lpuart32_write(&sport->port, temp, UARTWATER);
-		}
-		temp = lpuart32_read(&sport->port, UARTCTRL);
-		if (!sport->lpuart_dma_rx_use)
-			temp |= UARTCTRL_RIE;
-		if (!sport->lpuart_dma_tx_use)
-			temp |= UARTCTRL_TIE;
-		lpuart32_write(&sport->port, temp, UARTCTRL);
-	}
+	if (lpuart_is_32(sport))
+		lpuart32_configure(sport);
 
 	uart_resume_port(&lpuart_reg, &sport->port);
 
-- 
2.21.0

