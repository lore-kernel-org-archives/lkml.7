Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED01C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 03:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F5320716
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 03:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nHid3n2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLUDhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 22:37:17 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50373 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfLUDhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 22:37:17 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so4954900pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 19:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bC53Tdj/5zjf8vYVwoDsYPND1D7l6kC/YqTeCZYRFKg=;
        b=nHid3n2MdE+G2omI6IjxrvkfJvn3lxziq6J7qMfkau3EK2ThPGOSah6/AtBG2AIp8u
         ep75QXrqkWGlQpNJCNoenwHnkAYjrNElJrj67gDBLhlm3OZN7XjO6iDtsGAEbr0rR1+4
         JT614BRN9diYmRL2VEDdRP7FBJpGjLSX1Prgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bC53Tdj/5zjf8vYVwoDsYPND1D7l6kC/YqTeCZYRFKg=;
        b=CLfVhdG5WnAi9looxdq3ZA+LKjfLywOUa0xkA8QUZLNi3z5vGAhaKl/yLaAIr2dSzG
         L8ixN1PweNAM5sQ4UYhg777Vc32VYPHwKNtG55t65SZp6mqY5Pe97BBivx86cjVE9xOR
         4moJVuFsFWhBJCHvlZK0/micqhZkppTSJjTzYnr+Eu4XCo2BsUeE58ylnAGUrZxfKUOn
         L88T3J6+mUvxaGVfq0Hr8JcteXmxm9EdlqxXMCK+EQLVmYNpwxGoRBlRDJUhDr2u77d9
         /flFCH6izi+PJoSTyP2IpqmU0gz9iYeWEjO0Z/ZUUOy2u/FyyR9D6obu5gPHZrEGZcJL
         MLPw==
X-Gm-Message-State: APjAAAWs/7NKQo470lJNe+QNDk0Xg6DOMh4NkUcW291QiuaM/+SOYoN1
        H7De4phRE7YMz6dIeLN4SXXoLQ==
X-Google-Smtp-Source: APXvYqxTjJ0fOwvHPPhViRSqpwoLi1bU+C77TCtWQjhMz7r/m1MeRtF3UpiAs8HWgTUl+d7HHaBbCQ==
X-Received: by 2002:a17:902:bc45:: with SMTP id t5mr18551837plz.163.1576899435987;
        Fri, 20 Dec 2019 19:37:15 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j18sm13110940pgk.1.2019.12.20.19.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 19:37:15 -0800 (PST)
Date:   Fri, 20 Dec 2019 22:37:14 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20191221033714.GB156579@google.com>
References: <20191219211349.235877-1-joel@joelfernandes.org>
 <20191221000729.GH2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221000729.GH2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 04:07:29PM -0800, Paul E. McKenney wrote:
