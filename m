Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA65C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E3021736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfDSCSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:18:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39244 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfDSCSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 22:18:01 -0400
Received: by mail-io1-f65.google.com with SMTP id e13so3455325ioq.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 19:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwBZzd//g9QMXA36h/ZVXcmw48M67202LeN6NFSg5P4=;
        b=M/LgXH2sV87grFCD0WzLVAwckYlaP+WRe9Ok4elU8APTyDuK5gz+8aRNJOSMEdMy4v
         CL/0xcuQoUoVaJCKHlcvKONvdDp+NR9C261Z4F4mNEdnWDPMqAnf6W8MR1W7RLbxUtst
         v7SaxgC+qW2p4tzSWimt9HIZT3Q5j2rryYPd2PsS9ZZFIXsRB77ffIb7YPH299IsrjpI
         KQodFEZqM20fixYyUYDs72BXSUOzCFA2d8lFYnFYDWo5cNrZgXK9bmQSPw1tYOaG2Lu7
         noGeBSfL2Dj+86YGTx+vG44ynQhjjMfA6FSKt3wSi1nSGy+QcNw0gZnAcvhWfmEM4mVY
         Wf2A==
X-Gm-Message-State: APjAAAWkM2mMm0Pvm4SFXZCYvYyM7rrr6I+Ms5mnsmt0lxI13gLkF2JF
        vOfSps5Kyc6ON2jRCiKQN5jtWUrU7yFEbWqanrseoQ==
X-Google-Smtp-Source: APXvYqwqhpzP0TlV/VgDhm3zeOdiqq2pQFN6Y/Ztz7sdLaLUJIGTZANfGVkQT10/XVPl4IbFLAqNJHBJ40vEVrBtgUg=
X-Received: by 2002:a5d:8757:: with SMTP id k23mr1257858iol.68.1555640280294;
 Thu, 18 Apr 2019 19:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190418160730.11901-1-kasong@redhat.com> <20190419005821.ttlpav7gviaed7am@treble>
In-Reply-To: <20190419005821.ttlpav7gviaed7am@treble>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 19 Apr 2019 10:17:49 +0800
Message-ID: <CACPcB9fsYqs+xaj6w6ExKdpi-Pk4RqiD5HxTyURpee_arYQANg@mail.gmail.com>
Subject: Re: [RFC PATCH v3] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 8:58 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> I still don't like using regs->bp because it results in different code
> paths for FP and ORC.  In the FP case, the regs are treated like real
> regs even though they're fake.
>
> Something like the below would be much simpler.  Would this work?  I don't
> know if any other code relies on the fake regs->bp or regs->sp.

Works perfectly. My only concern is that FP path used to work very
well, not sure it's a good idea to change it, and this may bring some
extra overhead for FP path.

>
> (BTW, tomorrow is a US holiday so I may not be very responsive until
> Monday.)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index de1a924a4914..f315425d8468 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2382,6 +2382,15 @@ void arch_perf_update_userpage(struct perf_event *event,
>         cyc2ns_read_end();
>  }
>
> +/*
> + * Determine whether the regs were taken from an irq/exception handler rather
> + * than from perf_arch_fetch_caller_regs().
> + */
> +static bool perf_hw_regs(struct pt_regs *regs)
> +{
> +       return regs->flags & X86_EFLAGS_FIXED;
> +}
> +
>  void
>  perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
>  {
> @@ -2393,11 +2402,15 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>                 return;
>         }
>
> -       if (perf_callchain_store(entry, regs->ip))
> -               return;
> +       if (perf_hw_regs(regs)) {
> +               if (perf_callchain_store(entry, regs->ip))
> +                       return;
> +               unwind_start(&state, current, regs, NULL);
> +       } else {
> +               unwind_start(&state, current, NULL, (void *)regs->sp);
> +       }
>
> -       for (unwind_start(&state, current, regs, NULL); !unwind_done(&state);
> -            unwind_next_frame(&state)) {
> +       for (; !unwind_done(&state); unwind_next_frame(&state)) {
>                 addr = unwind_get_return_address(&state);
>                 if (!addr || perf_callchain_store(entry, addr))
>                         return;
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 04768a3a5454..1392d5e6e8d6 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -308,14 +308,9 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>   */
>  #define perf_arch_fetch_caller_regs(regs, __ip)                {       \
>         (regs)->ip = (__ip);                                    \
> -       (regs)->bp = caller_frame_pointer();                    \
> +       (regs)->sp = (unsigned long)__builtin_frame_address(0); \
>         (regs)->cs = __KERNEL_CS;                               \
>         regs->flags = 0;                                        \
> -       asm volatile(                                           \
> -               _ASM_MOV "%%"_ASM_SP ", %0\n"                   \
> -               : "=m" ((regs)->sp)                             \
> -               :: "memory"                                     \
> -       );                                                      \
>  }
>
>  struct perf_guest_switch_msr {
> diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
> index d6d758a187b6..a8d0cdf48616 100644
> --- a/arch/x86/include/asm/stacktrace.h
> +++ b/arch/x86/include/asm/stacktrace.h
> @@ -100,19 +100,6 @@ struct stack_frame_ia32 {
>      u32 return_address;
>  };
>
> -static inline unsigned long caller_frame_pointer(void)
> -{
> -       struct stack_frame *frame;
> -
> -       frame = __builtin_frame_address(0);
> -
> -#ifdef CONFIG_FRAME_POINTER
> -       frame = frame->next_frame;
> -#endif
> -
> -       return (unsigned long)frame;
> -}
> -
>  void show_opcodes(struct pt_regs *regs, const char *loglvl);
>  void show_ip(struct pt_regs *regs, const char *loglvl);
>  #endif /* _ASM_X86_STACKTRACE_H */
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f3864e1c5569..0f560069aeec 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1062,7 +1062,7 @@ static inline void perf_arch_fetch_caller_regs(struct pt_regs *regs, unsigned lo
>   * the nth caller. We only need a few of the regs:
>   * - ip for PERF_SAMPLE_IP
>   * - cs for user_mode() tests
> - * - bp for callchains
> + * - sp for callchains
>   * - eflags, for future purposes, just in case
>   */
>  static inline void perf_fetch_caller_regs(struct pt_regs *regs)

-- 
Best Regards,
Kairui Song
