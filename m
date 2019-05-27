Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40934C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 03:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A0621707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 03:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfE0D6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 23:58:39 -0400
Received: from foss.arm.com ([217.140.101.70]:54410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfE0D6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 23:58:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25AF0A78;
        Sun, 26 May 2019 20:58:38 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D3373F690;
        Sun, 26 May 2019 20:58:35 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64/mm: Simplify protection flag creation for kernel huge mappings
Date:   Mon, 27 May 2019 09:28:15 +0530
Message-Id: <1558929495-19898-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though they have got the same value, PMD_TYPE_SECT and PUD_TYPE_SECT
get used for kernel huge mappings. But before that first the table bit gets
cleared using leaf level PTE_TABLE_BIT. Though functionally they are same,
we should use page table level specific macros to be consistent as per the
MMU specifications. Create page table level specific wrappers for kernel
huge mapping entries and just drop mk_sect_prot() which does not have any
other user.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 9 +++++++--
 arch/arm64/mm/mmu.c              | 8 ++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2c41b04708fe..6478dd121228 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -335,9 +335,14 @@ static inline pmd_t pte_pmd(pte_t pte)
 	return __pmd(pte_val(pte));
 }
 
-static inline pgprot_t mk_sect_prot(pgprot_t prot)
+static inline pgprot_t mk_pud_sect_prot(pgprot_t prot)
 {
-	return __pgprot(pgprot_val(prot) & ~PTE_TABLE_BIT);
+	return __pgprot((pgprot_val(prot) & ~PUD_TABLE_BIT) | PUD_TYPE_SECT);
+}
+
+static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~PMD_TABLE_BIT) | PMD_TYPE_SECT);
 }
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a1bfc4413982..22c2e4f0768f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -971,9 +971,7 @@ int __init arch_ioremap_pmd_supported(void)
 
 int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
-	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
-					pgprot_val(mk_sect_prot(prot)));
-	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), sect_prot);
+	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), mk_pud_sect_prot(prot));
 
 	/* Only allow permission changes for now */
 	if (!pgattr_change_is_safe(READ_ONCE(pud_val(*pudp)),
@@ -987,9 +985,7 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 
 int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
-	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
-					pgprot_val(mk_sect_prot(prot)));
-	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), sect_prot);
+	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), mk_pmd_sect_prot(prot));
 
 	/* Only allow permission changes for now */
 	if (!pgattr_change_is_safe(READ_ONCE(pmd_val(*pmdp)),
-- 
2.20.1

