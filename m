Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78469C3A59D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C83522DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfHUApQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:45:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbfHUApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:45:16 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7L0bOZt059167;
        Tue, 20 Aug 2019 20:44:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ugu9crseg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 20:44:38 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7L0bRTK059461;
        Tue, 20 Aug 2019 20:44:37 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ugu9crse6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 20:44:37 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7L0eRg8004588;
        Wed, 21 Aug 2019 00:44:37 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 2ue976pg90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 00:44:37 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7L0iaCn41353590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 00:44:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF68BB2064;
        Wed, 21 Aug 2019 00:44:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79D78B205F;
        Wed, 21 Aug 2019 00:44:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.78])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 00:44:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2CCCC16C1D4F; Tue, 20 Aug 2019 17:44:36 -0700 (PDT)
Date:   Tue, 20 Aug 2019 17:44:36 -0700
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
Message-ID: <20190821004436.GB28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190814160411.58591-2-joel@joelfernandes.org>
 <20190814225850.GZ28441@linux.ibm.com>
 <20190819193327.GF117548@google.com>
 <20190819222330.GH28441@linux.ibm.com>
 <20190819235123.GA185164@google.com>
 <20190820025056.GL28441@linux.ibm.com>
 <20190821002705.GA212946@google.com>
 <20190821003132.GA25611@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821003132.GA25611@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 08:31:32PM -0400, Joel Fernandes wrote:
> On Tue, Aug 20, 2019 at 08:27:05PM -0400, Joel Fernandes wrote:
> [snip]
> > > > > Or is the idea to time the kfree_rcu() loop separately?  (I don't see
> > > > > any such separate timing, though.)
> > > > 
> > > > The kmalloc() times are included within the kfree loop. The timing of
> > > > kfree_rcu() is not separate in my patch.
> > > 
> > > You lost me on this one.  What happens when you just interleave the
> > > kmalloc() and kfree_rcu(), without looping, compared to the looping
> > > above?  Does this get more expensive?  Cheaper?  More vulnerable to OOM?
> > > Something else?
> > 
> > You mean pairing a single kmalloc() with a single kfree_rcu() and doing this
> > several times? The results are very similar to doing kfree_alloc_num
> > kmalloc()s, then do kfree_alloc_num kfree_rcu()s; and repeat the whole thing
> > kfree_loops times (as done by this rcuperf patch we are reviewing).
> > 
> > Following are some numbers. One change is the case where we are not at all
> > batching does seem to complete even faster when we fully interleave kmalloc()
> > with kfree() while the case of batching in the same scenario completes at the
> > same time as did the "not fully interleaved" scenario. However, the grace
> > period reduction improvements and the chances of OOM'ing are pretty much the
> > same in either case.
> [snip]
> > Not fully interleaved: do kfree_alloc_num kmallocs, then do kfree_alloc_num kfree_rcu()s. And repeat this kfree_loops times.
> > =======================
> > (1) Batching
> > rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_no_batch=0 rcuperf.kfree_rcu_test=1
> > 
> > root@(none):/# free -m
> >               total        used        free      shared  buff/cache   available
> > Mem:            977         251         686           0          39         684
> > Swap:             0           0           0
> > 
> > [   15.574402] Total time taken by all kfree'ers: 14185970787 ns, loops: 20000, batches: 1548
> > 
> > (2) No Batching
> > rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_no_batch=1 rcuperf.kfree_rcu_test=1
> > 
> > root@(none):/# free -m
> >               total        used        free      shared  buff/cache   available
> > Mem:            977          82         855           0          39         853
> > Swap:             0           0           0
> > 
> > [   13.724554] Total time taken by all kfree'ers: 12246217291 ns, loops: 20000, batches: 7262
> 
> And the diff for changing the test to do this case is as follows (I don't
> plan to fold this diff in, since I feel the existing test suffices and
> results are similar):

But why not?  It does look to be a nice simplification, after all.

							Thanx, Paul

> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 46f9c4449348..e4e4be4aaf51 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -618,18 +618,13 @@ kfree_perf_thread(void *arg)
>  {
>  	int i, loop = 0;
>  	long me = (long)arg;
> -	struct kfree_obj **alloc_ptrs;
> +	struct kfree_obj *alloc_ptr;
>  	u64 start_time, end_time;
>  
>  	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
>  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
>  	set_user_nice(current, MAX_NICE);
>  
> -	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
> -						  GFP_KERNEL);
> -	if (!alloc_ptrs)
> -		return -ENOMEM;
> -
>  	start_time = ktime_get_mono_fast_ns();
>  
>  	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
> @@ -646,19 +641,17 @@ kfree_perf_thread(void *arg)
>  	 */
>  	do {
>  		for (i = 0; i < kfree_alloc_num; i++) {
> -			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> -			if (!alloc_ptrs[i])
> +			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> +			if (!alloc_ptr)
>  				return -ENOMEM;
> -		}
>  
> -		for (i = 0; i < kfree_alloc_num; i++) {
>  			if (!kfree_no_batch) {
> -				kfree_rcu(alloc_ptrs[i], rh);
> +				kfree_rcu(alloc_ptr, rh);
>  			} else {
>  				rcu_callback_t cb;
>  
>  				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> -				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
> +				kfree_call_rcu_nobatch(&(alloc_ptr->rh), cb);
>  			}
>  		}
>  
> @@ -682,7 +675,6 @@ kfree_perf_thread(void *arg)
>  		}
>  	}
>  
> -	kfree(alloc_ptrs);
>  	torture_kthread_stopping("kfree_perf_thread");
>  	return 0;
>  }
