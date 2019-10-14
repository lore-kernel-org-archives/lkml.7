Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4D7ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69BD21835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbfJNQCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:02:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39438 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387788AbfJNQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:02:43 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iK2nu-0002uy-R5; Mon, 14 Oct 2019 18:02:38 +0200
Date:   Mon, 14 Oct 2019 18:02:38 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Frank Rowand <frank.rowand@am.sony.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] Revert "ARM: Initialize split page table locks for vector
 page"
Message-ID: <20191014160238.enawbbfcxnbdrlch@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm dropping this patch, with its original description:

|ARM: Initialize split page table locks for vector page
|
|Without this patch, ARM can not use SPLIT_PTLOCK_CPUS if
|PREEMPT_RT_FULL=y because vectors_user_mapping() creates a
|VM_ALWAYSDUMP mapping of the vector page (address 0xffff0000), but no
|ptl->lock has been allocated for the page.  An attempt to coredump
|that page will result in a kernel NULL pointer dereference when
|follow_page() attempts to lock the page.
|
|The call tree to the NULL pointer dereference is:
|
|   do_notify_resume()
|      get_signal_to_deliver()
|         do_coredump()
|            elf_core_dump()
|               get_dump_page()
|                  __get_user_pages()
|                     follow_page()
|                        pte_offset_map_lock() <----- a #define
|                           ...
|                              rt_spin_lock()
|
|The underlying problem is exposed by mm-shrink-the-page-frame-to-rt-size.patch.

The patch named mm-shrink-the-page-frame-to-rt-size.patch was dropped
from the RT queue once the SPLIT_PTLOCK_CPUS feature (in a slightly
different shape) went upstream (somewhere between v3.12 and v3.14).

I can see that the patch still allocates a lock which wasn't there
before. However I can't trigger a kernel oops like described in the
patch by triggering a coredump.

---
 arch/arm/kernel/process.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 1041300022177..f934a6739fc05 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -325,30 +325,6 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 }
 
 #ifdef CONFIG_MMU
-/*
- * CONFIG_SPLIT_PTLOCK_CPUS results in a page->ptl lock.  If the lock is not
- * initialized by pgtable_page_ctor() then a coredump of the vector page will
- * fail.
- */
-static int __init vectors_user_mapping_init_page(void)
-{
-	struct page *page;
-	unsigned long addr = 0xffff0000;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	pgd = pgd_offset_k(addr);
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
-	page = pmd_page(*(pmd));
-
-	pgtable_page_ctor(page);
-
-	return 0;
-}
-late_initcall(vectors_user_mapping_init_page);
-
 #ifdef CONFIG_KUSER_HELPERS
 /*
  * The vectors page is always readable from user space for the
-- 
2.23.0

