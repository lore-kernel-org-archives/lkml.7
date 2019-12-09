Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703D2C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3341C214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575917957;
	bh=7ajHhqLPRSdhijGUTDGrfPaimYZfeDzD4uktbE6S/BI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=V6B4hbr9832FKlznm42mwOTD0Ob1FXwCuEt8WyM3Ps3xTLkEmmLnw4ZEW4VG0f5sl
	 pidvHbcn/wHaRI9TsHKZdquqIo1vHK3tHG1CoY0zZOts28BuzLsh4zfBPJTT9zOcGP
	 HcmWGy5dtY6t/3gxR2PRdt71ajzuR5PgKFyEHy6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLIS7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfLIS7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:59:10 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75DF4205C9;
        Mon,  9 Dec 2019 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575917949;
        bh=7ajHhqLPRSdhijGUTDGrfPaimYZfeDzD4uktbE6S/BI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PCXMJjPxKyI6EGqlYmAB0QWzvgOt7Uwl8SJqbKiC3aPvMYqPrN3IjC1KVBhmlPw5y
         RAEzCQIiVc8PCkmIajEDA+xudwyx1+jGf/yNHsD4OAowqLXzUcq6PJbnuUMc+WSokd
         lIz5ItX0BqESfTxcRNGHU3ZZ4j8ALyDZVaKhrOh4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 023343522769; Mon,  9 Dec 2019 10:59:08 -0800 (PST)
Date:   Mon, 9 Dec 2019 10:59:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191209185908.GA8470@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
 <20191204201150.GA14040@paulmck-ThinkPad-P72>
 <20191205102928.GG2810@hirez.programming.kicks-ass.net>
 <20191205103213.GB2871@hirez.programming.kicks-ass.net>
 <20191205144805.GR2889@paulmck-ThinkPad-P72>
 <20191206185208.GA25636@paulmck-ThinkPad-P72>
 <20191206220020.GA27511@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206220020.GA27511@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 02:00:20PM -0800, Paul E. McKenney wrote:
