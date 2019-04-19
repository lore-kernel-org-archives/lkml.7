Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDB8C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0131D214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfDSA6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:58:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfDSA6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:58:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABEC8301A639;
        Fri, 19 Apr 2019 00:58:24 +0000 (UTC)
Received: from treble (ovpn-124-190.rdu2.redhat.com [10.10.124.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52BBE60BE2;
        Fri, 19 Apr 2019 00:58:23 +0000 (UTC)
Date:   Thu, 18 Apr 2019 19:58:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v3] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190419005821.ttlpav7gviaed7am@treble>
References: <20190418160730.11901-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418160730.11901-1-kasong@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 19 Apr 2019 00:58:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:07:30PM -0400, Kairui Song wrote:
> Currently perf callchain doesn't work well when sampling from trace
> point, with ORC unwinder enabled and CONFIG_FRAME_POINTER disabled.
> We'll get useless in kernel callchain like this:
> 
> perf  6429 [000]    22.498450:             kmem:mm_page_alloc: page=0x176a17 pfn=1534487 order=0 migratetype=0 gfp_flags=GFP_KERNEL
>     ffffffffbe23e32e __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
> 	7efdf7f7d3e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
> 	5651468729c1 [unknown] (/usr/bin/perf)
> 	5651467ee82a main+0x69a (/usr/bin/perf)
> 	7efdf7eaf413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
>     5541f689495641d7 [unknown] ([unknown])
> 
> The root cause is within a trace point perf will try to dump the
> required caller's registers, but without CONFIG_FRAME_POINTER we
> can't get caller's BP as the frame pointer, so current frame pointer
> is returned instead. We get a invalid register combination which
> confuse the unwinder and end the stacktrace early.
> 
> So in such case just don't try dump BP when doing partial register
> dump. And just let the unwinder start directly when the register is
> incapable of presenting a unwinding start point. Use SP as the skip
> mark, skip all the frames until we meet the frame we want.
> 
> This make the callchain get the full kernel space stacktrace again:
> 
> perf  6503 [000]  1567.570191:             kmem:mm_page_alloc: page=0x16c904 pfn=1493252 order=0 migratetype=0 gfp_flags=GFP_KERNEL
>     ffffffffb523e2ae __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb52383bd __get_free_pages+0xd (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb52fd28a __pollwait+0x8a (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb521426f perf_poll+0x2f (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb52fe3e2 do_sys_poll+0x252 (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb52ff027 __x64_sys_poll+0x37 (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb500418b do_syscall_64+0x5b (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb5a0008c entry_SYSCALL_64_after_hwframe+0x44 (/lib/modules/5.1.0-rc3+/build/vmlinux)
> 	7f71e92d03e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
> 	55a22960d9c1 [unknown] (/usr/bin/perf)
> 	55a22958982a main+0x69a (/usr/bin/perf)
> 	7f71e9202413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
>     5541f689495641d7 [unknown] ([unknown])
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
> 
> Update from V2:
>   - Instead of looking at if BP is 0, use X86_EFLAGS_FIXED flag bit as
>     the indicator of where the pt_regs is valid for unwinding. As
>     suggested by Peter Zijlstra
>   - Update some comments accordingly.
> 
> Update from V1:
>   Get rid of a lot of unneccessary code and just don't dump a inaccurate
>   BP, and use SP as the marker for target frame.
> 
>  arch/x86/events/core.c            | 24 +++++++++++++++++++++---
>  arch/x86/include/asm/perf_event.h |  5 +++++
>  arch/x86/include/asm/stacktrace.h |  9 +++++++--
>  include/linux/perf_event.h        |  6 +++---
>  4 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index e2b1447192a8..e181e195fe5d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2355,6 +2355,18 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	cyc2ns_read_end();
>  }
>  
> +static inline int
> +valid_unwinding_registers(struct pt_regs *regs)
> +{
> +	/*
> +	 * regs might be a fake one, it won't dump the flags reg,
> +	 * and without frame pointer, it won't have a valid BP.
> +	 */
> +	if (IS_ENABLED(CONFIG_FRAME_POINTER))
> +		return 1;
> +	return (regs->flags & PERF_EFLAGS_SNAP);
> +}
> +
>  void
>  perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
>  {
> @@ -2366,11 +2378,17 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  		return;
>  	}
>  
> -	if (perf_callchain_store(entry, regs->ip))
> +	if (valid_unwinding_registers(regs)) {
> +		if (perf_callchain_store(entry, regs->ip))
> +			return;
> +		unwind_start(&state, current, regs, NULL);
> +	} else if (regs->sp) {
> +		unwind_start(&state, current, NULL, (unsigned long *)regs->sp);
> +	} else {
>  		return;
> +	}
>  
> -	for (unwind_start(&state, current, regs, NULL); !unwind_done(&state);
> -	     unwind_next_frame(&state)) {
> +	for (; !unwind_done(&state); unwind_next_frame(&state)) {
>  		addr = unwind_get_return_address(&state);
>  		if (!addr || perf_callchain_store(entry, addr))
>  			return;
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 8bdf74902293..77c8519512ff 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -239,11 +239,16 @@ extern void perf_events_lapic_init(void);
>   * Abuse bits {3,5} of the cpu eflags register. These flags are otherwise
>   * unused and ABI specified to be 0, so nobody should care what we do with
>   * them.
> + * And also leverage X86_EFLAGS_FIXED (bit 1). This bit is reserved as
> + * always set.
>   *
> + * SNAP  - flags is considered a real snapshot captured upon event
> + *         is triggered.
>   * EXACT - the IP points to the exact instruction that triggered the
>   *         event (HW bugs exempt).
>   * VM    - original X86_VM_MASK; see set_linear_ip().
>   */
> +#define PERF_EFLAGS_SNAP	X86_EFLAGS_FIXED
>  #define PERF_EFLAGS_EXACT	(1UL << 3)
>  #define PERF_EFLAGS_VM		(1UL << 5)
>  
> diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
> index f335aad404a4..226077e20412 100644
> --- a/arch/x86/include/asm/stacktrace.h
> +++ b/arch/x86/include/asm/stacktrace.h
> @@ -98,18 +98,23 @@ struct stack_frame_ia32 {
>      u32 return_address;
>  };
>  
> +#ifdef CONFIG_FRAME_POINTER
>  static inline unsigned long caller_frame_pointer(void)
>  {
>  	struct stack_frame *frame;
>  
>  	frame = __builtin_frame_address(0);
>  
> -#ifdef CONFIG_FRAME_POINTER
>  	frame = frame->next_frame;
> -#endif
>  
>  	return (unsigned long)frame;
>  }
> +#else
> +static inline unsigned long caller_frame_pointer(void)
> +{
> +	return 0;
> +}
> +#endif
>  
>  void show_opcodes(struct pt_regs *regs, const char *loglvl);
>  void show_ip(struct pt_regs *regs, const char *loglvl);
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e47ef764f613..07bcb1870220 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1055,11 +1055,11 @@ static inline void perf_arch_fetch_caller_regs(struct pt_regs *regs, unsigned lo
>  #endif
>  
>  /*
> - * Take a snapshot of the regs. Skip ip and frame pointer to
> - * the nth caller. We only need a few of the regs:
> + * Take a partial snapshot of the caller's regs.
> + * We only need a few of the regs:
>   * - ip for PERF_SAMPLE_IP
>   * - cs for user_mode() tests
> - * - bp for callchains
> + * - sp, bp for callchains
>   * - eflags, for future purposes, just in case
>   */
>  static inline void perf_fetch_caller_regs(struct pt_regs *regs)

I still don't like using regs->bp because it results in different code
paths for FP and ORC.  In the FP case, the regs are treated like real
regs even though they're fake.

Something like the below would be much simpler.  Would this work?  I don't
know if any other code relies on the fake regs->bp or regs->sp.

(BTW, tomorrow is a US holiday so I may not be very responsive until
Monday.)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index de1a924a4914..f315425d8468 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2382,6 +2382,15 @@ void arch_perf_update_userpage(struct perf_event *event,
 	cyc2ns_read_end();
 }
 
+/*
+ * Determine whether the regs were taken from an irq/exception handler rather
+ * than from perf_arch_fetch_caller_regs().
+ */
+static bool perf_hw_regs(struct pt_regs *regs)
+{
+	return regs->flags & X86_EFLAGS_FIXED;
+}
+
 void
 perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
@@ -2393,11 +2402,15 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 		return;
 	}
 
-	if (perf_callchain_store(entry, regs->ip))
-		return;
+	if (perf_hw_regs(regs)) {
+		if (perf_callchain_store(entry, regs->ip))
+			return;
+		unwind_start(&state, current, regs, NULL);
+	} else {
+		unwind_start(&state, current, NULL, (void *)regs->sp);
+	}
 
-	for (unwind_start(&state, current, regs, NULL); !unwind_done(&state);
-	     unwind_next_frame(&state)) {
+	for (; !unwind_done(&state); unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
 		if (!addr || perf_callchain_store(entry, addr))
 			return;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 04768a3a5454..1392d5e6e8d6 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -308,14 +308,9 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
  */
 #define perf_arch_fetch_caller_regs(regs, __ip)		{	\
 	(regs)->ip = (__ip);					\
-	(regs)->bp = caller_frame_pointer();			\
+	(regs)->sp = (unsigned long)__builtin_frame_address(0);	\
 	(regs)->cs = __KERNEL_CS;				\
 	regs->flags = 0;					\
-	asm volatile(						\
-		_ASM_MOV "%%"_ASM_SP ", %0\n"			\
-		: "=m" ((regs)->sp)				\
-		:: "memory"					\
-	);							\
 }
 
 struct perf_guest_switch_msr {
diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index d6d758a187b6..a8d0cdf48616 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -100,19 +100,6 @@ struct stack_frame_ia32 {
     u32 return_address;
 };
 
-static inline unsigned long caller_frame_pointer(void)
-{
-	struct stack_frame *frame;
-
-	frame = __builtin_frame_address(0);
-
-#ifdef CONFIG_FRAME_POINTER
-	frame = frame->next_frame;
-#endif
-
-	return (unsigned long)frame;
-}
-
 void show_opcodes(struct pt_regs *regs, const char *loglvl);
 void show_ip(struct pt_regs *regs, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f3864e1c5569..0f560069aeec 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1062,7 +1062,7 @@ static inline void perf_arch_fetch_caller_regs(struct pt_regs *regs, unsigned lo
  * the nth caller. We only need a few of the regs:
  * - ip for PERF_SAMPLE_IP
  * - cs for user_mode() tests
- * - bp for callchains
+ * - sp for callchains
  * - eflags, for future purposes, just in case
  */
 static inline void perf_fetch_caller_regs(struct pt_regs *regs)
