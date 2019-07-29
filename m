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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D410C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB87621655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ4WwWNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404056AbfG2T7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:59:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46934 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbfG2TxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so27881860plz.13;
        Mon, 29 Jul 2019 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kp9NlyUvWGSuGBjaaMhEx2jUU1orNg+BgS3bQvSUoQ=;
        b=dJ4WwWNl5W0Y8xr4wUOip3VYwrrR2Wy5dKPVcw63R2Fofn+YdzJBK1+DOwhk12m1zX
         adpIP40lZwUSqBLXWw3PfCUpSg2HQ+sK7VJFWOHliIC8C6hDwPehPEiFk5SzJDYViKvG
         KrdIJ49W4Cd20HlaBY9hrrcK306SZclLfmL++wpqY5iBhRDfC4pKpHZQBfwXxan565QT
         Y8GHQTmqUfgnmE8iAw5+I2v7YLcEkGCCSFx7b6b77rnFmnzOZ2tV8p1E3vJ6lqAN1jsM
         QcPvPn5IxrFPSJKaUOTDdUtw6C5nV3q+l/Qhk5+1f4YLZxj95SQY0TArfbxNGDkl0N3N
         nR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kp9NlyUvWGSuGBjaaMhEx2jUU1orNg+BgS3bQvSUoQ=;
        b=KgQZG6v2qbgC+5ZSDR/Ty+fhyobGGbAmHm4X+muSCx5N9tDKNaPBaYjgxB8H1SfdlM
         ZMhMTWsw2Y03LxbIqb4ggzPHMtvNvEgOLjzhvuM6Omin3HUS06/ghjqVwuWtv6OYs+Av
         vsyryPNME6zYIaFaPYzSFU7Swm9pJEAdg70emHMRxNZlbuL8kxdEHVU5dUdZcS2q6gVN
         nR7PUzuHGowSFRF73WHWFVW4yF2jSlDofCMdGpFne5C1hUU/gQyk75xN8wm5hfJpUecH
         bVji9LGFkxyunJNoHrh1gTnyk4preB0tDfiaIqz+p2yjIiFc3nR0r9di3yZfMjYRHms7
         ZMtw==
X-Gm-Message-State: APjAAAWuouo9cnDC4v6m3pduoj0KkYPk3WWfo9ZTzeeYnisf6SSwx1Fd
        tE5rMeouQrVQuDbJ+PbsG+0ZBkiV
X-Google-Smtp-Source: APXvYqz4bLV800O6SVQamkGgA98ToKg19UzIkdYDx8IpNv+UwxaBwOLtOjhx0V2M7hHuCjrpiQuEPg==
X-Received: by 2002:a17:902:bd49:: with SMTP id b9mr17569555plx.343.1564429983541;
        Mon, 29 Jul 2019 12:53:03 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:02 -0700 (PDT)
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
Subject: [PATCH 13/24] tty: serial: fsl_lpuart: Use appropriate lpuart32_* I/O funcs
Date:   Mon, 29 Jul 2019 12:52:15 -0700
Message-Id: <20190729195226.8862-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
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
 drivers/tty/serial/fsl_lpuart.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 10f1af51c58d..50a707c88a16 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -616,26 +616,26 @@ static int lpuart32_poll_init(struct uart_port *port)
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
@@ -643,18 +643,18 @@ static int lpuart32_poll_init(struct uart_port *port)
 
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

