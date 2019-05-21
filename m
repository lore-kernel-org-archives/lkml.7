Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7118C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC21C2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oYYi5+wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfEUHYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:24:08 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:22389 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfEUHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:24:08 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x4L7MHPs022832;
        Tue, 21 May 2019 16:22:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x4L7MHPs022832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558423339;
        bh=cqf/OA7v0beVGYTBfCLFXz4KvzaltleguuA8BoAdm58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYYi5+wKBbBtQKFDMZ5zDSJqB0++eS0fQ7rtdyJlTC5qQwzKttsnGLXUsN5jdcqXS
         fKtrWaFmC0yBV2u7TE2ilRQcy+QnVPAwLrIwtbT0erjK6jpp1nyO4cMLOteruaY07W
         m+TpZywYINXk/ShQglGQr0O8z4qfQPDpm9uT49cmxPij8oKn4TNlCpFr4LNx4TvEns
         d+/dGIsTl3pWNcbwem15SBMTpGgg31AsDe6zMcl1ym2+Zmzp5XnuNC9KjOQ5ppBno6
         8AZ+3CGyibut+0/lV71haPMm8tUN9BC5TeqmadfXxGil02trpMQt/iSCnFTuLaxcwr
         8BFQysmo9WtaQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/io_delay: define IO_DELAY macros in C instead of Kconfig
Date:   Tue, 21 May 2019 16:22:11 +0900
Message-Id: <20190521072211.21014-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521072211.21014-1-yamada.masahiro@socionext.com>
References: <20190521072211.21014-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IO_DELAY_TYPE_* are not kernel configuration at all. They just
define constant values, 0, 1, 2, and 3. Define them by #define in C.

CONFIG_DEFAULT_IO_DELAY_TYPE can also be defined in C by using #ifdef
and #define directives.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Kconfig.debug     | 44 --------------------------------------
 arch/x86/kernel/io_delay.c | 37 ++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 55 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index f730680dc818..6791a3c97589 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -179,26 +179,6 @@ config X86_DECODER_SELFTEST
 	 decoder code.
 	 If unsure, say "N".
 
-#
-# IO delay types:
-#
-
-config IO_DELAY_TYPE_0X80
-	int
-	default "0"
-
-config IO_DELAY_TYPE_0XED
-	int
-	default "1"
-
-config IO_DELAY_TYPE_UDELAY
-	int
-	default "2"
-
-config IO_DELAY_TYPE_NONE
-	int
-	default "3"
-
 choice
 	prompt "IO delay type"
 	default IO_DELAY_0X80
@@ -229,30 +209,6 @@ config IO_DELAY_NONE
 
 endchoice
 
-if IO_DELAY_0X80
-config DEFAULT_IO_DELAY_TYPE
-	int
-	default IO_DELAY_TYPE_0X80
-endif
-
-if IO_DELAY_0XED
-config DEFAULT_IO_DELAY_TYPE
-	int
-	default IO_DELAY_TYPE_0XED
-endif
-
-if IO_DELAY_UDELAY
-config DEFAULT_IO_DELAY_TYPE
-	int
-	default IO_DELAY_TYPE_UDELAY
-endif
-
-if IO_DELAY_NONE
-config DEFAULT_IO_DELAY_TYPE
-	int
-	default IO_DELAY_TYPE_NONE
-endif
-
 config DEBUG_BOOT_PARAMS
 	bool "Debug boot parameters"
 	depends on DEBUG_KERNEL
diff --git a/arch/x86/kernel/io_delay.c b/arch/x86/kernel/io_delay.c
index 3dc874d5d43b..fdb6506ceaaa 100644
--- a/arch/x86/kernel/io_delay.c
+++ b/arch/x86/kernel/io_delay.c
@@ -13,7 +13,22 @@
 #include <linux/dmi.h>
 #include <linux/io.h>
 
-int io_delay_type __read_mostly = CONFIG_DEFAULT_IO_DELAY_TYPE;
+#define IO_DELAY_TYPE_0X80	0
+#define IO_DELAY_TYPE_0XED	1
+#define IO_DELAY_TYPE_UDELAY	2
+#define IO_DELAY_TYPE_NONE	3
+
+#if defined(CONFIG_IO_DELAY_0X80)
+#define DEFAULT_IO_DELAY_TYPE	IO_DELAY_TYPE_0X80
+#elif defined(CONFIG_IO_DELAY_0XED)
+#define DEFAULT_IO_DELAY_TYPE	IO_DELAY_TYPE_0XED
+#elif defined(CONFIG_IO_DELAY_UDELAY)
+#define DEFAULT_IO_DELAY_TYPE	IO_DELAY_TYPE_UDELAY
+#elif defined(CONFIG_IO_DELAY_NONE)
+#define DEFAULT_IO_DELAY_TYPE	IO_DELAY_TYPE_NONE
+#endif
+
+int io_delay_type __read_mostly = DEFAULT_IO_DELAY_TYPE;
 
 static int __initdata io_delay_override;
 
@@ -24,13 +39,13 @@ void native_io_delay(void)
 {
 	switch (io_delay_type) {
 	default:
-	case CONFIG_IO_DELAY_TYPE_0X80:
+	case IO_DELAY_TYPE_0X80:
 		asm volatile ("outb %al, $0x80");
 		break;
-	case CONFIG_IO_DELAY_TYPE_0XED:
+	case IO_DELAY_TYPE_0XED:
 		asm volatile ("outb %al, $0xed");
 		break;
-	case CONFIG_IO_DELAY_TYPE_UDELAY:
+	case IO_DELAY_TYPE_UDELAY:
 		/*
 		 * 2 usecs is an upper-bound for the outb delay but
 		 * note that udelay doesn't have the bus-level
@@ -40,7 +55,7 @@ void native_io_delay(void)
 		 */
 		udelay(2);
 		break;
-	case CONFIG_IO_DELAY_TYPE_NONE:
+	case IO_DELAY_TYPE_NONE:
 		break;
 	}
 }
@@ -48,9 +63,9 @@ EXPORT_SYMBOL(native_io_delay);
 
 static int __init dmi_io_delay_0xed_port(const struct dmi_system_id *id)
 {
-	if (io_delay_type == CONFIG_IO_DELAY_TYPE_0X80) {
+	if (io_delay_type == IO_DELAY_TYPE_0X80) {
 		pr_notice("%s: using 0xed I/O delay port\n", id->ident);
-		io_delay_type = CONFIG_IO_DELAY_TYPE_0XED;
+		io_delay_type = IO_DELAY_TYPE_0XED;
 	}
 
 	return 0;
@@ -116,13 +131,13 @@ static int __init io_delay_param(char *s)
 		return -EINVAL;
 
 	if (!strcmp(s, "0x80"))
-		io_delay_type = CONFIG_IO_DELAY_TYPE_0X80;
+		io_delay_type = IO_DELAY_TYPE_0X80;
 	else if (!strcmp(s, "0xed"))
-		io_delay_type = CONFIG_IO_DELAY_TYPE_0XED;
+		io_delay_type = IO_DELAY_TYPE_0XED;
 	else if (!strcmp(s, "udelay"))
-		io_delay_type = CONFIG_IO_DELAY_TYPE_UDELAY;
+		io_delay_type = IO_DELAY_TYPE_UDELAY;
 	else if (!strcmp(s, "none"))
-		io_delay_type = CONFIG_IO_DELAY_TYPE_NONE;
+		io_delay_type = IO_DELAY_TYPE_NONE;
 	else
 		return -EINVAL;
 
-- 
2.17.1

