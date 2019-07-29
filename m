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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93150C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E18921655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIaexxXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404007AbfG2Txa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:53:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33843 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390734AbfG2TxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so22552941pgc.1;
        Mon, 29 Jul 2019 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNb4sWfrJHwA/jFMNl6gqnVSRPR3KuBtjcWxEggarxo=;
        b=lIaexxXPWTxK7oKtsvcW5ZsqDX2jZZETIQlQ/aww3n0VGslpELCgoua7U8JJG0Gh5F
         9Kt7ky/pDRa0O9NTR66xrAustgxFXrkp+71KhvbcsMaJ6YPGukituJwjGUf31hN62VE2
         R5UWz3h70VUGVc6OZn60X/tslu0QdWM0bYwLz0D4KDPsjtYD6zj9YqjuNFAKYQ2l2Cwh
         foeTkH/AJgDqZxjQTgTH00GOrjNuGWYdVSbvn1RSexm2l+61GzX8ker8YH+TMsUXpyzp
         0wWn51g6KOXhKlrq17WzkV8z3iObsNMVfii6LYj1VC/ZxtvM1FFdvAJAq6w0pTdLPAcl
         yMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNb4sWfrJHwA/jFMNl6gqnVSRPR3KuBtjcWxEggarxo=;
        b=TygldjJLhJbxhtKVwjphRTUk5l3U5e+k9lHmeOd8sdSpR7Cwyw5ABpCWOpJNkgfEuN
         ZT96nWVAM6ro/Kexc5C336V46E8cp5zD7naYp78SrZ+zSuLqNoD8UsSM+zBM89Jg7iZe
         Kh5HfXBrCVAtleBKIRh1+HUg3Dld85QnpanK4ZyzRJzZ4FR3/3wiGge+oRG7khbu4GTS
         x8rk5XH6yGeLIBJB/ciDqEdZYvY08CMKg8Zl+wrn2zg6Nt6d5FLlG/E/gydkJRkTTnNi
         U7kH8j+B93MeKht0zjCXFoCB8vZJ+mZrE6ZxxMAjBrgyH9K7E+72oK7hCfqs1AugaBhC
         QImw==
X-Gm-Message-State: APjAAAUV2WAMJzwbPuS3IHtPEyM3TGbbOmvdIt/+mRMK8qkZxkYBP3MR
        BFU47D2b9WG/YiM+o8UwQc5wPajc
X-Google-Smtp-Source: APXvYqxcFd4pGn6XPO91nk11sYjASJS6qbSomx2ffQB8dtNLLwQG3yEWsDbd2raXtti6Kuc/Q3OfpA==
X-Received: by 2002:a17:90a:36a7:: with SMTP id t36mr111430672pjb.34.1564429984867;
        Mon, 29 Jul 2019 12:53:04 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:04 -0700 (PDT)
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
Subject: [PATCH 14/24] tty: serial: fsl_lpuart: Introduce lpuart_wait_bit_set()
Date:   Mon, 29 Jul 2019 12:52:16 -0700
Message-Id: <20190729195226.8862-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
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
 drivers/tty/serial/fsl_lpuart.c | 42 +++++++++++++++++----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 50a707c88a16..dde5caf724ff 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -548,6 +548,20 @@ static void lpuart_flush_buffer(struct uart_port *port)
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
@@ -591,9 +605,7 @@ static int lpuart_poll_init(struct uart_port *port)
 static void lpuart_poll_put_char(struct uart_port *port, unsigned char c)
 {
 	/* drain */
-	while (!(readb(port->membase + UARTSR1) & UARTSR1_TDRE))
-		barrier();
-
+	lpuart_wait_bit_set(port, UARTSR1, UARTSR1_TDRE);
 	writeb(c, port->membase + UARTDR);
 }
 
@@ -643,9 +655,7 @@ static int lpuart32_poll_init(struct uart_port *port)
 
 static void lpuart32_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	while (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_TDRE))
-		barrier();
-
+	lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TDRE);
 	lpuart32_write(port, UARTDATA, c);
 }
 
@@ -1723,8 +1733,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
-	while (!(readb(sport->port.membase + UARTSR1) & UARTSR1_TC))
-		barrier();
+	lpuart_wait_bit_set(&sport->port, UARTSR1, UARTSR1_TC);
 
 	/* disable transmit and receive */
 	writeb(old_cr2 & ~(UARTCR2_TE | UARTCR2_RE),
@@ -1939,8 +1948,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
-	while (!(lpuart32_read(&sport->port, UARTSTAT) & UARTSTAT_TC))
-		barrier();
+	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
 
 	/* disable transmit and receive */
 	lpuart32_write(&sport->port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
@@ -2055,17 +2063,13 @@ static struct lpuart_port *lpuart_ports[UART_NR];
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
 
@@ -2091,8 +2095,7 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 	uart_console_write(&sport->port, s, count, lpuart_console_putchar);
 
 	/* wait for transmitter finish complete and restore CR2 */
-	while (!(readb(sport->port.membase + UARTSR1) & UARTSR1_TC))
-		barrier();
+	lpuart_wait_bit_set(&sport->port, UARTSR1, UARTSR1_TC);
 
 	writeb(old_cr2, sport->port.membase + UARTCR2);
 
@@ -2122,8 +2125,7 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 	uart_console_write(&sport->port, s, count, lpuart32_console_putchar);
 
 	/* wait for transmitter finish complete and restore CR2 */
-	while (!(lpuart32_read(&sport->port, UARTSTAT) & UARTSTAT_TC))
-		barrier();
+	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
 
 	lpuart32_write(&sport->port, old_cr, UARTCTRL);
 
-- 
2.21.0

