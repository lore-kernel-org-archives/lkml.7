Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A44C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA1D21707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FhsXw04C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfD3LTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:19:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfD3LTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:19:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBJLnK1347253
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:19:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBJLnK1347253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623161;
        bh=qiyHdKUGyo4ls/qfu27xDCczeiXrhi8+4MhiF9kebk4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FhsXw04CvFmgdJbKYjuMMhDaeq2dkRrTsBx+HcbX9ffS28NR8kZ8RtgtjSvUcAuoQ
         0zLn9S5dyqwSq5ZVYW7msfSbj1DtH3kg1soE60TOwo7Dp75sNEaCXEH2ln9Dw0koqp
         PGriqj9dy3miShxrp0GjyCwbf5pUPa11QGt0HkX+n5CbCZ0XbDxKGXzuptv7/KDOI2
         LG6N5ckkuEoXXJHzNH2OHZMe8VlJlP8oiVuFuB+rTFg8Ou3ZELPGyKwAbe9oWG6N+0
         DUnPhWssxQPli4+ZBDVVRgH+oWtKs8eebreyL2+dbZyZ3QyIXHd3pajcW1WPN9ABZv
         rErAzjlAC1ugg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBJKPQ1347249;
        Tue, 30 Apr 2019 04:19:20 -0700
Date:   Tue, 30 Apr 2019 04:19:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-4fc19708b165c1c152fa1f12f6600e66184b7786@git.kernel.org>
Cc:     namit@vmware.com, torvalds@linux-foundation.org, hpa@zytor.com,
        mhiramat@kernel.org, riel@surriel.com, peterz@infradead.org,
        tglx@linutronix.de, bp@alien8.de, luto@kernel.org,
        keescook@chromium.org, dave.hansen@intel.com,
        rick.p.edgecombe@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: dave.hansen@intel.com, namit@vmware.com,
          torvalds@linux-foundation.org, keescook@chromium.org,
          riel@surriel.com, peterz@infradead.org, hpa@zytor.com,
          mhiramat@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
          luto@kernel.org, bp@alien8.de
In-Reply-To: <20190426232303.28381-8-nadav.amit@gmail.com>
References: <20190426232303.28381-8-nadav.amit@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/alternatives: Initialize temporary mm for patching
Git-Commit-ID: 4fc19708b165c1c152fa1f12f6600e66184b7786
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

Commit-ID:  4fc19708b165c1c152fa1f12f6600e66184b7786
Gitweb:     https://git.kernel.org/tip/4fc19708b165c1c152fa1f12f6600e66184b7786
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Fri, 26 Apr 2019 16:22:46 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:52 +0200

x86/alternatives: Initialize temporary mm for patching

To prevent improper use of the PTEs that are used for text patching, the
next patches will use a temporary mm struct. Initailize it by copying
the init mm.

The address that will be used for patching is taken from the lower area
that is usually used for the task memory. Doing so prevents the need to
frequently synchronize the temporary-mm (e.g., when BPF programs are
installed), since different PGDs are used for the task memory.

Finally, randomize the address of the PTEs to harden against exploits
that use these PTEs.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Cc: ard.biesheuvel@linaro.org
Cc: deneen.t.dock@intel.com
Cc: kernel-hardening@lists.openwall.com
Cc: kristen@linux.intel.com
Cc: linux_dti@icloud.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190426232303.28381-8-nadav.amit@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable.h       |  3 +++
 arch/x86/include/asm/text-patching.h |  2 ++
 arch/x86/kernel/alternative.c        |  3 +++
 arch/x86/mm/init.c                   | 37 ++++++++++++++++++++++++++++++++++++
 init/main.c                          |  3 +++
 5 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2779ace16d23..702db5904753 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1021,6 +1021,9 @@ static inline void __meminit init_trampoline_default(void)
 	/* Default trampoline pgd value */
 	trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
 }
+
+void __init poking_init(void);
+
 # ifdef CONFIG_RANDOMIZE_MEMORY
 void __meminit init_trampoline(void);
 # else
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index f8fc8e86cf01..a75eed841eed 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -39,5 +39,7 @@ extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 extern int after_bootmem;
+extern __ro_after_init struct mm_struct *poking_mm;
+extern __ro_after_init unsigned long poking_addr;
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0a814d73547a..11d5c710a94f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -679,6 +679,9 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 	return addr;
 }
 
+__ro_after_init struct mm_struct *poking_mm;
+__ro_after_init unsigned long poking_addr;
+
 static void *__text_poke(void *addr, const void *opcode, size_t len)
 {
 	unsigned long flags;
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8dacdb96899e..fd10d91a6115 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -6,6 +6,7 @@
 #include <linux/swapfile.h>
 #include <linux/swapops.h>
 #include <linux/kmemleak.h>
+#include <linux/sched/task.h>
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
@@ -23,6 +24,7 @@
 #include <asm/hypervisor.h>
 #include <asm/cpufeature.h>
 #include <asm/pti.h>
+#include <asm/text-patching.h>
 
 /*
  * We need to define the tracepoints somewhere, and tlb.c
@@ -701,6 +703,41 @@ void __init init_mem_mapping(void)
 	early_memtest(0, max_pfn_mapped << PAGE_SHIFT);
 }
 
+/*
+ * Initialize an mm_struct to be used during poking and a pointer to be used
+ * during patching.
+ */
+void __init poking_init(void)
+{
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+	poking_mm = copy_init_mm();
+	BUG_ON(!poking_mm);
+
+	/*
+	 * Randomize the poking address, but make sure that the following page
+	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
+	 * and adjust the address if the PMD ends after the first one.
+	 */
+	poking_addr = TASK_UNMAPPED_BASE;
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		poking_addr += (kaslr_get_random_long("Poking") & PAGE_MASK) %
+			(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
+
+	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) == 0)
+		poking_addr += PAGE_SIZE;
+
+	/*
+	 * We need to trigger the allocation of the page-tables that will be
+	 * needed for poking now. Later, poking may be performed in an atomic
+	 * section, which might cause allocation to fail.
+	 */
+	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
+	BUG_ON(!ptep);
+	pte_unmap_unlock(ptep, ptl);
+}
+
 /*
  * devmem_is_allowed() checks to see if /dev/mem access to a certain address
  * is valid. The argument is a physical page number.
diff --git a/init/main.c b/init/main.c
index 7d4025d665eb..95dd9406ee31 100644
--- a/init/main.c
+++ b/init/main.c
@@ -504,6 +504,8 @@ void __init __weak thread_stack_cache_init(void)
 
 void __init __weak mem_encrypt_init(void) { }
 
+void __init __weak poking_init(void) { }
+
 bool initcall_debug;
 core_param(initcall_debug, initcall_debug, bool, 0644);
 
@@ -737,6 +739,7 @@ asmlinkage __visible void __init start_kernel(void)
 	taskstats_init_early();
 	delayacct_init();
 
+	poking_init();
 	check_bugs();
 
 	acpi_subsystem_init();
