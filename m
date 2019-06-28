Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06A3C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA6C205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfF1SUz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:20:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37501 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfF1SUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:20:54 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hgvUL-00044w-Ua; Fri, 28 Jun 2019 20:20:45 +0200
Date:   Fri, 28 Jun 2019 20:20:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628182045.ow4i5cncauk2jxjl@linutronix.de>
References: <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628164008.GB240964@google.com>
 <20190628164559.GC240964@google.com>
 <20190628173011.GX26519@linux.ibm.com>
 <20190628174545.pwgwi3wxl2eapkvm@linutronix.de>
 <20190628180727.GE240964@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190628180727.GE240964@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-28 14:07:27 [-0400], Joel Fernandes wrote:
> On Fri, Jun 28, 2019 at 07:45:45PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-06-28 10:30:11 [-0700], Paul E. McKenney wrote:
> > > > I believe the .blocked field remains set even though we are not any more in a
> > > > reader section because of deferred processing of the blocked lists that you
> > > > mentioned yesterday.
> > > 
> > > That can indeed happen.  However, in current -rcu, that would mean
> > > that .deferred_qs is also set, which (if in_irq()) would prevent
> > > the raise_softirq_irqsoff() from being invoked.  Which was why I was
> > > asking the questions about whether in_irq() returns true within threaded
> > > interrupts yesterday.  If it does, I need to find if there is some way
> > > of determining whether rcu_read_unlock_special() is being called from
> > > a threaded interrupt in order to suppress the call to raise_softirq()
> > > in that case.
> > 
> > Please not that:
> > | void irq_exit(void)
> > | {
> > |…
> > in_irq() returns true
> > |         preempt_count_sub(HARDIRQ_OFFSET);
> > in_irq() returns false
> > |         if (!in_interrupt() && local_softirq_pending())
> > |                 invoke_softirq();
> > 
> > -> invoke_softirq() does
> > |        if (!force_irqthreads) {
> > |                 __do_softirq();
> > |         } else {
> > |                 wakeup_softirqd();
> > |         }
> > 
> 
> In my traces which I shared previous email, the wakeup_softirqd() gets
> called.
> 
> I thought force_irqthreads value is decided at boot time, so I got lost a bit
> with your comment.

It does. I just wanted point out that in this case
rcu_unlock() / rcu_read_unlock_special() won't see in_irq() true.

Sebastian
