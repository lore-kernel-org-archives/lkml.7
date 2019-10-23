Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9CDCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940F321872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMe0Ilia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfJWRoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:44:22 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35460 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730988AbfJWRoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:44:22 -0400
Received: by mail-il1-f196.google.com with SMTP id p8so10015382ilp.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7knJJRqgYDmFqxJ/P0UYmGVQVgQ03De77m0r79mOwc=;
        b=uMe0IliaJYQWC8Jn/yZ3CiGlxuDQZH+f10Q7lge6zfWutnKJXGh4BWICW11Ebl+Ivy
         Oxejv1SVb2yT/78oFQyeW4IT+mBHN7lfptD17aF2otgkIjzcHbEckkO79uO0abLuB+54
         nJ4iBdYAAczEP6ZNeUD4kiKRbXclG8SM7J/22PKP2pv7qy+Fs2tmkBqHisDmUi4gguq1
         WxjK7bxCKSliaD0hRE1B7GeJ1ZKOsQiUYHPZUFtlNzlLlPHobxK8aXtnpX7E1VaZMLRR
         alMRul5KuIe2LWy7EZRui74YC/BQh8/DeNuhVw1UbTv2TbLfeUtij6rr9nZAfOGfpcbW
         i5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7knJJRqgYDmFqxJ/P0UYmGVQVgQ03De77m0r79mOwc=;
        b=hgQWOd5PvGkgKpmpdDyYX058sCkzl8KwfCjcUZHvRY2qLCKypVtyLWFdFSSOrNljoV
         8sH2vZ9fyL6ae+Crali18VI38nK8e21siIZ+G0pVY07by6WspWa2odoe2H4LgOoVSLN4
         FZSke56wAUGospEXb4hjhJnVoJNaR8hye7S8+Q85oBXcUaDUacnUaUWPbuCv59d4x+JY
         GVY5kbTMcPNJi3Mftws//5UPjMjiBUfesLNRl229J3m2UkzqkiKGa1+61SFyogOlhSTv
         cnlKq3/HvLg2A82P6MzWDHmWeyw4qsnPB4yuT0stIT5DotxYFOQNdBUcxSzruye2JE4E
         1LDw==
X-Gm-Message-State: APjAAAXwDxUqNyT++jxEjhoeSp1Gv+jxd3sOwj2EpB5+UD+vYdIkq8aO
        mF7ramSNvNzR4la6xoppt7gF6xFKli5G+E5RrXbJ0g==
X-Google-Smtp-Source: APXvYqwHJCvpPQUxFlZw2TZ9dIzX7FKcb7XR0aT91MnqH2tT22DFTGW4JpzbbSscGbBc0ZKfh/o3tgJXUzQ7/aKz1DI=
X-Received: by 2002:a92:9adb:: with SMTP id c88mr25596074ill.193.1571852657700;
 Wed, 23 Oct 2019 10:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191018002746.149200-1-eranian@google.com> <20191021102059.GD1800@hirez.programming.kicks-ass.net>
 <CABPqkBQ86=EpsKXMyYgqGdUhSHOi2uCQQfEtupMPavDRiK_30Q@mail.gmail.com> <20191023110234.GS1817@hirez.programming.kicks-ass.net>
