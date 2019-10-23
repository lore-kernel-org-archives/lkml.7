Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D9DCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE47F20650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ITRtSMTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404617AbfJWLCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:02:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47458 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390486AbfJWLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tyj/2nqlU5kbt82YaTK+ZX+NIRh3FTAAxHObeSa0tm8=; b=ITRtSMTYauboaCLY9Rnd4s2kZ
        3kOf6bG1e83hrehO5vNTSgEcEgGZ3GaAsJfjE+4TkUe/MgBrE7MH3lquQPqtdCttDCpdEh41VcNfj
        136yrP3FQxXwGuzBN2V1TtqCknrOBPz2IgqybCqaF0cnkdenJsxbPmyAs8KQmXf7DN+PGRGdpX8RT
        dqte/rqLzTEcy66lCDtC+YE1rD9pIU+AvtDTUWYDGHn2bkJFxtNoKX43lyXetlzRJ+rgZ7uazuW9t
        bBr0oQ3Ivn/x85S113HQq1y3CWkJOCYUR8Q/1E9EfjZ34rOGZF5DhO44xNTtExv4RzHGOekyhFlmz
        6vTwxTRQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNEPX-0005kY-1R; Wed, 23 Oct 2019 11:02:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5069F30038D;
        Wed, 23 Oct 2019 13:01:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 480C62B1C5851; Wed, 23 Oct 2019 13:02:34 +0200 (CEST)
Date:   Wed, 23 Oct 2019 13:02:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf/core: fix multiplexing event scheduling issue
Message-ID: <20191023110234.GS1817@hirez.programming.kicks-ass.net>
References: <20191018002746.149200-1-eranian@google.com>
 <20191021102059.GD1800@hirez.programming.kicks-ass.net>
 <CABPqkBQ86=EpsKXMyYgqGdUhSHOi2uCQQfEtupMPavDRiK_30Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQ86=EpsKXMyYgqGdUhSHOi2uCQQfEtupMPavDRiK_30Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:30:03AM -0700, Stephane Eranian wrote:
> On Mon, Oct 21, 2019 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Oct 17, 2019 at 05:27:46PM -0700, Stephane Eranian wrote:
> > > This patch complements the following commit:
> > > 7fa343b7fdc4 ("perf/core: Fix corner case in perf_rotate_context()")
> > >
> > > The fix from Song addresses the consequences of the problem but
> > > not the cause. This patch fixes the causes and can sit on top of
> > > Song's patch.
> >
> > I'm tempted to say the other way around.
> >
> > Consider the case where you claim fixed2 with a pinned event and then
> > have another fixed2 in the flexible list. At that point you're _never_
> > going to run any other flexible events (without Song's patch).
> >
> In that case, there is no deactivation or removal of events, so yes, my patch
> will not help that case. I said his patch is still useful. You gave one example,
> even though in this case the rotate will not yield a reschedule of that flexible
> event because fixed2 is used by a pinned event. So checking for it, will not
> really help.

Stick 10 cycle events after the fixed2 flexible event. Without Song's
patch you'll never see those 10 cycle events get scheduled.

> > This patch isn't going to help with that. Similarly, Songs patch helps
> > with your situation where it will allow rotation to resume after you
> > disable/remove all active events (while you still have pending events).
> >
> Yes, it will unblock the case where active events are deactivated or
> removed. But it will delay the unblocking until the next mux timer
> expires. And I am saying this is too far away in many cases. For instance,
> we do not run with the 1ms timer for uncore, this is way too much overhead.
> Imagine this timer is set to 10ms or event 100ms, just with Song's patch, the
> inactive events would have to wait for up to 100ms to be scheduled again.
> This is not acceptable for us.

Then how was it acceptible to mux in the first place? And if
multiplexing wasn't acceptible, then why were you doing it?

> > > However, the cause is not addressed. The kernel should not rely on
> > > the multiplexing hrtimer to unblock inactive events. That timer
> > > can have abitrary duration in the milliseconds. Until the timer
> > > fires, counters are available, but no measurable events are using
> > > them. We do not want to introduce blind spots of arbitrary durations.
> >
> > This I disagree with -- you don't get a guarantee other than
> > timer_period/n when you multiplex, and idling the counters until the
> > next tick doesn't violate that at all.
>
> My take is that if you have free counters and "idling" events, the kernel
> should take every effort to schedule them as soon as they become available.
> In the situation I described in the patch, once I remove the active
> events, there
> is no more reasons for multiplexing, all the counters are free (ignore
> watchdog).

That's fine; all I'm arguing is that the current behaviour doesn't
violate the guarantees given. Now you want to improve counter
utilization (at a cost) and that is fine. Just don't argue that there's
something broken -- there is not.

Your patch also does not fix something more fundamental than Song's
patch did. Quite the reverse. Yours is purely a utilization efficiency
thing, while Song's addressed a correctness issue.

> Now you may be arguing, that it may take more time to ctx_resched() then to
> wait for the timer to expire. But I am not sure I buy that.

I'm not arguing that. All I'm saying is that fairness is not affected.

> Similarly, I am not sure there is code to cancel an active mux hrtimer
> when we clear rotate_necessary.  Maybe we just let it lapse and clear
> itself via a ctx_sched_out() in the rotation code.

Yes, we let it lapse and disable itself, I don't see the problem with
that -- also remember that the timer services two contexts.

> > > This patch addresses the cause of the problem, by checking that,
> > > when an event is disabled or removed and the context was multiplexing
> > > events, inactive events gets immediately a chance to be scheduled by
> > > calling ctx_resched(). The rescheduling is done on  event of equal
> > > or lower priority types.  With that in place, as soon as a counter
> > > is freed, schedulable inactive events may run, thereby eliminating
> > > a blind spot.
> >
> > Disagreed, Song's patch removed the fundamental blind spot of rotation
> > completely failing.

> Sure it removed the infinite blocking of schedulable events. My patch
> addresses the issue of having free counters following a
> deactivation/removal and not scheduling the idling events on them,
> thereby creating a blind spot where no event is monitoring.

If the counters were removed later (like a us before their slice
expired) there would not have been much idle time.

Either way, fairness does not mandate we schedule immediately.

> > This just slightly optimizes counter usage -- at a cost of having to
> > reprogram the counters more often.
> >
> Only on deactivation/removal AND multiplexing so it is not every time but
> only where there is an opportunity to keep the counters busy.

Sure, but it's still non-zero :-)

> > Not saying we shouldn't do this, but this justification is just all
> > sorts of wrong.
>
> I think the patches are not mutually exclusive.

I never said they were. And I'm not opposed to your patch. What I
objected to was the mischaracterization of it in the Changelog.

Present it as an optimization and all should be well.
