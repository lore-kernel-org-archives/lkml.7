Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D85C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 04:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C60920825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 04:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMs8qnIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfEGEcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 00:32:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39300 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfEGEcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 00:32:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so7945385pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 21:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shZUqSG3iEomF4hE/YitMZi/piFpwFyo/m4MHkOwnu4=;
        b=hMs8qnILHz1DNpxxEnf8N/I9YqUSlRrqQTBGkbA6/H9TkEj+hjS+XVPTNLN00GU+NW
         ljb7Q8LZ4iREhGkoyumcQ/uQ3oxsM5CDlzskmvSnYaeshkjveKHN0W0xsL8nEB420HX/
         Z0VPBz72gC3fCd7xvBkoQf1gPFN7g7ZHvXTLOIbNmwj+Lo+fyCLuzqAE01vjEOp3ar/b
         tXFMX5ZrZFM3rneBRq3NIBcS+r69WSoN7tLwoaZtzGTdi3ZIwQIJas1lXLhQkD5vgD97
         tUchuJyUtzQbRuPKgUC2R4SmQtIwPLRYJ82XVreyeMfMzLykBeGMSqjVHYS4it9TlX8C
         NBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shZUqSG3iEomF4hE/YitMZi/piFpwFyo/m4MHkOwnu4=;
        b=OhJFCh3v/iHInRNnwaY03oFRTkY49Y3PoON3z4y1N41w43Q9cB7d4HObCKK4vhsSPg
         IdFG16Xw554+kLfQYGdN6LPuf3jDWGTPjKtASvFLP5/mQLjiuMLkCHuMUrpQX3XTu6Nl
         EUWQAOfaUxpASHSVQI3enmeRVIC4nxIX+yt9oHCLnQZ19V9RusoVngkwMyv6zqUybKWM
         8NgLbP2+zS+nqOpEP9jNVYmlJ8vz0olMhq+4P5gn1yfByr6hfJXejVl4ve8hp4RJ12ff
         KEN0QUISeTEYQIckHjGdvq0W4MuOtO3/FUzprVpODb5Ba70fmeH0tSu4YVNvf9sJTK3v
         kf6Q==
X-Gm-Message-State: APjAAAUkVaxZBYEHDgNM+B5R6xuSIclkgjgeSxP7MOc0yo1te0JGsKlG
        jTv4aMpzVpJ6jh9HS2+kxw==
X-Google-Smtp-Source: APXvYqxpJKU26KSfuOfNs5n+XoTRCU14yHs40PWQFr3QnQYd0eL5C5cAQt6h2iDkbXssld6gWjNQBA==
X-Received: by 2002:a62:be13:: with SMTP id l19mr39316582pff.137.1557203540150;
        Mon, 06 May 2019 21:32:20 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 25sm14108762pfo.145.2019.05.06.21.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 21:32:19 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv5 2/2] x86/boot/KASLR: skip the specified crashkernel region
Date:   Tue,  7 May 2019 12:31:34 +0800
Message-Id: <1557203494-7939-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557203494-7939-1-git-send-email-kernelfans@gmail.com>
References: <1557203494-7939-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crashkernel=x@y or or =range1:size1[,range2:size2,...]@offset option may
fail to reserve the required memory region if KASLR puts kernel into the
region. To avoid this uncertainty, asking KASLR to skip the required
region.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/boot/compressed/kaslr.c | 40 ++++++++++++++++++++++++++++++++++++++++
 lib/parse_crashkernel.c          | 10 ++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 2e53c05..12f72a3 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -107,6 +107,7 @@ enum mem_avoid_index {
 	MEM_AVOID_BOOTPARAMS,
 	MEM_AVOID_MEMMAP_BEGIN,
 	MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
+	MEM_AVOID_CRASHKERNEL,
 	MEM_AVOID_MAX,
 };
 
@@ -131,6 +132,11 @@ char *skip_spaces(const char *str)
 }
 #include "../../../../lib/ctype.c"
 #include "../../../../lib/cmdline.c"
+#ifdef CONFIG_CRASH_CORE
+#define printk
+#define _BOOT_KASLR
+#include "../../../../lib/parse_crashkernel.c"
+#endif
 
 static int
 parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
@@ -292,6 +298,39 @@ static void handle_mem_options(void)
 	return;
 }
 
+static u64 mem_ram_size(void)
+{
+	struct boot_e820_entry *entry;
+	u64 total_sz = 0;
+	int i;
+
+	for (i = 0; i < boot_params->e820_entries; i++) {
+		entry = &boot_params->e820_table[i];
+		/* Skip non-RAM entries. */
+		if (entry->type != E820_TYPE_RAM)
+			continue;
+		total_sz += entry->size;
+	}
+	return total_sz;
+}
+
+/*
+ * For crashkernel=size@offset or =range1:size1[,range2:size2,...]@offset
+ * options, recording mem_avoid for them.
+ */
+static void handle_crashkernel_options(void)
+{
+	unsigned long long crash_size, crash_base;
+	char *cmdline = (char *)get_cmd_line_ptr();
+	u64 total_sz = mem_ram_size();
+
+	parse_crashkernel(cmdline, total_sz, &crash_size, &crash_base);
+	if (crash_base) {
+		mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
+		mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
+	}
+}
+
 /*
  * In theory, KASLR can put the kernel anywhere in the range of [16M, 64T).
  * The mem_avoid array is used to store the ranges that need to be avoided
@@ -414,6 +453,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 
 	/* Mark the memmap regions we need to avoid */
 	handle_mem_options();
+	handle_crashkernel_options();
 
 	/* Enumerate the immovable memory regions */
 	num_immovable_mem = count_immovable_mem_regions();
diff --git a/lib/parse_crashkernel.c b/lib/parse_crashkernel.c
index b9a8dc6..4644379 100644
--- a/lib/parse_crashkernel.c
+++ b/lib/parse_crashkernel.c
@@ -137,6 +137,7 @@ static __initdata char *suffix_tbl[] = {
 	[SUFFIX_NULL] = NULL,
 };
 
+#ifndef _BOOT_KASLR
 /*
  * That function parses "suffix"  crashkernel command lines like
  *
@@ -169,6 +170,7 @@ static int __init parse_crashkernel_suffix(char *cmdline,
 
 	return 0;
 }
+#endif
 
 static __init char *get_last_crashkernel(char *cmdline,
 			     const char *name,
@@ -232,9 +234,11 @@ static int __init __parse_crashkernel(char *cmdline,
 
 	ck_cmdline += strlen(name);
 
+#ifndef _BOOT_KASLR
 	if (suffix)
 		return parse_crashkernel_suffix(ck_cmdline, crash_size,
 				suffix);
+#endif
 	/*
 	 * if the commandline contains a ':', then that's the extended
 	 * syntax -- if not, it must be the classic syntax
@@ -261,6 +265,11 @@ int __init parse_crashkernel(char *cmdline,
 					"crashkernel=", NULL);
 }
 
+/*
+ * At boot stage, KASLR does not care about crashkernel=size,[high|low], which
+ * never specifies the offset of region.
+ */
+#ifndef _BOOT_KASLR
 int __init parse_crashkernel_high(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
@@ -278,3 +287,4 @@ int __init parse_crashkernel_low(char *cmdline,
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
+#endif
-- 
2.7.4

