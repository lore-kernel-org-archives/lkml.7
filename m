Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB72AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08672070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="SGjyUqhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfJHOMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:12:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36438 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:12:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so3316723wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=hhi061WV6l5bWbobRameaZ9fCkXMs3Uy6r+tMzymC4k=;
        b=SGjyUqhNTPVgZePfTUEeMOde3BfWCV9UG9Nd5S/u8KasboYQCvwQl0RSXfJbDMDDbT
         t1nmS5O9zoCWwSvbrCbAaq7lckg6o/PHnphjhc4vEf7UqHY/WY2qBrsT+eec9EF+Pr2H
         Y/Wjioj2m/dhNoa/EYIVRj5w8fUruFsV1cHo2ahOFnguSfkN0L4xFGq93qNJw/VwqftI
         p3sagGJMdqR8yYGUK/FFJ5ahnQHJyysl14XeVlmwZ+dtjnDT1ggwr41YkP0YbzI+t87R
         RI02LAKnC7rdEgrjfqNmwfNfMP3aDA3Z7EXcs8spLMNSRBCWY9+1fn2lhfQgx6pbiszr
         3q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=hhi061WV6l5bWbobRameaZ9fCkXMs3Uy6r+tMzymC4k=;
        b=JOQe+NRO7mpyOMPMcabByZ/VDVrDtVeKHMxUv8RKvnXRUSVZLa+CZG9MSMJ5n0XuS5
         v5gDI0UMYuYdZnDTJKt5KONUFcMoZ/Rgs3KFc8NIVaFh2jKTR0oWYrBttJ7Xurz81mXF
         sDqqwJqf3XI5pTbiIVNaIHuctPABFEC9sOWR89WWrkfR4wpWX5X2RBPmpa1jFe2hVh8I
         yYQ0+nsI0Wxarx8y3O4aSn04SB8xBni/YrJ+OEfikE7Pj0l8hg301kBfOLEEjyVkGw3z
         wvijJhExKVnJfwygf64mfhutnx/YOvjfFT0H+EKqfrwB41v6ai6+vrYGD9JK1lkMqE0e
         GYjw==
X-Gm-Message-State: APjAAAVrRiS+aLvtQ/M7dg+IB/WVzCBnaIMGOa5m5HbkCspWfv2Bo4sy
        kf5qQav2EY3zFsuU1tIAdi17JcMS1nMWf6Gg
X-Google-Smtp-Source: APXvYqyJXduMWr+YDS5spGRQEcNwmz3rzPzkWy1P/eYsPopGINliLMm8PKc/3GSGU5f2vUfY8jvStQ==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr3972815wmf.80.1570543928879;
        Tue, 08 Oct 2019 07:12:08 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id r18sm4362096wme.48.2019.10.08.07.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 07:12:08 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] hvc: dcc: Add earlycon support
Date:   Tue,  8 Oct 2019 16:12:06 +0200
Message-Id: <41e2920a6348e65b2e986b0e65b66531e87cd756.1570543923.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DCC earlycon support for early printks. The patch is useful for SoC
bringup where HW serial console is broken.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

I have this patch in Xilinx tree for quite a long time and it was develop
as preparation work for SoC bringup where jtag is functional and get
information from kernel what's going on.

There is one checkpatch warning
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+static void dcc_early_write(struct console *con, const char *s, unsigned n)
but
console write is defined like that.
include/linux/console.h  +145
void    (*write)(struct console *, const char *, unsigned);
---
 drivers/tty/hvc/hvc_dcc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 02629a1f193d..8e0edb7d93fd 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2010, 2014 The Linux Foundation. All rights reserved.  */
 
+#include <linux/console.h>
 #include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
 
 #include <asm/dcc.h>
 #include <asm/processor.h>
@@ -12,6 +15,31 @@
 #define DCC_STATUS_RX		(1 << 30)
 #define DCC_STATUS_TX		(1 << 29)
 
+static void dcc_uart_console_putchar(struct uart_port *port, int ch)
+{
+	while (__dcc_getstatus() & DCC_STATUS_TX)
+		cpu_relax();
+
+	__dcc_putchar(ch);
+}
+
+static void dcc_early_write(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, dcc_uart_console_putchar);
+}
+
+static int __init dcc_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	device->con->write = dcc_early_write;
+
+	return 0;
+}
+
+EARLYCON_DECLARE(dcc, dcc_early_console_setup);
+
 static int hvc_dcc_put_chars(uint32_t vt, const char *buf, int count)
 {
 	int i;
-- 
2.17.1

