Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647BBC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238722253D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiyK4t8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfGXJME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:12:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47103 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfGXJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:12:04 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so87960705iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sRlylSNczuEnN2aNH3I85pbG0P7MfDaMqfGAEipuRs=;
        b=fiyK4t8LNXVZ8Wts4XLlCcQP+wWMU13USI8AilCSgciD91VrKhYTGpinAS8z1SY7Ly
         GUT2NNu1yc1UhVS5OJn2OvVshu/Rw4he4dIr3wazgKAAP6F9pbImM8Z7Zvt3HlLored1
         SVfZ4FcRO/LqCv2+6rmj/gfEV7WLOC0s1aLDf4oxHghX0izzR602S7K4VrKjNszbKUd4
         FRN3tbFDZzZZfhHYqLmKVMa7cr49ORE0esnOE5nEvbUJym9boLQ6dBkV/aEJ3POHIsyh
         0opcUxaMnSgr+Y0RUsbZpdo5pu8ABk747iG9aeM/P9pc23BS/vwPjXvuenrnI1bV1NIV
         Odbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sRlylSNczuEnN2aNH3I85pbG0P7MfDaMqfGAEipuRs=;
        b=nvm8zpSe5SORFfVopfbSXK6rDW2RygDcF+x2VIfe2U1/Zi0lAxM85MVHS18lC49PTw
         9Y0SiuVPhtdKoH9Ano03qNpH3BG/yzj1KKKK7uOZtYB8t6LMc8B6Z33Rz90rqFyAr884
         BsP8Lw7SqWT7pSxk3k+acCTClBIv+9BSf82opsuoBfFHf8kHvxTBAKLqCkeiam2CJTQb
         oS2ND+1uJgDJ+t79hDzEAwjF0RcXqeTB/QAQ3Ob/fvOAD6K+sYJJQGV87nCRorrrlco7
         cDChWphVS2QDzImo4tYIczLFiMClF8MCvRI26vqxlH4dz4jP7dFUwxGOLSbLMxEwlbY6
         U2sQ==
X-Gm-Message-State: APjAAAXt/J40+09y6GS71nn166/UbV3aM4S2BIe96vYdYgg1iEsD3jdP
        OZovfptTnsKh4yGW6INhBEZ3g2/6Ulg6pFh2LqKRuvBppizC0g==
X-Google-Smtp-Source: APXvYqw565UdWyxGdRP/kSKtDh8SC/tc0vvWCMy7/Xq1lFsi5A2aEQ+NyAcFXQXCdIw7+0m6wI1Iawc7yBMRYy2j5ak=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr70964257iop.58.1563959522535;
 Wed, 24 Jul 2019 02:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190719132818.40258-1-elver@google.com> <20190723164115.GB56959@lakrids.cambridge.arm.com>
In-Reply-To: <20190723164115.GB56959@lakrids.cambridge.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 Jul 2019 11:11:49 +0200
Message-ID: <CACT4Y+Y47_030eX-JiE1hFCyP5RiuTCSLZNKpTjuHwA5jQJ3+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/fork: Add support for stack-end guard page
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 6:41 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Jul 19, 2019 at 03:28:17PM +0200, Marco Elver wrote:
> > Enabling STACK_GUARD_PAGE helps catching kernel stack overflows immediately
> > rather than causing difficult-to-diagnose corruption. Note that, unlike
> > virtually-mapped kernel stacks, this will effectively waste an entire page of
> > memory; however, this feature may provide extra protection in cases that cannot
> > use virtually-mapped kernel stacks, at the cost of a page.
> >
> > The motivation for this patch is that KASAN cannot use virtually-mapped kernel
> > stacks to detect stack overflows. An alternative would be implementing support
> > for vmapped stacks in KASAN, but would add significant extra complexity.
>
> Do we have an idea as to how much additional complexity?

We would need to map/unmap shadow for vmalloc region on stack
allocation/deallocation. We may need to track shadow pages that cover
both stack and an unused memory, or 2 different stacks, which are
mapped/unmapped at different times. This may have some concurrency
concerns.  Not sure what about page tables for other CPU, I've seen
some code that updates pages tables for vmalloc region lazily on page
faults. Not sure what about TLBs. Probably also some problems that I
can't thought about now.


