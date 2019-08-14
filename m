Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BF2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8132067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfHNXCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 19:02:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728492AbfHNXCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:02:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EN2QhJ039871
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 19:02:30 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uct00k1ys-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 19:02:30 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 15 Aug 2019 00:02:28 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Aug 2019 00:02:23 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7EN2M1p53019042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 23:02:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43E2EB2064;
        Wed, 14 Aug 2019 23:02:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15799B205F;
        Wed, 14 Aug 2019 23:02:22 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Aug 2019 23:02:22 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3356A16C0600; Wed, 14 Aug 2019 16:02:24 -0700 (PDT)
Date:   Wed, 14 Aug 2019 16:02:24 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] rcu/tree: Add basic support for kfree_rcu batching
Reply-To: paulmck@linux.ibm.com
References: <20190813170046.81707-1-joel@joelfernandes.org>
 <20190813190738.GH28441@linux.ibm.com>
 <20190814143817.GA253999@google.com>
 <20190814172233.GA68498@google.com>
 <20190814184429.GV28441@linux.ibm.com>
 <20190814223413.GB69375@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814223413.GB69375@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081423-0064-0000-0000-00000408B383
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011591; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01246896; UDB=6.00658035; IPR=6.01028403;
 MB=3.00028177; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-14 23:02:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081423-0065-0000-0000-00003EABDDFC
Message-Id: <20190814230224.GB28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 06:34:13PM -0400, Joel Fernandes wrote:
> On Wed, Aug 14, 2019 at 11:44:29AM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 14, 2019 at 01:22:33PM -0400, Joel Fernandes wrote:
> > > On Wed, Aug 14, 2019 at 10:38:17AM -0400, Joel Fernandes wrote:
> > > > On Tue, Aug 13, 2019 at 12:07:38PM -0700, Paul E. McKenney wrote:
> > >  [snip]
> > > > > > - * Queue an RCU callback for lazy invocation after a grace period.
> > > > > > - * This will likely be later named something like "call_rcu_lazy()",
> > > > > > - * but this change will require some way of tagging the lazy RCU
> > > > > > - * callbacks in the list of pending callbacks. Until then, this
> > > > > > - * function may only be called from __kfree_rcu().
> > > > > > + * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
> > > > > > + * kfree(s) is queued for freeing after a grace period, right away.
> > > > > >   */
> > > > > > -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > > > +struct kfree_rcu_cpu {
> > > > > > +	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> > > > > > +	 * is done after a grace period.
> > > > > > +	 */
> > > > > > +	struct rcu_work rcu_work;
> > > > > > +
> > > > > > +	/* The list of objects being queued in a batch but are not yet
> > > > > > +	 * scheduled to be freed.
> > > > > > +	 */
> > > > > > +	struct rcu_head *head;
> > > > > > +
> > > > > > +	/* The list of objects that have now left ->head and are queued for
> > > > > > +	 * freeing after a grace period.
> > > > > > +	 */
> > > > > > +	struct rcu_head *head_free;
> > > > > 
> > > > > So this is not yet the one that does multiple batches concurrently
> > > > > awaiting grace periods, correct?  Or am I missing something subtle?
> > > > 
> > > > Yes, it is not. I honestly, still did not understand that idea. Or how it
> > > > would improve things. May be we can discuss at LPC on pen and paper? But I
> > > > think that can also be a follow-up optimization.
> > > 
> > > I got it now. Basically we can benefit a bit more by having another list
> > > (that is have multiple kfree_rcu batches in flight). I will think more about
> > > it - but hopefully we don't need to gate this patch by that.
> > 
> > I am willing to take this as a later optimization.
> > 
> > > It'll be interesting to see what rcuperf says about such an improvement :)
> > 
> > Indeed, no guarantees either way.  The reason for hope assumes a busy
> > system where each grace period is immediately followed by another
> > grace period.  On such a system, the current setup allows each CPU to
> > make use only of every second grace period for its kfree_rcu() work.
> > The hope would therefore be that this would reduce the memory footprint
> > substantially with no increase in overhead.
> 
> Good news! I was able to bring down memory foot print by almost 30% by adding
> another batch. Below is the patch. Thanks for the suggestion!

Nice!

> I can add this as a patch on top of the initial one, for easier review.

Yes, please!

> The memory consumed drops from 300-350MB to 200-250MB. Increasing
> KFREE_N_BATCHES did not cause a reduction in memory, though.

OK, good to know.

						Thanx, Paul

> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] WIP: Multiple batches
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 58 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1d1847cadea2..a272c893dbdc 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2596,26 +2596,35 @@ EXPORT_SYMBOL_GPL(call_rcu);
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
> +	struct kfree_rcu_cpu *krc;
> +};
> +static DEFINE_PER_CPU(__typeof__(struct kfree_rcu_work)[KFREE_N_BATCHES], krw);
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
> +	struct kfree_rcu_work *krw;
>  
>  	/* Protect concurrent access to this structure. */
>  	spinlock_t lock;
> @@ -2638,12 +2647,15 @@ static void kfree_rcu_work(struct work_struct *work)
>  {
>  	unsigned long flags;
>  	struct rcu_head *head, *next;
> -	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
> -					struct kfree_rcu_cpu, rcu_work);
> +	struct kfree_rcu_work *krw = container_of(to_rcu_work(work),
> +					struct kfree_rcu_work, rcu_work);
> +	struct kfree_rcu_cpu *krcp;
> +
> +	krcp = krw->krc;
>  
>  	spin_lock_irqsave(&krcp->lock, flags);
> -	head = krcp->head_free;
> -	krcp->head_free = NULL;
> +	head = krw->head_free;
> +	krw->head_free = NULL;
>  	spin_unlock_irqrestore(&krcp->lock, flags);
>  
>  	/*
> @@ -2666,19 +2678,30 @@ static void kfree_rcu_work(struct work_struct *work)
>   */
>  static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  {
> +	int i = 0;
> +	struct kfree_rcu_work *krw = NULL;
> +
>  	lockdep_assert_held(&krcp->lock);
> +	while (i < KFREE_N_BATCHES) {
> +		if (!krcp->krw[i].head_free) {
> +			krw = &(krcp->krw[i]);
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
> -	if (krcp->head_free)
> +	if (!krw)
>  		return false;
>  
> -	krcp->head_free = krcp->head;
> +	krw->head_free = krcp->head;
> +	krw->krc = krcp;   /* Should need to do only once, optimize later. */
>  	krcp->head = NULL;
> -	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
> -	queue_rcu_work(system_wq, &krcp->rcu_work);
> +	INIT_RCU_WORK(&krw->rcu_work, kfree_rcu_work);
> +	queue_rcu_work(system_wq, &krw->rcu_work);
>  
>  	return true;
>  }
> @@ -3631,6 +3654,7 @@ static void __init kfree_rcu_batch_init(void)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		spin_lock_init(&krcp->lock);
> +		krcp->krw = &(per_cpu(krw, cpu)[0]);
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
>  	}
>  }
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 