> On Thu, Dec 19, 2019 at 04:13:49PM -0500, Joel Fernandes (Google) wrote:
> > During changes to kfree_rcu() code, we often check the amount of free
> > memory.  As an alternative to checking this manually, this commit adds a
> > measurement in the test itself.  It measures four times during the test
> > for available memory, digitally filters these measurements to produce a
> > running average with a weight of 0.5, and compares this digitally
> > filtered value with the amount of available memory at the beginning of
> > the test.
> > 
> > We apply the digital filter only once we are more than 25% into the
> > test. At the 25% mark, we just read available memory and don't apply any
> > filtering. This prevents the first sample from skewing the results
> > as we would not consider memory readings that were before memory was
> > allocated.
> > 
> > A sample run shows something like:
> > 
> > Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Much better!  A few comments below.
> 
> 							Thanx, Paul
> 
> > ---
> > v1->v2: Minor corrections
> > v1->v3: Use long long to prevent 32-bit system's overflow
> > 	Handle case where some threads start later than others.
> > 	Start measuring only once 25% into the test. Slightly more accurate.
> > 
> > Cc: bristot@redhat.com
> > Cc: frextrite@gmail.com
> > Cc: madhuparnabhowmik04@gmail.com
> > Cc: urezki@gmail.com
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> >  kernel/rcu/rcuperf.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > index da94b89cd531..67e0f804ea97 100644
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
> > @@ -604,6 +605,8 @@ struct kfree_obj {
> >  	struct rcu_head rh;
> >  };
> >  
> > +long long mem_begin;
> > +
> >  static int
> >  kfree_perf_thread(void *arg)
> >  {
> > @@ -611,6 +614,7 @@ kfree_perf_thread(void *arg)
> >  	long me = (long)arg;
> >  	struct kfree_obj *alloc_ptr;
> >  	u64 start_time, end_time;
> > +	long long mem_during = si_mem_available();
> 
> You initialize here, which makes quite a bit of sense...
> 
> >  	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> >  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> > @@ -626,6 +630,15 @@ kfree_perf_thread(void *arg)
> >  	}
> >  
> >  	do {
> > +		// Moving average of memory availability measurements.
> > +		// Start measuring only from when we are at least 25% into the test.
> > +		if (loop && kfree_loops > 3 && (loop % (kfree_loops / 4) == 0)) {
> > +			if (loop == (kfree_loops / 4))
> > +				mem_during = si_mem_available();
> 
> But then you reinitialize here.  Perhaps to avoid the compiler being
> confused into complaining about uninitialized variables?  (But if so,
> please comment it.)

It is reinitialized here like that, because if kfree_loops is < 4, then
mem_during needs to hold some value to avoid the (mem_begin - mem_during) to
falsely appear quite large. That's why I initialized it in the beginning. If
kfree_loops is >= 4, then yes it will be initialized twice but that's Ok.

I can add a comment to the earlier initialization if you like.

If that is the only comment on the patch left, I appreciate if you can
change:
 + long long mem_during = si_mem_available();
 to 
 + long long mem_during = si_mem_available(); // for kfree_loops < 4 case

> The thing is that by the fourth measurement, the initial influence has
> been diluted by a factor of something like 16 or 32, correct?  I don't
> believe that your measurements are any more accurate than that, given the
> bursty nature of the RCU reclamation process.  So why not just initialize
> it and average it at each sample point?

Yes but diluting 200MB of delta by 16 is still high and causes a skew.

> 
> If you want more accuracy, you could increase the number of sample
> points, while changing the filter constants to more heavily weight
> past measurements.

At the moment the results are showing me consistent numbers in my tests and
I'm quite happy with them. And it is better to have some measurement, than
not having anything.

We can certainly refine it further but at this time I am thinking of spending
my time reviewing Lai's patches and learning some other RCU things I need to
catch up on. If you hate this patch too much, we can also defer this patch
review for a bit and I can carry it in my tree for now as it is only a patch
to test code. But honestly, in its current form I am sort of happy with it.

> Actually, I strongly suggest recording frequent raw data, and applying
> various filtering techniques offline to see what works best.  I might
> be mistaken, but it feels like you are shooting in the dark here.

The number I am aiming for is close to a constant. For example in a run, I
see the available memory goes down from 460000 pages to ~ 400000 pages. That
is around ~240MB of memory. This deviates by +- 20MB. I would rather take
many samples than just 1 sample and apply some form of reduction to combine
them into a single sample.  My current filtering works well in my testing and
I could do more complex things, but then again at the moment I am happy with
the test. I am open to any other filtering related suggestions though!

Sorry if I missed something!

thanks,

 - Joel


> > +			else
> > +				mem_during = (mem_during + si_mem_available()) / 2;
> > +		}
> > +
> >  		for (i = 0; i < kfree_alloc_num; i++) {
> >  			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> >  			if (!alloc_ptr)
> > @@ -645,9 +658,13 @@ kfree_perf_thread(void *arg)
> >  		else
> >  			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
> >  
> > -		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
> > +		// The "memory footprint" field represents how much in-flight
> > +		// memory is allocated during the test and waiting to be freed.
> 
> This added comment is much better, thank you!
> 
> > +		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
> >  		       (unsigned long long)(end_time - start_time), kfree_loops,
> > -		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
> > +		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
> > +		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
> > +
> >  		if (shutdown) {
> >  			smp_mb(); /* Assign before wake. */
> >  			wake_up(&shutdown_wq);
> > @@ -719,6 +736,8 @@ kfree_perf_init(void)
> >  		goto unwind;
> >  	}
> >  
> > +	mem_begin = si_mem_available();
> > +
> >  	for (i = 0; i < kfree_nrealthreads; i++) {
> >  		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
> >  						  kfree_reader_tasks[i]);
> > -- 
> > 2.24.1.735.g03f4e72817-goog
