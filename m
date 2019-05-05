Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F55C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 10:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F0C2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 10:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MSzGsq6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfEEKvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 06:51:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43061 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEEKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 06:51:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x45AotAX3629706
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 5 May 2019 03:50:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x45AotAX3629706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557053456;
        bh=8TPIZylbEnLDqrVeEidBlaV2naJ2/HoZTlL2u/51r9o=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MSzGsq6C0HMwtF/+3/URebRqu0S8LHOHvZVJRwIqltZsyXGo4IHRAfFki+aspiBjq
         o/pJ32X1H179QYZE2KtE2DgMjiZh12qwl/0iFNwza/omkKAEkxlNXuMXqhfsVLwg6r
         Yf18n/nslmrKAjhEtzyKhZVeRUTMAEKHbMZDbA0k4OWSVxcSm884BO+11Z6FyYy1vM
         LALHiZck7yyYpaE1CV5vFmVNg/DNpUZLNwc9xDTrgMG4OSQM0L1qP/NbJIsQjbazqE
         TwUN7vyBTkB8f2mx/LAtB8Zq1KlCGI2a97ww68DwwD+NLyG97aQycKFBCdIr8HFU9N
         LM5DnZpIWAlog==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x45AonSx3629697;
        Sun, 5 May 2019 03:50:49 -0700
Date:   Sun, 5 May 2019 03:50:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-ef5f22b4e5caf7e5ac12b28d4c9566c95d709ba5@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        peterz@infradead.org, tglx@linutronix.de, namit@vmware.com,
        torvalds@linux-foundation.org, hpa@zytor.com, lkp@intel.com,
        rick.p.edgecombe@intel.com, nadav.amit@gmail.com,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@kernel.org,
        riel@surriel.com, luto@kernel.org
Reply-To: riel@surriel.com, luto@kernel.org, nadav.amit@gmail.com,
          dave.hansen@linux.intel.com, mingo@kernel.org, bp@alien8.de,
          lkp@intel.com, rick.p.edgecombe@intel.com, namit@vmware.com,
          tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
          hpa@zytor.com, torvalds@linux-foundation.org
In-Reply-To: <20190505011124.39692-1-namit@vmware.com>
References: <20190505011124.39692-1-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Initialize PGD cache during mm initialization
Git-Commit-ID: ef5f22b4e5caf7e5ac12b28d4c9566c95d709ba5
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

Commit-ID:  ef5f22b4e5caf7e5ac12b28d4c9566c95d709ba5
Gitweb:     https://git.kernel.org/tip/ef5f22b4e5caf7e5ac12b28d4c9566c95d709ba5
Author:     Nadav Amit <nadav.amit@gmail.com>
AuthorDate: Sat, 4 May 2019 18:11:24 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 5 May 2019 12:43:13 +0200

x86/mm: Initialize PGD cache during mm initialization

Poking-mm initialization might require to duplicate the PGD in early
stage. Initialize the PGD cache earlier to prevent boot failures.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 4fc19708b165 ("x86/alternatives: Initialize temporary mm for patching")
Link: http://lkml.kernel.org/r/20190505011124.39692-1-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable.h |  1 +
 arch/x86/mm/pgtable.c          | 10 ++++++----
 init/main.c                    |  1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 702db5904753..d488b3053330 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1010,6 +1010,7 @@ static inline int pgd_none(pgd_t pgd)
 
 extern int direct_gbpages;
 void init_mem_mapping(void);
+void pgd_cache_init(void);
 void early_alloc_pgt_buf(void);
 extern void memblock_find_dma_reserve(void);
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7bd01709a091..c8177045b7d4 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -373,14 +373,14 @@ static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
 
 static struct kmem_cache *pgd_cache;
 
-static int __init pgd_cache_init(void)
+void __init pgd_cache_init(void)
 {
 	/*
 	 * When PAE kernel is running as a Xen domain, it does not use
 	 * shared kernel pmd. And this requires a whole page for pgd.
 	 */
 	if (!SHARED_KERNEL_PMD)
-		return 0;
+		return;
 
 	/*
 	 * when PAE kernel is not running as a Xen domain, it uses
@@ -390,9 +390,7 @@ static int __init pgd_cache_init(void)
 	 */
 	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_ALIGN,
 				      SLAB_PANIC, NULL);
-	return 0;
 }
-core_initcall(pgd_cache_init);
 
 static inline pgd_t *_pgd_alloc(void)
 {
@@ -420,6 +418,10 @@ static inline void _pgd_free(pgd_t *pgd)
 }
 #else
 
+void __init pgd_cache_init(void)
+{
+}
+
 static inline pgd_t *_pgd_alloc(void)
 {
 	return (pgd_t *)__get_free_pages(PGALLOC_GFP, PGD_ALLOCATION_ORDER);
diff --git a/init/main.c b/init/main.c
index 95dd9406ee31..1d1cb8f10cad 100644
--- a/init/main.c
+++ b/init/main.c
@@ -537,6 +537,7 @@ static void __init mm_init(void)
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
 	pti_init();
+	pgd_cache_init();
 }
 
 void __init __weak arch_call_rest_init(void)
