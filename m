Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391AFC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039742464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Aepzbqy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfLEK3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:29:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfLEK3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pf3VRmP8HmHiyiOcV+xYnOtrZTggWIGVma7A8JY6Tbc=; b=Aepzbqy6h4NAA4gWqcMM8WUWT
        dbAK+bwyiwqtDY4+58NteAYnzBPqUPn3Dmtjk4bffOt+0/mQI1/9EFSIZDaoT1Zhy1IjCBEOalDoE
        ui+oEGIjYETpUbbB/qVU4WpkbCEWys9PoT2WAes9SqLybHOMGNXLWXzk16Z3wwD0P+G0002bHVNb0
        dLhvbk6JgmZ3XS4G0G44jBNTBn9O5PUyrUnpGciaCwARlxi0YOk2w4SxVUMJFmf2ATJFm9dwloR1y
        wSnVsKBO2WLOrYx2Y3JedCNjIxFGc5j3tcwS9NQU9bGApBlm7PGlyn8es6BWEXRGaU5XxYMuWK9Jj
        qK/9PvU6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icoO3-0003DQ-EV; Thu, 05 Dec 2019 10:29:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EAFC33011E0;
        Thu,  5 Dec 2019 11:28:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F0752B26E208; Thu,  5 Dec 2019 11:29:28 +0100 (CET)
Date:   Thu, 5 Dec 2019 11:29:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191205102928.GG2810@hirez.programming.kicks-ass.net>
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
 <20191204201150.GA14040@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204201150.GA14040@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 12:11:50PM -0800, Paul E. McKenney wrote:

> And the good news is that I didn't see the workqueue splat, though my
> best guess is that I had about a 13% chance of not seeing it due to
> random chance (and I am currently trying an idea that I hope will make
> it more probable).  But I did get a couple of new complaints about RCU
> being used illegally from an offline CPU.  Splats below.

Shiny!

> Your patch did rearrange the CPU-online sequence, so let's see if I
> can piece things together...
> 
> RCU considers a CPU to be online at rcu_cpu_starting() time.  This is
> called from notify_cpu_starting(), which is called from the arch-specific
> CPU-bringup code.  Any RCU readers before rcu_cpu_starting() will trigger
> the warning I am seeing.

Right.

> The original location of the stop_machine_unpark() was in
> bringup_wait_for_ap(), which is called from bringup_cpu(), which is in
> the CPUHP_BRINGUP_CPU entry of cpuhp_hp_states[].  Which, if I am not
> too confused, is invoked by some CPU other than the to-be-incoming CPU.

Correct.

> The new location of the stop_machine_unpark() is in cpuhp_online_idle(),
> which is called from cpu_startup_entry(), which is invoked from
> the arch-specific bringup code that runs on the incoming CPU.

The new place is the final piece of bringup, it is right before where
the freshly woken CPU will drop into the idle loop and start scheduling
(for the first time).

> Which
> is the same code that invokes notify_cpu_starting(), so we need
> notify_cpu_starting() to be invoked before cpu_startup_entry().

Right, that is right before we run what used to be the CPU_STARTING
notifiers. This is in fact (on x86) before the CPU is marked
cpu_online(). It has to be before cpu_startup_entry(), before this is
ran with IRQs disabled, while cpu_startup_entry() demands IRQs are
enabled.

> The order is not immediately obvious on IA64.  But it looks like
> everything else does it in the required order, so I am a bit confused
> about this.

That makes two of us, afaict we have RCU up and running when we get to
the idle loop.
