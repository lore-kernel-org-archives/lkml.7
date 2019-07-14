Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3EC742D2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 13:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57E12064A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 13:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce87s3Ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfGNNkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 09:40:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42076 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfGNNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 09:40:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id v15so13005977eds.9;
        Sun, 14 Jul 2019 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPNCsDsKiy2WuUSjyYZuWmV0J2cvRy4lv1v/waY+sgA=;
        b=Ce87s3IbRnGx2AG8fApdTusmolhpP0aA7o9w9AGnSE39TxTokfpeDki6eYPAAXSHIA
         y9GvOgxbtDgUU8Rt8+7xGjRUKKOxINDmNGfZ5X+K8Jxg2JvRKnwrQAH83vmiTcZzGYMs
         CaA0rh+8PjsaZJgD+mdvYyTi2C8RIBeqPdFrAIW7u8ZucXMkH9MDNYJiMPLnfKFxhdwn
         p49H3UgcfPTwcSCmS8L7N/Vb1hcHI7PSgBMHtGef8tizB7zIB2/D2iN7UHLhK6sQ5y3m
         IpqGWjAoZPM9DpPMbA+FlopN2Px8rQ9P4Pm6taYXx9JJimlrGcMXOwt+zYvXqpq1Xz1h
         AelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPNCsDsKiy2WuUSjyYZuWmV0J2cvRy4lv1v/waY+sgA=;
        b=C78W2aSI5HwJ6CQHZ0d0/SC4lPdOLVLlQ+P4O8qtJSWVITRQfOlrWAgpqUa9L+UWfx
         EukIrSJVENjksYv+F5+ROK7KmDlgoJcawGCUcngo7R+wejcVZyZHy+loBFo5PHrwbQTn
         LVBEybvzzuQXTs50AY6AP5mfCll1sdrAAyPN9nCypLNQbeda2Oqq7tXjJLkqcXOsTWqy
         OEix/7eO+mH/Afpbd0x2uXpReSwNTALwuytxHx5zz5dE5FT3/OoYyAdHTrdQA50/Xh8H
         1XAGUls+UKChzf4PUSKGKr8+/noIhauqgGEwnEOgr0AuF9CKDieA6qiu6QLcyfaTEEIe
         ypkg==
X-Gm-Message-State: APjAAAXhQy9x+m3NCcqmX0DKQ+Gtq9yjLqITRWTT7SWCMApys4ZtGfK1
        kxpiAMWVSLnHAjqZy7gSbgNCswY0CMhfGyJmG0Q=
X-Google-Smtp-Source: APXvYqxcY7b9oOnXMXLYMx4UrY5I5QE3m5m1SKIgSPsn+VbvTSmb7Ar9V865WLyMRQsDeSWjcYlJZ81HjgJOckog1+E=
X-Received: by 2002:a50:a56b:: with SMTP id z40mr17995149edb.99.1563111609585;
 Sun, 14 Jul 2019 06:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190711130849.GA212044@google.com> <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com> <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R> <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com> <20190713154257.GE133650@google.com> <20190713174111.GG26519@linux.ibm.com>
In-Reply-To: <20190713174111.GG26519@linux.ibm.com>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Sun, 14 Jul 2019 22:39:58 +0900
Message-ID: <CANrsvRNK=+SKHJNLmwNjp2tnjacJpqwFVQH9aRCj2E1L10GHDQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <byungchul.park@lge.com>,
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

