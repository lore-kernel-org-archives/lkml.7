Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66262C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317E021773
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CC2YO/5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHSBmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:42:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35938 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfHSBmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 21:42:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so190555pgm.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 18:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GZ8KRd4m5tmf1sZH0S6i055h87V1Sn2Dsp8wrpuRW2I=;
        b=CC2YO/5wguKCQTET4BxoVFoyknrTC9mEtsaR0KfZra1yS6Z7NWVInFOefa/yn/TK5H
         a0zREvHq6w/5D6uDib9cB0lsf/PGWmE83+fQvDHmKsvcA+3t0W6OF8QwZ69IXqP/cIfq
         UFIhKICzQhQwPsNRBzFOzGebAou9XgBRqhA2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GZ8KRd4m5tmf1sZH0S6i055h87V1Sn2Dsp8wrpuRW2I=;
        b=C6D8zZ15G490B+TZSqcvK9ToHkwtpQxE7+gxjcSrNO0z3FPuz9+qleVN90K9e32shB
         IFCv56ZVHV7dE8SZtOc1GXBsbm5eejVga1lXEtoOGAdQE+y9HK55AiOrrXHgosuw1ggw
         OofCbHEXjD6ny7Whb1O+aNnTcpTQqKEWUi+S5ES6oJk58Qopy3zsNEcJPnl8RPUybV6c
         vTZDiUzFO+SAJt1JSloLzTgoLvWD1qNbJWjCnIxS/mN2Bkw02+KSLpG7lA01xCJkXI4Z
         FoNTOFsUt124D1gJR8VRgtTmyRvfD1dZm1VoqWDwYfhV1+D9TkJ9JgvyF/prH/HISaTD
         YNkw==
X-Gm-Message-State: APjAAAUd9JIsGBcGUsDsXC6fQJgi5P7VyvXOGk/26lIkIiYVo0wJ5gku
        hWV2apyqiYRkSCpbh8Z3A/fNklu1Y/M=
X-Google-Smtp-Source: APXvYqyEBa+u6Ju+6rey/3COmBroZZy8aLxdljJTHlK/Hd22pxrWiYNqZUqJY7j3uXws4p8YSZdzRw==
X-Received: by 2002:a63:1b66:: with SMTP id b38mr6194396pgm.54.1566178921490;
        Sun, 18 Aug 2019 18:42:01 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id m20sm15034426pff.79.2019.08.18.18.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 18:42:00 -0700 (PDT)
Date:   Sun, 18 Aug 2019 21:41:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190819014143.GB160903@google.com>
References: <20190818214948.GA134430@google.com>
 <20190818221210.GP28441@linux.ibm.com>
 <20190818223230.GA143857@google.com>
 <20190818223511.GB143857@google.com>
 <20190818233135.GQ28441@linux.ibm.com>
 <20190818233839.GA160903@google.com>
 <20190819012153.GR28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819012153.GR28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 06:21:53PM -0700, Paul E. McKenney wrote:
