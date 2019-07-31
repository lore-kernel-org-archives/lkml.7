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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D558C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A9F20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMZNfQnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfGaRbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41661 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbfGaRbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so30674229pls.8;
        Wed, 31 Jul 2019 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QV3QEs9S8gHSGE1q0dgi9urKTyxRBsTx76YM3aO3MSw=;
        b=BMZNfQnHysObs5nv+CNH8dcx+AwBJRCtPtqGisPxegVfnXfJlwT8jxJaq251IaHz9c
         MTPBFuITnWCH+Fkdqp4S9Jzj0mkUDdEBt2dTKUGYqzIO9op4hY90O+5oceoA/AE74tBf
         DyuAzbrbKgN/ES0G8KOYvSPt7H+s8vCCLKI0dI349TOCnF98FzLf2rBjUGztJ9cQPTPT
         XsRshhLcIJOT8clo7jLUXxdYtQbLxohF2TrrfjumRS7Ob0tArsy/6iWanL988jcK88d0
         IZ8+ci9aGeomd5RMIjX89nKi1YXWEdfmLf6g6ixa0Z7ARldNlCaKaobW0D8OGZe0pyYF
         BG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QV3QEs9S8gHSGE1q0dgi9urKTyxRBsTx76YM3aO3MSw=;
        b=ltsbZN8Ki/deFEGhuOhDbRSorT7dPfT+3zAuGIAl5GQP+C/uwInt27VDlC/1At906R
         GYAg5WH1h4yCbk9bqQnuqGOdpfUfPAAoYF/jK8ejBk4V1VGkhxMY5PDnuGOMR2mq/X21
         BK537HDufEmrunR7kDwN9T+y4MsNBf6FFiG3ChHsC1C6CVtpIypDFnYU7tu0cZ5G12+C
         vA82yaprKjHubb6vAyRcaOiak0nGRIi8csXcJy1mbt9HL9nGxPI7jjRQeAiHjO90M9n6
         +nGQBPuZYlE925XUOd0SYapc56/fE5L4nvDcgaJTQcBuioTSck2jyL55MTyTAbBweAtq
         dowA==
X-Gm-Message-State: APjAAAV8oRRE4IaxdEzSdLpY72rfm7sQ6xWyPwpb8+fILjj9r4n2pluN
        aXgvQIDTS73USi9+kn/RDiizQsG9
X-Google-Smtp-Source: APXvYqz0NS+ihL/+9dsWV94zsBsfungBGvY+4n1mYI9pSaudX5TnevfHpArlaqP/ko3uXnY4JubcTQ==
X-Received: by 2002:a17:902:f204:: with SMTP id gn4mr122783056plb.3.1564594275316;
        Wed, 31 Jul 2019 10:31:15 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:14 -0700 (PDT)
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
Subject: [PATCH v2 04/23] tty: serial: fsl_lpuart: Simplify RX/TX IRQ handlers
Date:   Wed, 31 Jul 2019 10:30:26 -0700
Message-Id: <20190731173045.11718-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that lpuart_rxint, lpuart_txint and lpuart32_rxint were
modelled after identical function found in UART driver for
i.MX. However, while said functions are used as individual IRQ
handlers in i.MX driver (in case of i.MX1), it is not the case for
LPUART. Given that, there's no need for us to restrict the prototype
of the handler to irqreturn_t foo(int, void *) and we can drop all of
uneened boilerplate code by changing it void foo(struct lpuart_port *).

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
 drivers/tty/serial/fsl_lpuart.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 12ddca608eba..c60c5354a5b9 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -771,9 +771,8 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 	return 0;
 }
 
-static irqreturn_t lpuart_txint(int irq, void *dev_id)
+static void lpuart_txint(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = dev_id;
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long flags;
 
@@ -804,12 +803,10 @@ static irqreturn_t lpuart_txint(int irq, void *dev_id)
 
 out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
-	return IRQ_HANDLED;
 }
 
-static irqreturn_t lpuart_rxint(int irq, void *dev_id)
+static void lpuart_rxint(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = dev_id;
 	unsigned int flg, ignored = 0, overrun = 0;
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags;
@@ -878,12 +875,10 @@ static irqreturn_t lpuart_rxint(int irq, void *dev_id)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	tty_flip_buffer_push(port);
-	return IRQ_HANDLED;
 }
 
-static irqreturn_t lpuart32_rxint(int irq, void *dev_id)
+static void lpuart32_rxint(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = dev_id;
 	unsigned int flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long flags;
@@ -942,7 +937,6 @@ static irqreturn_t lpuart32_rxint(int irq, void *dev_id)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	tty_flip_buffer_push(port);
-	return IRQ_HANDLED;
 }
 
 static irqreturn_t lpuart_int(int irq, void *dev_id)
@@ -953,10 +947,10 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 	sts = readb(sport->port.membase + UARTSR1);
 
 	if (sts & UARTSR1_RDRF)
-		lpuart_rxint(irq, dev_id);
+		lpuart_rxint(sport);
 
 	if (sts & UARTSR1_TDRE)
-		lpuart_txint(irq, dev_id);
+		lpuart_txint(sport);
 
 	return IRQ_HANDLED;
 }
@@ -971,10 +965,10 @@ static irqreturn_t lpuart32_int(int irq, void *dev_id)
 	rxcount = rxcount >> UARTWATER_RXCNT_OFF;
 
 	if ((sts & UARTSTAT_RDRF || rxcount > 0) && !sport->lpuart_dma_rx_use)
-		lpuart32_rxint(irq, dev_id);
+		lpuart32_rxint(sport);
 
 	if ((sts & UARTSTAT_TDRE) && !sport->lpuart_dma_tx_use)
-		lpuart_txint(irq, dev_id);
+		lpuart_txint(sport);
 
 	lpuart32_write(&sport->port, sts, UARTSTAT);
 	return IRQ_HANDLED;
-- 
2.21.0

