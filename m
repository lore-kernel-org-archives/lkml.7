Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115D0C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E772146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BRJUs3TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfF0SQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:16:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36033 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfF0SQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:16:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so1729000plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BqXuPgbDW9jqhBIRJbFP1aVNCPUo6cgHt9WqrHFg/IU=;
        b=BRJUs3TNRerJ3fL8rJInBzd8TDNO1Xt/5ZcpLmTBc9afiaB1MMX+OQsgBbhOdjqeds
         QeHsPOoP98odXHa2NkWNL7Sny9knai7Xms2gZ5yl3IlCGZA8TcPcV6XrVJMUAUZnh3fB
         c6EyIm0dSIf7n+Mcuvw0FKrix9o9A233jA1jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BqXuPgbDW9jqhBIRJbFP1aVNCPUo6cgHt9WqrHFg/IU=;
        b=RSUVQA6miP6aJM7g1efHSj7VlhFwPaMl8PHq7AMbBqX0WcBfgjWidf1bQ1AW3+kAwk
         +/bKgxDMF2w2YoJ4DZIfrPMFiesjzXmliTlnRx5e4yEalBRKg37rR4h+j81CNkFMg3vk
         /GsDM9ldhjez1zZ6PCElVhHw/0WpYC0UOSJBqMtOw4IpejINY6cFyvvswaYJeC3pH/6V
         33HsCllRNX5M7BFi7b0Rv6U/7uLZNV4VsIvVb2/aJtv6QJUYFHVNukWk3IgqjiFXmmo6
         V71PHS3GQ867KZ1tb7o5z7w64AS8OoT2EdHnXicbwedHgcOMBmR1YdqrEbyrt49nMnI1
         BK4A==
X-Gm-Message-State: APjAAAVUqjFU8L/jwUrWs71e7xE7B1/LopKUuaAbc+4LoKP/cuFJh2Bj
        kvQi1lRS7CUJlk9OAYG6ONO+XQ==
X-Google-Smtp-Source: APXvYqwehXNd4wUz0H/vlo6QWlr+zz7ONrR/4ce9LJBpll0BznfhO0S14Pq5QoVelxg1Ovr2MS6ltg==
X-Received: by 2002:a17:902:1c9:: with SMTP id b67mr6303823plb.333.1561659400991;
        Thu, 27 Jun 2019 11:16:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm3983347pfo.49.2019.06.27.11.16.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 11:16:40 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:16:38 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190627181638.GA209455@google.com>
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627173831.GW26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 10:38:31AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 27, 2019 at 12:47:24PM -0400, Joel Fernandes wrote:
> > On Thu, Jun 27, 2019 at 11:55 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > >
> > > On Thu, Jun 27, 2019 at 11:30:31AM -0400, Joel Fernandes wrote:
> > > > On Thu, Jun 27, 2019 at 10:34:55AM -0400, Steven Rostedt wrote:
> > > > > On Thu, 27 Jun 2019 10:24:36 -0400
> > > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > > > What am I missing here?
> > > > > >
> > > > > > This issue I think is
> > > > > >
> > > > > > (in normal process context)
> > > > > > spin_lock_irqsave(rq_lock); // which disables both preemption and interrupt
> > > > > >                      // but this was done in normal process context,
> > > > > >                      // not from IRQ handler
> > > > > > rcu_read_lock();
> > > > > >           <---------- IPI comes in and sets exp_hint
> > > > >
> > > > > How would an IPI come in here with interrupts disabled?
> > > > >
> > > > > -- Steve
> > > >
> > > > This is true, could it be rcu_read_unlock_special() got called for some
> > > > *other* reason other than the IPI then?
> > > >
> > > > Per Sebastian's stack trace of the recursive lock scenario, it is happening
> > > > during cpu_acct_charge() which is called with the rq_lock held.
> > > >
> > > > The only other reasons I know off to call rcu_read_unlock_special() are if
> > > > 1. the tick indicated that the CPU has to report a QS
> > > > 2. an IPI in the middle of the reader section for expedited GPs
> > > > 3. preemption in the middle of a preemptible RCU reader section
> > >
> > > 4. Some previous reader section was IPIed or preempted, but either
> > >    interrupts, softirqs, or preemption was disabled across the
> > >    rcu_read_unlock() of that previous reader section.
> > 
> > Hi Paul, I did not fully understand 4. The previous RCU reader section
> > could not have been IPI'ed or been preempted if interrupts were
> > disabled across. Also, if softirq/preempt is disabled across the
> > previous reader section, the previous reader could not be preempted in
> > these case.
> 
> Like this, courtesy of the consolidation of RCU flavors:
> 
> 	previous_reader()
> 	{
> 		rcu_read_lock();
> 		do_something(); /* Preemption happened here. */
> 		local_irq_disable(); /* Cannot be the scheduler! */
> 		do_something_else();
> 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> 		do_some_other_thing();
> 		local_irq_enable();
> 	}
> 
> 	current_reader() /* QS from previous_reader() is still deferred. */
> 	{
> 		local_irq_disable();  /* Might be the scheduler. */
> 		do_whatever();
> 		rcu_read_lock();
> 		do_whatever_else();
> 		rcu_read_unlock();  /* Must still defer reporting QS. */
> 		do_whatever_comes_to_mind();
> 		local_irq_enable();
> 	}
> 
> Both instances of rcu_read_unlock() need to cause some later thing
> to report the quiescent state, and in some cases it will do a wakeup.
> Now, previous_reader()'s IRQ disabling cannot be due to scheduler rq/pi
> locks due to the rule about holding them across the entire RCU reader
> if they are held across the rcu_read_unlock().  But current_reader()'s
> IRQ disabling might well be due to the scheduler rq/pi locks, so
> current_reader() must be careful about doing wakeups.

