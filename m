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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2339C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9060217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD/hzx6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390601AbfG2Twy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:52:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42557 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390669AbfG2Twv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so28763614pgb.9;
        Mon, 29 Jul 2019 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ITELl99aXbX87R9cYxa6vyymZoJe5+3YlMPTPeLvD60=;
        b=rD/hzx6J7gjwuRcEDs+iMh/ovpV+g6m/XFz4YNv0sKJM9qWvqK9qhdQE6S1Wg/KJ20
         jOGZrTnWXtr7eRiOepTuMhd1xfPQjuCIBkspEuceQbb1rvYLSnKTTgkgh/rP+sYpADRK
         9DQk0NMUK2uQYJR3g6+hZzWRfVNdJffQyAIcLb5Gji99kYAmpu7PCDhhCfL+RV7EQzzf
         2DJPnLLlq4TtB4esGgrnIcfERC0bNHOXIjec9rwm5aVmH7sC3/OdmsSlbixDEZ5FbLIa
         aRmkhTLt6gGn7pUqXhffsP2jeXECMzFMPCIvxonbfgyt9DcFynBI9JFnaVJHa6exbAwW
         eVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ITELl99aXbX87R9cYxa6vyymZoJe5+3YlMPTPeLvD60=;
        b=PThReCnIETCylk2wb0LBsmzd2nyVVUocYor1cJV01oSzOzLOBpTkEXo3SircR5us6A
         5vhU5FoEGkZQyokeivl+ko3vZliLkdqgl5gRWx0n1VGeVT7VrFLOB8koH6rEV9pbY6E5
         oXV558SFuuik5kqqmP8Bwr8GxRy08KF03Eb9+upfEnbDYcKbrWiwVzqLSZiYTQYiXHeA
         VNXkBFWXLl43j1XKkM0JCDBET5l+Z3Tuk+VGRSoX5tIlak/msPqJCutMw2Bztllfra35
         Dn52qcQFR9pd7DorCT2AX8O1q3RoxGXRaTod5L5XoFd/zHzY4FgZ/mp/HK6xbvi6fhtC
         +FUw==
X-Gm-Message-State: APjAAAVRMJCg8w0EswtY/R8Lv67nEZwEDSexBhP+pC+MDDxrzRc4I5TL
        5Jp16Y+VU1D1+4t2tYN+suHNcTOZ
X-Google-Smtp-Source: APXvYqzdi9Zqa9fwsbUiNynMCG/YC59cNG99C8LbD6MQj1FbcUApc1NE7Roo4R4jCfYm2+jQ2CGZww==
X-Received: by 2002:a17:90a:cb01:: with SMTP id z1mr112484030pjt.93.1564429970329;
        Mon, 29 Jul 2019 12:52:50 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:49 -0700 (PDT)
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
Subject: [PATCH 04/24] tty: serial: fsl_lpuart: Simplify RX/TX IRQ handlers
Date:   Mon, 29 Jul 2019 12:52:06 -0700
Message-Id: <20190729195226.8862-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
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
 drivers/tty/serial/fsl_lpuart.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 56423ad02f0f..3e38970a444e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -770,9 +770,8 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 	return 0;
 }
 
-static irqreturn_t lpuart_txint(int irq, void *dev_id)
+static void lpuart_txint(struct lpuart_port *sport)
 {
-	struct lpuart_port *sport = dev_id;
 	struct circ_buf *xmit = &sport->port.state->xmit;
 	unsigned long flags;
 
@@ -803,12 +802,10 @@ static irqreturn_t lpuart_txint(int irq, void *dev_id)
 
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
@@ -877,12 +874,10 @@ static irqreturn_t lpuart_rxint(int irq, void *dev_id)
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
@@ -941,7 +936,6 @@ static irqreturn_t lpuart32_rxint(int irq, void *dev_id)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	tty_flip_buffer_push(port);
-	return IRQ_HANDLED;
 }
 
 static irqreturn_t lpuart_int(int irq, void *dev_id)
@@ -952,10 +946,10 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 	sts = readb(sport->port.membase + UARTSR1);
 
 	if (sts & UARTSR1_RDRF)
-		lpuart_rxint(irq, dev_id);
+		lpuart_rxint(sport);
 
 	if (sts & UARTSR1_TDRE)
-		lpuart_txint(irq, dev_id);
+		lpuart_txint(sport);
 
 	return IRQ_HANDLED;
 }
@@ -970,10 +964,10 @@ static irqreturn_t lpuart32_int(int irq, void *dev_id)
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

