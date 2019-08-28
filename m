Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054FCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17DA22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567026783;
	bh=b5/nF4ROr5NuNS1oRAv98e6jKcG4dDdwraHjs0waTxY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=F1DeCLfpgkEft2J6EsTHdnZRY731WA/2ILHhZeBj73wPPFtxiCqE55kiumcO6yq5Y
	 w3NDu9wpgGieQXP1udA0iGMVwPA9Jb6toG+BCxnrGRbU9LOk9rQcFAxi2L04LITgAj
	 s+sDCpHdqblFUMN8cxxEwo9osF5JmLVJwNiNcgm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfH1VND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:13:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfH1VNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:13:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SL7EaF091641;
        Wed, 28 Aug 2019 17:12:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unxpxn484-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:12:26 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SL9TEf098144;
        Wed, 28 Aug 2019 17:12:26 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unxpxn47f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:12:26 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SL4uxC027019;
        Wed, 28 Aug 2019 21:12:24 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 2ujvv7896g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 21:12:24 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SLCOqO51052882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 21:12:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78B04B2066;
        Wed, 28 Aug 2019 21:12:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4775DB2065;
        Wed, 28 Aug 2019 21:12:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 21:12:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1656116C1700; Wed, 28 Aug 2019 14:12:26 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:12:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH 1/5] rcu/rcuperf: Add kfree_rcu() performance Tests
Message-ID: <20190828211226.GW26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d657e33.1c69fb81.54250.01dd@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d657e33.1c69fb81.54250.01dd@mx.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:01:55PM -0400, Joel Fernandes (Google) wrote:
> This test runs kfree_rcu() in a loop to measure performance of the new
> kfree_rcu() batching functionality.
> 
> The following table shows results when booting with arguments:
> rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_rcu_test=1
> 
> In addition, rcuperf.kfree_no_batch is used to toggle the batching of
> kfree_rcu()s for a test run.
> 
> patch applied		GPs	time (seconds)
>  yes			1732	14.5
>  no			9133 	11.5

This is really "rcuperf.kfree_no_batch" rather than "patch applied", right?
(Yes, we did discuss this last time around, but this table combined with
the prior paragraph is still ambiguous.)  Please make it unambiguous.
One way to do that is as follows:

------------------------------------------------------------------------

The following table shows results when booting with arguments:
rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_rcu_test=1  rcuperf.kfree_no_batch=X

rcuperf.kfree_no_batch=X    # Grace Periods	Test Duration (s)
 X=1 (old behavior)              9133                 11.5
 X=0 (new behavior)              1732                 14.5

------------------------------------------------------------------------

> On a 16 CPU system with the above boot parameters, we see that the total
> number of grace periods that elapse during the test drops from 9133 when
> not batching to 1732 when batching (a 5X improvement). The kfree_rcu()
> flood itself slows down a bit when batching, though, as shown.

This last sentence would be more clear as something like: "However,
use of batching increases the duration of the kfree_rcu()-flood test."

> Note that the active memory consumption during the kfree_rcu() flood
> does increase to around 200-250MB due to the batching (from around 50MB
> without batching). However, this memory consumption is relatively
> constant. In other words, the system is able to keep up with the
> kfree_rcu() load. The memory consumption comes down considerably if
> KFREE_DRAIN_JIFFIES is increased from HZ/50 to HZ/80.

That would be a decrease rather than an increase in KFREE_DRAIN_JIFFIES,
correct?

This would also be a good place to mention that a later patch will
decrease consumption, but that is strictly optional.  However, you did
introduce the topic of changing KFREE_DRAIN_JIFFIES, so if a later patch
changes this value, this would be an excellent place to mention this.

> Also, when running the test, please disable CONFIG_DEBUG_PREEMPT and
> CONFIG_PROVE_RCU for realistic comparisons with/without batching.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And the code is much better!  Just one duplication-avoidance nit below.
Plus a thought for a future patch.

							Thanx, Paul

