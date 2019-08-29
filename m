Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC5EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D892422CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wQAjOzxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfH2U4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:56:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40623 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfH2U4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:56:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so2899071pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VpoCOiTqt2OXtuTEcfdRivemuSYVHt20AJpr4bHjRMs=;
        b=wQAjOzxG38j3KShRalpKFUSlN2Pd78hXVqN+9h+m2yA6pPnRI46QIrqs8J0gjfS+Nr
         W4i9JkH1kpAHAyb9gRQLmiXsdvrmmKmr9jGVak0Ba8JSGCk1WU1Xo1ODb+xrvxP5jnNh
         KZVLf/gKNC0uoHJU1ZPxRMbddjjBqAzeD3EtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VpoCOiTqt2OXtuTEcfdRivemuSYVHt20AJpr4bHjRMs=;
        b=qu6QehNGsTlcBeaUaOli4Ah/PK8WEjEakokZmMwF8sXpiFvzIuM2PVhrYj26biIVPq
         gdlbc4HO8h7N9ohcFSnIwlGqUP1YGsV5hi8ZZATUwVSE4k3E3IWvs0VYIGe6hxUgEnn8
         cQiy00KQ4v5L4SHzp5FpJXD/Y+JlX4zFXdxfjOfiTByuDP2kUXT0skt6twnsXO7w5Oco
         LdDsK8W1f9tHlK4Nl75jTJV3gK6QTPoJb4XpvghgcNLrZ9qvE+vGGEKI2K7yhLPVfWRD
         HbtwhhF9BwbMF6avhckzp8Vmt5fKSc/XvEwdgh5jjk9LFotSoVdoD+FLUsKygOxvRU9+
         LzQw==
X-Gm-Message-State: APjAAAWra663AmKQb61aDBttx+O+xFDZRX5hjxQ8YRJqIra4iKY3Aa6m
        4NZQOE824foKw6DWaVuYm+ALLQ==
X-Google-Smtp-Source: APXvYqztHwoxkUqyVXeIXD9BZ7I5PAuVTbqWub9Vj1FWPwK1+v8pWWCY+5HJwBK5XS9ln01APQCHPQ==
X-Received: by 2002:a17:90b:907:: with SMTP id bo7mr12095330pjb.107.1567112199751;
        Thu, 29 Aug 2019 13:56:39 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y13sm3901434pfm.164.2019.08.29.13.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 13:56:38 -0700 (PDT)
Date:   Thu, 29 Aug 2019 16:56:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/5] rcu/rcuperf: Add kfree_rcu() performance Tests
Message-ID: <20190829205637.GA162830@google.com>
References: <5d657e33.1c69fb81.54250.01dd@mx.google.com>
 <20190828211226.GW26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828211226.GW26530@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 02:12:26PM -0700, Paul E. McKenney wrote:
> On Tue, Aug 27, 2019 at 03:01:55PM -0400, Joel Fernandes (Google) wrote:
> > This test runs kfree_rcu() in a loop to measure performance of the new
> > kfree_rcu() batching functionality.
> > 
> > The following table shows results when booting with arguments:
> > rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_rcu_test=1
> > 
> > In addition, rcuperf.kfree_no_batch is used to toggle the batching of
> > kfree_rcu()s for a test run.
> > 
> > patch applied		GPs	time (seconds)
> >  yes			1732	14.5
> >  no			9133 	11.5
> 
> This is really "rcuperf.kfree_no_batch" rather than "patch applied", right?
> (Yes, we did discuss this last time around, but this table combined with
> the prior paragraph is still ambiguous.)  Please make it unambiguous.
> One way to do that is as follows:
> 
> ------------------------------------------------------------------------
> 
> The following table shows results when booting with arguments:
> rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_rcu_test=1  rcuperf.kfree_no_batch=X
> 
> rcuperf.kfree_no_batch=X    # Grace Periods	Test Duration (s)
>  X=1 (old behavior)              9133                 11.5
>  X=0 (new behavior)              1732                 14.5

