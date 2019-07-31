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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF22BC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C590B20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7emTE/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfGaRbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44096 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfGaRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so32383580pgl.11;
        Wed, 31 Jul 2019 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyLT7hSjTKCoy5pu8GW06Bk6izFaRzdbq6tARdGHvhA=;
        b=P7emTE/lFVHA5mlyKcHK6ujqZ254QE5NLfbUqE6zmUnRRPKdZZR+ISSq5dCgyIRBag
         5EzwrFOtRO5xzIHYF140UrxgOjTh16MR3DnsU41+8BCHR8w1fKvKjKsSZVmgru6MbIsa
         opeqdipo459Szq6D/Qr55tZ0SPN6lAFGyQrLIGZlHc324VHAE4iEfFpltBIi8QLbxT/b
         FUl/4NehLSGlLQzZN2UfocGhRRM9G01XtT28FWxVtUR9lleUzfR8ec5EjD8XiIDuYVA2
         7A2tNQhnyI5Os2C9hCxAZELAiYOrA/mxLOMsB7Bxje9xrUs3NgvyDxf6i8z8IOJKO7kZ
         MkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyLT7hSjTKCoy5pu8GW06Bk6izFaRzdbq6tARdGHvhA=;
        b=ptSyrcJOIIScM7eIa6UXivLDqJsPbSxdlKuv7RsZqpfNLWKalhRb/3bNMWTwWst2DM
         Lf1ZdL8oJNsW/Bw6FvAxRKtWUufJ02hGdm9iqPz1Di5G/i/U81+lTytmTKa6rgdyRspb
         NJRL5YWavI1wRDe89fb4poqJwcSc8t8UsKOP1XYm2cC5h3veKoqXT1NKrolY40VHS1Vd
         TUJR6VG1/DkrD0d/TJ5Ru25dEa2xCkDac4Ddwf/yGu0SRVg4ZUN+Drlxq+B2qs+uAjm4
         0CXMUXUCrInnOsSww6mSfmDk92LTngZo+P2d1nywqn3m7OR5UUYmGLwN69S5GM9pQA7Z
         9+Yg==
X-Gm-Message-State: APjAAAVKoYgYUrg9sTTETpSlR6Wr5z+4VIxVM5g63Q9Yk/4say73IX+y
        oE7Joa9555XwSNayRFMtMAfZ5R8iQTc=
X-Google-Smtp-Source: APXvYqy1bAKY0QeLwwLLdGi/T/Y9m8qBk7BNv+IPIJSZR8lQPqnUvrqSUJ6Se+f2B+uXc3zA5DZ7Uw==
X-Received: by 2002:a17:90a:9dca:: with SMTP id x10mr4130069pjv.100.1564594292067;
        Wed, 31 Jul 2019 10:31:32 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:31 -0700 (PDT)
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
Subject: [PATCH v2 12/23] tty: serial: fsl_lpuart: Use appropriate lpuart32_* I/O funcs
Date:   Wed, 31 Jul 2019 10:30:34 -0700
Message-Id: <20190731173045.11718-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dealing with 32-bit variant of LPUART IP block appropriate I/O
helpers have to be used to properly deal with endianness
differences. Change all of the offending code to do that.

Fixes: a5fa2660d787 ("tty/serial/fsl_lpuart: Add CONSOLE_POLL support
for lpuart32.")
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
 drivers/tty/serial/fsl_lpuart.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index a0f38d7caa76..395df8c7e1d5 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -617,26 +617,26 @@ static int lpuart32_poll_init(struct uart_port *port)
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	/* Disable Rx & Tx */
-	writel(0, sport->port.membase + UARTCTRL);
+	lpuart32_write(&sport->port, UARTCTRL, 0);
 
-	temp = readl(sport->port.membase + UARTFIFO);
+	temp = lpuart32_read(&sport->port, UARTFIFO);
 
 	/* Enable Rx and Tx FIFO */
-	writel(temp | UARTFIFO_RXFE | UARTFIFO_TXFE,
-		   sport->port.membase + UARTFIFO);
+	lpuart32_write(&sport->port, UARTFIFO,
+		       temp | UARTFIFO_RXFE | UARTFIFO_TXFE);
 
 	/* flush Tx and Rx FIFO */
-	writel(UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH,
-			sport->port.membase + UARTFIFO);
+	lpuart32_write(&sport->port, UARTFIFO,
+		       UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH);
 
 	/* explicitly clear RDRF */
-	if (readl(sport->port.membase + UARTSTAT) & UARTSTAT_RDRF) {
-		readl(sport->port.membase + UARTDATA);
-		writel(UARTFIFO_RXUF, sport->port.membase + UARTFIFO);
+	if (lpuart32_read(&sport->port, UARTSTAT) & UARTSTAT_RDRF) {
+		lpuart32_read(&sport->port, UARTDATA);
+		lpuart32_write(&sport->port, UARTFIFO, UARTFIFO_RXUF);
 	}
 
 	/* Enable Rx and Tx */
-	writel(UARTCTRL_RE | UARTCTRL_TE, sport->port.membase + UARTCTRL);
+	lpuart32_write(&sport->port, UARTCTRL, UARTCTRL_RE | UARTCTRL_TE);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	return 0;
@@ -644,18 +644,18 @@ static int lpuart32_poll_init(struct uart_port *port)
 
 static void lpuart32_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	while (!(readl(port->membase + UARTSTAT) & UARTSTAT_TDRE))
+	while (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_TDRE))
 		barrier();
 
-	writel(c, port->membase + UARTDATA);
+	lpuart32_write(port, UARTDATA, c);
 }
 
 static int lpuart32_poll_get_char(struct uart_port *port)
 {
-	if (!(readl(port->membase + UARTSTAT) & UARTSTAT_RDRF))
+	if (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_RDRF))
 		return NO_POLL_CHAR;
 
-	return readl(port->membase + UARTDATA);
+	return lpuart32_read(port, UARTDATA);
 }
 #endif
 
-- 
2.21.0