> > While the stack-end guard page approach here wastes a page, it is
> > significantly simpler than the alternative.  We assume that the extra
> > cost of a page can be justified in the cases where STACK_GUARD_PAGE
> > would be enabled.
> >
> > Note that in an earlier prototype of this patch, we used
> > 'set_memory_{ro,rw}' functions, which flush the TLBs. This, however,
> > turned out to be unacceptably expensive, especially when run with
> > fuzzers such as Syzkaller, as the kernel would encounter frequent RCU
> > timeouts. The current approach of not flushing the TLB is therefore
> > best-effort, but works in the test cases considered -- any comments on
> > better alternatives or improvements are welcome.
>
> Ouch. I don't think that necessarily applies to other architectures, and
> from my PoV it would be nicer if we could rely on regular vmap'd stacks.
> That way we have one code path, and we can rely on the fault.
>
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Andrey Konovalov <andreyknvl@google.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: kasan-dev@googlegroups.com
> > ---
> >  arch/Kconfig                         | 15 +++++++++++++++
> >  arch/x86/include/asm/page_64_types.h |  8 +++++++-
> >  include/linux/sched/task_stack.h     | 11 +++++++++--
> >  kernel/fork.c                        | 22 +++++++++++++++++++++-
> >  4 files changed, 52 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index e8d19c3cb91f..cca3258fff1f 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -935,6 +935,21 @@ config LOCK_EVENT_COUNTS
> >         the chance of application behavior change because of timing
> >         differences. The counts are reported via debugfs.
> >
> > +config STACK_GUARD_PAGE
> > +     default n
> > +     bool "Use stack-end page as guard page"
> > +     depends on !VMAP_STACK && ARCH_HAS_SET_DIRECT_MAP && THREAD_INFO_IN_TASK && !STACK_GROWSUP
> > +     help
> > +       Enable this if you want to use the stack-end page as a guard page.
> > +       This causes kernel stack overflows to be caught immediately rather
> > +       than causing difficult-to-diagnose corruption. Note that, unlike
> > +       virtually-mapped kernel stacks, this will effectively waste an entire
> > +       page of memory; however, this feature may provide extra protection in
> > +       cases that cannot use virtually-mapped kernel stacks, at the cost of
> > +       a page. Note that, this option does not implicitly increase the
> > +       default stack size. The main use-case is for KASAN to avoid reporting
> > +       misleading bugs due to stack overflow.
>
> These dependencies can also be satisfied on arm64, but I don't believe
> this will work correctly there, and we'll need something like a
> ARCH_HAS_STACK_GUARD_PAGE symbol so that x86 can opt-in.
>
> On arm64 our exception vectors don't specify an alternative stack, so we
> don't have a direct equivalent to x86 double-fault handler. Our kernel
> stack overflow handling requires explicit tests in the entry assembly
> that are only built (or valid) when VMAP_STACK is selected.
>
> > +
> >  source "kernel/gcov/Kconfig"
> >
> >  source "scripts/gcc-plugins/Kconfig"
> > diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> > index 288b065955b7..b218b5713c02 100644
> > --- a/arch/x86/include/asm/page_64_types.h
> > +++ b/arch/x86/include/asm/page_64_types.h
> > @@ -12,8 +12,14 @@
> >  #define KASAN_STACK_ORDER 0
> >  #endif
> >
> > +#ifdef CONFIG_STACK_GUARD_PAGE
> > +#define STACK_GUARD_SIZE PAGE_SIZE
> > +#else
> > +#define STACK_GUARD_SIZE 0
> > +#endif
> > +
> >  #define THREAD_SIZE_ORDER    (2 + KASAN_STACK_ORDER)
> > -#define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
> > +#define THREAD_SIZE  ((PAGE_SIZE << THREAD_SIZE_ORDER) - STACK_GUARD_SIZE)
>
> I'm pretty sure that common code relies on THREAD_SIZE being a
> power-of-two. I also know that if we wanted to enable this on arm64 that
> would very likely be a requirement.
>
> For example, in kernel/trace/trace_stack.c we have:
>
> | this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
>
> ... and INIT_TASK_DATA() allocates the initial task stack using
> THREAD_SIZE, so that may require special care, as it might not be sized
> or aligned as you expect.


