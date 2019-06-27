Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2FCC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C119020B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sBBjmakC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0SvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:51:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34463 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0SvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:51:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so1776434plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/9M26T3oiyNuR9GuR1JIFyMn1p0ZbmIJLvb6ri0eB+o=;
        b=sBBjmakC1uzlgJ2S58gqpXQlJ9nRUqB0pweEg0wT2zxyGda8K3n9+G1Zl5S1gkfdYi
         wMPfHuUFfwB9QCqLY9eX4OHp+OXo5cPA2FV3y8/MbBTe/HZe0FG5/G0jprniXM9nPDcY
         7uFBp3q5vjLyagFpCnWcmD9leeTNQQPHodA0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/9M26T3oiyNuR9GuR1JIFyMn1p0ZbmIJLvb6ri0eB+o=;
        b=JmQ/wsBlVCIoECPWWElS1DfcXU+3YnEN7J1YatjAr1UQMVCJgHlk2ABpZ2Ld9InxIt
         Om6ZUOLiCn2vlc3etc7Zz3ATsR9Ok2BbqtlHejK5fK9SZYM9leBerFk3NLYlBz2kwfY1
         R0w6ErTRj6umb4HNduHbfe7BWHr+fmomqWO8gb3MG/3CEYPp/IgxsDhGhBp+yYd8aG4i
         w0YKFC6/JQis83oEKFCY2hAHIXD+Zc7tyKalRyTNXzGPAzXxglisKRsniVZXgg40QBT4
         cMj7y5RAAINZQ2DqWtOMnMgQqqpORMCiy/SyPMdf5nXreLVWlh05aYFm+Rd6MgwObT+T
         aSVw==
X-Gm-Message-State: APjAAAWKL7pg9NtdqHJ5AJ1SqiFU/XEoQNW9ftzVDcosZA/efAcpalqE
        +ykNfGFzqBHL9W0Cmb4qRCXcJQ==
X-Google-Smtp-Source: APXvYqwsoSSJMzj+6ufN6aS4G4gCzQIZeBcpbmot5k14HkvmicJh+K2PEVCmTpY5SjESAz+dfhdZvw==
X-Received: by 2002:a17:902:363:: with SMTP id 90mr6235047pld.340.1561661465292;
        Thu, 27 Jun 2019 11:51:05 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g13sm3741104pfi.93.2019.06.27.11.51.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 11:51:04 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:51:03 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190627185103.GA8956@google.com>
References: <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <CAEXW_YT5LgdP_9SrachU4ZrhV9a7o_DM8eBfgxj=n7yRRyS-TQ@mail.gmail.com>
 <20190627154011.vbje64x6auaknhx4@linutronix.de>
 <CAEXW_YTvkSTqwi_jOE2Pr+uD-GC4Xv0CtBEL9YO7=LvJcM3FBQ@mail.gmail.com>
 <CAEXW_YTmx3wFKuiLyrQO6uSPYAL179EPa6N3WO7qZahccCs-pg@mail.gmail.com>
 <20190627181112.GY26519@linux.ibm.com>
 <20190627182722.GA216610@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627182722.GA216610@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 02:27:22PM -0400, Joel Fernandes wrote:
