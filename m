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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEC5C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76363206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuPgG0L4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfGaRb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39798 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbfGaRb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so28265727pfn.6;
        Wed, 31 Jul 2019 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ce0ZiVLoam9yH7Sl9DlCW46oEKSkBr9q6CskSukF+ZI=;
        b=AuPgG0L4cOXsZ0wQnnRxOsxju4bF3pSYYf2ROtXIIsl88i5t0vZe0wTUMqJrJ+wFzt
         5NezBZRsibg+SbAneCQbkLuJUwq5j0ABkpQDdaepkFD/S1dtfCy/b+nDqL4W7XOoaxYB
         f0GW8SLen9fSddyrqzuAxv+QZPqSD9qmA+P47QfEAlZwLrJ3ST7SuGqkWhPzDqp3bugh
         QkueB4c3Dw08JUR+g5Jml6x67m3OqTGeBM+tXYgRPmzQrst7HYB/s2opj+ps2ZgVq3pG
         uYpTfX4TS0IwMhQRvz7HEPxZe62YnRww137OEoedWpT0kYPPBLIUFjFUv3e111bivDWs
         MPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ce0ZiVLoam9yH7Sl9DlCW46oEKSkBr9q6CskSukF+ZI=;
        b=Q4E8i/fEA13EJAYJE3CvAogeJKzI1ZKfQNC5/M1er3Q6h1RGvo9IuI+rtcMqI97mm/
         7YiMHO0I5GrCn2w1SbvDfC2XT68C9cXtLBIxDKzJDZ7hhUVaXxEKocU5PRiuHBdevFNr
         IpWXwnb/bJcHtB2dX0cbN3Tbtk1lHJI65c46P8WR0HyBlCE/7T8tkCLanA5NDLXtco5U
         w6Mmpb83y8fCHk2ALFsdFWpVKpN/M3JbvRipD3Hm+VGtTsbym2mzyAyZRhhAaojDPIi9
         NlXnUeIcvfgX6h9F/Gz5t5626tiDGVBnHaQUfdG8dabTZqkajdHZ2MC25FXdpl8VlpNo
         ZY9g==
X-Gm-Message-State: APjAAAVV8mFK4m8IUIT54rLUXlJ76igMd/t1Z1Q6fP1fZALDKJS3Is8p
        jzZcOkMWJ+4HSmzwzj2TW9jF9VCjS/8=
X-Google-Smtp-Source: APXvYqz23Jn5px56CZ9kpJmrpnNDwDfWi1VEA3KUWnZUf+C2cnh/Po+MIJhwn0dHikcq99/g6uIhKQ==
X-Received: by 2002:a63:e14d:: with SMTP id h13mr115165120pgk.431.1564594315512;
        Wed, 31 Jul 2019 10:31:55 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:54 -0700 (PDT)
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
Subject: [PATCH v2 20/23] tty: serial: fsl_lpuart: Introduce lpuart32_configure()
Date:   Wed, 31 Jul 2019 10:30:42 -0700
Message-Id: <20190731173045.11718-21-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
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
index 7d67e9631623..5a6516f4bc93 100644
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
 	lpuart_tx_dma_startup(sport);
 
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
@@ -2581,21 +2588,8 @@ static int lpuart_resume(struct device *dev)
 
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

