Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B82CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D555821855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j3MErZPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfDEHz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:55:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfDEHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hSCoH375imCrsPBrV3MZSJaxDjhAhZHTukSSI0h4QLA=; b=j3MErZPbW4xXTAGOQC8tdL5GP
        hCw4Fe8FCmX9z45Ca6hTCj2qa2PuVQlc03SAiXGh9sbMBu8sdGtMQVSLkPimMNL7COIOrixg9/At1
        cCtGioqftMuxP7a1lKPPwVY482nixeb8QkSz58A/APp04aW9oT8wCFy1fFjHT4DRz3jMX1dPLkHYU
        jbhoqDqrmWbhoCoCdC8y2SEqcO82LQao7Hp+W4gYexAWDj84DaksWhyp6SfzBxHE0tdCQiCvZ3MLL
        z5g27ly/ap4EjmIg3Yk5O2avj+nLOxHKk3GsBrhwTNPy4yIB63+yXby3am3QPRl+IJprk3ZdAu9QN
        6gYFdw//g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCJ61-0004k8-R5; Fri, 05 Apr 2019 07:17:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31AA323954638; Fri,  5 Apr 2019 09:17:04 +0200 (CEST)
Date:   Fri, 5 Apr 2019 09:17:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190405071704.GC4038@hirez.programming.kicks-ass.net>
References: <20190404172545.20928-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404172545.20928-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


And you forgot to Cc Josh..

