Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B41C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C10320835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pZQb8jWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfK0Tjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:39:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40792 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfK0Tjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:39:51 -0500
Received: from zn.tnic (p200300EC2F0F37001503A7D2BED37AE0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:3700:1503:a7d2:bed3:7ae0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86B621EC0CCE;
        Wed, 27 Nov 2019 20:39:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574883586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EUJy5Hjm/ijM1KVDCnc+ezgbZaFSphyf1CPFMJjaoG4=;
        b=pZQb8jWqur8YhbAwa0fN8imydaEU2q/ExWUqQIFckfw5CnSEMis+hx7a5pSlrCo4CM3ZZQ
        ohtoQv9qtViA03zZnSYObfnC3kymlA1rXuVy3PULu5KePPT9zRySmeEV3CmXKoJ8W/9TY8
        89mdPkDRYM8NAMSDy+fYt/27rvqbBYQ=
Date:   Wed, 27 Nov 2019 20:39:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] x86: Remove CONFIG_DOUBLEFAULT
Message-ID: <20191127193937.GD3812@zn.tnic>
References: <157484276997.21853.6533072564160468139.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157484276997.21853.6533072564160468139.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 08:19:29AM -0000, tip-bot2 for Andy Lutomirski wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     93efbde2c331004d8053f04b4bf0ca3e630b474a
> Gitweb:        https://git.kernel.org/tip/93efbde2c331004d8053f04b4bf0ca3e630b474a
> Author:        Andy Lutomirski <luto@kernel.org>
> AuthorDate:    Wed, 20 Nov 2019 22:12:38 -08:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 26 Nov 2019 21:53:34 +01:00
> 
> x86/traps: Disentangle the 32-bit and 64-bit doublefault code
> 
> The 64-bit doublefault handler is much nicer than the 32-bit one.
> As a first step toward unifying them, make the 64-bit handler
> self-contained.  This should have no effect no functional effect
> except in the odd case of x86_64 with CONFIG_DOUBLEFAULT=n in which
> case it will change the logging a bit.
> 
> This also gets rid of CONFIG_DOUBLEFAULT configurability on 64-bit
> kernels.  It didn't do anything useful -- CONFIG_DOUBLEFAULT=n
> didn't actually disable doublefault handling on x86_64.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/Kconfig.debug           |  2 +-
>  arch/x86/include/asm/processor.h |  1 -
>  arch/x86/kernel/doublefault.c    | 11 -----------
>  arch/x86/kernel/traps.c          | 12 +++---------
>  4 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index 409c00f..c4eab8e 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -117,7 +117,7 @@ config DEBUG_WX
>  
>  config DOUBLEFAULT
>  	default y
> -	bool "Enable doublefault exception handler" if EXPERT
> +	bool "Enable doublefault exception handler" if EXPERT && X86_32

Yeah, how about we simplify the whole df code even more. It is clearly
much better to always have a registered #DF handler so let's get rid of
that silly config option.

Only compile-tested.

---
From: Borislav Petkov <bp@suse.de>
Date: Wed, 27 Nov 2019 19:12:29 +0100
Subject: [RFC PATCH] x86: Remove CONFIG_DOUBLEFAULT

... and make it unconditional.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Kconfig.debug             | 9 ---------
 arch/x86/entry/entry_32.S          | 2 --
 arch/x86/include/asm/doublefault.h | 6 ++----
 arch/x86/include/asm/traps.h       | 2 --
 arch/x86/kernel/Makefile           | 4 +---
 arch/x86/kernel/dumpstack_32.c     | 4 ----
 arch/x86/kernel/traps.c            | 2 --
 arch/x86/mm/cpu_entry_area.c       | 4 +---
 8 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index c4eab8ed33a3..f386068114d6 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -115,15 +115,6 @@ config DEBUG_WX
 
 	  If in doubt, say "Y".
 
-config DOUBLEFAULT
-	default y
-	bool "Enable doublefault exception handler" if EXPERT && X86_32
-	---help---
-	  This option allows trapping of rare doublefault exceptions that
-	  would otherwise cause a system to silently reboot. Disabling this
-	  option saves about 4k and might cause you much additional grey
-	  hair.
-
 config DEBUG_TLBFLUSH
 	bool "Set upper limit of TLB entries to flush one-by-one"
 	depends on DEBUG_KERNEL
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 7e0560442538..8bd285617c21 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1536,7 +1536,6 @@ SYM_CODE_START(debug)
 	jmp	common_exception
 SYM_CODE_END(debug)
 
