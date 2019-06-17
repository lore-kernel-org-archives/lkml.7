Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99590C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5BF20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM9V28lH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfFQWL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:11:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45192 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbfFQWLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:11:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so6389364pfq.12;
        Mon, 17 Jun 2019 15:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p6XDrWIXPxwiC0WkVplyBA2eip53/d0wLoTT+kG56h8=;
        b=lM9V28lHz+IBkY5VdI0s8iO+vLMAs40MpqbH7p8o1V0kN4h5BVAps6MhzWd47/5wqS
         5a12SMTuwq6I9MuodRL4pZkKfq7Kv4WDPsN63pkUZJAtLWVL3fdWGGc0tS9cpupi6eGU
         fNtSYFIYvpYDVEd7NfZh03N9Nxq2UR/jwFxWL4YubGBUny9kkKwYxVJ/i9XJhPiq+5Yy
         xoO58VJx7oQax+iuOVcR/gGOszW6LoPHu/claYKKs+tZyLfyXrIONhj9JDOjHUang8Zm
         a4L39eESo/iOuqAxSGpNucGJSSfP6xYK1JPFc+7t9oYNpOqCsyfsJFGQ4Fs1a0+CgPl/
         uPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p6XDrWIXPxwiC0WkVplyBA2eip53/d0wLoTT+kG56h8=;
        b=HSiuW+QB95vvKWlDs+oeSIV4srfyt5tOU6tFznVW6C/eHDNV4Ss6RIMCSrrsAEREjd
         SbbHrh993Mo1vrm1BxG3kK123PDwxQzDCqaSh48C0pu0+4brzIcdIppb3OSXkDQHzB/3
         tw/JEbDncexMCU40A3lDSDXlve4Q2kQdmW2scpf482YDfSF/m6G5monJZx/z2W+c7fBZ
         TcZhAkYeLN4Wl5vdhAfifP4pOlR9FdWjEHN96MpfbEtVAN4oCEKEywrlQWLWz6gW1RzE
         eMyYkYubY47dPM33taG+6ptn3+ILKgCRfTd1mW5d1aEqz4XzOoSR4VfhR/nskeFDtUOq
         h86A==
X-Gm-Message-State: APjAAAUQbQGJEI1B8+gI/hWPL0PohvD/TvsvLBA9wMNYrA5Qcyp3/9T7
        kLhXrvUHkWtV0NcMOjamMWg=
X-Google-Smtp-Source: APXvYqyxYiqJ9jSGW3jhLESovzpKr5QifimBTtn4hfhm7oQhnRbpIKEXlU7NCDDsQg7EH82JV4+iqw==
X-Received: by 2002:a62:764d:: with SMTP id r74mr95168317pfc.110.1560809513044;
        Mon, 17 Jun 2019 15:11:53 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s129sm12551020pfb.186.2019.06.17.15.11.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:11:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>, glider@google.com,
        dvyukov@google.com, corbet@lwn.net, linux@armlinux.org.uk,
        christoffer.dall@arm.com, marc.zyngier@arm.com, arnd@arndb.de,
        nico@fluxnic.net, vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, alexandre.belloni@bootlin.com,
        ard.biesheuvel@linaro.org, daniel.lezcano@linaro.org,
        pombredanne@nexb.com, rob@landley.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, yamada.masahiro@socionext.com,
        tglx@linutronix.de, thgarnie@google.com, dhowells@redhat.com,
        geert@linux-m68k.org, andre.przywara@arm.com,
        julien.thierry@arm.com, drjones@redhat.com, philip@cog.systems,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        ryabinin.a.a@gmail.com
Subject: [PATCH v6 5/6] ARM: Initialize the mapping of KASan shadow memory
Date:   Mon, 17 Jun 2019 15:11:33 -0700
Message-Id: <20190617221134.9930-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617221134.9930-1-f.fainelli@gmail.com>
References: <20190617221134.9930-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

