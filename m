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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FEFC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF44620C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XibeZd22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfGaRbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38236 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbfGaRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id f5so23567933pgu.5;
        Wed, 31 Jul 2019 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EeAZAWp2Z7De/B3SiPd1DtUecOkI3jfu2KRB2h/TVfQ=;
        b=XibeZd22jlp5vOWoMLBrXJTHnen86i4ddADdRLqf2j/o18JCbIFN+rQ0gjARGCQEL+
         C3ANOyMu8yWD/u+ER6pXQ1tU8F39HEJ49HzNACtkWcCsoyProOFkE2kDAjVhXvREEAs4
         z0NfvKtqWdxXIGDpgArbRqLpJznCDCiqy6r5P3H1+KwslkQF3GDXy6BPHnq+qGHM5/03
         vcV5WPYPGqMZq6tl6du0lU0U7tvKB6yHtKNzandbp8NJysfNgF6K/snQVOyhKFqaRidY
         TZj5heApV3mJ0uMIWzU0lZZ0jXuFWxzSC0RjTMwxajYHESd0Tp09JPtlBbqsonWYla2y
         AkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EeAZAWp2Z7De/B3SiPd1DtUecOkI3jfu2KRB2h/TVfQ=;
        b=KyFNSVzf7paf4WdIKlQZqc2EEaHToNz1DWaxqZsVsyhI91pbMDCyTwDVY0ynRC/O9b
         duUQjHV+2gxmSmzgCRl6TiiQSD8o07IRgwkegwlbkNAVL1i8MhUDGdiI5IndxkXlBEtj
         7ifoQmTlrc+iVOd2UX1BhJcCcVAI0pW+0TnUGm8v5EW3cHuFj/FUwAITr/mmtBRggdsi
         dhvu/bIba8ZXPhi+2wAA0Cd4Nd7j6QEfPxwwDY2w+oZHNN8cD9QhYa/8574bNteXCsZ2
         T/ArQXgFKJDQqkvdcQAp89wGnHDp8BahzCn1VfdcXcZDZRfT5/0vwq221kSIjE+oC/IJ
         4vBg==
X-Gm-Message-State: APjAAAX2Ugs/4j3TEml/WoqdTNao+ZMxUab1t1cS6Qs69dTmPYYTSLmY
        ZBEh3bTKHt/LdDukF3UoY6DLj9GoucQ=
X-Google-Smtp-Source: APXvYqwSRzf2VVKKlwIl6Jb2B/Mn91PiNPmKrd5Jgijpauwd3ipGlwCc4GrqgdUjwXAwM6YdH1vEPg==
X-Received: by 2002:a65:65c5:: with SMTP id y5mr113729157pgv.342.1564594309121;
        Wed, 31 Jul 2019 10:31:49 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:48 -0700 (PDT)
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
Subject: [PATCH v2 19/23] tty: serial: fsl_lpuart: Introduce lpuart_rx_dma_startup()
Date:   Wed, 31 Jul 2019 10:30:41 -0700
Message-Id: <20190731173045.11718-20-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
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
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 40 ++++++++++++++-------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5f2dc43676f7..7d67e9631623 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1455,6 +1455,21 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
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
 	lpuart_tx_dma_startup(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -1522,18 +1526,8 @@ static int lpuart32_startup(struct uart_port *port)
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
 
+	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(sport);
 
 	if (sport->lpuart_dma_rx_use) {
-- 
2.21.0

