Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE24CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FAE22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNKapKXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405673AbfHWNlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:41:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39640 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731976AbfHWNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:41:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so8688323wra.6;
        Fri, 23 Aug 2019 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aj3B45jhtEZcmQmilM9V1gT63YSrO/49VbhmaZmMCl0=;
        b=FNKapKXyOkxQI4mV1jhF+IKzzz2Ev7anaoQseA+F0oPOhfgN9+GMVuSt1k9/Z+jhX6
         YYI3jY0/MCSqyOWUch37iepC6VMUvLEGw8ncSM5djTCgM4Gg5nMHhC0+5TZEIoiLs+2w
         q3Cl8TD8JQ/nxICQM8/twFIwGrm7+Lp+a+3nMb1kLQxkpFLFl4B5YF+WvOOPOmA9lkeV
         dhAkQ8ZAwJVhZXmKjj68mPVlPIV8V3Kv5hne0l3axycLtdYnhOBBTrnlFXF0cryeHHRr
         PQ2sBcdWaxJyGB7h3c29nN9OhH3PEutRCnBij68a4Y3HUaT3fiXJBgt6QA4a3xkNtIY2
         aJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aj3B45jhtEZcmQmilM9V1gT63YSrO/49VbhmaZmMCl0=;
        b=Y4EGx0eweVEIOARLHvtjXQCAuAvbEdg3UuifoVwc1LHT1ZdNMe4h/AaR6jb6XJ4kN8
         WEaEx+AoKenX63GKDiiD76lqxURQ7HKPN0ZTt+J+07wfI2ZpaaK87OWwdHRCcwPb/iYG
         PHvKR7FXT3KWCqotIx2zFNsYb0PILAdf8wBqnaOYjyw/f0ZlsTbfo/2lbeQkXwJ1PGuc
         YpC9j7cshpuPXkeYeAS852AXkS2RYlp9vjJTL4KeXUEuvDx3WNFWZs8fmWgRk4afhE2i
         WTOJgvogNwTOKhXjJNtA5bn0yGAmRYYN5cRs3Zi7nNl3d7+6PtPRMJqBZ+ExA7AmLgmT
         l5Qw==
X-Gm-Message-State: APjAAAVCYpA+lx+On9Ac4ZAMfTXtLgeQLmgUfONGBMSyt9fQNRy05SG+
        PVW5unRupUPpgor/88QEJ2M=
X-Google-Smtp-Source: APXvYqznbduO48damzNK/nFcez8ZSj9B4TeoJy109j6Q06iG+oQZq2N46/8vb1yP/spS+dr7tM0RIw==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr5489728wrt.294.1566567701297;
        Fri, 23 Aug 2019 06:41:41 -0700 (PDT)
Received: from localhost ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id l62sm5236104wml.13.2019.08.23.06.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 06:41:40 -0700 (PDT)
From:   Richard Genoud <richard.genoud@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH] tty/serial: atmel: remove unneeded atmel_get_lines_status function
Date:   Fri, 23 Aug 2019 15:41:09 +0200
Message-Id: <20190823134109.12402-1-richard.genoud@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ce59e48fdbad ("serial: mctrl_gpio: implement interrupt
handling"), the GPIOs interrupts are handled by mctrl_gpio_irq_handle().
So, atmel_get_lines_status() can be completely killed and replaced by :
atmel_uart_readl(port, ATMEL_US_CSR);

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 48 ++-----------------------------
 1 file changed, 2 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 9a54c9e6d36e..a8dc8af83f39 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -294,50 +294,6 @@ static void atmel_tasklet_schedule(struct atmel_uart_port *atmel_port,
 		tasklet_schedule(t);
 }
 
-static unsigned int atmel_get_lines_status(struct uart_port *port)
-{
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	unsigned int status, ret = 0;
-
-	status = atmel_uart_readl(port, ATMEL_US_CSR);
-
-	mctrl_gpio_get(atmel_port->gpios, &ret);
-
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_CTS))) {
-		if (ret & TIOCM_CTS)
-			status &= ~ATMEL_US_CTS;
-		else
-			status |= ATMEL_US_CTS;
-	}
-
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_DSR))) {
-		if (ret & TIOCM_DSR)
-			status &= ~ATMEL_US_DSR;
-		else
-			status |= ATMEL_US_DSR;
-	}
-
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_RI))) {
-		if (ret & TIOCM_RI)
-			status &= ~ATMEL_US_RI;
-		else
-			status |= ATMEL_US_RI;
-	}
-
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_DCD))) {
-		if (ret & TIOCM_CD)
-			status &= ~ATMEL_US_DCD;
-		else
-			status |= ATMEL_US_DCD;
-	}
-
-	return status;
-}
-
 /* Enable or disable the rs485 support */
 static int atmel_config_rs485(struct uart_port *port,
 			      struct serial_rs485 *rs485conf)
@@ -1453,7 +1409,7 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 	spin_lock(&atmel_port->lock_suspended);
 
 	do {
-		status = atmel_get_lines_status(port);
+		status = atmel_uart_readl(port, ATMEL_US_CSR);
 		mask = atmel_uart_readl(port, ATMEL_US_IMR);
 		pending = status & mask;
 		if (!pending)
@@ -2002,7 +1958,7 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	/* Save current CSR for comparison in atmel_tasklet_func() */
-	atmel_port->irq_status_prev = atmel_get_lines_status(port);
+	atmel_port->irq_status_prev = atmel_uart_readl(port, ATMEL_US_CSR);
 
 	/*
 	 * Finally, enable the serial port
-- 
2.19.2

