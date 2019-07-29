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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8436BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54262204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k33cG8V6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404297AbfG2T7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:59:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36202 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403971AbfG2TxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so27923807plt.3;
        Mon, 29 Jul 2019 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GeKGWefMNR4NtcNNCPJbjTkpbz1oGPCwTuqJluu/vRM=;
        b=k33cG8V6to7Ehfy8PmmpuMPGBc++pXePDZpEPUgcsupDRRge4vfHDmBtyKteRIQ0/J
         8vluiQ9Q1jxAM25IaGICF6f+NhQ4CibcvswxSN5QmUcQAtgDlSkKi4+fmCvvA2cYN+qh
         /VbjRlZeW1LlqlllRx/A1Y3xibUpJPz0hwq80MLscxEOXArsscDIy3gUFNRWuDm58+s2
         O8KO29N2MRLCOp/J+d9Y7dr3B2ACQ9idjTibpx1bR+CsasRW9Ju9Xhr0v66qkuSQbZ+e
         DLI9Jc2nnqJRgmBJuVH9CW/GuOgGbjE96fH0Oy8bV1lkGpldoNoqAd+FL6d22RceTsUA
         rYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GeKGWefMNR4NtcNNCPJbjTkpbz1oGPCwTuqJluu/vRM=;
        b=uQ0D3XwPcpY+PxzrkSJ0wWofjSZcrqPlc7uxB6nzhBBC3khGy+56QHakESleeTsUkX
         YF1NHu4RBaB6g5yOKrrc+hloFNe8BIT/mELRCDK4+vAA4esX1E9jh1NbAFNo4fsxPRAj
         Y5MzfoXeP4mhqpny/szuBgrf9CROSiTXWJrrdNPVZtw3mOeXe+ZVPAYx+xV/AQI5whC0
         f6x8caD508fXtzBJPS5KxtY8GS3VlR+gFoG9wAHQFulXQUYyKblMXV0sGzWo3lsp8eXv
         5FdUCh3MVSN9jQTkAdUV1pIXCAg9jpqV/DYCDfZ1ZUXx4LXBGIfqEZuG3/zPjrJqlSPq
         TIXg==
X-Gm-Message-State: APjAAAUMYVUFwRFl7D3YEKK9NNDoN01CsLSXC3wWqMh4MOWfNBWrDvmC
        3Mtw/3JIV78HD14oT6W4qkYnVCLD
X-Google-Smtp-Source: APXvYqxWiKjNlv05VKJKWS+klBG1+Xr88JkC+ui1zqi7HGB94u4L9tFN55zVLXNly2kubHX9NQVeiA==
X-Received: by 2002:a17:902:e281:: with SMTP id cf1mr108148950plb.271.1564429993372;
        Mon, 29 Jul 2019 12:53:13 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:12 -0700 (PDT)
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
Subject: [PATCH 20/24] tty: serial: fsl_lpuart: Introduce lpuart_rx_dma_startup()
Date:   Mon, 29 Jul 2019 12:52:22 -0700
Message-Id: <20190729195226.8862-21-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code doing initial DMA RX configuration in lpuart_startup() and
lpuart32_startup() is exactly the same, so move it into a standalone
subroutine.

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
 drivers/tty/serial/fsl_lpuart.c | 41 ++++++++++++++-------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 558acf29cbed..bda01d23cea8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1454,6 +1454,21 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 	}
 }
 
+static void lpuart_rx_dma_startup(struct lpuart_port *sport)
+{
+	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
+		/* set Rx DMA timeout */
+		sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
+		if (!sport->dma_rx_timeout)
+			sport->dma_rx_timeout = 1;
+
+		sport->lpuart_dma_rx_use = true;
+		rx_dma_timer_init(sport);
+	} else {
+		sport->lpuart_dma_rx_use = false;
+	}
+}
+
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -1479,18 +1494,7 @@ static int lpuart_startup(struct uart_port *port)
 	temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
 	writeb(temp, sport->port.membase + UARTCR2);
 
-	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
-		/* set Rx DMA timeout */
-		sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
-		if (!sport->dma_rx_timeout)
-		     sport->dma_rx_timeout = 1;
-
-		sport->lpuart_dma_rx_use = true;
-		rx_dma_timer_init(sport);
-	} else {
-		sport->lpuart_dma_rx_use = false;
-	}
-
+	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(port);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -1523,18 +1527,7 @@ static int lpuart32_startup(struct uart_port *port)
 	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
 	lpuart32_write(&sport->port, temp, UARTCTRL);
 
-	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
-		/* set Rx DMA timeout */
-		sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
-		if (!sport->dma_rx_timeout)
-			sport->dma_rx_timeout = 1;
-
-		sport->lpuart_dma_rx_use = true;
-		rx_dma_timer_init(sport);
-	} else {
-		sport->lpuart_dma_rx_use = false;
-	}
-
+	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(port);
 
 	if (sport->lpuart_dma_rx_use) {
-- 
2.21.0

