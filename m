Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD84C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9A8206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="diuOugQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfHUP06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:26:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41148 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbfHUP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:26:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so1501274pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f66f7evZfjkexG93o+hTzCxQL7jcHjoGTmjCrvuOhSc=;
        b=diuOugQ3W+1+KVPbgPHXT9BgGxfGt1UFCnZHIk8FSytswqczUS3CSXwtlXtxdfKR4r
         xj2o7yrMFN9tuX3xODchVfzl6uNRRSG7Xq1hri9TuCtiJl2rnF8RXwrWJor2WvhFjgST
         L1wQA1Lm9IFoxE+kXiHnh4FOvYCayc0xJpnaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f66f7evZfjkexG93o+hTzCxQL7jcHjoGTmjCrvuOhSc=;
        b=TDEdyvyZEceoja6vIZKlSkbddV44DQSJiRsKHm+ZrVnJu6ECkYYhw5etAvGkW/dkx4
         Mj4nCNfufsMSAoA1BNhdRLkaFVvWJDRHGqeaWxl7rGO2qbVgchr7raUFt45NISy4rQ1c
         nV8gh6T1OCpYLKTEXNcYSwomE+OaKN76AuJP36pfTKATiG62jiEv5OhZ7jRD7ZtulKC/
         UCELyudFF9jrXy0XptXBnpEEg3i4jUVjdhv2NW0mvqYhEQMWybz87acr9PvA0iITVfEI
         hoTGcU382RfR072r1F8pdkFTZYs8npjFHEunekLTOEpCtjohXNou9HsXjK0NcmJfIqqJ
         4cqw==
X-Gm-Message-State: APjAAAVsv4kuJQOUgpGOzXUFSiccrCW0UwJimFq7BrYoYpM8yaxAuJ3Q
        IL22gk4mpWrkYIR4bUlJm0hb1g==
X-Google-Smtp-Source: APXvYqyj8pjIhVtbQIUXkvXiwyrAeIPRfYNCkg+19nxQTKzyp2ZZRYB8ArysWArxhNikckg/tSgTMQ==
X-Received: by 2002:a17:902:a40d:: with SMTP id p13mr19223259plq.92.1566401216056;
        Wed, 21 Aug 2019 08:26:56 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id j6sm317887pje.11.2019.08.21.08.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 08:26:55 -0700 (PDT)
Date:   Wed, 21 Aug 2019 11:26:38 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190821152638.GF147977@google.com>
References: <20190818233839.GA160903@google.com>
 <20190819012153.GR28441@linux.ibm.com>
 <20190819014143.GB160903@google.com>
 <20190819014623.GC160903@google.com>
 <20190819022927.GS28441@linux.ibm.com>
 <20190819125757.GA6946@linux.ibm.com>
 <20190819143314.GT28441@linux.ibm.com>
 <20190819154143.GA18470@linux.ibm.com>
 <20190821143841.GC147977@google.com>
 <20190821145617.GD147977@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821145617.GD147977@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 10:56:17AM -0400, Joel Fernandes wrote:
