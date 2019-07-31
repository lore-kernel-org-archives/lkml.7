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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9B0C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31E320679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG04ZQc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbfGaRbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42079 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbfGaRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so32241456pff.9;
        Wed, 31 Jul 2019 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SysvR+iTfqiqnO1IFKSbNIeQ1lVsVQXS2ZPWMPEYzaE=;
        b=iG04ZQc2tt4x+OSNh04WsXGjXjL/Yw9oxtk0hUAwD1rBs8AvONlPVrkV19ml4STsl+
         9e8Yesgh0FKPZy0q5jHx4J2gklSEiYyWgoxDsGjnOXll+4B/SC655ZKF59c2X/P9dGMf
         pU+ihWzw1gz8DmsRXF7vFN32ElkSsjt2TgWz45yLkNWAVZ4eaeX5VtHWso1V1oK9M43v
         FHN2u3M4Fs0LDXNpljwk4x22GNnFonVSlEsBevubKT+vmPkAK2A9jT8Ouj9Sk7fnr0VB
         LU7bD8r4jUAKNc14+6lqNHgqZbsePOlCTb0KhUR1wTmHHnLSU2tHWrPh9zObpMUNosMx
         KkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SysvR+iTfqiqnO1IFKSbNIeQ1lVsVQXS2ZPWMPEYzaE=;
        b=U2M1nllMsqCMqEvq2PzV9w3DnnSE8sQUTMbmEYs7ayT+YCo8YvNV+hKLlzxK12m6JN
         F+jsUIAs4zr5ytp9ig/ivuB7Fgec4knQiyYtsni8Z+4RFrxlUDWMs2kXs3UT2JIXOCOP
         smmPCvyWiE8kdCzcDwpeblc9sfIln6jMmeqTbhtkXz/15QGe3zud21M2ny5woxgcglqj
         +lyORbaM8GsiSRe20VzgiBwKZfTNQgrHa59Hzw/lt1SO6Zaix7tNg0zxVVKVdvD8NNU6
         W+Gk7kXtsC6JZt810qABYeC9yeEE8sL/WJjbfRETFUFcIYWoRebpw04nhZc0hAM5PSFf
         C+KQ==
X-Gm-Message-State: APjAAAW/3Nq6LuQB2InIz1XV6K0wttSzgsn5LoeLirmEfj15r8eJ3BRV
        73LvS6sNU023at9rlajANcDjUlll
X-Google-Smtp-Source: APXvYqx9r1WgbyWQKus9afQs2IKPGqXedp9halWGCKVLX926ckPYstFZajPz2bnI5SD5LKCbFJx1NA==
X-Received: by 2002:a17:90a:ba93:: with SMTP id t19mr3945236pjr.139.1564594277268;
        Wed, 31 Jul 2019 10:31:17 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:16 -0700 (PDT)
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
Subject: [PATCH v2 05/23] tty: serial: fsl_lpuart: Fix bogus indentation
Date:   Wed, 31 Jul 2019 10:30:27 -0700
Message-Id: <20190731173045.11718-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bogus indentation in rx_dma_timer_init().

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
 drivers/tty/serial/fsl_lpuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c60c5354a5b9..57c5825f5de7 100644
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

