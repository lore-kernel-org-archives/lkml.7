Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE34C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770812086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RTwiSKhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF0OYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:24:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37364 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfF0OYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:24:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so1397967plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SHTB4Z6XW4tYdotgBg3rQI5OzHkx05PWO8EvnuTdDpA=;
        b=RTwiSKhGsYe+BkJrX+Ptijk2tNusw6yE5rW9P9psNclbEu160/BAP/kRa80FoikZ7u
         U8O9WeOOv56yfmAa1/rYNDE1sJeKalQ0Gsif43a3Kvx3L/08vODwyFWvLpjgU/lavAfe
         RQm/BjBq/so/oR9z5wqqvEfKacV8cSe83mbgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHTB4Z6XW4tYdotgBg3rQI5OzHkx05PWO8EvnuTdDpA=;
        b=twnbVlc7zdBSjJOiCO6E29Spx4ow6iAXWfQa+rUlf/2Q2B6cZBAm7tkWZIvfMQH5AH
         bR8WTbqpRsjrxxLPKmArV8pW2yfpckBh2pl55TILo/QJEarcAH0BFxccT4PJ2G1RaKTk
         mvZrVz4bd2AzwOlJS1ZqvKZp6sd46puyqxhwk9ywaeFHrZuFa+B57y4tRXTIwryYb3ev
         TktOUaa19N3I2JBulSb90LzqJf8CwBjD329epM1Fbpp9Zn6ufIrNVl+EepCvq5oXm22l
         raUzUBzbuxCZiEPi86PCl5B73ITuxTpcPxEkpsTQAHrSXjp1D1dzlN4ZETRBKtUCKEs3
         nYEg==
X-Gm-Message-State: APjAAAUr+rbskWT/NMVKcdOhspIV4IJsE9Lr1Pktey7FwM0cUbD51lbK
        H3lvdtZH+XbhwDeAPqQ+OdYsCN+3oGZXAA==
X-Google-Smtp-Source: APXvYqx3V0r+qIK0XMntowRFU9cO8eldPMAXzsI0yP8rMipeq/2aTkTmDr6A7tkBbvhCbl6gJpv0Yg==
X-Received: by 2002:a17:902:a81:: with SMTP id 1mr4936656plp.287.1561645478476;
        Thu, 27 Jun 2019 07:24:38 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o13sm9155200pje.28.2019.06.27.07.24.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 07:24:37 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:24:36 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190627142436.GD215968@google.com>
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626162558.GY26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:25:58AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 26, 2019 at 03:54:47PM +0200, Sebastian Andrzej Siewior wrote:
> > one of my boxes boots with "threadirqs" and since commit 05f415715ce45
> > ("rcu: Speed up expedited GPs when interrupting RCU reader") I run
> > reliably into the following deadlock:
> > 
> > | ============================================
> > | WARNING: possible recursive locking detected
> > | 5.2.0-rc6 #279 Not tainted
> > | --------------------------------------------
> > | (cron)/2109 is trying to acquire lock:
> > | 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
> > |
> > | but task is already holding lock:
> > | 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
> > |
> > | other info that might help us debug this:
> > |  Possible unsafe locking scenario:
> > |
> > |        CPU0
> > |        ----
> > |   lock(&p->pi_lock);  
> > |   lock(&p->pi_lock);  
> > |
> > |  *** DEADLOCK ***
> > |
> > |  May be due to missing lock nesting notation
> > |
> > | 4 locks held by (cron)/2109:
> > |  #0: 00000000c0ae63d9 (&sb->s_type->i_mutex_key){++++}, at: iterate_dir+0x3d/0x170
> > |  #1: 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
> > |  #2: 00000000f62f14cf (&rq->lock){-.-.}, at: try_to_wake_up+0x209/0x700
> > |  #3: 000000000d32568e (rcu_read_lock){....}, at: cpuacct_charge+0x37/0x1e0
> > |
> > | stack backtrace:
> > | CPU: 3 PID: 2109 Comm: (cron) Not tainted 5.2.0-rc6 #279
> > | Call Trace:
> > |  <IRQ>
> > |  dump_stack+0x67/0x90 
> > |  __lock_acquire.cold.63+0x142/0x23a
> > |  lock_acquire+0x9b/0x1a0
> > |  ? try_to_wake_up+0x37/0x700
> > |  _raw_spin_lock_irqsave+0x33/0x50
> > |  ? try_to_wake_up+0x37/0x700
> > |  try_to_wake_up+0x37/0x700
> > wake up ksoftirqd
> > 
> > |  rcu_read_unlock_special+0x61/0xa0
> > |  __rcu_read_unlock+0x58/0x60
> > |  cpuacct_charge+0xeb/0x1e0
> > |  update_curr+0x15d/0x350
> > |  enqueue_entity+0x115/0x7e0
> > |  enqueue_task_fair+0x78/0x450
> > |  activate_task+0x41/0x90
> > |  ttwu_do_activate+0x49/0x80
> > |  try_to_wake_up+0x23f/0x700
> > 
> > wake up ksoftirqd
> > 
> > |  irq_exit+0xba/0xc0   
> > |  smp_apic_timer_interrupt+0xb2/0x2a0
> > |  apic_timer_interrupt+0xf/0x20
> > |  </IRQ>
> > 
> > based one the commit it seems the problem was always there but now the
> > mix of raise_softirq_irqoff() and set_tsk_need_resched() seems to hit
> > the window quite reliably. Replacing it with 
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 1102765f91fd1..baab36f4d0f45 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -627,14 +627,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >         if (preempt_bh_were_disabled || irqs_were_disabled) {
> >                 WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> >                 /* Need to defer quiescent state until everything is enabled. */
> > -               if (irqs_were_disabled) {
> > -                       /* Enabling irqs does not reschedule, so... */
> > -                       raise_softirq_irqoff(RCU_SOFTIRQ);
> > -               } else {
> > -                       /* Enabling BH or preempt does reschedule, so... */
> > -                       set_tsk_need_resched(current);
> > -                       set_preempt_need_resched();
> > -               }
> > +               raise_softirq_irqoff(RCU_SOFTIRQ);
> >                 local_irq_restore(flags);
> >                 return;
> >         }
> > 
> > will make it go away.
> 
> Color me confused.  Neither set_tsk_need_resched() nor
> set_preempt_need_resched() acquire locks or do wakeups.
> Yet raise_softirq_irqoff() can do a wakeup if not called
> from hardirq/softirq/NMI context, so I would instead expect
> raise_softirq_irqoff() to be the source of troubles when
> interrupts are threaded.
> 
> What am I missing here?

This issue I think is

(in normal process context)
spin_lock_irqsave(rq_lock); // which disables both preemption and interrupt
			   // but this was done in normal process context,
			   // not from IRQ handler
rcu_read_lock();
          <---------- IPI comes in and sets exp_hint
rcu_read_unlock()
   -> rcu_read_unlock_special
        -> raise_softirq_irqoff
	    -> wakeup_softirq  <--- because in_interrupt returns false.

I think the issue is in_interrupt() does not know about threaded interrupts.
If it did, then the ksoftirqd wake up would not happen.

Did I get something wrong?

thanks,

 - Joel


> > Any suggestions?
> 
> Does something like IRQ work help?  Please see -rcu commit 0864f057b050
> ("rcu: Use irq_work to get scheduler's attention in clean context")
> for one way of doing this.  Perhaps in combination with -rcu commit
> a69987a515c8 ("rcu: Simplify rcu_read_unlock_special() deferred wakeups").
> 
> 							Thanx, Paul
