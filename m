Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B055C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EACE206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDHOa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:30:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDHOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:30:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x38EUWxr4101104
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 8 Apr 2019 07:30:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x38EUWd74101101;
        Mon, 8 Apr 2019 07:30:32 -0700
Date:   Mon, 8 Apr 2019 07:30:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-28e3ace70c3d2ea47a62dffe046011d1b74ee839@git.kernel.org>
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, bp@suse.de, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@kernel.org, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, luto@kernel.org, bp@suse.de, mingo@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, dave.hansen@linux.intel.com
In-Reply-To: <20190330112022.28888-5-bp@alien8.de>
References: <20190330112022.28888-5-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/mm: Convert some slow-path static_cpu_has()
 callers to boot_cpu_has()
Git-Commit-ID: 28e3ace70c3d2ea47a62dffe046011d1b74ee839
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

Commit-ID:  28e3ace70c3d2ea47a62dffe046011d1b74ee839
Gitweb:     https://git.kernel.org/tip/28e3ace70c3d2ea47a62dffe046011d1b74ee839
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 29 Mar 2019 20:00:38 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 8 Apr 2019 12:14:16 +0200

x86/mm: Convert some slow-path static_cpu_has() callers to boot_cpu_has()

Using static_cpu_has() is pointless on those paths, convert them to the
boot_cpu_has() variant.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190330112022.28888-5-bp@alien8.de
---
 arch/x86/mm/dump_pagetables.c | 4 ++--
 arch/x86/mm/pgtable.c         | 4 ++--
 arch/x86/mm/pti.c             | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index ee8f8ab46941..7b71ac15b235 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -577,7 +577,7 @@ void ptdump_walk_pgd_level(struct seq_file *m, pgd_t *pgd)
 void ptdump_walk_pgd_level_debugfs(struct seq_file *m, pgd_t *pgd, bool user)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-	if (user && static_cpu_has(X86_FEATURE_PTI))
+	if (user && boot_cpu_has(X86_FEATURE_PTI))
 		pgd = kernel_to_user_pgdp(pgd);
 #endif
 	ptdump_walk_pgd_level_core(m, pgd, false, false);
@@ -590,7 +590,7 @@ void ptdump_walk_user_pgd_level_checkwx(void)
 	pgd_t *pgd = INIT_PGD;
 
 	if (!(__supported_pte_mask & _PAGE_NX) ||
-	    !static_cpu_has(X86_FEATURE_PTI))
+	    !boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	pr_info("x86/mm: Checking user space page tables\n");
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7bd01709a091..3dbf440d4114 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -190,7 +190,7 @@ static void pgd_dtor(pgd_t *pgd)
  * when PTI is enabled. We need them to map the per-process LDT into the
  * user-space page-table.
  */
-#define PREALLOCATED_USER_PMDS	 (static_cpu_has(X86_FEATURE_PTI) ? \
+#define PREALLOCATED_USER_PMDS	 (boot_cpu_has(X86_FEATURE_PTI) ? \
 					KERNEL_PGD_PTRS : 0)
 #define MAX_PREALLOCATED_USER_PMDS KERNEL_PGD_PTRS
 
@@ -292,7 +292,7 @@ static void pgd_mop_up_pmds(struct mm_struct *mm, pgd_t *pgdp)
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	pgdp = kernel_to_user_pgdp(pgdp);
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4fee5c3003ed..8c9a54ebda60 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -626,7 +626,7 @@ void pti_set_kernel_image_nonglobal(void)
  */
 void __init pti_init(void)
 {
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	pr_info("enabled\n");
