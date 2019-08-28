Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DE8C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA9D2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567025203;
	bh=Vp9GJhlKPZJ6sn5fDW45gmN3TG/A2V9LB+lsWb0hdJc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=t2x5kro+BDoNZa+rZaIMdKmbklDQoY2bfppLaaABdz2WD7N1qV4xBvV18GseWAJzN
	 vfHQPdDwyE2ycyF5TbACRaZDnJUaq35O2uWAIBvARK+sKbP/a9a1PF7YDO/Ri2iuqu
	 d1jP/a4FU08rqy091LtsZYV8PAJ+RlQ9i9KJiBC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfH1Uqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:46:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbfH1Uql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:46:41 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SKjxDq051985;
        Wed, 28 Aug 2019 16:46:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unys2a4q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 16:46:07 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SKk563052512;
        Wed, 28 Aug 2019 16:46:05 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unys2a4c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 16:46:04 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SKYLdl017202;
        Wed, 28 Aug 2019 20:45:20 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 2ujvv6r40n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 20:45:20 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SKjKPV53739936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 20:45:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42310B2065;
        Wed, 28 Aug 2019 20:45:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 124DFB205F;
        Wed, 28 Aug 2019 20:45:20 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 20:45:20 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CD7D816C1700; Wed, 28 Aug 2019 13:45:21 -0700 (PDT)
Date:   Wed, 28 Aug 2019 13:45:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH v2] rcu/tree: Add multiple in-flight batches of kfree_rcu
 work
Message-ID: <20190828204521.GU26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d657e35.1c69fb81.54250.01de@mx.google.com>
 <20190828140952.258739-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828140952.258739-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:09:52AM -0400, Joel Fernandes (Google) wrote:
> During testing, it was observed that amount of memory consumed due
> kfree_rcu() batching is 300-400MB. Previously we had only a single
> head_free pointer pointing to the list of rcu_head(s) that are to be
> freed after a grace period. Until this list is drained, we cannot queue
> any more objects on it since such objects may not be ready to be
> reclaimed when the worker thread eventually gets to drainin g the
> head_free list.
> 
> We can do better by maintaining multiple lists as done by this patch.
> Testing shows that memory consumption came down by around 100-150MB with
> just adding another list. Adding more than 1 additional list did not
> show any improvement.

Nice!  A few comments below.  Please address them and post a full v3.
(I am off the next two days, and I guarantee you that upon return I will
mix and match the wrong patches otherwise!)

> Suggested-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 61 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4f7c3096d786..5bf8f7e793ea 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2688,28 +2688,37 @@ EXPORT_SYMBOL_GPL(call_rcu);
>  
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (HZ / 50)
> +#define KFREE_N_BATCHES 2
> +
> +struct kfree_rcu_work {
> +	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> +	 * is done after a grace period.
> +	 */
> +	struct rcu_work rcu_work;
> +
> +	/* The list of objects that have now left ->head and are queued for
> +	 * freeing after a grace period.
> +	 */
> +	struct rcu_head *head_free;
> +
> +	struct kfree_rcu_cpu *krcp;
> +};
>  
>  /*
>   * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
>   * kfree(s) is queued for freeing after a grace period, right away.
>   */
>  struct kfree_rcu_cpu {
> -	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> -	 * is done after a grace period.
> -	 */
> -	struct rcu_work rcu_work;
>  
>  	/* The list of objects being queued in a batch but are not yet
>  	 * scheduled to be freed.
>  	 */
>  	struct rcu_head *head;
>  
> -	/* The list of objects that have now left ->head and are queued for
> -	 * freeing after a grace period.
> -	 */
> -	struct rcu_head *head_free;
> +	/* Pointer to the per-cpu array of kfree_rcu_work structures */
> +	struct kfree_rcu_work krw_arr[KFREE_N_BATCHES];
>  
> -	/* Protect concurrent access to this structure. */
> +	/* Protect concurrent access to this structure and kfree_rcu_work. */
>  	spinlock_t lock;
>  
>  	/* The delayed work that flushes ->head to ->head_free incase ->head
> @@ -2730,12 +2739,14 @@ static void kfree_rcu_work(struct work_struct *work)
>  {
>  	unsigned long flags;
>  	struct rcu_head *head, *next;
> -	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
> -					struct kfree_rcu_cpu, rcu_work);
> +	struct kfree_rcu_work *krwp = container_of(to_rcu_work(work),
> +					struct kfree_rcu_work, rcu_work);
> +	struct kfree_rcu_cpu *krcp;
> +
> +	krcp = krwp->krcp;
>  
>  	spin_lock_irqsave(&krcp->lock, flags);
> -	head = krcp->head_free;
> -	krcp->head_free = NULL;
> +	head = xchg(&krwp->head_free, NULL);

Given that we hold the lock, why the xchg()?  Alternatively, why not
just acquire the lock in the other places you use xchg()?  This is a
per-CPU lock, so contention should not be a problem, should it?

>  	spin_unlock_irqrestore(&krcp->lock, flags);
>  
>  	/*
> @@ -2758,19 +2769,28 @@ static void kfree_rcu_work(struct work_struct *work)
>   */
>  static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  {
> +	int i = 0;
> +	struct kfree_rcu_work *krwp = NULL;
> +
>  	lockdep_assert_held(&krcp->lock);
> +	while (i < KFREE_N_BATCHES) {
> +		if (!krcp->krw_arr[i].head_free) {
> +			krwp = &(krcp->krw_arr[i]);
> +			break;
> +		}
> +		i++;
> +	}
>  
> -	/* If a previous RCU batch work is already in progress, we cannot queue
> +	/* If both RCU batches are already in progress, we cannot queue
>  	 * another one, just refuse the optimization and it will be retried
>  	 * again in KFREE_DRAIN_JIFFIES time.
>  	 */

If you are going to remove the traditional first "/*" line of a comment,
why not go all the way and cut the last one as well?  "//".

> -	if (krcp->head_free)
> +	if (!krwp)
>  		return false;
>  
> -	krcp->head_free = krcp->head;
> -	krcp->head = NULL;
> -	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
> -	queue_rcu_work(system_wq, &krcp->rcu_work);
> +	krwp->head_free = xchg(&krcp->head, NULL);

This isn't anywhere near a fastpath, so just acquiring the lock is a
better choice here.

> +	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
> +	queue_rcu_work(system_wq, &krwp->rcu_work);
>  
>  	return true;
>  }
> @@ -3736,8 +3756,11 @@ static void __init kfree_rcu_batch_init(void)
>  
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> +		int i = KFREE_N_BATCHES;
>  
>  		spin_lock_init(&krcp->lock);
> +		while (i--)
> +			krcp->krw_arr[i].krcp = krcp;

This was indeed a nice trick back in the PDP-11 days of 64-kilobyte
address spaces, so thank you for the nostalgia!  However, a straight-up
"for" loop is less vulnerable to code being added between the declaration
of "i" and the "while" loop.

>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
>  	}
>  }
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
