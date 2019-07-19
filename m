Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA2C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D8A21851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfGSAkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:40:47 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:40020 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfGSAkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:40:47 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 19 Jul 2019 09:40:45 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.121 with ESMTP; 19 Jul 2019 09:40:45 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 19 Jul 2019 09:39:42 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190719003942.GA28226@X58A-UD3R>
References: <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com>
 <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com>
 <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:14:22PM -0400, Joel Fernandes wrote:
> Trimming the list a bit to keep my noise level low,
> 
> On Sat, Jul 13, 2019 at 1:41 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> [snip]
> > > It still feels like you guys are hyperfocusing on this one particular
> > > > knob.  I instead need you to look at the interrelating knobs as a group.
> > >
> > > Thanks for the hints, we'll do that.
> > >
> > > > On the debugging side, suppose someone gives you an RCU bug report.
> > > > What information will you need?  How can you best get that information
> > > > without excessive numbers of over-and-back interactions with the guy
> > > > reporting the bug?  As part of this last question, what information is
> > > > normally supplied with the bug?  Alternatively, what information are
> > > > bug reporters normally expected to provide when asked?
> > >
> > > I suppose I could dig out some of our Android bug reports of the past where
> > > there were RCU issues but if there's any fires you are currently fighting do
> > > send it our way as debugging homework ;-)
> >
> >   Suppose that you were getting RCU CPU stall
> > warnings featuring multi_cpu_stop() called from cpu_stopper_thread().
> > Of course, this really means that some other CPU/task is holding up
> > multi_cpu_stop() without also blocking the current grace period.
> >
> 
> So I took a shot at this trying to learn how CPU stoppers work in
> relation to this problem.
> 
> I am assuming here say CPU X has entered MULTI_STOP_DISABLE_IRQ state
> in multi_cpu_stop() but another CPU Y has not yet entered this state.
> So CPU X is stalling RCU but it is really because of CPU Y. Now in the
> problem statement, you mentioned CPU Y is not holding up the grace
> period, which means Y doesn't have any of IRQ, BH or preemption
> disabled ; but is still somehow stalling RCU indirectly by troubling
> X.
> 
> This can only happen if :
> - CPU Y has a thread executing on it that is higher priority than CPU
> X's stopper thread which prevents it from getting scheduled. - but the
> CPU stopper thread (migration/..) is highest priority RT so this would
> be some kind of an odd scheduler bug.

I think this bug hardly can happen.

> - There is a bug in the CPU stopper machinery itself preventing it
> from scheduling the stopper on Y. Even though Y is not holding up the
> grace period.

Or any thread on Y is busy with preemption/irq disabled preventing the
stopper from being scheduled on Y.

Or something is stuck in ttwu() to wake up the stopper on Y due to any
scheduler locks such as pi_lock or rq->lock or something.

I think what you mentioned can happen easily.

Basically we would need information about preemption/irq disabled
sections on Y and scheduler's current activity on every cpu at that time.

Am I missing something?

> Did I get that right? Would be exciting to run the rcutorture test
> once Paul has it available to reproduce this problem.

Thanks,
Byungchul

