Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA7FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B3824676
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfLFNzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:55:13 -0500
Received: from foss.arm.com ([217.140.110.172]:44946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfLFNyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:54:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDF6711FB;
        Fri,  6 Dec 2019 05:54:35 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E2CA3F718;
        Fri,  6 Dec 2019 05:54:33 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v16 18/25] x86: mm+efi: Convert ptdump_walk_pgd_level() to take a mm_struct
Date:   Fri,  6 Dec 2019 13:53:09 +0000
Message-Id: <20191206135316.47703-19-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191206135316.47703-1-steven.price@arm.com>
References: <20191206135316.47703-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable x86 to use the generic walk_page_range() function, the
callers of ptdump_walk_pgd_level() need to pass an mm_struct rather
than the raw pgd_t pointer. Luckily since commit 7e904a91bf60
("efi: Use efi_mm in x86 as well as ARM") we now have an mm_struct
for EFI on x86.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/x86/include/asm/pgtable.h | 2 +-
 arch/x86/mm/dump_pagetables.c  | 4 ++--
 arch/x86/platform/efi/efi_32.c | 2 +-
 arch/x86/platform/efi/efi_64.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 8091a1c62596..5a30bf58156e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -29,7 +29,7 @@
 extern pgd_t early_top_pgt[PTRS_PER_PGD];
 int __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
 
-void ptdump_walk_pgd_level(struct seq_file *m, pgd_t *pgd);
+void ptdump_walk_pgd_level(struct seq_file *m, struct mm_struct *mm);
 void ptdump_walk_pgd_level_debugfs(struct seq_file *m, pgd_t *pgd, bool user);
 void ptdump_walk_pgd_level_checkwx(void);
 void ptdump_walk_user_pgd_level_checkwx(void);
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 4dc6f4df40af..24fe76325b31 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -567,9 +567,9 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 		pr_info("x86/mm: Checked W+X mappings: passed, no W+X pages found.\n");
 }
 
-void ptdump_walk_pgd_level(struct seq_file *m, pgd_t *pgd)
+void ptdump_walk_pgd_level(struct seq_file *m, struct mm_struct *mm)
 {
-	ptdump_walk_pgd_level_core(m, pgd, false, true);
+	ptdump_walk_pgd_level_core(m, mm->pgd, false, true);
 }
 
 void ptdump_walk_pgd_level_debugfs(struct seq_file *m, pgd_t *pgd, bool user)
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 9959657127f4..1616074075c3 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -49,7 +49,7 @@ void efi_sync_low_kernel_mappings(void) {}
 void __init efi_dump_pagetable(void)
 {
 #ifdef CONFIG_EFI_PGT_DUMP
-	ptdump_walk_pgd_level(NULL, swapper_pg_dir);
+	ptdump_walk_pgd_level(NULL, &init_mm);
 #endif
 }
 
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 08ce8177c3af..3cb63cd369d6 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -614,9 +614,9 @@ void __init efi_dump_pagetable(void)
 {
 #ifdef CONFIG_EFI_PGT_DUMP
 	if (efi_enabled(EFI_OLD_MEMMAP))
-		ptdump_walk_pgd_level(NULL, swapper_pg_dir);
+		ptdump_walk_pgd_level(NULL, &init_mm);
 	else
-		ptdump_walk_pgd_level(NULL, efi_mm.pgd);
+		ptdump_walk_pgd_level(NULL, &efi_mm);
 #endif
 }
 
-- 
2.20.1

