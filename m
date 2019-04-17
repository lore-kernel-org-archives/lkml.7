Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07EBC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB61206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbfDQOei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:34:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45904 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731454AbfDQOeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:34:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6141B15A2;
        Wed, 17 Apr 2019 07:34:37 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B02433F557;
        Wed, 17 Apr 2019 07:34:33 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Steven Price <steven.price@arm.com>
Subject: [RFC PATCH 2/3] arm64: mm: Switch to using generic pt_dump
Date:   Wed, 17 Apr 2019 15:34:22 +0100
Message-Id: <20190417143423.26665-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417143423.26665-1-steven.price@arm.com>
References: <3acbf061-8c97-55eb-f4b6-163a33ea4d73@arm.com>
 <20190417143423.26665-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of providing our own callbacks for walking the page tables,
switch to using the generic version instead.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/Kconfig              |   1 +
 arch/arm64/Kconfig.debug        |  19 +-----
 arch/arm64/include/asm/ptdump.h |   8 +--
 arch/arm64/mm/Makefile          |   4 +-
 arch/arm64/mm/dump.c            | 104 +++++++++-----------------------
 arch/arm64/mm/ptdump_debugfs.c  |   2 +-
 6 files changed, 37 insertions(+), 101 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 117b2541ef3d..4ff55b3ce8dc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -97,6 +97,7 @@ config ARM64
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP
+	select GENERIC_PTDUMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 69c9170bdd24..570dba4d4a0e 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -1,21 +1,4 @@
 
-config ARM64_PTDUMP_CORE
-	def_bool n
-
-config ARM64_PTDUMP_DEBUGFS
-	bool "Export kernel pagetable layout to userspace via debugfs"
-	depends on DEBUG_KERNEL
-	select ARM64_PTDUMP_CORE
-	select DEBUG_FS
-        help
-	  Say Y here if you want to show the kernel pagetable layout in a
-	  debugfs file. This information is only useful for kernel developers
-	  who are working in architecture specific areas of the kernel.
-	  It is probably not a good idea to enable this feature in a production
-	  kernel.
-
-	  If in doubt, say N.
-
 config PID_IN_CONTEXTIDR
 	bool "Write the current PID to the CONTEXTIDR register"
 	help
@@ -41,7 +24,7 @@ config ARM64_RANDOMIZE_TEXT_OFFSET
 
 config DEBUG_WX
 	bool "Warn on W+X mappings at boot"
-	select ARM64_PTDUMP_CORE
+	select PTDUMP_CORE
 	---help---
 	  Generate a warning if any W+X mappings are found at boot.
 
diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 9e948a93d26c..f8fecda7b61d 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -16,7 +16,7 @@
 #ifndef __ASM_PTDUMP_H
 #define __ASM_PTDUMP_H
 
-#ifdef CONFIG_ARM64_PTDUMP_CORE
+#ifdef CONFIG_PTDUMP_CORE
 
 #include <linux/mm_types.h>
 #include <linux/seq_file.h>
@@ -32,15 +32,15 @@ struct ptdump_info {
 	unsigned long			base_addr;
 };
 
-void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
-#ifdef CONFIG_ARM64_PTDUMP_DEBUGFS
+void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
+#ifdef CONFIG_PTDUMP_DEBUGFS
 void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 #else
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
 #endif
 void ptdump_check_wx(void);
-#endif /* CONFIG_ARM64_PTDUMP_CORE */
+#endif /* CONFIG_PTDUMP_CORE */
 
 #ifdef CONFIG_DEBUG_WX
 #define debug_checkwx()	ptdump_check_wx()
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 849c1df3d214..d91030f0ffee 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -4,8 +4,8 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   ioremap.o mmap.o pgd.o mmu.o \
 				   context.o proc.o pageattr.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