In-Reply-To: <20191023110234.GS1817@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 23 Oct 2019 10:44:06 -0700
Message-ID: <CABPqkBQ+dwSbFjRL+AnGnEMhRkiPEEGAt9sTxHqLm5vg=4XPKA@mail.gmail.com>
Subject: Re: [PATCH] perf/core: fix multiplexing event scheduling issue
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 4:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 23, 2019 at 12:30:03AM -0700, Stephane Eranian wrote:
> > On Mon, Oct 21, 2019 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 05:27:46PM -0700, Stephane Eranian wrote:
> > > > This patch complements the following commit:
> > > > 7fa343b7fdc4 ("perf/core: Fix corner case in perf_rotate_context()")
> > > >
> > > > The fix from Song addresses the consequences of the problem but
> > > > not the cause. This patch fixes the causes and can sit on top of
> > > > Song's patch.
> > >
> > > I'm tempted to say the other way around.
> > >
> > > Consider the case where you claim fixed2 with a pinned event and then
> > > have another fixed2 in the flexible list. At that point you're _never_
> > > going to run any other flexible events (without Song's patch).
> > >
> > In that case, there is no deactivation or removal of events, so yes, my patch
> > will not help that case. I said his patch is still useful. You gave one example,
> > even though in this case the rotate will not yield a reschedule of that flexible
> > event because fixed2 is used by a pinned event. So checking for it, will not
> > really help.
>
> Stick 10 cycle events after the fixed2 flexible event. Without Song's
> patch you'll never see those 10 cycle events get scheduled.
>
> > > This patch isn't going to help with that. Similarly, Songs patch helps
> > > with your situation where it will allow rotation to resume after you
> > > disable/remove all active events (while you still have pending events).
> > >
> > Yes, it will unblock the case where active events are deactivated or
> > removed. But it will delay the unblocking until the next mux timer
> > expires. And I am saying this is too far away in many cases. For instance,
> > we do not run with the 1ms timer for uncore, this is way too much overhead.
> > Imagine this timer is set to 10ms or event 100ms, just with Song's patch, the
> > inactive events would have to wait for up to 100ms to be scheduled again.
> > This is not acceptable for us.
>
> Then how was it acceptible to mux in the first place? And if
> multiplexing wasn't acceptible, then why were you doing it?
>
> > > > However, the cause is not addressed. The kernel should not rely on
> > > > the multiplexing hrtimer to unblock inactive events. That timer
> > > > can have abitrary duration in the milliseconds. Until the timer
> > > > fires, counters are available, but no measurable events are using
> > > > them. We do not want to introduce blind spots of arbitrary durations.
> > >
> > > This I disagree with -- you don't get a guarantee other than
> > > timer_period/n when you multiplex, and idling the counters until the
> > > next tick doesn't violate that at all.
> >
> > My take is that if you have free counters and "idling" events, the kernel
> > should take every effort to schedule them as soon as they become available.
> > In the situation I described in the patch, once I remove the active
> > events, there
> > is no more reasons for multiplexing, all the counters are free (ignore
> > watchdog).
>
> That's fine; all I'm arguing is that the current behaviour doesn't
> violate the guarantees given. Now you want to improve counter
> utilization (at a cost) and that is fine. Just don't argue that there's
> something broken -- there is not.
>
> Your patch also does not fix something more fundamental than Song's
> patch did. Quite the reverse. Yours is purely a utilization efficiency
> thing, while Song's addressed a correctness issue.
>
Going back to Song's patch and his test case. It exposes a problem that was
introduced with the RB tree and multiple event list changes. In the event
scheduler, there was this guarantee that each event will get a chance to
be scheduled because each would eventually get to the head of the list and
thus get a chance to be scheduled as the first event of its priority
class, assuming
there was still at least one compatible counter available from higher
priority classes.
The scheduler also still stops at the first error. In Song's case
ref-cycles:D,ref-cycles,cycles,
the pinned event is commandeering fixed2. But I believe the rotation
code was not
rotating the list *even* if it could not schedule the first event.
That explained why
the cycle event could never be scheduled. That's a violation of the guarantee.
At each timer, the list must rotate. I think his patch somehow addresses this.

> > Now you may be arguing, that it may take more time to ctx_resched() then to
> > wait for the timer to expire. But I am not sure I buy that.
>
> I'm not arguing that. All I'm saying is that fairness is not affected.
>
> > Similarly, I am not sure there is code to cancel an active mux hrtimer
> > when we clear rotate_necessary.  Maybe we just let it lapse and clear
> > itself via a ctx_sched_out() in the rotation code.
>
> Yes, we let it lapse and disable itself, I don't see the problem with
> that -- also remember that the timer services two contexts.
>
> > > > This patch addresses the cause of the problem, by checking that,
> > > > when an event is disabled or removed and the context was multiplexing
> > > > events, inactive events gets immediately a chance to be scheduled by
> > > > calling ctx_resched(). The rescheduling is done on  event of equal
> > > > or lower priority types.  With that in place, as soon as a counter
> > > > is freed, schedulable inactive events may run, thereby eliminating
> > > > a blind spot.
> > >
> > > Disagreed, Song's patch removed the fundamental blind spot of rotation
> > > completely failing.
>
> > Sure it removed the infinite blocking of schedulable events. My patch
> > addresses the issue of having free counters following a
> > deactivation/removal and not scheduling the idling events on them,
> > thereby creating a blind spot where no event is monitoring.
>
> If the counters were removed later (like a us before their slice
> expired) there would not have been much idle time.
>
> Either way, fairness does not mandate we schedule immediately.
>
> > > This just slightly optimizes counter usage -- at a cost of having to
> > > reprogram the counters more often.
> > >
> > Only on deactivation/removal AND multiplexing so it is not every time but
> > only where there is an opportunity to keep the counters busy.
>
> Sure, but it's still non-zero :-)
>
> > > Not saying we shouldn't do this, but this justification is just all
> > > sorts of wrong.
> >
> > I think the patches are not mutually exclusive.
>
> I never said they were. And I'm not opposed to your patch. What I
> objected to was the mischaracterization of it in the Changelog.
>
> Present it as an optimization and all should be well.

I will respin it as an optimization then.
Thanks.
