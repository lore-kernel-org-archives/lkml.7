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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E643C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAB4204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp4TXqJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390939AbfG2Txw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:53:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44251 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390885AbfG2TxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so28772025pgl.11;
        Mon, 29 Jul 2019 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C24JyWvS4iXs+QyXvvHadZ5yOKSQrVuM4Za3GdCH/ek=;
        b=qp4TXqJ0Hx9cOOjkGQfhlkZilqrby6BP91cJX3cVfKTaoZJT2gcoii6CRl9c4snY1x
         +0xNoKz4jD5tdkCljy+ueTaik5ALKSTVw3KkS/OSI+5gp1OyFI1JMAzmPk33Nyg1Nu6Q
         EvLQMIw05+DlUNTu0I65IZC/1kR4N0jAU1IOTVP49XodeZxKrpEfk0r35OPIsBRJZXal
         rXWsN1SBhb5V/hWFsrOq2jO83evUHAnHRau8x68ahLH8og3XzzfeMPfMVzu7hpxLgpLh
         YgxO9TQuUMk4bE4kuet+bZMZRSVHm7ibvO9X13av0skGw2TMIm4G0FuTiF3cHCsmdb/l
         kJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C24JyWvS4iXs+QyXvvHadZ5yOKSQrVuM4Za3GdCH/ek=;
        b=dhIZa7VyUs9pcwG1RFa1rLCVx72mDmFOGToLYRmUi1ZYfP0ZRs8aTS2+hUWopHguVm
         Pd0fH72PlGp0usKlYfM2vBQWu2555bZ+GEK2GK96Op9Ok5zzzkShR1OfD4/8S6GpR4Pd
         BMpIpy3P/Oy+6Bu/qdKmT5o0IvSj34rd+D3t+mrcpEOWrzmjvSe1ZEWIWHRMS1UTbX16
         dV65rWDS7zF5QY+aOJ3ZYwXCuFRc51RkFNA40ki53WGbzz2pWTBFqXpI33TsZ17xnWf4
         r4973rEMZo313cg0oBENNoL2Cl+urrauVi+HIZ0M95XQgzr9sWhqzHPy4ag39v8MUmr+
         7Z4g==
X-Gm-Message-State: APjAAAWWCG8jgAGcn1tVk6BLSQyXSW3ecDyxNvK0t0VXfxgiLqsk35Os
        mf7poovPnrPJfXJJAXySnOkEC+GN
X-Google-Smtp-Source: APXvYqx0lyEaEq9Er5v9nptmjRPbqVK/eJsjnUNNg7gJkIBYrk1Fj4V6MHSfjKzs+yqC2h/2t7zpKw==
X-Received: by 2002:a62:18d4:: with SMTP id 203mr38594300pfy.165.1564429999507;
        Mon, 29 Jul 2019 12:53:19 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:18 -0700 (PDT)
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
Subject: [PATCH 24/24] tty: serial: fsl_lpuart: Ignore TX/RX interrupts if DMA is enabled
Date:   Mon, 29 Jul 2019 12:52:26 -0700
Message-Id: <20190729195226.8862-25-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
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
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 53b98065f9c5..b74027964b45 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -966,10 +966,10 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 
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

