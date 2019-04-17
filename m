Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B07AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4001B21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cJBEvxrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbfDQOPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:15:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46133 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfDQOPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:15:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEEYal3934508
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:14:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEEYal3934508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510476;
        bh=4yg3gMj1CNw4beewq5SrySuvpoFa27G8vvJqNIV/xkE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cJBEvxrlop9FdSwFuRHbDhT5KRZaFTD+w9RlHr/t2xyC7G1Rd7uvP1s78/m8YJ7hX
         Lnyjo/Dr4DQueiaUhE1XCl44ETWRFbYp9EfKDuD25Esiivm01BGVloQWJ/2kF3kDTw
         9itBs0Su0OI/xFaTGpdE9TXkLsyVMO8cZtC9D3xaQ9/HP/rt+bwfvIKn4PfyuIEWFc
         lGXVjQcVjzyjY5iNtTlQt0YXOibXb81L27eIacK0neEMX5q+umsi0WRPte980nnUp+
         24D0QOJSlQExAjYa7WNnG7A6FAW146Wq3asMGbzo9PtE1r0ubQMExI/TuZLYHXwWZN
         J2P1quVEoQ8Gw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEEXfD3934505;
        Wed, 17 Apr 2019 07:14:33 -0700
Date:   Wed, 17 Apr 2019 07:14:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-3207426925d2b4da390be8068df1d1c2b36e5918@git.kernel.org>
Cc:     tglx@linutronix.de, cai@lca.pw, mingo@redhat.com,
        peterz@infradead.org, mingo@kernel.org, konrad.wilk@oracle.com,
        douly.fnst@cn.fujitsu.com, luto@kernel.org,
        sean.j.christopherson@intel.com, x86@kernel.org, nstange@suse.de,
        linux@dominikbrodowski.net, chang.seok.bae@intel.com,
        kirill.shutemov@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, bp@suse.de, keescook@chromium.org,
        jannh@google.com, bhe@redhat.com, hpa@zytor.com
Reply-To: jannh@google.com, keescook@chromium.org,
          linux-kernel@vger.kernel.org, bp@suse.de, bhe@redhat.com,
          hpa@zytor.com, kirill.shutemov@linux.intel.com,
          linux@dominikbrodowski.net, chang.seok.bae@intel.com,
          jpoimboe@redhat.com, x86@kernel.org,
          sean.j.christopherson@intel.com, luto@kernel.org,
          nstange@suse.de, tglx@linutronix.de, mingo@redhat.com,
          cai@lca.pw, peterz@infradead.org, mingo@kernel.org,
          douly.fnst@cn.fujitsu.com, konrad.wilk@oracle.com
In-Reply-To: <20190414160145.241588113@linutronix.de>
References: <20190414160145.241588113@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/exceptions: Disconnect IST index and stack order
Git-Commit-ID: 3207426925d2b4da390be8068df1d1c2b36e5918
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

Commit-ID:  3207426925d2b4da390be8068df1d1c2b36e5918
Gitweb:     https://git.kernel.org/tip/3207426925d2b4da390be8068df1d1c2b36e5918
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:55 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:01:09 +0200

x86/exceptions: Disconnect IST index and stack order

The entry order of the TSS.IST array and the order of the stack
storage/mapping are not required to be the same.

With the upcoming split of the debug stack this is going to fall apart as
the number of TSS.IST array entries stays the same while the actual stacks
are increasing.

Make them separate so that code like dumpstack can just utilize the mapping
order. The IST index is solely required for the actual TSS.IST array
initialization.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160145.241588113@linutronix.de
---
 arch/x86/entry/entry_64.S             |  2 +-
 arch/x86/include/asm/cpu_entry_area.h | 11 +++++++++++
 arch/x86/include/asm/page_64_types.h  |  9 ++++-----
 arch/x86/include/asm/stacktrace.h     |  2 ++
 arch/x86/kernel/cpu/common.c          | 10 +++++-----
 arch/x86/kernel/idt.c                 |  8 ++++----
 6 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index fd0a50452cb3..5c0348504a4b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1129,7 +1129,7 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
-idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=ESTACK_DB
+idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=IST_INDEX_DB
 idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 9b406f067ecf..310eeb62d418 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -35,6 +35,17 @@ struct cea_exception_stacks {
 	ESTACKS_MEMBERS(0)
 };
 
+/*
+ * The exception stack ordering in [cea_]exception_stacks
+ */
+enum exception_stack_ordering {
+	ESTACK_DF,
+	ESTACK_NMI,
+	ESTACK_DB,
+	ESTACK_MCE,
+	N_EXCEPTION_STACKS
+};
+
 #define CEA_ESTACK_SIZE(st)					\
 	sizeof(((struct cea_exception_stacks *)0)->st## _stack)
 
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 6ab2c54c1bf9..056de887b220 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -27,11 +27,10 @@
 /*
  * The index for the tss.ist[] array. The hardware limit is 7 entries.
  */
-#define	ESTACK_DF		0
-#define	ESTACK_NMI		1
-#define	ESTACK_DB		2
-#define	ESTACK_MCE		3
-#define	N_EXCEPTION_STACKS	4
+#define	IST_INDEX_DF		0
+#define	IST_INDEX_NMI		1
+#define	IST_INDEX_DB		2
+#define	IST_INDEX_MCE		3
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index f335aad404a4..d6d758a187b6 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -9,6 +9,8 @@
 
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
+
+#include <asm/cpu_entry_area.h>
 #include <asm/switch_to.h>
 
 enum stack_type {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8243f198fb7f..143aceaf9a9a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1731,11 +1731,11 @@ void cpu_init(void)
 	 * set up and load the per-CPU TSS
 	 */
 	if (!t->x86_tss.ist[0]) {
-		t->x86_tss.ist[ESTACK_DF] = __this_cpu_ist_top_va(DF);
-		t->x86_tss.ist[ESTACK_NMI] = __this_cpu_ist_top_va(NMI);
-		t->x86_tss.ist[ESTACK_DB] = __this_cpu_ist_top_va(DB);
-		t->x86_tss.ist[ESTACK_MCE] = __this_cpu_ist_top_va(MCE);
-		per_cpu(debug_stack_addr, cpu) = t->x86_tss.ist[ESTACK_DB];
+		t->x86_tss.ist[IST_INDEX_DF] = __this_cpu_ist_top_va(DF);
+		t->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
+		t->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
+		t->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
+		per_cpu(debug_stack_addr, cpu) = t->x86_tss.ist[IST_INDEX_DB];
 	}
 
 	t->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 2188f734ec61..6d8917875f44 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -183,11 +183,11 @@ gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
  * cpu_init() when the TSS has been initialized.
  */
 static const __initconst struct idt_data ist_idts[] = {
-	ISTG(X86_TRAP_DB,	debug,		ESTACK_DB),
-	ISTG(X86_TRAP_NMI,	nmi,		ESTACK_NMI),
-	ISTG(X86_TRAP_DF,	double_fault,	ESTACK_DF),
+	ISTG(X86_TRAP_DB,	debug,		IST_INDEX_DB),
+	ISTG(X86_TRAP_NMI,	nmi,		IST_INDEX_NMI),
+	ISTG(X86_TRAP_DF,	double_fault,	IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
-	ISTG(X86_TRAP_MC,	&machine_check,	ESTACK_MCE),
+	ISTG(X86_TRAP_MC,	&machine_check,	IST_INDEX_MCE),
 #endif
 };
 
