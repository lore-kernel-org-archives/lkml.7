Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E044C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF0820882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR9ZaXDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDBELK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:11:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39400 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBELK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:11:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so5849352pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cCnqsZVwTriWVEcplTABc4E4LxwRjzZ19PFXxg5eC/o=;
        b=KR9ZaXDpjlxPE+RAibaXeanSrzsBWpT3e2VfYdxlcDU9ayTJL2ZBHNT/SP5WMOiI6P
         5VENeif++Yo99ltE+i3jKg+Mf2M2cJphNkyzIxoTxqI6ayVEiQRiMr8qeSu3jat4qan5
         y1jvZSSKtgvWQkRoHyXaYHcOteZeviuO7SNdkxmer1nw6l1hnaLXfaU4farGzVzZJZy+
         M9NpXifpbdBI7whv/SNUG4Yel349s215S4mfc2jA3duldSHmc75bShzahRuQCgDWYZdS
         vnqzFwFBCUOxF3K9YW1oYIbMRProR3J3mJOCIpkJ8on3dwYX7k1btOfYkHFe9tQ+VoZE
         1fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cCnqsZVwTriWVEcplTABc4E4LxwRjzZ19PFXxg5eC/o=;
        b=OkgjKse2MabLMG/QJzI970khqSr73I/jcXuo4gERyNreOvMpBWo+qANMC1PwN/OjHT
         nhxlg5xNgly9rlro0SqodTFWOncLeZ79pszYiDGbgk1OXdMeZbPIQqp2iQEQnBKxAH/E
         YFadb3isWsNZjHj5EZfScsbSK2wpBBYXAS+UBX3up84EE0djhvanB19Bya4KwgwwnvuY
         qZecGj91ZVDdoYA2vs/jet94Ne9wCH5uh5M9QbLm/33TUPoEg7k5I9Bw6pvSLk/otQ4s
         A9fYanrUPC/CPhV6IJ7t8Gtg2GAcXbl5Bo4OA6kiVQ02sEB3xgNLxTRT0gm7xYuIuBAx
         QJzQ==
X-Gm-Message-State: APjAAAUQiMrf6FpZq9s+PylNDNfuhj/tYGmK+0Kue2Up/YaZurPx0eSD
        R6LmPXwIE8ZEjpyjgpzM6A==
X-Google-Smtp-Source: APXvYqwGrDWJu7a5ZVINdA1sOM3Ox6iSRGLn64WLrz6GO0e9Ao0utKFbaqUIo6dJK2iDZArBBjyHFQ==
X-Received: by 2002:a65:4108:: with SMTP id w8mr64459529pgp.236.1554178269193;
        Mon, 01 Apr 2019 21:11:09 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n1sm13739953pgv.19.2019.04.01.21.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 21:11:08 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3] x86/boot/KASLR: skip the specified crashkernel region
Date:   Tue,  2 Apr 2019 12:10:46 +0800
Message-Id: <1554178246-8162-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org
---
v2 -> v3: adding parsing of crashkernel=range1:size1[,range2:size2,...]@offset

 arch/x86/boot/compressed/kaslr.c | 116 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 2e53c05..7f698f4 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -107,6 +107,7 @@ enum mem_avoid_index {
 	MEM_AVOID_BOOTPARAMS,
 	MEM_AVOID_MEMMAP_BEGIN,
 	MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
+	MEM_AVOID_CRASHKERNEL,
 	MEM_AVOID_MAX,
 };
 
@@ -238,6 +239,115 @@ static void parse_gb_huge_pages(char *param, char *val)
 	}
 }
 
