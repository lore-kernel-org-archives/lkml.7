Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EAAC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE04E2253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Vov9+2yB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfLMAIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38988 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbfLMAIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so535517pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Euik8RhSRJjHmC28+StnihMZD1d4qJRUDgdRlDVUqg8=;
        b=Vov9+2yB9/3J2+7DANI/wPjle8KZwVg0d5zBvN5FnKFK2vBdtzOq7YcpV9aNTO2UVi
         J+2z+NpVo3Ei+Pl4+oggYNrBLDvL/eMxREVg6SLUIyyiHBghtCgmfaXVT57XltyKauc3
         OzAv3XL2UKiRaOikeC7iTvhrIzspRT8CUNWLLjzmuYT+nYNmZaGi5qcUtIqcam0H124e
         RbclY+ExjONTJH6cmIEhDq6bmEYd9/EAFkqIp/bZq9PKYiVdFbNKprQM4q9hbaC3RKqk
         IGMkNo2fkuWmlu2mT7mfqbIin7ri/Vc8aIKwHHOOpF2FCjzTecK7E3S40SISqeuGnlox
         bD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Euik8RhSRJjHmC28+StnihMZD1d4qJRUDgdRlDVUqg8=;
        b=oZ7FXu2fuxTW9g8oDQw8Zkv2HzmvZQB0ykrDZW6rs957wFDlbwajc3kjA6UGA3WJLG
         vbqWpXBxTRMaj+MD2DMNrQBN07tu1SyPfSU77BCOKIuRC+jzlqVmr/qcCKHozhOXy73x
         pTiYRiQ5WCch94/PsuRzmFtdAaMJH92+SsYWqiv8C7tsB/21iPckdwK0IB9dXyUh0aug
         MZHI9coHOwLqfnP9IPKgIYlsuOtcZqjeg9jUnA8q1rscdm6+ETFvP0M4EZgmoeQbbTFT
         PpDGRZUF8wjHpZXwwTTZ48NRZzNWsQ7b1yRCgzC4m45soz0StPGvCOdqlExtv3AUnPRZ
         MbpQ==
X-Gm-Message-State: APjAAAXATL3hPZqEnw75cbBvyYPZ/T3DeKrAjpC0b9Jkq2hqo01CCbIy
        OQR8RhWSH8MLmyEk/TXu5irnucrwQWg=
X-Google-Smtp-Source: APXvYqzY6lLiNfLcAT2CBNRvssxZ7MTePv1pHo5Z9zzhPNEs2I5saW4nMcezRwTRhfTnTCpuHM6CLA==
X-Received: by 2002:aa7:95a9:: with SMTP id a9mr12656949pfk.15.1576195681400;
        Thu, 12 Dec 2019 16:08:01 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:00 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 16/58] tty/serial: Migrate efm32-uart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:15 +0000
Message-Id: <20191213000657.931618-17-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/efm32-uart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index d6b5e5463746..2ac87128d7fd 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -1,8 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#if defined(CONFIG_SERIAL_EFM32_UART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/io.h>
@@ -748,6 +744,7 @@ static int efm32_uart_probe(struct platform_device *pdev)
 	efm_port->port.type = PORT_EFMUART;
 	efm_port->port.iotype = UPIO_MEM32;
 	efm_port->port.fifosize = 2;
+	efm_port->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_EFM32_UART_CONSOLE);
 	efm_port->port.ops = &efm32_uart_pops;
 	efm_port->port.flags = UPF_BOOT_AUTOCONF;
 
-- 
2.24.0

