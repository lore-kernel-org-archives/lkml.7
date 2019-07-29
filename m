Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9000C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C2F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfG2OoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:44:09 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfG2OoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:44:08 -0400
Received: from orion.localdomain ([77.4.29.213]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4bA0-1hqSBc3r9S-001lLn; Mon, 29 Jul 2019 16:44:07 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Subject: [PATCH] drivers: tty: serial: amba-pl011: use generic ops request/release port
Date:   Mon, 29 Jul 2019 16:44:05 +0200
Message-Id: <1564411445-26933-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:jdPTzVwFCUfxy3QU+2kLmfIUT55orwVaxqJ69PmQw5UfU9KZzDw
 wql5XfmsTe/VCPW2xY1keE8jypSgxOHsIecar5nuXnHzQo745zmKsI4Zz7zngr6CsGqAOe8
 elVBX0FMHSSsUBADOSdUrlqxsfgPWCPRTLejjsm4+BUt+9rL9/bDammMcXAEPhcvjIsumvz
 awr1hOF+fOYzcBtyX0oIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9/NGNk0UAT4=:O+Zbg9s8HYxFwidTY8c++4
 hCXMfmBMvffdecKzVGu72HF5tbKcwcWgxJrHbJ46mFcdXOenVp9sbFFXEkjzOzQlDeQocyZAd
 hHicgGZtqNOLuTVOAwMHYyxPQvxilgkWdesUB8hGhGNb1MolZqameOV+Ag2mh1QC/D+pP/yUa
 lsZIgi6PGSeZMWE+9MDyzEFyaUkaJ3J5OdsePMRrbuvsuZwl+LVziPdu/3Nmmf6dGE6BHvnhY
 mGyTUjLpOQ1Qg8Zltw4UKSomZf5e4BtGhmCg1bQ4DwpWOBQozIpECogDmsHF6F9p56FLVVCEx
 O3l+f1ImxRb6abCb3iRXNo8Z6YSp2stKb37sfKQ7u+SlGZq8Cm08IAHZWqZohhAk2P48HCKzP
 fmCTeArQIXYdsydsRlyosyQ7jMnId1FAxET84WFyFpLkdEWn8Wcf1dsI4nzPUX4HruVKYQu9O
 PZX8bkzA3htkoBGCdfaJlypqpVVPyGCPDlBK241cltAe9Rlf+UIOT1c1Bjqlzk+IPUSiDaVum
 L/cTv5aQEDcPZ8qogoEQ0zD8KokMxPN9NCD/M4dm3z7ax6lg+3IDrwoI77SbHIcOTBmcRgL32
 gXAKRBIEfve2IopX9SPZW+jtLq5m4IuAR4p50GFruPWyhzRJCwtpMrAAPkTGQ71e9vVag+LGr
 C8ab6EF4qllV7Y8d7t1KoAuexqYfK0/gvzSpDl5QpKq5qFEx02QMtDL5cEfr6lcAUnavSkZtN
 HQbdaBonZMWd9XpBJ+k6V3v7YRFeh28PF+EvDw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce boilerplate by using generic implementation of the trivial
request_port/release_port operations. For that to work, we have to
set the mapsize field accordingly.
---
 drivers/tty/serial/amba-pl011.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5921a33..6b7c3c7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2094,30 +2094,13 @@ static const char *pl011_type(struct uart_port *port)
 }
 
 /*
- * Release the memory region(s) being used by 'port'
- */
-static void pl011_release_port(struct uart_port *port)
-{
-	release_mem_region(port->mapbase, SZ_4K);
-}
-
-/*
- * Request the memory region(s) being used by 'port'
- */
-static int pl011_request_port(struct uart_port *port)
-{
-	return request_mem_region(port->mapbase, SZ_4K, "uart-pl011")
-			!= NULL ? 0 : -EBUSY;
-}
-
-/*
  * Configure/autoconfigure the port.
  */
 static void pl011_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE) {
 		port->type = PORT_AMBA;
-		pl011_request_port(port);
+		uart_defops_request_port(port);
 	}
 }
 
@@ -2150,8 +2133,8 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 	.flush_buffer	= pl011_dma_flush_buffer,
 	.set_termios	= pl011_set_termios,
 	.type		= pl011_type,
-	.release_port	= pl011_release_port,
-	.request_port	= pl011_request_port,
+	.release_port	= uart_defops_release_port,
+	.request_port	= uart_defops_request_port,
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
@@ -2181,8 +2164,8 @@ static unsigned int sbsa_uart_get_mctrl(struct uart_port *port)
 	.shutdown	= sbsa_uart_shutdown,
 	.set_termios	= sbsa_uart_set_termios,
 	.type		= pl011_type,
-	.release_port	= pl011_release_port,
-	.request_port	= pl011_request_port,
+	.release_port	= uart_defops_release_port,
+	.request_port	= uart_defops_request_port,
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
@@ -2584,6 +2567,7 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 	uap->port.dev = dev;
 	uap->port.mapbase = mmiobase->start;
 	uap->port.membase = base;
+	uap->port.mapsize = SZ_4K;
 	uap->port.fifosize = uap->fifosize;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = index;
-- 
1.9.1