+/* code heavily copied from parse_crashkernel_mem() */
+static void handle_crashkernel_mem(char *cmdline,
+					unsigned long long system_ram,
+					unsigned long long *crash_size,
+					unsigned long long *crash_base)
+{
+	char *tmp, *cur = cmdline;
+
+	/* for each entry of the comma-separated list */
+	do {
+		unsigned long long start, end = ULLONG_MAX, size;
+
+		/* get the start of the range */
+		start = memparse(cur, &tmp);
+		/* no value given */
+		if (cur == tmp)
+			return;
+		cur = tmp;
+		if (*cur != '-')
+			return;
+		cur++;
+
+		/* if no ':' is here, than we read the end */
+		if (*cur != ':') {
+			end = memparse(cur, &tmp);
+			/* no value given */
+			if (cur == tmp)
+				return;
+			cur = tmp;
+			/* invalid if crashkernel end <= start */
+			if (end <= start)
+				return;
+		}
+		/* expect ":" after range */
+		if (*cur != ':')
+			return;
+		cur++;
+
+		size = memparse(cur, &tmp);
+		/* no size value given */
+		if (cur == tmp)
+			return;
+		cur = tmp;
+		if (size >= system_ram)
+			return;
+
+		/* match ? */
+		if (system_ram >= start && system_ram < end) {
+			*crash_size = size;
+			break;
+		}
+	} while (*cur++ == ',');
+
+	if (*crash_size > 0) {
+		while (*cur && *cur != ' ' && *cur != '@')
+			cur++;
+		if (*cur == '@') {
+			cur++;
+			*crash_base = memparse(cur, &tmp);
+		}
+	}
+}
+
+/* handle crashkernel=x@y or =range1:size1[,range2:size2,...]@offset options */
+static void mem_avoid_specified_crashkernel_region(char *option)
+{
+	unsigned long long crash_size, crash_base = 0;
+	char	*first_colon, *first_space, *cur = option;
+
+	first_colon = strchr(option, ':');
+	first_space = strchr(option, ' ');
+	/* if contain ":" */
+	if (first_colon && (!first_space || first_colon < first_space)) {
+		int i;
+		u64 total_sz = 0;
+		struct boot_e820_entry *entry;
+
+		for (i = 0; i < boot_params->e820_entries; i++) {
+			entry = &boot_params->e820_table[i];
+			/* Skip non-RAM entries. */
+			if (entry->type != E820_TYPE_RAM)
+				continue;
+			total_sz += entry->size;
+		}
+		handle_crashkernel_mem(option, total_sz, &crash_size,
+			&crash_base);
+	} else {
+		crash_size = memparse(option, &cur);
+		if (option == cur)
+			return;
+		while (*cur && *cur != ' ' && *cur != '@')
+			cur++;
+		if (*cur == '@') {
+			option = cur + 1;
+			crash_base = memparse(option, &cur);
+		}
+	}
+	if (crash_base) {
+		mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
+		mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
+	} else {
+		/*
+ 		 * Clearing mem_avoid if no offset is given. This is consistent
+ 		 * with kernel, which uses the last crashkernel= option.
+		 */
+		mem_avoid[MEM_AVOID_CRASHKERNEL].start = 0;
+		mem_avoid[MEM_AVOID_CRASHKERNEL].size = 0;
+	}
+}
 
 static void handle_mem_options(void)
 {
@@ -248,7 +358,7 @@ static void handle_mem_options(void)
 	u64 mem_size;
 
 	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
-		!strstr(args, "hugepages"))
+		!strstr(args, "hugepages") && !strstr(args, "crashkernel="))
 		return;
 
 	tmp_cmdline = malloc(len + 1);
@@ -284,6 +394,8 @@ static void handle_mem_options(void)
 				goto out;
 
 			mem_limit = mem_size;
+		} else if (strstr(param, "crashkernel")) {
+			mem_avoid_specified_crashkernel_region(val);
 		}
 	}
 
@@ -412,7 +524,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 
 	/* We don't need to set a mapping for setup_data. */
 
-	/* Mark the memmap regions we need to avoid */
+	/* Mark the regions we need to avoid */
 	handle_mem_options();
 
 	/* Enumerate the immovable memory regions */
-- 
2.7.4

