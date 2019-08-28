Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B41DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F502339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567029431;
	bh=pBsVFoWXbDsglTmnog1lSV4o1jCIEQxKlF1nYS4V9QM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KAeDjOOPB+ClZ+TVM/DrsGzZ1B05RIdp7eEkt6KaqckEMfeHpPlqVfCzZxErDy9u8
	 LfyfCrKIxiYHMijxDI1FyoN230byAozQQE4yTbtrZOreuFADsHxJiqBjJ2OvWJ1lL4
	 xhQkFhkE55/SHO1meWATHPMu+CKLq4J3x/jCxtZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfH1V5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:57:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726875AbfH1V5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:57:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SLpnN0091141;
        Wed, 28 Aug 2019 17:56:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2up0etjs4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:56:36 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SLq4T3091562;
        Wed, 28 Aug 2019 17:56:36 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2up0etjs42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:56:36 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SLtUCi019288;
        Wed, 28 Aug 2019 21:56:35 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 2un65k2fq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 21:56:35 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SLuYsa46596428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 21:56:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61240B2068;
        Wed, 28 Aug 2019 21:56:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32D6AB205F;
        Wed, 28 Aug 2019 21:56:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 21:56:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0929316C65C1; Wed, 28 Aug 2019 14:56:36 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:56:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH 5/5] rcu: Remove kfree_call_rcu_nobatch()
Message-ID: <20190828215636.GA26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d657e3b.1c69fb81.54250.01e2@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d657e3b.1c69fb81.54250.01e2@mx.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:01:59PM -0400, Joel Fernandes (Google) wrote:
> Now that kfree_rcu() special casing have been removed from tree RCU,
> remove kfree_call_rcu_nobatch() since it is not needed.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Now -this- one qualifies as a nice negative delta!  ;-)

A few things below, please fix in next version.

							Thanx, Paul

> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ---
>  include/linux/rcutiny.h                       |  5 ---
>  include/linux/rcutree.h                       |  1 -
>  kernel/rcu/rcuperf.c                          | 10 +-----
>  kernel/rcu/tree.c                             | 33 ++++++++-----------
>  5 files changed, 14 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 24fe8aefb12c..56be0e30100b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3909,10 +3909,6 @@
>  			Number of loops doing rcuperf.kfree_alloc_num number
>  			of allocations and frees.
>  
> -	rcuperf.kfree_no_batch= [KNL]
> -			Use the non-batching (less efficient) version of kfree_rcu().
> -			This is useful for comparing with the batched version.
> -
>  	rcuperf.nreaders= [KNL]
>  			Set number of RCU readers.  The value -1 selects
>  			N, where N is the number of CPUs.  A value
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 949841f52ec5..7aa93afa5d8d 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -39,11 +39,6 @@ static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	call_rcu(head, func);
>  }
>  
> -static inline void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
> -{
> -	call_rcu(head, func);
> -}
> -
>  void rcu_qs(void);
>  
>  static inline void rcu_softirq_qs(void)
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 961b7e05d141..0b68aa952f8b 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -34,7 +34,6 @@ static inline void rcu_virt_note_context_switch(int cpu)
>  
>  void synchronize_rcu_expedited(void);
>  void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> -void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
>  
>  void rcu_barrier(void);
>  bool rcu_eqs_special_set(int cpu);
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index c1e25fd10f2a..da94b89cd531 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -593,7 +593,6 @@ rcu_perf_shutdown(void *arg)
>  torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
>  torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
>  torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> -torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu().");
>  
>  static struct task_struct **kfree_reader_tasks;
>  static int kfree_nrealthreads;
> @@ -632,14 +631,7 @@ kfree_perf_thread(void *arg)
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> -			if (!kfree_no_batch) {
> -				kfree_rcu(alloc_ptr, rh);
> -			} else {
> -				rcu_callback_t cb;
> -
> -				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> -				kfree_call_rcu_nobatch(&(alloc_ptr->rh), cb);
> -			}
> +			kfree_rcu(alloc_ptr, rh);
>  		}
>  
>  		cond_resched();
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 12c17e10f2b4..c767973d62ac 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2777,8 +2777,10 @@ static void kfree_rcu_work(struct work_struct *work)
>  		rcu_lock_acquire(&rcu_callback_map);
>  		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
>  
> -		/* Could be possible to optimize with kfree_bulk in future */
> -		kfree((void *)head - offset);
> +		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset))) {
> +			/* Could be optimized with kfree_bulk() in future. */
> +			kfree((void *)head - offset);
> +		}

This really needs to be in the previous patch until such time as Tiny RCU
no longer needs the restriction.

>  		rcu_lock_release(&rcu_callback_map);
>  		cond_resched_tasks_rcu_qs();
> @@ -2856,16 +2858,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  		spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  
> -/*
> - * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
> - * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
> - */
> -void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
> -{
> -	__call_rcu(head, func);
> -}
> -EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
> -
>  /*
>   * Queue a request for lazy invocation of kfree() after a grace period.
>   *
> @@ -2885,12 +2877,6 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
>  
> -	/* kfree_call_rcu() batching requires timers to be up. If the scheduler
> -	 * is not yet up, just skip batching and do the non-batched version.
> -	 */
> -	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
> -		return kfree_call_rcu_nobatch(head, func);
> -
>  	if (debug_rcu_head_queue(head)) {
>  		/* Probable double kfree_rcu() */
>  		WARN_ONCE(1, "kfree_call_rcu(): Double-freed call. rcu_head %p\n",
> @@ -2909,8 +2895,15 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	krcp->head = head;
>  
>  	/* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
> -	if (!xchg(&krcp->monitor_todo, true))
> -		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +	if (!xchg(&krcp->monitor_todo, true)) {
> +		/* Scheduling the monitor requires scheduler/timers to be up,
> +		 * if it is not, just skip it. An eventual kfree_rcu() will
> +		 * kick it again.
> +		 */
> +		if ((rcu_scheduler_active == RCU_SCHEDULER_RUNNING)) {
> +			schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +		}
> +	}

And this also needs to be in an earlier patch.  Bisectability and all that!

Are we really guaranteed that there will be an eventual kfree_rcu()?
More of a worry for Tiny RCU than for Tree RCU, but still could be
annoying for someone trying to debug a memory leak.

							Thanx, Paul

>  	spin_unlock(&krcp->lock);
>  	local_irq_restore(flags);
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
