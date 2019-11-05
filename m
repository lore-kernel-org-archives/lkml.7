Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735AFC17495
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A14921A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572964418;
	bh=6O2NEEOOxx8S7SJH4HJjeFMgt6ASRdeLnH/DBw8jvyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P6sqTIgHkOfN+AJnjyv46ieNmxj0vzN+uUoi3kNqQtfnkBHwQ6DfnpS5mUf2aJHcl
	 KUru8fYvh4GnMfNC81nDjc/son6DkeuzcuBJTIHyOA5cbvxGyTd/ImZw6MJ2Ljp2yA
	 JalRe1RHEgavbb4MM7H4TIkkROUqc/3bFqcLCaK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389644AbfKEOdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389110AbfKEOdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:33:36 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0B4021D7D;
        Tue,  5 Nov 2019 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572964415;
        bh=6O2NEEOOxx8S7SJH4HJjeFMgt6ASRdeLnH/DBw8jvyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNnYaSw5E8zeWjE5qyw8SXSRhjEB1Y/l52tPCck474r3Vnxo+geo+xth+4cQaZrvM
         x9RpPKpytTr8KVcicGo2NvghHix2L0eQgIhc5un5gxqmKul+7/0VxTfXIfTNDeQJ4M
         b20OdjstrAiailpQintBbuffbGNBSxD85m4355IM=
From:   Mike Rapoport <rppt@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/2] xtensa: get rid of __ARCH_USE_5LEVEL_HACK
Date:   Tue,  5 Nov 2019 16:33:20 +0200
Message-Id: <1572964400-16542-3-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572964400-16542-1-git-send-email-rppt@kernel.org>
References: <1572964400-16542-1-git-send-email-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

xtensa has 2-level page tables and already uses pgtable-nopmd for page
table folding.

Add walks of p4d level where appropriate and drop usage of
__ARCH_USE_5LEVEL_HACK.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/xtensa/include/asm/pgtable.h |  1 -
 arch/xtensa/mm/fault.c            | 10 ++++++++--
 arch/xtensa/mm/kasan_init.c       |  6 ++++--
 arch/xtensa/mm/mmu.c              |  3 ++-
 arch/xtensa/mm/tlb.c              |  5 ++++-
 5 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index af72f02..27ac17c 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -8,7 +8,6 @@
 #ifndef _XTENSA_PGTABLE_H
 #define _XTENSA_PGTABLE_H
 
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm/page.h>
 #include <asm/kmem_layout.h>
 #include <asm-generic/pgtable-nopmd.h>
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 68a0414..bee30a7 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -197,6 +197,7 @@ void do_page_fault(struct pt_regs *regs)
 		struct mm_struct *act_mm = current->active_mm;
 		int index = pgd_index(address);
 		pgd_t *pgd, *pgd_k;
+		p4d_t *p4d, *p4d_k;
 		pud_t *pud, *pud_k;
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
@@ -212,8 +213,13 @@ void do_page_fault(struct pt_regs *regs)
 
 		pgd_val(*pgd) = pgd_val(*pgd_k);
 
-		pud = pud_offset(pgd, address);
-		pud_k = pud_offset(pgd_k, address);
+		p4d = p4d_offset(pgd, address);
+		p4d_k = p4d_offset(pgd_k, address);
+		if (!p4d_present(*p4d) || !p4d_present(*p4d_k))
+			goto bad_page_fault;
+
+		pud = pud_offset(p4d, address);
+		pud_k = pud_offset(p4d_k, address);
 		if (!pud_present(*pud) || !pud_present(*pud_k))
 			goto bad_page_fault;
 
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index ace98bd..9c95779 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -20,7 +20,8 @@ void __init kasan_early_init(void)
 {
 	unsigned long vaddr = KASAN_SHADOW_START;
 	pgd_t *pgd = pgd_offset_k(vaddr);
-	pud_t *pud = pud_offset(pgd, vaddr);
+	p4d_t *p4d = p4d_offset(pgd, vaddr);
+	pud_t *pud = pud_offset(p4d, vaddr);
 	pmd_t *pmd = pmd_offset(pud, vaddr);
 	int i;
 
@@ -43,7 +44,8 @@ static void __init populate(void *start, void *end)
 	unsigned long i, j;
 	unsigned long vaddr = (unsigned long)start;
 	pgd_t *pgd = pgd_offset_k(vaddr);
-	pud_t *pud = pud_offset(pgd, vaddr);
+	p4d_t *p4d = p4d_offset(pgd, vaddr);
+	pud_t *pud = pud_offset(p4d, vaddr);
 	pmd_t *pmd = pmd_offset(pud, vaddr);
 	pte_t *pte = memblock_alloc(n_pages * sizeof(pte_t), PAGE_SIZE);
 
diff --git a/arch/xtensa/mm/mmu.c b/arch/xtensa/mm/mmu.c
index 018dda2..37e478a 100644
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -22,7 +22,8 @@
 static void * __init init_pmd(unsigned long vaddr, unsigned long n_pages)
 {
 	pgd_t *pgd = pgd_offset_k(vaddr);
-	pud_t *pud = pud_offset(pgd, vaddr);
+	p4d_t *p4d = p4d_offset(pgd, vaddr);
+	pud_t *pud = pud_offset(p4d, vaddr);
 	pmd_t *pmd = pmd_offset(pud, vaddr);
 	pte_t *pte;
 	unsigned long i;
diff --git a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
index 164a2ca..a460474 100644
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -178,7 +178,10 @@ static unsigned get_pte_for_vaddr(unsigned vaddr)
 	pgd = pgd_offset(mm, vaddr);
 	if (pgd_none_or_clear_bad(pgd))
 		return 0;
-	pud = pud_offset(pgd, vaddr);
+	p4d = p4d_offset(pgd, vaddr);
+	if (p4d_none_or_clear_bad(p4d))
+		return 0;
+	pud = pud_offset(p4d, vaddr);
 	if (pud_none_or_clear_bad(pud))
 		return 0;
 	pmd = pmd_offset(pud, vaddr);
-- 
2.7.4

