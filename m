Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EAC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE38E2464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rARhb1mA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfLEKcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:32:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfLEKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f76/byIM4/nNtclvZu2E9nyNQtNNUooYPwrvqXam70M=; b=rARhb1mAQXI1OuiKTzUopxiHQ
        8nFGlzkBhhfoz5f1cf6ZbJqexWVk20JN8YhLmTrDkcjCYIi30NOPJTIntVvZN8uRYsYL7swsBudfL
        I1VW0/AYA8DHoHG2uTkIFOyWo1nvhf+Eb8I0ccyGeT/mVrn418ylckBJenP2/SbW4+yF3prVrCOBF
        sXhFHBfFbCT1NdYRgJEYGlM9Nr0DnVaysz3wvZ9m54u+7SFwP3deaK5WD5DLeMVfpQh6KvCnfjC/Z
        Zg71MnD0BrUYmk+/LJ2Pg/W4Y6WaG+c0g/A5S5Xn+wqstwxcqqxKwYeZ33xcwfbNyC1eU4WjgHTfG
        TRaYfha6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icoQh-0005Y9-9h; Thu, 05 Dec 2019 10:32:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF0CC3011E0;
        Thu,  5 Dec 2019 11:30:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 233572006F795; Thu,  5 Dec 2019 11:32:13 +0100 (CET)
Date:   Thu, 5 Dec 2019 11:32:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191205103213.GB2871@hirez.programming.kicks-ass.net>
References: <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
 <20191204201150.GA14040@paulmck-ThinkPad-P72>
 <20191205102928.GG2810@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205102928.GG2810@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 11:29:28AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 04, 2019 at 12:11:50PM -0800, Paul E. McKenney wrote:
> 
> > And the good news is that I didn't see the workqueue splat, though my
> > best guess is that I had about a 13% chance of not seeing it due to
> > random chance (and I am currently trying an idea that I hope will make
> > it more probable).  But I did get a couple of new complaints about RCU
> > being used illegally from an offline CPU.  Splats below.
> 
> Shiny!
> 
> > Your patch did rearrange the CPU-online sequence, so let's see if I
> > can piece things together...
> > 
> > RCU considers a CPU to be online at rcu_cpu_starting() time.  This is
> > called from notify_cpu_starting(), which is called from the arch-specific
> > CPU-bringup code.  Any RCU readers before rcu_cpu_starting() will trigger
> > the warning I am seeing.
> 
> Right.
> 
> > The original location of the stop_machine_unpark() was in
> > bringup_wait_for_ap(), which is called from bringup_cpu(), which is in
> > the CPUHP_BRINGUP_CPU entry of cpuhp_hp_states[].  Which, if I am not
> > too confused, is invoked by some CPU other than the to-be-incoming CPU.
> 
> Correct.
> 
> > The new location of the stop_machine_unpark() is in cpuhp_online_idle(),
> > which is called from cpu_startup_entry(), which is invoked from
> > the arch-specific bringup code that runs on the incoming CPU.
> 
> The new place is the final piece of bringup, it is right before where
> the freshly woken CPU will drop into the idle loop and start scheduling
> (for the first time).
> 
> > Which
> > is the same code that invokes notify_cpu_starting(), so we need
> > notify_cpu_starting() to be invoked before cpu_startup_entry().
> 
> Right, that is right before we run what used to be the CPU_STARTING
> notifiers. This is in fact (on x86) before the CPU is marked
> cpu_online(). It has to be before cpu_startup_entry(), before this is
> ran with IRQs disabled, while cpu_startup_entry() demands IRQs are
> enabled.
> 
> > The order is not immediately obvious on IA64.  But it looks like
> > everything else does it in the required order, so I am a bit confused
> > about this.
> 
> That makes two of us, afaict we have RCU up and running when we get to
> the idle loop.

Or did we need rcutree_online_cpu() to have ran? Because that is ran
much later than this...
