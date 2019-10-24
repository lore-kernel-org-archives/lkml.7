Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5B5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6087D2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f0ryRBHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393465AbfJXNCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:02:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34281 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbfJXNCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:02:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id k7so11857116pll.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zxcQQpLGST8DneMyruDForj/PfYh/236qxDtuBFhRzA=;
        b=f0ryRBHjO5mpGpUEVFM2cf61xo+xUMkRlSTIfFn5U2+dIXwh+JU5Yxyh21rQbNzTtd
         cXuoSr5N8RW8RdP0RQmPBSDlOUNcYQA8+4objIi/g7Ub4cHFvYESPAm8LFR1HbOjPR5G
         sHpmWZXLSfD+KL0+O75vpjziulRqSDQBLGjSBgOZrkfSAVflNyc81WtqDYCWygJ1zUgG
         pFdp3rgfNihCM+xjyF1jgHxYmeHLBXF6smTtopDBPwseLgwSWR+YmW0POqQ1tR8x0xNz
         8Ym/SE1cX1h9As9/5Ab4pKdWYSXD3w5UjLFVqWpe/zP3/cLKOMySInNjQhU9cAF9paRo
         k+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zxcQQpLGST8DneMyruDForj/PfYh/236qxDtuBFhRzA=;
        b=e4vzYjWruZWkhT1MRNSE9iLFsugQLKqd6oDt13U18p3+P816xp5k/C7v4QG203ebUA
         CBrFdBH8nWV6u8jg+3IkotnGpEUt+NFajopDaXCCj2IKKXN/aNI/fFM+eZfKtOeXPINR
         cedxw8uS4QMkWW0VeA4dIYpagA7ehRhrqFQ/eV2DFql59FTEG3QzEC1U0eudp6tBe04O
         Wac6ocB8LZsWSqDAdDkN6c+TmQLXhIynTTaUSkjC286MFeOrO0Pg2fgxAWqc3rBvrdNk
         3ROVwVY0pH5sRFJUtiklKjPppYEdOJIl9t7aq/NwVxYM5y0md1xd/1aENqxFw6phxpd4
         3KGA==
X-Gm-Message-State: APjAAAUUs9e8gcsyXG1JDQSYZ8Oq/ElCUTGHRr36xFuWgCbAUNVhKRvc
        cFIHOF8Gp8JwD6WKwuhjTSBAigaIsyLoow==
X-Google-Smtp-Source: APXvYqyRGF5pkLAAG8f1EnPKEOqssLvHuMdR5MW8vDsoIyRxRpl86FB1Wo2NAKA0Ml0MLtfi75PWZQ==
X-Received: by 2002:a17:902:8507:: with SMTP id bj7mr14972505plb.73.1571922163662;
        Thu, 24 Oct 2019 06:02:43 -0700 (PDT)
Received: from gamma07.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id z4sm2308775pjt.17.2019.10.24.06.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Oct 2019 06:02:42 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@sifive.com, steven.price@arm.com
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/1] riscv: Add support to dump the kernel page tables
Date:   Thu, 24 Oct 2019 06:02:18 -0700
Message-Id: <87a7b40428c94b57b9037108715bca60d72c1b94.1571920862.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1571920862.git.zong.li@sifive.com>
References: <cover.1571920862.git.zong.li@sifive.com>
In-Reply-To: <cover.1571920862.git.zong.li@sifive.com>
References: <cover.1571920862.git.zong.li@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a similar manner to arm64, x86, powerpc, etc., it can traverse all
page tables, and dump the page table layout with the memory types and
permissions.

Add a debugfs file at /sys/kernel/debug/kernel_page_tables to export
the page table layout to userspace.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig               |   1 +
 arch/riscv/include/asm/pgtable.h |  10 ++
 arch/riscv/include/asm/ptdump.h  |  19 +++
 arch/riscv/mm/Makefile           |   1 +
 arch/riscv/mm/ptdump.c           | 309 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 340 insertions(+)
 create mode 100644 arch/riscv/include/asm/ptdump.h
 create mode 100644 arch/riscv/mm/ptdump.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bc7598f..053cb7a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -25,6 +25,7 @@ config RISCV
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
+	select GENERIC_PTDUMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index df6522d..be93e59 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -444,6 +444,16 @@ extern void setup_bootmem(void);
 extern void paging_init(void);
 
 /*
+ * In the RV64 Linux scheme, we give the user half of the virtual-address space
+ * and give the kernel the other (upper) half.
+ */
+#ifdef CONFIG_64BIT
+#define KERN_VIRT_START	(-(BIT(CONFIG_VA_BITS)) + TASK_SIZE)
+#else
+#define KERN_VIRT_START	FIXADDR_START
+#endif
+
+/*
  * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  */
diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
new file mode 100644
index 0000000..26d9221
--- /dev/null
+++ b/arch/riscv/include/asm/ptdump.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 SiFive
+ */
+
+#ifndef _ASM_RISCV_PTDUMP_H
+#define _ASM_RISCV_PTDUMP_H
+
+#ifdef CONFIG_PTDUMP_CORE
+void ptdump_check_wx(void);
+#endif /* CONFIG_PTDUMP_CORE */
+
+#ifdef CONFIG_DEBUG_WX
+#define debug_checkwx() ptdump_check_wx()
+#else
+#define debug_checkwx() do { } while (0)
+#endif
+
+#endif /* _ASM_RISCV_PTDUMP_H */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 9d9a173..d6132f8 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -17,3 +17,4 @@ ifeq ($(CONFIG_MMU),y)
 obj-$(CONFIG_SMP) += tlbflush.o
 endif
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
new file mode 100644
index 0000000..60c8af1
--- /dev/null
+++ b/arch/riscv/mm/ptdump.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 SiFive
+ */
+
+#include <linux/init.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/ptdump.h>
+
+#include <asm/ptdump.h>
+#include <asm/pgtable.h>
+
+#define pt_dump_seq_printf(m, fmt, args...)	\
+({						\
+	if (m)					\
+		seq_printf(m, fmt, ##args);	\
+})
+
+#define pt_dump_seq_puts(m, fmt)	\
+({					\
+	if (m)				\
+		seq_printf(m, fmt);	\
+})
+
+/*
+ * The page dumper groups page table entries of the same type into a single
+ * description. It uses pg_state to track the range information while
+ * iterating over the pte entries. When the continuity is broken it then
+ * dumps out a description of the range.
+ */
+struct pg_state {
+	struct ptdump_state ptdump;
+	struct seq_file *seq;
+	const struct addr_marker *marker;
+	unsigned long start_address;
+	unsigned long start_pa;
+	unsigned long last_pa;
+	int level;
+	u64 current_prot;
+	bool check_wx;
+	unsigned long wx_pages;
+};
+
+/* Address marker */
+struct addr_marker {
+	unsigned long start_address;
+	const char *name;
+};
+
+static struct addr_marker address_markers[] = {
+	{FIXADDR_START,		"Fixmap start"},
+	{FIXADDR_TOP,		"Fixmap end"},
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	{VMEMMAP_START,		"vmemmap start"},
+	{VMEMMAP_END,		"vmemmap end"},
+#endif
+	{VMALLOC_START,		"vmalloc() area"},
+	{VMALLOC_END,		"vmalloc() end"},
+	{PAGE_OFFSET,		"Linear mapping"},
+	{-1, NULL},
+};
+
+/* Page Table Entry */
+struct prot_bits {
+	u64 mask;
+	u64 val;
+	const char *set;
+	const char *clear;
+};
+
+static const struct prot_bits pte_bits[] = {
+	{
+		.mask = _PAGE_SOFT,
+		.val = _PAGE_SOFT,
+		.set = "RSW",
+		.clear = "   ",
+	 }, {
+		.mask = _PAGE_DIRTY,
+		.val = _PAGE_DIRTY,
+		.set = "D",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_ACCESSED,
+		.val = _PAGE_ACCESSED,
+		.set = "A",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_GLOBAL,
+		.val = _PAGE_GLOBAL,
+		.set = "G",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_USER,
+		.val = _PAGE_USER,
+		.set = "U",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_EXEC,
+		.val = _PAGE_EXEC,
+		.set = "X",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_WRITE,
+		.val = _PAGE_WRITE,
+		.set = "W",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_READ,
+		.val = _PAGE_READ,
+		.set = "R",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_PRESENT,
+		.val = _PAGE_PRESENT,
+		.set = "V",
+		.clear = ".",
+	}
+};
+
+/* Page Level */
+struct pg_level {
+	const char *name;
+	u64 mask;
+};
+
+static struct pg_level pg_level[] = {
+	{
+	}, { /* pgd */
+		.name = "PGD",
+	}, { /* p4d */
+		.name = (CONFIG_PGTABLE_LEVELS > 4) ? "P4D" : "PGD",
+	}, { /* pud */
+		.name = (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
+	}, { /* pmd */
+		.name = (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
+	}, { /* pte */
+		.name = "PTE",
+	},
+};
+
+static void dump_prot(struct pg_state *st)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pte_bits); i++) {
+		const char *s;
+
+		if ((st->current_prot & pte_bits[i].mask) == pte_bits[i].val)
+			s = pte_bits[i].set;
+		else
+			s = pte_bits[i].clear;
+
+		if (s)
+			pt_dump_seq_printf(st->seq, " %s", s);
+	}
+}
+
+#ifdef CONFIG_64BIT
+#define ADDR_FORMAT	"0x%016lx"
+#else
+#define ADDR_FORMAT	"0x%08lx"
+#endif
+static void dump_addr(struct pg_state *st, unsigned long addr)
+{
+	static const char units[] = "KMGTPE";
+	const char *unit = units;
+	unsigned long delta;
+
+	pt_dump_seq_printf(st->seq, ADDR_FORMAT "-" ADDR_FORMAT "   ",
+			   st->start_address, addr);
+
+	pt_dump_seq_printf(st->seq, " " ADDR_FORMAT " ", st->start_pa);
+	delta = (addr - st->start_address) >> 10;
+
+	while (!(delta & 1023) && unit[1]) {
+		delta >>= 10;
+		unit++;
+	}
+
+	pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
+			   pg_level[st->level].name);
+}
+
+static void note_prot_wx(struct pg_state *st, unsigned long addr)
+{
+	if (!st->check_wx)
+		return;
+
+	if ((st->current_prot & (_PAGE_WRITE | _PAGE_EXEC)) !=
+	    (_PAGE_WRITE | _PAGE_EXEC))
+		return;
+
+	WARN_ONCE(1, "riscv/mm: Found insecure W+X mapping at address %p/%pS\n",
+		  (void *)st->start_address, (void *)st->start_address);
+
+	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
+}
+
+static void note_page(struct ptdump_state *pt_st, unsigned long addr,
+		      int level, unsigned long val)
+{
+	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	u64 pa = PFN_PHYS(pte_pfn(__pte(val)));
+	u64 prot = 0;
+
+	if (level >= 0)
+		prot = val & pg_level[level].mask;
+
+	if (!st->level) {
+		st->level = level;
+		st->current_prot = prot;
+		st->start_address = addr;
+		st->start_pa = pa;
+		st->last_pa = pa;
+		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+	} else if (prot != st->current_prot ||
+		   level != st->level || addr >= st->marker[1].start_address) {
+		if (st->current_prot) {
+			note_prot_wx(st, addr);
+			dump_addr(st, addr);
+			dump_prot(st);
+			pt_dump_seq_puts(st->seq, "\n");
+		}
+
+		while (addr >= st->marker[1].start_address) {
+			st->marker++;
+			pt_dump_seq_printf(st->seq, "---[ %s ]---\n",
+					   st->marker->name);
+		}
+
+		st->start_address = addr;
+		st->start_pa = pa;
+		st->last_pa = pa;
+		st->current_prot = prot;
+		st->level = level;
+	} else {
+		st->last_pa = pa;
+	}
+}
+
+static void ptdump_walk(struct seq_file *s)
+{
+	struct pg_state st = {
+		.seq = s,
+		.marker = address_markers,
+		.ptdump = {
+			.note_page = note_page,
+			.range = (struct ptdump_range[]) {
+				{KERN_VIRT_START, ULONG_MAX},
+				{0, 0}
+			}
+		}
+	};
+
+	ptdump_walk_pgd(&st.ptdump, &init_mm);
+}
+
+void ptdump_check_wx(void)
+{
+	struct pg_state st = {
+		.seq = NULL,
+		.marker = (struct addr_marker[]) {
+			{0, NULL},
+			{-1, NULL},
+		},
+		.check_wx = true,
+		.ptdump = {
+			.note_page = note_page,
+			.range = (struct ptdump_range[]) {
+				{KERN_VIRT_START, ULONG_MAX},
+				{0, 0}
+			}
+		}
+	};
+
+	ptdump_walk_pgd(&st.ptdump, &init_mm);
+
+	if (st.wx_pages)
+		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found\n",
+			st.wx_pages);
+	else
+		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
+}
+
+static int ptdump_show(struct seq_file *m, void *v)
+{
+	ptdump_walk(m);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(ptdump);
+
+static int ptdump_init(void)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
+		for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
+			pg_level[i].mask |= pte_bits[j].mask;
+
+	debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
+			    &ptdump_fops);
+
+	return 0;
+}
+
+device_initcall(ptdump_init);
-- 
2.7.4

