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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ED7C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3282B217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeaGhFXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390622AbfG2TxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:53:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46456 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390810AbfG2Twx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id k189so9730081pgk.13;
        Mon, 29 Jul 2019 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ZUYQjsQOSoF7cnt3apJdVFojNnNOlP5fhhY2kvbOSU=;
        b=DeaGhFXMF9XdWQknLV+nN6xPae5Jm2cRHRe9s3LxJE3nLYEehp5BhGyWsomktzRz3P
         CEXnkZtiAP3ERhQpGE+tfuPugVDQ48ftruowp0g0Fm9947/JEfTihdGndH3B7dUqyEc4
         2InRiWkyyDcB5OQIC5XtqQD5eKv77T4il7IVVyh3JqOYxnt8uWh+DiJFkxfCpAQInuJu
         2LdxkuYWDE/Yznp4sTNVQ0JF6qwFMYNXOHDmdUOo/NlbFJJkxSf8UiMl0a7Ma/OLA3tE
         Sk1fXJLCG9hKbx9rk37pdVm0bSKp0YdK8M/lMi7xUosB2CBQdXaeJAuTg76Hd2/KBNgN
         5q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZUYQjsQOSoF7cnt3apJdVFojNnNOlP5fhhY2kvbOSU=;
        b=GMIVabYn4OBm8vx3CtNM62T6OvYp7BGy/9SMW8l+qa7b/EKUvAAf+vg841C3YFe/8U
         ibooNrq9ho/P/xvVZ5nnRFVvmp9ESBgh0/2ZRT9d2wYbbHhqGOj0ChZRUVsMnhy+sl3i
         3Ib3TVM0lKpi8xRrald9mIbcEapHP1BryYNAYIA5HmlwWeooG9ICMohtwzJl+2fNJceR
         o+2gyXJTBj9F3EWPIh1lcKnnrW2VxRN7OBq8w9/WoaObD2qIxbBOeWVmh6uNDH+N+IS7
         /UkM5t94ACRQjXGB/bN2YPi24e/yvYNb/vfuvoeTiFcn1sdf0gZjmySUbphhmXga0IdX
         54jg==
X-Gm-Message-State: APjAAAVDVtMylOiM5Znp8eEIS3hIDrsIh1HMStW59Z8VJNbW/Bv94lAd
        jB1nsl7pkxS9xGC6dMHLKfQg1ioq
X-Google-Smtp-Source: APXvYqyV1Z0Sf8gr+Uz6USWetj3sLpLYNqGuQS1ggbcha6KBTqCIdDTFsxSatObzdcPEsQtAEJcPCg==
X-Received: by 2002:aa7:957c:: with SMTP id x28mr38078342pfq.42.1564429972121;
        Mon, 29 Jul 2019 12:52:52 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:51 -0700 (PDT)
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
Subject: [PATCH 05/24] tty: serial: fsl_lpuart: Fix bogus indentation
Date:   Mon, 29 Jul 2019 12:52:07 -0700
Message-Id: <20190729195226.8862-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bogus indentation in rx_dma_timer_init().

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
 drivers/tty/serial/fsl_lpuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3e38970a444e..1b3f2a87e558 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1409,9 +1409,9 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 
 static void rx_dma_timer_init(struct lpuart_port *sport)
 {
-		timer_setup(&sport->lpuart_timer, lpuart_timer_func, 0);
-		sport->lpuart_timer.expires = jiffies + sport->dma_rx_timeout;
-		add_timer(&sport->lpuart_timer);
+	timer_setup(&sport->lpuart_timer, lpuart_timer_func, 0);
+	sport->lpuart_timer.expires = jiffies + sport->dma_rx_timeout;
+	add_timer(&sport->lpuart_timer);
 }
 
 static int lpuart_startup(struct uart_port *port)
-- 
2.21.0

