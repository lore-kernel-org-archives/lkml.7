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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5B2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D834C2182B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLl5ZrY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403955AbfG2TxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:53:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42556 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403808AbfG2Twt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so28763559pgb.9;
        Mon, 29 Jul 2019 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSaHP0QqkD0s9itI8zThvuVWmdKrdr4qQiU1/5TRtVY=;
        b=KLl5ZrY+FHLEnaKKmPNzNyRaXomnJvIlw5WwWHtjyFMT3Em1Sf+5n4R84/NetDIyZc
         nBj6tmZ+q6nz2ff7EtN+W3ZVMT6lbaIDPN/soMcRG777RJm9G9Yxi0W9GHU01/chwaXu
         SD3X37AmZ9P9xvlFUv+QIPKC8akkJ/oEZEVgWA6c/tXpn4Go79aAkojC7csVd6cRhUtz
         8MQ4cAAGFSMjXAYldJnyz0de6asyFctxu5mYG0rbswk/RfN2h5nmyErWnkIum/GfdSxC
         GitLjKNvnV3j9qb6OebkqQWOD+jqS/KNHW0IFGqEtbe813XRpN6UKWzyztu9xPC0dvcc
         5irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSaHP0QqkD0s9itI8zThvuVWmdKrdr4qQiU1/5TRtVY=;
        b=JkVcvrJW8xhxkvwVQwlPukLanoan8eVvkKVpzn+El2lsOCPgjzyZrXm5kMqYaiBYlS
         /mjw4MbzBZwQX1XZEfeVWX3Fc0ILnxfv9H0nPxH/8yrL32nIsei87hAsIwfCqcb/ISMf
         5A8Mhcy5fqdZiyYb2YBtHbLOnYgkwReUMSw77EcFcfbsWIsOpIeTMciVeT49xJUpcEv5
         G0OmyWOWRXO9hwntQRoE+Davs8tC/Jed+Ezs7ZC4+AsAZwFDXnB0w/KKwC324DgGQWlc
         9/nj2ksTO5lVnWD0aURAuqjZV0JtYjQprYcY6nnnZvPbWnxczaJCX5uOUUoqe5OPSwVV
         AAHA==
X-Gm-Message-State: APjAAAWKLe6Z1tQtBhrIuhjULkCrr5CQbdW/mN903K6OqOraD9t04sjy
        w+aIKX9+/DIuFN+Ife7451/dTPqS
X-Google-Smtp-Source: APXvYqwK+8MFBJYhqU57T1JP6Eg7Bn/WXrT3D67wHlKHTUcyE6NiMd/0soZIJqdj7gB8RTNU9kbTug==
X-Received: by 2002:a63:1f1b:: with SMTP id f27mr10071440pgf.233.1564429967729;
        Mon, 29 Jul 2019 12:52:47 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:47 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/24] tty: serial: fsl_lpuart: flush receive FIFO after overruns
Date:   Mon, 29 Jul 2019 12:52:04 -0700
Message-Id: <20190729195226.8862-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
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
 drivers/tty/serial/fsl_lpuart.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 586b3513a6b0..edb1a9425fac 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -798,7 +798,7 @@ static irqreturn_t lpuart_txint(int irq, void *dev_id)
 static irqreturn_t lpuart_rxint(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned int flg, ignored = 0;
+	unsigned int flg, ignored = 0, overrun = 0;
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags;
 	unsigned char rx, sr;
@@ -825,7 +825,7 @@ static irqreturn_t lpuart_rxint(int irq, void *dev_id)
 				sport->port.icount.frame++;
 
 			if (sr & UARTSR1_OR)
-				sport->port.icount.overrun++;
+				overrun++;
 
 			if (sr & sport->port.ignore_status_mask) {
 				if (++ignored > 100)
@@ -852,6 +852,17 @@ static irqreturn_t lpuart_rxint(int irq, void *dev_id)
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

