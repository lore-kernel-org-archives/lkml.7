Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647A1C32751
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 02:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20588208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 02:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="go8bkkMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfHKCB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 22:01:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41532 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfHKCB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 22:01:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so37403479pgg.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 19:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AeFtgYQQ60iUyXKAlfN71O4/ntVJzJDm/WOo9iKCvJk=;
        b=go8bkkMfoX3wpqMblSJ0Gbz1sxvwuCUio1BAuBcVpKbyNjaksnBCiPRijm27BFVTXX
         H7Iq8srLU+7Jw3j5DVLANRzlrC6hfWFGWk/y6EPEPoQyWXz/Wlw216Cs5rQC1mUc6cY0
         /fEL+kfrS5p92WaIZpA6onS5OvsitB8GaeDas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AeFtgYQQ60iUyXKAlfN71O4/ntVJzJDm/WOo9iKCvJk=;
        b=BAjW1goiM4GJ/J22rcx4z3FLKC/BpzcP+/pO6N4Xz8OHE7Mw8vzHphQBhtoxvARtks
         81giKN/JTXFLhlXrAow8Gkali3rFWHp4imRURa4yCytvD79Q4qHrwahNv12BZKtScbyP
         J7bqTYULl7dPAQ3OoZ6aQGza2WEzKr/Uok1tKrhZ75t3mArPmOYgsJl9dVaXbcZgmc/Y
         mAVTP2TIeQDeT2JerwZTd9B/pwPjaN/UcF7dBATz2ah0MUkmrPWfqBSGn6vN9MRZ06zC
         pnv2eZvCSLbMGRSkK4hi7udpMq/P9y8t2xPSsIMHlD8GITCGNQ+hsAzcUFtHMXH6VbuS
         nhsg==
X-Gm-Message-State: APjAAAWMm6O3L9llh5LBQDoQoF79n4L65qVrWSobWoDArixgHeBTgrTW
        RklezdOw569rkA0VgIM0xCPnaw==
X-Google-Smtp-Source: APXvYqyACFwVqBVsp+ONZvLP/JTRRTx2xkIMb5JkHRIkh9E0eaORbXs/ShwBQBaJdA0XRS2kmudVlg==
X-Received: by 2002:a17:90a:ad86:: with SMTP id s6mr17262543pjq.42.1565488918001;
        Sat, 10 Aug 2019 19:01:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f205sm250383pfa.161.2019.08.10.19.01.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 19:01:56 -0700 (PDT)
Date:   Sat, 10 Aug 2019 22:01:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com,
        byungchul.park@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 2/2] rcuperf: Add kfree_rcu performance Tests
Message-ID: <20190811020154.GA74292@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806212041.118146-2-joel@joelfernandes.org>
 <20190807002915.GV28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807002915.GV28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 05:29:15PM -0700, Paul E. McKenney wrote:
> On Tue, Aug 06, 2019 at 05:20:41PM -0400, Joel Fernandes (Google) wrote:
> > This test runs kfree_rcu in a loop to measure performance of the new
> > kfree_rcu, with and without patch.
> > 
> > To see improvement, run with boot parameters:
> > rcuperf.kfree_loops=2000 rcuperf.kfree_alloc_num=100 rcuperf.perf_type=kfree
> > 
> > Without patch, test runs in 6.9 seconds.
> > With patch, test runs in 6.1 seconds (+13% improvement)
> > 
> > If it is desired to run the test but with the traditional (non-batched)
> > kfree_rcu, for example to compare results, then you could pass along the
> > rcuperf.kfree_no_batch=1 boot parameter.
> 
> You lost me on this one.  You ran two runs, with rcuperf.kfree_no_batch=1
> and without?  Or you ran this patch both with and without the earlier
> patch, and could have run with the patch and rcuperf.kfree_no_batch=1?
> 
> If the latter, it would be good to try all three.

Did this in new patch, will post shortly.

[snip]
> > +torture_param(int, kfree_nthreads, -1, "Number of RCU reader threads");
> > +torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done by a thread");
> > +torture_param(int, kfree_alloc_size, 16,  "Size of each allocation");
> 
> Is this used?  How does it relate to KFREE_OBJ_BYTES?

It is not used, I removed it.

> > +torture_param(int, kfree_loops, 10, "Size of each allocation");
> 
> I suspect that this kfree_loops string is out of date.

Updated, thanks.

> > +torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu");
> 
> All of these need to be added to kernel-parameters.txt.  Along with
> any added by the earlier patch, for that matter.

Will do.

