Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239ADC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF942146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDEUUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:20:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42255 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDEUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:20:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35KJHp72896064
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 13:19:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35KJGXu2896061;
        Fri, 5 Apr 2019 13:19:16 -0700
Date:   Fri, 5 Apr 2019 13:19:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-0925dda5962e9b55e4d38a72eba93858f24bac41@git.kernel.org>
Cc:     hpa@zytor.com, kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        bhe@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: bhe@redhat.com, tglx@linutronix.de,
          kirill.shutemov@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190308025616.21440-2-bhe@redhat.com>
References: <20190308025616.21440-2-bhe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/KASLR: Use only one PUD entry for real mode
 trampoline
Git-Commit-ID: 0925dda5962e9b55e4d38a72eba93858f24bac41
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0925dda5962e9b55e4d38a72eba93858f24bac41
Gitweb:     https://git.kernel.org/tip/0925dda5962e9b55e4d38a72eba93858f24bac41
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Fri, 8 Mar 2019 10:56:15 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 5 Apr 2019 22:13:00 +0200

x86/mm/KASLR: Use only one PUD entry for real mode trampoline

The current code builds identity mapping for the real mode trampoline by
borrowing page tables from the direct mapping section if KASLR is
enabled. It copies present entries of the first PUD table in 4-level paging
mode, or the first P4D table in 5-level paging mode.

However, there's only a very small area under low 1 MB reserved for the
real mode trampoline in reserve_real_mode() so it makes no sense to build
up a really large mapping for it.

Reduce it to one PUD (1GB) entry. This matches the randomization
granularity in 4-level paging mode and allows to change the randomization
granularity in 5-level paging mode from 512GB to 1GB later.

[ tglx: Massaged changelog and comments ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: keescook@chromium.org
Cc: thgarnie@google.com
Link: https://lkml.kernel.org/r/20190308025616.21440-2-bhe@redhat.com

---
 arch/x86/mm/kaslr.c | 84 +++++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 47 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 3f452ffed7e9..97813751340d 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -147,74 +147,64 @@ void __init kernel_randomize_memory(void)
 
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
+	 * There are two mappings for the low 1MB area, the direct mapping
+	 * and the 1:1 mapping for the real mode trampoline:
+	 *
+	 * Direct mapping: virt_addr = phys_addr + PAGE_OFFSET
+	 * 1:1 mapping:    virt_addr = phys_addr
+	 */
 	paddr = 0;
-	pgd = pgd_offset_k((unsigned long)__va(paddr));
-	pud_page = (pud_t *) pgd_page_vaddr(*pgd);
-
-	for (i = pud_index(paddr); i < PTRS_PER_PUD; i++, paddr = paddr_next) {
-		pud_t *pud, *pud_tramp;
-		unsigned long vaddr = (unsigned long)__va(paddr);
+	vaddr = (unsigned long)__va(paddr);
+	pgd = pgd_offset_k(vaddr);
 
-		pud_tramp = pud_page_tramp + pud_index(paddr);
-		pud = pud_page + pud_index(vaddr);
-		paddr_next = (paddr & PUD_MASK) + PUD_SIZE;
-
-		*pud_tramp = *pud;
-	}
+	p4d = p4d_offset(pgd, vaddr);
+	pud = pud_offset(p4d, vaddr);
 
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
+	pud_tramp = pud_page_tramp + pud_index(paddr);
+	*pud_tramp = *pud;
 
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
+ * The real mode trampoline, which is required for bootstrapping CPUs
+ * occupies only a small area under the low 1MB.  See reserve_real_mode()
+ * for details.
+ *
+ * If KASLR is disabled the first PGD entry of the direct mapping is copied
+ * to map the real mode trampoline.
+ *
+ * If KASLR is enabled, copy only the PUD which covers the low 1MB
+ * area. This limits the randomization granularity to 1GB for both 4-level
+ * and 5-level paging.
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