On Fri, Apr 05, 2019 at 01:25:45AM +0800, Kairui Song wrote:
> Currently perf callchain is not working properly with ORC unwinder,
> we'll get useless in kernel callchain like this:
> 
> perf  6429 [000]    22.498450:             kmem:mm_page_alloc: page=0x176a17 pfn=1534487 order=0 migratetype=0 gfp_flags=GFP_KERNEL
>         ffffffffbe23e32e __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
>             7efdf7f7d3e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
>             5651468729c1 [unknown] (/usr/bin/perf)
>             5651467ee82a main+0x69a (/usr/bin/perf)
>             7efdf7eaf413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
>         5541f689495641d7 [unknown] ([unknown])
> 
> Without CONFIG_FRAME_POINTER, bp is not reserved as frame pointer so
> can't get callers frame pointer, instead current frame pointer is
> returned when trying to fetch caller registers. The unwinder will error
> out early, and end the stacktrace early.
> 
> So instead of let the unwinder start with the dumped register, we start
> it right where the unwinding started when the stacktrace is triggered by
> trace event directly. And skip until the frame pointer is reached.
> 
> This makes the callchain get the full in kernel stacktrace again:
> 
> perf  6503 [000]  1567.570191:             kmem:mm_page_alloc: page=0x16c904 pfn=1493252 order=0 migratetype=0 gfp_flags=GFP_KERNEL
>         ffffffffb523e2ae __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb52383bd __get_free_pages+0xd (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb52fd28a __pollwait+0x8a (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb521426f perf_poll+0x2f (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb52fe3e2 do_sys_poll+0x252 (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb52ff027 __x64_sys_poll+0x37 (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb500418b do_syscall_64+0x5b (/lib/modules/5.1.0-rc3+/build/vmlinux)
>         ffffffffb5a0008c entry_SYSCALL_64_after_hwframe+0x44 (/lib/modules/5.1.0-rc3+/build/vmlinux)
>             7f71e92d03e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
>             55a22960d9c1 [unknown] (/usr/bin/perf)
>             55a22958982a main+0x69a (/usr/bin/perf)
>             7f71e9202413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
>         5541f689495641d7 [unknown] ([unknown])
> 
> ----
> 
> Just found with ORC unwinder the perf callchain is unusable, and this
> seems fixes it well, any suggestion is welcome, thanks!

That whole .direct stuff is horrible crap.

> ---
>  arch/x86/events/core.c     | 34 ++++++++++++++++++++++++++++------
>  include/linux/perf_event.h |  3 ++-
>  kernel/bpf/stackmap.c      |  4 ++--
>  kernel/events/callchain.c  | 13 +++++++++++--
>  kernel/events/core.c       |  2 +-
>  5 files changed, 44 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index e2b1447192a8..3f3e110794ac 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2355,8 +2355,9 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	cyc2ns_read_end();
>  }
>  
> -void
> -perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
> +static void
> +__perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs,
> +			bool direct_call)
>  {
>  	struct unwind_state state;
>  	unsigned long addr;
> @@ -2366,17 +2367,38 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  		return;
>  	}
>  
> -	if (perf_callchain_store(entry, regs->ip))
> -		return;
> +	/*
> +	 * Without frame pointer, we can't get a reliable caller bp value.
> +	 * If this is called directly from a trace point, just start the
> +	 * unwind from here and skip until the frame is reached.
> +	 */
> +	if (IS_ENABLED(CONFIG_FRAME_POINTER) || !direct_call) {
> +		if (perf_callchain_store(entry, regs->ip))
> +			return;
> +		unwind_start(&state, current, regs, NULL);
> +	} else {
> +		unwind_start(&state, current, NULL, (unsigned long*)regs->bp);
> +	}
>  
> -	for (unwind_start(&state, current, regs, NULL); !unwind_done(&state);
> -	     unwind_next_frame(&state)) {
> +	for (; !unwind_done(&state); unwind_next_frame(&state)) {
>  		addr = unwind_get_return_address(&state);
>  		if (!addr || perf_callchain_store(entry, addr))
>  			return;
>  	}
>  }
>  
> +void
> +perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
> +{
> +	__perf_callchain_kernel(entry, regs, false);
> +}
> +
> +void
> +perf_callchain_kernel_direct(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
> +{
> +	__perf_callchain_kernel(entry, regs, true);
> +}
> +
>  static inline int
>  valid_user_frame(const void __user *fp, unsigned long size)
>  {
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e47ef764f613..b0e33ba36695 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1154,9 +1154,10 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
>  
>  extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>  extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
> +extern void perf_callchain_kernel_direct(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>  extern struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> -		   u32 max_stack, bool crosstask, bool add_mark);
> +		   u32 max_stack, bool crosstask, bool add_mark, bool direct_call);
>  extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
>  extern int get_callchain_buffers(int max_stack);
>  extern void put_callchain_buffers(void);
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 950ab2f28922..376d774da6b5 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -368,7 +368,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>  		return -EINVAL;
>  
>  	trace = get_perf_callchain(regs, init_nr, kernel, user,
> -				   sysctl_perf_event_max_stack, false, false);
> +				   sysctl_perf_event_max_stack, false, false, false);
>  
>  	if (unlikely(!trace))
>  		/* couldn't fetch the stack trace */
> @@ -476,7 +476,7 @@ BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, void *, buf, u32, size,
>  	else
>  		init_nr = sysctl_perf_event_max_stack - num_elem;
>  	trace = get_perf_callchain(regs, init_nr, kernel, user,
> -				   sysctl_perf_event_max_stack, false, false);
> +				   sysctl_perf_event_max_stack, false, false, false);
>  	if (unlikely(!trace))
>  		goto err_fault;
>  
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index c2b41a263166..4cb5861f57ee 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -40,6 +40,12 @@ __weak void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
>  {
>  }
>  
> +__weak void perf_callchain_kernel_direct(struct perf_callchain_entry_ctx *entry,
> +				  struct pt_regs *regs)
> +{
> +	perf_callchain_kernel(entry, regs);
> +}
> +
>  __weak void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  				struct pt_regs *regs)
>  {
> @@ -176,7 +182,7 @@ put_callchain_entry(int rctx)
>  
>  struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> -		   u32 max_stack, bool crosstask, bool add_mark)
> +		   u32 max_stack, bool crosstask, bool add_mark, bool direct_call)
>  {
>  	struct perf_callchain_entry *entry;
>  	struct perf_callchain_entry_ctx ctx;
> @@ -198,7 +204,10 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
>  	if (kernel && !user_mode(regs)) {
>  		if (add_mark)
>  			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
> -		perf_callchain_kernel(&ctx, regs);
> +		if (direct_call)
> +			perf_callchain_kernel_direct(&ctx, regs);
> +		else
> +			perf_callchain_kernel(&ctx, regs);
>  	}
>  
>  	if (user) {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 72d06e302e99..af9fb9b03283 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6377,7 +6377,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  		return &__empty_callchain;
>  
>  	callchain = get_perf_callchain(regs, 0, kernel, user,
> -				       max_stack, crosstask, true);
> +				       max_stack, crosstask, true, true);
>  	return callchain ?: &__empty_callchain;
>  }
>  
> -- 
> 2.20.1
> 
