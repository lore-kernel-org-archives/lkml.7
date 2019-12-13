Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD527C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8324C206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="i7uxmhA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfLMAIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42200 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbfLMAIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so379703pfz.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eIG2+4JbwVOuLRSDX8JZZBINCAprxXq9FQQrJM6v5lY=;
        b=i7uxmhA2rgEx5xz5lwkNok1PJSSUXiIGLw2LYAurwbY25ER+4Kn2iIb8xZJpupl8eS
         GMFaqOnsR9Xk0kkTXTORWl3OApnz1zkV1b/5Mri63yr4/t8LAS1GyUvkfTEE6tefzRCj
         rX4xYsqGGQSy4VgL1nBXyIQBhvqGppe6wqJHq3vHjYNphpNhgVFXvCh6XQ1dNo5+qVfu
         OB00i/RNOVpg8mpuej5sR0lEhGxiZNujzNOZKOoPlfNGQtBeD+//SlBunakQJ4wnMZfw
         s8vtkYZgemCVG5uJwv8zCQqzgKCtPJMxAtXm8aaPngpieBNmwV9Fz3WlZ9yiuy5P33SE
         e+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eIG2+4JbwVOuLRSDX8JZZBINCAprxXq9FQQrJM6v5lY=;
        b=KsJl26C1c0AJqDDbrRmqPTnPRNyRr4oGyOFWRzhZ2dVUk/4wN8Hde3248uYs/VPF+a
         FewE6TR7nYTXvTCx05VX3ZZ650Gi5RoQrJpfRxoWQkp7G5icV0oKes/8uQfppHaiKiBN
         gv1i67Jev7fZ+m++vlHiSxjEgNxGjVonZPPgVzJQYb86Yyu0d1EUN2LUeIFI79yB3nVu
         BKECCdpo/iAWzeHoWAAZikZK49Fwl84qWrZoiARq94JJ0a1VlkaOzFN9c7O27HbTLkaP
         aU8t5VFpe3Mcg7Erkjm+h7JmCm/Ww22MfUyGzJEfnZlGNCFZepWRGShZU14lH1zcsytd
         Mpcg==
X-Gm-Message-State: APjAAAXtESd39mQzsBHT4/cIrxRwIdSZuCLQPIPbcQrNKLZbq49bB1vh
        yyOQSHvdwFqDES/16q813/Fsxd2EvTk=
X-Google-Smtp-Source: APXvYqw5ht+uJN4C/OeK2k0lFtlvIG3dJAym/DzMXBsu1g2/2ovtqrVHmV9EmTuPxecmvGJGcMfDqA==
X-Received: by 2002:a62:53c3:: with SMTP id h186mr5433700pfb.118.1576195699313;
        Thu, 12 Dec 2019 16:08:19 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:18 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 22/58] tty/serial: Migrate milbeaut_usio to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:21 +0000
Message-Id: <20191213000657.931618-23-dima@arista.com>
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
 drivers/tty/serial/milbeaut_usio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 949ab7efc4fc..8f2cab7f66ad 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -3,10 +3,6 @@
  * Copyright (C) 2018 Socionext Inc.
  */
 
-#if defined(CONFIG_SERIAL_MILBEAUT_USIO_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/module.h>
@@ -537,6 +533,7 @@ static int mlb_usio_probe(struct platform_device *pdev)
 	port->irq = mlb_usio_irq[index][RX];
 	port->uartclk = clk_get_rate(clk);
 	port->fifosize = 128;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MILBEAUT_USIO_CONSOLE);
 	port->iotype = UPIO_MEM32;
 	port->flags = UPF_BOOT_AUTOCONF | UPF_SPD_VHI;
 	port->line = index;
-- 
2.24.0

