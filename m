Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB90C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557832067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfHNW7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:59:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728413AbfHNW7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:59:35 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EMvggQ088640;
        Wed, 14 Aug 2019 18:58:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ucuhng26d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 18:58:50 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7EMwnFB091362;
        Wed, 14 Aug 2019 18:58:49 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ucuhng261-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 18:58:49 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7EMseqG008944;
        Wed, 14 Aug 2019 22:58:48 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 2u9nj6yca2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 22:58:48 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7EMwmDp31326566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 22:58:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59A1EB2065;
        Wed, 14 Aug 2019 22:58:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 268CFB2064;
        Wed, 14 Aug 2019 22:58:48 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Aug 2019 22:58:48 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4205B16C0600; Wed, 14 Aug 2019 15:58:50 -0700 (PDT)
Date:   Wed, 14 Aug 2019 15:58:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com, Rao Shoaib <rao.shoaib@oracle.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 2/2] rcuperf: Add kfree_rcu() performance Tests
Message-ID: <20190814225850.GZ28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190814160411.58591-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814160411.58591-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:04:11PM -0400, Joel Fernandes (Google) wrote:
> This test runs kfree_rcu in a loop to measure performance of the new
> kfree_rcu batching functionality.

kfree_rcu().

> The following table shows results when booting with arguments:
> rcuperf.kfree_loops=200000 rcuperf.kfree_alloc_num=1000 rcuperf.kfree_rcu_test=1
> 
> In addition, rcuperf.kfree_no_batch is used to toggle the batching of
> kfree_rcu()s for a test run.
> 
> rcuperf.kfree_no_batch	GPs	time (seconds)
>  0 (default)		1732	15.9
>  1			9133 	14.5
> 
> Note that the results are the same for the case:
> 1. Patch is not applied and rcuperf.kfree_no_batch=0
> 2. Patch is applied     and rcuperf.kfree_no_batch=1
> 
> On a 16 CPU system with the above boot parameters, we see that the total
> number of grace periods that elapse during the test drops from 9133 when
> not batching to 1732 when batching (a 5X improvement). The kfree_rcu()
> flood itself slows down a bit when batching, though, as shown. This is
> likely due to rcuperf threads contending with the additional worker
> threads that are now running both before (the monitor) and after (the
> work done to kfree()) the grace period.

Another possibility is that the batching approach is resulting in a
greater number of objects waiting to be freed (noted below), and it
takes the extra 1.4 seconds to catch up.  How would you decide which
effect is the most important?  (Your path of least resistance is to
remove the speculation.)

> Note that the active memory consumption during the kfree_rcu() flood
> does increase to around 300-400MB due to the batching (from around 50MB
> without batching). However, this memory consumption is relatively
> constant and is just an effect of the buffering. In other words, the
> system is able to keep up with the kfree_rcu() load. The memory
> consumption comes down to 200-300MB if KFREE_DRAIN_JIFFIES is
> increased from HZ/50 to HZ/80.
> 
> Also, when running the test, please disable CONFIG_DEBUG_PREEMPT and
> CONFIG_PROVE_RCU for realistic comparisons with/without batching.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks pretty close, just a very few issues needing fixing below.

							Thanx, Paul

> ---
>  .../admin-guide/kernel-parameters.txt         |  17 ++
>  kernel/rcu/rcuperf.c                          | 189 +++++++++++++++++-
>  2 files changed, 198 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7ccd158b3894..a9156ca5de24 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3895,6 +3895,23 @@
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
> +			Use the non-batching (slower) version of kfree_rcu.
> +			This is useful for comparing with the batched version.

I suggest s/slower/more efficient/ given that the batching takes more
wall-clock time than does the no-batching.

>  	rcuperf.nreaders= [KNL]
>  			Set number of RCU readers.  The value -1 selects
>  			N, where N is the number of CPUs.  A value
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 7a6890b23c5f..70d6ac19cbff 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -86,6 +86,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
>  	      "Shutdown at end of performance tests.");
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
> +torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu perf test?");
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
>  static int rcu_perf_writer_state;
> @@ -379,10 +380,10 @@ rcu_perf_writer(void *arg)
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
> @@ -435,10 +436,10 @@ rcu_perf_writer(void *arg)
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
> @@ -523,8 +524,8 @@ rcu_perf_cleanup(void)
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
> @@ -592,6 +593,175 @@ rcu_perf_shutdown(void *arg)
>  	return -EINVAL;
>  }
>  
> +/*
> + * kfree_rcu performance tests: Start a kfree_rcu loop on all CPUs for number
> + * of iterations and measure total time and number of GP for all iterations to complete.
> + */
> +
> +torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
> +torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
> +torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> +torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu.");
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

(Aside from above, no need to change this part of the patch, at least not
that I know of at the moment.)

24 bytes on a 64-bit system, 16 on a 32-bit system.  So there might
have been 10 million extra objects awaiting free in the batching case
given the 400M-50M=350M excess for the batching approach.  If freeing
each object took about 100ns, that could account for the additional
wall-clock time for the batching approach.

> +
> +static int
> +kfree_perf_thread(void *arg)
> +{
> +	int i, loop = 0;
> +	long me = (long)arg;
> +	struct kfree_obj **alloc_ptrs;
> +	u64 start_time, end_time;
> +
> +	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> +	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));

(No need for a change, another aside:  This assumes dense CPU numbering,
which will cause trouble at some point.  As you may have noticed from
the other similar code in rcuperf.c, I have been using the strategy of
waiting until a real problem shows up before fixing it.)

> +	set_user_nice(current, MAX_NICE);
> +
> +	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
> +						  GFP_KERNEL);
> +	if (!alloc_ptrs)
> +		return -ENOMEM;
> +
> +	start_time = ktime_get_mono_fast_ns();
> +
> +	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
> +		if (gp_exp)
> +			b_rcu_gp_test_started = cur_ops->exp_completed() / 2;
> +		else
> +			b_rcu_gp_test_started = cur_ops->get_gp_seq();
> +	}
> +
> +	do {
> +		for (i = 0; i < kfree_alloc_num; i++) {
> +			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> +			if (!alloc_ptrs[i])
> +				return -ENOMEM;
> +		}
> +
> +		for (i = 0; i < kfree_alloc_num; i++) {
> +			if (!kfree_no_batch) {
> +				kfree_rcu(alloc_ptrs[i], rh);
> +			} else {
> +				rcu_callback_t cb;
> +
> +				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> +				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
> +			}
> +		}

The point of allocating a large batch and then kfree_rcu()ing them in a
loop is to defeat the per-CPU pool optimization?  Either way, a comment
would be very good!

> +
> +		cond_resched();
> +	} while (!torture_must_stop() && ++loop < kfree_loops);
> +
> +	if (atomic_inc_return(&n_kfree_perf_thread_ended) >= kfree_nrealthreads) {
> +		end_time = ktime_get_mono_fast_ns();
> +
> +		if (gp_exp)
> +			b_rcu_gp_test_finished = cur_ops->exp_completed() / 2;

Why not use a .gp_diff field similar to the way that rcutorture does?
(Yes, rcutorture ignores numbers of expedited grace periods, but the
GP sequence numbers now have the same formats in both cases.)

This can be a follow-on.

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
> +	kfree(alloc_ptrs);
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
> @@ -624,6 +794,9 @@ rcu_perf_init(void)
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
> 2.23.0.rc1.153.gdeed80330f-goog
> 
