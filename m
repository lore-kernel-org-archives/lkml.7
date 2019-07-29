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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4CCC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A532171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpJkNgj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404025AbfG2Txk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:53:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33859 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390874AbfG2TxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so22553094pgc.1;
        Mon, 29 Jul 2019 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2y38r8Q0fTUiy8MObZ0DDMq4mumMi9GnvU5cAyR8h6E=;
        b=kpJkNgj3WsZARoAj1cZfr10Tm3jhIa7iraYcmvplqd96i9Bf6hQ+cXBxbPpUq0BzHi
         p27BkR6YgSAEUwwsX/oXNUuvD3WWyN05LNZMlegq4KQKUxE40V8wAPi6KPwXSN9q0MVM
         0gpCHB27hLvqfsJkBNUTbMuvqVTEMHUPQ2HAH1Z38ZdTeAd3b+v3P44I9Dvl0orYWKbH
         q/2j6ZI+vyR7EzTZQ5KcGoSEdgvolBXjBfJwFGfrNI0R/6bxfJu3t+9WYvxYpMXMURYb
         OpoIMnI0nhCJTZGK3vThxp2zG9MRy26OjCcjnDAfeKSC3ewelKcziNfUK4GOfR9A0X5I
         weww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2y38r8Q0fTUiy8MObZ0DDMq4mumMi9GnvU5cAyR8h6E=;
        b=X+rz7L8sC4mzfEljlBAx1ag8GryepcJcoQEf4A+se7AN0yVR5WKYlmq+nSMOGblTOa
         RNk7VQkW7j7FMD1pOgbxBGkK1RkYPEWVcNlAXqBbpFY4ER+aulquS9GmDioJFsNXKFa+
         /VOooT+lGVU6Pm7Nc03r1fFBPMt0Ajq9nGi63CYQ+rCasr5p3picS1y7R2sqLzew2Cpp
         S5P0lBDp8t33pdb+vr23ALgyqAk5kcck0Q/mSXT/utbCNKmFkABpExaaNm9D6ku97Mzw
         40hLEkMRk98pSfeQDM7MxP4dcySHnT2gpa9XmwPbNZVzi7dj6SBGbqUoqbFlUlbsE4df
         RYHw==
X-Gm-Message-State: APjAAAWTxok/9kB702fciH2W/5+1X4FRWxWFOk/ZIxrGQfgNbvWT95cs
        yrZmqHgUiRzO2uSGGIMBIUl81v+b
X-Google-Smtp-Source: APXvYqwv/Gzc3AsAr9EMO+oXWBYD1Z6OL9eRMw796+E7AZtDGczw6K42sidsmJ48ZpeITAztoQH5Kg==
X-Received: by 2002:aa7:9514:: with SMTP id b20mr39185079pfp.223.1564429990783;
        Mon, 29 Jul 2019 12:53:10 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:10 -0700 (PDT)
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
Subject: [PATCH 18/24] tty: serial: fsl_lpuart: Introduce lpuart_dma_shutdown()
Date:   Mon, 29 Jul 2019 12:52:20 -0700
Message-Id: <20190729195226.8862-19-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last steps of .shutdown() code are identical for lpuart and lpuart32
cases, so move it all into a standalone subroutine.

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
 drivers/tty/serial/fsl_lpuart.c | 42 ++++++++++++++-------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 67f196f66533..2ad5750fe511 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1548,6 +1548,22 @@ static int lpuart32_startup(struct uart_port *port)
 	return 0;
 }
 
+static void lpuart_dma_shutdown(struct lpuart_port *sport)
+{
+	if (sport->lpuart_dma_rx_use) {
+		del_timer_sync(&sport->lpuart_timer);
+		lpuart_dma_rx_free(&sport->port);
+	}
+
+	if (sport->lpuart_dma_tx_use) {
+		if (wait_event_interruptible(sport->dma_wait,
+			!sport->dma_tx_in_progress) != false) {
+			sport->dma_tx_in_progress = false;
+			dmaengine_terminate_all(sport->dma_tx_chan);
+		}
+	}
+}
+
 static void lpuart_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -1564,18 +1580,7 @@ static void lpuart_shutdown(struct uart_port *port)
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (sport->lpuart_dma_rx_use) {
-		del_timer_sync(&sport->lpuart_timer);
-		lpuart_dma_rx_free(&sport->port);
-	}
-
-	if (sport->lpuart_dma_tx_use) {
-		if (wait_event_interruptible(sport->dma_wait,
-			!sport->dma_tx_in_progress) != false) {
-			sport->dma_tx_in_progress = false;
-			dmaengine_terminate_all(sport->dma_tx_chan);
-		}
-	}
+	lpuart_dma_shutdown(sport);
 }
 
 static void lpuart32_shutdown(struct uart_port *port)
@@ -1595,18 +1600,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (sport->lpuart_dma_rx_use) {
-		del_timer_sync(&sport->lpuart_timer);
-		lpuart_dma_rx_free(&sport->port);
-	}
-
-	if (sport->lpuart_dma_tx_use) {
-		if (wait_event_interruptible(sport->dma_wait,
-					     !sport->dma_tx_in_progress)) {
-			sport->dma_tx_in_progress = false;
-			dmaengine_terminate_all(sport->dma_tx_chan);
-		}
-	}
+	lpuart_dma_shutdown(sport);
 }
 
 static void
-- 
2.21.0

