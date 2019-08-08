Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C506DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9192089E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+6juk5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404248AbfHHS4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:56:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35293 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403901AbfHHS4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:56:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so2793407pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VL69OhOnAwL0XYVUd4iryHVhyGAPtRV3TIOYsddsZuM=;
        b=f+6juk5fgHqCxIRZWOOX36n2xL+/ppYo6Qbp1wljaKvVZnxFO820pyEsxKJ+vzEohX
         iKEFP7KQmuYg8BHp7MrWIhekF3jI8lUXgLsJmLTkSUtsl3554ZtFb7tEBGT1ThcC0eYv
         +sj6KHPxY975ct1rBh22CFOoH8Ij/fIXgEyUGWCnTga/tYRdZyZ82980RC7Z9OVAllzz
         3xMch/mpGq/SqoHlTvQggN2YjjIb/OnUdvYEmmAwiU4DDFqSASHsjEwlGYgIDFiNWItF
         JsP4Bv+hLGBF+6/jSYP6NeVuB/YQ2s7w9XD+YORSAIH92rnZPf6SPMm6TCToigz79AUY
         cFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VL69OhOnAwL0XYVUd4iryHVhyGAPtRV3TIOYsddsZuM=;
        b=tCnx/Twq/3h2r23/0txUowkYqRexgICbddVhRmFRqOHa0vroiJl8K9wXDr83NgsZHj
         c/n9Wp5EjXc6Xj9YbOXtaPh1bEmQAVuOI8evBNzVOhMADHuCHhvabPLJLKXjN4fDfuN1
         5fxwz0nx73J2HotLh0HtKttWYSIZbg10zHMCQLH72W3/CkqzkHo6NkBon38JVk0K1Inm
         vLa10GaU+GBRuRRK/5+Qs4s5fAD9UbuZmRWUW9CP/8mIX39HAJWpGC5LxXM1rF7eEodg
         zfJZn1H8KFCK4Qp0qvWKmWf2uKyehikhLiS4K0WW49AAjYw74El7FAdfdMvf0AI1gaUy
         LnKg==
X-Gm-Message-State: APjAAAWNkWcPUNU9jbli2tHkcDS2l3Zfn2GLjf896QNsm3QS9pxvDpzy
        IZBLvpvLyETzvrDFWjEHn3E=
X-Google-Smtp-Source: APXvYqzmACaBuhqTBmjTQlnT6ChPMYf/ayBZCWzg3+/6P+IBtpm8+LChFsyMwzvH7PAmVCkELOrNWA==
X-Received: by 2002:a63:d002:: with SMTP id z2mr14374376pgf.364.1565290568086;
        Thu, 08 Aug 2019 11:56:08 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id p2sm135451554pfb.118.2019.08.08.11.56.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 11:56:07 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, sivanich@sgi.com,
        jhubbard@nvidia.com
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        william.kucharski@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [Linux-kernel-mentees][PATCH v4 1/1] sgi-gru: Remove *pte_lookup functions
Date:   Fri,  9 Aug 2019 00:25:55 +0530
Message-Id: <1565290555-14126-2-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565290555-14126-1-git-send-email-linux.bhar@gmail.com>
References: <1565290555-14126-1-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *pte_lookup functions can be removed and be easily replaced with
get_user_pages_fast functions. In the case of atomic lookup,
__get_user_pages_fast is used which does not fall back to slow
get_user_pages. get_user_pages_fast on the other hand tries to use
__get_user_pages_fast but fallbacks to slow get_user_pages if
__get_user_pages_fast fails.

Also unnecessary ifdefs to check for CONFIG_HUGETLB is removed as the
check is redundant.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
This is a fold of the 3 patches in the v2 patch series.
The review tags were given to the individual patches.

Changes since v3
	- Used gup flags in get_user_pages_fast rather than
	boolean flags.
