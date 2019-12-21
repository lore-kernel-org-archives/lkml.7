Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CFC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 00:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E0C20866
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 00:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576886852;
	bh=DUTd9ZXnPeBkStx+DZbftMxjTkhEGCBmWttg8e+wCg0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=kNj1BwbT9CXtO8S6qTv+DtNnH829+q7D3va0pTq8D6iUsDjIDEgZ+hlZ0EUO7wjGI
	 q4VDEZ0uBBnmP5Pz67j8IxI+FvB0NoA1XjoeUdsts0PnK7bVrDV25551YbnuV7S/OJ
	 1OpvnK1b0HgtZRmps0LT3o1OI4ClktfJbivVwk7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfLUAHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 19:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfLUAHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 19:07:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74FF62082E;
        Sat, 21 Dec 2019 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576886849;
        bh=DUTd9ZXnPeBkStx+DZbftMxjTkhEGCBmWttg8e+wCg0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xae+YooODExpWO8UxwBTaVUN/Wv3bcLeOACU9OUer/dz6xshNqVd66g93jNUpKrLb
         fHJ2p6HllOGr5Du6b024m2A95AlzJAa+3dwvvtIJR6Kl6qQcgKguCiwyxZ5IMBSK6W
         PL2vvHtBisGw1lDsotEd70sY4gqWOAgdRHUrYeYs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4AE663522744; Fri, 20 Dec 2019 16:07:29 -0800 (PST)
Date:   Fri, 20 Dec 2019 16:07:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20191221000729.GH2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191219211349.235877-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219211349.235877-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 04:13:49PM -0500, Joel Fernandes (Google) wrote:
> During changes to kfree_rcu() code, we often check the amount of free
> memory.  As an alternative to checking this manually, this commit adds a
> measurement in the test itself.  It measures four times during the test
> for available memory, digitally filters these measurements to produce a
> running average with a weight of 0.5, and compares this digitally
> filtered value with the amount of available memory at the beginning of
> the test.
> 
> We apply the digital filter only once we are more than 25% into the
> test. At the 25% mark, we just read available memory and don't apply any
> filtering. This prevents the first sample from skewing the results
> as we would not consider memory readings that were before memory was
> allocated.
> 
> A sample run shows something like:
> 
> Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Much better!  A few comments below.

							Thanx, Paul

> ---
> v1->v2: Minor corrections
> v1->v3: Use long long to prevent 32-bit system's overflow
> 	Handle case where some threads start later than others.
> 	Start measuring only once 25% into the test. Slightly more accurate.
> 
> Cc: bristot@redhat.com
> Cc: frextrite@gmail.com
> Cc: madhuparnabhowmik04@gmail.com
> Cc: urezki@gmail.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
>  kernel/rcu/rcuperf.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index da94b89cd531..67e0f804ea97 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -12,6 +12,7 @@
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/kthread.h>
>  #include <linux/err.h>
> @@ -604,6 +605,8 @@ struct kfree_obj {
>  	struct rcu_head rh;
>  };
>  
> +long long mem_begin;
> +
>  static int
>  kfree_perf_thread(void *arg)
>  {
> @@ -611,6 +614,7 @@ kfree_perf_thread(void *arg)
>  	long me = (long)arg;
>  	struct kfree_obj *alloc_ptr;
>  	u64 start_time, end_time;
> +	long long mem_during = si_mem_available();

You initialize here, which makes quite a bit of sense...

>  	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
>  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> @@ -626,6 +630,15 @@ kfree_perf_thread(void *arg)
>  	}
>  
>  	do {
> +		// Moving average of memory availability measurements.
> +		// Start measuring only from when we are at least 25% into the test.
> +		if (loop && kfree_loops > 3 && (loop % (kfree_loops / 4) == 0)) {
> +			if (loop == (kfree_loops / 4))
> +				mem_during = si_mem_available();

But then you reinitialize here.  Perhaps to avoid the compiler being
confused into complaining about uninitialized variables?  (But if so,
please comment it.)

The thing is that by the fourth measurement, the initial influence has
been diluted by a factor of something like 16 or 32, correct?  I don't
believe that your measurements are any more accurate than that, given the
bursty nature of the RCU reclamation process.  So why not just initialize
it and average it at each sample point?

If you want more accuracy, you could increase the number of sample
points, while changing the filter constants to more heavily weight
past measurements.

Actually, I strongly suggest recording frequent raw data, and applying
various filtering techniques offline to see what works best.  I might
be mistaken, but it feels like you are shooting in the dark here.

> +			else
> +				mem_during = (mem_during + si_mem_available()) / 2;
> +		}
> +
>  		for (i = 0; i < kfree_alloc_num; i++) {
>  			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
>  			if (!alloc_ptr)
> @@ -645,9 +658,13 @@ kfree_perf_thread(void *arg)
>  		else
>  			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
>  
> -		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
> +		// The "memory footprint" field represents how much in-flight
> +		// memory is allocated during the test and waiting to be freed.

This added comment is much better, thank you!

> +		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
>  		       (unsigned long long)(end_time - start_time), kfree_loops,
> -		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
> +		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
> +		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
> +
>  		if (shutdown) {
>  			smp_mb(); /* Assign before wake. */
>  			wake_up(&shutdown_wq);
> @@ -719,6 +736,8 @@ kfree_perf_init(void)
>  		goto unwind;
>  	}
>  
> +	mem_begin = si_mem_available();
> +
>  	for (i = 0; i < kfree_nrealthreads; i++) {
>  		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
>  						  kfree_reader_tasks[i]);
> -- 
> 2.24.1.735.g03f4e72817-goog
