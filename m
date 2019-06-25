Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BB5C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7F6208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfFYNZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:25:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbfFYNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:25:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PDHbGQ053055;
        Tue, 25 Jun 2019 09:24:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tbk6241m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 09:24:35 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5PDHlRT054117;
        Tue, 25 Jun 2019 09:24:34 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tbk6241kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 09:24:34 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5PDK5Dd008348;
        Tue, 25 Jun 2019 13:24:33 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 2t9by6ra34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 13:24:33 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5PDOWUG49152280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 13:24:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E405B206A;
        Tue, 25 Jun 2019 13:24:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50090B2064;
        Tue, 25 Jun 2019 13:24:32 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 13:24:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4328E16C179D; Tue, 25 Jun 2019 06:24:32 -0700 (PDT)
Date:   Tue, 25 Jun 2019 06:24:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [RFC] rcu: Warn that rcu ktheads cannot be spawned
Message-ID: <20190625132432.GU26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <1561364852-5113-1-git-send-email-byungchul.park@lge.com>
 <20190624164624.GA41314@google.com>
 <20190625025015.GB10912@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625025015.GB10912@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:50:15AM +0900, Byungchul Park wrote:
> On Mon, Jun 24, 2019 at 12:46:24PM -0400, Joel Fernandes wrote:
> > On Mon, Jun 24, 2019 at 05:27:32PM +0900, Byungchul Park wrote:
> > > Hello rcu folks,
> > > 
> > > I thought it'd better to announce it if those spawnings fail because of
> > > !rcu_scheduler_fully_active.
> > > 
> > > Of course, with the current code, it never happens though.
> > > 
> > > Thoughts?
> > 
> > It seems in the right spirit, but with your patch a warning always fires.
> > rcu_prepare_cpu() is called multiple times, once from rcu_init() and then
> > from hotplug paths.
> 
> I'm sorry bothering you.
> 
> I sent the patch to ask how you guys think about the direction coz I'm
> not sure if the current code w/o warning on it is intended or not.
> 
> However from now on, I think I need to test it first even if it's RFC :)

That is what I do.  ;-)

							Thanx, Paul

> Thank you very much for the information.
> 
> Thanks,
> Byungchul
> 
> > Warning splat stack looks like:
> > 
> > [    0.398767] Call Trace:                                                                                                        
> > [    0.398775]  rcu_init+0x6aa/0x724                                             
> > [    0.398779]  start_kernel+0x220/0x4a2                                    
> > [    0.398780]  ? copy_bootdata+0x12/0xac                                                                                                                                   
> > [    0.398782]  secondary_startup_64+0xa4/0xb0    
> > 
> > 
> > > 
> > > Thanks,
> > > Byungchul
> > > 
> > > ---8<---
> > > From 58a33a85c70f82c406319b4752af95cf6ceb73a3 Mon Sep 17 00:00:00 2001
> > > From: Byungchul Park <byungchul.park@lge.com>
> > > Date: Mon, 24 Jun 2019 17:08:26 +0900
> > > Subject: [RFC] rcu: Warn that rcu ktheads cannot be spawned
> > > 
> > > In case that rcu ktheads cannot be spawned due to
> > > !rcu_scheduler_fully_active, it'd be better to anounce it.
> > > 
> > > While at it, because the return value of rcu_spawn_one_boost_kthread()
> > > is not used any longer, changed the return type from int to void.
> > > 
> > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > ---
> > >  kernel/rcu/tree_plugin.h | 31 +++++++++++++++++++------------
> > >  1 file changed, 19 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 1102765..7d74193 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -1131,7 +1131,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
> > >   * already exist.  We only create this kthread for preemptible RCU.
> > >   * Returns zero if all is well, a negated errno otherwise.
> > >   */
> > > -static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > > +static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > >  {
> > >  	int rnp_index = rnp - rcu_get_root();
> > >  	unsigned long flags;
> > > @@ -1139,25 +1139,24 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > >  	struct task_struct *t;
> > >  
> > >  	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> > > -		return 0;
> > > +		return;
> > >  
> > > -	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
> > > -		return 0;
> > > +	if (rcu_rnp_online_cpus(rnp) == 0)
> > > +		return;
> > >  
> > >  	rcu_state.boost = 1;
> > >  	if (rnp->boost_kthread_task != NULL)
> > > -		return 0;
> > > +		return;
> > >  	t = kthread_create(rcu_boost_kthread, (void *)rnp,
> > >  			   "rcub/%d", rnp_index);
> > >  	if (IS_ERR(t))
> > > -		return PTR_ERR(t);
> > > +		return;
> > >  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > >  	rnp->boost_kthread_task = t;
> > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  	sp.sched_priority = kthread_prio;
> > >  	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> > >  	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
> > > -	return 0;
> > >  }
> > >  
> > >  static void rcu_cpu_kthread_setup(unsigned int cpu)
> > > @@ -1264,8 +1263,12 @@ static void __init rcu_spawn_boost_kthreads(void)
> > >  		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
> > >  	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__))
> > >  		return;
> > > +
> > > +	if (WARN_ON(!rcu_scheduler_fully_active))
> > > +		return;
> > > +
> > >  	rcu_for_each_leaf_node(rnp)
> > > -		(void)rcu_spawn_one_boost_kthread(rnp);
> > > +		rcu_spawn_one_boost_kthread(rnp);
> > >  }
> > >  
> > >  static void rcu_prepare_kthreads(int cpu)
> > > @@ -1273,9 +1276,11 @@ static void rcu_prepare_kthreads(int cpu)
> > >  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > >  	struct rcu_node *rnp = rdp->mynode;
> > >  
> > > +	if (WARN_ON(!rcu_scheduler_fully_active))
> > > +		return;
> > > +
> > >  	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
> > > -	if (rcu_scheduler_fully_active)
> > > -		(void)rcu_spawn_one_boost_kthread(rnp);
> > > +	rcu_spawn_one_boost_kthread(rnp);
> > >  }
> > >  
> > >  #else /* #ifdef CONFIG_RCU_BOOST */
> > > @@ -2198,8 +2203,10 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
> > >   */
> > >  static void rcu_spawn_cpu_nocb_kthread(int cpu)
> > >  {
> > > -	if (rcu_scheduler_fully_active)
> > > -		rcu_spawn_one_nocb_kthread(cpu);
> > > +	if (WARN_ON(!rcu_scheduler_fully_active))
> > > +		return;
> > > +
> > > +	rcu_spawn_one_nocb_kthread(cpu);
> > >  }
> > >  
> > >  /*
> > > -- 
> > > 1.9.1
> > > 
> 
