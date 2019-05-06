Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACD4C04AAE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0242087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LoSYKvlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfEFGf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:35:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfEFGf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:35:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x466YIuK4032620
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 5 May 2019 23:34:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x466YIuK4032620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557124459;
        bh=CUpNcCDQKx6zVxA8dzYrnmmnbZzGtNKCPc406O4qvLU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LoSYKvlcp0Q7sC79s+mUN4r+tMAWDt5l25MqzogBZppAjfUwz4OBODltVWZPHBZHu
         NLrohnl44WJwmHc2nNwmqDEgt9AUdSaIi/KohJxROm1o5h7cK4xC0h7DT2aSJP9Ng3
         Tkhb9bhE7vBXRYN1Px42/LfqsrYXweN/bhv6Z7eMPqoPmM56bWDbNokD9MNMd3cjv+
         T4AWbkcPmHaGyfcHsMkexRoigvhjHB3oDt6f0c2sW3Fbnb9/W2AUyAOiaKZuwHV3Nw
         apNRkt/P3H9ATzJU2izJ39/cK/SMDw3J1S9Npwxzm2GUMqnCstGznuuaF+drAV08fp
         f7xIa22UutMlQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x466YGML4032617;
        Sun, 5 May 2019 23:34:16 -0700
Date:   Sun, 5 May 2019 23:34:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-caa841360134f863987f2d4f77b8dc2fbb7596f8@git.kernel.org>
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        luto@kernel.org, bp@alien8.de, hpa@zytor.com, lkp@intel.com,
        dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com,
        mingo@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, nadav.amit@gmail.com, namit@vmware.com,
        tglx@linutronix.de, riel@surriel.com
Reply-To: hpa@zytor.com, dave.hansen@linux.intel.com, lkp@intel.com,
          rick.p.edgecombe@intel.com, sfr@canb.auug.org.au,
          linux-kernel@vger.kernel.org, luto@kernel.org, bp@alien8.de,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          nadav.amit@gmail.com, namit@vmware.com, riel@surriel.com,
          mingo@kernel.org, peterz@infradead.org
In-Reply-To: <20190505011124.39692-1-namit@vmware.com>
References: <20190505011124.39692-1-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Initialize PGD cache during mm initialization
Git-Commit-ID: caa841360134f863987f2d4f77b8dc2fbb7596f8
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

Commit-ID:  caa841360134f863987f2d4f77b8dc2fbb7596f8
Gitweb:     https://git.kernel.org/tip/caa841360134f863987f2d4f77b8dc2fbb7596f8
Author:     Nadav Amit <nadav.amit@gmail.com>
AuthorDate: Sat, 4 May 2019 18:11:24 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 5 May 2019 20:32:46 +0200

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
 arch/x86/mm/pgtable.c         | 10 ++++++----
 include/asm-generic/pgtable.h |  2 ++
 init/main.c                   |  3 +++
 3 files changed, 11 insertions(+), 4 deletions(-)

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
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index fa782fba51ee..75d9d68a6de7 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1126,6 +1126,8 @@ int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 static inline void init_espfix_bsp(void) { }
 #endif
 
+extern void __init pgd_cache_init(void);
+
 #ifndef __HAVE_ARCH_PFN_MODIFY_ALLOWED
 static inline bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
 {
diff --git a/init/main.c b/init/main.c
index 95dd9406ee31..9dc2f3b4f753 100644
--- a/init/main.c
+++ b/init/main.c
@@ -506,6 +506,8 @@ void __init __weak mem_encrypt_init(void) { }
 
 void __init __weak poking_init(void) { }
 
+void __init __weak pgd_cache_init(void) { }
+
 bool initcall_debug;
 core_param(initcall_debug, initcall_debug, bool, 0644);
 
@@ -537,6 +539,7 @@ static void __init mm_init(void)
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
 	pti_init();
+	pgd_cache_init();
 }
 
 void __init __weak arch_call_rest_init(void)
