Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD92C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F87F20675
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388751AbfCAOpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:45:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfCAOpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:45:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D21FA0B9A;
        Fri,  1 Mar 2019 14:45:06 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D15460A9A;
        Fri,  1 Mar 2019 14:45:05 +0000 (UTC)
Date:   Fri, 1 Mar 2019 22:45:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v2 0/2] x86/mm/KASLR: Change the granularity of
 randomization to PUD size in 5-level
Message-ID: <20190301144502.GV14858@MiWiFi-R3L-srv>
References: <20190228003522.9957-1-bhe@redhat.com>
 <20190228091001.5wvkwe7cqkf2euzc@kshutemo-mobl1>
 <20190228092346.GQ14858@MiWiFi-R3L-srv>
 <20190228095503.jy44nwqhtmr4qeaq@kshutemo-mobl1>
 <20190228100419.GS14858@MiWiFi-R3L-srv>
 <20190228103051.dvqiy2slwwt56ag2@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228103051.dvqiy2slwwt56ag2@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 01 Mar 2019 14:45:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

I updated patch per your comments. While I kept the 'paddr' variable and
the '0' initilization stuffs. My thought is there are two kinds of mapping
in the handling, so keeping these names from old codes can make it more
understandable. What do you think?

Kind               Physical address            Virtual address
----------------------------------------------------------------
Direct mapping     paddr                vaddr = paddr+PAGE_OFFSET
1:1 mapping        paddr                    paddr

Thanks
Baoquan

From 52c6c80b2e3ffe153902800793c0e732c3c6bf1d Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Thu, 21 Feb 2019 11:46:59 +0800
Subject: [PATCH] x86/mm/KASLR: Only build one PUD entry of area for real mode
 trampoline

The current code builds identity mapping for real mode treampoline by
borrowing page tables from the direct mapping section if KASLR is
enabled. It will copy present entries of the first PUD table in 4-level
paging mode, or the first P4D table in 5-level paging mode.

However, there's only a very small area under low 1 MB reserved
for real mode trampoline in reserve_real_mode(). Makes no sense
to build up so large area of mapping for it. Since the randomization
granularity in 4-level is 1 GB, and 512 GB in 5-level, only copying
one PUD entry is enough.

Hence, only copy one PUD entry of area where physical address 0
resides. And this is preparation for later changing the randomization
granularity of 5-level paging mode from 512 GB to 1 GB.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 79 ++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 47 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 3f452ffed7e9..c6fab7a77439 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -147,74 +147,59 @@ void __init kernel_randomize_memory(void)
 
 static void __meminit init_trampoline_pud(void)
 {
-	unsigned long paddr, paddr_next;
+	pud_t *pud_page_tramp, *pud, *pud_tramp;
+	p4d_t *p4d_page_tramp, *p4d, *p4d_tramp;
+	unsigned long paddr, vaddr;
 	pgd_t *pgd;
-	pud_t *pud_page, *pud_page_tramp;
-	int i;
 
 	pud_page_tramp = alloc_low_page();
 
 	paddr = 0;
-	pgd = pgd_offset_k((unsigned long)__va(paddr));
-	pud_page = (pud_t *) pgd_page_vaddr(*pgd);
+	vaddr = (unsigned long)__va(paddr);
+	pgd = pgd_offset_k(vaddr);
 
-	for (i = pud_index(paddr); i < PTRS_PER_PUD; i++, paddr = paddr_next) {
-		pud_t *pud, *pud_tramp;
-		unsigned long vaddr = (unsigned long)__va(paddr);
+	p4d = p4d_offset(pgd, vaddr);
+	pud = pud_offset(p4d, vaddr);
 
-		pud_tramp = pud_page_tramp + pud_index(paddr);
-		pud = pud_page + pud_index(vaddr);
-		paddr_next = (paddr & PUD_MASK) + PUD_SIZE;
+	pud_tramp = pud_page_tramp + pud_index(paddr);
+	*pud_tramp = *pud;
 
-		*pud_tramp = *pud;
-	}
-
-	set_pgd(&trampoline_pgd_entry,
-		__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
-}
-
-static void __meminit init_trampoline_p4d(void)
-{
-	unsigned long paddr, paddr_next;
-	pgd_t *pgd;
-	p4d_t *p4d_page, *p4d_page_tramp;
-	int i;
-
-	p4d_page_tramp = alloc_low_page();
-
-	paddr = 0;
-	pgd = pgd_offset_k((unsigned long)__va(paddr));
-	p4d_page = (p4d_t *) pgd_page_vaddr(*pgd);
-
-	for (i = p4d_index(paddr); i < PTRS_PER_P4D; i++, paddr = paddr_next) {
-		p4d_t *p4d, *p4d_tramp;
-		unsigned long vaddr = (unsigned long)__va(paddr);
+	if (pgtable_l5_enabled()) {
+		p4d_page_tramp = alloc_low_page();
 
 		p4d_tramp = p4d_page_tramp + p4d_index(paddr);
-		p4d = p4d_page + p4d_index(vaddr);
-		paddr_next = (paddr & P4D_MASK) + P4D_SIZE;
 
-		*p4d_tramp = *p4d;
-	}
+		set_p4d(p4d_tramp,
+			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
 
-	set_pgd(&trampoline_pgd_entry,
-		__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
+		set_pgd(&trampoline_pgd_entry,
+			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
+	} else {
+		set_pgd(&trampoline_pgd_entry,
+			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
+	}
 }
 
 /*
- * Create PGD aligned trampoline table to allow real mode initialization
- * of additional CPUs. Consume only 1 low memory page.
+ * Real mode trampoline only occupies a small area under low 1 MB
+ * (please check codes in reserve_real_mode() for details). For
+ * APs' booting up, we just borrow as few page tables as possible
+ * from the direct physical mapping to build 1:1 mapping to cover
+ * that area. In case KASLR disabled, the 1st PGD entry of the
+ * direct mapping is copied directly. If KASLR is enabled, only
+ * copy the 1st PUD entry where physical address 0 resides since
+ * the granularity of randomization is PUD size in 4-level, and
+ * P4D size in 5-level.
+ *
+ * This consumes one low memory page in 4-level case, and extra one
+ * in 5-level.
  */
 void __meminit init_trampoline(void)
 {
-
 	if (!kaslr_memory_enabled()) {
 		init_trampoline_default();
 		return;
 	}
 
-	if (pgtable_l5_enabled())
-		init_trampoline_p4d();
-	else
-		init_trampoline_pud();
+	init_trampoline_pud();
 }
-- 
2.17.2

