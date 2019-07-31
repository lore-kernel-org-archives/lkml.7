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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDBC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72B7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+5s0UTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfGaRbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47044 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730740AbfGaRbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so9117558pfa.13;
        Wed, 31 Jul 2019 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3py4SL+FEb0M5NjbK3Ciwljlgw2tqU0mcz+OYfcvKhA=;
        b=k+5s0UTQZ2YvHkzXPVTh55yj5pKx4Z0duMTLQGvi4lS9zWBz3NJ+zMwve+nN3ekTob
         gTZb5huwQX6exjWFvJCAdBd5OJlBliPLHsyczffG8sPM952UTGcsDIwfoo984YP9iT8t
         +jBPPIqwP2m82oz0ei+JS/rRQUgdG1AN4YUVJ4GkDpefGWPtYi0pOKmXc5vdUhUk/3L/
         RKZS15d8m7AwT0RpAez6ecw76LL4EtCxTkk5RoBJprBiGjhxBxH9dWxHNqgWOJXnezuw
         5F4F8uOF/Wp7cf0httZTNNDUPJBrH23gwB32fNLrPte+1S430xBR/ozGFSOKQZYcFHNb
         6C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3py4SL+FEb0M5NjbK3Ciwljlgw2tqU0mcz+OYfcvKhA=;
        b=ema8DYK3m63oNQuvm/ecgXN2nlI7y4IQ92l6LTTEed02JlCzhy/myHpjTrKGDmMJL5
         XFwJFuXs+qTUe6WfAOwDXFgXvZlYe7wJqXxXdXRr4UO+KGooJNaWvWOGoFyW9loiPE3P
         g2eCEPgv4OnSV26VUukoxINS92xDJKzSYVym7QSVai11IT+Vj8rxPREl10Ysq22GqNj7
         vQqeJggpL4K+DLytjpocOMZTLrtpibtvVPlWbYo6E1LJ6kK12fPcZ74xRciDPiNeGb5N
         o3DrFLclJ1Be43h8jFVLLeWJU4L0g9KZK/kFJmvm1jQjaCCMCnd+HmAm7oskDSUxzGzI
         h1wg==
X-Gm-Message-State: APjAAAV6RYTO6tLpTZyOWdWGbOrFp8DlCPohO80OlCqepQglOEIZgnW/
        oFg9g0/X0cpNDDjD74FlqY2aGYqrJAU=
X-Google-Smtp-Source: APXvYqy4IbqSybl4W+hR1KUdFiOAvkVPbqukT1mKctk829FyXpa1SU/TI1OB4hKmRCn89e2fo3d7Ug==
X-Received: by 2002:aa7:8b52:: with SMTP id i18mr49378249pfd.194.1564594294497;
        Wed, 31 Jul 2019 10:31:34 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:33 -0700 (PDT)
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
Subject: [PATCH v2 13/23] tty: serial: fsl_lpuart: Introduce lpuart_wait_bit_set()
Date:   Wed, 31 Jul 2019 10:30:35 -0700
Message-Id: <20190731173045.11718-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Busy polling on a bit in a register is used in multiple places in the
driver. Move it into a shared function.

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
 drivers/tty/serial/fsl_lpuart.c | 42 +++++++++++++++++----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 395df8c7e1d5..eb748ef85da7 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -549,6 +549,20 @@ static void lpuart_flush_buffer(struct uart_port *port)
 	}
 }
 
+static void lpuart_wait_bit_set(struct uart_port *port, unsigned int offset,
+				u8 bit)
+{
+	while (!(readb(port->membase + offset) & bit))
+		barrier();
+}
+
+static void lpuart32_wait_bit_set(struct uart_port *port, unsigned int offset,
+				  u32 bit)
+{
+	while (!(lpuart32_read(port, offset) & bit))
+		barrier();
+}
+
 #if defined(CONFIG_CONSOLE_POLL)
 
 static int lpuart_poll_init(struct uart_port *port)
@@ -592,9 +606,7 @@ static int lpuart_poll_init(struct uart_port *port)
 static void lpuart_poll_put_char(struct uart_port *port, unsigned char c)
 {
 	/* drain */
-	while (!(readb(port->membase + UARTSR1) & UARTSR1_TDRE))
-		barrier();
-
+	lpuart_wait_bit_set(port, UARTSR1, UARTSR1_TDRE);
 	writeb(c, port->membase + UARTDR);
 }
 
@@ -644,9 +656,7 @@ static int lpuart32_poll_init(struct uart_port *port)
 
 static void lpuart32_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	while (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_TDRE))
-		barrier();
-
+	lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TDRE);
 	lpuart32_write(port, UARTDATA, c);
 }
 
@@ -1722,8 +1732,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
-	while (!(readb(sport->port.membase + UARTSR1) & UARTSR1_TC))
-		barrier();
+	lpuart_wait_bit_set(&sport->port, UARTSR1, UARTSR1_TC);
 
 	/* disable transmit and receive */
 	writeb(old_cr2 & ~(UARTCR2_TE | UARTCR2_RE),
@@ -1938,8 +1947,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
-	while (!(lpuart32_read(&sport->port, UARTSTAT) & UARTSTAT_TC))
-		barrier();
+	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
 
 	/* disable transmit and receive */
 	lpuart32_write(&sport->port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
@@ -2054,17 +2062,13 @@ static struct lpuart_port *lpuart_ports[UART_NR];
 #ifdef CONFIG_SERIAL_FSL_LPUART_CONSOLE
 static void lpuart_console_putchar(struct uart_port *port, int ch)
 {
-	while (!(readb(port->membase + UARTSR1) & UARTSR1_TDRE))
-		barrier();
-
+	lpuart_wait_bit_set(port, UARTSR1, UARTSR1_TDRE);
 	writeb(ch, port->membase + UARTDR);
 }
 
 static void lpuart32_console_putchar(struct uart_port *port, int ch)
 {
-	while (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_TDRE))
-		barrier();
-
+	lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TDRE);
 	lpuart32_write(port, ch, UARTDATA);
 }
 
@@ -2090,8 +2094,7 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 	uart_console_write(&sport->port, s, count, lpuart_console_putchar);
 
 	/* wait for transmitter finish complete and restore CR2 */
-	while (!(readb(sport->port.membase + UARTSR1) & UARTSR1_TC))
-		barrier();
+	lpuart_wait_bit_set(&sport->port, UARTSR1, UARTSR1_TC);
 
 	writeb(old_cr2, sport->port.membase + UARTCR2);
 
@@ -2121,8 +2124,7 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 	uart_console_write(&sport->port, s, count, lpuart32_console_putchar);
 
 	/* wait for transmitter finish complete and restore CR2 */
-	while (!(lpuart32_read(&sport->port, UARTSTAT) & UARTSTAT_TC))
-		barrier();
+	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
 
 	lpuart32_write(&sport->port, old_cr, UARTCTRL);
 
-- 
2.21.0

