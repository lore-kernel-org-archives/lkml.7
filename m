Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6BFC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBE320861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffd9uvqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfGIM5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:57:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38160 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIM5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xwxt302YR0q8PaP4227fgkLbfxPY0ENxYFuABYvBumo=; b=ffd9uvqEeDEgLOUIzlVw0RPH6
        Upgxx2D5uCTXSM8a0Thj22lU/TIuTscW2Edl3aOP1RmUYZ3yTsHGESaMTckU75eoXQHK8+iL42LKR
        rc/ysfg+02ACvP4x7tsue8JPxukYOdpbs7UQFyPvukY5CFcIAtrIWuvg6iHeGm6E19dFmau7vClFw
        bRZxQb2SDh8GRcU+wE8rdo+V59L3G3FsJCVOZ9T9fJUXGoWJGC7nwZXfKtXYDvkGtFnc4PLWaO5GX
        2etlr45eK7FclOAxT/gOKXWnGyePgvihqrwwJ0eUffg8dyCsJWMSsY1pzh/G0RZZE5112HkqMmKXt
        dOI8/gVDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkpgn-0006eF-O1; Tue, 09 Jul 2019 12:57:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B7C92097783C; Tue,  9 Jul 2019 14:57:44 +0200 (CEST)
Date:   Tue, 9 Jul 2019 14:57:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH] x86/alternatives: Fix int3_emulate_call() selftest stack
 corruption
Message-ID: <20190709125744.GB3402@hirez.programming.kicks-ass.net>
References: <1a859cba4db356852b20222ebe056b38c6a6e963.1562619299.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a859cba4db356852b20222ebe056b38c6a6e963.1562619299.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 03:55:30PM -0500, Josh Poimboeuf wrote:

>  arch/x86/kernel/alternative.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 99ef8b6f9a1a..2644a7b82f96 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -651,6 +651,13 @@ int3_exception_notify(struct notifier_block *self, unsigned long val, void *data
>  	return NOTIFY_STOP;
>  }
>  
> +#ifdef CONFIG_X86_32
> +# define INT3_TEST_CLOBBERS "memory", "cc", "ecx", "edx"
> +#else
> +# define INT3_TEST_CLOBBERS "memory", "cc", "rax", "rcx", "rdx", "rsi", "r8", \
> +			    "r9", "r10", "r11"
> +#endif
> +
>  static void __init int3_selftest(void)
>  {
>  	static __initdata struct notifier_block int3_exception_nb = {
> @@ -676,7 +683,7 @@ static void __init int3_selftest(void)
>  		      "int3_selftest_ip:\n\t"
>  		      __ASM_SEL(.long, .quad) " 1b\n\t"
>  		      ".popsection\n\t"
> -		      : : __ASM_SEL_RAW(a, D) (&val) : "memory");
> +		      : : __ASM_SEL_RAW(a, D) (&val) : INT3_TEST_CLOBBERS);
>  
>  	BUG_ON(val != 1);

As discussed on IRC; I've changed that to the other variant.

---
Subject: x86/alternatives: Fix int3_emulate_call() selftest stack corruption
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 8 Jul 2019 15:55:30 -0500

