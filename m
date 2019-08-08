Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91187C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5222173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofe+C/6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbfHHHSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:18:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39684 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHHSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:18:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so39582522pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QURP9tOX78OoV4YHCAVa4gci4kleUEql2IHdV0xtxs=;
        b=ofe+C/6DddZyrlA676hoMNYEomzxlCl46Fw00Ol5KRPmYwLSXIvjNgpKXzEhKBFXx2
         2eJVS8sdC7xB/JWrbk1vuYQF6/RJQnZCg/4Y7fncYaY2oQkxtMl2WeAurHsBvHCdQHSC
         1pVhBxZU7PavnfiYxuOe53Hi/zm3kFxYxZHo429vz75VB9F+gZHSMAnSGVY3t73OyF0R
         osXEriXi46YAOfRfkG8klF/r7ZnzhdXrlYSzHZXR2DNFGz3OI8i1oIFbzqMv6y1s7PaW
         tF1v9G+h6WTLPfGytr1qSWojG0LiIfwXB9AhSY8xMMNc8nHJVuPUBCN4/KEX5qrjhxIx
         GyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QURP9tOX78OoV4YHCAVa4gci4kleUEql2IHdV0xtxs=;
        b=BMITVoOsohepfHw1ZLnx8Vweqfj8Zjf4eZcFXOcxCXKRx/oWu4ShJMLghMs8MijNm4
         8BkaUSJkqBdT0JtOwngvzZhrIrZPtyTggJdIfoBVbrfCSkg+GPrd99hLIvCLkg72HVBe
         wq2MDAiKGoMhKQDnexLsX0qiBWA8rNJwUr1qiOTnaD9faXluu+la+Rf3NzhfiJfh5Dpk
         3WOGog26umDMwwDekESBN8mWSh3siNcKGsgDhCvYiw2wR3nk+CG29VLfbjnKT2B7oMgA
         +zpfkAdvt0Y8RePAKhprK+c/5oOO/YgtN9+zWEayho66rdwAc13Z7bsaAPA5WCsqKmul
         l/oQ==
X-Gm-Message-State: APjAAAUoxbWEISMLEQCuLtMnnZRw7Z8nLr1r7Da13CR5bd6k7pnBsLk5
        jVM6hCoXp/+GsPg6imjeQ9sgftGLiNK/jA==
X-Google-Smtp-Source: APXvYqxaB9L2RCswOePuUQM+DhSwxpmDjg2nAbPkGip2xWbLOC1BEw2+nSXFh6g4o27B11DrViofsw==
X-Received: by 2002:a62:8f91:: with SMTP id n139mr11570927pfd.48.1565248693830;
        Thu, 08 Aug 2019 00:18:13 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id w22sm99435168pfi.175.2019.08.08.00.18.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 00:18:13 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] powerpc/mm: Use refcount_t for refcount
Date:   Thu,  8 Aug 2019 15:18:08 +0800
Message-Id: <20190808071808.6531-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference counters are preferred to use refcount_t instead of
atomic_t.
This is because the implementation of refcount_t can prevent
overflows and detect possible use-after-free.
So convert atomic_t ref counters to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 arch/powerpc/mm/book3s64/mmu_context.c | 2 +-
 arch/powerpc/mm/book3s64/pgtable.c     | 7 +++----
 arch/powerpc/mm/pgtable-frag.c         | 9 ++++-----
 include/linux/mm_types.h               | 3 ++-
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index 2d0cb5ba9a47..f836fd5a6abc 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -231,7 +231,7 @@ static void pmd_frag_destroy(void *pmd_frag)
 	/* drop all the pending references */
 	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (atomic_sub_and_test(PMD_FRAG_NR - count, &page->pt_frag_refcount)) {
+	if (refcount_sub_and_test(PMD_FRAG_NR - count, &page->pt_frag_refcount)) {
 		pgtable_pmd_page_dtor(page);
 		__free_page(page);
 	}
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 7d0e0d0d22c4..40056896ce4e 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -277,7 +277,7 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
 		return NULL;
 	}
 
-	atomic_set(&page->pt_frag_refcount, 1);
+	refcount_set(&page->pt_frag_refcount, 1);
 
 	ret = page_address(page);
 	/*
@@ -294,7 +294,7 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
 	 * count.
 	 */
 	if (likely(!mm->context.pmd_frag)) {
-		atomic_set(&page->pt_frag_refcount, PMD_FRAG_NR);
+		refcount_set(&page->pt_frag_refcount, PMD_FRAG_NR);
 		mm->context.pmd_frag = ret + PMD_FRAG_SIZE;
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -317,8 +317,7 @@ void pmd_fragment_free(unsigned long *pmd)
 {
 	struct page *page = virt_to_page(pmd);
 
-	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
-	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
+	if (refcount_dec_and_test(&page->pt_frag_refcount)) {
 		pgtable_pmd_page_dtor(page);
 		__free_page(page);
 	}
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index a7b05214760c..4ef8231b677f 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -24,7 +24,7 @@ void pte_frag_destroy(void *pte_frag)
 	/* drop all the pending references */
 	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
+	if (refcount_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
 		pgtable_page_dtor(page);
 		__free_page(page);
 	}
@@ -71,7 +71,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 			return NULL;
 	}
 
-	atomic_set(&page->pt_frag_refcount, 1);
+	refcount_set(&page->pt_frag_refcount, 1);
 
 	ret = page_address(page);
 	/*
@@ -87,7 +87,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 	 * count.
 	 */
 	if (likely(!pte_frag_get(&mm->context))) {
-		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
+		refcount_set(&page->pt_frag_refcount, PTE_FRAG_NR);
 		pte_frag_set(&mm->context, ret + PTE_FRAG_SIZE);
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -110,8 +110,7 @@ void pte_fragment_free(unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
 
-	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
-	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
+	if (refcount_dec_and_test(&page->pt_frag_refcount)) {
 		if (!kernel)
 			pgtable_page_dtor(page);
 		__free_page(page);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3a37a89eb7a7..7fe23a3faf95 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -14,6 +14,7 @@
 #include <linux/uprobes.h>
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
+#include <linux/refcount.h>
 
 #include <asm/mmu.h>
 
@@ -147,7 +148,7 @@ struct page {
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
-				atomic_t pt_frag_refcount; /* powerpc */
+				refcount_t pt_frag_refcount; /* powerpc */
 			};
 #if ALLOC_SPLIT_PTLOCKS
 			spinlock_t *ptl;
-- 
2.20.1

