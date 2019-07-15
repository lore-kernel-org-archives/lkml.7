Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00905C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68AA20665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fP8z5XCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfGORj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:39:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38735 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731574AbfGORj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:39:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so8051431pgz.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7U1Xh3KJHRX3fVObFfNniPQDr+9DvufaO0iXvtp2ATI=;
        b=fP8z5XChx2nfUCYytw2wl18tc3wHbm9R+/m3U+VYRuzfycbKtDqXFXUS5fQ6cQ88qL
         geCTZGgWwbdkzpqMineiy+pGa2fLbiGkdkczWEnDQCqFZhl4htdbvDgErys0wLWV9jR9
         Rqaar9sS0n3KdndGjlbksnM/Ni5r8Zq6WwsCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7U1Xh3KJHRX3fVObFfNniPQDr+9DvufaO0iXvtp2ATI=;
        b=kv9QJmODsoF7CNZ3VcvwfBops0retagFRuk+pvU8dDZKv5V0kQ4MfzI8fCK5T0QnKk
         tfKOy0+boq9Cw06DQ8GvFZa6V/UlDw/aVXRWEf+r0Bykv9uTlaBlMjgGTcX0dhcbK9Nf
         8/Fft6VPR/u6tc/0k9d4EwPZB0fBoOBeyQc/nE+fnyRsYVHiRngKr2V5oJHgRoMHm8mM
         0VBsfpIRT6r08YqPY7vpNrOw1FBqUgrCP7jnz3h+Z80+BiaZe4/8C9oLe8JoWozGrxsj
         V7KDyrR9AY0cEp6/XFKCkY9hHI6lIFUfi++BRGQtkSooOLPUo2ez+mvbhZleEq55IR0g
         DFWQ==
X-Gm-Message-State: APjAAAX0AnH32KERdHPq1f9zcomWvZwRoGekoUuYoKN7jQ1kjrs61kpr
        mXVvxyvJ7+ErdmwaV65Mi9O+CUfT
X-Google-Smtp-Source: APXvYqwnE+Ox7CluL9ZvKyYVQysEGycFVnLDm6E1FR3A/gFPiF5hf5S+n5LYLg5n6AWcikohmXEwsQ==
X-Received: by 2002:a17:90a:d996:: with SMTP id d22mr30632422pjv.86.1563212367205;
        Mon, 15 Jul 2019 10:39:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 14sm17547769pfy.40.2019.07.15.10.39.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 10:39:26 -0700 (PDT)
Date:   Mon, 15 Jul 2019 13:39:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190715173924.GA2494@google.com>
References: <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com>
 <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com>
 <CANrsvRNK=+SKHJNLmwNjp2tnjacJpqwFVQH9aRCj2E1L10GHDQ@mail.gmail.com>
 <20190714135610.GJ26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190714135610.GJ26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 06:56:10AM -0700, Paul E. McKenney wrote:
