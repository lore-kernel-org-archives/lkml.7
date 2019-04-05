Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B88C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94629218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfDEPNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:13:17 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55695 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731692AbfDEPNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:13:16 -0400
Received: by mail-it1-f193.google.com with SMTP id y134so3402522itc.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uM/RVlnro6yZIq3fCY7OnwpfXD5lHXOV2rTBSf93blo=;
        b=aKyy55v50HNnwUMcAzRj5CaB6ZXBeApsiW4VwBQQoRvlL1YsKLq+fC9O2MF/PsonxX
         6uxiK6EgwTMYXzSHSJ5bbsZFTHAfqcuCBapC35eiK+ysLjZbiefw4cVD3I7wH/2t4y4I
         aqB7piJuehlB8RG0sO0zMRKzb7PJ2fLMTd0FmMDUkFP53nJA365ClicH2cL62FR5bv1A
         IzVW/vQoAfbjggEqmvvZj2tGYGDOdofvuodmoJBxTC4WborEaHp5ixVCgyhd/E88qngJ
         rMUgmBppw2zEe58Q29OhJHqvp/mXQDcQt39phzCWQgnKHd6PFPqDDXtUB1VFnFO5AI2F
         uhsg==
X-Gm-Message-State: APjAAAXjT3Vjob1owURvl3DpT6NW6X+Whsb/kWtPCbzXPHV7XqzNmKF4
        PJgH87DahE+smo/IBGfpBRwQa9rNrFZYxBcBpF8dOA==
X-Google-Smtp-Source: APXvYqzoltE3Q2WXLdZSP2TY3BmFiTmViFJBFF2T7s7dN5odwbyGKNgULJnALos4UH6XunS0s2+CCYBS3UrM5eubQsM=
X-Received: by 2002:a24:65c8:: with SMTP id u191mr9815489itb.137.1554477194539;
 Fri, 05 Apr 2019 08:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190404172545.20928-1-kasong@redhat.com> <20190405140929.pycfea7drnpb2sug@treble>
