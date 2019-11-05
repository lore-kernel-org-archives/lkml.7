Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0797C17495
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A747D21D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572964415;
	bh=RJ99QllcrN1HNR6BEqcZH1BDdjZzLYeU5xEjL0q3c+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t56bITfESnCbAypVoppt7ONjZo8wNqPu1+q8vT1rlnPvF8+OuKjdoLt41LAsj4gMn
	 UUMgy4cwU4jzvT6TN18cayeQAmzd8LUG91t0ojfd/ZraOKb7QvWM+xE7f/wz8ec+eo
	 PFw0zRa4f/6XhSoYUBnU4/2LLaig7hNDZ65miHRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbfKEOde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:33:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389110AbfKEOde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:33:34 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DAF821A4A;
        Tue,  5 Nov 2019 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572964412;
        bh=RJ99QllcrN1HNR6BEqcZH1BDdjZzLYeU5xEjL0q3c+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/LYGSISJvrOYDYvaiQC2MnO2xwZSTDM8WPqBrtkyIZhkHDEgFGuWVtpicFK+N6XC
         0tPbw8YFxb9T4+9TlAf/0krMDkQz+QH6iLwGo6JIH4UVxe+zQCb8bxuOt8+0Dw9bCW
         qACCLMwfnpZ29/Q9T54ul8vUZ27Qx9y5nc9aiaHk=
From:   Mike Rapoport <rppt@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 1/2] xtensa: mm: fix PMD folding implementation
Date:   Tue,  5 Nov 2019 16:33:19 +0200
Message-Id: <1572964400-16542-2-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572964400-16542-1-git-send-email-rppt@kernel.org>
References: <1572964400-16542-1-git-send-email-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There was a definition of pmd_offset() in arch/xtensa/include/asm/pgtable.h
that shadowed the generic implementation defined in
include/asm-generic/pgtable-nopmd.h.

As the result, xtensa had shortcuts in page table traversal in several
places instead of doing level unfolding.

Remove local override for pmd_offset() and add page table unfolding where
necessary.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/xtensa/include/asm/pgtable.h |  3 ---
 arch/xtensa/mm/fault.c            | 10 ++++++++--
 arch/xtensa/mm/kasan_init.c       |  6 ++++--
 arch/xtensa/mm/mmu.c              |  3 ++-
 arch/xtensa/mm/tlb.c              |  6 +++++-
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 3f7fe5a..af72f02 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -371,9 +371,6 @@ ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 
 #define pgd_index(address)	((address) >> PGDIR_SHIFT)
 
-/* Find an entry in the second-level page table.. */
-#define pmd_offset(dir,address) ((pmd_t*)(dir))
-
 /* Find an entry in the third-level page table.. */
 #define pte_index(address)	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir,addr) 					\
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index f81b147..68a0414 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -197,6 +197,7 @@ void do_page_fault(struct pt_regs *regs)
 		struct mm_struct *act_mm = current->active_mm;
 		int index = pgd_index(address);
 		pgd_t *pgd, *pgd_k;
+		pud_t *pud, *pud_k;
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
 
@@ -211,8 +212,13 @@ void do_page_fault(struct pt_regs *regs)
 
 		pgd_val(*pgd) = pgd_val(*pgd_k);
 
-		pmd = pmd_offset(pgd, address);
-		pmd_k = pmd_offset(pgd_k, address);
+		pud = pud_offset(pgd, address);
+		pud_k = pud_offset(pgd_k, address);
+		if (!pud_present(*pud) || !pud_present(*pud_k))
+			goto bad_page_fault;
+
+		pmd = pmd_offset(pud, address);
+		pmd_k = pmd_offset(pud_k, address);
 		if (!pmd_present(*pmd) || !pmd_present(*pmd_k))
 			goto bad_page_fault;
 
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index af71525..ace98bd 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -20,7 +20,8 @@ void __init kasan_early_init(void)
 {
 	unsigned long vaddr = KASAN_SHADOW_START;
 	pgd_t *pgd = pgd_offset_k(vaddr);
-	pmd_t *pmd = pmd_offset(pgd, vaddr);
+	pud_t *pud = pud_offset(pgd, vaddr);
+	pmd_t *pmd = pmd_offset(pud, vaddr);
 	int i;
 
 	for (i = 0; i < PTRS_PER_PTE; ++i)
@@ -42,7 +43,8 @@ static void __init populate(void *start, void *end)
 	unsigned long i, j;
 	unsigned long vaddr = (unsigned long)start;
 	pgd_t *pgd = pgd_offset_k(vaddr);
-	pmd_t *pmd = pmd_offset(pgd, vaddr);
+	pud_t *pud = pud_offset(pgd, vaddr);
+	pmd_t *pmd = pmd_offset(pud, vaddr);
 	pte_t *pte = memblock_alloc(n_pages * sizeof(pte_t), PAGE_SIZE);
 
 	if (!pte)
diff --git a/arch/xtensa/mm/mmu.c b/arch/xtensa/mm/mmu.c
index 03678c4..018dda2 100644
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -22,7 +22,8 @@
 static void * __init init_pmd(unsigned long vaddr, unsigned long n_pages)
 {
 	pgd_t *pgd = pgd_offset_k(vaddr);
-	pmd_t *pmd = pmd_offset(pgd, vaddr);
+	pud_t *pud = pud_offset(pgd, vaddr);
+	pmd_t *pmd = pmd_offset(pud, vaddr);
 	pte_t *pte;
 	unsigned long i;
 
diff --git a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
index 59153d0..164a2ca 100644
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -169,6 +169,7 @@ static unsigned get_pte_for_vaddr(unsigned vaddr)
 	struct task_struct *task = get_current();
 	struct mm_struct *mm = task->mm;
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 
@@ -177,7 +178,10 @@ static unsigned get_pte_for_vaddr(unsigned vaddr)
 	pgd = pgd_offset(mm, vaddr);
 	if (pgd_none_or_clear_bad(pgd))
 		return 0;
-	pmd = pmd_offset(pgd, vaddr);
+	pud = pud_offset(pgd, vaddr);
+	if (pud_none_or_clear_bad(pud))
+		return 0;
+	pmd = pmd_offset(pud, vaddr);
 	if (pmd_none_or_clear_bad(pmd))
 		return 0;
 	pte = pte_offset_map(pmd, vaddr);
-- 
2.7.4

