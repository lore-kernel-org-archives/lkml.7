Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E739C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E832075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfC0Vg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:36:56 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58676 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbfC0Vgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:36:50 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE4-0006DM-EI; Wed, 27 Mar 2019 15:36:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE2-0006Cn-FL; Wed, 27 Mar 2019 15:36:46 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Stefan O'Rear" <sorear2@gmail.com>,
        Anup Patel <anup.patel@wdc.com>, Zong Li <zong@andestech.com>,
        Guo Ren <ren_guo@c-sky.com>
Date:   Wed, 27 Mar 2019 15:36:42 -0600
Message-Id: <20190327213643.23789-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327213643.23789-1-logang@deltatee.com>
References: <20190327213643.23789-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sbates@raithlin.com, palmer@sifive.com, hch@lst.de, aou@eecs.berkeley.edu, logang@deltatee.com, rppt@linux.ibm.com, sorear2@gmail.com, anup.patel@wdc.com, zong@andestech.com, ren_guo@c-sky.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 6/7] RISC-V: Implement memory hot remove
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementing arch_remove_memory() and filling in vmemap_free() allows
us to declare ARCH_ENABLE_MEMORY_HOTREMOVE.

arch_remove_memory() is very similar to x86 and we roughly copy the
remove_pagetable() function from x86 but with a bunch of the unnecessary
features stripped out.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: "Stefan O'Rear" <sorear2@gmail.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Zong Li <zong@andestech.com>
Cc: Guo Ren <ren_guo@c-sky.com>
---
 arch/riscv/Kconfig                  |   3 +
 arch/riscv/include/asm/pgtable-64.h |   2 +
 arch/riscv/include/asm/pgtable.h    |   5 +
 arch/riscv/mm/init.c                | 186 ++++++++++++++++++++++++++++
 4 files changed, 196 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9477214a00e7..2cb39b4d6d6b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -86,6 +86,9 @@ config ARCH_SELECT_MEMORY_MODEL
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y
 
+config ARCH_ENABLE_MEMORY_HOTREMOVE
+	def_bool y
+
 config STACKTRACE_SUPPORT
 	def_bool y
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 7aa0ea9bd8bb..d369be5467cf 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -67,6 +67,8 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
 }
 
 #define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+#define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+#define p4d_index(addr) (((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
 
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 {
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2a5070540996..e071e2be3a6c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -173,6 +173,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
 }
 
+static inline struct page *pud_page(pud_t pud)
+{
+	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
+}
+
 /* Yields the page frame number (PFN) of a page table entry */
 static inline unsigned long pte_pfn(pte_t pte)
 {
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0a54c3adf0ac..fffe1238434e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -240,9 +240,175 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static void __meminit free_pagetable(struct page *page, int order)
+{
+	unsigned long magic;
+	unsigned int nr_pages = 1 << order;
+
+	/* bootmem page has reserved flag */
+	if (PageReserved(page)) {
+		__ClearPageReserved(page);
+
+		magic = (unsigned long)page->freelist;
+		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
+			while (nr_pages--)
+				put_page_bootmem(page++);
+		} else {
+			while (nr_pages--)
+				free_reserved_page(page++);
+		}
+	} else {
+		free_pages((unsigned long)page_address(page), order);
+	}
+}
+
+static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
+{
+	pte_t *pte;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		pte = pte_start + i;
+		if (!pte_none(*pte))
+			return;
+	}
+
+	/* free a pte table */
+	free_pagetable(pmd_page(*pmd), 0);
+	spin_lock(&init_mm.page_table_lock);
+	pmd_clear(pmd);
+	spin_unlock(&init_mm.page_table_lock);
+}
+
+static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
+{
+	pmd_t *pmd;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd = pmd_start + i;
+		if (!pmd_none(*pmd))
+			return;
+	}
+
+	/* free a pmd table */
+	free_pagetable(pud_page(*pud), 0);
+	spin_lock(&init_mm.page_table_lock);
+	pud_clear(pud);
+	spin_unlock(&init_mm.page_table_lock);
+}
+
+static void __meminit
+remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pte_t *pte;
+
+	pte = pte_start + pte_index(addr);
+	for (; addr < end; addr = next, pte++) {
+		next = (addr + PAGE_SIZE) & PAGE_MASK;
+		if (next > end)
+			next = end;
+
+		if (!pte_present(*pte))
+			continue;
+
+		free_pagetable(pte_page(*pte), 0);
+
+		spin_lock(&init_mm.page_table_lock);
+		pte_clear(&init_mm, addr, pte);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	flush_tlb_all();
+}
+
+static void __meminit
+remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pte_t *pte_base;
+	pmd_t *pmd;
+
+	pmd = pmd_start + pmd_index(addr);
+	for (; addr < end; addr = next, pmd++) {
+		next = pmd_addr_end(addr, end);
+
+		if (!pmd_present(*pmd))
+			continue;
+
+		pte_base = (pte_t *)pmd_page_vaddr(*pmd);
+		remove_pte_table(pte_base, addr, next);
+		free_pte_table(pte_base, pmd);
+	}
+}
+
+static void __meminit
+remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pmd_t *pmd_base;
+	pud_t *pud;
+
+	pud = pud_start + pud_index(addr);
+	for (; addr < end; addr = next, pud++) {
+		next = pud_addr_end(addr, end);
+
+		if (!pud_present(*pud))
+			continue;
+
+		pmd_base = pmd_offset(pud, 0);
+		remove_pmd_table(pmd_base, addr, next);
+		free_pmd_table(pmd_base, pud);
+	}
+}
+
+static void __meminit
+remove_p4d_table(p4d_t *p4d_start, unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pud_t *pud_base;
+	p4d_t *p4d;
+
+	p4d = p4d_start + p4d_index(addr);
+	for (; addr < end; addr = next, p4d++) {
+		next = p4d_addr_end(addr, end);
+
+		if (!p4d_present(*p4d))
+			continue;
+
+		pud_base = pud_offset(p4d, 0);
+		remove_pud_table(pud_base, addr, next);
+	}
+}
+
+/* start and end are both virtual address. */
+static void __meminit
+remove_pagetable(unsigned long start, unsigned long end)
+{
+	unsigned long next;
+	unsigned long addr;
+	pgd_t *pgd;
+	p4d_t *p4d;
+
+	for (addr = start; addr < end; addr = next) {
+		next = pgd_addr_end(addr, end);
+
+		pgd = pgd_offset_k(addr);
+		if (!pgd_present(*pgd))
+			continue;
+
+		p4d = p4d_offset(pgd, 0);
+		remove_p4d_table(p4d, addr, next);
+	}
+
+	flush_tlb_all();
+}
+
 void vmemmap_free(unsigned long start, unsigned long end,
 		  struct vmem_altmap *altmap)
 {
+	remove_pagetable(start, end);
 }
 
 int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
@@ -264,4 +430,24 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 	return ret;
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+int __ref arch_remove_memory(int nid, u64 start, u64 size,
+			     struct vmem_altmap *altmap)
+{
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct page *page = pfn_to_page(start_pfn);
+	struct zone *zone;
+	int ret;
+
+	if (altmap)
+		page += vmem_altmap_offset(altmap);
+	zone = page_zone(page);
+	ret = __remove_pages(zone, start_pfn, nr_pages, altmap);
+	WARN_ON_ONCE(ret);
+
+	return ret;
+}
+
+#endif
 #endif
-- 
2.20.1

