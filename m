Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C1C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB642218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfB1Afi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:35:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbfB1Afi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:35:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCA5030BEE27;
        Thu, 28 Feb 2019 00:35:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E825E619D2;
        Thu, 28 Feb 2019 00:35:31 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/2] x86/mm/KASLR: Only build one PUD entry of area for real mode trampoline
Date:   Thu, 28 Feb 2019 08:35:21 +0800
Message-Id: <20190228003522.9957-2-bhe@redhat.com>
In-Reply-To: <20190228003522.9957-1-bhe@redhat.com>
References: <20190228003522.9957-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 28 Feb 2019 00:35:37 +0000 (UTC)
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
 arch/x86/mm/kaslr.c | 82 +++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 754b5da91d43..131e08a10a68 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -226,74 +226,68 @@ void __init kernel_randomize_memory(void)
 
 static void __meminit init_trampoline_pud(void)
 {
-	unsigned long paddr, paddr_next;
+	unsigned long paddr, vaddr;
 	pgd_t *pgd;
-	pud_t *pud_page, *pud_page_tramp;
-	int i;
+
+	pud_t *pud_page, *pud_page_tramp, *pud, *pud_tramp;
 
 	pud_page_tramp = alloc_low_page();
 
 	paddr = 0;
+	vaddr = (unsigned long)__va(paddr);
 	pgd = pgd_offset_k((unsigned long)__va(paddr));
-	pud_page = (pud_t *) pgd_page_vaddr(*pgd);
-
-	for (i = pud_index(paddr); i < PTRS_PER_PUD; i++, paddr = paddr_next) {
-		pud_t *pud, *pud_tramp;
-		unsigned long vaddr = (unsigned long)__va(paddr);
 
-		pud_tramp = pud_page_tramp + pud_index(paddr);
-		pud = pud_page + pud_index(vaddr);
-		paddr_next = (paddr & PUD_MASK) + PUD_SIZE;
-
-		*pud_tramp = *pud;
-	}
+	if (pgtable_l5_enabled()) {
+		p4d_t *p4d_page, *p4d_page_tramp, *p4d, *p4d_tramp;

+		p4d_page_tramp = alloc_low_page();
 
-	set_pgd(&trampoline_pgd_entry,
-		__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
-}
+		p4d_page = (p4d_t *) pgd_page_vaddr(*pgd);
+		p4d = p4d_page + p4d_index(vaddr);
 
-static void __meminit init_trampoline_p4d(void)
-{
-	unsigned long paddr, paddr_next;
-	pgd_t *pgd;
-	p4d_t *p4d_page, *p4d_page_tramp;
-	int i;
+		pud_page = (pud_t *) p4d_page_vaddr(*p4d);
+		pud = pud_page + pud_index(vaddr);
 
-	p4d_page_tramp = alloc_low_page();
+		p4d_tramp = p4d_page_tramp + p4d_index(paddr);
+		pud_tramp = pud_page_tramp + pud_index(paddr);
 
-	paddr = 0;
-	pgd = pgd_offset_k((unsigned long)__va(paddr));
-	p4d_page = (p4d_t *) pgd_page_vaddr(*pgd);
+		*pud_tramp = *pud;
 
-	for (i = p4d_index(paddr); i < PTRS_PER_P4D; i++, paddr = paddr_next) {
-		p4d_t *p4d, *p4d_tramp;
-		unsigned long vaddr = (unsigned long)__va(paddr);
+		set_p4d(p4d_tramp,
+			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
 
-		p4d_tramp = p4d_page_tramp + p4d_index(paddr);
-		p4d = p4d_page + p4d_index(vaddr);
-		paddr_next = (paddr & P4D_MASK) + P4D_SIZE;
+		set_pgd(&trampoline_pgd_entry,
+			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
+	} else {
+		pud_page = (pud_t *) pgd_page_vaddr(*pgd);
+		pud = pud_page + pud_index(vaddr);
 
-		*p4d_tramp = *p4d;
+		pud_tramp = pud_page_tramp + pud_index(paddr);
+		*pud_tramp = *pud;
+		set_pgd(&trampoline_pgd_entry,
+			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
 	}
-
-	set_pgd(&trampoline_pgd_entry,
-		__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
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

