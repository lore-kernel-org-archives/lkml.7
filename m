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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09498C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D243420679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+KFmR0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfGaRbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43565 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbfGaRbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so32261363pfg.10;
        Wed, 31 Jul 2019 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAkcSMkLtN3GAxedcViIaYgiH1QmaED404G34ozwxpg=;
        b=Q+KFmR0UJ4XxWbpUqg/mm0L6pXxZ8awQCaP2aYllkKMvHaaqtuywYUbljTiQUdOpoV
         lDbIW3WmlH5umuM5TfmKmymAHRMqYIVmq0J0m3J4nbblBa2KlY2EW3eL9cTkGIZEl5CJ
         RC/P08D2zZ3A7BJwnaxciEhsl3mZ58Dbx7h2dH4Yz94eeqTZDVSmuyVmbUh36yM+l56L
         l/3wnhbBEEcRyi9qh5b/pubFsANUjesyLT6BtZ9AOrvyYrF2WvyzWwGHtHgMsnNWCy0V
         ZW87XnwFClkpp1/KM7tQONmThlfafSHtO69l5Z64tM7TrJ9gctmNbTT5/ZeQJsYKdl+V
         q+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAkcSMkLtN3GAxedcViIaYgiH1QmaED404G34ozwxpg=;
        b=Vyznk9TqXQVa11oIaO80a/nnanh05tTluOFsgU6rdsDXL0ca26wUOTtP57LZF17bO4
         U41SukQPpbJlnX1Wc8gb/NcNH4i/L2+TGzS4K0pARU0iA+J5FKamyIMkcHheJrNCeaxM
         fIbNXau2JdZxO+To1n+jyQwm8jeEVH/lt+MSad3OkzI9JSylLpUSx8wL9ro64GeQ6Gls
         //eRI+che9ZHMF7gH5yy0dwkA4pWzcYIkbzjgr+XtoTYLDUqmWV6fXfqucT/cbBcEBEy
         vTXBBPFv/5Z7Tw2zlsHdMJ1yJRkClDr0N7ky2ukspBe/PLKkl3irO9RZMCP7fV1D7ZNs
         xfYg==
X-Gm-Message-State: APjAAAUdYIXQE5No3YNsKeMqtPtu0NUAMP9+7k9WzM4F6C+++foCwd4a
        t2RqvbUmsgHB0C9AuCLBqMp5xhJH
X-Google-Smtp-Source: APXvYqyNcHRP02cbTDO3g5hEx+qA2tSrXME5wXx8IW6SHEZdO/6tWJfGrvu6Lz5BxDlOxyFHaLlHvA==
X-Received: by 2002:a17:90a:9b8a:: with SMTP id g10mr3986429pjp.66.1564594268628;
        Wed, 31 Jul 2019 10:31:08 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:08 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/23] tty: serial: fsl_lpuart: fix framing error handling when using DMA
Date:   Wed, 31 Jul 2019 10:30:23 -0700
Message-Id: <20190731173045.11718-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

When using DMA framing error get cleared properly. However, due
to the additional read from the data register, an underflow in
the receive FIFO buffer occurs (the FIFO pointer gets out of
sync).

Clear the FIFO in case an underflow has occurred. Also disable the
receiver during this operation and when reading the data register to
minimize potential interference.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Acked-by: Max Krummenacher <max.krummenacher@toradex.com>
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
 drivers/tty/serial/fsl_lpuart.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index d15e65f88214..0643fa368d35 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -983,6 +983,13 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 		unsigned char sr = readb(sport->port.membase + UARTSR1);
 
 		if (sr & (UARTSR1_PE | UARTSR1_FE)) {
+			unsigned char cr2;
+
+			/* Disable receiver during this operation... */
+			cr2 = readb(sport->port.membase + UARTCR2);
+			cr2 &= ~UARTCR2_RE;
+			writeb(cr2, sport->port.membase + UARTCR2);
+
 			/* Read DR to clear the error flags */
 			readb(sport->port.membase + UARTDR);
 
@@ -990,6 +997,25 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 				sport->port.icount.parity++;
 			else if (sr & UARTSR1_FE)
 				sport->port.icount.frame++;
+			/*
+			 * At this point parity/framing error is
+			 * cleared However, since the DMA already read
+			 * the data register and we had to read it
+			 * again after reading the status register to
+			 * properly clear the flags, the FIFO actually
+			 * underflowed... This requires a clearing of
+			 * the FIFO...
+			 */
+			if (readb(sport->port.membase + UARTSFIFO) &
+			    UARTSFIFO_RXUF) {
+				writeb(UARTSFIFO_RXUF,
+				       sport->port.membase + UARTSFIFO);
+				writeb(UARTCFIFO_RXFLUSH,
+				       sport->port.membase + UARTCFIFO);
+			}
+
+			cr2 |= UARTCR2_RE;
+			writeb(cr2, sport->port.membase + UARTCR2);
 		}
 	}
 
-- 
2.21.0

