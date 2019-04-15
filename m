Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61F0C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3382075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356597;
	bh=QbaI6hIrRcd98/+SRCFn0g7IqGNDzkl2E2asttGYS14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XMJSML529QTY+aD1RT+bqK+FbqWtpDLtUbiC6NeGkgUqgwxMCdIvDXIjNaADphIey
	 J3d2bDY4U7lPiRBHCvmQHKLTG8SDc6aUdWuEgZ6JVn52k7US/4cMDLyKKYZYJACabU
	 h1ELYR8j1Z3K6raD3uaK+xLwV9eWobg1jy6Syeo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfDOTCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbfDOTB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:01:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7BF2087C;
        Mon, 15 Apr 2019 19:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354916;
        bh=QbaI6hIrRcd98/+SRCFn0g7IqGNDzkl2E2asttGYS14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0Iq2SC6Cuqe4dBXW/mwDhU124hcyoJ8NeuVHvWI4gCXEhfFNfxxJ6r0ouapivXZK
         SknmkEXTMzJgOYVUG+kWJaHXgrTwSveFIUbyyYfTcX/taknrldWlfwmw+63hsG4GR3
         uMgIfYiHWQw9tliSjxuaRgSnRtK/fPdOkEyKbDhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 05/69] x86/power: Make restore_processor_context() sane
Date:   Mon, 15 Apr 2019 20:58:23 +0200
Message-Id: <20190415183727.581656002@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7ee18d677989e99635027cee04c878950e0752b9 ]

My previous attempt to fix a couple of bugs in __restore_processor_context():

  5b06bbcfc2c6 ("x86/power: Fix some ordering bugs in __restore_processor_context()")

... introduced yet another bug, breaking suspend-resume.

