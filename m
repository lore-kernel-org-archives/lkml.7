Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68FDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFF0218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfDXMmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:42:53 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54120 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDXMmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:42:52 -0400
Received: by mail-it1-f196.google.com with SMTP id z4so1798821itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qH/I56NCmI+3may9AdNh6uFn3lE6ttyh9s1gBQhKvDQ=;
        b=qq7ojNIhdRydTIowX7GuTeBGSz837WT1oQxJdnyF/b4dyUWHwxrCTf6//fbAuFoz9v
         TMYmTfxFIh38Jl+wSYbuVfDcBuCsvHcXTik/kE+rSUyMIsj4ZWdoE0mRsMcL3R3OqJi0
         ttuje8fHat0/LGyB8JKOS8pSLgMXsHLymMQoVfgelVUMxmQIxUcors4r1PpMl3MdMH5r
         5HTP9a60IAUQrrMwq0jUnTe7318AWy7E1BtMMeZGuBBzt9/taj2T7g+IhnymbOi/DguU
         1CXi5NuvgbGNKtsty/EGJfN8cy9qCuOcvSVGdcpeP8YpzmIyOUcNLbkojVX+ZQ/Lazxl
         u/Hg==
X-Gm-Message-State: APjAAAUQqyfX6kFxNG2rijJSElQfzbW0gQuVozNxkFUkrJmeavZsIZxE
        rwGCMwGP84WXtUpMZsYZfOKzbpMTbnX1wwiKj7ZSMw==
X-Google-Smtp-Source: APXvYqyUFghu0iQIiqb8pqbPxqXg+lnH3PW9fjXo1+rpNltWh5fHtBrvbWhCZFbiyelRPIp+UBBvfVpKX4UNxdjAk4w=
X-Received: by 2002:a02:3342:: with SMTP id k2mr20225459jak.15.1556109771692;
 Wed, 24 Apr 2019 05:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190422162652.15483-1-kasong@redhat.com> <20190423113501.GN11158@hirez.programming.kicks-ass.net>
In-Reply-To: <20190423113501.GN11158@hirez.programming.kicks-ass.net>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 24 Apr 2019 08:42:40 -0400
Message-ID: <CACPcB9f8JuALCw1i-V2N01GuTQRfjrCya6esOTM8dGwvf+oT7w@mail.gmail.com>
Subject: Re: [RFC PATCH v4] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 7:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Apr 23, 2019 at 12:26:52AM +0800, Kairui Song wrote:
> > Currently perf callchain doesn't work well with ORC unwinder
> > when sampling from trace point. We'll get useless in kernel callchain
> > like this:
> >
> > perf  6429 [000]    22.498450:             kmem:mm_page_alloc: page=0x176a17 pfn=1534487 order=0 migratetype=0 gfp_flags=GFP_KERNEL
> >     ffffffffbe23e32e __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >       7efdf7f7d3e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
> >       5651468729c1 [unknown] (/usr/bin/perf)
> >       5651467ee82a main+0x69a (/usr/bin/perf)
> >       7efdf7eaf413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
> >     5541f689495641d7 [unknown] ([unknown])
> >
> > The root cause is that, for trace point events, it doesn't provide a
> > real snapshot of the hardware registers. Instead perf tries to get
> > required caller's registers and compose a fake register snapshot
> > which suppose to contain enough information for start a unwinding.
> > However without CONFIG_FRAME_POINTER, if failed to get caller's BP as the
> > frame pointer, so current frame pointer is returned instead. We get
> > a invalid register combination which confuse the unwinder, and end the
> > stacktrace early.
> >
> > So in such case just don't try dump BP, and let the unwinder start
> > directly when the register is not a real snapshot. And Use SP
> > as the skip mark, unwinder will skip all the frames until it meet
> > the frame of the trace point caller.
> >
> > Tested with frame pointer unwinder and ORC unwinder, this make perf
> > callchain get the full kernel space stacktrace again like this:
> >
> > perf  6503 [000]  1567.570191:             kmem:mm_page_alloc: page=0x16c904 pfn=1493252 order=0 migratetype=0 gfp_flags=GFP_KERNEL
> >     ffffffffb523e2ae __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >     ffffffffb52383bd __get_free_pages+0xd (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >     ffffffffb52fd28a __pollwait+0x8a (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >     ffffffffb521426f perf_poll+0x2f (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >     ffffffffb52fe3e2 do_sys_poll+0x252 (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >     ffffffffb52ff027 __x64_sys_poll+0x37 (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >     ffffffffb500418b do_syscall_64+0x5b (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >     ffffffffb5a0008c entry_SYSCALL_64_after_hwframe+0x44 (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >       7f71e92d03e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
> >       55a22960d9c1 [unknown] (/usr/bin/perf)
> >       55a22958982a main+0x69a (/usr/bin/perf)
> >       7f71e9202413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
> >     5541f689495641d7 [unknown] ([unknown])
> >
> > Co-developed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Kairui Song <kasong@redhat.com>
>
> Thanks!
>
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index e47ef764f613..ab135abe62e0 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1059,7 +1059,7 @@ static inline void perf_arch_fetch_caller_regs(struct pt_regs *regs, unsigned lo
> >   * the nth caller. We only need a few of the regs:
> >   * - ip for PERF_SAMPLE_IP
> >   * - cs for user_mode() tests
> > - * - bp for callchains
> > + * - sp for callchains
> >   * - eflags, for future purposes, just in case
> >   */
> >  static inline void perf_fetch_caller_regs(struct pt_regs *regs)
>
> I've extended that like so:
>
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1058,12 +1058,18 @@ static inline void perf_arch_fetch_calle
>  #endif
>
>  /*
> - * Take a snapshot of the regs. Skip ip and frame pointer to
> - * the nth caller. We only need a few of the regs:
> + * When generating a perf sample in-line, instead of from an interrupt /
> + * exception, we lack a pt_regs. This is typically used from software events
> + * like: SW_CONTEXT_SWITCHES, SW_MIGRATIONS and the tie-in with tracepoints.
> + *
> + * We typically don't need a full set, but (for x86) do require:
>   * - ip for PERF_SAMPLE_IP
>   * - cs for user_mode() tests
> - * - sp for callchains
> - * - eflags, for future purposes, just in case
> + * - sp for PERF_SAMPLE_CALLCHAIN
> + * - eflags for MISC bits and CALLCHAIN (see: perf_hw_regs())
> + *
> + * NOTE: assumes @regs is otherwise already 0 filled; this is important for
> + * things like PERF_SAMPLE_REGS_INTR.
>   */
>  static inline void perf_fetch_caller_regs(struct pt_regs *regs)
>  {

Sure, the updated comments looks much better. Will the maintainer
squash the comment update or should I send a V5?

--
Best Regards,
Kairui Song