> On Sun, Aug 18, 2019 at 07:38:39PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 18, 2019 at 04:31:35PM -0700, Paul E. McKenney wrote:
> > > On Sun, Aug 18, 2019 at 06:35:11PM -0400, Joel Fernandes wrote:
> > > > On Sun, Aug 18, 2019 at 06:32:30PM -0400, Joel Fernandes wrote:
> > > > > On Sun, Aug 18, 2019 at 03:12:10PM -0700, Paul E. McKenney wrote:
> > > > > > On Sun, Aug 18, 2019 at 05:49:48PM -0400, Joel Fernandes (Google) wrote:
> > > > > > > When we're in hard interrupt context in rcu_read_unlock_special(), we
> > > > > > > can still benefit from invoke_rcu_core() doing wake ups of rcuc
> > > > > > > threads when the !use_softirq parameter is passed.  This is safe
> > > > > > > to do so because:
> > > > > > > 
> > > > > > > 1. We avoid the scheduler deadlock issues thanks to the deferred_qs bit
> > > > > > > introduced in commit 23634ebc1d94 ("rcu: Check for wakeup-safe
> > > > > > > conditions in rcu_read_unlock_special()") by checking for the same in
> > > > > > > this patch.
> > > > > > > 
> > > > > > > 2. in_irq() implies in_interrupt() which implies raising softirq will
> > > > > > > not do any wake ups.
> > > > > > > 
> > > > > > > The rcuc thread which is awakened will run when the interrupt returns.
> > > > > > > 
> > > > > > > We also honor 25102de ("rcu: Only do rcu_read_unlock_special() wakeups
> > > > > > > if expedited") thus doing the rcuc awakening only when none of the
> > > > > > > following are true:
> > > > > > >   1. Critical section is blocking an expedited GP.
> > > > > > >   2. A nohz_full CPU.
> > > > > > > If neither of these cases are true (exp == false), then the "else" block
> > > > > > > will run to do the irq_work stuff.
> > > > > > > 
> > > > > > > This commit is based on a partial revert of d143b3d1cd89 ("rcu: Simplify
> > > > > > > rcu_read_unlock_special() deferred wakeups") with an additional in_irq()
> > > > > > > check added.
> > > > > > > 
> > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > 
> > > > > > OK, I will bite...  If it is safe to wake up an rcuc kthread, why
> > > > > > is it not safe to do raise_softirq()?
> > > > > 
> > > > > Because raise_softirq should not be done and/or doesn't do anything
> > > > > if use_softirq == false. In fact, RCU_SOFTIRQ doesn't even existing if
> > > > > use_softirq == false. The "else if" condition of this patch uses for
> > > > > use_softirq.
> > > > > 
> > > > > Or, did I miss your point?
> > > 
> > > I am concerned that added "else if" condition might not be sufficient
> > > to eliminate all possible cases of the caller holding a scheduler lock,
> > > which could result in deadlock in the ensuing wakeup.  Might be me missing
> > > something, but such deadlocks have been a recurring problem in the past.
> > 
> > I thought that was the whole point of the
> > rcu_read_unlock_special.b.deferred_qs bit that was introduced in
> > 23634ebc1d94. We are checking that bit in the "else if" here as well. So this
> > should be no less immune to scheduler deadlocks any more than the preceding
> > "else if" where we are checking this bit.
> 
> I would have much more confidence in a line of reasoning that led to
> "immune to scheduler deadlocks" than one that led to "no less immune to
> scheduler deadlocks".  ;-)

That is fair :-D But let me explain,

What I meant is, if we are saying that this solution has a scheduler
deadlock, then that would almost certainly imply that the existing code has
scheduler deadlock issue. Since the existing code uses the same technique
(using the deferred_qs bit in the union) to prevent the deadlock we were
discussing a few months back. If that is indeed the case, it is good to be
discussing this since we can discuss if the existing code needs any fixing as
well.

> > > Also, your commit log's point #2 is "in_irq() implies in_interrupt()
> > > which implies raising softirq will not do any wake ups."  This mention
> > > of softirq seems a bit odd, given that we are going to wake up a rcuc
> > > kthread.  Of course, this did nothing to quell my suspicions.  ;-)
> > 
> > Yes, I should delete this #2 from the changelog since it is not very relevant
> > (I feel now). My point with #2 was that even if were to raise a softirq
> > (which we are not), a scheduler wakeup of ksoftirqd is impossible in this
> > path anyway since in_irq() implies in_interrupt().
> 
> Please!  Could you also add a first-principles explanation of why
> the added condition is immune from scheduler deadlocks?

Sure I can add an example in the change log, however I was thinking of this
example which you mentioned:
https://lore.kernel.org/lkml/20190627173831.GW26519@linux.ibm.com/

	previous_reader()
	{
		rcu_read_lock();
		do_something(); /* Preemption happened here. */
		local_irq_disable(); /* Cannot be the scheduler! */
		do_something_else();
		rcu_read_unlock();  /* Must defer QS, task still queued. */
		do_some_other_thing();
		local_irq_enable();
	}

	current_reader() /* QS from previous_reader() is still deferred. */
	{
		local_irq_disable();  /* Might be the scheduler. */
		do_whatever();
		rcu_read_lock();
		do_whatever_else();
		rcu_read_unlock();  /* Must still defer reporting QS. */
		do_whatever_comes_to_mind();
		local_irq_enable();
	}

One modification of the example could be, previous_reader() could also do:
	previous_reader()
	{
		rcu_read_lock();
		do_something_that_takes_really_long(); /* causes need_qs in
							  the unlock_special_union to be set */
		local_irq_disable(); /* Cannot be the scheduler! */
		do_something_else();
		rcu_read_unlock();  /* Must defer QS, task still queued. */
		do_some_other_thing();
		local_irq_enable();
	}


thanks!

 - Joel

