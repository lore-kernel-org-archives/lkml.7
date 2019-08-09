Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2EDC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168D9214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437095AbfHIQdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:33:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406775AbfHIQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:33:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79GXB8R114636
        for <linux-kernel@vger.kernel.org>; Fri, 9 Aug 2019 12:33:51 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u9cd1g5tm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 12:33:51 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 9 Aug 2019 17:33:50 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 9 Aug 2019 17:33:46 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x79GXjOj24052074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Aug 2019 16:33:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6461DB2067;
        Fri,  9 Aug 2019 16:33:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B21EB205F;
        Fri,  9 Aug 2019 16:33:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  9 Aug 2019 16:33:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CD4A816C9A29; Fri,  9 Aug 2019 09:33:46 -0700 (PDT)
Date:   Fri, 9 Aug 2019 09:33:46 -0700
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
 <20190809151619.GD28441@linux.ibm.com>
 <20190809153924.GB211412@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809153924.GB211412@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080916-0060-0000-0000-0000036B59CE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011575; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01244392; UDB=6.00656519; IPR=6.01025874;
 MB=3.00028109; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-09 16:33:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080916-0061-0000-0000-00004A7D3341
Message-Id: <20190809163346.GF28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 11:39:24AM -0400, Joel Fernandes wrote:
> On Fri, Aug 09, 2019 at 08:16:19AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 08, 2019 at 07:30:14PM -0400, Joel Fernandes wrote:
> [snip]
> > > > But I could make it something like:
> > > > 1. Letting ->head grow if ->head_free busy
> > > > 2. If head_free is busy, then just queue/requeue the monitor to try again.
> > > > 
> > > > This would even improve performance, but will still risk going out of memory.
> > > 
> > > It seems I can indeed hit an out of memory condition once I changed it to
> > > "letting list grow" (diff is below which applies on top of this patch) while
> > > at the same time removing the schedule_timeout(2) and replacing it with
> > > cond_resched() in the rcuperf test.  I think the reason is the rcuperf test
> > > starves the worker threads that are executing in workqueue context after a
> > > grace period and those are unable to get enough CPU time to kfree things fast
> > > enough. But I am not fully sure about it and need to test/trace more to
> > > figure out why this is happening.
> > > 
> > > If I add back the schedule_uninterruptibe_timeout(2) call, the out of memory
> > > situation goes away.
> > > 
> > > Clearly we need to do more work on this patch.
> > > 
> > > In the regular kfree_rcu_no_batch() case, I don't hit this issue. I believe
> > > that since the kfree is happening in softirq context in the _no_batch() case,
> > > it fares better. The question then I guess is how do we run the rcu_work in a
> > > higher priority context so it is not starved and runs often enough. I'll
> > > trace more.
> > > 
> > > Perhaps I can also lower the priority of the rcuperf threads to give the
> > > worker thread some more room to run and see if anything changes. But I am not
> > > sure then if we're preparing the code for the real world with such
> > > modifications.
> > > 
> > > Any thoughts?
> > 
> > Several!  With luck, perhaps some are useful.  ;-)
> > 
> > o	Increase the memory via kvm.sh "--memory 1G" or more.  The
> > 	default is "--memory 500M".
> 
> Thanks, this definitely helped.
> 
> > o	Leave a CPU free to run things like the RCU grace-period kthread.
> > 	You might also need to bind that kthread to that CPU.
> > 
> > o	Alternatively, use the "rcutree.kthread_prio=" boot parameter to
> > 	boost the RCU kthreads to real-time priority.  This won't do
> > 	anything for ksoftirqd, though.
> 
> I will try these as well.
> 
> > 
> > o	Along with the above boot parameter, use "rcutree.use_softirq=0"
> > 	to cause RCU to use kthreads instead of softirq.  (You might well
> > 	find issues in priority setting as well, but might as well find
> > 	them now if so!)
> 
> Doesn't think one actually reduce the priority of the core RCU work? softirq
> will always have higher priority than any there. So wouldn't that have the
> effect of not reclaiming things fast enough? (Or, in my case not scheduling
> the rcu_work which does the reclaim).

