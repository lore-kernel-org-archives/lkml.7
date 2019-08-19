Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08448C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F1D214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfHSWYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:24:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728469AbfHSWYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:24:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JMGfIB009291;
        Mon, 19 Aug 2019 18:23:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ug2gnvc14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 18:23:27 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7JMHKbD011371;
        Mon, 19 Aug 2019 18:23:27 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ug2gnvc0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 18:23:27 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7JMKDUN004403;
        Mon, 19 Aug 2019 22:23:26 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 2ue976h1eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 22:23:26 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JMNPvd15598428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 22:23:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6A3DB205F;
        Mon, 19 Aug 2019 22:23:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88E7CB206C;
        Mon, 19 Aug 2019 22:23:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 22:23:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1276B16C2403; Mon, 19 Aug 2019 15:23:30 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:23:30 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com, Rao Shoaib <rao.shoaib@oracle.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 2/2] rcuperf: Add kfree_rcu() performance Tests
Message-ID: <20190819222330.GH28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190814160411.58591-2-joel@joelfernandes.org>
 <20190814225850.GZ28441@linux.ibm.com>
 <20190819193327.GF117548@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819193327.GF117548@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 03:33:27PM -0400, Joel Fernandes wrote:
> On Wed, Aug 14, 2019 at 03:58:50PM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 14, 2019 at 12:04:11PM -0400, Joel Fernandes (Google) wrote:
> > > This test runs kfree_rcu in a loop to measure performance of the new
> > > kfree_rcu batching functionality.
> > 
> > kfree_rcu().
> 
> Fixed.
> 
> > > The following table shows results when booting with arguments:
> > > rcuperf.kfree_loops=200000 rcuperf.kfree_alloc_num=1000 rcuperf.kfree_rcu_test=1
> > > 
> > > In addition, rcuperf.kfree_no_batch is used to toggle the batching of
> > > kfree_rcu()s for a test run.
> > > 
> > > rcuperf.kfree_no_batch	GPs	time (seconds)
> > >  0 (default)		1732	15.9
> > >  1			9133 	14.5
> > > 
> > > Note that the results are the same for the case:
> > > 1. Patch is not applied and rcuperf.kfree_no_batch=0
> > > 2. Patch is applied     and rcuperf.kfree_no_batch=1
> > > 
> > > On a 16 CPU system with the above boot parameters, we see that the total
> > > number of grace periods that elapse during the test drops from 9133 when
> > > not batching to 1732 when batching (a 5X improvement). The kfree_rcu()
> > > flood itself slows down a bit when batching, though, as shown. This is
> > > likely due to rcuperf threads contending with the additional worker
> > > threads that are now running both before (the monitor) and after (the
> > > work done to kfree()) the grace period.
> > 
> > Another possibility is that the batching approach is resulting in a
> > greater number of objects waiting to be freed (noted below), and it
> > takes the extra 1.4 seconds to catch up.  How would you decide which
> > effect is the most important?  (Your path of least resistance is to
> > remove the speculation.)
> 
> I will remove the speculation since the slightly extra time is understandable
> and not concerning. I hope we agree on that.

Works for me!

> > > Note that the active memory consumption during the kfree_rcu() flood
> > > does increase to around 300-400MB due to the batching (from around 50MB
> > > without batching). However, this memory consumption is relatively
> > > constant and is just an effect of the buffering. In other words, the
> > > system is able to keep up with the kfree_rcu() load. The memory
> > > consumption comes down to 200-300MB if KFREE_DRAIN_JIFFIES is
> > > increased from HZ/50 to HZ/80.
> > > 
> > > Also, when running the test, please disable CONFIG_DEBUG_PREEMPT and
> > > CONFIG_PROVE_RCU for realistic comparisons with/without batching.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Looks pretty close, just a very few issues needing fixing below.
> 
> Thanks!
> 
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         |  17 ++
> > >  kernel/rcu/rcuperf.c                          | 189 +++++++++++++++++-
> > >  2 files changed, 198 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 7ccd158b3894..a9156ca5de24 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3895,6 +3895,23 @@
> > >  			test until boot completes in order to avoid
> > >  			interference.
> > >  
> > > +	rcuperf.kfree_rcu_test= [KNL]
> > > +			Set to measure performance of kfree_rcu() flooding.
> > > +
> > > +	rcuperf.kfree_nthreads= [KNL]
> > > +			The number of threads running loops of kfree_rcu().
> > > +
> > > +	rcuperf.kfree_alloc_num= [KNL]
> > > +			Number of allocations and frees done in an iteration.
> > > +
> > > +	rcuperf.kfree_loops= [KNL]
> > > +			Number of loops doing rcuperf.kfree_alloc_num number
> > > +			of allocations and frees.
> > > +
> > > +	rcuperf.kfree_no_batch= [KNL]
> > > +			Use the non-batching (slower) version of kfree_rcu.
> > > +			This is useful for comparing with the batched version.
> > 
> > I suggest s/slower/more efficient/ given that the batching takes more
> > wall-clock time than does the no-batching.
> 
> I think you mean, slower -> less efficient (due to taking up more grace
> period cycles per second in the no batching case). I will update it
> accordingly.

