Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F31C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BABF20874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Wo39Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfHZHSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:18:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51122 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfHZHSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:18:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so14390286wml.0;
        Mon, 26 Aug 2019 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VM0i+HbQcoHkYJJw8AmMRth0Vj3bfPKY+WqSiqGn1IQ=;
        b=D6Wo39MlDNinRfzLvY0bTdk86E2JxqjjV1T5YBQ2whdaSjbzPM7js1rU09B4FSbqfy
         lWD9yBbSVQ5JMslvFrpDxVJWJibtVyr6alAPXXFKVH4L24SOv3E9negZHv/KbCFZikG8
         bsLdqY1MHWSF/DKll5NsvfmDXj9515sFLMc1UOkWVjSJ8TkBD4+byoZohCLJm9vTOSjU
         1MkQ6V1XK3Se4vepQc/Yi0s9aa9G8rTWj6fcbCDTW71jLMJFFMzV7p9aMjJCAb0ujXrQ
         7eTNGf1z+gVhhwl6ptNj2tXTAUphkiscByUBBP9i++jpOrdaR5jIE4H4iqUd6ffKPOGY
         wVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VM0i+HbQcoHkYJJw8AmMRth0Vj3bfPKY+WqSiqGn1IQ=;
        b=r7mwgO5n81GaTJ8SFxiFfvaH0teAr2cqATpVwMkacuRhKfp8ZGV1Bq3aMMmJw6xlk1
         kipqeXULBdWaJJHj7JQkNvyW8Q5slGKdiJUl51qJE+KfIR2y/GpYTFA/TCACHMxKPijJ
         E7b4vfPpRvVJhlrUoxGRh4z5JkeE+lF67ntFB4PByEdKV6AaaWdePg93z3Qipjxd5iWC
         UauGzKj3O4o+EG4Ny5GbWSi3LmMpHFyDAqW3Y1IflLoVujvhf+wb5A3iSSeKnXX3OyS2
         7R0PpBQkv2P7bIl37kLjzwhrgKD8N2YyXxFvE8H2U2Y9i74oQAyDqVPzhLTjHfHTQTya
         3PVg==
X-Gm-Message-State: APjAAAU2HyXKEkDM6lP5OCHRX5o1Po82d7tVCtwMhsyf7+sIQv4tj4qb
        uoJZamVOy/youcTySVi1E6c=
X-Google-Smtp-Source: APXvYqws+8tczvnHlDZ7acLjdiXOcnOl5mlhNYUha+CVNXAG7XVTEGIzY3PvK5kjDoaAgX07XIp98w==
X-Received: by 2002:a1c:a701:: with SMTP id q1mr19160124wme.72.1566803886960;
        Mon, 26 Aug 2019 00:18:06 -0700 (PDT)
Received: from localhost ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id f13sm9703479wrr.5.2019.08.26.00.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Aug 2019 00:18:05 -0700 (PDT)
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
Subject: [PATCH v2] tty/serial: atmel: remove unneeded atmel_get_lines_status function
Date:   Mon, 26 Aug 2019 09:17:52 +0200
Message-Id: <20190826071752.30396-1-richard.genoud@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 18dfef9c7f87 ("serial: atmel: convert to irq handling
provided mctrl-gpio"), the GPIOs interrupts are handled by
mctrl_gpio_irq_handle().
So, atmel_get_lines_status() can be completely killed and replaced by :
atmel_uart_readl(port, ATMEL_US_CSR);

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 48 ++-----------------------------
 1 file changed, 2 insertions(+), 46 deletions(-)

Changes from v1:
 - point out the right commit (thx Uwe)
 - add Suggested-by/Acked-by

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
