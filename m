Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8EFC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481F720B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ekic6LOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfGAJqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:46:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33798 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGAJqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jRQOuot/3DREIfxSXRdJMtvHKLC9IjBUX/bzg6FhxEk=; b=ekic6LOMRWZa+p+/oLNO3RAQv
        a4zs6w9e9ZTyO78XG+X7TJggUq9Zv4oDACdUCDz6usc1jr2S1/SuX31Jyx5cSiH4V3us92GV6qMLT
        0GXYn8S9dxxY+2j/iHCx719O7w8Ht4IeJBtWtReNykiN2dMJCVFf/1gbiDyZaVqcJdiX9Xn3CGK4V
        5AFRxTaZ6ORkIX19AJ3BR+M0ugmolyeERJ0WTPHR3dJKNjBAZqQeBzI+tHs+LYhPj1Oc1+n7l7LgE
        rR7QomvUzds+wnTAphG8WKvJEQ7ZkqMfHXGaqbSIXhi+tL6ob0D9roPWMZn+Zue6odRoRpTF54DGe
        U6Lj/N7Bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhssp-0005NY-H6; Mon, 01 Jul 2019 09:45:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 396C920963E23; Mon,  1 Jul 2019 11:45:58 +0200 (CEST)
Date:   Mon, 1 Jul 2019 11:45:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Scott Wood <swood@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190701094558.GS3402@hirez.programming.kicks-ass.net>
References: <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628141522.GF3402@hirez.programming.kicks-ass.net>
 <ea495c55c1aea45cc1b0e9ab6779354ba2a9983a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea495c55c1aea45cc1b0e9ab6779354ba2a9983a.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 03:01:36PM -0500, Scott Wood wrote:
> On Fri, 2019-06-28 at 16:15 +0200, Peter Zijlstra wrote:
> > On Thu, Jun 27, 2019 at 01:36:12PM -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 27, 2019 at 03:17:27PM -0500, Scott Wood wrote:
> > > > On Thu, 2019-06-27 at 11:41 -0700, Paul E. McKenney wrote:
> > > > > Of course, unconditionally refusing to do the wakeup might not be
> > > > > happy
> > > > > thing for NO_HZ_FULL kernels that don't implement IRQ work.
> > > > 
> > > > Couldn't smp_send_reschedule() be used instead?
> > > 
> > > Good point.  If current -rcu doesn't fix things for Sebastian's case,
> > > that would be well worth looking at.  But there must be some reason
> > > why Peter Zijlstra didn't suggest it when he instead suggested using
> > > the IRQ work approach.
> > > 
> > > Peter, thoughts?
> > 
> > I've not exactly kept up with the thread; but irq_work allows you to run
> > some actual code on the remote CPU which is often useful and it is only
> > a little more expensive than smp_send_reschedule().
> > 
> > Also, just smp_send_reschedule() doesn't really do anything without
> > first poking TIF_NEED_RESCHED (or other scheduler state) and if you want
> > to do both, there's other helpers you should use, like resched_cpu().
> 
> resched_cpu() will not send an IPI to the current CPU[1].

Correct, smp_send_reschedule() might not work for self, not all hardware
can self-IPI.

> Plus, the RCU
> code needs to set need_resched even in cases where it doesn't need to send
> the IPI.  And worst of all, resched_cpu() takes the rq lock which is the
> deadlock scenario we're trying to avoid.
> 
> -Scott
> 
> [1] Which makes me nervous about latency if there are any wakeups with irqs
> disabled, without a preempt_enable() after irqs are enabled again, and not
> inside an interrupt.

All good points; and those are all solved with irq_work. That provides a
'clean' IRQ context.
