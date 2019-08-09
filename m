Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B815C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67035204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407310AbfHIPQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:16:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbfHIPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:16:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79FCQ2n078030
        for <linux-kernel@vger.kernel.org>; Fri, 9 Aug 2019 11:16:26 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u9ask9nc0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:16:26 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 9 Aug 2019 16:16:25 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 9 Aug 2019 16:16:19 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x79FGI7T8978824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Aug 2019 15:16:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CC8EB2067;
        Fri,  9 Aug 2019 15:16:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E898B2068;
        Fri,  9 Aug 2019 15:16:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  9 Aug 2019 15:16:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C7B4316C9A67; Fri,  9 Aug 2019 08:16:19 -0700 (PDT)
Date:   Fri, 9 Aug 2019 08:16:19 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <20190808233014.GA184373@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808233014.GA184373@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080915-2213-0000-0000-000003BA80F6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011575; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01244366; UDB=6.00656504; IPR=6.01025848;
 MB=3.00028109; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-09 15:16:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080915-2214-0000-0000-00005F957A96
Message-Id: <20190809151619.GD28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 07:30:14PM -0400, Joel Fernandes wrote:
> On Thu, Aug 08, 2019 at 08:56:07AM -0400, Joel Fernandes wrote:
> > On Thu, Aug 08, 2019 at 06:52:32PM +0900, Byungchul Park wrote:
> > > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > > > > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> > > > [ . . . ]
> > > > > > > +	for (; head; head = next) {
> > > > > > > +		next = head->next;
> > > > > > > +		head->next = NULL;
> > > > > > > +		__call_rcu(head, head->func, -1, 1);
> > > > > > 
> > > > > > We need at least a cond_resched() here.  200,000 times through this loop
> > > > > > in a PREEMPT=n kernel might not always be pretty.  Except that this is
> > > > > > invoked directly from kfree_rcu() which might be invoked with interrupts
> > > > > > disabled, which precludes calls to cond_resched().  So the realtime guys
> > > > > > are not going to be at all happy with this loop.
> > > > > 
> > > > > Ok, will add this here.
> > > > > 
> > > > > > And this loop could be avoided entirely by having a third rcu_head list
> > > > > > in the kfree_rcu_cpu structure.  Yes, some of the batches would exceed
> > > > > > KFREE_MAX_BATCH, but given that they are invoked from a workqueue, that
> > > > > > should be OK, or at least more OK than queuing 200,000 callbacks with
> > > > > > interrupts disabled.  (If it turns out not to be OK, an array of rcu_head
> > > > > > pointers can be used to reduce the probability of oversized batches.)
> > > > > > This would also mean that the equality comparisons with KFREE_MAX_BATCH
> > > > > > need to become greater-or-equal comparisons or some such.
> > > > > 
> > > > > Yes, certainly we can do these kinds of improvements after this patch, and
> > > > > then add more tests to validate the improvements.
> > > > 
> > > > Out of pity for people bisecting, we need this fixed up front.
> > > > 
> > > > My suggestion is to just allow ->head to grow until ->head_free becomes
> > > > available.  That way you are looping with interrupts and preemption
> > > > enabled in workqueue context, which is much less damaging than doing so
> > > > with interrupts disabled, and possibly even from hard-irq context.
> > > 
> > > Agree.
> > > 
> > > Or after introducing another limit like KFREE_MAX_BATCH_FORCE(>=
> > > KFREE_MAX_BATCH):
> > > 
> > > 1. Try to drain it on hitting KFREE_MAX_BATCH as it does.
> > > 
> > >    On success: Same as now.
> > >    On fail: let ->head grow and drain if possible, until reaching to
> > >             KFREE_MAX_BATCH_FORCE.
> > > 
> > > 3. On hitting KFREE_MAX_BATCH_FORCE, give up batching but handle one by
> > >    one from now on to prevent too many pending requests from being
> > >    queued for batching work.
> > 
> > I also agree. But this _FORCE thing will still not solve the issue Paul is
> > raising which is doing this loop possibly in irq disabled / hardirq context.
> > We can't even cond_resched() here. In fact since _FORCE is larger, it will be
> > even worse. Consider a real-time system with a lot of memory, in this case
> > letting ->head grow large is Ok, but looping for long time in IRQ disabled
> > would not be Ok.
> > 
> > But I could make it something like:
> > 1. Letting ->head grow if ->head_free busy
> > 2. If head_free is busy, then just queue/requeue the monitor to try again.
> > 
> > This would even improve performance, but will still risk going out of memory.
> 
> It seems I can indeed hit an out of memory condition once I changed it to
> "letting list grow" (diff is below which applies on top of this patch) while
> at the same time removing the schedule_timeout(2) and replacing it with
> cond_resched() in the rcuperf test.  I think the reason is the rcuperf test
> starves the worker threads that are executing in workqueue context after a
> grace period and those are unable to get enough CPU time to kfree things fast
> enough. But I am not fully sure about it and need to test/trace more to
> figure out why this is happening.
> 
> If I add back the schedule_uninterruptibe_timeout(2) call, the out of memory
> situation goes away.
> 
> Clearly we need to do more work on this patch.
> 
> In the regular kfree_rcu_no_batch() case, I don't hit this issue. I believe
> that since the kfree is happening in softirq context in the _no_batch() case,
> it fares better. The question then I guess is how do we run the rcu_work in a
> higher priority context so it is not starved and runs often enough. I'll
> trace more.
> 
> Perhaps I can also lower the priority of the rcuperf threads to give the
> worker thread some more room to run and see if anything changes. But I am not
> sure then if we're preparing the code for the real world with such
> modifications.
> 
> Any thoughts?

Several!  With luck, perhaps some are useful.  ;-)

