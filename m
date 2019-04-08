Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6D0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B36F20855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teaR0miW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDHF71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:59:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41744 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDHF70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:59:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id d1so6662253plj.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bw0EVeJpNkrMz2L4c8qp9A6NLRnHK7POrJ8aoCce0Mw=;
        b=teaR0miWSKG5l/ISsU9f506yTCEg/gzKrVe2SC402+yAvedUcz+vsGyUPGdYa3q9eG
         EVbb8bQ/AGvahW6VJRXcppKZ16cqb9IvHcMc8tlAAOvKkiyO7KqmPqrbd4rwMDMHYpWR
         8WQpuOeAJzHuSFwWcNTle5qkhwzS5b3p/SSsHPxPhgd1cKp8g5QaHKE7tn7hPKeXNLFq
         YKMd99M/Au+QNsf0Gf8HAWtZHAqNGLTJGoA5o+/1N5XNkD9O8Va/tiJPlbeJuDpydt5l
         FAFtIkFcgIMUwmquosC0Q9LpZRLL8TKYehhwH/ucIFLkgMcUyP62dO+KQiPszMjaFwq9
         Ciyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bw0EVeJpNkrMz2L4c8qp9A6NLRnHK7POrJ8aoCce0Mw=;
        b=FCR6avu7RIw6tqDEIsJ4qhO7EmtKQHQCBszTVNpd2UmkUeOPXluhmvtX9rSq9Mh8WT
         kBlZgd/pVbzGlKpObqSajOxZZKxG29eGWn3RvMYVG2HziV4LHTZUXlAYtAGjUOjVc5+N
         fanqbBOfgFjSfQ//ElPY2YW7c9TAnXkeeMEToz5inbQds2v81EIsLq31S05ebm6KUty7
         vuh3fbrvV3UcFbTRsnXpCLC/5NvtRg0RQrEk4Na4jSJhSnrDYPBRrKciWgS5ruJ9W5WH
         25Ps/BGaCuhUX08Z/Q+/qoUlA0IKqkdOyHvtd6EDF2gr6/lzJBx4ezkUmDJQbEVfHH1A
         i8dQ==
X-Gm-Message-State: APjAAAXNLFWrVAUdWfkKhKoFCOmMzU8FATLuI++u0VPXAmdjfReGBZPb
        dTfZAlwXxcmoX0V5fTYwYw==
X-Google-Smtp-Source: APXvYqwu7Rm/AYQZ2R8BDzUMR14vFOpJmJfSQENwULqfibGaUX5CEaJtcapb4UwIRhf2COFBbHhWKw==
X-Received: by 2002:a17:902:2aa6:: with SMTP id j35mr28624205plb.56.1554703166102;
        Sun, 07 Apr 2019 22:59:26 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e1sm34389658pfn.187.2019.04.07.22.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 22:59:25 -0700 (PDT)
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
Subject: [PATCH v4 2/2] x86/boot/KASLR: skip the specified crashkernel region
Date:   Mon,  8 Apr 2019 13:58:35 +0800
Message-Id: <1554703115-15299-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
References: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
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
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 2e53c05..765a593 100644
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
+	unsigned long long crash_size, crash_base = 0;
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
-- 
2.7.4

