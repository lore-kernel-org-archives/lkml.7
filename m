Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31495C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF002190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfGXLVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:21:06 -0400
Received: from foss.arm.com ([217.140.110.172]:39328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbfGXLVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:21:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E2B1509;
        Wed, 24 Jul 2019 04:21:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F4013F71A;
        Wed, 24 Jul 2019 04:21:04 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:21:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 1/2] kernel/fork: Add support for stack-end guard page
Message-ID: <20190724112101.GB2624@lakrids.cambridge.arm.com>
References: <20190719132818.40258-1-elver@google.com>
 <20190723164115.GB56959@lakrids.cambridge.arm.com>
 <CACT4Y+Y47_030eX-JiE1hFCyP5RiuTCSLZNKpTjuHwA5jQJ3+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y47_030eX-JiE1hFCyP5RiuTCSLZNKpTjuHwA5jQJ3+w@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:11:49AM +0200, Dmitry Vyukov wrote:
> On Tue, Jul 23, 2019 at 6:41 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Fri, Jul 19, 2019 at 03:28:17PM +0200, Marco Elver wrote:
> > > Enabling STACK_GUARD_PAGE helps catching kernel stack overflows immediately
> > > rather than causing difficult-to-diagnose corruption. Note that, unlike
> > > virtually-mapped kernel stacks, this will effectively waste an entire page of
> > > memory; however, this feature may provide extra protection in cases that cannot
> > > use virtually-mapped kernel stacks, at the cost of a page.
> > >
> > > The motivation for this patch is that KASAN cannot use virtually-mapped kernel
> > > stacks to detect stack overflows. An alternative would be implementing support
> > > for vmapped stacks in KASAN, but would add significant extra complexity.
> >
> > Do we have an idea as to how much additional complexity?
> 
> We would need to map/unmap shadow for vmalloc region on stack
> allocation/deallocation. We may need to track shadow pages that cover
> both stack and an unused memory, or 2 different stacks, which are
> mapped/unmapped at different times. This may have some concurrency
> concerns.  Not sure what about page tables for other CPU, I've seen
> some code that updates pages tables for vmalloc region lazily on page
> faults. Not sure what about TLBs. Probably also some problems that I
> can't thought about now.

Ok. So this looks big, we this hasn't been prototyped, so we don't have
a concrete idea. I agree that concurrency is likely to be painful. :)

[...]

> > > diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> > > index 288b065955b7..b218b5713c02 100644
> > > --- a/arch/x86/include/asm/page_64_types.h
> > > +++ b/arch/x86/include/asm/page_64_types.h
> > > @@ -12,8 +12,14 @@
> > >  #define KASAN_STACK_ORDER 0
> > >  #endif
> > >
> > > +#ifdef CONFIG_STACK_GUARD_PAGE
> > > +#define STACK_GUARD_SIZE PAGE_SIZE
> > > +#else
> > > +#define STACK_GUARD_SIZE 0
> > > +#endif
> > > +
> > >  #define THREAD_SIZE_ORDER    (2 + KASAN_STACK_ORDER)
> > > -#define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
> > > +#define THREAD_SIZE  ((PAGE_SIZE << THREAD_SIZE_ORDER) - STACK_GUARD_SIZE)
> >
> > I'm pretty sure that common code relies on THREAD_SIZE being a
> > power-of-two. I also know that if we wanted to enable this on arm64 that
> > would very likely be a requirement.
> >
> > For example, in kernel/trace/trace_stack.c we have:
> >
> > | this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
> >
> > ... and INIT_TASK_DATA() allocates the initial task stack using
> > THREAD_SIZE, so that may require special care, as it might not be sized
> > or aligned as you expect.
> 
> We've built it, booted it, stressed it, everything looked fine... that
> should have been a build failure.

I think it's been an implicit assumption for so long that no-one saw the need
for built-time assertions where they depend on it. 

I also suspect that in practice there are paths that you won't have
stressed in your environment, e.g. in the ACPI wakeup path where we end
up calling:

/* Unpoison the stack for the current task beyond a watermark sp value. */
asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
{
	/*
	 * Calculate the task stack base address.  Avoid using 'current'
	 * because this function is called by early resume code which hasn't
	 * yet set up the percpu register (%gs).
	 */
	void *base = (void *)((unsigned long)watermark & ~(THREAD_SIZE - 1));

	kasan_unpoison_shadow(base, watermark - base);
} 

> Is it a property that we need to preserve? Or we could fix the uses
> that assume power-of-2?

Generally, I think that those can be fixed up. Someone just needs to dig
through how THREAD_SIZE and THREAD_SIZE_ORDER are used to generate or
manipulate addresses.

For local-task stuff, I think it's easy to rewrite in terms of
task_stack_page(), but I'm not entirely sure what we'd do for cases
where we look at another task, e.g.

static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns, 
                                struct pid *pid, struct task_struct *task)
{
        unsigned long prev_depth = THREAD_SIZE -
                                (task->prev_lowest_stack & (THREAD_SIZE - 1)); 
        unsigned long depth = THREAD_SIZE -
                                (task->lowest_stack & (THREAD_SIZE - 1)); 

        seq_printf(m, "previous stack depth: %lu\nstack depth: %lu\n",
                                                        prev_depth, depth);
        return 0;
}

... as I'm not sure of the lifetime of task->stack relative to task. I
know that with THREAD_INFO_IN_TASK the stack can be freed while the task
is still live.

Thanks,
Mark.