Makes sense now, thanks.

> > That leaves us with the only scenario where the previous reader was
> > IPI'ed while softirq/preempt was disabled across it. Is that what you
> > meant?
> 
> No, but that can also happen.
> 
> >        But in this scenario, the previous reader should have set
> > exp_hint to false in the previous reader's rcu_read_unlock_special()
> > invocation itself. So I would think t->rcu_read_unlock_special should
> > be 0 during the new reader's invocation thus I did not understand how
> > rcu_read_unlock_special can be called because of a previous reader.
> 
> Yes, exp_hint would unconditionally be set to false in the first
> reader's rcu_read_unlock().  But .blocked won't be.

Makes sense.

> > I'll borrow some of that confused color paint if you don't mind ;-)
> > And we should document this somewhere for future sanity preservation
> > :-D
> 
> Or adjust the code and requirements to make it more sane, if feasible.
> 
> My current (probably wildly unreliable) guess that the conditions in
> rcu_read_unlock_special() need adjusting.  I was assuming that in_irq()
> implies a hardirq context, in other words that in_irq() would return
> false from a threaded interrupt handler.  If in_irq() instead returns
> true from within a threaded interrupt handler, then this code in
> rcu_read_unlock_special() needs fixing:
> 
> 		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
> 		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> 			// Using softirq, safe to awaken, and we get
> 			// no help from enabling irqs, unlike bh/preempt.
> 			raise_softirq_irqoff(RCU_SOFTIRQ);
> 
> The fix would be replacing the calls to in_irq() with something that
> returns true only if called from within a hardirq context.
> Thoughts?

I am not sure if this will fix all cases though?

I think the crux of the problem is doing a recursive wake up. The threaded
IRQ probably just happens to be causing it here, it seems to me this problem
can also occur on a non-threaded irq system (say current_reader() in your
example executed in a scheduler path in process-context and not from an
interrupt). Is that not possible?

I think the fix should be to prevent the wake-up not based on whether we are
in hard/soft-interrupt mode but that we are doing the rcu_read_unlock() from
a scheduler path (if we can detect that)

I lost track of this code:
 		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
 		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {

Was this patch posted to the list? I will blame it to try to get some
context. It sounds like you added more conditions on when to kick the
softirq.

> Ugh.  Same question about IRQ work.  Will the current use of it by
> rcu_read_unlock_special() cause breakage in the presence of threaded
> interrupt handlers?

/me needs to understand why the irq work stuff was added here as well. Have
my work cut out for the day! ;-)

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> > thanks,
> >  - Joel
> > 
> > 
> > 
> > >
> > > I -think- that this is what Sebastian is seeing.
> > >
> > >                                                         Thanx, Paul
> > >
> > > > 1. and 2. are not possible because interrupts are disabled, that's why the
> > > > wakeup_softirq even happened.
> > > > 3. is not possible because we are holding rq_lock in the RCU reader section.
> > > >
> > > > So I am at a bit of a loss how this can happen :-(
> > > >
> > > > Spurious call to rcu_read_unlock_special() may be when it should not have
> > > > been called?
> > > >
> > > > thanks,
> > > >
> > > > - Joel
> 
