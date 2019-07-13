Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E8CC31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E392A2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UCOs5FL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfGMOUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 10:20:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33481 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfGMOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 10:20:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so8309642lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eoo4TggbXqVeMTReA94Ufd750gwnU1fKyL4kS8L/PyY=;
        b=UCOs5FL8fHXmegSsSGaSv3eE8QOcjtDyOHU8x4M4O/v/X7byzi/hEZl5y719AbZjpB
         QxtWKIyxb118isP7mkPt/viq+2zaHqo4qXIcfjDGFlbso54ehvIxnv6ylEwR9AC7yLLf
         OuC6yjmGzH9u/i6zrKIphMp2GwStuLYsEfPKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eoo4TggbXqVeMTReA94Ufd750gwnU1fKyL4kS8L/PyY=;
        b=VbBJ+I+ILHfq2ok7UTP6iJPP/Jqn/Ipg+gX/CgBQpQOGc/D1rsHwpZZ6/PkcFAGTvP
         McS+uNDADxh2sI6kNO9WKAAopz7FE9JGl+ca3Zc3PB/mcKdIn8K/MInkwD+WUCV1pYhB
         +zaSn2U/+JUV4BEUyY+qnLXY7jiJ0kGLLIVOopbIoEZR6rCCR0jy5NkPy9YLjU7zFi+o
         NSoSTgN+rCttXMSJGwM066cspBTlW1/geWnybTXGSJ3wR3WBBDKZpYTwHiyomFNNfkL+
         Mb8VOhOxM/75L7gkTjZ9YVTOTnljvKshBVtRsilA8QDIv2n98f6o6tNwbBIa7CBVP6Xo
         Se/A==
X-Gm-Message-State: APjAAAXw67bySnplDDp7NV5SgXnbrpNEJCq6QOZes/lXZzmuNm4EBbWU
        N250de1QU4K/4ZmBU/ep+p5RS8b9kI50FtNfJZA=
X-Google-Smtp-Source: APXvYqxzt5k1eW/K2o6Qy5uoov3A1JKzsdk57PXpv0xzIPwciKJh+5wHgegHZxYKdEnRHFS2QXHFLdpeC8THQDSb8/w=
X-Received: by 2002:a19:c80b:: with SMTP id y11mr7118647lff.81.1563027612870;
 Sat, 13 Jul 2019 07:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190708130359.GA42888@google.com> <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com> <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com> <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com> <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com> <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com> <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
In-Reply-To: <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 13 Jul 2019 10:20:02 -0400
Message-ID: <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
To:     Byungchul Park <max.byungchul.park@gmail.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 4:47 AM Byungchul Park
<max.byungchul.park@gmail.com> wrote:
>
> On Fri, Jul 12, 2019 at 9:51 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Fri, Jul 12, 2019 at 03:32:40PM +0900, Byungchul Park wrote:
> > > On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> > > > Hmm, speaking of grace period durations, it seems to me the maximum grace
> > > > period ever is recorded in rcu_state.gp_max. However it is not read from
> > > > anywhere.
> > > >
> > > > Any idea why it was added but not used?
> > > >
> > > > I am interested in dumping this value just for fun, and seeing what I get.
> > > >
> > > > I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> > > > issues, or even expose it in sys/proc fs to see what worst case grace periods
> > > > look like.
> > >
> > > Hi,
> > >
> > >       commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> > >       rcu: Remove debugfs tracing
> > >
> > > removed all debugfs tracing, gp_max also included.
> > >
> > > And you sounds great. And even looks not that hard to add it like,
> > >
> > > :)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index ad9dc86..86095ff 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
> > >       raw_spin_lock_irq_rcu_node(rnp);
> > >       rcu_state.gp_end = jiffies;
> > >       gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> > > -     if (gp_duration > rcu_state.gp_max)
> > > +     if (gp_duration > rcu_state.gp_max) {
> > >               rcu_state.gp_max = gp_duration;
> > > +             trace_rcu_grace_period(something something);
> > > +     }
> >
> > Yes, that makes sense. But I think it is much better off as a readable value
> > from a virtual fs. The drawback of tracing for this sort of thing are:
> >  - Tracing will only catch it if tracing is on
> >  - Tracing data can be lost if too many events, then no one has a clue what
> >    the max gp time is.
> >  - The data is already available in rcu_state::gp_max so copying it into the
> >    trace buffer seems a bit pointless IMHO
> >  - It is a lot easier on ones eyes to process a single counter than process
> >    heaps of traces.
> >
> > I think a minimal set of RCU counters exposed to /proc or /sys should not
> > hurt and could do more good than not. The scheduler already does this for
> > scheduler statistics. I have seen Peter complain a lot about new tracepoints
> > but not much (or never) about new statistics.
> >
> > Tracing has its strengths but may not apply well here IMO. I think a counter
> > like this could be useful for tuning of things like the jiffies_*_sched_qs,
> > the stall timeouts and also any other RCU knobs. What do you think?
>
> I prefer proc/sys knob for it to tracepoint. Why I've considered it is just it
> looks like undoing what Paul did at ae91aa0ad.
>
> I think you're rational enough. I just wondered how Paul think of it.

I believe at least initially, a set of statistics can be made
available only when rcutorture or rcuperf module is loaded. That way
they are purely only for debugging and nothing needs to be exposed to
normal kernels distributed thus reducing testability concerns.

rcu_state::gp_max would be trivial to expose through this, but for
other statistics that are more complicated - perhaps
tracepoint_probe_register can be used to add hooks on to the
tracepoints and generate statistics from them. Again the registration
of the probe and the probe handler itself would all be in
rcutorture/rcuperf test code and not a part of the kernel proper.
Thoughts?

 - Joel
