Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F5C76197
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 15:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833E82083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 15:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODLroZ/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfGUP6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 11:58:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37801 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfGUP6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 11:58:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so16180051pfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mu8trQVZC3rHCOtMYrCUpgRKCETCP3JlFKLgFP5GMsg=;
        b=ODLroZ/h+hP6Y33PcgSXD4q2Uc8RcP/LdSQozj6vnDx90z1Mq6K/foEe5nz7ZE2BPd
         yYZAMSLyYG3vQ0iOmeXcDLNnWfNQH4g6AMONx5mDjWIdel6bpziU1NAHYdyK2pZ378Rr
         FZ2ZeYBK/Uor03e7IT/JubBVBKBTHhPcV8cRRS95AnmkWrOA5HCwpl5IfUJ32bAZkYFy
         kLT059ALWFeHtBbDtT1ZXSm/q583gn6n+Z++Kw7Pm61/vOy0/vDZ6m9Jy6b1Uk8C8yb2
         wMujseQCu+jXWT0qW/n5t4vm67DuuywYUODpEzZ8ow7y4QxZPfogWyGgMHcWonCunkUn
         phfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mu8trQVZC3rHCOtMYrCUpgRKCETCP3JlFKLgFP5GMsg=;
        b=M89FVjbMKUfIOBkzpxJ+vxht/HLc+i71aRloYgQ+chThaFwTJCBErwF2n2yyrqA+yp
         +0vcGGmNDXYANq4NMXbrPda23VZAZVxTA40rrkoB3wJGnBdFSY5WwedixZxzNitTbLZn
         3EWMhuWw/mIuDBDRhqEXxrAtAUD36Xp6x4xisGMv4TFj2iIuo89sz7ImYng4akFDflH0
         L3ek5tH9fLT1yr6M3KMa8EFKjM/s/AGYAURYovpv4wc3ENvxqhQs+WwhsWz8rPQ5PHZa
         3OhNaq9SOO0gtAN7TUt1NQeG8ecxSXbDxB7VMSmwt1RznAKMQMdRg4AGDq/nMLjwR1+N
         9xXg==
X-Gm-Message-State: APjAAAVtX/Hpmsq6sHYJ8hk9of0SFkF2uCXUgbGcZ9UI/ISmKFCmZQbR
        yUg7ytC+/z+P3VApjYfvufU=
X-Google-Smtp-Source: APXvYqwC3lbzN6ZeQmPUeK90Wp81J3UzSILb/l6kA0SmEh/tiLeanHZIQoe+bvHFOO1ZCx7hgtXRQg==
X-Received: by 2002:a17:90a:bf08:: with SMTP id c8mr71922342pjs.75.1563724710070;
        Sun, 21 Jul 2019 08:58:30 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id w22sm38827754pfi.175.2019.07.21.08.58.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jul 2019 08:58:29 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     arnd@arndb.de, sivanich@sgi.com, gregkh@linuxfoundation.org
Cc:     ira.weiny@intel.com, jhubbard@nvidia.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH 3/3] sgi-gru: Use __get_user_pages_fast in atomic_pte_lookup
Date:   Sun, 21 Jul 2019 21:28:05 +0530
Message-Id: <1563724685-6540-4-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
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

This is largely inspired from kvm code. kvm uses __get_user_pages_fast
in hva_to_pfn_fast function which can run in an atomic context.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/misc/sgi-gru/grufault.c | 39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 75108d2..121c9a4 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -202,46 +202,17 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
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
+	struct page *page;
 
-	pmdp = pmd_offset(pudp, vaddr);
-	if (unlikely(pmd_none(*pmdp)))
-		goto err;
-#ifdef CONFIG_X86_64
-	if (unlikely(pmd_large(*pmdp)))
-		pte = *(pte_t *) pmdp;
-	else
-#endif
-		pte = *pte_offset_kernel(pmdp, vaddr);
+	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
 
-	if (unlikely(!pte_present(pte) ||
-		     (write && (!pte_write(pte) || !pte_dirty(pte)))))
+	if (!__get_user_pages_fast(vaddr, 1, write, &page))
 		return 1;
 
-	*paddr = pte_pfn(pte) << PAGE_SHIFT;
-
-	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
+	*paddr = page_to_phys(page);
+	put_user_page(page);
 
 	return 0;
-
-err:
-	return 1;
 }
 
 static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
-- 
2.7.4