Yes, less efficient.  ;-)

> [snip]
> > > @@ -592,6 +593,175 @@ rcu_perf_shutdown(void *arg)
> > >  	return -EINVAL;
> > >  }
> > >  
> > > +/*
> > > + * kfree_rcu performance tests: Start a kfree_rcu loop on all CPUs for number
> > > + * of iterations and measure total time and number of GP for all iterations to complete.
> > > + */
> > > +
> > > +torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
> > > +torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
> > > +torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> > > +torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu.");
> > > +
> > > +static struct task_struct **kfree_reader_tasks;
> > > +static int kfree_nrealthreads;
> > > +static atomic_t n_kfree_perf_thread_started;
> > > +static atomic_t n_kfree_perf_thread_ended;
> > > +
> > > +struct kfree_obj {
> > > +	char kfree_obj[8];
> > > +	struct rcu_head rh;
> > > +};
> > 
> > (Aside from above, no need to change this part of the patch, at least not
> > that I know of at the moment.)
> > 
> > 24 bytes on a 64-bit system, 16 on a 32-bit system.  So there might
> > have been 10 million extra objects awaiting free in the batching case
> > given the 400M-50M=350M excess for the batching approach.  If freeing
> > each object took about 100ns, that could account for the additional
> > wall-clock time for the batching approach.
> 
> Makes sense, and this comes down to 200-220MB range with the additional list.

Which might even match the observed numbers?

> > > +	set_user_nice(current, MAX_NICE);
> > > +
> > > +	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
> > > +						  GFP_KERNEL);
> > > +	if (!alloc_ptrs)
> > > +		return -ENOMEM;
> > > +
> > > +	start_time = ktime_get_mono_fast_ns();
> > > +
> > > +	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
> > > +		if (gp_exp)
> > > +			b_rcu_gp_test_started = cur_ops->exp_completed() / 2;
> > > +		else
> > > +			b_rcu_gp_test_started = cur_ops->get_gp_seq();
> > > +	}
> > > +
> > > +	do {
> > > +		for (i = 0; i < kfree_alloc_num; i++) {
> > > +			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> > > +			if (!alloc_ptrs[i])
> > > +				return -ENOMEM;
> > > +		}
> > > +
> > > +		for (i = 0; i < kfree_alloc_num; i++) {
> > > +			if (!kfree_no_batch) {
> > > +				kfree_rcu(alloc_ptrs[i], rh);
> > > +			} else {
> > > +				rcu_callback_t cb;
> > > +
> > > +				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> > > +				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
> > > +			}
> > > +		}
> > 
> > The point of allocating a large batch and then kfree_rcu()ing them in a
> > loop is to defeat the per-CPU pool optimization?  Either way, a comment
> > would be very good!
> 
> It was a reasoning like this, added it as a comment:
> 
> 	/* While measuring kfree_rcu() time, we also end up measuring kmalloc()
> 	 * time. So the strategy here is to do a few (kfree_alloc_num) number
> 	 * of kmalloc() and kfree_rcu() every loop so that the current loop's
> 	 * deferred kfree()ing overlaps with the next loop's kmalloc().
> 	 */

The thought being that the CPU will be executing the two loops
concurrently?  Up to a point, agreed, but how much of an effect is
that, really?

Or is the idea to time the kfree_rcu() loop separately?  (I don't see
any such separate timing, though.)

							Thanx, Paul

> Will post it soon with other patches on top of -rcu dev.
> 
> thanks,
> 
>  - Joel
> 