> On Thu, Jun 27, 2019 at 11:11:12AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 27, 2019 at 01:46:27PM -0400, Joel Fernandes wrote:
> > > On Thu, Jun 27, 2019 at 1:43 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Thu, Jun 27, 2019 at 11:40 AM Sebastian Andrzej Siewior
> > > > <bigeasy@linutronix.de> wrote:
> > > > >
> > > > > On 2019-06-27 11:37:10 [-0400], Joel Fernandes wrote:
> > > > > > Sebastian it would be nice if possible to trace where the
> > > > > > t->rcu_read_unlock_special is set for this scenario of calling
> > > > > > rcu_read_unlock_special, to give a clear idea about whether it was
> > > > > > really because of an IPI. I guess we could also add additional RCU
> > > > > > debug fields to task_struct (just for debugging) to see where there
> > > > > > unlock_special is set.
> > > > > >
> > > > > > Is there a test to reproduce this, or do I just boot an intel x86_64
> > > > > > machine with "threadirqs" and run into it?
> > > > >
> > > > > Do you want to send me a patch or should I send you my kvm image which
> > > > > triggers the bug on boot?
> > > >
> > > > I could reproduce this as well just booting Linus tree with threadirqs
> > > > command line and running rcutorture. In 15 seconds or so it locks
> > > > up... gdb backtrace shows the recursive lock:
> > > 
> > > Sorry that got badly wrapped, so I pasted it here:
> > > https://hastebin.com/ajivofomik.shell
> > 
> > Which rcutorture scenario would that be?  TREE03 is thus far refusing
> > to fail for me when run this way:
> > 
> > $ tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 5 --trust-make --configs "TREE03" --bootargs "threadirqs"
> 
> I built x86_64_defconfig with CONFIG_PREEMPT enabled, then I ran it with
> following boot params:
> rcutorture.shutdown_secs=60 rcutorture.n_barrier_cbs=4 rcutree.kthread_prio=2
> 
> and also "threadirqs"
> 
> This was not a TREE config, but just my simple RCU test using qemu.

Ah, it seems that the issue is reproducible in Linus tree only (which matches
the initial diff Sebastian posted). It cannot be reproduced with your /dev
branch. So perhaps the in_irq() check indeed works.

Looking further, in_irq() does also set the HARDIRQ_MASK in the preempt_count
courtesy of:
#define __irq_enter()                                   \
        do {                                            \
                account_irq_enter_time(current);        \
                preempt_count_add(HARDIRQ_OFFSET);      \
                trace_hardirq_enter();

I dumped the stack at this point as well even with "threadirqs" just to
double confirm that is the case.

So probably, the in_irq() check is sufficient. However I am still a bit
nervous about this issue manifesting in other paths of the scheduler
that don't execute from an interrupt handler, but still would have RCU
reader sections with spinlocks held - I am not sure if this is possible
though but it does make me nervous.

Thanks!

> 
> 
> I will try this diff and let you know.
> 
> > If it had failed, I would have tried the patch shown below.  I know that
> > Sebastian has some concerns about the bug happening anyway, but we have
> > to start somewhere!  ;-)
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 82c925df1d92..be7bafc2c0a0 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -624,25 +624,16 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  		      (rdp->grpmask & rnp->expmask) ||
> >  		      tick_nohz_full_cpu(rdp->cpu);
> >  		// Need to defer quiescent state until everything is enabled.
> > -		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
> > -		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> > -			// Using softirq, safe to awaken, and we get
> > -			// no help from enabling irqs, unlike bh/preempt.
> > -			raise_softirq_irqoff(RCU_SOFTIRQ);
> > -		} else {
> > -			// Enabling BH or preempt does reschedule, so...
> > -			// Also if no expediting or NO_HZ_FULL, slow is OK.
> > -			set_tsk_need_resched(current);
> > -			set_preempt_need_resched();
> > -			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> > -			    !rdp->defer_qs_iw_pending && exp) {
> > -				// Get scheduler to re-evaluate and call hooks.
> > -				// If !IRQ_WORK, FQS scan will eventually IPI.
> > -				init_irq_work(&rdp->defer_qs_iw,
> > -					      rcu_preempt_deferred_qs_handler);
> > -				rdp->defer_qs_iw_pending = true;
> > -				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > -			}
> > +		set_tsk_need_resched(current);
> > +		set_preempt_need_resched();
> > +		if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> > +		    !rdp->defer_qs_iw_pending && exp) {
> > +			// Get scheduler to re-evaluate and call hooks.
> > +			// If !IRQ_WORK, FQS scan will eventually IPI.
> > +			init_irq_work(&rdp->defer_qs_iw,
> > +				      rcu_preempt_deferred_qs_handler);
> > +			rdp->defer_qs_iw_pending = true;
> > +			irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> 
> Nice to see the code here got simplified ;-)
> 
