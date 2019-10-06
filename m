Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBF9C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5462084B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHi5EbVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfJFQdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 12:33:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46886 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfJFQdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:33:51 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so23482341ioo.13;
        Sun, 06 Oct 2019 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CMh6JBMYSI4pAfFgF8FN6yl6CamG6o0LnLww5wv2NbM=;
        b=tHi5EbVpuZATNqyRmg87Qdmwe5JgPQEpT815Zv25DjNPHyH01byS6plO/sH1cgDTOK
         kDRfedbM6kVZvYwHajJbWuD9s0J7XIx2Tlk7zbDNTiIeH8ljNe/RLVpUymf3t18CVEXu
         MJn0T3SK92R3tKEybhqqvBEU6qToIJpV2hJjwpwBqcM0JmMSsXTViSRtSnQNLff3BCHC
         j/UcDV8watJ6npvEyQRIxQwgw/9TcXoPd1OfuR7eyNkwP9Edz6yHFb8/Oj1tb1yDBKkz
         8zj9NeEHLNvUkr7A+aCKjzhBGWVigsYyMLeX/lrAKEOf5BidnFb1A3GcKpWc14Td6aa+
         z51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CMh6JBMYSI4pAfFgF8FN6yl6CamG6o0LnLww5wv2NbM=;
        b=XCQEcwiivP4JgVjIksofpeL/1OJTO2goyZreMT+xYzpKf5XTRqVFi7fH02Cxy7war6
         0Y20w9CC3g6l/GvssPSWZzjaDgKIYtwxwGpuYli8lJbQwFaULjVtGYQXhX/KsJ8fnA2d
         I72oi6DwB7cr9uErvl7JaoHUVE6HNCUd5+PBtnqSZO5gjr1ClDHbPg8Rk1J8oo+OtAoh
         BUNvoxfVm/Oysvkuuvk8dJjzU+mml2dui9R2BsSWbN+yo4Ck9yfWTZ/3b79s90gk+ccN
         Yph/8jmePksgSXiOxuhT5pfrcVfvCeB+bXkArKQ4bAAEOHlm8T7tN5MW0bO2EAGooOBb
         fN2w==
X-Gm-Message-State: APjAAAWo/o3TS8ayc4ru1tNTEcrEVNKmymn2t9rpMio8QTymoZajLMjp
        5AKATaTGZjhTb7ts0AHdKK1K5ZuzNhE=
X-Google-Smtp-Source: APXvYqz0yUVfJ2iwPUNK2CgR+ejLbLmEZwUyMe8qo0nlZnBtCP1Q3hnS0wUtFJNIYl11ku5y2qWxBQ==
X-Received: by 2002:a92:b74f:: with SMTP id c15mr25915446ilm.43.1570379630395;
        Sun, 06 Oct 2019 09:33:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id s11sm4471795ioc.79.2019.10.06.09.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 09:33:49 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vignesh R <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] serial: 8250_omap: Fix gpio check for auto RTS/CTS
Date:   Sun,  6 Oct 2019 11:33:12 -0500
Message-Id: <20191006163314.23191-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191006163314.23191-1-aford173@gmail.com>
References: <20191006163314.23191-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two checks to see if the manual gpio is configured, but
these the check is seeing if the structure is NULL instead it
should check to see if there are CTS and/or RTS pins defined.

This patch uses checks for those individual pins instead of
checking for the structure itself to restore auto RTS/CTS.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Made the NULL dererence check from patch 1/2 come before this.

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index c68e2b3a1634..836e736ae188 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -141,7 +141,7 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	serial8250_do_set_mctrl(port, mctrl);
 
-	if (!up->gpios) {
+	if (!mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS)) {
 		/*
 		 * Turn off autoRTS if RTS is lowered and restore autoRTS
 		 * setting if RTS is raised
@@ -456,7 +456,8 @@ static void omap_8250_set_termios(struct uart_port *port,
 	up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
 
 	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW &&
-	    !up->gpios) {
+	    !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS) &&
+	    !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_CTS)) {
 		/* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
 		up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 		priv->efr |= UART_EFR_CTS;
-- 
2.17.1

