Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE2C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F0320659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfGBIpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:45:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbfGBIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:45:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x628gOiO106364;
        Tue, 2 Jul 2019 04:45:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tg346t8fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 04:45:04 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x628j4OB114350;
        Tue, 2 Jul 2019 04:45:04 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tg346t8eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 04:45:04 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x628eNlO007482;
        Tue, 2 Jul 2019 08:45:02 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01wdc.us.ibm.com with ESMTP id 2tdym6muks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 08:45:02 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x628j2rO46203150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jul 2019 08:45:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80B18B2066;
        Tue,  2 Jul 2019 08:45:02 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CAB7B2073;
        Tue,  2 Jul 2019 08:45:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.179.41])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jul 2019 08:45:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6A91D16C5E27; Tue,  2 Jul 2019 01:45:02 -0700 (PDT)
Date:   Tue, 2 Jul 2019 01:45:02 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v3] rcu: Change return type of
 rcu_spawn_one_boost_kthread()
Message-ID: <20190702084502.GL26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <1561941639-14318-1-git-send-email-byungchul.park@lge.com>
 <20190701201216.GQ26519@linux.ibm.com>
 <20190702051103.GA13132@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702051103.GA13132@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 02:11:03PM +0900, Byungchul Park wrote:
> On Mon, Jul 01, 2019 at 01:12:16PM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 01, 2019 at 09:40:39AM +0900, Byungchul Park wrote:
> > > Hello,
> > > 
> > > I tested again if the WARN_ON_ONCE() is fired with my box.
> > > 
> > > And it was OK.
> > > 
> > > Thanks,
> > > Byungchul
> > 
> > And it now applies just fine, so I have queued it, thank you!
> > 
> > In the future, could you please use something like "git send-email"
> > to email a proper patch?  When you do it this way, after I do "git am",
> > I have to hand-edit the commit to remove this preamble.
> 
> Oh! Sorry to hear that. I've been always using "git send-email" with
> scissors in the body expecting you do "git am -c". Do you mean it's not
> a good way, right? I won't use the scissors again.

Ah.  First I have heard of the "-c" argument to "git am".  OK, now that
I know, feel free to continue sending me scissored patches, and thank
you for calling my attention to this feature!

Actually, I just updated my git config to make "-c" the default.  That
way I don't have to remember.  ;-)

							Thanx, Paul

> > But while I was doing the hand-editing, I updated the commit log as
> > follows:
> > 
> > 	rcu: Change return type of rcu_spawn_one_boost_kthread()
> > 
> > 	The return value of rcu_spawn_one_boost_kthread() is not used
> > 	any longer.  This commit therefore changes its return type from
> > 	int to void, and removes the cast to void from its callers.
> > 
> > Does that work for you?
> 
> Sure. Thank you.
> 
> Thanks,
> Byungchul
> 
> > 						Thanx, Paul
> > 
> > > Changes from v2
> > > -. Port the patch to a1af11a24cb0 (Paul's request)
> > > -. Add a few new lines for a better look
> > > 
> > > Changes from v1
> > > -. WARN_ON_ONCE() on failing to create rcu_boost_kthread.
> > > -. Changed title and commit message a bit.
> > > 
> > > ---8<---
> > > >From 20c934c5657a7a0f13ebb050ffd350d4174965d0 Mon Sep 17 00:00:00 2001
> > > From: Byungchul Park <byungchul.park@lge.com>
> > > Date: Mon, 1 Jul 2019 09:27:15 +0900
> > > Subject: [PATCH v3] rcu: Change return type of rcu_spawn_one_boost_kthread()
> > > 
> > > The return value of rcu_spawn_one_boost_kthread() is not used any
> > > longer. Change return type of that function from int to void.
> > > 
> > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > ---
> > >  kernel/rcu/tree_plugin.h | 20 +++++++++++---------
> > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index c588ef9..b8eea22 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -1119,7 +1119,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
> > >   * already exist.  We only create this kthread for preemptible RCU.
> > >   * Returns zero if all is well, a negated errno otherwise.
> > >   */
> > > -static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > > +static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > >  {
> > >  	int rnp_index = rnp - rcu_get_root();
> > >  	unsigned long flags;
> > > @@ -1127,25 +1127,27 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > >  	struct task_struct *t;
> > >  
> > >  	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> > > -		return 0;
> > > +		return;
> > >  
> > >  	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
> > > -		return 0;
> > > +		return;
> > >  
> > >  	rcu_state.boost = 1;
> > > +
> > >  	if (rnp->boost_kthread_task != NULL)
> > > -		return 0;
> > > +		return;
> > > +
> > >  	t = kthread_create(rcu_boost_kthread, (void *)rnp,
> > >  			   "rcub/%d", rnp_index);
> > > -	if (IS_ERR(t))
> > > -		return PTR_ERR(t);
> > > +	if (WARN_ON_ONCE(IS_ERR(t)))
> > > +		return;
> > > +
> > >  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > >  	rnp->boost_kthread_task = t;
> > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  	sp.sched_priority = kthread_prio;
> > >  	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> > >  	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
> > > -	return 0;
> > >  }
> > >  
> > >  /*
> > > @@ -1186,7 +1188,7 @@ static void __init rcu_spawn_boost_kthreads(void)
> > >  	struct rcu_node *rnp;
> > >  
> > >  	rcu_for_each_leaf_node(rnp)
> > > -		(void)rcu_spawn_one_boost_kthread(rnp);
> > > +		rcu_spawn_one_boost_kthread(rnp);
> > >  }
> > >  
> > >  static void rcu_prepare_kthreads(int cpu)
> > > @@ -1196,7 +1198,7 @@ static void rcu_prepare_kthreads(int cpu)
> > >  
> > >  	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
> > >  	if (rcu_scheduler_fully_active)
> > > -		(void)rcu_spawn_one_boost_kthread(rnp);
> > > +		rcu_spawn_one_boost_kthread(rnp);
> > >  }
> > >  
> > >  #else /* #ifdef CONFIG_RCU_BOOST */
> > > -- 
> > > 1.9.1
> > > 
> 