Rather than trying to come up with a minimal fix, let's try to clean it up
for real.  This patch fixes quite a few things:

 - The old code saved a nonsensical subset of segment registers.
   The only registers that need to be saved are those that contain
   userspace state or those that can't be trivially restored without
   percpu access working.  (On x86_32, we can restore percpu access
   by writing __KERNEL_PERCPU to %fs.  On x86_64, it's easier to
   save and restore the kernel's GSBASE.)  With this patch, we
   restore hardcoded values to the kernel state where applicable and
   explicitly restore the user state after fixing all the descriptor
   tables.

 - We used to use an unholy mix of inline asm and C helpers for
   segment register access.  Let's get rid of the inline asm.

This fixes the reported s2ram hangs and make the code all around
more logical.

Analyzed-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reported-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>
Fixes: 5b06bbcfc2c6 ("x86/power: Fix some ordering bugs in __restore_processor_context()")
Link: http://lkml.kernel.org/r/398ee68e5c0f766425a7b746becfc810840770ff.1513286253.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/suspend_32.h |  8 +++-
 arch/x86/include/asm/suspend_64.h | 16 ++++++-
 arch/x86/power/cpu.c              | 79 ++++++++++++++++---------------
 3 files changed, 62 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 982c325dad33..8be6afb58471 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -12,7 +12,13 @@
 
 /* image of the saved processor state */
 struct saved_context {
-	u16 es, fs, gs, ss;
+	/*
+	 * On x86_32, all segment registers, with the possible exception of
+	 * gs, are saved at kernel entry in pt_regs.
+	 */
+#ifdef CONFIG_X86_32_LAZY_GS
+	u16 gs;
+#endif
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	bool misc_enable_saved;
diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
index 600e9e0aea51..a7af9f53c0cb 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -20,8 +20,20 @@
  */
 struct saved_context {
 	struct pt_regs regs;
-	u16 ds, es, fs, gs, ss;
-	unsigned long gs_base, gs_kernel_base, fs_base;
+
+	/*
+	 * User CS and SS are saved in current_pt_regs().  The rest of the
+	 * segment selectors need to be saved and restored here.
+	 */
+	u16 ds, es, fs, gs;
+
+	/*
+	 * Usermode FSBASE and GSBASE may not match the fs and gs selectors,
+	 * so we save them separately.  We save the kernelmode GSBASE to
+	 * restore percpu access after resume.
+	 */
+	unsigned long kernelmode_gs_base, usermode_gs_base, fs_base;
+
 	unsigned long cr0, cr2, cr3, cr4, cr8;
 	u64 misc_enable;
 	bool misc_enable_saved;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 8e1668470b23..a7d966964c6f 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -99,22 +99,18 @@ static void __save_processor_state(struct saved_context *ctxt)
 	/*
 	 * segment registers
 	 */
-#ifdef CONFIG_X86_32
-	savesegment(es, ctxt->es);
-	savesegment(fs, ctxt->fs);
+#ifdef CONFIG_X86_32_LAZY_GS
 	savesegment(gs, ctxt->gs);
-	savesegment(ss, ctxt->ss);
-#else
-/* CONFIG_X86_64 */
-	asm volatile ("movw %%ds, %0" : "=m" (ctxt->ds));
-	asm volatile ("movw %%es, %0" : "=m" (ctxt->es));
-	asm volatile ("movw %%fs, %0" : "=m" (ctxt->fs));
-	asm volatile ("movw %%gs, %0" : "=m" (ctxt->gs));
-	asm volatile ("movw %%ss, %0" : "=m" (ctxt->ss));
+#endif
+#ifdef CONFIG_X86_64
+	savesegment(gs, ctxt->gs);
+	savesegment(fs, ctxt->fs);
+	savesegment(ds, ctxt->ds);
+	savesegment(es, ctxt->es);
 
 	rdmsrl(MSR_FS_BASE, ctxt->fs_base);
-	rdmsrl(MSR_GS_BASE, ctxt->gs_base);
-	rdmsrl(MSR_KERNEL_GS_BASE, ctxt->gs_kernel_base);
+	rdmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
+	rdmsrl(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
 	mtrr_save_fixed_ranges(NULL);
 
 	rdmsrl(MSR_EFER, ctxt->efer);
@@ -191,9 +187,12 @@ static void fix_processor_context(void)
 }
 
 /**
- *	__restore_processor_state - restore the contents of CPU registers saved
- *		by __save_processor_state()
- *	@ctxt - structure to load the registers contents from
+ * __restore_processor_state - restore the contents of CPU registers saved
+ *                             by __save_processor_state()
+ * @ctxt - structure to load the registers contents from
+ *
+ * The asm code that gets us here will have restored a usable GDT, although
+ * it will be pointing to the wrong alias.
  */
 static void notrace __restore_processor_state(struct saved_context *ctxt)
 {
@@ -216,46 +215,50 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	write_cr2(ctxt->cr2);
 	write_cr0(ctxt->cr0);
 
+	/* Restore the IDT. */
+	load_idt(&ctxt->idt);
+
 	/*
-	 * now restore the descriptor tables to their proper values
-	 * ltr is done i fix_processor_context().
+	 * Just in case the asm code got us here with the SS, DS, or ES
+	 * out of sync with the GDT, update them.
 	 */
-	load_idt(&ctxt->idt);
+	loadsegment(ss, __KERNEL_DS);
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
 
-#ifdef CONFIG_X86_64
 	/*
-	 * We need GSBASE restored before percpu access can work.
-	 * percpu access can happen in exception handlers or in complicated
-	 * helpers like load_gs_index().
+	 * Restore percpu access.  Percpu access can happen in exception
+	 * handlers or in complicated helpers like load_gs_index().
 	 */
-	wrmsrl(MSR_GS_BASE, ctxt->gs_base);
+#ifdef CONFIG_X86_64
+	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
+#else
+	loadsegment(fs, __KERNEL_PERCPU);
+	loadsegment(gs, __KERNEL_STACK_CANARY);
 #endif
 
+	/* Restore the TSS, RO GDT, LDT, and usermode-relevant MSRs. */
 	fix_processor_context();
 
 	/*
-	 * Restore segment registers.  This happens after restoring the GDT
-	 * and LDT, which happen in fix_processor_context().
+	 * Now that we have descriptor tables fully restored and working
+	 * exception handling, restore the usermode segments.
 	 */
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_64
+	loadsegment(ds, ctxt->es);
 	loadsegment(es, ctxt->es);
 	loadsegment(fs, ctxt->fs);
-	loadsegment(gs, ctxt->gs);
-	loadsegment(ss, ctxt->ss);
-#else
-/* CONFIG_X86_64 */
-	asm volatile ("movw %0, %%ds" :: "r" (ctxt->ds));
-	asm volatile ("movw %0, %%es" :: "r" (ctxt->es));
-	asm volatile ("movw %0, %%fs" :: "r" (ctxt->fs));
 	load_gs_index(ctxt->gs);
-	asm volatile ("movw %0, %%ss" :: "r" (ctxt->ss));
 
 	/*
-	 * Restore FSBASE and user GSBASE after reloading the respective
-	 * segment selectors.
+	 * Restore FSBASE and GSBASE after restoring the selectors, since
+	 * restoring the selectors clobbers the bases.  Keep in mind
+	 * that MSR_KERNEL_GS_BASE is horribly misnamed.
 	 */
 	wrmsrl(MSR_FS_BASE, ctxt->fs_base);
-	wrmsrl(MSR_KERNEL_GS_BASE, ctxt->gs_kernel_base);
+	wrmsrl(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
+#elif defined(CONFIG_X86_32_LAZY_GS)
+	loadsegment(gs, ctxt->gs);
 #endif
 
 	do_fpu_end();
-- 
2.19.1



