Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437FB218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QmvngLN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfC3LUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 07:20:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57452 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbfC3LU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:26 -0400
Received: from zn.tnic (p200300EC2F148A00C43C95AA310C833A.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:c43c:95aa:310c:833a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DC1D1EC08EF;
        Sat, 30 Mar 2019 12:20:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553944825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dh0C6P1g5dMwx3RmQzKwzVd0jl3+YH6hUBeTIxUetdc=;
        b=QmvngLN4Mo3IQOssCF184nKLSIRg0UxoFJVIJ6qWciUzoxoxFE6MxCgcXLrz3/RaPjJfiE
        uFxTQeAolMPSFgAR3rel7zxPxETJe53KMhIzq8kgd5a5EnTUj6lH+ZZMsft0VH28WE5SFj
        kt6SRAjeY8+XCsyy+SdQIa+gkacC9R8=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 4/5] x86/mm: Convert some slow-path static_cpu_has() callers to boot_cpu_has()
Date:   Sat, 30 Mar 2019 12:20:21 +0100
Message-Id: <20190330112022.28888-5-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190330112022.28888-1-bp@alien8.de>
References: <20190330112022.28888-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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
index 139b28a01ce4..5d27172c683f 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -626,7 +626,7 @@ static void pti_set_kernel_image_nonglobal(void)
  */
 void __init pti_init(void)
 {
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	pr_info("enabled\n");
-- 
2.21.0