In-Reply-To: <20190405140929.pycfea7drnpb2sug@treble>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 5 Apr 2019 23:13:02 +0800
Message-ID: <CACPcB9f7v4SU37YWKmUr=+iFWqL8hRapp1GPX+H8ixvGwzHsHA@mail.gmail.com>
Subject: Re: [RFC PATCH] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 10:09 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Apr 05, 2019 at 01:25:45AM +0800, Kairui Song wrote:
> > Currently perf callchain is not working properly with ORC unwinder,
> > we'll get useless in kernel callchain like this:
> >
> > perf  6429 [000]    22.498450:             kmem:mm_page_alloc: page=0x176a17 pfn=1534487 order=0 migratetype=0 gfp_flags=GFP_KERNEL
> >         ffffffffbe23e32e __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >             7efdf7f7d3e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
> >             5651468729c1 [unknown] (/usr/bin/perf)
> >             5651467ee82a main+0x69a (/usr/bin/perf)
> >             7efdf7eaf413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
> >         5541f689495641d7 [unknown] ([unknown])
> >
> > Without CONFIG_FRAME_POINTER, bp is not reserved as frame pointer so
> > can't get callers frame pointer, instead current frame pointer is
> > returned when trying to fetch caller registers. The unwinder will error
> > out early, and end the stacktrace early.
> >
> > So instead of let the unwinder start with the dumped register, we start
> > it right where the unwinding started when the stacktrace is triggered by
> > trace event directly. And skip until the frame pointer is reached.
> >
> > This makes the callchain get the full in kernel stacktrace again:
> >
> > perf  6503 [000]  1567.570191:             kmem:mm_page_alloc: page=0x16c904 pfn=1493252 order=0 migratetype=0 gfp_flags=GFP_KERNEL
> >         ffffffffb523e2ae __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >         ffffffffb52383bd __get_free_pages+0xd (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >         ffffffffb52fd28a __pollwait+0x8a (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >         ffffffffb521426f perf_poll+0x2f (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >         ffffffffb52fe3e2 do_sys_poll+0x252 (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >         ffffffffb52ff027 __x64_sys_poll+0x37 (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >         ffffffffb500418b do_syscall_64+0x5b (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >         ffffffffb5a0008c entry_SYSCALL_64_after_hwframe+0x44 (/lib/modules/5.1.0-rc3+/build/vmlinux)
> >             7f71e92d03e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
> >             55a22960d9c1 [unknown] (/usr/bin/perf)
> >             55a22958982a main+0x69a (/usr/bin/perf)
> >             7f71e9202413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
> >         5541f689495641d7 [unknown] ([unknown])
> >
> > ----
> >
> > Just found with ORC unwinder the perf callchain is unusable, and this
> > seems fixes it well, any suggestion is welcome, thanks!
>
> Hi Kairui,
>
> Without CONFIG_FRAME_POINTER, the BP register has no meaning, so I don't
> see how this patch could work.
>
> Also, perf stack traces seem to work fine for me with ORC.  Can you give
> some details on how to recreate the issue?
>
> --
> Josh


Hi Josh, thanks for the review, I tried again, using latest upstream
kernel commit ea2cec24c8d429ee6f99040e4eb6c7ad627fe777:
# uname -a
Linux localhost.localdomain 5.1.0-rc3+ #29 SMP Fri Apr 5 22:53:05 CST
2019 x86_64 x86_64 x86_64 GNU/Linux

Having following config:
> CONFIG_UNWINDER_ORC=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
and CONFIG_FRAME_POINTER is off too.

Then record something with perf (also latest upstream version):
./perf record -g -e kmem:* -c 1

Interrupt it, then view the output:
perf script | less

Then I notice the stacktrace in kernle is incomplete like following.
Did I miss anything?
--------------
lvmetad   617 [000]    55.600786:                     kmem:kfree:
call_site=ffffffffb219e269 ptr=(nil)
        ffffffffb22b2d1c kfree+0x11c (/lib/modules/5.1.0-rc3+/build/vmlinux)
            7fba7e58fd0f __select+0x5f (/usr/lib64/libc-2.28.so)

kworker/u2:5-rp   171 [000]    55.628529:
kmem:kmem_cache_alloc: call_site=ffffffffb20e963d
ptr=0xffffa07f39c581e0 bytes_req=80 bytes_alloc=80
gfp_flags=GFP_ATOMIC
        ffffffffb22b0dec kmem_cache_alloc+0x13c
(/lib/modules/5.1.0-rc3+/build/vmlinux)
-------------

And for the patch, I debugged the problem, and found how it happend:
The reason is that we use following code for fetching the registers on
a trace point:
...snip...
#define perf_arch_fetch_caller_regs(regs, __ip) { \
(regs)->ip = (__ip); \
(regs)->bp = caller_frame_pointer(); \
(regs)->cs = __KERNEL_CS;
...snip...

It tries to dump the registers of caller, but in the definition of
caller_frame_pointer:
static inline unsigned long caller_frame_pointer(void)
{
struct stack_frame *frame;

frame = __builtin_frame_address(0);

#ifdef CONFIG_FRAME_POINTER
frame = frame->next_frame;
#endif

return (unsigned long)frame;
}

Without CONFIG_FRAME_POINTER, current frame pointer is returned instead.

The fetched BP value should be still valid in this case, maybe it's
not the real BP value but should be the frame pointer, as it's
returned by __builtin_frame_address. But this will cause the regs
variable to contain the IP of caller function (the function actually
trying to trace), and the BP of current function (a event probe
function). Unwinder will error out.

I think there is noway to get caller's frame without calling the
unwinder, but issue a unwinding call on event tracing point would be
over kill.
For call chain, regs here is only used to tell unwinder to start by
the given stack, IP and frame. If it's unusable, just start the
unwinder directly if the unwinder is started directly inside the event
trace point. That would garentee we will unwind to the event path. And
just skip all the part we won't want.

With this patch, it worked, i got the full stacktrace again, so I
assume I got it right... let me know if I'm making any mistake, thank
you!

-- 
Best Regards,
Kairui Song
