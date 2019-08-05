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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479ADC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDD320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzVRo/06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfHES5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:57:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41055 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfHES5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:57:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so29850996pgg.8;
        Mon, 05 Aug 2019 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjWaUP04Ww8m6uQcC0AKZNjv1jlcUsiz2ETZEZkSQs0=;
        b=FzVRo/06bzl3CwDZ8+mhccUNJDBYaD5L/lSu+58feeqoYEUwyacnkqSPjgVWuV/C/l
         ZgZp/2xRhBnSlGLUrdKgKu8x++voB5hI/EaZmL4hNi+HcksMDSoMAcAhpWg4Hv3tYbw/
         Q2H/b/93g8luBZOpY3r/6TnS8SNO1kgSu1SZ4Gm2yoWDH2QSBYiS7pdPKqPx3UyKCx7x
         vo9A49HI+Cuho6/+ZjSWgs3n2eIODQ6tlOMYgdZCA1BiPqLMYM+P4bF4WW9ZSSxeJaGg
         9yXf3Hps8/CqauiqiqZWoNU86f4udeIChfKiD8HfypIGkBAsxFS3KixPfNmbb3GnzY8R
         HqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjWaUP04Ww8m6uQcC0AKZNjv1jlcUsiz2ETZEZkSQs0=;
        b=NmoMpDg8cwoaCfMYSyAP2yiz7UNvDu7GVj7+Ie7GILIIaFVC/xcayoFrjhlxVvyTsX
         dQWajYco9O6oNut8SW0SN6jdMASLByqW9idFgUxjEdhprJHbRM1KWC8omAdLHBiFq5Vn
         6+rvsILXjRkLkArWMJkXWLXLzbtUrQZ9bl/+kybyACCCqlegYpg3vPC7uas8EJP/Xr/z
         rptdy86Iv/TUlKewaUJjUeDp8xFEMDgsuwy97Uio1tJZGIUXbyQCGc0VV+H0/5qLRjrl
         ruAlVCQMiFqXj8mzcqrNrNvOKAtORgHX44yOLfqNel6W9lpHHJ9eWiL9rKIvWafDLP47
         TVZQ==
X-Gm-Message-State: APjAAAXW6VrEvqeE+81zYQyg3H3aVPrjSiraX9E0hOdNY66lSXAXM3Yx
        0VgwZwpXg4ikuPLorn86MBLEqzTA
X-Google-Smtp-Source: APXvYqyHtUVmbAp3IBSNC6sKX7W7bCeFehFK75RelWZEFMS+D/0YMMGuA0ZIBXr0vLInDa6r9iPjbw==
X-Received: by 2002:a62:8494:: with SMTP id k142mr73816957pfd.75.1565031452362;
        Mon, 05 Aug 2019 11:57:32 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k64sm16037959pgk.74.2019.08.05.11.57.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 11:57:31 -0700 (PDT)
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
Subject: [PATCH v3 5/6] tty: serial: fsl_lpuart: Don't enable TIE in .startup() or .resume()
Date:   Mon,  5 Aug 2019 11:57:00 -0700
Message-Id: <20190805185701.22863-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190805185701.22863-1-andrew.smirnov@gmail.com>
References: <20190805185701.22863-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling TIE in .startup() callback causes the driver to start (or at
least try) to transmit data before .start_tx() is called. Which, while
harmless (since TIE handler will immediately disable it), is a no-op
and shouldn't really happen. Drop UARTCR2_TIE from list of bits set in
lpuart_startup().

This change will also not enable TIE in .resume(), but it seems that,
similart to .startup(), transmit interrupt shouldn't be enabled there
either.

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
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fb9961edce3a..5c3cc1051aa8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1410,7 +1410,7 @@ static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 	lpuart_setup_watermark(sport);
 
 	cr2 = readb(sport->port.membase + UARTCR2);
-	cr2 |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
+	cr2 |= UARTCR2_RIE | UARTCR2_RE | UARTCR2_TE;
 	writeb(cr2, sport->port.membase + UARTCR2);
 }
 
-- 
2.21.0

