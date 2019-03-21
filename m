Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F569C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F06D21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfCUNv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:51:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727857AbfCUNvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:51:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LDhsk9076841
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:51:24 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rc96yfx08-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:51:23 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 21 Mar 2019 13:51:24 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Mar 2019 13:51:21 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2LDpIud20512950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 13:51:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85EBAB205F;
        Thu, 21 Mar 2019 13:51:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58444B2064;
        Thu, 21 Mar 2019 13:51:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 21 Mar 2019 13:51:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D82E516C34EE; Thu, 21 Mar 2019 06:52:09 -0700 (PDT)
Date:   Thu, 21 Mar 2019 06:52:09 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, tglx@linutronix.de,
        Mike Galbraith <bitbucket@online.de>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Allow to eliminate softirq processing from rcutree
Reply-To: paulmck@linux.ibm.com
References: <20190315111130.4902-1-bigeasy@linutronix.de>
 <20190320002613.GA129907@google.com>
 <20190320112835.prq22vsto3ecckff@linutronix.de>
 <20190321120656.GA61489@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321120656.GA61489@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032113-0052-0000-0000-0000039F2C89
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177566; UDB=6.00616021; IPR=6.00958261;
 MB=3.00026091; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-21 13:51:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032113-0053-0000-0000-0000603AF489
