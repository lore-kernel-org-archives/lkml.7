Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FE8CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD212084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4viSWdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbfJWHaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:30:16 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:46266 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389459AbfJWHaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:30:16 -0400
Received: by mail-il1-f194.google.com with SMTP id m16so11562456iln.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/eREjOiXcNhufL9DgQopGz4FLxgM/xyBmpBfgdAUZM=;
        b=k4viSWddhZ6TKb4tB8HqvScD0/HK7k0Cy3zYqS4VIz2vBUs1Nf4hOvsxAGTsTjoL/e
         OyuYHC5mO5M1/tJsY1lvvb3LX+xdShCDn6JWOXsDwdEz8kNNQ9o+MJYxv0KNpXnEZbIT
         COCFxWpVlEHJk0LifLkoMiOwXa3v2D5CwodZEFSIaSuvcX/gdkx8JyNc72a3nmgBajte
         g13Bz2lyBJuVrtoD6M+MUjMdGuP+LL+6J/+YVaU81BELS6N5P0qHU8gKES0zfp/UZ12z
         vOr9FWsR2l6mVW6c+cV99KLivXONHN+Ozs3yuftfsfzrCuwGpBYYKaDba9z/G1NU/U0b
         rV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/eREjOiXcNhufL9DgQopGz4FLxgM/xyBmpBfgdAUZM=;
        b=f3XqCaNk9c6bo/4/6zuWCBrktLYVjzLVKW3Zvkmph9Afg9RAOyXdQa7o+AhiwTDPlU
         JPn28yQtuxCI9Ug7tCow2No4OrsLlP3w9IjwfpyGF6MlN9ILNW94Xj4uX7+cQNXZkE4n
         1juimHJul68NVzVNO5fmYPybQ+KwUsme8cZWrkzraIHz6INkKFqUWjxVvTGrHwzcvKcm
         4eY2sD9NN9IrzvpW4D/S0hFXx8ge6nhPAPOr3ifTnGQT2KVNKdICSIIbRKHa5id96q6E
         cWndeMgXX+Ewkt3SXp6uhe4wBhJEQhF2Zvur95GBlfgon1Jm2shD6X7XExfjuc8vY1pc
         bstg==
X-Gm-Message-State: APjAAAXnvlbs2ZmDccJepOtxpWfSMXGwr9GcPiCUP+aacmVIAacTrBvi
        e41ZQzkqvCuaEKAxBW3xkmpvZa2imbMbx2cez7KPLg==
X-Google-Smtp-Source: APXvYqyRlGK1oEwk1RoOfA9S4tf+gVhDDuQFE+LN9hnnSLY3yCv1j8mvau3zqyjGrggq8l2c26tLc2A8LwQgE+ji4Yk=
X-Received: by 2002:a92:8f94:: with SMTP id r20mr37550938ilk.41.1571815814849;
 Wed, 23 Oct 2019 00:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191018002746.149200-1-eranian@google.com> <20191021102059.GD1800@hirez.programming.kicks-ass.net>
In-Reply-To: <20191021102059.GD1800@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 23 Oct 2019 00:30:03 -0700
Message-ID: <CABPqkBQ86=EpsKXMyYgqGdUhSHOi2uCQQfEtupMPavDRiK_30Q@mail.gmail.com>
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

