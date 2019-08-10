Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780DAC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 03:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3A2217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 03:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHJDjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 23:39:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbfHJDjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 23:39:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7A3acmB095213;
        Fri, 9 Aug 2019 23:38:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u9jq5wamp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 23:38:16 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7A3bJBf096238;
        Fri, 9 Aug 2019 23:38:16 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u9jq5wamg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 23:38:16 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7A3Z7G3026958;
        Sat, 10 Aug 2019 03:38:15 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 2u9nj605ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Aug 2019 03:38:15 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7A3cFIm45285766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Aug 2019 03:38:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FAE8B2066;
        Sat, 10 Aug 2019 03:38:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEE2DB205F;
        Sat, 10 Aug 2019 03:38:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 10 Aug 2019 03:38:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EBC8F16C9A73; Fri,  9 Aug 2019 20:38:14 -0700 (PDT)
Date:   Fri, 9 Aug 2019 20:38:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190810033814.GP28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190810024232.GA183658@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810024232.GA183658@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908100038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 10:42:32PM -0400, Joel Fernandes wrote:
> On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> [snip] 
> > > > > @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
> > > > >  {
> > > > >  	int cpu;
> > > > >  
> > > > > +	kfree_rcu_batch_init();
> > > > 
> > > > What happens if someone does a kfree_rcu() before this point?  It looks
> > > > like it should work, but have you tested it?
> > > > 
> > > > >  	rcu_early_boot_tests();
> > > > 
> > > > For example, by testing it in rcu_early_boot_tests() and moving the
> > > > call to kfree_rcu_batch_init() here.
> > > 
> > > I have not tried to do the kfree_rcu() this early. I will try it out.
> > 
> > Yeah, well, call_rcu() this early came as a surprise to me back in the
> > day, so...  ;-)
> 
> I actually did get surprised as well!
> 
> It appears the timers are not fully initialized so the really early
> kfree_rcu() call from rcu_init() does cause a splat about an initialized
> timer spinlock (even though future kfree_rcu()s and the system are working
> fine all the way into the torture tests).
> 
> I think to resolve this, we can just not do batching until early_initcall,
> during which I have an initialization function which switches batching on.
> >From that point it is safe.

Just go ahead and batch, but don't bother with the timer until
after single-threaded boot is done.  For example, you could check
rcu_scheduler_active similar to how sync_rcu_exp_select_cpus() does.
(See kernel/rcu/tree_exp.h.)

If needed, use an early_initcall() to handle the case where early boot
kfree_rcu() calls needed to set the timer but could not.

> Below is the diff on top of this patch, I think this should be good but let
> me know if anything looks odd to you. I tested it and it works.

Keep in mind that a call_rcu() callback can't possibly be invoked until
quite some time after the scheduler is up and running.  So it will be
a lot simpler to just skip setting the timer during early boot.

							Thanx, Paul

> have a great weekend! thanks,
> -Joel
> 
> ---8<-----------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a09ef81a1a4f..358f5c065fa4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2634,6 +2634,7 @@ struct kfree_rcu_cpu {
>  };
>  
>  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
> +int kfree_rcu_batching_ready;
>  
>  /*
>   * This function is invoked in workqueue context after a grace period.
> @@ -2742,6 +2743,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  		spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  
> +/*
> + * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
> + * Used only by rcuperf torture test for comparison with kfree_rcu_batch()
> + * or during really early init.
> + */
> +void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
> +{
> +	__call_rcu(head, func, -1, 1);
> +}
> +EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
> +
>  /*
>   * Queue a request for lazy invocation of kfree() after a grace period.
>   *
> @@ -2764,6 +2775,10 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
>  	bool monitor_todo;
> +	static int once;
> +
> +	if (!READ_ONCE(kfree_rcu_batching_ready))
> +		return kfree_call_rcu_nobatch(head, func);
>  
>  	local_irq_save(flags);
>  	krcp = this_cpu_ptr(&krc);
> @@ -2794,16 +2809,6 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  }
>  EXPORT_SYMBOL_GPL(kfree_call_rcu);
>  
> -/*
> - * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
> - * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
> - */
> -void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
> -{
> -	__call_rcu(head, func, -1, 1);
> -}
> -EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
> -
>  /*
>   * During early boot, any blocking grace-period wait automatically
>   * implies a grace period.  Later on, this is never the case for PREEMPT.
> @@ -3650,17 +3655,6 @@ static void __init rcu_dump_rcu_node_tree(void)
>  	pr_cont("\n");
>  }
>  
> -void kfree_rcu_batch_init(void)
> -{
> -	int cpu;
> -
> -	for_each_possible_cpu(cpu) {
> -		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> -		spin_lock_init(&krcp->lock);
> -		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> -	}
> -}
> -
>  struct workqueue_struct *rcu_gp_wq;
>  struct workqueue_struct *rcu_par_gp_wq;
>  
> @@ -3668,8 +3662,6 @@ void __init rcu_init(void)
>  {
>  	int cpu;
>  
> -	kfree_rcu_batch_init();
> -
>  	rcu_early_boot_tests();
>  
>  	rcu_bootup_announce();
> @@ -3700,6 +3692,21 @@ void __init rcu_init(void)
>  	srcu_init();
>  }
>  
> +static int __init kfree_rcu_batch_init(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> +		spin_lock_init(&krcp->lock);
> +		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> +	}
> +
> +	WRITE_ONCE(kfree_rcu_batching_ready, 1);
> +	return 0;
> +}
> +early_initcall(kfree_rcu_batch_init);
> +
>  #include "tree_stall.h"
>  #include "tree_exp.h"
>  #include "tree_plugin.h"
