Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8001FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4789E20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfCHC4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:56:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfCHC4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:56:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC8EA5945E;
        Fri,  8 Mar 2019 02:56:29 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F02175D9E1;
        Fri,  8 Mar 2019 02:56:23 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 1/2] x86/mm/KASLR: Only build one PUD entry of area for real mode trampoline
Date:   Fri,  8 Mar 2019 10:56:15 +0800
Message-Id: <20190308025616.21440-2-bhe@redhat.com>
In-Reply-To: <20190308025616.21440-1-bhe@redhat.com>
References: <20190308025616.21440-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 08 Mar 2019 02:56:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/x86/mm/kaslr.c | 88 +++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 47 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 3f452ffed7e9..8bd4192c68b9 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -147,74 +147,68 @@ void __init kernel_randomize_memory(void)
 
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
 
+	/*
+	 * There are two kinds of mapping in the handling for the same
+	 * place of low 1 MB area. They are the direct mapping and the
+	 * 1:1 mapping for real mode trampoline.
+	 * ------------------------------------------------------------
+	 * Kind             Physical address    Virtual address
+	 * Direct mapping   paddr               vaddr=paddr+PAGE_OFFSET
+	 * 1:1 mapping      paddr               paddr
+	 */
 	paddr = 0;
-	pgd = pgd_offset_k((unsigned long)__va(paddr));
-	pud_page = (pud_t *) pgd_page_vaddr(*pgd);
-
-	for (i = pud_index(paddr); i < PTRS_PER_PUD; i++, paddr = paddr_next) {
-		pud_t *pud, *pud_tramp;
-		unsigned long vaddr = (unsigned long)__va(paddr);
-
-		pud_tramp = pud_page_tramp + pud_index(paddr);
-		pud = pud_page + pud_index(vaddr);
-		paddr_next = (paddr & PUD_MASK) + PUD_SIZE;
-
-		*pud_tramp = *pud;
-	}
-
-	set_pgd(&trampoline_pgd_entry,
-		__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
-}
+	vaddr = (unsigned long)__va(paddr);
+	pgd = pgd_offset_k(vaddr);
 
-static void __meminit init_trampoline_p4d(void)
-{
-	unsigned long paddr, paddr_next;
-	pgd_t *pgd;
-	p4d_t *p4d_page, *p4d_page_tramp;
-	int i;
+	p4d = p4d_offset(pgd, vaddr);
+	pud = pud_offset(p4d, vaddr);
 
-	p4d_page_tramp = alloc_low_page();
-
-	paddr = 0;
-	pgd = pgd_offset_k((unsigned long)__va(paddr));
-	p4d_page = (p4d_t *) pgd_page_vaddr(*pgd);
+	pud_tramp = pud_page_tramp + pud_index(paddr);
+	*pud_tramp = *pud;
 
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

