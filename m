Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F877C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221E620836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575988655;
	bh=Jj+kqL3oDpAOi3xZ9oFO5W6Gd+sw+qlOruuOifJ0chM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HfjJsZrrTtV17zny8CZU8OMO9L3tn6FFiGSpBCuO/kLAbWnzQjuoozxpWPUDnCDjz
	 c79j4VaJveP8MHvX+w43jvVFtTIioAAwuQLTUruwK/8jWf0QWbPbQN+3AdorZ55rWk
	 qoNECVI768DT86fkChWGmbTpG1cBwu1kAFJzo1zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfLJOhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfLJOhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:37:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A87420637;
        Tue, 10 Dec 2019 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988649;
        bh=Jj+kqL3oDpAOi3xZ9oFO5W6Gd+sw+qlOruuOifJ0chM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIGN0/mdbwR7DhlORTEopy1cIB7Yf1k+QLNhgfHWLjjqA0JJRGuDwRXbQstYIQDi/
         ROhlY/yaEFiLm8BbJlg0dUB1Qjv24Xr/TK+vcwD43gTnhrBHpEqKVwZw32UIe3s/kv
         O7KAD9/QbQTM1yHFzIIDnPIhPQESZw7rKatnKucs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] tty: serial: samsung_tty: drop unneded dbg() calls
Date:   Tue, 10 Dec 2019 15:37:02 +0100
Message-Id: <20191210143706.3928480-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the kernel has ftrace, any debugging calls that just do "made
it to this function!" and "leaving this function!" can be removed.

On the quest to move the samsung_tty driver over to use the standard
kernel debugging functions, drop these unneeded calls.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 1a3bf5879344..37749f09066d 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1136,9 +1136,6 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	int ret;
 
-	dbg("s3c24xx_serial_startup: port=%p (%08llx,%p)\n",
-	    port, (unsigned long long)port->mapbase, port->membase);
-
 	rx_enabled(port) = 1;
 
 	ret = request_irq(ourport->rx_irq, s3c24xx_serial_rx_chars, 0,
@@ -1165,8 +1162,6 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 
 	ourport->tx_claimed = 1;
 
-	dbg("s3c24xx_serial_startup ok\n");
-
 	/* the port reset code should have done the correct
 	 * register setup for the port controls */
 
@@ -1184,9 +1179,6 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	unsigned int ufcon;
 	int ret;
 
-	dbg("s3c64xx_serial_startup: port=%p (%08llx,%p)\n",
-	    port, (unsigned long long)port->mapbase, port->membase);
-
 	wr_regl(port, S3C64XX_UINTM, 0xf);
 	if (ourport->dma) {
 		ret = s3c24xx_serial_request_dma(ourport);
@@ -1224,7 +1216,6 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	/* Enable Rx Interrupt */
 	s3c24xx_clear_bit(port, S3C64XX_UINTM_RXD, S3C64XX_UINTM);
 
-	dbg("s3c64xx_serial_startup ok\n");
 	return ret;
 }
 
@@ -1870,8 +1861,6 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	struct resource *res;
 	int ret;
 
-	dbg("s3c24xx_serial_init_port: port=%p, platdev=%p\n", port, platdev);
-
 	if (platdev == NULL)
 		return -ENODEV;
 
@@ -2011,8 +2000,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 			index = ret;
 	}
 
-	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
-
 	if (index >= ARRAY_SIZE(s3c24xx_serial_ports)) {
 		dev_err(&pdev->dev, "serial%d out of range\n", index);
 		return -EINVAL;
@@ -2273,10 +2260,6 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 	ucon   = rd_regl(port, S3C2410_UCON);
 	ubrdiv = rd_regl(port, S3C2410_UBRDIV);
 
-	dbg("s3c24xx_serial_get_options: port=%p\n"
-	    "registers: ulcon=%08x, ucon=%08x, ubdriv=%08x\n",
-	    port, ulcon, ucon, ubrdiv);
-
 	if (s3c24xx_port_configured(ucon)) {
 		switch (ulcon & S3C2410_LCON_CSMASK) {
 		case S3C2410_LCON_CS5:
@@ -2334,9 +2317,6 @@ s3c24xx_serial_console_setup(struct console *co, char *options)
 	int parity = 'n';
 	int flow = 'n';
 
-	dbg("s3c24xx_serial_console_setup: co=%p (%d), %s\n",
-	    co, co->index, options);
-
 	/* is this a valid port */
 
 	if (co->index == -1 || co->index >= CONFIG_SERIAL_SAMSUNG_UARTS)
@@ -2351,8 +2331,6 @@ s3c24xx_serial_console_setup(struct console *co, char *options)
 
 	cons_uart = port;
 
-	dbg("s3c24xx_serial_console_setup: port=%p (%d)\n", port, co->index);
-
 	/*
 	 * Check whether an invalid uart number has been specified, and
 	 * if so, search for the first available port that does have
-- 
2.24.0

