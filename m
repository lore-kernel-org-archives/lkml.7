Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A91C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A4621734
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhbwDZ3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfHES5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:57:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36917 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbfHES5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:57:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so40091102pfa.4;
        Mon, 05 Aug 2019 11:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VdUzTwa+OjzYQgE6vtFVuX6c9hPKU8SQFqp6Wy3beoE=;
        b=mhbwDZ3nlvhLAwJKo7WM78d4RYMu3zRSi2QTG1gFGHFiLXFhqRXiav/ZJdMnKPndeJ
         lZq0KEnmbNlvZY6LDDa9NyLHBvOcRZoHzL1E66T4EcX2oG27pOCCJuRUqef9Ac0MT29i
         qx1GhfoO2x/qH8Nt+aIikUNaPS565DmGsYnj2d5FFy1f6oV7WEWZeinAYw9iuDupmhjT
         g24SNXcEzI6KDdmD3vMj9jBdTZ3PYdyNVoh8NVcsQcXnS/RPDMa+7+BMx9WT3FZo0GRT
         C5956Oh5AYJUR0K+5SqdaSpFd6LsO4MtymwKl+V8A91yKXEq/vpcVAgeOn/uqXUM6wHS
         jr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdUzTwa+OjzYQgE6vtFVuX6c9hPKU8SQFqp6Wy3beoE=;
        b=YOOB9BJGjoB2mXhisywc9QzC+DtbPS4UE85UoOaN7ScBxHV/g0RyqwzLMPpQH9zHxH
         vVyeGoQ2GVPIMap8QJTnLAfq2eFB+kyYsmSQ+ZSvdRDkjqbyT4u8c6Y+ZQDOp/GNsDi1
         1wBq2HhE4cbkJgrdGPhkYXrnGN00w2UDfch5uGW6Jn7YyHCq/1a6B+xXa/gdn5N1xUzp
         2ToG1kD+x0rR7cKcJYcsZqUxyFb13n1grpuibNjNFeje3iipbLt1QAgsHqgMtZN7RTtw
         8/92q13tLW/5NVTZbySlGkkKZR99J4wkKCBOoFd03mtW7iNx5L3zGR6GuBBxt89yK0vg
         8OcA==
X-Gm-Message-State: APjAAAWD1EDQVsO1uduiTlALBkPgoobBW//Vt6N9lrNS9Zf2IBbW5FWd
        gJaZh1UBYMxBBGdzemMRGu9I27M2
X-Google-Smtp-Source: APXvYqzSxOGGpN+FN/BOtK0Bspwn5pbqjnYTqGYz49C3V+RPPYz9uUbB8ATeNO1MMHZvctU0Upu2Qg==
X-Received: by 2002:a63:790d:: with SMTP id u13mr25883505pgc.232.1565031453562;
        Mon, 05 Aug 2019 11:57:33 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k64sm16037959pgk.74.2019.08.05.11.57.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 11:57:32 -0700 (PDT)
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
Subject: [PATCH v3 6/6] tty: serial: fsl_lpuart: Ignore TX/RX interrupts if DMA is enabled
Date:   Mon,  5 Aug 2019 11:57:01 -0700
Message-Id: <20190805185701.22863-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190805185701.22863-1-andrew.smirnov@gmail.com>
References: <20190805185701.22863-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a mixed DMA/IRQ use-case (e.g.: DMA for TX, IRQ for RX), interrupt
handler might try to handle Rx/Tx condition it shouldn't. Change the
code to only handle TX/RX event if corresponding path isn't being
handled by DMA.

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
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5c3cc1051aa8..3e17bb8a0b16 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -967,10 +967,10 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 
 	sts = readb(sport->port.membase + UARTSR1);
 
-	if (sts & UARTSR1_RDRF)
+	if (sts & UARTSR1_RDRF && !sport->lpuart_dma_rx_use)
 		lpuart_rxint(sport);
 
-	if (sts & UARTSR1_TDRE)
+	if (sts & UARTSR1_TDRE && !sport->lpuart_dma_tx_use)
 		lpuart_txint(sport);
 
 	return IRQ_HANDLED;
-- 
2.21.0