On Sun, Jul 14, 2019 at 2:41 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Sat, Jul 13, 2019 at 11:42:57AM -0400, Joel Fernandes wrote:
> > On Sat, Jul 13, 2019 at 08:13:30AM -0700, Paul E. McKenney wrote:
> > > On Sat, Jul 13, 2019 at 10:20:02AM -0400, Joel Fernandes wrote:
> > > > On Sat, Jul 13, 2019 at 4:47 AM Byungchul Park
> > > > <max.byungchul.park@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jul 12, 2019 at 9:51 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > On Fri, Jul 12, 2019 at 03:32:40PM +0900, Byungchul Park wrote:
> > > > > > > On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> > > > > > > > Hmm, speaking of grace period durations, it seems to me the maximum grace
> > > > > > > > period ever is recorded in rcu_state.gp_max. However it is not read from
> > > > > > > > anywhere.
> > > > > > > >
> > > > > > > > Any idea why it was added but not used?
> > > > > > > >
> > > > > > > > I am interested in dumping this value just for fun, and seeing what I get.
> > > > > > > >
> > > > > > > > I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> > > > > > > > issues, or even expose it in sys/proc fs to see what worst case grace periods
> > > > > > > > look like.
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > >       commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> > > > > > >       rcu: Remove debugfs tracing
> > > > > > >
> > > > > > > removed all debugfs tracing, gp_max also included.
> > > > > > >
> > > > > > > And you sounds great. And even looks not that hard to add it like,
> > > > > > >
> > > > > > > :)
> > > > > > >
> > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > index ad9dc86..86095ff 100644
> > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
> > > > > > >       raw_spin_lock_irq_rcu_node(rnp);
> > > > > > >       rcu_state.gp_end = jiffies;
> > > > > > >       gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> > > > > > > -     if (gp_duration > rcu_state.gp_max)
> > > > > > > +     if (gp_duration > rcu_state.gp_max) {
> > > > > > >               rcu_state.gp_max = gp_duration;
> > > > > > > +             trace_rcu_grace_period(something something);
> > > > > > > +     }
> > > > > >
> > > > > > Yes, that makes sense. But I think it is much better off as a readable value
> > > > > > from a virtual fs. The drawback of tracing for this sort of thing are:
> > > > > >  - Tracing will only catch it if tracing is on
> > > > > >  - Tracing data can be lost if too many events, then no one has a clue what
> > > > > >    the max gp time is.
> > > > > >  - The data is already available in rcu_state::gp_max so copying it into the
> > > > > >    trace buffer seems a bit pointless IMHO
> > > > > >  - It is a lot easier on ones eyes to process a single counter than process
> > > > > >    heaps of traces.
> > > > > >
> > > > > > I think a minimal set of RCU counters exposed to /proc or /sys should not
> > > > > > hurt and could do more good than not. The scheduler already does this for
> > > > > > scheduler statistics. I have seen Peter complain a lot about new tracepoints
> > > > > > but not much (or never) about new statistics.
> > > > > >
> > > > > > Tracing has its strengths but may not apply well here IMO. I think a counter
> > > > > > like this could be useful for tuning of things like the jiffies_*_sched_qs,
> > > > > > the stall timeouts and also any other RCU knobs. What do you think?
> > > > >
> > > > > I prefer proc/sys knob for it to tracepoint. Why I've considered it is just it
> > > > > looks like undoing what Paul did at ae91aa0ad.
> > > > >
> > > > > I think you're rational enough. I just wondered how Paul think of it.
> > > >
> > > > I believe at least initially, a set of statistics can be made
> > > > available only when rcutorture or rcuperf module is loaded. That way
> > > > they are purely only for debugging and nothing needs to be exposed to
> > > > normal kernels distributed thus reducing testability concerns.
> > > >
> > > > rcu_state::gp_max would be trivial to expose through this, but for
> > > > other statistics that are more complicated - perhaps
> > > > tracepoint_probe_register can be used to add hooks on to the
> > > > tracepoints and generate statistics from them. Again the registration
> > > > of the probe and the probe handler itself would all be in
> > > > rcutorture/rcuperf test code and not a part of the kernel proper.
> > > > Thoughts?
> > >
> > > It still feels like you guys are hyperfocusing on this one particular
> > > knob.  I instead need you to look at the interrelating knobs as a group.
> >
> > Thanks for the hints, we'll do that.
> >
> > > On the debugging side, suppose someone gives you an RCU bug report.
> > > What information will you need?  How can you best get that information
> > > without excessive numbers of over-and-back interactions with the guy
> > > reporting the bug?  As part of this last question, what information is
> > > normally supplied with the bug?  Alternatively, what information are
> > > bug reporters normally expected to provide when asked?
> >
> > I suppose I could dig out some of our Android bug reports of the past where
> > there were RCU issues but if there's any fires you are currently fighting do
> > send it our way as debugging homework ;-)
>
> Evading the questions, are we?
>
> OK, I can be flexible.  Suppose that you were getting RCU CPU stall
> warnings featuring multi_cpu_stop() called from cpu_stopper_thread().
> Of course, this really means that some other CPU/task is holding up
> multi_cpu_stop() without also blocking the current grace period.
>
> What is the best way to work out what is really holding things up?

Either the stopper preempted another being in a critical section and
has something wrong itself in case of PREEMPT or mechanisms for
urgent control doesn't work correctly.

I don't know what exactly you intended but I would check things like
(1) irq disable / eqs / tick / scheduler events and (2) whether special
handling for each level of qs urgency has started correctly. For that
purpose all the history of those events would be more useful.

And with thinking it more, we could come up with a good way to
make use of those data to identify what the problem is. Do I catch
the point correctly? If so, me and Joel can start to work on it.
Otherwise, please correct me.

-- 
Thanks,
Byungchul