For low kfree_rcu() loads, yes, it increases overhead due to the need
for context switches instead of softirq running at the tail end of an
interrupt.  But for high kfree_rcu() loads, it gets you realtime priority
(in conjunction with "rcutree.kthread_prio=", that is).

> > o	With any of the above, invoke rcu_momentary_dyntick_idle() along
> > 	with cond_resched() in your kfree_rcu() loop.  This simulates
> > 	a trip to userspace for nohz_full CPUs, so if this helps for
> > 	non-nohz_full CPUs, adjustments to the kernel might be called for.
> 
> Ok, will try it.
> 
> Save these bullet points for future reference! ;-)  thanks,

I guess this is helping me to prepare for Plumbers.  ;-)

							Thanx, Paul

>  - Joel
> 
> 
> > 
> > Probably others, but this should do for a start.
> > 
> > 							Thanx, Paul
> > 
> > > thanks,
> > > 
> > >  - Joel
> > > 
> > > ---8<-----------------------
> > > 
> > > >From 098d62e5a1b84a11139236c9b1f59e7f32289b40 Mon Sep 17 00:00:00 2001
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > Date: Thu, 8 Aug 2019 16:29:58 -0400
> > > Subject: [PATCH] Let list grow
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/rcuperf.c |  2 +-
> > >  kernel/rcu/tree.c    | 52 +++++++++++++++++++-------------------------
> > >  2 files changed, 23 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > > index 34658760da5e..7dc831db89ae 100644
> > > --- a/kernel/rcu/rcuperf.c
> > > +++ b/kernel/rcu/rcuperf.c
> > > @@ -654,7 +654,7 @@ kfree_perf_thread(void *arg)
> > >  			}
> > >  		}
> > >  
> > > -		schedule_timeout_uninterruptible(2);
> > > +		cond_resched();
> > >  	} while (!torture_must_stop() && ++l < kfree_loops);
> > >  
> > >  	kfree(alloc_ptrs);
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index bdbd483606ce..bab77220d8ac 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2595,7 +2595,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
> > >  
> > >  
> > >  /* Maximum number of jiffies to wait before draining batch */
> > > -#define KFREE_DRAIN_JIFFIES 50
> > > +#define KFREE_DRAIN_JIFFIES (HZ / 20)
> > >  
> > >  /*
> > >   * Maximum number of kfree(s) to batch, if limit is hit
> > > @@ -2684,27 +2684,19 @@ static void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krc,
> > >  {
> > >  	struct rcu_head *head, *next;
> > >  
> > > -	/* It is time to do bulk reclaim after grace period */
> > > -	krc->monitor_todo = false;
> > > +	/* It is time to do bulk reclaim after grace period. */
> > >  	if (queue_kfree_rcu_work(krc)) {
> > >  		spin_unlock_irqrestore(&krc->lock, flags);
> > >  		return;
> > >  	}
> > >  
> > > -	/*
> > > -	 * Use non-batch regular call_rcu for kfree_rcu in case things are too
> > > -	 * busy and batching of kfree_rcu could not be used.
> > > -	 */
> > > -	head = krc->head;
> > > -	krc->head = NULL;
> > > -	krc->kfree_batch_len = 0;
> > > -	spin_unlock_irqrestore(&krc->lock, flags);
> > > -
> > > -	for (; head; head = next) {
> > > -		next = head->next;
> > > -		head->next = NULL;
> > > -		__call_rcu(head, head->func, -1, 1);
> > > +	/* Previous batch did not get free yet, let us try again soon. */
> > > +	if (krc->monitor_todo == false) {
> > > +		schedule_delayed_work_on(smp_processor_id(),
> > > +				&krc->monitor_work,  KFREE_DRAIN_JIFFIES/4);
> > > +		krc->monitor_todo = true;
> > >  	}
> > > +	spin_unlock_irqrestore(&krc->lock, flags);
> > >  }
> > >  
> > >  /*
> > > -- 
> > > 2.23.0.rc1.153.gdeed80330f-goog
> > > 
> > 
> 

