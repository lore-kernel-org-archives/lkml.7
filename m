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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BEAC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFC220679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT9azT16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfGaRbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39294 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730593AbfGaRbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so30832977pls.6;
        Wed, 31 Jul 2019 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4CAPfa7bKBiVOxNpzdai0coxa1oaSp0dwsEN7w5wwg=;
        b=cT9azT16+c2zMSZ6czEvoUm6kcTiB4XmzsZzkuT4fX6nEL6tFjDSUXhCFR0uRRxlsY
         PDmb3dz4rO0UKCQWmWkPeO6WPojg9uMpEKDpabfWRFhptevuV2M7EB8c1z10qNhryl5v
         VMjUoEtEqS/UcdabVPUtc72di4y6R7QsI9UJHw0+BSCnJ0/Uk7HBil+XYRZnI+Zeuovf
         97uAm9OpWmLLFyVGn+h+Bn71BxDag0lGa3X4r6ZKtBIMMC8svG063hdnn9Gg4LxZaWVl
         KZBtI3fAwfTUEi5Kk7cMrWWmE5/FxMven/Un5pQpTxJb2ane6uDDNJsQvcxmW+LmAU3n
         KrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4CAPfa7bKBiVOxNpzdai0coxa1oaSp0dwsEN7w5wwg=;
        b=QkLkrJeUWiQSPfXaF/H1n7t+Q9BCJH0y1malVs4K4GPlknn882ofC6ibLCpp3z0+Nt
         FYN+lcViX0IIs00scQXNc1osDhc5he/wSh1fktOwHDg5Kuz+/4vgQgkW3NKuMbKb0RNX
         o/nQwxcc+cTmDhW1Zg9AVKvMsLDwc6bZZzFeTSkPVTnPJd2DTwV3W9kElR2Ve8bIvqDR
         rCylkAJyw4kqW7Ynk8JNAAPZfJXOMpoiZacfSoDqGDJW8rb4lnIh2+fI73V9QOhZwH2C
         FLTGOtajZRBIsovr+3XKxiq9AXIfFpq8tHXXLZttpGVygxMl8LEekvBBxB6evtW2V9CB
         /4nQ==
X-Gm-Message-State: APjAAAWXuov7yd0FJQjwiMrPKuVvDWLoBTtIynfWM0BHoYsTtrPn/CyL
        KANYRMkQ4Vg6XRBCuGjRGuw/oiT4
X-Google-Smtp-Source: APXvYqwqWeXtwVwGc6eX9wBirn3Qg0BuBNu6IUWzV6uXiSB9WmQLVJKaD1IR3Nfzk5EpsCEWYS1nPg==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr123618991plz.38.1564594270608;
        Wed, 31 Jul 2019 10:31:10 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:10 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/23] tty: serial: fsl_lpuart: flush receive FIFO after overruns
Date:   Wed, 31 Jul 2019 10:30:24 -0700
Message-Id: <20190731173045.11718-3-andrew.smirnov@gmail.com>
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

After overruns the FIFO pointers become misaligned. This
typically shows by characters still being stuck in the FIFO
despite the empty flag being asserted. After the first
assertion of the overrun flag the empty flag still seems to
indicate FIFO state correctly and all data can be read.
However, after another overrun assertion the FIFO seems to
be off by one such that the last received character is still
in the FIFO (despite the empty flag being asserted).

Flushing the receive FIFO reinitializes pointers. Hence it
is recommended to flush the FIFO after overruns, see also:
https://community.nxp.com/thread/321175

Hence, on assertion of the overrun flag read the remaining
data from the FIFO and flush buffers.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Acked-by: Max Krummenacher <max.krummenacher@toradex.com>
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
 drivers/tty/serial/fsl_lpuart.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 0643fa368d35..317bbc1dd2b4 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -799,7 +799,7 @@ static irqreturn_t lpuart_txint(int irq, void *dev_id)
 static irqreturn_t lpuart_rxint(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned int flg, ignored = 0;
+	unsigned int flg, ignored = 0, overrun = 0;
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags;
 	unsigned char rx, sr;
@@ -826,7 +826,7 @@ static irqreturn_t lpuart_rxint(int irq, void *dev_id)
 				sport->port.icount.frame++;
 
 			if (sr & UARTSR1_OR)
-				sport->port.icount.overrun++;
+				overrun++;
 
 			if (sr & sport->port.ignore_status_mask) {
 				if (++ignored > 100)
@@ -853,6 +853,17 @@ static irqreturn_t lpuart_rxint(int irq, void *dev_id)
 	}
 
 out:
+	if (overrun) {
+		sport->port.icount.overrun += overrun;
+
+		/*
+		 * Overruns cause FIFO pointers to become missaligned.
+		 * Flushing the receive FIFO reinitializes the pointers.
+		 */
+		writeb(UARTCFIFO_RXFLUSH, sport->port.membase + UARTCFIFO);
+		writeb(UARTSFIFO_RXOF, sport->port.membase + UARTSFIFO);
+	}
+
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	tty_flip_buffer_push(port);
-- 
2.21.0

