Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A39C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257C32084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfGSBLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:11:17 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:43009 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGSBLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:11:16 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 19 Jul 2019 10:11:15 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 19 Jul 2019 10:11:15 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 19 Jul 2019 10:10:11 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190719011011.GC28226@X58A-UD3R>
References: <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com>
 <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com>
 <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
 <20190719003942.GA28226@X58A-UD3R>
 <CAEXW_YQij-N2-NFjUQtsmYxVLtWxcQk_Kb16fGBzzPAZtWg+sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQij-N2-NFjUQtsmYxVLtWxcQk_Kb16fGBzzPAZtWg+sg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 08:52:52PM -0400, Joel Fernandes wrote:
> On Thu, Jul 18, 2019 at 8:40 PM Byungchul Park <byungchul.park@lge.com> wrote:
> [snip]
> > > - There is a bug in the CPU stopper machinery itself preventing it
> > > from scheduling the stopper on Y. Even though Y is not holding up the
> > > grace period.
> >
> > Or any thread on Y is busy with preemption/irq disabled preventing the
> > stopper from being scheduled on Y.
> >
> > Or something is stuck in ttwu() to wake up the stopper on Y due to any
> > scheduler locks such as pi_lock or rq->lock or something.
> >
> > I think what you mentioned can happen easily.
> >
> > Basically we would need information about preemption/irq disabled
> > sections on Y and scheduler's current activity on every cpu at that time.
> 
> I think all that's needed is an NMI backtrace on all CPUs. An ARM we
> don't have NMI solutions and only IPI or interrupt based backtrace
> works which should at least catch and the preempt disable and softirq
> disable cases.
> 
> But yeah I don't see why just the stacks of those CPUs that are
> blocking the CPU X would not suffice for the trivial cases where a
> piece of misbehaving code disable interrupts / preemption and
> prevented the stopper thread from executing.

Right. So it makes more interesting tho! :-)

> May be once the test case is ready (no rush!) , then it will be more
> clear what can help.

Yes. I'm really happy to help things about RCU that I love, fixed or
improved. And with the the test case or a real issue, I believe I can do
more helpful work. Looking forward to it, too (no rush!).

Thanks,
Byungchul

