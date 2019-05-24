Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB85BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D8721883
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391556AbfEXRjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:39:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47706 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfEXRjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:39:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADB42A78;
        Fri, 24 May 2019 10:39:19 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9901C3F703;
        Fri, 24 May 2019 10:39:17 -0700 (PDT)
Date:   Fri, 24 May 2019 18:39:15 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v2] locking/lock_events: Use this_cpu_add() when necessary
Message-ID: <20190524173915.GB9120@fuggles.cambridge.arm.com>
References: <20190524165346.26373-1-longman@redhat.com>
 <20190524171939.GA9120@fuggles.cambridge.arm.com>
 <CAHk-=wiQ3kbk1G40ofSMu7qGhrX4PgngN64jGnttOcNCvKy6EA@mail.gmail.com>
 <8ceebb1c-e8f1-8bc5-e032-48f1a653a979@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ceebb1c-e8f1-8bc5-e032-48f1a653a979@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:35:39PM -0400, Waiman Long wrote:
> On 5/24/19 1:27 PM, Linus Torvalds wrote:
> > On Fri, May 24, 2019 at 10:19 AM Will Deacon <will.deacon@arm.com> wrote:
> >> Are you sure this works wrt IRQs? For example, if I take an interrupt when
> >> trying to update the counter, and then the irq handler takes a qspinlock
> >> which in turn tries to update the counter. Would I lose an update in that
> >> scenario?
> > Sounds about right.
> >
> > We might decide that the lock event counters are not necessarily
> > precise, but just rough guide-line statistics ("close enough in
> > practice")
> >
> > But that would imply that it shouldn't be dependent on CONFIG_PREEMPT
> > at all, and we should always use the double-underscore version, except
> > without the debug checking.
> >
> > Maybe the #ifdef should just be CONFIG_PREEMPT_DEBUG, with a comment
> > saying "we're not exact, but debugging complains, so if you enable
> > debugging it will be slower and precise". Because I don't think we
> > have a "do this unsafely and without any debugging" option.
> 
> I am not too worry about losing count here and there once in a while
> because of interrupts, but the possibility of having the count from one
> CPU to be put into another CPU in a preempt kernel may distort the total
> count significantly. This is what I want to avoid.
> 
> 
> >
> > And the whole "not precise" thing should be documented, of course.
> 
> Yes, I will update the patch to document that fact that the count may
> not be precise. Anyway even if we have a 1-2% error, it is not a big
> deal in term of presenting a global picture of what operations are being
> done.

I suppose one alternative would be to have a per-cpu local_t variable,
and do the increments on that. However, that's probably worse than the
current approach for x86.

Will
