Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFCFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C7922CEB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="i0VhpKk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfHSQZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:25:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46691 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfHSQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:25:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so1485778pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Im8H5DjaGTeKhVxCzYCiTtkyC8Mv3EVk0hT9uwqZD/M=;
        b=i0VhpKk4cUZElAQvULGvXmuApDKKqs+XLDcvrEGG+tMbXN6z9QV/oBiMkufq5U4KXn
         bb/NCfgZngkukmyuq/3lrBwtXMkkX+d9KOuJ3/E3K0Ljykld+cSuBYa4nBrZFglmSjkg
         gAtvsUsJVWyst+Xcsn6OI1azdG4fF5dnoKuBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Im8H5DjaGTeKhVxCzYCiTtkyC8Mv3EVk0hT9uwqZD/M=;
        b=nwtGtpeQ/sbldKedsLJH6huwfoUeDncKIqiUK1WXh/cLTMmrXXDnm2lVDJXlfgdY4F
         yAep7XUWosGIJZKbLjxRyBLPORQ+uSxN4+HpOQ5GOZj5snMnWcpdBNgI8xhmtlw4Ca9J
         JL5UTmpiLwQrLeXCeJrC0u2RfUMvTQsb5RZM2ImcaZVeO/dwYlMdOP+3dYsnkd4yvyZV
         fYjqHcEB2gOCgSDqlKAUbRn/gr7dEmEvtNE74q+XJA4GbMWrELFX+D0SisC6VZxggp2E
         VNOgNbk6I504Dn7KAt//bJ2QmSH6y6mVWNA4r8ACMfCDz9xvgsvGN5mtVdFMVTstN/ou
         CfuQ==
X-Gm-Message-State: APjAAAVcydo7kZrm0e4mAQAK1FRPhOVRhWqZOf80sXqodK8v3Nrx2RSj
        Rz+He+AUepv/42yVU2wVrI1mHw==
X-Google-Smtp-Source: APXvYqwNYp0e5aNRsYuEICoLhAqdC7HoB+2Fp+kWtHWe2npuwopBpswAy/EYp4WCc+b1Qtu4u1Il1Q==
X-Received: by 2002:aa7:8b52:: with SMTP id i18mr25406623pfd.194.1566231951873;
        Mon, 19 Aug 2019 09:25:51 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id m9sm17340923pfh.84.2019.08.19.09.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 09:25:51 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:25:34 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190819162534.GD117548@google.com>
References: <20190818223511.GB143857@google.com>
 <20190818233135.GQ28441@linux.ibm.com>
 <20190818233839.GA160903@google.com>
 <20190819012153.GR28441@linux.ibm.com>
 <20190819014143.GB160903@google.com>
 <20190819014623.GC160903@google.com>
 <20190819022927.GS28441@linux.ibm.com>
 <20190819125757.GA6946@linux.ibm.com>
 <20190819143314.GT28441@linux.ibm.com>
 <20190819154143.GA18470@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819154143.GA18470@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:41:43AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 19, 2019 at 07:33:14AM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 19, 2019 at 05:57:57AM -0700, Paul E. McKenney wrote:
