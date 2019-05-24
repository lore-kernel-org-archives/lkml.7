Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E7FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39CD2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="a/vWLxpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbfEXIFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:05:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58669 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389181AbfEXIFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:05:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O84mUh117650
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:04:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O84mUh117650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685089;
        bh=GZVIe5tmWqtR3ro5VQFMeUy4S8qgWCv8Paz2nR9mSEg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=a/vWLxpGqYE93/btJHjNmqP1uz/pd9FbfZ7XINq1QBIWB6qpjDKDpMO/lzOqe1g9p
         NRETgC1LYFIXmswUHm67s4wQF3tx89hTLvmU31tx62yYcfbczuzC7rMgZozic08+Ky
         hb0Pm6cQ96Uc9H3oZU1xd95ZFZTG1O7u2qb6iAaZwVOBXxtsqU4WQhKFPxtZSgVPDf
         omseV1mV208kymNxJax7Y4AngZF3CcKPSPlLzN8BC44U/8A+OyRGPoShK7pe89d8k6
         0EgSGksFSrJ/EQLH9tZbUXLf8BZtSL9zcC4ng3dJq+4Uhl7JtKrKsJQExs7G5x84sH
         YjXns6jsCnzcg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O84mnZ117646;
        Fri, 24 May 2019 01:04:48 -0700
Date:   Fri, 24 May 2019 01:04:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-c2d64c7ec4de6385150aa79570c438b4ba49c243@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org
Reply-To: yamada.masahiro@socionext.com, peterz@infradead.org,
          bp@alien8.de, tglx@linutronix.de, mingo@kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190521072211.21014-2-yamada.masahiro@socionext.com>
References: <20190521072211.21014-2-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/io_delay: Define IO_DELAY macros in C
 instead of Kconfig
Git-Commit-ID: c2d64c7ec4de6385150aa79570c438b4ba49c243
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c2d64c7ec4de6385150aa79570c438b4ba49c243
Gitweb:     https://git.kernel.org/tip/c2d64c7ec4de6385150aa79570c438b4ba49c243
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 21 May 2019 16:22:11 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 08:46:06 +0200

x86/io_delay: Define IO_DELAY macros in C instead of Kconfig

CONFIG_IO_DELAY_TYPE_* are not kernel configuration at all. They just
define constant values, 0, 1, 2, and 3. Define them by #define in C.

CONFIG_DEFAULT_IO_DELAY_TYPE can also be defined in C by using #ifdef
and #define directives.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190521072211.21014-2-yamada.masahiro@socionext.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig.debug     | 44 --------------------------------------------
 arch/x86/kernel/io_delay.c | 37 ++++++++++++++++++++++++++-----------
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
 
