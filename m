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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F924C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6755420679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRHCnS/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfGaRbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46538 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbfGaRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so30759828plz.13;
        Wed, 31 Jul 2019 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ly9Fm+AvGdnsdGY/IVP3FuY35d1qoMGO4Csfajhx2ZI=;
        b=jRHCnS/X/s4PVg+xtIIr+mH1MF+jEFMeUZXApzA/CZ3zi3tUI1UMb9Lhh6pX03Gi/A
         FPSsjdkXbWQlR6Ij0G9SHNm9CKcX9KJt6g+utGGxfGSC+A9hKu+lcSst1+hogrq9/Xlc
         zwV8jNwSJfEckP0OLcRpVysqOo4+Rt3D/d+CHYj/IzhERJjqnI14iVkfulIBSf4R04Pj
         TMn2o3ZMNwf1icZ03987nY6HzQhPcVOIDDMTXYvUWnBUPE8Fo7Zb3ANYmQDbVkLcjrJ/
         F+t0AS/8kyS582392EEl/TXPn+vFDYN+HMecTfwrTrzScuHUW8ligzZhl7wAQgGnBop5
         9rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ly9Fm+AvGdnsdGY/IVP3FuY35d1qoMGO4Csfajhx2ZI=;
        b=OQ482T/WoOYJr3BDs46h7Lx+JNYjS42LDXHBeemcbeOWxpzmJc9F/EJteyY6o/awRH
         dLKP3R4/1mmOFVITampml+O6XlazcjWZAJ2afIMwKEzhY4QWug0QuqAD4he7cvOBENBx
         Am1NTb4p4Jj7cIG9eWRQ1B5ZMv5ppFN6OMikHUTL/WQnNKDYaXKtEjHCilPrrSV0QYlr
         CZecvD4dHgjVCET9l3zif5a+2LC4QRwoqIP+hpt1KlO8jIgppLF0jgN3zIqwl+zmUmo8
         HOTjcmDh14nQHwnJC93VaHapoCDoQv5mL9ldre3tulSFF35u0VJL3AYH/8sUnPOYwrGm
         +rvg==
X-Gm-Message-State: APjAAAUny1CpQeUOspXpXYotTxTrBsZThpa7CQ2eOQZ4ZK/otE/jhnK8
        Mv4NXH335Soj65loMyL6e9USXta6
X-Google-Smtp-Source: APXvYqwwPGbYrx7i1wiZVqncHM+1E1h/G+aNWIJeg/y1FRpnfkO2FpMNN7+cdWQqoowOXF1CWNxB7g==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr125380490pld.16.1564594273095;
        Wed, 31 Jul 2019 10:31:13 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:12 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/23] tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer
Date:   Wed, 31 Jul 2019 10:30:25 -0700
Message-Id: <20190731173045.11718-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
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
index 317bbc1dd2b4..12ddca608eba 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -518,9 +518,16 @@ static int lpuart_dma_tx_request(struct uart_port *port)
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
@@ -530,6 +537,16 @@ static void lpuart_flush_buffer(struct uart_port *port)
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
@@ -754,12 +771,6 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
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

