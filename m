Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880EAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644E420811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfCSSne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:43:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:57905 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbfCSSnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:43:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 11:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,245,1549958400"; 
   d="scan'208";a="330066607"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2019 11:43:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3DC5645; Tue, 19 Mar 2019 20:43:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/7] x86/boot: Convert early_serial_base to unsigned long
Date:   Tue, 19 Mar 2019 21:43:19 +0300
Message-Id: <20190319184325.72807-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparatory of adding flexible serial I/O accessors, convert
early_serial_base to unsigned long to cover all possible bus addresses
on the system.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/boot/boot.h                            | 2 +-
 arch/x86/boot/compressed/early_serial_console.c | 2 +-
 arch/x86/boot/compressed/misc.h                 | 4 ++--
 arch/x86/boot/early_serial_console.c            | 6 +++---
 arch/x86/boot/tty.c                             | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 32a09eb5c101..f41291903da7 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -299,7 +299,7 @@ int check_knl_erratum(void);
 int validate_cpu(void);
 
 /* early_serial_console.c */
-extern int early_serial_base;
+extern unsigned long early_serial_base;
 void console_init(void);
 
 /* edd.c */
diff --git a/arch/x86/boot/compressed/early_serial_console.c b/arch/x86/boot/compressed/early_serial_console.c
index 261e81fb9582..5e3a66478754 100644
--- a/arch/x86/boot/compressed/early_serial_console.c
+++ b/arch/x86/boot/compressed/early_serial_console.c
@@ -1,5 +1,5 @@
 #include "misc.h"
 
-int early_serial_base;
+unsigned long early_serial_base;
 
 #include "../early_serial_console.c"
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index fd13655e0f9b..6f2bdf813949 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -110,10 +110,10 @@ static inline void finalize_identity_maps(void)
 
 #ifdef CONFIG_EARLY_PRINTK
 /* early_serial_console.c */
-extern int early_serial_base;
+extern unsigned long early_serial_base;
 void console_init(void);
 #else
-static const int early_serial_base;
+static const unsigned long early_serial_base;
 static inline void console_init(void)
 { }
 #endif
diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 023bf1c3de8b..2b663beda582 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -23,7 +23,7 @@
 
 #define DEFAULT_BAUD 9600
 
-static void early_serial_init(int port, int baud)
+static void early_serial_init(unsigned long port, int baud)
 {
 	unsigned char c;
 	unsigned divisor;
@@ -48,7 +48,7 @@ static void parse_earlyprintk(void)
 	int baud = DEFAULT_BAUD;
 	char arg[32];
 	int pos = 0;
-	int port = 0;
+	unsigned long port = 0;
 
 	if (cmdline_find_option("earlyprintk", arg, sizeof(arg)) > 0) {
 		char *e;
@@ -118,7 +118,7 @@ static void parse_console_uart8250(void)
 {
 	char optstr[64], *options;
 	int baud = DEFAULT_BAUD;
-	int port = 0;
+	unsigned long port = 0;
 
 	/*
 	 * console=uart8250,io,0x3f8,115200n8
diff --git a/arch/x86/boot/tty.c b/arch/x86/boot/tty.c
index def2451f46ae..d1d34c6ca153 100644
--- a/arch/x86/boot/tty.c
+++ b/arch/x86/boot/tty.c
@@ -15,7 +15,7 @@
 
 #include "boot.h"
 
-int early_serial_base;
+unsigned long early_serial_base;
 
 #define XMTRDY          0x20
 
-- 
2.20.1

