Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CBBC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA2B22305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbfHGSCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:02:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388163AbfHGSCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:02:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77Huxn1093733;
        Wed, 7 Aug 2019 13:56:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u83g7g026-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 13:56:59 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x77HuxB8093674;
        Wed, 7 Aug 2019 13:56:59 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u83g7g01d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 13:56:59 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x77HnsSg024862;
        Wed, 7 Aug 2019 17:56:57 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 2u51w63uen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 17:56:57 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x77Huvrn51511580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Aug 2019 17:56:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F56DB2081;
        Wed,  7 Aug 2019 17:56:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 208F0B2079;
        Wed,  7 Aug 2019 17:56:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Aug 2019 17:56:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C856516C5DA7; Wed,  7 Aug 2019 10:56:57 -0700 (PDT)
Date:   Wed, 7 Aug 2019 10:56:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com,
        byungchul.park@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 2/2] rcuperf: Add kfree_rcu performance Tests
Message-ID: <20190807175657.GF28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806212041.118146-2-joel@joelfernandes.org>
 <20190807002915.GV28441@linux.ibm.com>
 <20190807102213.GD169551@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807102213.GD169551@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 06:22:13AM -0400, Joel Fernandes wrote:
> On Tue, Aug 06, 2019 at 05:29:15PM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 06, 2019 at 05:20:41PM -0400, Joel Fernandes (Google) wrote:
> > > This test runs kfree_rcu in a loop to measure performance of the new
> > > kfree_rcu, with and without patch.
> > > 
> > > To see improvement, run with boot parameters:
> > > rcuperf.kfree_loops=2000 rcuperf.kfree_alloc_num=100 rcuperf.perf_type=kfree
> > > 
> > > Without patch, test runs in 6.9 seconds.
> > > With patch, test runs in 6.1 seconds (+13% improvement)
> > > 
> > > If it is desired to run the test but with the traditional (non-batched)
> > > kfree_rcu, for example to compare results, then you could pass along the
> > > rcuperf.kfree_no_batch=1 boot parameter.
> > 
> > You lost me on this one.  You ran two runs, with rcuperf.kfree_no_batch=1
> > and without?  Or you ran this patch both with and without the earlier
> > patch, and could have run with the patch and rcuperf.kfree_no_batch=1?
> 
> I always run the rcutorture test with patch because the patch doesn't really
> do anything if rcuperf.kfree_no_batch=0. This parameter is added so that in
> the future folks can compare effect of non-batching with that of the
> batching. However, I can also remove the patch itself and run this test
> again.
> 
> > If the latter, it would be good to try all three.
> 
> Ok, sure.

Very good!  And please make the commit log more clear.  ;-)

> [snip] 
> > > ---
> > >  kernel/rcu/rcuperf.c | 169 ++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 168 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > > index 7a6890b23c5f..34658760da5e 100644
> > > --- a/kernel/rcu/rcuperf.c
> > > +++ b/kernel/rcu/rcuperf.c
> > > @@ -89,7 +89,7 @@ torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable
> > >  
> > >  static char *perf_type = "rcu";
> > >  module_param(perf_type, charp, 0444);
> > > -MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, ...)");
> > > +MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, kfree,...)");
> > >  
> > >  static int nrealreaders;
> > >  static int nrealwriters;
> > > @@ -592,6 +592,170 @@ rcu_perf_shutdown(void *arg)
> > >  	return -EINVAL;
> > >  }
> > >  
> > > +/*
> > > + * kfree_rcu performance tests: Start a kfree_rcu loop on all CPUs for number
> > > + * of iterations and measure total time for all iterations to complete.
> > > + */
> > > +
> > > +torture_param(int, kfree_nthreads, -1, "Number of RCU reader threads");
> > > +torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done by a thread");
> > > +torture_param(int, kfree_alloc_size, 16,  "Size of each allocation");
> > 
> > Is this used?  How does it relate to KFREE_OBJ_BYTES?
> 
> You're right, I had added this before but it is unused now. Sorry about that,
> I will remove it.
> 
> > > +torture_param(int, kfree_loops, 10, "Size of each allocation");
> > 
> > I suspect that this kfree_loops string is out of date.
> 
> Yes, complete screw up, will update it.
> 
> > > +torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu");
> > 
> > All of these need to be added to kernel-parameters.txt.  Along with
> > any added by the earlier patch, for that matter.
> 
> Sure, should I split that into a separate patch?

Your choice.

> > > +static struct task_struct **kfree_reader_tasks;
> > > +static int kfree_nrealthreads;
> > > +static atomic_t n_kfree_perf_thread_started;
> > > +static atomic_t n_kfree_perf_thread_ended;
> > > +
> > > +#define KFREE_OBJ_BYTES 8
> > > +
> > > +struct kfree_obj {
> > > +	char kfree_obj[KFREE_OBJ_BYTES];
> > > +	struct rcu_head rh;
> > > +};
> > > +
> > > +void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
> > > +
> > > +static int
> > > +kfree_perf_thread(void *arg)
> > > +{
> > > +	int i, l = 0;
> > 
> > It is really easy to confuse "l" and "1" in some fonts, so please use
> > a different name.  (From the "showing my age" department:  On typical
> > 1970s typewriters, there was no numeral "1" -- you typed the letter
> > "l" instead, thus anticipating at least the first digit of "1337".)
> 
> :-D Ok, I will improve the names.
> 
> > > +	long me = (long)arg;
> > > +	struct kfree_obj **alloc_ptrs;
> > > +	u64 start_time, end_time;
> > > +
> > > +	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> > > +	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> > > +	set_user_nice(current, MAX_NICE);
> > > +	atomic_inc(&n_kfree_perf_thread_started);
> > > +
> > > +	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
> > > +						  GFP_KERNEL);
> > > +	if (!alloc_ptrs)
> > > +		return -ENOMEM;
> > > +
> > > +	start_time = ktime_get_mono_fast_ns();
> > 
> > Don't you want to announce that you started here rather than above in
> > order to avoid (admittedly slight) measurement inaccuracies?
> 
> I did not follow, are you referring to the measurement inaccuracy related to
> the "kfree_perf_thread task started" string print?  Or, are you saying that
> ktime_get_mono_fast_ns() has to start earlier than over here?

I am referring to the atomic_inc().

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
> > > +
> > > +		schedule_timeout_uninterruptible(2);
> > 
> > Why the two-jiffy wait in the middle of a timed test?  Yes, you need
> > a cond_resched() and maybe more here, but a two-jiffy wait?  I don't
> > see how this has any chance of getting valid measurements.
> > 
> > What am I missing here?
> 
> I am getting pretty reliable and repeatable results with this test.

That is a good thing, but you might not be measuring what you think you
are measuring.

>                                                                     The sleep
> was mostly just to give the system a chance to scheduler other tasks. I can
> remove the schedule and also try with just cond_resched().

Please do!  This can be a bit fiddly, but there is example code in
current rcutorture on -rcu.

> The other reason for the schedule call was also to give the test a longer
> running time and help with easier measurement as a result, since the test
> would run otherwise for a very shortwhile. Agreed there might be a better way
> to handle this issue.

Easy!  Do more kmalloc()/kfree_rcu() pairs!  ;-)

> (I will reply to the rest of the comments below in a bit, I am going to a
> hospital now to visit a sick relative and will be back a bit later.)

Ouch!!!  I hope that goes as well as it possibly can!  And please don't
neglect your relative on RCU's account!!!

							Thanx, Paul