KASAN shows the following splat during boot:

  BUG: KASAN: unknown-crash in unwind_next_frame+0x3f6/0x490
  Read of size 8 at addr ffffffff84007db0 by task swapper/0

  CPU: 0 PID: 0 Comm: swapper Tainted: G                T 5.2.0-rc6-00013-g7457c0d #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
  Call Trace:
   dump_stack+0x19/0x1b
   print_address_description+0x1b0/0x2b2
   ? unwind_next_frame+0x3f6/0x490
   __kasan_report+0x10f/0x171
   ? unwind_next_frame+0x3f6/0x490
   kasan_report+0x12/0x1c
   __asan_load8+0x54/0x81
   unwind_next_frame+0x3f6/0x490
   ? unwind_dump+0x24e/0x24e
   unwind_next_frame+0x1b/0x23
   ? create_prof_cpu_mask+0x20/0x20
   arch_stack_walk+0x68/0xa5
   ? set_memory_4k+0x2a/0x2c
   stack_trace_save+0x7b/0xa0
   ? stack_trace_consume_entry+0x89/0x89
   save_trace+0x3c/0x93
   mark_lock+0x1ef/0x9b1
   ? sched_clock_local+0x86/0xa6
   __lock_acquire+0x3ba/0x1bea
   ? __asan_loadN+0xf/0x11
   ? mark_held_locks+0x8e/0x8e
   ? mark_lock+0xb4/0x9b1
   ? sched_clock_local+0x86/0xa6
   lock_acquire+0x122/0x221
   ? _vm_unmap_aliases+0x141/0x183
   __mutex_lock+0xb6/0x731
   ? _vm_unmap_aliases+0x141/0x183
   ? sched_clock_cpu+0xac/0xb1
   ? __mutex_add_waiter+0xae/0xae
   ? lock_downgrade+0x368/0x368
   ? _vm_unmap_aliases+0x40/0x183
   mutex_lock_nested+0x16/0x18
   _vm_unmap_aliases+0x141/0x183
   ? _vm_unmap_aliases+0x40/0x183
   vm_unmap_aliases+0x14/0x16
   change_page_attr_set_clr+0x15e/0x2f2
   ? __set_pages_p+0x111/0x111
   ? alternative_instructions+0xd8/0x118
   ? arch_init_ideal_nops+0x181/0x181
   set_memory_4k+0x2a/0x2c
   check_bugs+0x11fd/0x1298
   ? l1tf_cmdline+0x1dc/0x1dc
   ? proc_create_single_data+0x5f/0x6e
   ? cgroup_init+0x2b1/0x2f6
   start_kernel+0x793/0x7eb
   ? thread_stack_cache_init+0x2e/0x2e
   ? idt_setup_early_handler+0x70/0xb1
   x86_64_start_reservations+0x55/0x76
   x86_64_start_kernel+0x87/0xaa
   secondary_startup_64+0xa4/0xb0

  Memory state around the buggy address:
   ffffffff84007c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
   ffffffff84007d00: f1 00 00 00 00 00 00 00 00 00 f2 f2 f2 f3 f3 f3
  >ffffffff84007d80: f3 79 be 52 49 79 be 00 00 00 00 00 00 00 00 f1

It turns out that int3_selftest() is corrupting the stack.  The problem
is that the KASAN-ified version of int3_magic() is much less trivial
than the C code appears.  It clobbers several unexpected registers.  So
when the selftest's INT3 is converted to an emulated call to
int3_magic(), the registers are clobbered and Bad Things happen when the
function returns.

Fix this by converting int3_magic() to the trivial ASM function it
should be, avoiding all calling convetion issues. Also add
ASM_CALL_CONSTRAINT to the INT3 ASM, since it contains a 'CALL'.

Fixes: 7457c0da024b ("x86/alternatives: Add int3_emulate_call() selftest")
Cc: x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Debugged-by: Josh Poimboeuf <jpoimboe@redhat.com>
[peterz: cribbed changelog from josh]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -625,10 +625,23 @@ extern struct paravirt_patch_site __star
  *
  * See entry_{32,64}.S for more details.
  */
-static void __init int3_magic(unsigned int *ptr)
-{
-	*ptr = 1;
-}
+
+/*
+ * We define the int3_magic() function in assembly to control the calling
+ * convention such that we can 'call' it from assembly.
+ */
+
+extern void int3_magic(unsigned int *ptr); /* defined in asm */
+
+asm (
+"	.pushsection	.init.text, \"ax\", @progbits\n"
+"	.type		int3_magic, @function\n"
+"int3_magic:\n"
+"	movl	$1, (%" _ASM_ARG1 ")\n"
+"	ret\n"
+"	.size		int3_magic, .-int3_magic\n"
+"	.popsection\n"
+);
 
 extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
 
@@ -676,7 +689,9 @@ static void __init int3_selftest(void)
 		      "int3_selftest_ip:\n\t"
 		      __ASM_SEL(.long, .quad) " 1b\n\t"
 		      ".popsection\n\t"
-		      : : __ASM_SEL_RAW(a, D) (&val) : "memory");
+		      : ASM_CALL_CONSTRAINT
+		      : __ASM_SEL_RAW(a, D) (&val)
+		      : "memory");
 
 	BUG_ON(val != 1);
 
