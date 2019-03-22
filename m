Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E837C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E12218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553223151;
	bh=2NpbcW6cxEiyvRyH1XuHWQ1FUFXWq2d4xM5L+GBfKpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d1uSkXilRM+MdKdgBmJ/3T0wdzCR3BADaYiccE13lKc1GUDfDptVAYDgotK10p0KJ
	 ayKE7LLLUt6/0qpfnZdoiZwgPkFDnsy6wQ2ocRLGLH2PPYhT7y6czHHpfC+eBfA2kF
	 H/rNHicaLua+JhWOUdFMcryATTB8a7gvz01ekD08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCVCw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfCVCw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 22:52:28 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652BE2190A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 02:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553223147;
        bh=2NpbcW6cxEiyvRyH1XuHWQ1FUFXWq2d4xM5L+GBfKpQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c6tRLYSa0EDMGZOql2zBtSJy3nQ1lg3R7j44hacenLtdton6kwDIrDUR0KUVHoLeG
         EqjXsXcwOCPP1QpuXFseuxuzaizd0hEHjlx7ETz0J9FVn2k5K4zl5ozjguph71nUjz
         /6UmQhhrr6B21uFp2Vf4LH/GzMOCLpoEGEdaxBBw=
Received: by mail-wr1-f51.google.com with SMTP id s15so664274wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 19:52:27 -0700 (PDT)
X-Gm-Message-State: APjAAAWrX2O7Q6n52bJgYuIaLBwzc9JHoH0oEmfhNnocbH4Lnu8WAUjq
        ubf6SbaUXYIssAosU/6gd+q5O6oO0Cc4ZbHt1qxnOA==
X-Google-Smtp-Source: APXvYqwz0SfAOF8qJG9p53gjOgp55NewjU+Lo7QLc98AhC/WTcRkLY1vrqtUe/nU6kq5D9351UlnBvSZOs4ua2n5m8w=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr4465895wrq.176.1553223145982;
 Thu, 21 Mar 2019 19:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home> <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
 <20190321141020.641e313f@gandalf.local.home> <CALCETrV1YRo8C6=VtFfrSDFAjQBs=Z6+uw-5hbus4frqAbUqGQ@mail.gmail.com>
 <20190321205011.GE2490@worktop.programming.kicks-ass.net>
In-Reply-To: <20190321205011.GE2490@worktop.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Mar 2019 19:52:14 -0700
X-Gmail-Original-Message-ID: <CALCETrUXYypfeZoVBQ4VUFnUNt9un71C=QwTKLOobqXbpZuE+w@mail.gmail.com>
Message-ID: <CALCETrUXYypfeZoVBQ4VUFnUNt9un71C=QwTKLOobqXbpZuE+w@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 1:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 21, 2019 at 11:27:00AM -0700, Andy Lutomirski wrote:
> > Well, here's pass zero at this.  Untested, because it obviously
> > doesn't work.  Here are just a few things that are almost certainly
> > wrong with it
>
> Aah, you're proposing to simply not do TRACE_IRQS_OFF and
> CALL_enter_from_user_mode and let \do_sym deal with it all.
>
> Yes, that looks like it could almost work; esp. if you start by only
> doing this for the idtentry stuff.
>
> >  - The IRQ tracing needs to be re-added.
> >
> >  - Some real semantics need to be defined for precisely what code is
> > responsible for tracing.
>
> So we get passed \do_sym, how about we do:
>
>         call    __\do_sym
>
> And then use some CPP magic to generate the those functions such that we
> have a consistent part of C glue between our asm and our 'real' C
> handler.
>
> This glue can then do the tracing in a consistent manner.
>
> #define IDT_HANDLER(do_sym)                                             \
> asmlinkage __visible notrace void __do_sym(struct pt_regs *regs)        \
> {                                                                       \
>         trace_hardirqs_off();                                           \
>         if (user_mode(regs))                                            \
>                 enter_from_user_mode();                                 \
>         do_sym(regs);                                                   \
> }
>
> Except more complicated I'm afraid, we need to handle more args etc..

Seems reasonable.  We should drop the asmlinkage, and if do_sym is
static, the code should be pretty good.

>
> >  - We need some asm-callable assertions to check the following
> > conditions as appropriate:
> >
> >  (a) that IRQ flags are currently traced as off.
>
> What do you need this for? When returning from do_sym ?
>
> >  (b) that IRQ flags are currently traced to match the IRET frame.
>
> idem. Can't we have our C glue do that?

The idea was to sanity check the C glue.  Maybe this isn't such a big deal.

>
> >  (c) that our context tracking is currently in good shape.  I'm not
> > 100% sure how to define this.
>
> So looking at this more; I used the %ebx games employed by
> paranoid_entry to convey the state, but I didn't have to do that, the
> actual condition seems to be:
>
>         regs->cs & 3
>
> aka. user_mode(regs). In this case our C glue would need to do the
> context tracking user exit.
>
> In fact, I can change my patch to use that and reduce the ebx ugly.
>
> >  - We need to do some serious don't-instrument-me stuff to all the C
> > entries, since we're now in an awful context when calling them.
>
> Yah, but that's not new. do_page_fault(), sync_regs() at the very least
> have this, so we can easily have our C glue have this too.

True.