> On Fri, Dec 06, 2019 at 10:52:08AM -0800, Paul E. McKenney wrote:
> > On Thu, Dec 05, 2019 at 06:48:05AM -0800, Paul E. McKenney wrote:
> > > On Thu, Dec 05, 2019 at 11:32:13AM +0100, Peter Zijlstra wrote:
> > > > On Thu, Dec 05, 2019 at 11:29:28AM +0100, Peter Zijlstra wrote:
> > > > > On Wed, Dec 04, 2019 at 12:11:50PM -0800, Paul E. McKenney wrote:
> > > > > 
> > > > > > And the good news is that I didn't see the workqueue splat, though my
> > > > > > best guess is that I had about a 13% chance of not seeing it due to
> > > > > > random chance (and I am currently trying an idea that I hope will make
> > > > > > it more probable).  But I did get a couple of new complaints about RCU
> > > > > > being used illegally from an offline CPU.  Splats below.
> > > > > 
> > > > > Shiny!
> > > 
> > > And my attempt to speed things up did succeed, but the success was limited
> > > to finding more places where rcutorture chokes on CPUs being slow to boot.
> > > Fixing those and trying again...
> > 
> > And I finally did manage to get a clean run.  There are probably a few
> > more things that a large slow-booting hyperthreaded system can do to
> > confuse rcutorture, but it is at least down to a dull roar.
> > 
> > > > > > Your patch did rearrange the CPU-online sequence, so let's see if I
> > > > > > can piece things together...
> > > > > > 
> > > > > > RCU considers a CPU to be online at rcu_cpu_starting() time.  This is
> > > > > > called from notify_cpu_starting(), which is called from the arch-specific
> > > > > > CPU-bringup code.  Any RCU readers before rcu_cpu_starting() will trigger
> > > > > > the warning I am seeing.
> > > > > 
> > > > > Right.
> > > > > 
> > > > > > The original location of the stop_machine_unpark() was in
> > > > > > bringup_wait_for_ap(), which is called from bringup_cpu(), which is in
> > > > > > the CPUHP_BRINGUP_CPU entry of cpuhp_hp_states[].  Which, if I am not
> > > > > > too confused, is invoked by some CPU other than the to-be-incoming CPU.
> > > > > 
> > > > > Correct.
> > > > > 
> > > > > > The new location of the stop_machine_unpark() is in cpuhp_online_idle(),
> > > > > > which is called from cpu_startup_entry(), which is invoked from
> > > > > > the arch-specific bringup code that runs on the incoming CPU.
> > > > > 
> > > > > The new place is the final piece of bringup, it is right before where
> > > > > the freshly woken CPU will drop into the idle loop and start scheduling
> > > > > (for the first time).
> > > > > 
> > > > > > Which
> > > > > > is the same code that invokes notify_cpu_starting(), so we need
> > > > > > notify_cpu_starting() to be invoked before cpu_startup_entry().
> > > > > 
> > > > > Right, that is right before we run what used to be the CPU_STARTING
> > > > > notifiers. This is in fact (on x86) before the CPU is marked
> > > > > cpu_online(). It has to be before cpu_startup_entry(), before this is
> > > > > ran with IRQs disabled, while cpu_startup_entry() demands IRQs are
> > > > > enabled.
> > > > > 
> > > > > > The order is not immediately obvious on IA64.  But it looks like
> > > > > > everything else does it in the required order, so I am a bit confused
> > > > > > about this.
> > > > > 
> > > > > That makes two of us, afaict we have RCU up and running when we get to
> > > > > the idle loop.
> > > > 
> > > > Or did we need rcutree_online_cpu() to have ran? Because that is ran
> > > > much later than this...
> > > 
> > > No, rcu_cpu_starting() does the trick.  So I remain confused.
> > > 
> > > My thought is to add some printk()s or tracing to rcu_cpu_starting()
> > > and its counterpart, rcu_report_dead().  But is there a better way?
> > 
> > And the answer is...
> > 
> > This splat happens even without your fix!
> > 
> > Which goes a long way to explaining why neither of us could figure out
> > how your fix could have caused it.  It apparently was the increased
> > stress required to reproduce quickly rather than your fix that made it
> > happen more frequently.  Though there are few enough occurrences that
> > it might just be random chance.
> > 
> > Thoughts?
> 
> I now have 12 of these, and my best guess is that this is happening
> from kvm_guest_cpu_init() when it prints "KVM setup async PF for cpu",
> given that this message is always either the line immediately
> following the splat or the one after that.  So let's see if I can
> connect the dots between kvm_guest_cpu_init() and start_secondary().
> The "? slow_virt_to_phys()" makes sense, as it is invoked by
> kvm_guest_cpu_init() just before the suspect printk().
> 
> kvm_guest_cpu_init() is invoked by kvm_smp_prepare_boot_cpu(),
> kvm_cpu_online(), and kvm_guest_init().  Since the boot CPU came
> up long ago and since rcutorture CPU hotplug should be on the job
> at the time of all of these splats, I am guessing kvm_cpu_online().
> But kvm_cpu_online() is invoked by kvm_guest_init(), so all non-boot-CPU
> roads lead to kvm_guest_init() anyway.
> 
> But kvm_guest_init() is an postcore_initcall() function.
> It is also placed in x86_hyper_kvm.init.guest_late_init().
> The postcore_initcall() looks unconditional, but does not appear in
> dmesg.  Besides which, at the time of the splat, boot is working on
> late_initcall()s rather than postcore_initcalls().  So let's look at
> x86_hyper_kvm.init.guest_late_init(), which is invoked in setup_arch(),
> which is in turn invoked way early in boot, before rcu_init().
> 
> So neither seem to make much sense here.
> 
> On the other hand, rcutorture's exercising of CPU hotplug before init
> has been spawned might not make the most sense, either.  So I will queue
> a patch that makes rcutorture hold off on the hotplug until boot is a
> bit further along.
> 
> And then hammer this a bit over the weekend, this time with Peter's
> alleged fix.  ;-)

And it survived!  ;-)

Peter, could I please have your Signed-off-by?  Or take my Tested-by if
you would prefer to send it up some other way.

							Thanx, Paul
