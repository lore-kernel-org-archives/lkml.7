Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC257C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992420716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Q7Of3Qtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLSR65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:58:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42790 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLSR64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:58:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so3681461pfz.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GR+2AIpEIH8QFbHQE5Zox7wP3+Qqg8rCZTNs6v4GEPU=;
        b=Q7Of3QtbXz5uyf9+3tuix8v66hjahjSvFZObTzCvJeODsq9ZfSFZ68I3pkkyJGDpTA
         9tvSxtsLZpdNrAT3JXMjz3eUr5AIsQLMsP8eQjf1oXjG1ekXv5HU/4s9JkG0Iwj+0hmZ
         ljaEbpamyuKIknLejPPtVC0Bvm5FjIvw4bBcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GR+2AIpEIH8QFbHQE5Zox7wP3+Qqg8rCZTNs6v4GEPU=;
        b=AG66fdKBtUos59JWoXoq0C2CXxkZNOFfVQQN//Pkk+LL00LcxD+xh2KveuRCAdcYzo
         PEREsIP5r35hYEgcKzgdlvK3nYbk34T78FZufOe9fk3M1mmBNTXcPtQX47sl2CX6Ewoc
         QfcRez9EYzCEh5INbtfUvl/Heq46f1WwjEohZH47MxMjofS3PNSlaubeRkfVFOmatJej
         DCBhQ7a85QZSoB1D0jz/o0VodISLitWJW6uNAL1wT3/NsJBZGMDeNBywe/1Pe0brTSpP
         sbuQQARIoaDnqRadHOc11to/NsKT9wfb4luysQw3ctIiFW9p9FIHG7GO/sARmsDusu6u
         TNew==
X-Gm-Message-State: APjAAAVtMvp25yY0ishPiwx/XiL+Odl4Ex/5VpF6V1H1OWz7O7VrE35G
        EpyFzD3CrTWUIFwtuEu9c0Q2qw==
X-Google-Smtp-Source: APXvYqxThzLQHtBNWNL6z+VwDc6LtI57vx2V88hHtFyNTVAaPtjALHRkj5QG4R10o8QQDBEtIw3s9Q==
X-Received: by 2002:aa7:8191:: with SMTP id g17mr11256440pfi.25.1576778335053;
        Thu, 19 Dec 2019 09:58:55 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i9sm9089977pfk.24.2019.12.19.09.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:58:54 -0800 (PST)
Date:   Thu, 19 Dec 2019 12:58:53 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20191219175853.GB135978@google.com>
References: <20191219162242.128282-1-joel@joelfernandes.org>
 <20191219171402.GB2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219171402.GB2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 09:14:02AM -0800, Paul E. McKenney wrote:
> On Thu, Dec 19, 2019 at 11:22:42AM -0500, Joel Fernandes (Google) wrote:
> > During changes to kfree_rcu() code, we often check how much is free
> > memory. Instead of doing so manually, add a measurement in the test
> > itself. We measure 4 times during the test for available memory and
> > compare with the beginning.
> > 
> > A sample run shows something like:
> > 
> > Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Does the following make sense for the commit log?
> 
> ------------------------------------------------------------------------
> 
> During changes to kfree_rcu() code, we often check the amount of free
> memory.  As an alternative to checking this manually, this commit adds a
> measurement in the test itself.  It measures four times during the test
> for available memory, digitally filters these measurements to produce a
> running average with a weight of 0.5, and compares this digitally filtered
> value with the amount of available memory at the beginning of the test.
> 
> Something like the following is printed at the end of the run:

Yes! I'll incorporate this!

