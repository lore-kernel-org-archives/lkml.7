Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79CDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852C220896
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfCXXlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:41:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbfCXXlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:41:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2ONcUIH072625
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 19:41:21 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2reb0m9x1f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 19:41:21 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 24 Mar 2019 23:41:20 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 24 Mar 2019 23:41:16 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2ONfFwo18415816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Mar 2019 23:41:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6346FB205F;
        Sun, 24 Mar 2019 23:41:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3595DB2064;
        Sun, 24 Mar 2019 23:41:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 24 Mar 2019 23:41:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 86F1E16C2DE1; Sun, 24 Mar 2019 16:42:11 -0700 (PDT)
Date:   Sun, 24 Mar 2019 16:42:11 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3] rcu: Allow to eliminate softirq processing from
 rcutree
Reply-To: paulmck@linux.ibm.com
References: <20190320161500.GK4102@linux.ibm.com>
 <20190320163532.mr32oi53iaueuizw@linutronix.de>
 <20190320173001.GM4102@linux.ibm.com>
 <20190320175952.yh6yfy64vaiurszw@linutronix.de>
 <20190320181210.GO4102@linux.ibm.com>
 <20190320181435.x3qyutwqllmq5zbk@linutronix.de>
 <20190320211333.eq7pwxnte7la67ph@linutronix.de>
 <20190322234819.GA99360@google.com>
 <20190323002519.GV4102@linux.ibm.com>
 <20190323161002.GA17112@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323161002.GA17112@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032423-0068-0000-0000-000003AA6BB3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010809; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01179187; UDB=6.00617002; IPR=6.00959897;
 MB=3.00026141; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-24 23:41:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032423-0069-0000-0000-000047ECBB2E