o	Increase the memory via kvm.sh "--memory 1G" or more.  The
	default is "--memory 500M".

o	Leave a CPU free to run things like the RCU grace-period kthread.
	You might also need to bind that kthread to that CPU.

o	Alternatively, use the "rcutree.kthread_prio=" boot parameter to
	boost the RCU kthreads to real-time priority.  This won't do
	anything for ksoftirqd, though.

o	Along with the above boot parameter, use "rcutree.use_softirq=0"
	to cause RCU to use kthreads instead of softirq.  (You might well
	find issues in priority setting as well, but might as well find
	them now if so!)

o	With any of the above, invoke rcu_momentary_dyntick_idle() along
	with cond_resched() in your kfree_rcu() loop.  This simulates
	a trip to userspace for nohz_full CPUs, so if this helps for
	non-nohz_full CPUs, adjustments to the kernel might be called for.

Probably others, but this should do for a start.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> ---8<-----------------------
> 
> >From 098d62e5a1b84a11139236c9b1f59e7f32289b40 Mon Sep 17 00:00:00 2001
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Date: Thu, 8 Aug 2019 16:29:58 -0400
> Subject: [PATCH] Let list grow
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcuperf.c |  2 +-
>  kernel/rcu/tree.c    | 52 +++++++++++++++++++-------------------------
>  2 files changed, 23 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 34658760da5e..7dc831db89ae 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -654,7 +654,7 @@ kfree_perf_thread(void *arg)
>  			}
>  		}
>  
> -		schedule_timeout_uninterruptible(2);
> +		cond_resched();
>  	} while (!torture_must_stop() && ++l < kfree_loops);
>  
>  	kfree(alloc_ptrs);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bdbd483606ce..bab77220d8ac 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2595,7 +2595,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
>  
>  
>  /* Maximum number of jiffies to wait before draining batch */
> -#define KFREE_DRAIN_JIFFIES 50
> +#define KFREE_DRAIN_JIFFIES (HZ / 20)
>  
>  /*
>   * Maximum number of kfree(s) to batch, if limit is hit
> @@ -2684,27 +2684,19 @@ static void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krc,
>  {
>  	struct rcu_head *head, *next;
>  
> -	/* It is time to do bulk reclaim after grace period */
> -	krc->monitor_todo = false;
> +	/* It is time to do bulk reclaim after grace period. */
>  	if (queue_kfree_rcu_work(krc)) {
>  		spin_unlock_irqrestore(&krc->lock, flags);
>  		return;
>  	}
>  
> -	/*
> -	 * Use non-batch regular call_rcu for kfree_rcu in case things are too
> -	 * busy and batching of kfree_rcu could not be used.
> -	 */
> -	head = krc->head;
> -	krc->head = NULL;
> -	krc->kfree_batch_len = 0;
> -	spin_unlock_irqrestore(&krc->lock, flags);
> -
> -	for (; head; head = next) {
> -		next = head->next;
> -		head->next = NULL;
> -		__call_rcu(head, head->func, -1, 1);
> +	/* Previous batch did not get free yet, let us try again soon. */
> +	if (krc->monitor_todo == false) {
> +		schedule_delayed_work_on(smp_processor_id(),
> +				&krc->monitor_work,  KFREE_DRAIN_JIFFIES/4);
> +		krc->monitor_todo = true;
>  	}
> +	spin_unlock_irqrestore(&krc->lock, flags);
>  }
>  
>  /*
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 

