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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBBCC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397D320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSwemd5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfHES5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:57:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39255 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbfHES5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:57:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so36107375pfn.6;
        Mon, 05 Aug 2019 11:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/MIiHcQumuxQUNSzBjPEJpMDTyUHR0oWuuWeDFIn00=;
        b=RSwemd5UOTfacTh1nvmDCQVCZF0ip5YiZM+cHvWAk1jilGBiDsCgOiEK2ABrFWUosz
         cvveviTt12sH7vcIBUpuZ4BoQvSxvozBVqpwjBLyWCcctdLlbTP7t8HN3DEwJfyV0BIr
         Uc8YuUkToEfPqAmYcuBAeeCGFasijL6JqtchJin/YMHubGxzFdf5M74+EEWFN8SBYjcu
         N7NdMkUcH0MfYBZb1ZNDceiO9CBg4EdI+QvzkOu+SaEKAr8FHspm0pz+zlDkfFlnOegf
         cddjsD+d4BXADGclBq6viE3SuxTWDp5DEeibaOVNjUcE6XmrxLy/bYSDaG2zGvMxhKTp
         ahMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/MIiHcQumuxQUNSzBjPEJpMDTyUHR0oWuuWeDFIn00=;
        b=lXGvYG+SFeGLcv4x1PHaxYG+cvSKEACz0LgwrgfvtU8rpDWw/HmlF8UZoPbgsMH4Vu
         ap3j1y52veNPadVr7WRwT5vT5am3G4JO4oj6E3xIJk1g/zRZYbqUVL5xMa3MbfWfRQI2
         RoFCZTHouB7JCv6F2h3r6falWHen41ceHGjsi/jGEWi6BImJLrNFu2vOMvqnYmAci5AI
         N2qgjEZF8gCbnx8Y2MzAQREospRdTw5y/1Pbe93ucV9p+267qjRzZ+ZcLKyhV03KTijG
         7M7ubZPZBWGhAfj1EBeKh44yxDoo77O7H05dXrSoFrxibKmwD2+x0IE9cY2Fpf5PSn5R
         xXyw==
X-Gm-Message-State: APjAAAVmhmRk06IoAJwbs/Vc4brp9XsFcWO8eF26tw0gjuEyr/gR+U1e
        CNsL9X5/aIpkxttfm1L9sRoXwOsF
X-Google-Smtp-Source: APXvYqw2NvQd07i/SzNRhmmzG0SS2sWKSda5f1g5/jwd0fZeKPkFnW7GQIRU/VANyGtDgO17Dt5tdw==
X-Received: by 2002:a63:460d:: with SMTP id t13mr9857116pga.205.1565031450971;
        Mon, 05 Aug 2019 11:57:30 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k64sm16037959pgk.74.2019.08.05.11.57.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 11:57:30 -0700 (PDT)
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
Subject: [PATCH v3 4/6] tty: serial: fsl_lpuart: Introduce lpuart*_setup_watermark_enable()
Date:   Mon,  5 Aug 2019 11:56:59 -0700
Message-Id: <20190805185701.22863-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190805185701.22863-1-andrew.smirnov@gmail.com>
References: <20190805185701.22863-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most users of lpuart*_setup_watermark() enable identical set of flags
right after the call, so combine those two action into a subroutine
and make use of it.

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
 drivers/tty/serial/fsl_lpuart.c | 50 ++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 1286daa1be79..fb9961edce3a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1403,6 +1403,17 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 	writeb(cr2_saved, sport->port.membase + UARTCR2);
 }
 
+static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
+{
+	unsigned char cr2;
+
+	lpuart_setup_watermark(sport);
+
+	cr2 = readb(sport->port.membase + UARTCR2);
+	cr2 |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
+	writeb(cr2, sport->port.membase + UARTCR2);
+}
+
 static void lpuart32_setup_watermark(struct lpuart_port *sport)
 {
 	unsigned long val, ctrl;
@@ -1428,6 +1439,17 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	lpuart32_write(&sport->port, ctrl_saved, UARTCTRL);
 }
 
+static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
+{
+	u32 temp;
+
+	lpuart32_setup_watermark(sport);
+
+	temp = lpuart32_read(&sport->port, UARTCTRL);
+	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
+	lpuart32_write(&sport->port, temp, UARTCTRL);
+}
+
 static void rx_dma_timer_init(struct lpuart_port *sport)
 {
 	timer_setup(&sport->lpuart_timer, lpuart_timer_func, 0);
@@ -1488,11 +1510,7 @@ static int lpuart_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	lpuart_setup_watermark(sport);
-
-	temp = readb(sport->port.membase + UARTCR2);
-	temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
-	writeb(temp, sport->port.membase + UARTCR2);
+	lpuart_setup_watermark_enable(sport);
 
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(sport);
@@ -1538,11 +1556,7 @@ static int lpuart32_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	lpuart32_setup_watermark(sport);
-
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	lpuart32_setup_watermark_enable(sport);
 
 
 	lpuart_rx_dma_startup(sport);
@@ -2558,22 +2572,14 @@ static int lpuart_resume(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	bool irq_wake = irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq));
-	unsigned long temp;
 
 	if (sport->port.suspended && !irq_wake)
 		lpuart_enable_clks(sport);
 
-	if (lpuart_is_32(sport)) {
-		lpuart32_setup_watermark(sport);
-		temp = lpuart32_read(&sport->port, UARTCTRL);
-		temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
-		lpuart32_write(&sport->port, temp, UARTCTRL);
-	} else {
-		lpuart_setup_watermark(sport);
-		temp = readb(sport->port.membase + UARTCR2);
-		temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
-		writeb(temp, sport->port.membase + UARTCR2);
-	}
+	if (lpuart_is_32(sport))
+		lpuart32_setup_watermark_enable(sport);
+	else
+		lpuart_setup_watermark_enable(sport);
 
 	if (sport->lpuart_dma_rx_use) {
 		if (irq_wake) {
-- 
2.21.0