On Mon, Oct 21, 2019 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 17, 2019 at 05:27:46PM -0700, Stephane Eranian wrote:
> > This patch complements the following commit:
> > 7fa343b7fdc4 ("perf/core: Fix corner case in perf_rotate_context()")
> >
> > The fix from Song addresses the consequences of the problem but
> > not the cause. This patch fixes the causes and can sit on top of
> > Song's patch.
>
> I'm tempted to say the other way around.
>
> Consider the case where you claim fixed2 with a pinned event and then
> have another fixed2 in the flexible list. At that point you're _never_
> going to run any other flexible events (without Song's patch).
>
In that case, there is no deactivation or removal of events, so yes, my patch
will not help that case. I said his patch is still useful. You gave one example,
even though in this case the rotate will not yield a reschedule of that flexible
event because fixed2 is used by a pinned event. So checking for it, will not
really help.

> This patch isn't going to help with that. Similarly, Songs patch helps
> with your situation where it will allow rotation to resume after you
> disable/remove all active events (while you still have pending events).
>
Yes, it will unblock the case where active events are deactivated or
removed. But it will delay the unblocking until the next mux timer
expires. And I am saying this is too far away in many cases. For instance,
we do not run with the 1ms timer for uncore, this is way too much overhead.
Imagine this timer is set to 10ms or event 100ms, just with Song's patch, the
inactive events would have to wait for up to 100ms to be scheduled again.
This is not acceptable for us.

> > This patch fixes a scheduling problem in the core functions of
> > perf_events. Under certain conditions, some events would not be
> > scheduled even though many counters would be available. This
> > is related to multiplexing and is architecture agnostic and
> > PMU agnostic (i.e., core or uncore).
> >
> > This problem can easily be reproduced when you have two perf
> > stat sessions. The first session does not cause multiplexing,
> > let's say it is measuring 1 event, E1. While it is measuring,
> > a second session starts and causes multiplexing. Let's say it
> > adds 6 events, B1-B6. Now, 7 events compete and are multiplexed.
> > When the second session terminates, all 6 (B1-B6) events are
> > removed. Normally, you'd expect the E1 event to continue to run
> > with no multiplexing. However, the problem is that depending on
> > the state Of E1 when B1-B6 are removed, it may never be scheduled
> > again. If E1 was inactive at the time of removal, despite the
> > multiplexing hrtimer still firing, it will not find any active
> > events and will not try to reschedule. This is what Song's patch
> > fixes. It forces the multiplexing code to consider non-active events.
>
> This; so Song's patch fixes the fundamental problem of the rotation not
> working right under certain conditions.
>
> > However, the cause is not addressed. The kernel should not rely on
> > the multiplexing hrtimer to unblock inactive events. That timer
> > can have abitrary duration in the milliseconds. Until the timer
> > fires, counters are available, but no measurable events are using
> > them. We do not want to introduce blind spots of arbitrary durations.
>
> This I disagree with -- you don't get a guarantee other than
> timer_period/n when you multiplex, and idling the counters until the
> next tick doesn't violate that at all.

My take is that if you have free counters and "idling" events, the kernel
should take every effort to schedule them as soon as they become available.
In the situation I described in the patch, once I remove the active
events, there
is no more reasons for multiplexing, all the counters are free (ignore
watchdog).
Now you may be arguing, that it may take more time to ctx_resched() then to
wait for the timer to expire. But I am not sure I buy that. Similarly,
I am not sure
there is code to cancel an active mux hrtimer when we clear rotate_necessary.
Maybe we just let it lapse and clear itself via a ctx_sched_out() in
the rotation code.

>
> > This patch addresses the cause of the problem, by checking that,
> > when an event is disabled or removed and the context was multiplexing
> > events, inactive events gets immediately a chance to be scheduled by
> > calling ctx_resched(). The rescheduling is done on  event of equal
> > or lower priority types.  With that in place, as soon as a counter
> > is freed, schedulable inactive events may run, thereby eliminating
> > a blind spot.
>
> Disagreed, Song's patch removed the fundamental blind spot of rotation
> completely failing.
Sure it removed the infinite blocking of schedulable events. My patch addresses
the issue of having free counters following a deactivation/removal and
not scheduling
the idling events on them, thereby creating a blind spot where no
event is monitoring.

>
> This just slightly optimizes counter usage -- at a cost of having to
> reprogram the counters more often.
>
Only on deactivation/removal AND multiplexing so it is not every time but
only where there is an opportunity to keep the counters busy.

> Not saying we shouldn't do this, but this justification is just all
> sorts of wrong.

I think the patches are not mutually exclusive. They sort of complement each
other. My problem was that if you have free counters and idling events, you may
not need to do one more rotation and wait for it to resume active
collection, especially
when the timer may be set to a value larger than default. In my case,
I debug my issue
without Song's patch. I discovered it at the time I was ready to
submit my patch to LKML.
My patch by itself solved the problem I was seeing. Song patch is
needed to solve the
problem of the first flexible event not schedulable while other could
be. My patch does
not address that. It would address the case where that ref-cycles
pinned event is removed
and the flexible ref-cycles could take the counter immediately. So, I
am okay with you saying
this is an optimization and I think it is useful.
