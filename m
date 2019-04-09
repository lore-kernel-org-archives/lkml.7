Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B40C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C7C21841
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfDIGSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:18:06 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46663 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfDIGSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:18:05 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 541991C0009;
        Tue,  9 Apr 2019 06:17:58 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 2/2] riscv: Introduce huge page support for 32/64bit kernel
Date:   Tue,  9 Apr 2019 02:14:49 -0400
Message-Id: <20190409061449.5083-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409061449.5083-1-alex@ghiti.fr>
References: <20190409061449.5083-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements both 4MB huge page support for 32bit kernel
and 2MB/1GB huge pages support for 64bit kernel.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/Kconfig               |  8 ++++++
 arch/riscv/include/asm/hugetlb.h | 18 +++++++++++++
 arch/riscv/include/asm/page.h    | 10 ++++++++
 arch/riscv/include/asm/pgtable.h |  8 ++++--
 arch/riscv/mm/Makefile           |  2 ++
 arch/riscv/mm/hugetlbpage.c      | 44 ++++++++++++++++++++++++++++++++
 6 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/hugetlb.h
 create mode 100644 arch/riscv/mm/hugetlbpage.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb56c82d8aa1..a400d4b4e1b3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -49,6 +49,8 @@ config RISCV
 	select GENERIC_IRQ_MULTI_HANDLER
 	select ARCH_HAS_PTE_SPECIAL
 	select HAVE_EBPF_JIT if 64BIT
+	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 
 config MMU
 	def_bool y
@@ -63,6 +65,12 @@ config PAGE_OFFSET
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
+config ARCH_WANT_GENERAL_HUGETLB
+	def_bool y
+
+config SYS_SUPPORTS_HUGETLBFS
+	def_bool y
+
 config STACKTRACE_SUPPORT
 	def_bool y
 
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
new file mode 100644
index 000000000000..728a5db66597
--- /dev/null
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_HUGETLB_H
+#define _ASM_RISCV_HUGETLB_H
+
+#include <asm-generic/hugetlb.h>
+#include <asm/page.h>
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					 unsigned long addr,
+					 unsigned long len) {
+	return 0;
+}
+
+static inline void arch_clear_hugepage_flags(struct page *page)
+{
+}
+
+#endif /* _ASM_RISCV_HUGETLB_H */
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 2a546a52f02a..4ef2936295aa 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -24,6 +24,16 @@
 #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE - 1))
 
+#ifdef CONFIG_64BIT
+#define HUGE_MAX_HSTATE		2
+#else
+#define HUGE_MAX_HSTATE		1
+#endif
+#define HPAGE_SHIFT		PMD_SHIFT
+#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
+
 /*
  * PAGE_OFFSET -- the first address of the first page of memory.
  * When not using MMU this corresponds to the first free page in
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 1141364d990e..f3456fcdff92 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -121,7 +121,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 	set_pmd(pmdp, __pmd(0));
 }
 
-
 static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
 {
 	return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
@@ -258,6 +257,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
+static inline pte_t pte_mkhuge(pte_t pte)
+{
+	return pte;
+}
+
 /* Modify page protection bits */
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
@@ -417,7 +421,7 @@ static inline void pgtable_cache_init(void)
 #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
 
 /*
- * Task size is 0x40000000000 for RV64 or 0xb800000 for RV32.
+ * Task size is 0x4000000000 for RV64 or 0xb800000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  */
 #ifdef CONFIG_64BIT
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index b68aac701803..7bbe533d92f5 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -9,3 +9,5 @@ obj-y += fault.o
 obj-y += extable.o
 obj-y += ioremap.o
 obj-y += cacheflush.o
+
+obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
new file mode 100644
index 000000000000..0d4747e9d5b5
--- /dev/null
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/hugetlb.h>
+#include <linux/err.h>
+
+int pud_huge(pud_t pud)
+{
+	return pud_present(pud) &&
+		(pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+}
+
+int pmd_huge(pmd_t pmd)
+{
+	return pmd_present(pmd) &&
+		(pmd_val(pmd) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+}
+
+static __init int setup_hugepagesz(char *opt)
+{
+	unsigned long ps = memparse(opt, &opt);
+
+	if (ps == HPAGE_SIZE) {
+		hugetlb_add_hstate(HPAGE_SHIFT - PAGE_SHIFT);
+	} else if (IS_ENABLED(CONFIG_64BIT) && ps == PUD_SIZE) {
+		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
+	} else {
+		hugetlb_bad_size();
+		pr_err("hugepagesz: Unsupported page size %lu M\n", ps >> 20);
+		return 0;
+	}
+
+	return 1;
+}
+__setup("hugepagesz=", setup_hugepagesz);
+
+#ifdef CONFIG_CONTIG_ALLOC
+static __init int gigantic_pages_init(void)
+{
+	/* With CONTIG_ALLOC, we can allocate gigantic pages at runtime */
+	if (IS_ENABLED(CONFIG_64BIT) && !size_to_hstate(1UL << PUD_SHIFT))
+		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
+	return 0;
+}
+arch_initcall(gigantic_pages_init);
+#endif
-- 
2.20.1