-#ifdef CONFIG_DOUBLEFAULT
 SYM_CODE_START(double_fault)
 1:
 	/*
@@ -1576,7 +1575,6 @@ SYM_CODE_START(double_fault)
 	hlt
 	jmp 1b
 SYM_CODE_END(double_fault)
-#endif
 
 /*
  * NMI is doubly nasty.  It can happen on the first instruction of
diff --git a/arch/x86/include/asm/doublefault.h b/arch/x86/include/asm/doublefault.h
index af9a14ac8962..65b58363797e 100644
--- a/arch/x86/include/asm/doublefault.h
+++ b/arch/x86/include/asm/doublefault.h
@@ -2,12 +2,10 @@
 #ifndef _ASM_X86_DOUBLEFAULT_H
 #define _ASM_X86_DOUBLEFAULT_H
 
-#if defined(CONFIG_X86_32) && defined(CONFIG_DOUBLEFAULT)
+#ifdef CONFIG_X86_32
 extern void doublefault_init_cpu_tss(void);
 #else
-static inline void doublefault_init_cpu_tss(void)
-{
-}
+static inline void doublefault_init_cpu_tss(void) { }
 #endif
 
 #endif /* _ASM_X86_DOUBLEFAULT_H */
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index ffa0dc8a535e..4580c8207da3 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -69,9 +69,7 @@ dotraplinkage void do_overflow(struct pt_regs *regs, long error_code);
 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
 dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
-#if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
-#endif
 dotraplinkage void do_coprocessor_segment_overrun(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
 dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index ccb13271895d..0f5bdf6dfce6 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -104,9 +104,7 @@ obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
 obj-y				+= kprobes/
 obj-$(CONFIG_MODULES)		+= module.o
-ifeq ($(CONFIG_X86_32),y)
-obj-$(CONFIG_DOUBLEFAULT)	+= doublefault_32.o
-endif
+obj-$(CONFIG_X86_32)		+= doublefault_32.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 8e3a8fedfa4d..722fd712e1cf 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -87,7 +87,6 @@ static bool in_softirq_stack(unsigned long *stack, struct stack_info *info)
 
 static bool in_doublefault_stack(unsigned long *stack, struct stack_info *info)
 {
-#ifdef CONFIG_DOUBLEFAULT
 	struct cpu_entry_area *cea = get_cpu_entry_area(raw_smp_processor_id());
 	struct doublefault_stack *ss = &cea->doublefault_stack;
 
@@ -103,9 +102,6 @@ static bool in_doublefault_stack(unsigned long *stack, struct stack_info *info)
 	info->next_sp	= (unsigned long *)this_cpu_read(cpu_tss_rw.x86_tss.sp);
 
 	return true;
-#else
-	return false;
-#endif
 }
 
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f19de6f45d48..3bcbf5c3d1f0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -306,7 +306,6 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 }
 #endif
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 /*
  * Runs on an IST stack for x86_64 and on a special task stack for x86_32.
  *
@@ -430,7 +429,6 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 	die("double fault", regs, error_code);
 	panic("Machine halted.");
 }
-#endif
 
 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 {
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 56f9189bbadb..5199d8a1daf1 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -17,7 +17,7 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
 DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
 #endif
 
-#if defined(CONFIG_X86_32) && defined(CONFIG_DOUBLEFAULT)
+#ifdef CONFIG_X86_32
 DECLARE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack);
 #endif
 
@@ -114,12 +114,10 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 #else
 static inline void percpu_setup_exception_stacks(unsigned int cpu)
 {
-#ifdef CONFIG_DOUBLEFAULT
 	struct cpu_entry_area *cea = get_cpu_entry_area(cpu);
 
 	cea_map_percpu_pages(&cea->doublefault_stack,
 			     &per_cpu(doublefault_stack, cpu), 1, PAGE_KERNEL);
-#endif
 }
 #endif
 
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
