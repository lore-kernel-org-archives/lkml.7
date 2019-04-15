Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51FCC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B1220693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfDOMiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:38:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbfDOMiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:38:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0B37307D868;
        Mon, 15 Apr 2019 12:38:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7F8B45D70E;
        Mon, 15 Apr 2019 12:38:10 +0000 (UTC)
Date:   Mon, 15 Apr 2019 14:38:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v2] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190415123809.GA25190@krava>
References: <20190408165942.23640-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408165942.23640-1-kasong@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 15 Apr 2019 12:38:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 12:59:42AM +0800, Kairui Song wrote:
> Currently perf callchain is not working properly with ORC unwinder,
> and sampling event from trace point. We'll get useless in kernel
> callchain like this:
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
> caller's register, but without CONFIG_FRAME_POINTER we can't get
> caller's BP as the frame pointer, so current frame pointer is returned
> instead. We get a register combination of caller IP and current BP,
> which confuse the unwinder and end the stacktrace early.
> 
> So in such case don't dump BP, and just let the unwinder start directly
> and skip until we reached the stack we wanted.
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

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
> 
> Update from V1:
>   Get rid of a lot of unneccessary code and just don't dump a inaccurate
>   BP, and use SP as the marker for target frame.
> 
>  arch/x86/events/core.c            | 18 +++++++++++++++---
>  arch/x86/include/asm/stacktrace.h |  9 +++++++--
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index e2b1447192a8..6075a4f94376 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2355,6 +2355,12 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	cyc2ns_read_end();
>  }
>  
> +static inline int
> +valid_perf_registers(struct pt_regs *regs)
> +{
> +	return (regs->ip && regs->bp && regs->sp);
> +}
> +
>  void
>  perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
>  {
> @@ -2366,11 +2372,17 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  		return;
>  	}
>  
> -	if (perf_callchain_store(entry, regs->ip))
> +	if (valid_perf_registers(regs)) {
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
> -- 
> 2.20.1
> 
