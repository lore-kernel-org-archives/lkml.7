Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC55C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BEE208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329250;
	bh=Y0pgp+cW86eu1WvjuOqG11JMB9mYMKFomTMG0EnJlf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Du1rmIuVj5trOZkvhPBPwewdFKrNI/HBfOSB/9eVLRnANPwnhgadDySTWWNCWb1uP
	 kTHcEWCi553XNK1NjZSKJZJjFnJ5qxGinkO+tHwIcsmY6hsQDxajUjn8xrE5fhMZAx
	 ylnCqwdH/kAYz1pAW9WPw/9gmeQYtjOKngEJ6Mk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfD0Bkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfD0Bkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF72208CB;
        Sat, 27 Apr 2019 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329246;
        bh=Y0pgp+cW86eu1WvjuOqG11JMB9mYMKFomTMG0EnJlf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hk0UKNlKlJ9pnpiJRYN8QejQwxlwt3aoU53TNXZkfaxxqpFAM15wU+x11/Ma9h6gN
         F7tAVPIvSMUt9PS/ze1JQwEga3mQ/9VW2RIAAuviI1pPgqRmtU/a7ukESOv0ANU8jJ
         jKQn1thb/4U0Ry9ViIjCN8rdf6VuRZpr13/Css8Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.0 78/79] mm: prevent get_user_pages() from overflowing page refcount
Date:   Fri, 26 Apr 2019 21:38:37 -0400
Message-Id: <20190427013838.6596-78-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 8fde12ca79aff9b5ba951fce1a2641901b8d8e64 ]

If the page refcount wraps around past zero, it will be freed while
there are still four billion references to it.  One of the possible
avenues for an attacker to try to make this happen is by doing direct IO
on a page multiple times.  This patch makes get_user_pages() refuse to
take a new page reference if there are already more than two billion
references to the page.

Reported-by: Jann Horn <jannh@google.com>
Acked-by: Matthew Wilcox <willy@infradead.org>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c     | 48 ++++++++++++++++++++++++++++++++++++------------
 mm/hugetlb.c | 13 +++++++++++++
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 75029649baca..81e0bdefa2cc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -157,8 +157,12 @@ retry:
 		goto retry;
 	}
 
-	if (flags & FOLL_GET)
-		get_page(page);
+	if (flags & FOLL_GET) {
+		if (unlikely(!try_get_page(page))) {
+			page = ERR_PTR(-ENOMEM);
+			goto out;
+		}
+	}
 	if (flags & FOLL_TOUCH) {
 		if ((flags & FOLL_WRITE) &&
 		    !pte_dirty(pte) && !PageDirty(page))
@@ -295,7 +299,10 @@ retry_locked:
 			if (pmd_trans_unstable(pmd))
 				ret = -EBUSY;
 		} else {
-			get_page(page);
+			if (unlikely(!try_get_page(page))) {
+				spin_unlock(ptl);
+				return ERR_PTR(-ENOMEM);
+			}
 			spin_unlock(ptl);
 			lock_page(page);
 			ret = split_huge_page(page);
@@ -497,7 +504,10 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 		if (is_device_public_page(*page))
 			goto unmap;
 	}
-	get_page(*page);
+	if (unlikely(!try_get_page(*page))) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
 out:
 	ret = 0;
 unmap:
@@ -1393,6 +1403,20 @@ static void undo_dev_pagemap(int *nr, int nr_start, struct page **pages)
 	}
 }
 
+/*
+ * Return the compund head page with ref appropriately incremented,
+ * or NULL if that failed.
+ */
+static inline struct page *try_get_compound_head(struct page *page, int refs)
+{
+	struct page *head = compound_head(page);
+	if (WARN_ON_ONCE(page_ref_count(head) < 0))
+		return NULL;
+	if (unlikely(!page_cache_add_speculative(head, refs)))
+		return NULL;
+	return head;
+}
+
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			 int write, struct page **pages, int *nr)
@@ -1427,9 +1451,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
-		head = compound_head(page);
 
-		if (!page_cache_get_speculative(head))
+		head = try_get_compound_head(page, 1);
+		if (!head)
 			goto pte_unmap;
 
 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
@@ -1568,8 +1592,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
-	head = compound_head(pmd_page(orig));
-	if (!page_cache_add_speculative(head, refs)) {
+	head = try_get_compound_head(pmd_page(orig), refs);
+	if (!head) {
 		*nr -= refs;
 		return 0;
 	}
@@ -1606,8 +1630,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
-	head = compound_head(pud_page(orig));
-	if (!page_cache_add_speculative(head, refs)) {
+	head = try_get_compound_head(pud_page(orig), refs);
+	if (!head) {
 		*nr -= refs;
 		return 0;
 	}
@@ -1643,8 +1667,8 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
-	head = compound_head(pgd_page(orig));
-	if (!page_cache_add_speculative(head, refs)) {
+	head = try_get_compound_head(pgd_page(orig), refs);
+	if (!head) {
 		*nr -= refs;
 		return 0;
 	}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8dfdffc34a99..c220315dc533 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4298,6 +4298,19 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
 		page = pte_page(huge_ptep_get(pte));
+
+		/*
+		 * Instead of doing 'try_get_page()' below in the same_page
+		 * loop, just check the count once here.
+		 */
+		if (unlikely(page_count(page) <= 0)) {
+			if (pages) {
+				spin_unlock(ptl);
+				remainder = 0;
+				err = -ENOMEM;
+				break;
+			}
+		}
 same_page:
 		if (pages) {
 			pages[i] = mem_map_offset(page, pfn_offset);
-- 
2.19.1

