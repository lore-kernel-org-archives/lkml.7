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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26546C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E522A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXNorrU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404278AbfG2T65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:58:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33459 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390878AbfG2TxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so28558240pfq.0;
        Mon, 29 Jul 2019 12:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91FlADo2LjmlT+xEM8z3y/II2Zv+hw+rO/GDlwPAqvA=;
        b=JXNorrU08g829KsWFaMQlr2VPG3Vj4AKtRKIggcHP6H1VUNWpoCmiqp9YwKNQ+96PA
         4a4qm/0jLIWPsATBdxryN+TCbI8dgW5OScaq7DuSXAMjp6gwEjro1lsvjJnl8myTzPdg
         8JbG04ZGFs+aWGRLzybV6LOUEkOSmR7Li84FKSGGTb9Db9DKOqkjc8uqT3fBQ6y/Exey
         xZm3cPG1x4q5ZLea4pllf1fYOpaQBw8jYfO5IWe8r61x/LBrrFQQQtxLDJSwx3209/bp
         YLvZLjjPlPY4ZP/YPEC93awsaCDMnbjsJJNNtYAE2XcBl997uARm6DmnTYpm5RsUKcTt
         tAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91FlADo2LjmlT+xEM8z3y/II2Zv+hw+rO/GDlwPAqvA=;
        b=ZJ88SP/QQ0FnMZ3XsjKApeUDR7VRO1Wg6xaySd3fhA382trJjz897N3gxXZlXlgNnN
         HZb0kDDcQ78eUArujAWDGwq4PIkEs/MIcuMZBVFxeSitGb0qucmh2Sz5FhLnn07v3YGp
         zyveC2b+D+IvK8199uWUDV9BMYb+tYuhbBc/jUc6rmXJhXWXMDxQ7OGXyJPxtAlUiS3k
         qAmNpBOgCIjQXL+RT1B0pux1KoHDu3MMrjdKI5p1IA0f2Z9n3YG+46+W02p/Xf2hvA/C
         EoYSj+CS+CqC2eIerziIaC7G9ZxUayCElYWV1n7MJdtWsj8LOuPUcH/haAniz1b11ioC
         CRXg==
X-Gm-Message-State: APjAAAVe2pEsqh2yusYg9WsjjxH5IyzVtJJUz9j70jPJrW4LBOUh+yeh
        Xf92GhUl8SVzCpjxv0Y0PFNctLhM
X-Google-Smtp-Source: APXvYqwSG6pu9THsK8pEY2SYMQflqLuj78vzR8hXu5aVsKW7+KaPq2blRmerresS3ypt7eGQ6QnYAQ==
X-Received: by 2002:aa7:8a97:: with SMTP id a23mr37614435pfc.117.1564429996314;
        Mon, 29 Jul 2019 12:53:16 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:15 -0700 (PDT)
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
Subject: [PATCH 22/24] tty: serial: fsl_lpuart: Introduce lpuart*_setup_watermark_enable()
Date:   Mon, 29 Jul 2019 12:52:24 -0700
Message-Id: <20190729195226.8862-23-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most users of lpuart*_setup_watermark() enable identical set of flags
right after the call, so combine those two action into a subroutine
and make use of it.

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
 drivers/tty/serial/fsl_lpuart.c | 50 ++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 112fb1e19a1c..9643d4524e59 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1402,6 +1402,17 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 	writeb(cr2_saved, sport->port.membase + UARTCR2);
 }
 
+static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
+{
+	unsigned char cr2;
+
+	lpuart_setup_watermark(sport);
+
+	cr2 = readb(sport->port.membase + UARTCR2);
+	cr2 |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
+	writeb(cr2, sport->port.membase + UARTCR2);
+}
+
 static void lpuart32_setup_watermark(struct lpuart_port *sport)
 {
 	unsigned long val, ctrl;
@@ -1427,6 +1438,17 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	lpuart32_write(&sport->port, ctrl_saved, UARTCTRL);
 }
 
+static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
+{
+	u32 temp;
+
+	lpuart32_setup_watermark(sport);
+
+	temp = lpuart32_read(&sport->port, UARTCTRL);
+	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
+	lpuart32_write(&sport->port, temp, UARTCTRL);
+}
+
 static void rx_dma_timer_init(struct lpuart_port *sport)
 {
 	timer_setup(&sport->lpuart_timer, lpuart_timer_func, 0);
@@ -1488,11 +1510,7 @@ static int lpuart_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	lpuart_setup_watermark(sport);
-
-	temp = readb(sport->port.membase + UARTCR2);
-	temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
-	writeb(temp, sport->port.membase + UARTCR2);
+	lpuart_setup_watermark_enable(sport);
 
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(port);
@@ -1539,11 +1557,7 @@ static int lpuart32_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	lpuart32_setup_watermark(sport);
-
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	lpuart32_setup_watermark_enable(sport);
 
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(port);
@@ -2561,22 +2575,14 @@ static int lpuart_resume(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
 	bool irq_wake = irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq));
-	unsigned long temp;
 
 	if (sport->port.suspended && !irq_wake)
 		lpuart_enable_clks(sport);
 
-	if (lpuart_is_32(sport)) {
-		lpuart32_setup_watermark(sport);
-		temp = lpuart32_read(&sport->port, UARTCTRL);
-		temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
-		lpuart32_write(&sport->port, temp, UARTCTRL);
-	} else {
-		lpuart_setup_watermark(sport);
-		temp = readb(sport->port.membase + UARTCR2);
-		temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
-		writeb(temp, sport->port.membase + UARTCR2);
-	}
+	if (lpuart_is_32(sport))
+		lpuart32_setup_watermark_enable(sport);
+	else
+		lpuart_setup_watermark_enable(sport);
 
 	if (sport->lpuart_dma_rx_use) {
 		if (irq_wake) {
-- 
2.21.0