Message-Id: <20190324234211.GA28064@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-24_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903240181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 09:10:02AM -0700, Paul E. McKenney wrote:
> On Fri, Mar 22, 2019 at 05:25:19PM -0700, Paul E. McKenney wrote:
> > On Fri, Mar 22, 2019 at 07:48:19PM -0400, Joel Fernandes wrote:
> > > On Wed, Mar 20, 2019 at 10:13:33PM +0100, Sebastian Andrzej Siewior wrote:
> > > > Running RCU out of softirq is a problem for some workloads that would
> > > > like to manage RCU core processing independently of other softirq
> > > > work, for example, setting kthread priority.  This commit therefore
> > > > introduces the `rcunosoftirq' option which moves the RCU core work
> > > > from softirq to a per-CPU/per-flavor SCHED_OTHER kthread named rcuc.
> > > > The SCHED_OTHER approach avoids the scalability problems that appeared
> > > > with the earlier attempt to move RCU core processing to from softirq
> > > > to kthreads.  That said, kernels built with RCU_BOOST=y will run the
> > > > rcuc kthreads at the RCU-boosting priority.
> > > [snip]
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 0f31b79eb6761..05a1e42fdaf10 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -51,6 +51,12 @@
> > > >  #include <linux/tick.h>
> > > >  #include <linux/sysrq.h>
> > > >  #include <linux/kprobes.h>
> > > > +#include <linux/gfp.h>
> > > > +#include <linux/oom.h>
> > > > +#include <linux/smpboot.h>
> > > > +#include <linux/jiffies.h>
> > > > +#include <linux/sched/isolation.h>
> > > > +#include "../time/tick-internal.h"
> > > >  
> > > >  #include "tree.h"
> > > >  #include "rcu.h"
> > > > @@ -92,6 +98,9 @@ struct rcu_state rcu_state = {
> > > >  /* Dump rcu_node combining tree at boot to verify correct setup. */
> > > >  static bool dump_tree;
> > > >  module_param(dump_tree, bool, 0444);
> > > > +/* Move RCU_SOFTIRQ to rcuc kthreads. */
> > > > +static bool use_softirq = 1;
> > > > +module_param(use_softirq, bool, 0444);
> > > >  /* Control rcu_node-tree auto-balancing at boot time. */
> > > >  static bool rcu_fanout_exact;
> > > >  module_param(rcu_fanout_exact, bool, 0444);
> > > > @@ -2253,7 +2262,7 @@ void rcu_force_quiescent_state(void)
> > > >  EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
> > > >  
> > > >  /* Perform RCU core processing work for the current CPU.  */
> > > > -static __latent_entropy void rcu_core(struct softirq_action *unused)
> > > > +static __latent_entropy void rcu_core(void)
> > > >  {
> > > >  	unsigned long flags;
> > > >  	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
> > > > @@ -2295,6 +2304,34 @@ static __latent_entropy void rcu_core(struct softirq_action *unused)
> > > >  	trace_rcu_utilization(TPS("End RCU core"));
> > > >  }
> > > >  
> > > > +static void rcu_core_si(struct softirq_action *h)
> > > > +{
> > > > +	rcu_core();
> > > > +}
> > > > +
> > > > +static void rcu_wake_cond(struct task_struct *t, int status)
> > > > +{
> > > > +	/*
> > > > +	 * If the thread is yielding, only wake it when this
> > > > +	 * is invoked from idle
> > > > +	 */
> > > > +	if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)))
> > > > +		wake_up_process(t);
> > > > +}
> > > > +
> > > > +static void invoke_rcu_core_kthread(void)
> > > > +{
> > > > +	struct task_struct *t;
> > > > +	unsigned long flags;
> > > > +
> > > > +	local_irq_save(flags);
> > > > +	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
> > > > +	t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
> > > > +	if (t != NULL && t != current)
> > > > +		rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
> > > > +	local_irq_restore(flags);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Schedule RCU callback invocation.  If the running implementation of RCU
> > > >   * does not support RCU priority boosting, just do a direct call, otherwise
> > > > @@ -2306,19 +2343,95 @@ static void invoke_rcu_callbacks(struct rcu_data *rdp)
> > > >  {
> > > >  	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
> > > >  		return;
> > > > -	if (likely(!rcu_state.boost)) {
> > > > -		rcu_do_batch(rdp);
> > > > -		return;
> > > > -	}
> > > > -	invoke_rcu_callbacks_kthread();
> > > > +	if (rcu_state.boost || !use_softirq)
> > > > +		invoke_rcu_core_kthread();
> > > > +	rcu_do_batch(rdp);
> > > 
> > > Shouldn't there be an else before the rcu_do_batch? If we are waking up the
> > > rcuc thread, then that will do the rcu_do_batch when it runs right?
> > > 
> > > Something like:
> > > 	if (rcu_state.boost || !use_softirq)
> > > 		invoke_rcu_core_kthread();
> > > 	else
> > > 		rcu_do_batch(rdp);
> > > 
> > > Previous code similarly had a return; also.
> > 
> > I believe that you are correct, so I will give it a shot.  Good eyes!
> 
> Yet rcutorture disagrees.  Actually, if we are using rcuc kthreads, this
> is only ever invoked from within tha thread, so the only check we need is
> for the scheduler being operational.  I am therefore trying this one out.
> 
> Thoughts?

And rcutorture likes this one, though at this point this function should
be pulled into its sole callsite.  ;-)

							Thanx, Paul

> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 76d6c0902f66..8d6ebc0944ec 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2333,18 +2333,16 @@ static void invoke_rcu_core_kthread(void)
>  }
>  
>  /*
> - * Schedule RCU callback invocation.  If the running implementation of RCU
> - * does not support RCU priority boosting, just do a direct call, otherwise
> - * wake up the per-CPU kernel kthread.  Note that because we are running
> - * on the current CPU with softirqs disabled, the rcu_cpu_kthread_task
> - * cannot disappear out from under us.
> + * Do RCU callback invocation.  Not that if we are running !use_softirq,
> + * we are already in the rcuc kthread.  If callbacks are offloaded, then
> + * ->cblist is always empty, so we don't get here.  Therefore, we only
> + * ever need to check for the scheduler being operational (some callbacks
> + * do wakeups, so we do need the scheduler).
>   */
>  static void invoke_rcu_callbacks(struct rcu_data *rdp)
>  {
>  	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
>  		return;
> -	if (rcu_state.boost || !use_softirq)
> -		invoke_rcu_core_kthread();
>  	rcu_do_batch(rdp);
>  }
>  

