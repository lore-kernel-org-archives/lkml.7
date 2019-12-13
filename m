Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443D1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13096227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GavOjZqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfLMAKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:10:51 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37279 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbfLMAIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so346733pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fEut0Fj8lvNcNC7jiLkhwffOKZHHYE/mx3CuScNZ2v8=;
        b=GavOjZqbHPXSvQsnp/4V2Vt2SbCm4wYmihMFu5kV6wmSDnQ2gZbhwrJGLpCGH8sZxc
         Mq3wTXtMxedfn5H6MhT8R0ZO36Id/ejuXCdH9tzshbmjAyq4XUn0K37ZvQ8+zF70KRlV
         A/xASlDmfCmEQkcjagj6/tOa2thmMlNg19XyRWpXHfYRcIexZfxxTdGcYFOZjmYT+S4N
         r778RI7pLZV6+wgHCoKtc2zKS5DVHCGS8qLdEZZvfpWGJ8+k43PdW0Vs4gaM8pHSQ7MH
         i36T2zmtzstJ9XsrkTbmXaqlKoO7gJSxO65l8tjt3Ot6HMrRPfekWZ4yWi//L65kOe5h
         +80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEut0Fj8lvNcNC7jiLkhwffOKZHHYE/mx3CuScNZ2v8=;
        b=GGdu3uuKvGLSowX8v1d2tVD+eknpzKKwGPJgACo8B/xbArjigDS6vrwWZEeSvJALze
         7b8f6yO1AQKdH5Q8vo9lIT5vs1N6BbS7HqPf1rQpeEJU+ONg2Fwu8jf2L2lpjY6E9qMk
         aYWDf3h2sYeaGfu0Xi/+X0uuBTF0cszgYXVarM7VAh610oAuG+pbziHWRwmLsrA2/sl5
         NpXrjTA/ZiD6OVxfi1eF53NvYeP6zKgZiTjGLeOWRO7Wy9h/Q27BjrRQIhqZ0GpI4OcP
         jZ2+eyFgyzn+zGc8GonqvYf3Gn2thMTKahQYOz36d7+yLbfwtZ79M86stWV8XQAqbeGy
         xM+w==
X-Gm-Message-State: APjAAAXfclqnqrT1jmKI1nlgOjlEOvb1avgpx8FsH2lpI46I+N1CJSFb
        6zocNbJ9ZE4lKWRv8rHqpPgEGhgLsjU=
X-Google-Smtp-Source: APXvYqwpZRasKszg6AZ/+lEvc5jALuKv9L8/eVh4D12TL0p2ZnL8XIvcoaxFCrZ/cC8QZUytMV6sTg==
X-Received: by 2002:a17:90a:6346:: with SMTP id v6mr12978944pjs.51.1576195720577;
        Thu, 12 Dec 2019 16:08:40 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:39 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 29/58] tty/serial: Migrate pch_uart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:28 +0000
Message-Id: <20191213000657.931618-30-dima@arista.com>
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
 drivers/tty/serial/pch_uart.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index c16234bca78f..c625bf7b8a92 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -2,9 +2,6 @@
 /*
  *Copyright (C) 2011 LAPIS Semiconductor Co., Ltd.
  */
-#if defined(CONFIG_SERIAL_PCH_UART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
 #include <linux/kernel.h>
 #include <linux/serial_reg.h>
 #include <linux/slab.h>
@@ -587,12 +584,10 @@ static int pch_uart_hal_read(struct eg20t_port *priv, unsigned char *buf,
 			if (uart_handle_break(port))
 				continue;
 		}
-#ifdef SUPPORT_SYSRQ
 		if (port->sysrq) {
 			if (uart_handle_sysrq_char(port, rbr))
 				continue;
 		}
-#endif
 
 		buf[i++] = rbr;
 	}
@@ -1796,6 +1791,7 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	priv->port.flags = UPF_BOOT_AUTOCONF;
 	priv->port.fifosize = fifosize;
 	priv->port.line = board->line_no;
+	priv->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_PCH_UART_CONSOLE);
 	priv->trigger = PCH_UART_HAL_TRIGGER_M;
 
 	snprintf(priv->irq_name, IRQ_NAME_SIZE,
-- 
2.24.0