Message-Id: <20190321135209.GT4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903210098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 08:06:56AM -0400, Joel Fernandes wrote:
> On Wed, Mar 20, 2019 at 12:28:35PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-03-19 20:26:13 [-0400], Joel Fernandes wrote:
> > > > @@ -2769,19 +2782,121 @@ static void invoke_rcu_callbacks(struct rcu_data *rdp)
> > > >  {
> > > >  	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
> > > >  		return;
> > > > -	if (likely(!rcu_state.boost)) {
> > > > -		rcu_do_batch(rdp);
> > > > -		return;
> > > > -	}
> > > > -	invoke_rcu_callbacks_kthread();
> > > > +	rcu_do_batch(rdp);
> > > 
> > > Looks like a nice change, but one question...
> > > 
> > > Consider the case where rcunosoftirq boot option is not passed.
> > > 
> > > Before, if RCU_BOOST=y, then callbacks would be invoked in rcuc threads if
> > > possible, by those threads being woken up from within the softirq context
> > > (in invoke_rcu_callbacks).
> > > 
> > > Now, if RCU_BOOST=y, then callbacks would only be invoked in softirq context
> > > and not in the threads at all. Because rcu_softirq_enabled = false, so the
> > > path executes:
> > >   rcu_read_unlock_special() ->
> > >         raise_softirq_irqsoff() ->
> > >                 rcu_process_callbacks_si() ->
> > >                         rcu_process_callbacks() ->
> > >                                 invoke_rcu_callbacks() ->
> > >                                         rcu_do_batch()
> > > 
> > > This seems like a behavioral change to me. This makes the callbacks always
> > > execute from the softirq context and not the threads when boosting is
> > > configured. IMO in the very least, such behavioral change should be
> > > documented in the change.
> > > 
> > > One way to fix this I think could be, if boosting is enabled, then set
> > > rcu_softirq_enabled to false by default so the callbacks are still executed
> > > in the rcuc threads.
> > > 
> > > Did I miss something? Sorry if I did, thanks!
> > 
> > So with all the swaps and reorder we talking about this change:
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 0a719f726e149..82810483bfc6c 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2306,20 +2306,6 @@ static void rcu_core_si(struct softirq_action *h)
> >  	rcu_core();
> >  }
> >  
> > -/*
> > - * Schedule RCU callback invocation.  If the running implementation of RCU
> > - * does not support RCU priority boosting, just do a direct call, otherwise
> > - * wake up the per-CPU kernel kthread.  Note that because we are running
> > - * on the current CPU with softirqs disabled, the rcu_cpu_kthread_task
> > - * cannot disappear out from under us.
> > - */
> > -static void invoke_rcu_callbacks(struct rcu_data *rdp)
> > -{
> > -	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
> > -		return;
> > -	rcu_do_batch(rdp);
> > -}
> > -
> >  static void rcu_wake_cond(struct task_struct *t, int status)
> >  {
> >  	/*
> > @@ -2330,6 +2316,19 @@ static void rcu_wake_cond(struct task_struct *t, int status)
> >  		wake_up_process(t);
> >  }
> >  
> > +static void invoke_rcu_core_kthread(void)
> > +{
> > +	struct task_struct *t;
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
> > +	t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
> > +	if (t != NULL && t != current)
> > +		rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
> > +	local_irq_restore(flags);
> > +}
> > +
> >  static bool rcu_softirq_enabled = true;
> >  
> >  static int __init rcunosoftirq_setup(char *str)
> > @@ -2339,26 +2338,33 @@ static int __init rcunosoftirq_setup(char *str)
> >  }
> >  __setup("rcunosoftirq", rcunosoftirq_setup);
> >  
> > +/*
> > + * Schedule RCU callback invocation.  If the running implementation of RCU
> > + * does not support RCU priority boosting, just do a direct call, otherwise
> > + * wake up the per-CPU kernel kthread.  Note that because we are running
> > + * on the current CPU with softirqs disabled, the rcu_cpu_kthread_task
> > + * cannot disappear out from under us.
> > + */
> > +static void invoke_rcu_callbacks(struct rcu_data *rdp)
> > +{
> > +	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
> > +		return;
> > +	if (rcu_state.boost || rcu_softirq_enabled)
> > +		invoke_rcu_core_kthread();
> 
> Here shouldn't it be this?
> 	if (rcu_state.boost || !rcu_softirq_enabled)
> 
> Also the rcu/dev branch has the following hunk where we unconditionally
> invoke rcu_do_batch even when boosting which would still have the issue I
> pointed. I would suggest Sebastian to post the latest v4 or v5 with all diff
> squashed, and then we do another round of review with latest patch, thanks!

I believe that -rcu has this change.  But it looks like there still are
failures, so yes, further review is necessary and deeply appreciated!

							Thanx, Paul

> 	@@ -2306,18 +2320,110 @@ static void invoke_rcu_callbacks(struct rcu_data *rdp)
>  {
>  	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
>  		return;
> -	if (likely(!rcu_state.boost)) {
> -		rcu_do_batch(rdp);
> -		return;
> -	}
> -	invoke_rcu_callbacks_kthread();
> +	rcu_do_batch(rdp);
> +}
> +
> 
> thanks,
> 
>  - Joel
> 
> 
> > +	rcu_do_batch(rdp);
> > +}
> > +
> >  /*
> >   * Wake up this CPU's rcuc kthread to do RCU core processing.
> >   */
> >  static void invoke_rcu_core(void)
> >  {
> > -	unsigned long flags;
> > -	struct task_struct *t;
> > -
> >  	if (!cpu_online(smp_processor_id()))
> >  		return;
> > -	if (rcu_softirq_enabled) {
> > +	if (rcu_softirq_enabled)
> >  		raise_softirq(RCU_SOFTIRQ);
> > -	} else {
> > -		local_irq_save(flags);
> > -		__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
> > -		t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
> > -		if (t != NULL && t != current)
> > -			rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
> > -		local_irq_restore(flags);
> > -	}
> > +	else
> > +		invoke_rcu_core_kthread();
> >  }
> >  
> >  static void rcu_cpu_kthread_park(unsigned int cpu)
> > @@ -2426,7 +2432,8 @@ static int __init rcu_spawn_core_kthreads(void)
> >  		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
> >  	if (!IS_ENABLED(CONFIG_RCU_BOOST) && !rcu_softirq_enabled)
> >  		return 0;
> > -	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__);
> > +	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec),
> > +		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
> >  	return 0;
> >  }
> >  early_initcall(rcu_spawn_core_kthreads);
> > -- 
> > 2.20.1
> > 
> > >  - Joel
> > 
> > Sebastian
> 