-obj-$(CONFIG_ARM64_PTDUMP_CORE)	+= dump.o
-obj-$(CONFIG_ARM64_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
+obj-$(CONFIG_PTDUMP_CORE)	+= dump.o
+obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 KASAN_SANITIZE_physaddr.o	+= n
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index ea20c1213498..e68df2ad8863 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/ptdump.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 
@@ -69,6 +70,7 @@ static const struct addr_marker address_markers[] = {
  * dumps out a description of the range.
  */
 struct pg_state {
+	struct ptdump_state ptdump;
 	struct seq_file *seq;
 	const struct addr_marker *marker;
 	unsigned long start_address;
@@ -172,6 +174,10 @@ static struct pg_level pg_level[] = {
 		.name	= "PGD",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
+	}, { /* p4d */
+		.name	= "P4D",
+		.bits	= pte_bits,
+		.num	= ARRAY_SIZE(pte_bits),
 	}, { /* pud */
 		.name	= (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
 		.bits	= pte_bits,
@@ -234,9 +240,10 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
 }
 
-static void note_page(struct pg_state *st, unsigned long addr, int level,
-				u64 val)
+static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
+				unsigned long val)
 {
+	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	static const char units[] = "KMGTPE";
 	u64 prot = 0;
 
@@ -289,83 +296,21 @@ static void note_page(struct pg_state *st, unsigned long addr, int level,
 
 }
 
-static int pud_entry(pud_t *pud, unsigned long addr,
-		unsigned long next, struct mm_walk *walk)
-{
-	struct pg_state *st = walk->private;
-	pud_t val = READ_ONCE(*pud);
-
-	if (pud_table(val))
-		return 0;
-
-	note_page(st, addr, 2, pud_val(val));
-
-	return 0;
-}
-
-static int pmd_entry(pmd_t *pmd, unsigned long addr,
-		unsigned long next, struct mm_walk *walk)
-{
-	struct pg_state *st = walk->private;
-	pmd_t val = READ_ONCE(*pmd);
-
-	if (pmd_table(val))
-		return 0;
-
-	note_page(st, addr, 3, pmd_val(val));
-
-	return 0;
-}
-
-static int pte_entry(pte_t *pte, unsigned long addr,
-		unsigned long next, struct mm_walk *walk)
-{
-	struct pg_state *st = walk->private;
-	pte_t val = READ_ONCE(*pte);
-
-	note_page(st, addr, 4, pte_val(val));
-
-	return 0;
-}
-
-static int pte_hole(unsigned long addr, unsigned long next,
-		struct mm_walk *walk)
-{
-	struct pg_state *st = walk->private;
-
-	note_page(st, addr, -1, 0);
-
-	return 0;
-}
-
-static void walk_pgd(struct pg_state *st, struct mm_struct *mm,
-		unsigned long start)
-{
-	struct mm_walk walk = {
-		.mm = mm,
-		.private = st,
-		.pud_entry = pud_entry,
-		.pmd_entry = pmd_entry,
-		.pte_entry = pte_entry,
-		.pte_hole = pte_hole
-	};
-	down_read(&mm->mmap_sem);
-	walk_page_range(start, start | (((unsigned long)PTRS_PER_PGD <<
-					 PGDIR_SHIFT) - 1),
-			&walk);
-	up_read(&mm->mmap_sem);
-}
-
-void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)
+void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 {
 	struct pg_state st = {
-		.seq = m,
+		.seq = s,
 		.marker = info->markers,
+		.ptdump = {
+			.note_page = note_page,
+			.range = (struct ptdump_range[]){
+				{info->base_addr, ~0UL},
+				{0, 0}
+			}
+		}
 	};
 
-	walk_pgd(&st, info->mm, info->base_addr);
-
-	note_page(&st, 0, 0, 0);
+	ptdump_walk_pgd(&st.ptdump, info->mm);
 }
 
 static void ptdump_initialize(void)
@@ -393,10 +338,17 @@ void ptdump_check_wx(void)
 			{ -1, NULL},
 		},
 		.check_wx = true,
+		.ptdump = {
+			.note_page = note_page,
+			.range = (struct ptdump_range[]) {
+				{VA_START, ~0UL},
+				{0, 0}
+			}
+		}
 	};
 
-	walk_pgd(&st, &init_mm, VA_START);
-	note_page(&st, 0, 0, 0);
+	ptdump_walk_pgd(&st.ptdump, &init_mm);
+
 	if (st.wx_pages || st.uxn_pages)
 		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found, %lu non-UXN pages found\n",
 			st.wx_pages, st.uxn_pages);
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 064163f25592..1f2eae3e988b 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -7,7 +7,7 @@
 static int ptdump_show(struct seq_file *m, void *v)
 {
 	struct ptdump_info *info = m->private;
-	ptdump_walk_pgd(m, info);
+	ptdump_walk(m, info);
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
-- 
2.20.1

