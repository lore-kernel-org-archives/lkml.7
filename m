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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5D7C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B32205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTghtoQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404156AbfG2T7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:59:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36192 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403951AbfG2TxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so27923618plt.3;
        Mon, 29 Jul 2019 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xSR8UIuJtUSfE1z/aFnKt2Qtqi8QrJMV4/6voBg3yuM=;
        b=sTghtoQ07flTgSh7Epjme4BrL1GNyPeXeHeX7d+kreZhh0eug8TbMG1el8na/8S4iK
         xSnmylVtUtcDC2Z8NHPpn8TsFhLlAGoYSMd40rg/brQ/qvnWiP7PHMd5NElKleX1up4X
         S96Dkrwc19E40ZqN+XB6ZbioTJcpWgGrJWdoogufTcmbiHKvydAoDIG4wjhcXu1N0Rws
         qIQNVFWmqJTWO4JyYY0BU+y0GGUvOG0pvrQh/KHl09pd6wOxUNnytpaq8E/I0UVZ72+Q
         Hmrg/oloTwUp7l2sVTy2wel1NCoGDpPbD89fImiVluqebqo/CkOjDM58dULGsZdNPymO
         Dlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xSR8UIuJtUSfE1z/aFnKt2Qtqi8QrJMV4/6voBg3yuM=;
        b=KywXcZ0CdP6MO9mAU5RrvxNWKld4yncuL0QDe92ach+bI7kx5JDsl2zfhnbBS6aVzp
         nCk9+A4QyylGDT5CBAsSIYfoiiRfFiYIR08S9HYBMj/1o5ty6nb0dYGw42OdfU1+mAqM
         I6G3MWpswKeDSNnfrM5OdbZ6HFQ2A3F5J3TdMuGrNeh+032NfKnRj5CioCJR/hf/FhsT
         QJ9iwgpXvDXZV7SDSXtcUk6vYUBGAYz3Oi4uvaS48wJSLareJhml3xrzqAKOIwYAsF5o
         QHh4a4SqoMS0Xa74jbsr6BQ5hGJf+9fXhc8seYHgmIDcHHTeCLEnV6tFavOmDcMKojTt
         qUyA==
X-Gm-Message-State: APjAAAWHI7GwgIlfXy+no77azn//6YzkzjlOP7eLRn/zQE1ZcikUmXk2
        1YJofPViWTPphbxyxkRhLZcxsVQ4
X-Google-Smtp-Source: APXvYqwAkcJ5VuqJJYKnj+U/FYuNG6xkJZ2V+u3k5VljLDWmRkMRJfyfXhePf/M4hly0tmPNiQu+Nw==
X-Received: by 2002:a17:902:6a85:: with SMTP id n5mr104225220plk.73.1564429980871;
        Mon, 29 Jul 2019 12:53:00 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:00 -0700 (PDT)
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
Subject: [PATCH 11/24] tty: serial: fsl_lpuart: Drop unnecessary extra parenthesis
Date:   Mon, 29 Jul 2019 12:52:13 -0700
Message-Id: <20190729195226.8862-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary extra parenthesis in the driver.

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
 drivers/tty/serial/fsl_lpuart.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5181ba5d8f71..5a1e19733353 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1443,7 +1443,7 @@ static int lpuart_startup(struct uart_port *port)
 	lpuart_setup_watermark(sport);
 
 	temp = readb(sport->port.membase + UARTCR2);
-	temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
+	temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
 	writeb(temp, sport->port.membase + UARTCR2);
 
 	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
@@ -1652,7 +1652,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
-		modem |= (UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
+		modem |= UARTMODEM_RXRTSE | UARTMODEM_TXCTSE;
 	else
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
 
@@ -1663,7 +1663,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CSIZE) == CS7)
 		termios->c_cflag |= PARENB;
 
-	if ((termios->c_cflag & PARENB)) {
+	if (termios->c_cflag & PARENB) {
 		if (termios->c_cflag & CMSPAR) {
 			cr1 &= ~UARTCR1_PE;
 			if (termios->c_cflag & PARODD)
@@ -1702,7 +1702,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	sport->port.read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		sport->port.read_status_mask |=	(UARTSR1_FE | UARTSR1_PE);
+		sport->port.read_status_mask |= UARTSR1_FE | UARTSR1_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
 		sport->port.read_status_mask |= UARTSR1_FE;
 
@@ -1816,7 +1816,7 @@ lpuart32_serial_setbrg(struct lpuart_port *sport, unsigned int baudrate)
 		tmp |= UARTBAUD_BOTHEDGE;
 
 	tmp &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
-	tmp |= (((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT);
+	tmp |= ((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT;
 
 	tmp &= ~UARTBAUD_SBR_MASK;
 	tmp |= sbr & UARTBAUD_SBR_MASK;
@@ -1869,7 +1869,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	if (termios->c_cflag & CRTSCTS) {
-		modem |= (UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
+		modem |= UARTMODEM_RXRTSE | UARTMODEM_TXCTSE;
 	} else {
 		termios->c_cflag &= ~CRTSCTS;
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
@@ -1918,7 +1918,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	sport->port.read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		sport->port.read_status_mask |=	(UARTSTAT_FE | UARTSTAT_PE);
+		sport->port.read_status_mask |= UARTSTAT_FE | UARTSTAT_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
 		sport->port.read_status_mask |= UARTSTAT_FE;
 
@@ -2085,7 +2085,7 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 
 	/* first save CR2 and then disable interrupts */
 	cr2 = old_cr2 = readb(sport->port.membase + UARTCR2);
-	cr2 |= (UARTCR2_TE |  UARTCR2_RE);
+	cr2 |= UARTCR2_TE | UARTCR2_RE;
 	cr2 &= ~(UARTCR2_TIE | UARTCR2_TCIE | UARTCR2_RIE);
 	writeb(cr2, sport->port.membase + UARTCR2);
 
@@ -2116,7 +2116,7 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 
 	/* first save CR2 and then disable interrupts */
 	cr = old_cr = lpuart32_read(&sport->port, UARTCTRL);
-	cr |= (UARTCTRL_TE |  UARTCTRL_RE);
+	cr |= UARTCTRL_TE | UARTCTRL_RE;
 	cr &= ~(UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
 	lpuart32_write(&sport->port, cr, UARTCTRL);
 
@@ -2574,7 +2574,7 @@ static int lpuart_resume(struct device *dev)
 	} else {
 		lpuart_setup_watermark(sport);
 		temp = readb(sport->port.membase + UARTCR2);
-		temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
+		temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
 		writeb(temp, sport->port.membase + UARTCR2);
 	}
 
-- 
2.21.0

