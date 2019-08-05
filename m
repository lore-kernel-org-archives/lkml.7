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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6EBC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FA520B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJfNZpRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfHES5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:57:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43394 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfHES53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:57:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so40099593pfg.10;
        Mon, 05 Aug 2019 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GuqKozIy0dCl6gP2tbi5iM8CAwVR9h4XqnYI4npVx1E=;
        b=OJfNZpRL9MR5WzezcxhL6uWJBdx+4lmz5IU3r91wS+wUDH6XpChGjyp7/csqor+5kg
         Bc9hx1VciPiHsM6qVbKakZKrDi+pRj42s0xEMFa8FovIXEpjUIEhcNMYyFZjmt3LyKBp
         xiGpRliAo+p49nVzjXIrCDGZk9/xtuZlnMVoYvvzA2mG93zkBGk1Alu5Gcm0w9+qLOQV
         XndrG1SUhsatmCp5IOY+kGus21J6cyufkz75kBB3rbSexEIrAEVw9Bx4aDEPJvX55kbM
         lgh21gUEBZPXQYBwzGydLwCwrNc7hOzwY+Q8IThEPKjcSpD2u5y/Ywo1AvCz1gnydtPM
         wmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuqKozIy0dCl6gP2tbi5iM8CAwVR9h4XqnYI4npVx1E=;
        b=rUtSL+stk7Rtunx+vROpbp5ZrkWWoiHfX+CXHAop3ve32gOgu8J9KkaEIOLulWLcFi
         itzzQdvYnopK8qnI+BSSEdLd3wg6jDwmmd4X31OyO0rlMzY7YHoCV6k0cXIXKKR30cPF
         UQLR7bHe2Z9Qo8822W06kp2QHobyag4PMxe+s2kz99mvlUol8yz0XJvnwjmwWXpB90lM
         bRxdxmdC8ar0TxoHFkegHCRxa+SaxHAQ7jJiXHO+ZU8lOu2Y4RuyJ75XSlJVmkMXB++n
         Hb9aYDEAPrMWhsBRMb3EQQWXvEK90Edi+uCLDWHYY5t7nJGaguiGgmtaHmFnBUjhFYvf
         yJcA==
X-Gm-Message-State: APjAAAVVsIgWgjx916U1loovepxmmtsnH621BUhz0QVnpnnjA8PEHkUg
        VrauJMBqUi9Qx2WTtB06ACwH2HpA
X-Google-Smtp-Source: APXvYqy2xxbn4unoTsKCmR+ZjIumWoYSHTqsNlf1zYtjhhJ5AZZVAd3lGkC2sSKYXqEiX0/UTdFw+w==
X-Received: by 2002:a63:c006:: with SMTP id h6mr7238122pgg.290.1565031448041;
        Mon, 05 Aug 2019 11:57:28 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k64sm16037959pgk.74.2019.08.05.11.57.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 11:57:27 -0700 (PDT)
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
Subject: [PATCH v3 2/6] tty: serial: fsl_lpuart: Introduce lpuart_rx_dma_startup()
Date:   Mon,  5 Aug 2019 11:56:57 -0700
Message-Id: <20190805185701.22863-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190805185701.22863-1-andrew.smirnov@gmail.com>
References: <20190805185701.22863-1-andrew.smirnov@gmail.com>
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
index 9da4529ee223..4b59801a0a0c 100644
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