This patch initializes KASan shadow region's page table and memory.
There are two stage for KASan initializing:
1. At early boot stage the whole shadow region is mapped to just
   one physical page (kasan_zero_page). It's finished by the function
   kasan_early_init which is called by __mmap_switched(arch/arm/kernel/
   head-common.S)
             ---Andrey Ryabinin <aryabinin@virtuozzo.com>

2. After the calling of paging_init, we use kasan_zero_page as zero
   shadow for some memory that KASan don't need to track, and we alloc
   new shadow space for the other memory that KASan need to track. These
   issues are finished by the function kasan_init which is call by
   setup_arch.
            ---Andrey Ryabinin <aryabinin@virtuozzo.com>

3. Add support arm LPAE
   If LPAE is enabled, KASan shadow region's mapping table need be copyed
   in pgd_alloc function.
            ---Abbott Liu <liuwenliang@huawei.com>

4. Change kasan_pte_populate,kasan_pmd_populate,kasan_pud_populate,
   kasan_pgd_populate from .meminit.text section to .init.text section.
           ---Reported by: Florian Fainelli <f.fainelli@gmail.com>
           ---Signed off by: Abbott Liu <liuwenliang@huawei.com>

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Co-Developed-by: Abbott Liu <liuwenliang@huawei.com>
Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/kasan.h       |  35 ++++
 arch/arm/include/asm/pgalloc.h     |   7 +-
 arch/arm/include/asm/thread_info.h |   4 +
 arch/arm/kernel/head-common.S      |   3 +
 arch/arm/kernel/setup.c            |   2 +
 arch/arm/mm/Makefile               |   3 +
 arch/arm/mm/kasan_init.c           | 301 +++++++++++++++++++++++++++++
 arch/arm/mm/pgd.c                  |  14 ++
 8 files changed, 367 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/kasan.h
 create mode 100644 arch/arm/mm/kasan_init.c

diff --git a/arch/arm/include/asm/kasan.h b/arch/arm/include/asm/kasan.h
new file mode 100644
index 000000000000..1801f4d30993
--- /dev/null
+++ b/arch/arm/include/asm/kasan.h
@@ -0,0 +1,35 @@
+/*
+ * arch/arm/include/asm/kasan.h
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd.
+ * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_KASAN_H
+#define __ASM_KASAN_H
+
+#ifdef CONFIG_KASAN
+
+#include <asm/kasan_def.h>
+
+#define KASAN_SHADOW_SCALE_SHIFT 3
+
+/*
+ * Compiler uses shadow offset assuming that addresses start
+ * from 0. Kernel addresses don't start from 0, so shadow
+ * for kernel really starts from 'compiler's shadow offset' +
+ * ('kernel address space start' >> KASAN_SHADOW_SCALE_SHIFT)
+ */
+
+extern void kasan_init(void);
+
+#else
+static inline void kasan_init(void) { }
+#endif
+
+#endif
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 17ab72f0cc4e..6cf45c249136 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -50,8 +50,11 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
  */
 #define pmd_alloc_one(mm,addr)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(mm, pmd)		do { } while (0)
-#define pud_populate(mm,pmd,pte)	BUG()
-
+#ifndef CONFIG_KASAN
+#define pud_populate(mm, pmd, pte)	BUG()
+#else
+#define pud_populate(mm, pmd, pte)	do { } while (0)
+#endif
 #endif	/* CONFIG_ARM_LPAE */
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 286eb61c632b..fae2fa993e86 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -16,7 +16,11 @@
 #include <asm/fpstate.h>
 #include <asm/page.h>
 
+#ifdef CONFIG_KASAN
+#define THREAD_SIZE_ORDER	2
+#else
 #define THREAD_SIZE_ORDER	1
+#endif
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 #define THREAD_START_SP		(THREAD_SIZE - 8)
 
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 6e3b9179806b..5db2a094a44c 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -115,6 +115,9 @@ __mmap_switched:
 	str	r8, [r2]			@ Save atags pointer
 	cmp	r3, #0
 	strne	r10, [r3]			@ Save control register values