[snip]
> > > > > > > > >
> > > > > > > > >       commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> > > > > > > > >       rcu: Remove debugfs tracing
> > > > > > > > >
> > > > > > > > > removed all debugfs tracing, gp_max also included.
> > > > > > > > >
> > > > > > > > > And you sounds great. And even looks not that hard to add it like,
> > > > > > > > >
> > > > > > > > > :)
> > > > > > > > >
> > > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > > index ad9dc86..86095ff 100644
> > > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > > @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
> > > > > > > > >       raw_spin_lock_irq_rcu_node(rnp);
> > > > > > > > >       rcu_state.gp_end = jiffies;
> > > > > > > > >       gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> > > > > > > > > -     if (gp_duration > rcu_state.gp_max)
> > > > > > > > > +     if (gp_duration > rcu_state.gp_max) {
> > > > > > > > >               rcu_state.gp_max = gp_duration;
> > > > > > > > > +             trace_rcu_grace_period(something something);
> > > > > > > > > +     }
> > > > > > > >
> > > > > > > > Yes, that makes sense. But I think it is much better off as a readable value
> > > > > > > > from a virtual fs. The drawback of tracing for this sort of thing are:
> > > > > > > >  - Tracing will only catch it if tracing is on
> > > > > > > >  - Tracing data can be lost if too many events, then no one has a clue what
> > > > > > > >    the max gp time is.
> > > > > > > >  - The data is already available in rcu_state::gp_max so copying it into the
> > > > > > > >    trace buffer seems a bit pointless IMHO
> > > > > > > >  - It is a lot easier on ones eyes to process a single counter than process
> > > > > > > >    heaps of traces.
> > > > > > > >
> > > > > > > > I think a minimal set of RCU counters exposed to /proc or /sys should not
> > > > > > > > hurt and could do more good than not. The scheduler already does this for
> > > > > > > > scheduler statistics. I have seen Peter complain a lot about new tracepoints
> > > > > > > > but not much (or never) about new statistics.
> > > > > > > >
> > > > > > > > Tracing has its strengths but may not apply well here IMO. I think a counter
> > > > > > > > like this could be useful for tuning of things like the jiffies_*_sched_qs,
> > > > > > > > the stall timeouts and also any other RCU knobs. What do you think?
> > > > > > >
> > > > > > > I prefer proc/sys knob for it to tracepoint. Why I've considered it is just it
> > > > > > > looks like undoing what Paul did at ae91aa0ad.
> > > > > > >
> > > > > > > I think you're rational enough. I just wondered how Paul think of it.
> > > > > >
> > > > > > I believe at least initially, a set of statistics can be made
> > > > > > available only when rcutorture or rcuperf module is loaded. That way
> > > > > > they are purely only for debugging and nothing needs to be exposed to
> > > > > > normal kernels distributed thus reducing testability concerns.
> > > > > >
> > > > > > rcu_state::gp_max would be trivial to expose through this, but for
> > > > > > other statistics that are more complicated - perhaps
> > > > > > tracepoint_probe_register can be used to add hooks on to the
> > > > > > tracepoints and generate statistics from them. Again the registration
> > > > > > of the probe and the probe handler itself would all be in
> > > > > > rcutorture/rcuperf test code and not a part of the kernel proper.
> > > > > > Thoughts?
> > > > >
> > > > > It still feels like you guys are hyperfocusing on this one particular
> > > > > knob.  I instead need you to look at the interrelating knobs as a group.
> > > >
> > > > Thanks for the hints, we'll do that.
> > > >
> > > > > On the debugging side, suppose someone gives you an RCU bug report.
> > > > > What information will you need?  How can you best get that information
> > > > > without excessive numbers of over-and-back interactions with the guy
> > > > > reporting the bug?  As part of this last question, what information is
> > > > > normally supplied with the bug?  Alternatively, what information are
> > > > > bug reporters normally expected to provide when asked?
> > > >
> > > > I suppose I could dig out some of our Android bug reports of the past where
> > > > there were RCU issues but if there's any fires you are currently fighting do
> > > > send it our way as debugging homework ;-)
> > >
> > > Evading the questions, are we?

Sorry if I sounded like evading, I was just saying that it would be nice to
work on some specific issue or bug report and then figure out what is needed
from there, instead of trying to predict what data is useful. Of course, I
think predicting and dumping data is also useful, but I was just wondering if
you had some specific issue in mind that we could work off of (you did
mention the CPU stopper below so thank you!)

> > > OK, I can be flexible.  Suppose that you were getting RCU CPU stall
> > > warnings featuring multi_cpu_stop() called from cpu_stopper_thread().
> > > Of course, this really means that some other CPU/task is holding up
> > > multi_cpu_stop() without also blocking the current grace period.
> > >
> > > What is the best way to work out what is really holding things up?
> > 
> > Either the stopper preempted another being in a critical section and
> > has something wrong itself in case of PREEMPT or mechanisms for
> > urgent control doesn't work correctly.
> > 
> > I don't know what exactly you intended but I would check things like
> > (1) irq disable / eqs / tick / scheduler events and (2) whether special
> > handling for each level of qs urgency has started correctly. For that
> > purpose all the history of those events would be more useful.

Agreed, these are all good.

> > And with thinking it more, we could come up with a good way to
> > make use of those data to identify what the problem is. Do I catch
> > the point correctly? If so, me and Joel can start to work on it.
> > Otherwise, please correct me.
> 
> I believe you are on the right track.  In short, it would be great if
> the kernel would automatically dump out the needed information when
> cpu_stopper gets stalled, sort of like RCU does (much of the time,
> anyway) in its CPU stall warnings.  Given a patch that did this, I would
> be quite happy to help advocate for it!

In case you have a LKML link to a thread or bug report to this specific
cpu_stopper issue, please do pass it along.

Happy to work on this with Byungchul, thanks,

- Joel

