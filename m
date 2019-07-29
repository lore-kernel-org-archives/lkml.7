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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7CDC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1E12054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgrBHmVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390838AbfG2TxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:53:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39051 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388511AbfG2Twu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so28772476pgi.6;
        Mon, 29 Jul 2019 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZybvyzKqpU4oPoCBYrIT2ASoiu315DqUEs+msQVN1Wk=;
        b=XgrBHmVxvkxSNwoaWTbONdqzHFMbWr4AH98Y51n2MJNbmeKLWsT/HnL58yeWNO7/RE
         2DqduHNgp4tSdgQEvauyEW9T5LED27uwDzxqSwu/TVHAkbHZ+26RPM1TGzWwN3mi1Ss6
         a7jRTdpKsKIqG+OBjdOkywGIsie8RIem9rOJPsVgcUiMueyMdv0hS5TVbCmInt1HqUDb
         N8QVanNINk5nXSlDA9cs77zylZRXaciGF2w60QaIOBc9wTG1ZP0P3zwjAjSS5kHCLpn6
         ljGOQCfVg0rcmO5rM7WlkGU4DmtYcUeGGuuFp4Wf3CMvkkpIEfGhW4ykeHVzMiBJXe+E
         1sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZybvyzKqpU4oPoCBYrIT2ASoiu315DqUEs+msQVN1Wk=;
        b=J2SzIYQ4B73SAq3pVhabl/kzjTvS/pqXjxd9BkJTPDT6jmXf7cOZTorbshustkkHJm
         m7g36yr1ANZaOsqYGgZEuTkYdnJunl6ssRIB71AwwVvQwTb5D7IRhJtTGmFjqpYMnKpd
         Zj43iq1INNlsl2AeAE1UXRHisJi/EJjb6P93GAmUUd4PEq8XKy+3NSClXAyLQtNOXkRD
         B7/kgpV45wzU/gcRhzD3hf0g3IhfoyUDFHP72lswfZp4XoLw/KaG1w5BhW7rdRR5obSs
         nmteEPqk20/VDlJNa/kUu/HeYlQv43ewKNuMBFUHisQ6Pp0HBxMQekfbAxk1IZy9nB7f
         9jLw==
X-Gm-Message-State: APjAAAU3XHp+G6ifK4FiiFUzNl0cp44BHUVikWyo6dtI46wOSXp1bOS+
        JHI+vZjfDTJiqzL0A64hW9+YqJsi
X-Google-Smtp-Source: APXvYqyOFZOFmd+OGrpceXnPd85a571mancWj08pkt/QlosqHQmGMlPOqgYQkcTJKjZoW1lBA15lVg==
X-Received: by 2002:a63:2364:: with SMTP id u36mr102326172pgm.449.1564429969160;
        Mon, 29 Jul 2019 12:52:49 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:48 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/24] tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer
Date:   Mon, 29 Jul 2019 12:52:05 -0700
Message-Id: <20190729195226.8862-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching baud rate might cause bogus data to appear in HW
FIFO. Add code to do a HW FIFO flush to .flush_buffer callback to
avoid that.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
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
 drivers/tty/serial/fsl_lpuart.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index edb1a9425fac..56423ad02f0f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -517,9 +517,16 @@ static int lpuart_dma_tx_request(struct uart_port *port)
 	return 0;
 }
 
+static bool lpuart_is_32(struct lpuart_port *sport)
+{
+	return sport->port.iotype == UPIO_MEM32 ||
+	       sport->port.iotype ==  UPIO_MEM32BE;
+}
+
 static void lpuart_flush_buffer(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
+	u32 val;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (sport->dma_tx_in_progress) {
@@ -529,6 +536,16 @@ static void lpuart_flush_buffer(struct uart_port *port)
 		}
 		dmaengine_terminate_all(sport->dma_tx_chan);
 	}
+
+	if (lpuart_is_32(sport)) {
+		val = lpuart32_read(&sport->port, UARTFIFO);
+		val |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
+		lpuart32_write(&sport->port, val, UARTFIFO);
+	} else {
+		val = readb(sport->port.membase + UARTPFIFO);
+		val |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
+		writeb(val, sport->port.membase + UARTCFIFO);
+	}
 }
 
 #if defined(CONFIG_CONSOLE_POLL)
@@ -753,12 +770,6 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 	return 0;
 }
 
-static bool lpuart_is_32(struct lpuart_port *sport)
-{
-	return sport->port.iotype == UPIO_MEM32 ||
-	       sport->port.iotype ==  UPIO_MEM32BE;
-}
-
 static irqreturn_t lpuart_txint(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-- 
2.21.0

