Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621C520811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCSSne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:43:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:18381 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfCSSnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:43:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 11:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,245,1549958400"; 
   d="scan'208";a="135648402"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Mar 2019 11:43:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 469EF213; Tue, 19 Mar 2019 20:43:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/7] x86/boot: Introduce helpers for serial I/O
Date:   Tue, 19 Mar 2019 21:43:20 +0300
Message-Id: <20190319184325.72807-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparatory to enable earlyprintk on non-standard ports on x86,
introduce serial_in() and serial_out() helpers to perform serial I/O.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/boot/boot.h                          |  2 +
 .../boot/compressed/early_serial_console.c    |  3 +
 arch/x86/boot/compressed/misc.c               |  4 +-
 arch/x86/boot/compressed/misc.h               |  4 ++
 arch/x86/boot/early_serial_console.c          | 63 +++++++++++++------
 arch/x86/boot/tty.c                           |  7 ++-
 6 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index f41291903da7..86641b2e83f8 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -299,6 +299,8 @@ int check_knl_erratum(void);
 int validate_cpu(void);
 
 /* early_serial_console.c */
+extern unsigned int (*serial_in)(unsigned long addr, int offset);
+extern void (*serial_out)(unsigned long addr, int offset, int value);
 extern unsigned long early_serial_base;
 void console_init(void);
 
diff --git a/arch/x86/boot/compressed/early_serial_console.c b/arch/x86/boot/compressed/early_serial_console.c
index 5e3a66478754..4b6269624b59 100644
--- a/arch/x86/boot/compressed/early_serial_console.c
+++ b/arch/x86/boot/compressed/early_serial_console.c
@@ -1,5 +1,8 @@
 #include "misc.h"
 
+unsigned int (*serial_in)(unsigned long addr, int offset);
+void (*serial_out)(unsigned long addr, int offset, int value);
+
 unsigned long early_serial_base;
 
 #include "../early_serial_console.c"
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c0d6c560df69..75b3c8bb92ac 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -98,10 +98,10 @@ static void serial_putchar(int ch)
 {
 	unsigned timeout = 0xffff;
 
-	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
+	while ((serial_in(early_serial_base, LSR) & XMTRDY) == 0 && --timeout)
 		cpu_relax();
 
-	outb(ch, early_serial_base + TXR);
+	serial_out(early_serial_base, TXR, ch);
 }
 
 void __putstr(const char *s)
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 6f2bdf813949..2fd3ec89a70d 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -110,9 +110,13 @@ static inline void finalize_identity_maps(void)
 
 #ifdef CONFIG_EARLY_PRINTK
 /* early_serial_console.c */
+extern unsigned int (*serial_in)(unsigned long addr, int offset);
+extern void (*serial_out)(unsigned long addr, int offset, int value);
 extern unsigned long early_serial_base;
 void console_init(void);
 #else
+static unsigned int (*serial_in)(unsigned long addr, int offset);
+static void (*serial_out)(unsigned long addr, int offset, int value);
 static const unsigned long early_serial_base;
 static inline void console_init(void)
 { }
diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 2b663beda582..05d02cd4de99 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -23,22 +23,45 @@
 
 #define DEFAULT_BAUD 9600
 
