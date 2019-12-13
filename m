Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836C8C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567EB206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MEiquop+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfLMAIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38350 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731643AbfLMAIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so389234pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uk3TZICnk6L8+YQsKzp4vXh6Lz+AHFrWnELXXHSVLmg=;
        b=MEiquop+dWgeX+dUKlkKtAa/DS84d2iq6ZW3M0G1Psp+yW+8kVNAYH6uQjsPE6JJ5i
         za7C7kyKxoDAA2dn0siHaxDAEijdX3Pcmou7RQYXmgc4vMF/39b3nBwSAnB7xRC9myN9
         t2TD35xkpGzZz9eHkb5uaIx/Jki9YMY0Hxw/TQqUh0/FAtfLYZcdkHvXPq0eFyvHHyeu
         HfjUzcroMqSh7D6/IYRUpsyQDt3CqfFUX+Pm8BoUYGT88RmIXIFDxmWn6vlIye7C2QGn
         2HwQ81fDPi+rbdnS+9f0Y7tr9+nNMau4z5t+HuFuO6XZeNFTOvveWSvDx00bm7lseGgW
         KJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uk3TZICnk6L8+YQsKzp4vXh6Lz+AHFrWnELXXHSVLmg=;
        b=JC3+xB+bRSQzDPKIDBX+t1CYQnteQ2BkSwhZqDyaudZwMsqQ5cSyZI+pDFjXVWx2LJ
         85QQhjjjdvgXBTt+yTQBiYD6kTru/UhNwjfS8/09B07/hhpBduFRvjMNnwhLRdio9yOw
         Nqs2JVADChglTGBayK8u+DKnF8mxniwlTGOUqGHZJ2JZJFuU/pykPI/sbGt/e2rE6N5w
         XQ+rFvEpXus3hLHv/afvopILES5kiWbhCdqmToK6aDHp7zjfL4KMvzGbISWxHtKEDghP
         ZLgOIKhVXwUwzuG4Wk83mq0/+bpdkC+QLZK8gkQM+UZEWxT6rhd5JBG4Pc2t2sJilWKb
         8Rzw==
X-Gm-Message-State: APjAAAUJSimvsVhkVFZxeoMf9Kj4IPKUYWGG5siEJ54h1UUdGbcwNvqx
        qZ42RLmbeKHoxZn3ui/srkI7te0uJpY=
X-Google-Smtp-Source: APXvYqzavE1+kkQp1uQB6Awu3jk2+Wse3GRBkbNukVGHGUDFeOheGMh3MBohyrMn3SZ2woUxcYQijQ==
X-Received: by 2002:a63:ca4d:: with SMTP id o13mr13550977pgi.360.1576195696496;
        Thu, 12 Dec 2019 16:08:16 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:15 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 21/58] tty/serial: Migrate meson_uart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:20 +0000
Message-Id: <20191213000657.931618-22-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/meson_uart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index fbc5bc022a39..12e15358554c 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -5,10 +5,6 @@
  * Copyright (C) 2014 Carlo Caione <carlo@caione.org>
  */
 
-#if defined(CONFIG_SERIAL_MESON_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
@@ -703,6 +699,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->mapsize = resource_size(res_mem);
 	port->irq = res_irq->start;
 	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
 	port->dev = &pdev->dev;
 	port->line = pdev->id;
 	port->type = PORT_MESON;
-- 
2.24.0

