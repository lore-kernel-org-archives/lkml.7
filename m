Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4142C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54E6206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OcggiXbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbfLMAJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39115 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbfLMAJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so389772pfx.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3MVH0IytIktlYSZoL4rqg8LTHZ+hNgx1HRy12FyMRVY=;
        b=OcggiXbDqASGa8a7H5cyEI5QMQ+J3uXvJEf7lpKl2y3L92IUziIjUeefF0uBhRPK16
         Td9Ym/BWyyDqE/OcuB1mGpduksFVQJB4kIh0SX0/O0xYzGcjoOVAZ05lCBD1J9q094bz
         7/JhQ1LQd6t6sUiVbyaKgE6TOI3lvP0Ej8IvGsrCFvQO6rtoaTp0SxorNKaTr/ZyRTaD
         b2Vej3DZT1stbyiFh0Jvz9vCxEHGCyZW+xWsQ7+H5YBvX+/DeQncsVtbrTRiptB2QaJJ
         JMgDz1PEVFooG2p7BhrhE5rcj4Q1uWaB7n3P23YADD2nXHDTjhE6mJvHElxA6A9/knm0
         aD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3MVH0IytIktlYSZoL4rqg8LTHZ+hNgx1HRy12FyMRVY=;
        b=bjvMTOgW01MY0iEPygu7Sl4yJlJSHdu889yDY+Mxppacsd0ee2C3DXxtvH1xFRa1e2
         T05xvUhwQSatFoHJ2Lx8bNXccgLDkoy3QbeM8lnC7DuofbWiTYHbw2u/8FbHTeRkDZyV
         cIi7AguAbXVmhcF4pzSNnRJV06UcBMwjDj9u+IZZntZZyxvBHzGX2+hvHMZwun9+RW9c
         jB4SUYSfR+G24PGzNTGfZBQTLyPX1cgUmlw2NbWW1F3rUpJ3EjEACkCJZGMSWH8jQIiy
         SfT6fvGq9vMCYxTbXBxoAX5yneRYGM1YE4p8znBjxAX5bvH4+DTOs+BMoHxCfkrvlQgB
         5hvQ==
X-Gm-Message-State: APjAAAVyAgDBuXzHG1vbmQQf/JkRGJgycCa9Jj87UNAOK/s8jVtZHAfI
        VOPOPPZWvEtkhqWTUfH9igudZ/3htuE=
X-Google-Smtp-Source: APXvYqz2fpugtxiFEVFNrvEOWUyHauLHOkhyLBr7rQ7WQYd0bvWwDAwNw0T+NTruARcW1efU/+wpRw==
X-Received: by 2002:a63:f901:: with SMTP id h1mr13691936pgi.445.1576195740415;
        Thu, 12 Dec 2019 16:09:00 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:59 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 36/58] tty/serial: Migrate sa1100 to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:35 +0000
Message-Id: <20191213000657.931618-37-dima@arista.com>
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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/sa1100.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 8e618129e65c..75c2a22895f9 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -7,10 +7,6 @@
  *  Copyright (C) 2000 Deep Blue Solutions Ltd.
  */
 
-#if defined(CONFIG_SERIAL_SA1100_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -214,9 +210,7 @@ sa1100_rx_chars(struct sa1100_port *sport)
 			else if (status & UTSR1_TO_SM(UTSR1_FRE))
 				flg = TTY_FRAME;
 
-#ifdef SUPPORT_SYSRQ
 			sport->port.sysrq = 0;
-#endif
 		}
 
 		if (uart_handle_sysrq_char(&sport->port, ch))
@@ -860,6 +854,7 @@ static int sa1100_serial_resume(struct platform_device *dev)
 static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
 {
 	sport->port.dev = &dev->dev;
+	sport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SA1100_CONSOLE);
 
 	// mctrl_gpio_init() requires that the GPIO driver supports interrupts,
 	// but we need to support GPIO drivers for hardware that has no such
-- 
2.24.0