---
 drivers/misc/sgi-gru/grufault.c | 112 +++++++++-------------------------------
 1 file changed, 24 insertions(+), 88 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 4b713a8..304e9c5 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -166,96 +166,20 @@ static void get_clear_fault_map(struct gru_state *gru,
 }
 
 /*
- * Atomic (interrupt context) & non-atomic (user context) functions to
- * convert a vaddr into a physical address. The size of the page
- * is returned in pageshift.
- * 	returns:
- * 		  0 - successful
- * 		< 0 - error code
- * 		  1 - (atomic only) try again in non-atomic context
- */
-static int non_atomic_pte_lookup(struct vm_area_struct *vma,
-				 unsigned long vaddr, int write,
-				 unsigned long *paddr, int *pageshift)
-{
-	struct page *page;
-
-#ifdef CONFIG_HUGETLB_PAGE
-	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
-#else
-	*pageshift = PAGE_SHIFT;
-#endif
-	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
-		return -EFAULT;
-	*paddr = page_to_phys(page);
-	put_page(page);
-	return 0;
-}
-
-/*
- * atomic_pte_lookup
+ * mmap_sem is already helod on entry to this function. This guarantees
+ * existence of the page tables.
  *
- * Convert a user virtual address to a physical address
  * Only supports Intel large pages (2MB only) on x86_64.
- *	ZZZ - hugepage support is incomplete
- *
- * NOTE: mmap_sem is already held on entry to this function. This
- * guarantees existence of the page tables.
+ *	ZZZ - hugepage support is incomplete.
  */
-static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
-	int write, unsigned long *paddr, int *pageshift)
-{
-	pgd_t *pgdp;
-	p4d_t *p4dp;
-	pud_t *pudp;
-	pmd_t *pmdp;
-	pte_t pte;
-
-	pgdp = pgd_offset(vma->vm_mm, vaddr);
-	if (unlikely(pgd_none(*pgdp)))
-		goto err;
-
-	p4dp = p4d_offset(pgdp, vaddr);
-	if (unlikely(p4d_none(*p4dp)))
-		goto err;
-
-	pudp = pud_offset(p4dp, vaddr);
-	if (unlikely(pud_none(*pudp)))
-		goto err;
-
-	pmdp = pmd_offset(pudp, vaddr);
-	if (unlikely(pmd_none(*pmdp)))
-		goto err;
-#ifdef CONFIG_X86_64
-	if (unlikely(pmd_large(*pmdp)))
-		pte = *(pte_t *) pmdp;
-	else
-#endif
-		pte = *pte_offset_kernel(pmdp, vaddr);
-
-	if (unlikely(!pte_present(pte) ||
-		     (write && (!pte_write(pte) || !pte_dirty(pte)))))
-		return 1;
-
-	*paddr = pte_pfn(pte) << PAGE_SHIFT;
-#ifdef CONFIG_HUGETLB_PAGE
-	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
-#else
-	*pageshift = PAGE_SHIFT;
-#endif
-	return 0;
-
-err:
-	return 1;
-}
-
 static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
 		    int write, int atomic, unsigned long *gpa, int *pageshift)
 {
 	struct mm_struct *mm = gts->ts_mm;
 	struct vm_area_struct *vma;
 	unsigned long paddr;
-	int ret, ps;
+	int ret;
+	struct page *page;
 
 	vma = find_vma(mm, vaddr);
 	if (!vma)
@@ -263,21 +187,33 @@ static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
 
 	/*
 	 * Atomic lookup is faster & usually works even if called in non-atomic
-	 * context.
+	 * context. get_user_pages_fast does atomic lookup before falling back to
+	 * slow gup.
 	 */
 	rmb();	/* Must/check ms_range_active before loading PTEs */
-	ret = atomic_pte_lookup(vma, vaddr, write, &paddr, &ps);
-	if (ret) {
-		if (atomic)
+	if (atomic) {
+		ret = __get_user_pages_fast(vaddr, 1, write, &page);
+		if (!ret)
 			goto upm;
-		if (non_atomic_pte_lookup(vma, vaddr, write, &paddr, &ps))
+	} else {
+		ret = get_user_pages_fast(vaddr, 1, write ? FOLL_WRITE : 0, &page);
+		if (!ret)
 			goto inval;
 	}
+
+	paddr = page_to_phys(page);
+	put_user_page(page);
+
+	if (unlikely(is_vm_hugetlb_page(vma)))
+		*pageshift = HPAGE_SHIFT;
+	else
+		*pageshift = PAGE_SHIFT;
+
 	if (is_gru_paddr(paddr))
 		goto inval;
-	paddr = paddr & ~((1UL << ps) - 1);
+	paddr = paddr & ~((1UL << *pageshift) - 1);
 	*gpa = uv_soc_phys_ram_to_gpa(paddr);
-	*pageshift = ps;
+
 	return VTOP_SUCCESS;
 
 inval:
-- 
2.7.4