> ---
>  .../admin-guide/kernel-parameters.txt         |  17 ++
>  kernel/rcu/rcuperf.c                          | 181 +++++++++++++++++-
>  2 files changed, 190 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 79b983bedcaa..24fe8aefb12c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3896,6 +3896,23 @@
>  			test until boot completes in order to avoid
>  			interference.
>  
> +	rcuperf.kfree_rcu_test= [KNL]
> +			Set to measure performance of kfree_rcu() flooding.
> +
> +	rcuperf.kfree_nthreads= [KNL]
> +			The number of threads running loops of kfree_rcu().
> +
> +	rcuperf.kfree_alloc_num= [KNL]
> +			Number of allocations and frees done in an iteration.
> +
> +	rcuperf.kfree_loops= [KNL]
> +			Number of loops doing rcuperf.kfree_alloc_num number
> +			of allocations and frees.
> +
> +	rcuperf.kfree_no_batch= [KNL]
> +			Use the non-batching (less efficient) version of kfree_rcu().
> +			This is useful for comparing with the batched version.
> +
>  	rcuperf.nreaders= [KNL]
>  			Set number of RCU readers.  The value -1 selects
>  			N, where N is the number of CPUs.  A value
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 5f884d560384..c1e25fd10f2a 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -86,6 +86,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
>  	      "Shutdown at end of performance tests.");
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
> +torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
>  
>  static char *perf_type = "rcu";
>  module_param(perf_type, charp, 0444);
> @@ -105,8 +106,8 @@ static atomic_t n_rcu_perf_writer_finished;
>  static wait_queue_head_t shutdown_wq;
>  static u64 t_rcu_perf_writer_started;
>  static u64 t_rcu_perf_writer_finished;
> -static unsigned long b_rcu_perf_writer_started;
> -static unsigned long b_rcu_perf_writer_finished;
> +static unsigned long b_rcu_gp_test_started;
> +static unsigned long b_rcu_gp_test_finished;
>  static DEFINE_PER_CPU(atomic_t, n_async_inflight);
>  
>  #define MAX_MEAS 10000
> @@ -378,10 +379,10 @@ rcu_perf_writer(void *arg)
>  	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
>  		t_rcu_perf_writer_started = t;
>  		if (gp_exp) {
> -			b_rcu_perf_writer_started =
> +			b_rcu_gp_test_started =
>  				cur_ops->exp_completed() / 2;
>  		} else {
> -			b_rcu_perf_writer_started = cur_ops->get_gp_seq();
> +			b_rcu_gp_test_started = cur_ops->get_gp_seq();
>  		}
>  	}
>  
> @@ -429,10 +430,10 @@ rcu_perf_writer(void *arg)
>  				PERFOUT_STRING("Test complete");
>  				t_rcu_perf_writer_finished = t;
>  				if (gp_exp) {
> -					b_rcu_perf_writer_finished =
> +					b_rcu_gp_test_finished =
>  						cur_ops->exp_completed() / 2;
>  				} else {
> -					b_rcu_perf_writer_finished =
> +					b_rcu_gp_test_finished =
>  						cur_ops->get_gp_seq();
>  				}
>  				if (shutdown) {
> @@ -515,8 +516,8 @@ rcu_perf_cleanup(void)
>  			 t_rcu_perf_writer_finished -
>  			 t_rcu_perf_writer_started,
>  			 ngps,
> -			 rcuperf_seq_diff(b_rcu_perf_writer_finished,
> -					  b_rcu_perf_writer_started));
> +			 rcuperf_seq_diff(b_rcu_gp_test_finished,
> +					  b_rcu_gp_test_started));
>  		for (i = 0; i < nrealwriters; i++) {
>  			if (!writer_durations)
>  				break;
> @@ -584,6 +585,167 @@ rcu_perf_shutdown(void *arg)
>  	return -EINVAL;
>  }
>  
> +/*
> + * kfree_rcu() performance tests: Start a kfree_rcu() loop on all CPUs for number
> + * of iterations and measure total time and number of GP for all iterations to complete.
> + */
> +
> +torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
> +torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
> +torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> +torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu().");
> +
> +static struct task_struct **kfree_reader_tasks;
> +static int kfree_nrealthreads;
> +static atomic_t n_kfree_perf_thread_started;
> +static atomic_t n_kfree_perf_thread_ended;
> +
> +struct kfree_obj {
> +	char kfree_obj[8];
> +	struct rcu_head rh;
> +};
> +
> +static int
> +kfree_perf_thread(void *arg)
> +{
> +	int i, loop = 0;
> +	long me = (long)arg;
> +	struct kfree_obj *alloc_ptr;
> +	u64 start_time, end_time;
> +
> +	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> +	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> +	set_user_nice(current, MAX_NICE);
> +
> +	start_time = ktime_get_mono_fast_ns();
> +
> +	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
> +		if (gp_exp)
> +			b_rcu_gp_test_started = cur_ops->exp_completed() / 2;

At some point, it would be good to use the new grace-period
sequence-counter functions (rcuperf_seq_diff(), for example) instead of
the open-coded division by 2.  I freely admit that you are just copying
my obsolete hack in this case, so not needed in this patch.

> +		else
> +			b_rcu_gp_test_started = cur_ops->get_gp_seq();
> +	}
> +
> +	do {
> +		for (i = 0; i < kfree_alloc_num; i++) {
> +			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> +			if (!alloc_ptr)
> +				return -ENOMEM;
> +
> +			if (!kfree_no_batch) {
> +				kfree_rcu(alloc_ptr, rh);
> +			} else {
> +				rcu_callback_t cb;
> +
> +				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> +				kfree_call_rcu_nobatch(&(alloc_ptr->rh), cb);
> +			}
> +		}

Nice, much simpler than the earlier version!

> +		cond_resched();
> +	} while (!torture_must_stop() && ++loop < kfree_loops);
> +
> +	if (atomic_inc_return(&n_kfree_perf_thread_ended) >= kfree_nrealthreads) {
> +		end_time = ktime_get_mono_fast_ns();
> +
> +		if (gp_exp)
> +			b_rcu_gp_test_finished = cur_ops->exp_completed() / 2;

Same here on open-coded division by 2.

> +		else
> +			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
> +
> +		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
> +		       (unsigned long long)(end_time - start_time), kfree_loops,
> +		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
> +		if (shutdown) {
> +			smp_mb(); /* Assign before wake. */
> +			wake_up(&shutdown_wq);
> +		}
> +	}
> +
> +	torture_kthread_stopping("kfree_perf_thread");
> +	return 0;
> +}
> +
> +static void
> +kfree_perf_cleanup(void)
> +{
> +	int i;
> +
> +	if (torture_cleanup_begin())
> +		return;
> +
> +	if (kfree_reader_tasks) {
> +		for (i = 0; i < kfree_nrealthreads; i++)
> +			torture_stop_kthread(kfree_perf_thread,
> +					     kfree_reader_tasks[i]);
> +		kfree(kfree_reader_tasks);
> +	}
> +
> +	torture_cleanup_end();
> +}
> +
> +/*
> + * shutdown kthread.  Just waits to be awakened, then shuts down system.
> + */
> +static int
> +kfree_perf_shutdown(void *arg)
> +{
> +	do {
> +		wait_event(shutdown_wq,
> +			   atomic_read(&n_kfree_perf_thread_ended) >=
> +			   kfree_nrealthreads);
> +	} while (atomic_read(&n_kfree_perf_thread_ended) < kfree_nrealthreads);
> +
> +	smp_mb(); /* Wake before output. */
> +
> +	kfree_perf_cleanup();
> +	kernel_power_off();
> +	return -EINVAL;

These last four lines should be combined with those of
rcu_perf_shutdown().  Actually, you could fold the two functions together
with only a pair of arguments and two one-line wrapper functions, which
would be even better.

> +}
> +
> +static int __init
> +kfree_perf_init(void)
> +{
> +	long i;
> +	int firsterr = 0;
> +
> +	kfree_nrealthreads = compute_real(kfree_nthreads);
> +	/* Start up the kthreads. */
> +	if (shutdown) {
> +		init_waitqueue_head(&shutdown_wq);
> +		firsterr = torture_create_kthread(kfree_perf_shutdown, NULL,
> +						  shutdown_task);
> +		if (firsterr)
> +			goto unwind;
> +		schedule_timeout_uninterruptible(1);
> +	}
> +
> +	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
> +			       GFP_KERNEL);
> +	if (kfree_reader_tasks == NULL) {
> +		firsterr = -ENOMEM;
> +		goto unwind;
> +	}
> +
> +	for (i = 0; i < kfree_nrealthreads; i++) {
> +		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
> +						  kfree_reader_tasks[i]);
> +		if (firsterr)
> +			goto unwind;
> +	}
> +
> +	while (atomic_read(&n_kfree_perf_thread_started) < kfree_nrealthreads)
> +		schedule_timeout_uninterruptible(1);
> +
> +	torture_init_end();
> +	return 0;
> +
> +unwind:
> +	torture_init_end();
> +	kfree_perf_cleanup();
> +	return firsterr;
> +}
> +
>  static int __init
>  rcu_perf_init(void)
>  {
> @@ -616,6 +778,9 @@ rcu_perf_init(void)
>  	if (cur_ops->init)
>  		cur_ops->init();
>  
> +	if (kfree_rcu_test)
> +		return kfree_perf_init();
> +
>  	nrealwriters = compute_real(nwriters);
>  	nrealreaders = compute_real(nreaders);
>  	atomic_set(&n_rcu_perf_reader_started, 0);
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
