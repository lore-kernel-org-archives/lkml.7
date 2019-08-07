Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D96C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEC921743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfHGA3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:29:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727881AbfHGA3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:29:52 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x770QxtA110302;
        Tue, 6 Aug 2019 20:29:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7jasb5mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 20:29:15 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x770RpDQ112247;
        Tue, 6 Aug 2019 20:29:15 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7jasb5ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 20:29:15 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x770Oppt020124;
        Wed, 7 Aug 2019 00:29:14 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 2u51w634aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 00:29:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x770TEbw51511674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Aug 2019 00:29:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 530C1B2064;
        Wed,  7 Aug 2019 00:29:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2476AB2067;
        Wed,  7 Aug 2019 00:29:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Aug 2019 00:29:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2A21B16C17E8; Tue,  6 Aug 2019 17:29:15 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:29:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com,
        byungchul.park@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 2/2] rcuperf: Add kfree_rcu performance Tests
Message-ID: <20190807002915.GV28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806212041.118146-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806212041.118146-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 05:20:41PM -0400, Joel Fernandes (Google) wrote:
> This test runs kfree_rcu in a loop to measure performance of the new
> kfree_rcu, with and without patch.
> 
> To see improvement, run with boot parameters:
> rcuperf.kfree_loops=2000 rcuperf.kfree_alloc_num=100 rcuperf.perf_type=kfree
> 
> Without patch, test runs in 6.9 seconds.
> With patch, test runs in 6.1 seconds (+13% improvement)
> 
> If it is desired to run the test but with the traditional (non-batched)
> kfree_rcu, for example to compare results, then you could pass along the
> rcuperf.kfree_no_batch=1 boot parameter.

You lost me on this one.  You ran two runs, with rcuperf.kfree_no_batch=1
and without?  Or you ran this patch both with and without the earlier
patch, and could have run with the patch and rcuperf.kfree_no_batch=1?

If the latter, it would be good to try all three.

> Cc: max.byungchul.park@gmail.com
> Cc: byungchul.park@lge.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

More comments below.

							Thanx, Paul

> ---
>  kernel/rcu/rcuperf.c | 169 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 168 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 7a6890b23c5f..34658760da5e 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -89,7 +89,7 @@ torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable
>  
>  static char *perf_type = "rcu";
>  module_param(perf_type, charp, 0444);
> -MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, ...)");
> +MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, kfree,...)");
>  
>  static int nrealreaders;
>  static int nrealwriters;
> @@ -592,6 +592,170 @@ rcu_perf_shutdown(void *arg)
>  	return -EINVAL;
>  }
>  
> +/*
> + * kfree_rcu performance tests: Start a kfree_rcu loop on all CPUs for number
> + * of iterations and measure total time for all iterations to complete.
> + */
> +
> +torture_param(int, kfree_nthreads, -1, "Number of RCU reader threads");
> +torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done by a thread");
> +torture_param(int, kfree_alloc_size, 16,  "Size of each allocation");

Is this used?  How does it relate to KFREE_OBJ_BYTES?

> +torture_param(int, kfree_loops, 10, "Size of each allocation");

I suspect that this kfree_loops string is out of date.

> +torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu");

All of these need to be added to kernel-parameters.txt.  Along with
any added by the earlier patch, for that matter.

> +static struct task_struct **kfree_reader_tasks;
> +static int kfree_nrealthreads;
> +static atomic_t n_kfree_perf_thread_started;
> +static atomic_t n_kfree_perf_thread_ended;
> +
> +#define KFREE_OBJ_BYTES 8
> +
> +struct kfree_obj {
> +	char kfree_obj[KFREE_OBJ_BYTES];
> +	struct rcu_head rh;
> +};
> +
> +void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
> +
> +static int
> +kfree_perf_thread(void *arg)
> +{
> +	int i, l = 0;

It is really easy to confuse "l" and "1" in some fonts, so please use
a different name.  (From the "showing my age" department:  On typical
1970s typewriters, there was no numeral "1" -- you typed the letter
"l" instead, thus anticipating at least the first digit of "1337".)

> +	long me = (long)arg;
> +	struct kfree_obj **alloc_ptrs;
> +	u64 start_time, end_time;
> +
> +	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> +	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> +	set_user_nice(current, MAX_NICE);
> +	atomic_inc(&n_kfree_perf_thread_started);
> +
> +	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
> +						  GFP_KERNEL);
> +	if (!alloc_ptrs)
> +		return -ENOMEM;
> +
> +	start_time = ktime_get_mono_fast_ns();

Don't you want to announce that you started here rather than above in
order to avoid (admittedly slight) measurement inaccuracies?

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
> +
> +		schedule_timeout_uninterruptible(2);

Why the two-jiffy wait in the middle of a timed test?  Yes, you need
a cond_resched() and maybe more here, but a two-jiffy wait?  I don't
see how this has any chance of getting valid measurements.

What am I missing here?

> +	} while (!torture_must_stop() && ++l < kfree_loops);
> +
> +	kfree(alloc_ptrs);
> +
> +	if (atomic_inc_return(&n_kfree_perf_thread_ended) >= kfree_nrealthreads) {
> +		end_time = ktime_get_mono_fast_ns();

Don't we want to capture the end time before the kfree()?

> +		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d\n",
> +		       (unsigned long long)(end_time - start_time), kfree_loops);
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
> +}

Is there some way to avoid (almost) duplicating rcu_perf_shutdown()?

> +static int __init
> +kfree_perf_init(void)
> +{
> +	long i;
> +	int firsterr = 0;
> +
> +	if (!torture_init_begin("kfree_perf", verbose))
> +		return -EBUSY;
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
> @@ -601,6 +765,9 @@ rcu_perf_init(void)
>  		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
>  	};
>  
> +	if (strcmp(perf_type, "kfree") == 0)
> +		return kfree_perf_init();
> +
>  	if (!torture_init_begin(perf_type, verbose))
>  		return -EBUSY;
>  
> -- 
> 2.22.0.770.g0f2c4a37fd-goog
> 
