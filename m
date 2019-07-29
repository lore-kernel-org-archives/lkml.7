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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B780EC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820F6204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2kao3Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390913AbfG2Txs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:53:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46490 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403982AbfG2TxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id k189so9730581pgk.13;
        Mon, 29 Jul 2019 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjyqAkqaIvQVGsGfH/t6cK+RJBb4dW7qrfLLFyN/P5w=;
        b=K2kao3Kjq2Ne/tabINdHqGVbeHrvSXujOJEN1yojuipXmlWQFcQDvq3iCBAe9u7UuV
         bkgRJDvYEDLTwgTdLDU45hzjYIojKDLgNeZcXnSVvepw5itrvZJz8FIDMfJqPbtd3WUn
         89UlsQaZK5ZpdgrHYVuFIqYwKnmHsisOJNfamugg41kce33Lk/S2sc9U9SPMN3Ovqaov
         V+OCkx/Pb+NX5Pn8htAFcyLwZlmRFERi3dEuaEaks907qfNnm1fH43BVrMvZYAcbZ1Fi
         Dg+YfDJgHd0k/bDpJ91YDuWgJvfCQKMJ3cQ8Uc0Nts/tvYpK4ETT6lvaRDbesw6nYVvj
         JInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjyqAkqaIvQVGsGfH/t6cK+RJBb4dW7qrfLLFyN/P5w=;
        b=Z2nFRKq9HCbQy/fbOySDlFcDKKN919r8XodeCAht0RZ7mCPaADusrpJAgN7f+7C5UC
         Iy6qfM4ecW9rg4ZTu7jS5ZfPl214h9xcJ+xFSgVI0WW+MlJnvKF6is6TbC4j5mw/CSKl
         VoI3x9GloN+jra7lwSUh/Q0Trctp6QXLWNBdk8pWg8M1iMIa4J8x8pdNSRXv6NtkqRj9
         i+gUPUmX8frF6mA5vdsdTmrTJ82xlvDTgWhLMD0ZoMoIawo4Y3mynsztrdf5TUSln6dB
         dPV58TuX+mVM0yc6v/+oI4aR4D/OOxwI6Zb1wYCJeeKPVbjdBB3E8J0ifbZbbrtIZL8d
         60pA==
X-Gm-Message-State: APjAAAU/PfeNlJW7PU+xGwo+E+W/Ipam2gapMuyLqdK4J8Olk5jYs6CL
        GrmTuhs5pbww6WxSLDdzw0bG87FY
X-Google-Smtp-Source: APXvYqyrA4tCbq8mGKmYropX7UChScShmjo/JGkhz7lDNiRFU4GDN8jwXhvuwdIpDTYyldp2Y2oAKg==
X-Received: by 2002:a17:90a:1ae2:: with SMTP id p89mr107524395pjp.26.1564429994928;
        Mon, 29 Jul 2019 12:53:14 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:14 -0700 (PDT)
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
Subject: [PATCH 21/24] tty: serial: fsl_lpuart: Introduce lpuart32_configure()
Date:   Mon, 29 Jul 2019 12:52:23 -0700
Message-Id: <20190729195226.8862-22-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code doing final steps of TX/RX configuration in lpuart32_startup()
and lpuart_resume() is identical, so move it into a standalone
subroutine.

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
 drivers/tty/serial/fsl_lpuart.c | 48 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bda01d23cea8..112fb1e19a1c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1502,6 +1502,24 @@ static int lpuart_startup(struct uart_port *port)
 	return 0;
 }
 
+static void lpuart32_configure(struct lpuart_port *sport)
+{
+	unsigned long temp;
+
+	if (sport->lpuart_dma_rx_use) {
+		/* RXWATER must be 0 */
+		temp = lpuart32_read(&sport->port, UARTWATER);
+		temp &= ~(UARTWATER_WATER_MASK << UARTWATER_RXWATER_OFF);
+		lpuart32_write(&sport->port, temp, UARTWATER);
+	}
+	temp = lpuart32_read(&sport->port, UARTCTRL);
+	if (!sport->lpuart_dma_rx_use)
+		temp |= UARTCTRL_RIE;
+	if (!sport->lpuart_dma_tx_use)
+		temp |= UARTCTRL_TIE;
+	lpuart32_write(&sport->port, temp, UARTCTRL);
+}
+
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
@@ -1530,18 +1548,7 @@ static int lpuart32_startup(struct uart_port *port)
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(port);
 
-	if (sport->lpuart_dma_rx_use) {
-		/* RXWATER must be 0 */
-		temp = lpuart32_read(&sport->port, UARTWATER);
-		temp &= ~(UARTWATER_WATER_MASK << UARTWATER_RXWATER_OFF);
-		lpuart32_write(&sport->port, temp, UARTWATER);
-	}
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	if (!sport->lpuart_dma_rx_use)
-		temp |= UARTCTRL_RIE;
-	if (!sport->lpuart_dma_tx_use)
-		temp |= UARTCTRL_TIE;
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	lpuart32_configure(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 	return 0;
@@ -2582,21 +2589,8 @@ static int lpuart_resume(struct device *dev)
 
 	lpuart_tx_dma_startup(sport);
 
-	if (lpuart_is_32(sport)) {
-		if (sport->lpuart_dma_rx_use) {
-			/* RXWATER must be 0 */
-			temp = lpuart32_read(&sport->port, UARTWATER);
-			temp &= ~(UARTWATER_WATER_MASK <<
-				  UARTWATER_RXWATER_OFF);
-			lpuart32_write(&sport->port, temp, UARTWATER);
-		}
-		temp = lpuart32_read(&sport->port, UARTCTRL);
-		if (!sport->lpuart_dma_rx_use)
-			temp |= UARTCTRL_RIE;
-		if (!sport->lpuart_dma_tx_use)
-			temp |= UARTCTRL_TIE;
-		lpuart32_write(&sport->port, temp, UARTCTRL);
-	}
+	if (lpuart_is_32(sport))
+		lpuart32_configure(sport);
 
 	uart_resume_port(&lpuart_reg, &sport->port);
 
-- 
2.21.0