Yes you are right, will fix. The reason I changed it to 'patch applied' is
because the last patch in the series removes kfree_no_batch. Will fix!
thanks!
 
> > On a 16 CPU system with the above boot parameters, we see that the total
> > number of grace periods that elapse during the test drops from 9133 when
> > not batching to 1732 when batching (a 5X improvement). The kfree_rcu()
> > flood itself slows down a bit when batching, though, as shown.
> 
> This last sentence would be more clear as something like: "However,
> use of batching increases the duration of the kfree_rcu()-flood test."
> 
> > Note that the active memory consumption during the kfree_rcu() flood
> > does increase to around 200-250MB due to the batching (from around 50MB
> > without batching). However, this memory consumption is relatively
> > constant. In other words, the system is able to keep up with the
> > kfree_rcu() load. The memory consumption comes down considerably if
> > KFREE_DRAIN_JIFFIES is increased from HZ/50 to HZ/80.
> 
> That would be a decrease rather than an increase in KFREE_DRAIN_JIFFIES,
> correct?
> 
> This would also be a good place to mention that a later patch will
> decrease consumption, but that is strictly optional.  However, you did
> introduce the topic of changing KFREE_DRAIN_JIFFIES, so if a later patch
> changes this value, this would be an excellent place to mention this.

Fixed.

[snip]
> > +/*
> > + * kfree_rcu() performance tests: Start a kfree_rcu() loop on all CPUs for number
> > + * of iterations and measure total time and number of GP for all iterations to complete.
> > + */
> > +
> > +torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
> > +torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
> > +torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> > +torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu().");
> > +
> > +static struct task_struct **kfree_reader_tasks;
> > +static int kfree_nrealthreads;
> > +static atomic_t n_kfree_perf_thread_started;
> > +static atomic_t n_kfree_perf_thread_ended;
> > +
> > +struct kfree_obj {
> > +	char kfree_obj[8];
> > +	struct rcu_head rh;
> > +};
> > +
> > +static int
> > +kfree_perf_thread(void *arg)
> > +{
> > +	int i, loop = 0;
> > +	long me = (long)arg;
> > +	struct kfree_obj *alloc_ptr;
> > +	u64 start_time, end_time;
> > +
> > +	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> > +	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> > +	set_user_nice(current, MAX_NICE);
> > +
> > +	start_time = ktime_get_mono_fast_ns();
> > +
> > +	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
> > +		if (gp_exp)
> > +			b_rcu_gp_test_started = cur_ops->exp_completed() / 2;
> 
> At some point, it would be good to use the new grace-period
> sequence-counter functions (rcuperf_seq_diff(), for example) instead of
> the open-coded division by 2.  I freely admit that you are just copying
> my obsolete hack in this case, so not needed in this patch.

But I am using rcu_seq_diff() below in the pr_alert().

Anyway, I agree this can be a follow-on since this pattern is borrowed from
another part of rcuperf. However, I am also confused about the pattern
itself.

If I understand, you are doing the "/ 2" because expedited_sequence
progresses by 2 for every expedited batch.

But does rcu_seq_diff() really work on these expedited GP numbers, and will
it be immune to changes in RCU_SEQ_STATE_MASK? Sorry for the silly questions,
but admittedly I have not looked too much yet into expedited RCU so I could
be missing the point.

> > +		else
> > +			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
> > +
> > +		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
> > +		       (unsigned long long)(end_time - start_time), kfree_loops,
> > +		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
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
> 
> These last four lines should be combined with those of
> rcu_perf_shutdown().  Actually, you could fold the two functions together
> with only a pair of arguments and two one-line wrapper functions, which
> would be even better.

But the cleanup() function is different in the 2 cases and will have to be
passed in as a function pointer. I believe we discussed this last review as
well.

thanks,

 - Joel

