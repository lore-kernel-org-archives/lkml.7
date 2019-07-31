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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F56AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BE020679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1XRmqP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfGaRch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:32:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44174 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfGaRcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:32:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so32384870pgl.11;
        Wed, 31 Jul 2019 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lP+gb0a7nXAkde0kTkIdwLRyN5Uij5gCsaOagxWeRf8=;
        b=a1XRmqP103eYkSMVwGRWnIy/45+s9a3RYL2IX+WIHXeGE3psrz/St/3Y0u0kGnsuBv
         kWcH9Q/mCWsiEFCENPtNXMv/Ncer8C9HeACP05bjRE174FxBVZpCcCOoSkPxQLkihq2D
         4itxekCgbqo/tPZEQGkUUfbHMCld2DUDlNagjbo/QybbOIR0RMuBlzloWKs1dBE+mesC
         i5iSxycYmaQ3GXkCntFCQbk3uGtA63RV7N06Nk5pN0N+b/YhDy4PPXKUiNLWIpxGG3HD
         uRIROehT0+0dQOmiyqGG7/Fp5NS9mVxrJuCQxe7DHTR8ttyHf2OOX0IYfLQ8saqy35XQ
         5Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lP+gb0a7nXAkde0kTkIdwLRyN5Uij5gCsaOagxWeRf8=;
        b=ZzyQ236pMZnG/uEppD72X+3rCO8/2c2mI/URLQV5XwRWVsVquJnLDmR4sE1TBCK+h+
         zfxXPqdE9SBWkz4ugKfOOs+3J23zgMYewLb3rpBQrG8dXe8P5hcg16Zn0aEyCc9CjKLt
         HCPnwlXCek9lwFR2TyxIVzM7VlVeYT+5XqQlWnkhvVkxWh7+PS8znVelEWa+iHo2wRZ1
         B3+8oJKjaz0LmilAEDYNkzZYgKpDtMXyDfjg0aEG5i4a3dcJuki00B54xbRnrxVIoQoa
         Z7b3ZIfn54PMwczjfBrLy6GpdU5L/gpMi6u27+njFamQq1/MIuHQRReu9ljNSYqF/Xme
         zbqA==
X-Gm-Message-State: APjAAAV898HdG6dYBBsCiwd4Rfh91OwnDfEzbuNiIlSGuwkdcDdqQ428
        Ne31SnTmerO71L9dYzdmmu07TUCOrec=
X-Google-Smtp-Source: APXvYqwddI2afXrM8alwQb7OlWZg6irEgRgnn7CUaubxvSyLNnvrA35PEo2toD16kQRvykdyRVVKaA==
X-Received: by 2002:a63:c50f:: with SMTP id f15mr15220177pgd.372.1564594343651;
        Wed, 31 Jul 2019 10:32:23 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:32:23 -0700 (PDT)
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
Subject: [PATCH v2 21/23] tty: serial: fsl_lpuart: Introduce lpuart*_setup_watermark_enable()
Date:   Wed, 31 Jul 2019 10:30:43 -0700
Message-Id: <20190731173045.11718-22-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
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
index 5a6516f4bc93..8ab5f9939597 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1403,6 +1403,17 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
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
@@ -1428,6 +1439,17 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
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
 	lpuart_tx_dma_startup(sport);
@@ -1538,11 +1556,7 @@ static int lpuart32_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	lpuart32_setup_watermark(sport);
-
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	lpuart32_setup_watermark_enable(sport);
 
 
 	lpuart_rx_dma_startup(sport);
@@ -2560,22 +2574,14 @@ static int lpuart_resume(struct device *dev)
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