We've built it, booted it, stressed it, everything looked fine... that
should have been a build failure.
Is it a property that we need to preserve? Or we could fix the uses
that assume power-of-2?


> >  #define EXCEPTION_STACK_ORDER (0 + KASAN_STACK_ORDER)
> >  #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
> > diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> > index 2413427e439c..7ee86ad0a282 100644
> > --- a/include/linux/sched/task_stack.h
> > +++ b/include/linux/sched/task_stack.h
> > @@ -11,6 +11,13 @@
> >
> >  #ifdef CONFIG_THREAD_INFO_IN_TASK
> >
> > +#ifndef STACK_GUARD_SIZE
> > +#ifdef CONFIG_STACK_GUARD_PAGE
> > +#error "Architecture not compatible with STACK_GUARD_PAGE"
> > +#endif
> > +#define STACK_GUARD_SIZE 0
> > +#endif
>
> The core code you add assumes that when enabled, this is PAGE_SIZE, so
> I think the definition should live in a common header.
>
> As above, it should not be possible to select CONFIG_STACK_GUARD_PAGE
> unless the architecture supports it. If nothing else, this avoids
> getting bug reports on randconfigs.
>
> Thanks,
> Mark.
>
> > +
> >  /*
> >   * When accessing the stack of a non-current task that might exit, use
> >   * try_get_task_stack() instead.  task_stack_page will return a pointer
> > @@ -18,14 +25,14 @@
> >   */
> >  static inline void *task_stack_page(const struct task_struct *task)
> >  {
> > -     return task->stack;
> > +     return task->stack + STACK_GUARD_SIZE;
> >  }
> >
> >  #define setup_thread_stack(new,old)  do { } while(0)
> >
> >  static inline unsigned long *end_of_stack(const struct task_struct *task)
> >  {
> > -     return task->stack;
> > +     return task->stack + STACK_GUARD_SIZE;
> >  }
> >
> >  #elif !defined(__HAVE_THREAD_FUNCTIONS)
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index d8ae0f1b4148..22033b03f7da 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -94,6 +94,7 @@
> >  #include <linux/livepatch.h>
> >  #include <linux/thread_info.h>
> >  #include <linux/stackleak.h>
> > +#include <linux/set_memory.h>
> >
> >  #include <asm/pgtable.h>
> >  #include <asm/pgalloc.h>
> > @@ -249,6 +250,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >                                            THREAD_SIZE_ORDER);
> >
> >       if (likely(page)) {
> > +             if (IS_ENABLED(CONFIG_STACK_GUARD_PAGE)) {
> > +                     /*
> > +                      * Best effort: do not flush TLB to avoid the overhead
> > +                      * of flushing all TLBs.
> > +                      */
> > +                     set_direct_map_invalid_noflush(page);
> > +             }
> > +
> >               tsk->stack = page_address(page);
> >               return tsk->stack;
> >       }
> > @@ -258,6 +267,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >
> >  static inline void free_thread_stack(struct task_struct *tsk)
> >  {
> > +     struct page* stack_page;
> >  #ifdef CONFIG_VMAP_STACK
> >       struct vm_struct *vm = task_stack_vm_area(tsk);
> >
> > @@ -285,7 +295,17 @@ static inline void free_thread_stack(struct task_struct *tsk)
> >       }
> >  #endif
> >
> > -     __free_pages(virt_to_page(tsk->stack), THREAD_SIZE_ORDER);
> > +     stack_page = virt_to_page(tsk->stack);
> > +
> > +     if (IS_ENABLED(CONFIG_STACK_GUARD_PAGE)) {
> > +             /*
> > +              * Avoid flushing TLBs, and instead rely on spurious fault
> > +              * detection of stale TLBs.
> > +              */
> > +             set_direct_map_default_noflush(stack_page);
> > +     }
> > +
> > +     __free_pages(stack_page, THREAD_SIZE_ORDER);
> >  }
> >  # else
> >  static struct kmem_cache *thread_stack_cache;
> > --
> > 2.22.0.657.g960e92d24f-goog
> >
