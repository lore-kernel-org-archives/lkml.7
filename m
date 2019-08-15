Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF3C3A59B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5292A2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pmWlNZJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbfHOTnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:43:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35669 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733083AbfHOTnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:43:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn20so1450904plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8N8cLIMPL3olrtQ0tMSlx1l44XRwy5ZaRYXR+SsPmbk=;
        b=pmWlNZJf/N6ZiVuyuKhv5aojKhiK9uARuOYkpwE5/232e2Vdbb68QqhzbS+WMqI/S4
         49iJCnlFjKZ3rsdfss0xh3pV6vixfQ4FsIfBcmZsYimU03ksYs36TkjQTlhmcy/qz21/
         a8w355sic1osDSPosliRBosm9GXJykXfARq1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8N8cLIMPL3olrtQ0tMSlx1l44XRwy5ZaRYXR+SsPmbk=;
        b=qRR+4AhGnIdHAT5w2vKA7HOdkFtcvxzBfMhQb8usVQJxmB74SEhPdoWEqBcP3nLwBs
         3fk+YRGLPKa18V9dc/Uwt3zL9oxXmIKQiWgPIszW+ChMhLa0bLp+uUEvRBnQDxG7M4k/
         komzU1Un/dP/rsqdkC/mQqtvu0oYgn8nLjkCShZ5DfUwsbKPh419P0ieXA0xhJ3lLX4A
         C0f3ZFYeAj34FAlhA1qV3nvRkOd4rQFq+R4w6a6giqef0zXIZc8Pgsxxul2jPVBF7Gyz
         JPT2NKPZagy89QPWjyWKfPn8U/z9wcoFa3Ohcp31sVAVdQpHOgGIeiHXNm2LkeUUMFjL
         qZLQ==
X-Gm-Message-State: APjAAAURvuAkhBsVGsfZ2wTTs78oB2M7bk4cg/v3cVu+UWUUvH7Lfa56
        v8l9dNBYctlcwAixg9A7p86N9Q==
X-Google-Smtp-Source: APXvYqy56OZ21DtHv0+nRBaVhYpRBxxWdVMCpzOESFIFUAzHm1pKjFwtsLfQW9v6dyo0mpGLZh8/xA==
X-Received: by 2002:a17:902:24b:: with SMTP id 69mr5545320plc.250.1565898194982;
        Thu, 15 Aug 2019 12:43:14 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id t9sm2040687pji.18.2019.08.15.12.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 12:43:14 -0700 (PDT)
Date:   Thu, 15 Aug 2019 15:42:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190815194257.GA23194@google.com>
References: <20190812210232.GA3648@lenoir>
 <20190812232316.GT28441@linux.ibm.com>
 <20190813123016.GA11455@lenoir>
 <20190813144809.GB28441@linux.ibm.com>
 <20190814175546.GB68498@google.com>
 <20190814220516.GY28441@linux.ibm.com>
 <20190815150735.GA12078@google.com>
 <20190815172351.GI28441@linux.ibm.com>
 <20190815181500.GC12078@google.com>
 <20190815183937.GK28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815183937.GK28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:39:37AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 15, 2019 at 02:15:00PM -0400, Joel Fernandes wrote:
