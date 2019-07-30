Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24596C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8772206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564504996;
	bh=mVaQfCUduyzwcuSDuf/0pHJrjsbowJ87qw05RgYyXQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TRzqXcKodM5iR6P4G3pmuKaJQHc5nk/Mv1o4Sks/jmbSBu5UzTAsqA8XmmZ6x6nLL
	 ZMY+LwmY6k9vFXYT1XccHAtOZ6bR7pSQwzWgXTwc0StnV1qex066jQvyGM6g5GdXJE
	 e0uiLY882L70cRknvHoEwF4ANUaRcbWApnTQZxqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfG3QnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfG3QnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:43:14 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60E9206A2;
        Tue, 30 Jul 2019 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564504993;
        bh=mVaQfCUduyzwcuSDuf/0pHJrjsbowJ87qw05RgYyXQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1oQy6DccGyY7TC6pRc2eJsnPfi+bdsqdoeupCCLYHUfH8LL82VRB2LxDHL0KRFo8
         kUUS2tNQUSUFwzTP/ymVG0SoLI4y6HkFQDtNN6G7Ob10gxvkGlbdFziqGMIbeNJauF
         ciK3a8J5Mi8FUhh+W+FEiwGOy0RWKe8hTJAs8waY=
Date:   Tue, 30 Jul 2019 18:43:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        peterz@infradead.org, paulmckrcu@gmail.com
Subject: Re: How to turn scheduler tick on for current nohz_full CPU?
Message-ID: <20190730164309.GA962@lenoir>
References: <20190724115331.GA29059@linux.ibm.com>
 <20190724132257.GA1029@lenoir>
 <20190724135219.GY14271@linux.ibm.com>
 <20190724143012.GB1029@lenoir>
 <20190725011243.GZ14271@linux.ibm.com>
 <20190729223238.GF14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729223238.GF14271@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 03:32:38PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 24, 2019 at 06:12:43PM -0700, Paul E. McKenney wrote:
> 
> The patch below (which includes your patch) does help considerably.
> However, it does have some shortcomings:
> 
> 1.	Adds an atomic operation (albeit a cache-local one) to
> 	the scheduler fastpath.  One approach would be to have
> 	a way of testing this bit and clearing it only if set.
> 
> 	Another approach would be to instead clear it on the
> 	transition to nohz_full userspace or to idle.

Well, the latter would be costly as it is going to restart the tick on every
user -> kernel transitions.

> 
> 2.	There are a lot of other places in the kernel that are in
> 	need of this bit being set.  I am therefore considering making
> 	multi_cpu_stop() or its callers set this bit on all CPUs upon
> 	entry and clear it upon exit.  While in this state, it is
> 	likely necessary to disable clearing this bit.  Or it would
> 	be necessary to make multi_cpu_stop() repeat clearing the bit
> 	every so often.
> 
> 	As it stands, I have CPU hotplug removal operations taking
> 	more than 400 seconds.
> 
> 3.	It was tempting to ask for this bit to be tracked on a per-task
> 	basis, but from what I can see that adds at least as much
> 	complexity as it removes.

Yeah I forgot to answer, you can use tick_dep_set_task() for that.

> 
> Thoughts?
> 
> 							Thanx, Paul
> 
> PS.  Outage on @linux.ibm.com, hence the CC of my gmail address.
> 
> ------------------------------------------------------------------------
> 
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 196a0a7bfc4f..0dea6fb33a11 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -108,7 +108,8 @@ enum tick_dep_bits {
>  	TICK_DEP_BIT_POSIX_TIMER	= 0,
>  	TICK_DEP_BIT_PERF_EVENTS	= 1,
>  	TICK_DEP_BIT_SCHED		= 2,
> -	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
> +	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
> +	TICK_DEP_BIT_RCU		= 4
>  };
>  
>  #define TICK_DEP_MASK_NONE		0
> @@ -116,6 +117,7 @@ enum tick_dep_bits {
>  #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
>  #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
>  #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
> +#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
>  
>  #ifdef CONFIG_NO_HZ_COMMON
>  extern bool tick_nohz_enabled;
> @@ -258,6 +260,9 @@ static inline bool tick_nohz_full_enabled(void) { return false; }
>  static inline bool tick_nohz_full_cpu(int cpu) { return false; }
>  static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
>  
> +static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
> +static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }

And I gave you the wrong APIs. Please consider_using tick_dep_set_cpu()
and tick_dep_clear_cpu() that first check if the CPU uses nohz_full.

Those should have the !CONFIG_NO_HZ_FULL stub implemented as well.

Thanks.
