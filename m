Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9E8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28717204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2IbrWF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404388AbfG2UAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:00:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42911 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403942AbfG2Twr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so27945661plb.9;
        Mon, 29 Jul 2019 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AW6LMocj5hW2ma4xyQWGmJ4mCwXZHVoAaKb26+6JOqU=;
        b=R2IbrWF+DWj6Lm+yjxhSXwPkwYhCeoZ3XjJpiJwOXmMXScwneZ8iFaQTPTCtSAnTJg
         l2ChGDs3Jx8GSDYqbi+VBxbONHRI0JfZYWmjCgGOI0Nhyasb3/Ratc6S8rr4oElIcJc3
         4qneIgG/5Iq7y7L2NFwh/6C99Bl8auwsJCI4A23txlBIadIvnqFx0UqZ3Df/nu4unm4H
         mYIiD+RE2XYfRd4mk6lNCqnke+mVvcOX90TQgDFphhp77NSt3QyoqBQGww0WaSsT50Lm
         Y4yT2IKho0wlqCb36V5YUUzbzf5tMyw7KozhTICSt6Be5f9aQPJICNAFPKD40/yQ7MhK
         zFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AW6LMocj5hW2ma4xyQWGmJ4mCwXZHVoAaKb26+6JOqU=;
        b=F5ypR2DpNT45hp2Ns/cb/FtbNeoTlJ8dyWbzGjQas5ipA346xgNcb1U5coL7bx1S4q
         W12+urmXITDSX98nM1Yfx2j+AzpPXrkfmeYZlbpR48xVboyx6yi6TAJ5OdvpJDJ48mbd
         Mq97tqBx5JR3SuhlmpCvbeAG3sQTBoAmPXIjzFlmvft7eKA8qEUxfbItB19IbIaSLuGT
         cIyyFabtQHUqCX3TC5F2OvIE/hqf9JMXicftx3kG+kIuXluHAW/4NRPLHzvappZgih42
         vY2TOmZRfWIuVGGla93cAvfyn+0/MkhaEz4irgmM4sPXvpPNgnMC7UXfhiNeLgkMpaqG
         fBaQ==
X-Gm-Message-State: APjAAAWE/KfeIW9aCpuMA/Tw7LLDxMsIsS+hUoxQNaFCPteK28wjrHjY
        i9cM+9NZGzKuF7dppQ5Q21k/Q4hC
X-Google-Smtp-Source: APXvYqx7eyZEQtwcnz8KsGTMp8ScnAvPm9o4n/MSu85csalV4FSCwTzLWhUP+PTw+bZopJjuKTtHqA==
X-Received: by 2002:a17:902:8205:: with SMTP id x5mr113404804pln.279.1564429966178;
        Mon, 29 Jul 2019 12:52:46 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:45 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/24] tty: serial: fsl_lpuart: fix framing error handling when using DMA
Date:   Mon, 29 Jul 2019 12:52:03 -0700
Message-Id: <20190729195226.8862-2-andrew.smirnov@gmail.com>
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
 drivers/tty/serial/fsl_lpuart.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 92dad2b4ec36..586b3513a6b0 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -982,6 +982,13 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
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
 
@@ -989,6 +996,25 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
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