> > +static struct task_struct **kfree_reader_tasks;
> > +static int kfree_nrealthreads;
> > +static atomic_t n_kfree_perf_thread_started;
> > +static atomic_t n_kfree_perf_thread_ended;
> > +
> > +#define KFREE_OBJ_BYTES 8
> > +
> > +struct kfree_obj {
> > +	char kfree_obj[KFREE_OBJ_BYTES];
> > +	struct rcu_head rh;
> > +};
> > +
> > +void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
> > +
> > +static int
> > +kfree_perf_thread(void *arg)
> > +{
> > +	int i, l = 0;
> 
> It is really easy to confuse "l" and "1" in some fonts, so please use
> a different name.  (From the "showing my age" department:  On typical
> 1970s typewriters, there was no numeral "1" -- you typed the letter
> "l" instead, thus anticipating at least the first digit of "1337".)

Change l to loops ;). I did see typewriters around in my childhood, I thought
they were pretty odd machines :-D. I am sure my daughter will think the same
about land-line phones :-D

> > +	long me = (long)arg;
> > +	struct kfree_obj **alloc_ptrs;
> > +	u64 start_time, end_time;
> > +
> > +	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> > +	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> > +	set_user_nice(current, MAX_NICE);
> > +	atomic_inc(&n_kfree_perf_thread_started);
> > +
> > +	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
> > +						  GFP_KERNEL);
> > +	if (!alloc_ptrs)
> > +		return -ENOMEM;
> > +
> > +	start_time = ktime_get_mono_fast_ns();
> 
> Don't you want to announce that you started here rather than above in
> order to avoid (admittedly slight) measurement inaccuracies?

Yes, in revised patch I am announcing here.

> > +	do {
> > +		for (i = 0; i < kfree_alloc_num; i++) {
> > +			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> > +			if (!alloc_ptrs[i])
> > +				return -ENOMEM;
> > +		}
> > +
> > +		for (i = 0; i < kfree_alloc_num; i++) {
> > +			if (!kfree_no_batch) {
> > +				kfree_rcu(alloc_ptrs[i], rh);
> > +			} else {
> > +				rcu_callback_t cb;
> > +
> > +				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> > +				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
> > +			}
> > +		}
> > +
> > +		schedule_timeout_uninterruptible(2);
> 
> Why the two-jiffy wait in the middle of a timed test?  Yes, you need
> a cond_resched() and maybe more here, but a two-jiffy wait?  I don't
> see how this has any chance of getting valid measurements.
> 
> What am I missing here?

Replace it with cond_resched() as we discussed.

> > +	} while (!torture_must_stop() && ++l < kfree_loops);
> > +
> > +	kfree(alloc_ptrs);
> > +
> > +	if (atomic_inc_return(&n_kfree_perf_thread_ended) >= kfree_nrealthreads) {
> > +		end_time = ktime_get_mono_fast_ns();
> 
> Don't we want to capture the end time before the kfree()?

Fixed.

> > +		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d\n",
> > +		       (unsigned long long)(end_time - start_time), kfree_loops);
> > +		if (shutdown) {
> > +			smp_mb(); /* Assign before wake. */
> > +			wake_up(&shutdown_wq);
> > +		}
> > +	}
> > +
> > +	torture_kthread_stopping("kfree_perf_thread");
> > +	return 0;
> > +}
> > +
> > +static void
> > +kfree_perf_cleanup(void)
> > +{
> > +	int i;
> > +
> > +	if (torture_cleanup_begin())
> > +		return;
> > +
> > +	if (kfree_reader_tasks) {
> > +		for (i = 0; i < kfree_nrealthreads; i++)
> > +			torture_stop_kthread(kfree_perf_thread,
> > +					     kfree_reader_tasks[i]);
> > +		kfree(kfree_reader_tasks);
> > +	}
> > +
> > +	torture_cleanup_end();
> > +}
> > +
> > +/*
> > + * shutdown kthread.  Just waits to be awakened, then shuts down system.
> > + */
> > +static int
> > +kfree_perf_shutdown(void *arg)
> > +{
> > +	do {
> > +		wait_event(shutdown_wq,
> > +			   atomic_read(&n_kfree_perf_thread_ended) >=
> > +			   kfree_nrealthreads);
> > +	} while (atomic_read(&n_kfree_perf_thread_ended) < kfree_nrealthreads);
> > +
> > +	smp_mb(); /* Wake before output. */
> > +
> > +	kfree_perf_cleanup();
> > +	kernel_power_off();
> > +	return -EINVAL;
> > +}
> 
> Is there some way to avoid (almost) duplicating rcu_perf_shutdown()?

At the moment, I don't see a good way to do this without passing in function
pointers or using macros which I think would look uglier than the above
addition. Sorry.

thanks,

 - Joel

