Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39B7C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89922073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Z/PDy/mV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfLMAJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42153 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731901AbfLMAJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so525660pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yMq/uVp2bU7wlvZw3KZoovZc3l4G7lkpgRh+6p4cD3E=;
        b=Z/PDy/mVsZTQqr/IepgWfeO3RQGcdegMuGz3YoVARfv4HpthA8oi8i2KQw6uBDhz33
         O4Ow1GEg4g+ZFVImGVpbI1M0s9h/cH7kpfkTKEGX8XgsLS08xVTguobc4MrhmgNwwczx
         KwoJiECme9OsAKNFUInINhcA04o2VBUuROayRtWWZPFfnQSQEC6tWsz5XMDLIodOAt7d
         NDOaFUQAFBCjSweyX/Gw9yxlE+PA9WlQxp/bqfdfHXL14bwTBduKD9zMEzL/aXvPpXfn
         FChEa9mUzsoODPgkqpp5Wrn2rRy+0p3aLx5eVPkkX8gMA80uqMUzR+ZYgmXA7Jp8Ngx9
         TZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yMq/uVp2bU7wlvZw3KZoovZc3l4G7lkpgRh+6p4cD3E=;
        b=ZsBc6/0+cdAupb5+u0G9jQNhTibIsUyFZI8gHq8YOi/BnHu4dIcs6x93Eh0co+/nAs
         +hGoK8PnavxPEsFX0HSMdDXrmS0DR/KSQybznCb7G2SgYqyg4sZ9nj4Xq2TdAN66QdNw
         2XfP5bVeiwX9BCKcAoRNFf9SB4TEvI7wDqMYaIm10JZnmEn/A/YuxG29gy8UAhnQ0MpY
         dmQOcMa9S5KjZDBp5ijKuTe+/t2/VMs63KPIrRS466UAGR2ySTf79eOuQRd9UcmlWz0L
         2tdByi/7qyglRPmlbRMBuRAJDu+79KySXUxnQca6WHekN3kH4LSJo/9A7FVoyswKiYRg
         r14g==
X-Gm-Message-State: APjAAAX0TnjuytXSqVbPSeW0NFGEmGufTYvNDeqRw9OdTfX0OsIEp8RC
        C8fGQYGmZXRheWZvZ0DT2aNZtFvCSRk=
X-Google-Smtp-Source: APXvYqwOENiOM4ymiVUwMat/f33ffxUq/FBlNLHyjzgxpbp6j6YG6HK/8dg6aGyVUNuaJlZ5rmXAzg==
X-Received: by 2002:a63:f844:: with SMTP id v4mr13352747pgj.71.1576195788732;
        Thu, 12 Dec 2019 16:09:48 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:47 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 52/58] tty/serial: Migrate xilinx_uartps to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:51 +0000
Message-Id: <20191213000657.931618-53-dima@arista.com>
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

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/xilinx_uartps.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4e55bc327a54..2b5606469bed 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -9,10 +9,6 @@
  * in the code.
  */
 
-#if defined(CONFIG_SERIAL_XILINX_PS_UART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/console.h>
@@ -1634,6 +1630,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &cdns_uart_ops;
 	port->fifosize	= CDNS_UART_FIFO_SIZE;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_XILINX_PS_UART_CONSOLE);
 
 	/*
 	 * Register the port.
-- 
2.24.0