> > On Thu, Aug 15, 2019 at 10:23:51AM -0700, Paul E. McKenney wrote:
> > > > [snip]
> > > > > > > If so, perhaps that monitoring could periodically invoke an RCU function
> > > > > > > that I provide for deciding when to turn the tick on.  We would also need
> > > > > > > to work out how to turn the tick off in a timely fashion once the CPU got
> > > > > > > out of kernel mode, perhaps in rcu_user_enter() or rcu_nmi_exit_common().
> > > > > > > 
> > > > > > > If this would be called only every second or so, the separate grace-period
> > > > > > > checking is still needed for its shorter timespan, though.
> > > > > > > 
> > > > > > > Thoughts?
> > > > > > 
> > > > > > Do you want me to test the below patch to see if it fixes the issue with my
> > > > > > other test case (where I had a nohz full CPU holding up a grace period).
> > > > > 
> > > > > Please!
> > > > 
> > > > I tried the patch below, but it did not seem to make a difference to the
> > > > issue I was seeing. My test tree is here in case you can spot anything I did
> > > > not do right: https://github.com/joelagnel/linux-kernel/commits/rcu/nohz-test
> > > > The main patch is here:
> > > > https://github.com/joelagnel/linux-kernel/commit/4dc282b559d918a0be826936f997db0bdad7abb3
> > > 
> > > That is more aggressive that rcutorture's rcu_torture_fwd_prog_nr(), so
> > > I am guessing that I need to up rcu_torture_fwd_prog_nr()'s game.  I am
> > > currently testing that.
> > > 
> > > > On the trace output, I grep something like: egrep "(rcu_perf|cpu 3|3d)". I
> > > > see a few ticks after 300ms, but then there are no more ticks and just a
> > > > periodic resched_cpu() from rcu_implicit_dynticks_qs():
> > > > 
> > > > [   19.534107] rcu_perf-165    12.... 2276436us : rcu_perf_writer: Start of rcuperf test
> > > > [   19.557968] rcu_pree-10      0d..1 2287973us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> > > > [   20.136222] rcu_perf-165     3d.h. 2591894us : rcu_sched_clock_irq: sched-tick
> > > > [   20.137185] rcu_perf-165     3d.h2 2591906us : rcu_sched_clock_irq: sched-tick
> > > > [   20.138149] rcu_perf-165     3d.h. 2591911us : rcu_sched_clock_irq: sched-tick
> > > > [   20.139106] rcu_perf-165     3d.h. 2591915us : rcu_sched_clock_irq: sched-tick
> > [snip]
> > > > [   20.147797] rcu_perf-165     3d.h. 2591953us : rcu_sched_clock_irq: sched-tick
> > > > [   20.148759] rcu_perf-165     3d.h. 2591957us : rcu_sched_clock_irq: sched-tick
> > > > [   20.151655] rcu_pree-10      0d..1 2591979us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> > > > [   20.732938] rcu_pree-10      0d..1 2895960us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> > [snip]
> > > > [   26.566100] rcu_pree-10      0d..1 5935982us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> > > > [   27.144497] rcu_pree-10      0d..1 6239973us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> > > > [   27.192661] rcu_perf-165     3d.h. 6276923us : rcu_sched_clock_irq: sched-tick
> > > > [   27.705789] rcu_pree-10      0d..1 6541901us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> > > > [   28.292155] rcu_pree-10      0d..1 6845974us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> > > > [   28.874049] rcu_pree-10      0d..1 7149972us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> > > > [   29.112646] rcu_perf-165     3.... 7275951us : rcu_perf_writer: End of rcuperf test
> > > 
> > > That would be due to my own stupidity.  I forgot to clear ->rcu_forced_tick
> > > in rcu_disable_tick_upon_qs() inside the "if" statement.  This of course
> > > prevents rcu_nmi_exit_common() from ever re-enabling it.
> > > 
> > > Excellent catch!  Thank you for testing this!!!
> > 
> > Ah I missed it too. Happy to help! I tried setting it as below but getting
> > same results:
> > 
> > +/*
> > + * If the scheduler-clock interrupt was enabled on a nohz_full CPU
> > + * in order to get to a quiescent state, disable it.
> > + */
> > +void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
> > +{
> > +       if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick)
> > +               tick_dep_clear_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > +       rdp->rcu_forced_tick = false;
> 
> I put this inside the "if" statement, though I would not expect that to
> change behavior in this case.
> 
> Does your test case still avoid turning on the tick more than once?  Or
> is it turning on the tick each time the grace period gets too long, but
> without the tick managing to end the grace periods?

I will put some more prints and let you know. But it looks like I see a print
from rcu_sched_clock_irq() only once at around 700ms from the start of the
test loop. After that I don't see prints at all for the rest of the 7 seconds
of the test.

Before the test starts, I see several rcu_sched_clock_irq() at the regular
tick interval of 1 ms (HZ=1000).

> > > > [snip]
> > > > > Without that code, RCU can give false-positive splats at various points
> > > > > in its processing.  ("Wait!  How can a task be blocked waiting on a
> > > > > grace period that hasn't even started yet???")
> > > > 
> > > > I did not fully understand the question in brackets though, a task can be on
> > > > a different CPU though which has nothing to do with the CPU that's going
> > > > offline/online so it could totally be waiting on a grace period right?
> > > > 
> > > > Also waiting on a grace period that hasn't even started is totally possible:
> > > > 
> > > >      GP1         GP2
> > > > |<--------->|<-------->|
> > > >      ^                 ^
> > > >      |                 |____  task gets unblocked
> > > > task blocks
> > > > on synchronize_rcu
> > > > but is waiting on
> > > > GP2 which hasn't started
> > > > 
> > > > Or did I misunderstand the question?
> > > 
> > > There is a ->gp_tasks field in the leaf rcu_node structures that
> > > references a list of tasks blocking the current grace period.  When there
> > > is no grace period in progress (as is the case from the end of GP1 to
> > > the beginning of GP2, the RCU code expects ->gp_tasks to be NULL.
> > > Without the curiosity code you pointed out above, ->gp_tasks could
> > > in fact end up being non-NULL when no grace period was in progress.
> > > 
> > > And did end up being non-NULL from time to time, initially every few
> > > hundred hours of a particular rcutorture scenario.
> > 
> > Oh ok! I will think more about it. I am not yet able to connect the gp_tasks
> > being non-NULL to the CPU going offline/online scenario though. Maybe I
> > should delete this code, run an experiment and trace for this condition
> > (gp_tasks != NULL)?
> 
> Or you could dig through the git logs for this code change.

Ok will do.

> > I love it how you found these issues by heavy testing and fixed them.
> 
> Me, I would have rather foreseen them and avoided them in the first place,
> but I agree that it is better for rcutorture to find them than for some
> hapless user somewhere to be inconvenienced by them.  ;-)

True, forseeing is always better ;)

thanks,

 - Joel