> On Wed, Aug 21, 2019 at 10:38:41AM -0400, Joel Fernandes wrote:
> > On Mon, Aug 19, 2019 at 08:41:43AM -0700, Paul E. McKenney wrote:
> > > On Mon, Aug 19, 2019 at 07:33:14AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Aug 19, 2019 at 05:57:57AM -0700, Paul E. McKenney wrote:
> > > > > On Sun, Aug 18, 2019 at 07:29:27PM -0700, Paul E. McKenney wrote:
> > > > > > On Sun, Aug 18, 2019 at 09:46:23PM -0400, Joel Fernandes wrote:
> > > > > > > On Sun, Aug 18, 2019 at 09:41:43PM -0400, Joel Fernandes wrote:
> > > > > > > > On Sun, Aug 18, 2019 at 06:21:53PM -0700, Paul E. McKenney wrote:
> > > > > > > [snip]
> > > > > > > > > > > Also, your commit log's point #2 is "in_irq() implies in_interrupt()
> > > > > > > > > > > which implies raising softirq will not do any wake ups."  This mention
> > > > > > > > > > > of softirq seems a bit odd, given that we are going to wake up a rcuc
> > > > > > > > > > > kthread.  Of course, this did nothing to quell my suspicions.  ;-)
> > > > > > > > > > 
> > > > > > > > > > Yes, I should delete this #2 from the changelog since it is not very relevant
> > > > > > > > > > (I feel now). My point with #2 was that even if were to raise a softirq
> > > > > > > > > > (which we are not), a scheduler wakeup of ksoftirqd is impossible in this
> > > > > > > > > > path anyway since in_irq() implies in_interrupt().
> > > > > > > > > 
> > > > > > > > > Please!  Could you also add a first-principles explanation of why
> > > > > > > > > the added condition is immune from scheduler deadlocks?
> > > > > > > > 
> > > > > > > > Sure I can add an example in the change log, however I was thinking of this
> > > > > > > > example which you mentioned:
> > > > > > > > https://lore.kernel.org/lkml/20190627173831.GW26519@linux.ibm.com/
> > > > > > > > 
> > > > > > > > 	previous_reader()
> > > > > > > > 	{
> > > > > > > > 		rcu_read_lock();
> > > > > > > > 		do_something(); /* Preemption happened here. */
> > > > > > > > 		local_irq_disable(); /* Cannot be the scheduler! */
> > > > > > > > 		do_something_else();
> > > > > > > > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > > > > > > > 		do_some_other_thing();
> > > > > > > > 		local_irq_enable();
> > > > > > > > 	}
> > > > > > > > 
> > > > > > > > 	current_reader() /* QS from previous_reader() is still deferred. */
> > > > > > > > 	{
> > > > > > > > 		local_irq_disable();  /* Might be the scheduler. */
> > > > > > > > 		do_whatever();
> > > > > > > > 		rcu_read_lock();
> > > > > > > > 		do_whatever_else();
> > > > > > > > 		rcu_read_unlock();  /* Must still defer reporting QS. */
> > > > > > > > 		do_whatever_comes_to_mind();
> > > > > > > > 		local_irq_enable();
> > > > > > > > 	}
> > > > > > > > 
> > > > > > > > One modification of the example could be, previous_reader() could also do:
> > > > > > > > 	previous_reader()
> > > > > > > > 	{
> > > > > > > > 		rcu_read_lock();
> > > > > > > > 		do_something_that_takes_really_long(); /* causes need_qs in
> > > > > > > > 							  the unlock_special_union to be set */
> > > > > > > > 		local_irq_disable(); /* Cannot be the scheduler! */
> > > > > > > > 		do_something_else();
> > > > > > > > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > > > > > > > 		do_some_other_thing();
> > > > > > > > 		local_irq_enable();
> > > > > > > > 	}
> > > > > > > 
> > > > > > > The point you were making in that thread being, current_reader() ->
> > > > > > > rcu_read_unlock() -> rcu_read_unlock_special() would not do any wakeups
> > > > > > > because previous_reader() sets the deferred_qs bit.
> > > > > > > 
> > > > > > > Anyway, I will add all of this into the changelog.
> > > > > > 
> > > > > > Examples are good, but what makes it so that there are no examples of
> > > > > > its being unsafe?
> > > > > > 
> > > > > > And a few questions along the way, some quick quiz, some more serious.
> > > > > > Would it be safe if it checked in_interrupt() instead of in_irq()?
> > > > > > If not, should the in_interrupt() in the "if" condition preceding the
> > > > > > added "else if" be changed to in_irq()?  Would it make sense to add an
> > > > > > "|| !irqs_were_disabled" do your new "else if" condition?  Would the
> > > > > > body of the "else if" actually be executed in current mainline?
> > > > > > 
> > > > > > In an attempt to be at least a little constructive, I am doing some
> > > > > > testing of this patch overnight, along with a WARN_ON_ONCE() to see if
> > > > > > that invoke_rcu_core() is ever reached.
> > > > > 
> > > > > And that WARN_ON_ONCE() never triggered in two-hour rcutorture runs of
> > > > > TREE01, TREE02, TREE03, and TREE09.  (These are the TREE variants in
> > > > > CFLIST that have CONFIG_PREEMPT=y.)
> > > > > 
> > > > > This of course raises other questions.  But first, do you see that code
> > > > > executing in your testing?
> > > > 
> > > > Never mind!  Idiot here forgot the "--bootargs rcutree.use_softirq"...
> > > 
> > > So this time I ran the test this way:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 10 --configs "TREE01 TREE02 TREE03 TREE09" --bootargs "rcutree.use_softirq=0"
> > > 
> > > Still no splats.  Though only 10-minute runs instead of the two-hour runs
> > > I did last night.  (Got other stuff I need to do, sorry!)
> > > 
> > > My test version of your patch is shown below.  Please let me know if I messed
> > > something up.
> > 
> > I think you also need to pass rcutorture.irqreader=1 ?
> > 
> > Otherwise seems all readers happen in process context AFAICS.
> 
> Which is the default setting for that, so that's not the issue.
> 
> I think one reason could be, in_irq() is false when the timer callback
> executes, since the timer callback is executing after a grace-period. The
> stack is as follows:
> 
> Any reason why we cannot both test for call_rcu() and execute the RCU
> callback from the timer hardirq handler?
> 
> In fact, I guess on use_nosoftirq systems, the callback will not even run
> in softirq context.
> 
> [   20.553361]  => rcu_torture_timer_cb
> [   20.553361]  => rcu_do_batch
> [   20.553361]  => rcu_core
> [   20.553361]  => __do_softirq
> [   20.553361]  => do_softirq_own_stack
> [   20.553361]  => do_softirq.part.16
> [   20.553361]  => __local_bh_enable_ip
> [   20.553361]  => rcutorture_one_extend
> [   20.553361]  => rcu_torture_one_read
> [   20.553361]  => rcu_torture_reader
> [   20.553361]  => kthread
> [   20.553361]  => ret_from_fork

Oops! wrong stack trace, this is the one where it shows that the timer handler
is running from softirq, not hardirq. Both the rcu_torture_timer() and
rcu_torture_timer_cb() run from softirq context. ftrace confirms:

[   27.949671] rcu_tort-182     8..s1 7268705us : <stack trace>
[   27.949671]  => __ftrace_trace_stack
[   27.949671]  => rcu_torture_timer
[   27.949671]  => call_timer_fn
[   27.949671]  => run_timer_softirq
[   27.949671]  => __do_softirq
[   27.949671]  => irq_exit
[   27.949671]  => smp_apic_timer_interrupt
[   27.949671]  => apic_timer_interrupt
[   27.949671]  => rcutorture_one_extend
[   27.949671]  => rcu_torture_one_read
[   27.949671]  => rcu_torture_reader
[   27.949671]  => kthread
[   27.949671]  => ret_from_fork

So looks like torture testing modifications are called for, to run them in
hard interrupt context as well to provide this additional coverage.. Or am I
way off in the woods?

thanks,

 - Joel