> 
> Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB
> 
> ------------------------------------------------------------------------
> 
> And some questions below.  I have queued this for testing and further
> review with the commit log above in the meantime.
> 
> 							Thanx, Paul
> 
> > ---
> > v1->v2 : Minor corrections
> > 
> > Cc: bristot@redhat.com
> > Cc: frextrite@gmail.com
> > Cc: madhuparnabhowmik04@gmail.com
> > Cc: urezki@gmail.com
> > 
> >  kernel/rcu/rcuperf.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > index da94b89cd531..91f0650914cc 100644
> > --- a/kernel/rcu/rcuperf.c
> > +++ b/kernel/rcu/rcuperf.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/types.h>
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> > +#include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/kthread.h>
> >  #include <linux/err.h>
> > @@ -611,6 +612,7 @@ kfree_perf_thread(void *arg)
> >  	long me = (long)arg;
> >  	struct kfree_obj *alloc_ptr;
> >  	u64 start_time, end_time;
> > +	long mem_begin, mem_during = 0;
> >  
> >  	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> >  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> > @@ -626,6 +628,12 @@ kfree_perf_thread(void *arg)
> >  	}
> >  
> >  	do {
> > +		if (!mem_during) {
> > +			mem_during = mem_begin = si_mem_available();
> 
> So we sample at the beginning of the test before we have either allocated
> or freed.  Or did I miss a beginning-of-test allocation somehow?

Yes, this is the assignment at the beginning of test. I did mess something up
though, if all threads don't start at around the same time, and then if the
thread that started late also ends later than everyone else and becomes the
chosen one to do the reporting, then there is a chance that the mem_begin
it prints will be larger considering the threads that started earlier than
the chosen one may have allocated some memory in the meanwhile. I did not
really see this happen in my testing but I'll fix that in the v3!

> 
> > +		} else if (loop % (kfree_loops / 4) == 0) {
> > +			mem_during = (mem_during + si_mem_available()) / 2;
> 
> This is the digital-filter step.  The truncating nature of integer
> division could actually get us four samples counting the first one if
> kfree_loops evenly divides by four, or five otherwise, correct?  In the
> latter case, we would have a measurement near the end of the test,
> but not exactly at the end of the test, right?

Yes there is an off-by-one possibility depending on kfree_loops value. I did
not mind that too much because I was looking for an approximate measurement
which would be better than my manual calculation of memory footprint anyway.
And I did not see how the off-by-one could affect the results.

> And I have to ask, having studied control systems back in the day...
> 
> Why digitally filter by 0.5 as opposed to any other choice?  For
> example, you could weight recent history more heavily:
> 
> 			mem_during = (mem_during + 3 * si_mem_available()) / 4;
> 
> Or vice versa:
> 
> 			mem_during = (3 * mem_during + si_mem_available()) / 4;
> 
> So why the specific choice of 0.5?

There wasn't a particular reason and I agree your weighted approach is better
and absorbs any quick fluctuations in the signal better.

> 
> Oh, and integer overflow is a problem on 32-bit platforms with more
> than 2GB of memory, for example x86 or ARM physical-address-extension
> (PAE) systems.  I therefore changed the declarations to "long long"
> (and adjusted the format accordingly), but please let me know if I am
> missing some other effect that prevents overflow.

Yes you're right. Thanks for fixing that. I'll fold that into my v3.

> This does not address the possible problem of 64-bit systems that really
> have 64 bits worth of physical memory, but I am happy to leave that one
> for the time being, to be fixed if and when.  ;-)
> Adjusted patch shown below.  Please let me know if I have messed anything
> up, and if there is nothing obviously wrong, please give it a good testing.

Will do!

thanks,

 - Joel

> 
> > +		}
> > +
> >  		for (i = 0; i < kfree_alloc_num; i++) {
> >  			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> >  			if (!alloc_ptr)
> > @@ -645,9 +653,11 @@ kfree_perf_thread(void *arg)
> >  		else
> >  			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
> >  
> > -		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
> > +		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %ldMB\n",
> >  		       (unsigned long long)(end_time - start_time), kfree_loops,
> > -		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
> > +		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
> > +		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
> > +
> >  		if (shutdown) {
> >  			smp_mb(); /* Assign before wake. */
> >  			wake_up(&shutdown_wq);
> > -- 
> > 2.24.1.735.g03f4e72817-goog
> 
> ------------------------------------------------------------------------
> 
> commit 8bf389d441538030d07a9a0f9e38ec0843f7a83e
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Thu Dec 19 11:22:42 2019 -0500
> 
>     rcuperf: Measure memory footprint during kfree_rcu() test
>     
>     During changes to kfree_rcu() code, we often check the amount of free
>     memory.  As an alternative to checking this manually, this commit adds a
>     measurement in the test itself.  It measures four times during the test
>     for available memory, digitally filters these measurements to produce a
>     running average with a weight of 0.5, and compares this digitally filtered
>     value with the amount of available memory at the beginning of the test.
>     
>     Something like the following is printed at the end of the run:
>     
>     Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB
>     
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index da94b89..a4a8d09 100644
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
> @@ -611,6 +612,7 @@ kfree_perf_thread(void *arg)
>  	long me = (long)arg;
>  	struct kfree_obj *alloc_ptr;
>  	u64 start_time, end_time;
> +	long long mem_begin, mem_during = 0;
>  
>  	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
>  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> @@ -626,6 +628,12 @@ kfree_perf_thread(void *arg)
>  	}
>  
>  	do {
> +		if (!mem_during) {
> +			mem_during = mem_begin = si_mem_available();
> +		} else if (loop % (kfree_loops / 4) == 0) {
> +			mem_during = (mem_during + si_mem_available()) / 2;
> +		}
> +
>  		for (i = 0; i < kfree_alloc_num; i++) {
>  			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
>  			if (!alloc_ptr)
> @@ -645,9 +653,11 @@ kfree_perf_thread(void *arg)
>  		else
>  			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
>  
> -		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
> +		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
>  		       (unsigned long long)(end_time - start_time), kfree_loops,
> -		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
> +		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
> +		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
> +
>  		if (shutdown) {
>  			smp_mb(); /* Assign before wake. */
>  			wake_up(&shutdown_wq);