> > > On Sun, Aug 18, 2019 at 07:29:27PM -0700, Paul E. McKenney wrote:
> > > > On Sun, Aug 18, 2019 at 09:46:23PM -0400, Joel Fernandes wrote:
> > > > > On Sun, Aug 18, 2019 at 09:41:43PM -0400, Joel Fernandes wrote:
> > > > > > On Sun, Aug 18, 2019 at 06:21:53PM -0700, Paul E. McKenney wrote:
> > > > > [snip]
> > > > > > > > > Also, your commit log's point #2 is "in_irq() implies in_interrupt()
> > > > > > > > > which implies raising softirq will not do any wake ups."  This mention
> > > > > > > > > of softirq seems a bit odd, given that we are going to wake up a rcuc
> > > > > > > > > kthread.  Of course, this did nothing to quell my suspicions.  ;-)
> > > > > > > > 
> > > > > > > > Yes, I should delete this #2 from the changelog since it is not very relevant
> > > > > > > > (I feel now). My point with #2 was that even if were to raise a softirq
> > > > > > > > (which we are not), a scheduler wakeup of ksoftirqd is impossible in this
> > > > > > > > path anyway since in_irq() implies in_interrupt().
> > > > > > > 
> > > > > > > Please!  Could you also add a first-principles explanation of why
> > > > > > > the added condition is immune from scheduler deadlocks?
> > > > > > 
> > > > > > Sure I can add an example in the change log, however I was thinking of this
> > > > > > example which you mentioned:
> > > > > > https://lore.kernel.org/lkml/20190627173831.GW26519@linux.ibm.com/
> > > > > > 
> > > > > > 	previous_reader()
> > > > > > 	{
> > > > > > 		rcu_read_lock();
> > > > > > 		do_something(); /* Preemption happened here. */
> > > > > > 		local_irq_disable(); /* Cannot be the scheduler! */
> > > > > > 		do_something_else();
> > > > > > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > > > > > 		do_some_other_thing();
> > > > > > 		local_irq_enable();
> > > > > > 	}
> > > > > > 
> > > > > > 	current_reader() /* QS from previous_reader() is still deferred. */
> > > > > > 	{
> > > > > > 		local_irq_disable();  /* Might be the scheduler. */
> > > > > > 		do_whatever();
> > > > > > 		rcu_read_lock();
> > > > > > 		do_whatever_else();
> > > > > > 		rcu_read_unlock();  /* Must still defer reporting QS. */
> > > > > > 		do_whatever_comes_to_mind();
> > > > > > 		local_irq_enable();
> > > > > > 	}
> > > > > > 
> > > > > > One modification of the example could be, previous_reader() could also do:
> > > > > > 	previous_reader()
> > > > > > 	{
> > > > > > 		rcu_read_lock();
> > > > > > 		do_something_that_takes_really_long(); /* causes need_qs in
> > > > > > 							  the unlock_special_union to be set */
> > > > > > 		local_irq_disable(); /* Cannot be the scheduler! */
> > > > > > 		do_something_else();
> > > > > > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > > > > > 		do_some_other_thing();
> > > > > > 		local_irq_enable();
> > > > > > 	}
> > > > > 
> > > > > The point you were making in that thread being, current_reader() ->
> > > > > rcu_read_unlock() -> rcu_read_unlock_special() would not do any wakeups
> > > > > because previous_reader() sets the deferred_qs bit.
> > > > > 
> > > > > Anyway, I will add all of this into the changelog.
> > > > 
> > > > Examples are good, but what makes it so that there are no examples of
> > > > its being unsafe?
> > > > 
> > > > And a few questions along the way, some quick quiz, some more serious.
> > > > Would it be safe if it checked in_interrupt() instead of in_irq()?
> > > > If not, should the in_interrupt() in the "if" condition preceding the
> > > > added "else if" be changed to in_irq()?  Would it make sense to add an
> > > > "|| !irqs_were_disabled" do your new "else if" condition?  Would the
> > > > body of the "else if" actually be executed in current mainline?
> > > > 
> > > > In an attempt to be at least a little constructive, I am doing some
> > > > testing of this patch overnight, along with a WARN_ON_ONCE() to see if
> > > > that invoke_rcu_core() is ever reached.
> > > 
> > > And that WARN_ON_ONCE() never triggered in two-hour rcutorture runs of
> > > TREE01, TREE02, TREE03, and TREE09.  (These are the TREE variants in
> > > CFLIST that have CONFIG_PREEMPT=y.)
> > > 
> > > This of course raises other questions.  But first, do you see that code
> > > executing in your testing?
> > 
> > Never mind!  Idiot here forgot the "--bootargs rcutree.use_softirq"...
> 
> So this time I ran the test this way:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 10 --configs "TREE01 TREE02 TREE03 TREE09" --bootargs "rcutree.use_softirq=0"
> 
> Still no splats.  Though only 10-minute runs instead of the two-hour runs
> I did last night.  (Got other stuff I need to do, sorry!)
> 
> My test version of your patch is shown below.  Please let me know if I messed
> something up.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 2defc7fe74c3..abf2fbba2568 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -621,6 +621,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			// Using softirq, safe to awaken, and we get
>  			// no help from enabling irqs, unlike bh/preempt.
>  			raise_softirq_irqoff(RCU_SOFTIRQ);
> +		} else if (exp && in_irq() && !use_softirq &&
> +			   !t->rcu_read_unlock_special.b.deferred_qs) {
> +			WARN_ON_ONCE(1); // Live code?
> +			invoke_rcu_core();

The change looks fine to me. I will test it out on my end today as well. It
could also be lack of code coverage for this case (?).

Will get back to you soon on this, thanks!

 - Joel