-static void early_serial_init(unsigned long port, int baud)
+static unsigned int io_serial_in(unsigned long addr, int offset)
+{
+	return inb(addr + offset);
+}
+
+static void io_serial_out(unsigned long addr, int offset, int value)
+{
+	outb(value, addr + offset);
+}
+
+static void early_serial_configure(unsigned long port, int baud)
 {
 	unsigned char c;
 	unsigned divisor;
 
-	outb(0x3, port + LCR);	/* 8n1 */
-	outb(0, port + IER);	/* no interrupt */
-	outb(0, port + FCR);	/* no fifo */
-	outb(0x3, port + MCR);	/* DTR + RTS */
+	serial_out(port, LCR, 0x3);	/* 8n1 */
+	serial_out(port, IER, 0);	/* no interrupt */
+	serial_out(port, FCR, 0);	/* no fifo */
+	serial_out(port, MCR, 0x3);	/* DTR + RTS */
 
 	divisor	= 115200 / baud;
-	c = inb(port + LCR);
-	outb(c | DLAB, port + LCR);
-	outb(divisor & 0xff, port + DLL);
-	outb((divisor >> 8) & 0xff, port + DLH);
-	outb(c & ~DLAB, port + LCR);
+	c = serial_in(port, LCR);
+	serial_out(port, LCR, c | DLAB);
+	serial_out(port, DLL, divisor & 0xff);
+	serial_out(port, DLH, (divisor >> 8) & 0xff);
+	serial_out(port, LCR, c & ~DLAB);
+}
+
+/* Assign serial I/O accessors */
+static void early_serial_use_io_accessors(void)
+{
+	/* These will always be IO based ports */
+	serial_in = io_serial_in;
+	serial_out = io_serial_out;
+}
+
+static void early_serial_init(unsigned long port, int baud)
+{
+	early_serial_configure(port, baud);
 
 	early_serial_base = port;
 }
@@ -73,6 +96,7 @@ static void parse_earlyprintk(void)
 				port = DEFAULT_SERIAL_PORT;
 			else
 				pos = e - arg;
+			early_serial_use_io_accessors();
 		} else if (!strncmp(arg + pos, "ttyS", 4)) {
 			static const int bases[] = { 0x3f8, 0x2f8 };
 			int idx = 0;
@@ -84,6 +108,7 @@ static void parse_earlyprintk(void)
 				idx = 1;
 
 			port = bases[idx];
+			early_serial_use_io_accessors();
 		}
 
 		if (arg[pos] == ',')
@@ -104,11 +129,11 @@ static unsigned int probe_baud(int port)
 	unsigned char lcr, dll, dlh;
 	unsigned int quot;
 
-	lcr = inb(port + LCR);
-	outb(lcr | DLAB, port + LCR);
-	dll = inb(port + DLL);
-	dlh = inb(port + DLH);
-	outb(lcr, port + LCR);
+	lcr = serial_in(port, LCR);
+	serial_out(port, LCR, lcr | DLAB);
+	dll = serial_in(port, DLL);
+	dlh = serial_in(port, DLH);
+	serial_out(port, LCR, lcr);
 	quot = (dlh << 8) | dll;
 
 	return BASE_BAUD / quot;
@@ -129,11 +154,13 @@ static void parse_console_uart8250(void)
 
 	options = optstr;
 
-	if (!strncmp(options, "uart8250,io,", 12))
+	if (!strncmp(options, "uart8250,io,", 12)) {
 		port = simple_strtoull(options + 12, &options, 0);
-	else if (!strncmp(options, "uart,io,", 8))
+		early_serial_use_io_accessors();
+	} else if (!strncmp(options, "uart,io,", 8)) {
 		port = simple_strtoull(options + 8, &options, 0);
-	else
+		early_serial_use_io_accessors();
+	} else
 		return;
 
 	if (options && (options[0] == ','))
diff --git a/arch/x86/boot/tty.c b/arch/x86/boot/tty.c
index d1d34c6ca153..b6aa9db65cda 100644
--- a/arch/x86/boot/tty.c
+++ b/arch/x86/boot/tty.c
@@ -15,6 +15,9 @@
 
 #include "boot.h"
 
+unsigned int (*serial_in)(unsigned long addr, int offset);
+void (*serial_out)(unsigned long addr, int offset, int value);
+
 unsigned long early_serial_base;
 
 #define XMTRDY          0x20
@@ -31,10 +34,10 @@ static void __attribute__((section(".inittext"))) serial_putchar(int ch)
 {
 	unsigned timeout = 0xffff;
 
-	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
+	while ((serial_in(early_serial_base, LSR) & XMTRDY) == 0 && --timeout)
 		cpu_relax();
 
-	outb(ch, early_serial_base + TXR);
+	serial_out(early_serial_base, TXR, ch);
 }
 
 static void __attribute__((section(".inittext"))) bios_putchar(int ch)
-- 
2.20.1

