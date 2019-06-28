Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14EFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E03721738
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfF1UBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:01:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfF1UBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:01:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AC413086234;
        Fri, 28 Jun 2019 20:01:39 +0000 (UTC)
Received: from ovpn-116-138.phx2.redhat.com (ovpn-116-138.phx2.redhat.com [10.3.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B8335C88A;
        Fri, 28 Jun 2019 20:01:37 +0000 (UTC)
Message-ID: <ea495c55c1aea45cc1b0e9ab6779354ba2a9983a.camel@redhat.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 28 Jun 2019 15:01:36 -0500
In-Reply-To: <20190628141522.GF3402@hirez.programming.kicks-ass.net>
References: <20190627142436.GD215968@google.com>
         <20190627103455.01014276@gandalf.local.home>
         <20190627153031.GA249127@google.com> <20190627155506.GU26519@linux.ibm.com>
         <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
         <20190627173831.GW26519@linux.ibm.com> <20190627181638.GA209455@google.com>
         <20190627184107.GA26519@linux.ibm.com>
         <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
         <20190627203612.GD26519@linux.ibm.com>
         <20190628141522.GF3402@hirez.programming.kicks-ass.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 28 Jun 2019 20:01:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-28 at 16:15 +0200, Peter Zijlstra wrote:
> On Thu, Jun 27, 2019 at 01:36:12PM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 27, 2019 at 03:17:27PM -0500, Scott Wood wrote:
> > > On Thu, 2019-06-27 at 11:41 -0700, Paul E. McKenney wrote:
> > > > Of course, unconditionally refusing to do the wakeup might not be
> > > > happy
> > > > thing for NO_HZ_FULL kernels that don't implement IRQ work.
> > > 
> > > Couldn't smp_send_reschedule() be used instead?
> > 
> > Good point.  If current -rcu doesn't fix things for Sebastian's case,
> > that would be well worth looking at.  But there must be some reason
> > why Peter Zijlstra didn't suggest it when he instead suggested using
> > the IRQ work approach.
> > 
> > Peter, thoughts?
> 
> I've not exactly kept up with the thread; but irq_work allows you to run
> some actual code on the remote CPU which is often useful and it is only
> a little more expensive than smp_send_reschedule().
> 
> Also, just smp_send_reschedule() doesn't really do anything without
> first poking TIF_NEED_RESCHED (or other scheduler state) and if you want
> to do both, there's other helpers you should use, like resched_cpu().

resched_cpu() will not send an IPI to the current CPU[1].  Plus, the RCU
code needs to set need_resched even in cases where it doesn't need to send
the IPI.  And worst of all, resched_cpu() takes the rq lock which is the
deadlock scenario we're trying to avoid.

-Scott

[1] Which makes me nervous about latency if there are any wakeups with irqs
disabled, without a preempt_enable() after irqs are enabled again, and not
inside an interrupt.

