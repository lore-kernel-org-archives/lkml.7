Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C283C41517
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A063229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuwmBoyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfGXLlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:41:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35992 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfGXLlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:41:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so21104501pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/B7iS7twoHuFiN2Sq9UrpmOirWTgDsR38WI+eokeIw=;
        b=nuwmBoyk/4mjKCCvHAMVDXxEHZeOXfghybqdlk45TABHI4NUxhZ7qZwTt4dgyuKVLk
         FdDuimPLodOe8X9r/jmApQ7hICQ2IjRf0du84YnIZK7DyFIncOglG/om0sL0N3Q7irou
         odpU3/NHnGVesgsh+LUJ3gU2qlBu0HUuj0dB/IVHsAQSalNpQstuQw9Rj9a+ibPlb8Mq
         4zCr9nj3e5eppuywNhUaSody/+rxS7Fyt1hQWYs+9lfgebNTWkb9Xg+m8jf9qQBUoUSI
         mhSFVpXKlTKpoVv/wQOx20JWHfTeApoEsLMG3H2PcnTnUqr5PMtCAprlqC0JQeu2QWu9
         7MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/B7iS7twoHuFiN2Sq9UrpmOirWTgDsR38WI+eokeIw=;
        b=c4LuzY+IxFqwnrpMx8sJAZceftqD0y7QV9SfP16sDFHoWWr+dKYi1pIendkZ1yHBBg
         f052Y/7mOq29l3REHrITm3Zn+HCcFCAPL+lBaIxJK0ODFfSsBofAHioxMFFfukXKuTYm
         6h4Md2skNguQV7/7BjppcWqqAzsk1tyJsqP+yuUH7rgi+FGFMRlVjDBPoh0aNljOJ8Iu
         L79DR3XNCs78+7hFdsUpXxJkiYyUx8UiKxYt8426fuPLy0ti4OmpS52/SPLb5IyVZNKC
         Fa1nnmZrj/Nqw1IPBMj2Lvc6zhNWceUVcboVXlZKqBvVN/nQzqZOY4IACIa9ERTgJH0u
         7JxA==
X-Gm-Message-State: APjAAAVUtC3jequmzxcwVD7sGyDBtaCw63G1COSF812Z27EGu8NI53qu
        TtxNrDxZ5L15OX6VH9tlxDc=
X-Google-Smtp-Source: APXvYqxyAvff4hzpbzMvBi/f0yE9LGLNcoyt7PgpRZOhB0FTxC0vLmHV/OJZGDPHCOMBdk5syS84iA==
X-Received: by 2002:aa7:957c:: with SMTP id x28mr10859669pfq.42.1563968504581;
        Wed, 24 Jul 2019 04:41:44 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id o14sm46177906pjp.29.2019.07.24.04.41.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jul 2019 04:41:44 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, arnd@arndb.de, jhubbard@nvidia.com
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH v2 3/3] sgi-gru: Use __get_user_pages_fast in atomic_pte_lookup
Date:   Wed, 24 Jul 2019 17:11:16 +0530
Message-Id: <1563968476-12785-4-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563968476-12785-1-git-send-email-linux.bhar@gmail.com>
References: <1563968476-12785-1-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*pte_lookup functions get the physical address for a given virtual
address by getting a physical page using gup and use page_to_phys to get
the physical address.

Currently, atomic_pte_lookup manually walks the page tables. If this
function fails to get a physical page, it will fall back too
non_atomic_pte_lookup to get a physical page which uses the slow gup
path to get the physical page.

Instead of manually walking the page tables use __get_user_pages_fast
which does the same thing and it does not fall back to the slow gup
path.

Also, the function atomic_pte_lookup's return value has been changed to boolean.
The callsites have been appropriately modified.

This is largely inspired from kvm code. kvm uses __get_user_pages_fast
in hva_to_pfn_fast function which can run in an atomic context.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v2
	- Modified the return value of atomic_pte_lookup
	to use booleans rather than numeric values.
	This was suggested by John Hubbard.
---
 drivers/misc/sgi-gru/grufault.c | 56 +++++++++++------------------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index bce47af..da2d2cc 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -193,9 +193,11 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
 }
 
 /*
- * atomic_pte_lookup
+ * atomic_pte_lookup() - Convert a user virtual address 
+ * to a physical address.
+ * @Return: true for success, false for failure. Failure means that
+ * the page could not be pinned via gup fast.
  *
- * Convert a user virtual address to a physical address
  * Only supports Intel large pages (2MB only) on x86_64.
  *	ZZZ - hugepage support is incomplete
  *
@@ -205,49 +207,20 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
 static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
 	int write, unsigned long *paddr, int *pageshift)
 {
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
+	struct page *page;
 
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		*pageshift = HPAGE_SHIFT;
 	else
 		*pageshift = PAGE_SHIFT;
 
-	return 0;
+	if (!__get_user_pages_fast(vaddr, 1, write, &page))
+		return false;
 
-err:
-	return 1;
+	*paddr = page_to_phys(page);
+	put_user_page(page);
+
+	return true;
 }
 
 static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
@@ -256,7 +229,8 @@ static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
 	struct mm_struct *mm = gts->ts_mm;
 	struct vm_area_struct *vma;
 	unsigned long paddr;
-	int ret, ps;
+	int ps;
+	bool success;
 
 	vma = find_vma(mm, vaddr);
 	if (!vma)
@@ -267,8 +241,8 @@ static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
 	 * context.
 	 */
 	rmb();	/* Must/check ms_range_active before loading PTEs */
-	ret = atomic_pte_lookup(vma, vaddr, write, &paddr, &ps);
-	if (ret) {
+	success = atomic_pte_lookup(vma, vaddr, write, &paddr, &ps);
+	if (!success) {
 		if (atomic)
 			goto upm;
 		if (non_atomic_pte_lookup(vma, vaddr, write, &paddr, &ps))
-- 
2.7.4