+#ifdef CONFIG_KASAN
+	bl	kasan_early_init
+#endif
 	mov	lr, #0
 	b	start_kernel
 ENDPROC(__mmap_switched)
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 5d78b6ac0429..71c27f3c3ed4 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -61,6 +61,7 @@
 #include <asm/unwind.h>
 #include <asm/memblock.h>
 #include <asm/virt.h>
+#include <asm/kasan.h>
 
 #include "atags.h"
 
@@ -1133,6 +1134,7 @@ void __init setup_arch(char **cmdline_p)
 	early_ioremap_reset();
 
 	paging_init(mdesc);
+	kasan_init();
 	request_standard_resources(mdesc);
 
 	if (mdesc->restart)
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 432302911d6e..1c937135c9c4 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -112,3 +112,6 @@ obj-$(CONFIG_CACHE_L2X0_PMU)	+= cache-l2x0-pmu.o
 obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
 obj-$(CONFIG_CACHE_TAUROS2)	+= cache-tauros2.o
 obj-$(CONFIG_CACHE_UNIPHIER)	+= cache-uniphier.o
+
+KASAN_SANITIZE_kasan_init.o    := n
+obj-$(CONFIG_KASAN)            += kasan_init.o
diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
new file mode 100644
index 000000000000..a7122b28fffa
--- /dev/null
+++ b/arch/arm/mm/kasan_init.c
@@ -0,0 +1,301 @@
+/*
+ * This file contains kasan initialization code for ARM.
+ *
+ * Copyright (c) 2018 Samsung Electronics Co., Ltd.
+ * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kasan.h>
+#include <linux/kernel.h>
+#include <linux/memblock.h>
+#include <linux/start_kernel.h>
+#include <asm/cputype.h>
+#include <asm/highmem.h>
+#include <asm/mach/map.h>
+#include <asm/memory.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/procinfo.h>
+#include <asm/proc-fns.h>
+#include <asm/tlbflush.h>
+#include <asm/cp15.h>
+#include <linux/sched/task.h>
+
+#include "mm.h"
+
+static pgd_t tmp_pgd_table[PTRS_PER_PGD] __initdata __aligned(1ULL << 14);
+
+pmd_t tmp_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
+
+static __init void *kasan_alloc_block(size_t size, int node)
+{
+	return memblock_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
+				      MEMBLOCK_ALLOC_KASAN, node);
+}
+
+static void __init kasan_early_pmd_populate(unsigned long start,
+					unsigned long end, pud_t *pud)
+{
+	unsigned long addr;
+	unsigned long next;
+	pmd_t *pmd;
+
+	pmd = pmd_offset(pud, start);
+	for (addr = start; addr < end;) {
+		pmd_populate_kernel(&init_mm, pmd, kasan_early_shadow_pte);
+		next = pmd_addr_end(addr, end);
+		addr = next;
+		flush_pmd_entry(pmd);
+		pmd++;
+	}
+}
+
+static void __init kasan_early_pud_populate(unsigned long start,
+				unsigned long end, pgd_t *pgd)
+{
+	unsigned long addr;
+	unsigned long next;
+	pud_t *pud;
+
+	pud = pud_offset(pgd, start);
+	for (addr = start; addr < end;) {
+		next = pud_addr_end(addr, end);
+		kasan_early_pmd_populate(addr, next, pud);
+		addr = next;
+		pud++;
+	}
+}
+
+void __init kasan_map_early_shadow(pgd_t *pgdp)
+{
+	int i;
+	unsigned long start = KASAN_SHADOW_START;
+	unsigned long end = KASAN_SHADOW_END;
+	unsigned long addr;
+	unsigned long next;
+	pgd_t *pgd;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		set_pte_at(&init_mm, KASAN_SHADOW_START + i*PAGE_SIZE,
+			&kasan_early_shadow_pte[i], pfn_pte(
+				virt_to_pfn(kasan_early_shadow_page),
+				__pgprot(_L_PTE_DEFAULT | L_PTE_DIRTY
+					| L_PTE_XN)));
+
+	pgd = pgd_offset_k(start);
+	for (addr = start; addr < end;) {
+		next = pgd_addr_end(addr, end);
+		kasan_early_pud_populate(addr, next, pgd);
+		addr = next;
+		pgd++;
+	}
+}
+
+extern struct proc_info_list *lookup_processor_type(unsigned int);
+
+void __init kasan_early_init(void)
+{
+	struct proc_info_list *list;
+
+	/*
+	 * locate processor in the list of supported processor
+	 * types.  The linker builds this table for us from the
+	 * entries in arch/arm/mm/proc-*.S
+	 */
+	list = lookup_processor_type(read_cpuid_id());
+	if (list) {
+#ifdef MULTI_CPU
+		processor = *list->proc;
+#endif
+	}
+
+	BUILD_BUG_ON((KASAN_SHADOW_END - (1UL << 29)) != KASAN_SHADOW_OFFSET);
+	kasan_map_early_shadow(swapper_pg_dir);
+}
+
+static void __init clear_pgds(unsigned long start,
+			unsigned long end)
+{
+	for (; start && start < end; start += PMD_SIZE)
+		pmd_clear(pmd_off_k(start));
+}
+
+pte_t * __init kasan_pte_populate(pmd_t *pmd, unsigned long addr, int node)
+{
+	pte_t *pte = pte_offset_kernel(pmd, addr);
+
+	if (pte_none(*pte)) {
+		pte_t entry;
+		void *p = kasan_alloc_block(PAGE_SIZE, node);
+
+		if (!p)
+			return NULL;
+		entry = pfn_pte(virt_to_pfn(p),
+			__pgprot(pgprot_val(PAGE_KERNEL)));
+		set_pte_at(&init_mm, addr, pte, entry);
+	}
+	return pte;
+}
+
+pmd_t * __init kasan_pmd_populate(pud_t *pud, unsigned long addr, int node)
+{
+	pmd_t *pmd = pmd_offset(pud, addr);
+
+	if (pmd_none(*pmd)) {
+		void *p = kasan_alloc_block(PAGE_SIZE, node);
+
+		if (!p)
+			return NULL;
+		pmd_populate_kernel(&init_mm, pmd, p);
+	}
+	return pmd;
+}
+
+pud_t * __init kasan_pud_populate(pgd_t *pgd, unsigned long addr, int node)
+{
+	pud_t *pud = pud_offset(pgd, addr);
+
+	if (pud_none(*pud)) {
+		void *p = kasan_alloc_block(PAGE_SIZE, node);
+
+		if (!p)
+			return NULL;
+		pr_err("populating pud addr %lx\n", addr);
+		pud_populate(&init_mm, pud, p);
+	}
+	return pud;
+}
+
+pgd_t * __init kasan_pgd_populate(unsigned long addr, int node)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+
+	if (pgd_none(*pgd)) {
+		void *p = kasan_alloc_block(PAGE_SIZE, node);
+
+		if (!p)
+			return NULL;
+		pgd_populate(&init_mm, pgd, p);
+	}
+	return pgd;
+}
+
+static int __init create_mapping(unsigned long start, unsigned long end,
+				int node)
+{
+	unsigned long addr = start;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pr_info("populating shadow for %lx, %lx\n", start, end);
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		pgd = kasan_pgd_populate(addr, node);
+		if (!pgd)
+			return -ENOMEM;
+
+		pud = kasan_pud_populate(pgd, addr, node);
+		if (!pud)
+			return -ENOMEM;
+
+		pmd = kasan_pmd_populate(pud, addr, node);
+		if (!pmd)
+			return -ENOMEM;
+
+		pte = kasan_pte_populate(pmd, addr, node);
+		if (!pte)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+
+void __init kasan_init(void)
+{
+	struct memblock_region *reg;
+	u64 orig_ttbr0;
+	int i;
+
+	/*
+	 * We are going to perform proper setup of shadow memory.
+	 * At first we should unmap early shadow (clear_pgds() call bellow).
+	 * However, instrumented code couldn't execute without shadow memory.
+	 * tmp_pgd_table and tmp_pmd_table used to keep early shadow mapped
+	 * until full shadow setup will be finished.
+	 */
+	orig_ttbr0 = get_ttbr0();
+
+#ifdef CONFIG_ARM_LPAE
+	memcpy(tmp_pmd_table,
+		pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_START)),
+		sizeof(tmp_pmd_table));
+	memcpy(tmp_pgd_table, swapper_pg_dir, sizeof(tmp_pgd_table));
+	set_pgd(&tmp_pgd_table[pgd_index(KASAN_SHADOW_START)],
+		__pgd(__pa(tmp_pmd_table) | PMD_TYPE_TABLE | L_PGD_SWAPPER));
+	set_ttbr0(__pa(tmp_pgd_table));
+#else
+	memcpy(tmp_pgd_table, swapper_pg_dir, sizeof(tmp_pgd_table));
+	set_ttbr0((u64)__pa(tmp_pgd_table));
+#endif
+	flush_cache_all();
+	local_flush_bp_all();
+	local_flush_tlb_all();
+
+	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
+
+	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
+				    kasan_mem_to_shadow((void *)-1UL) + 1);
+
+	for_each_memblock(memory, reg) {
+		void *start = __va(reg->base);
+		void *end = __va(reg->base + reg->size);
+
+		if (reg->base + reg->size > arm_lowmem_limit)
+			end = __va(arm_lowmem_limit);
+		if (start >= end)
+			break;
+
+		create_mapping((unsigned long)kasan_mem_to_shadow(start),
+			(unsigned long)kasan_mem_to_shadow(end),
+			NUMA_NO_NODE);
+	}
+
+	/*1.the module's global variable is in MODULES_VADDR ~ MODULES_END,
+	 *  so we need mapping.
+	 *2.PKMAP_BASE ~ PKMAP_BASE+PMD_SIZE's shadow and MODULES_VADDR
+	 *  ~ MODULES_END's shadow is in the same PMD_SIZE, so we cant
+	 *  use kasan_populate_zero_shadow.
+	 */
+	create_mapping(
+		(unsigned long)kasan_mem_to_shadow((void *)MODULES_VADDR),
+
+		(unsigned long)kasan_mem_to_shadow((void *)(PKMAP_BASE +
+							PMD_SIZE)),
+		NUMA_NO_NODE);
+
+	/*
+	 * KAsan may reuse the contents of kasan_early_shadow_pte directly, so
+	 * we should make sure that it maps the zero page read-only.
+	 */
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		set_pte_at(&init_mm, KASAN_SHADOW_START + i*PAGE_SIZE,
+			&kasan_early_shadow_pte[i],
+			pfn_pte(virt_to_pfn(kasan_early_shadow_page),
+				__pgprot(pgprot_val(PAGE_KERNEL)
+					| L_PTE_RDONLY)));
+	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
+	set_ttbr0(orig_ttbr0);
+	flush_cache_all();
+	local_flush_bp_all();
+	local_flush_tlb_all();
+	pr_info("Kernel address sanitizer initialized\n");
+	init_task.kasan_depth = 0;
+}
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index a1606d950251..30c70f4ef1b9 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -64,6 +64,20 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	new_pmd = pmd_alloc(mm, new_pud, 0);
 	if (!new_pmd)
 		goto no_pmd;
+#ifdef CONFIG_KASAN
+	/*
+	 *Copy PMD table for KASAN shadow mappings.
+	 */
+	init_pgd = pgd_offset_k(TASK_SIZE);
+	init_pud = pud_offset(init_pgd, TASK_SIZE);
+	init_pmd = pmd_offset(init_pud, TASK_SIZE);
+	new_pmd = pmd_offset(new_pud, TASK_SIZE);
+	memcpy(new_pmd, init_pmd,
+		(pmd_index(MODULES_VADDR)-pmd_index(TASK_SIZE))
+		* sizeof(pmd_t));
+	clean_dcache_area(new_pmd, PTRS_PER_PMD*sizeof(pmd_t));
+#endif
+
 #endif
 
 	if (!vectors_high()) {
-- 
2.17.1

