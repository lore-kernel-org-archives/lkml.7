Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF4C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7FD206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfGAUMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:12:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbfGAUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:12:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61KBedP110465
        for <linux-kernel@vger.kernel.org>; Mon, 1 Jul 2019 16:12:19 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfp83f8p8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 16:12:18 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Jul 2019 21:12:17 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 21:12:14 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61KCDIA47579440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 20:12:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D4E5B2064;
        Mon,  1 Jul 2019 20:12:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50BF1B205F;
        Mon,  1 Jul 2019 20:12:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 20:12:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6B41816C2BD7; Mon,  1 Jul 2019 13:12:16 -0700 (PDT)
Date:   Mon, 1 Jul 2019 13:12:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v3] rcu: Change return type of
 rcu_spawn_one_boost_kthread()
Reply-To: paulmck@linux.ibm.com
References: <1561941639-14318-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561941639-14318-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070120-0072-0000-0000-000004432C59
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011361; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226043; UDB=6.00645426; IPR=6.01007256;
 MB=3.00027541; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-01 20:12:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070120-0073-0000-0000-00004CB36361
Message-Id: <20190701201216.GQ26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:40:39AM +0900, Byungchul Park wrote:
> Hello,
> 
> I tested again if the WARN_ON_ONCE() is fired with my box.
> 
> And it was OK.
> 
> Thanks,
> Byungchul

And it now applies just fine, so I have queued it, thank you!

In the future, could you please use something like "git send-email"
to email a proper patch?  When you do it this way, after I do "git am",
I have to hand-edit the commit to remove this preamble.

But while I was doing the hand-editing, I updated the commit log as
follows:

	rcu: Change return type of rcu_spawn_one_boost_kthread()

	The return value of rcu_spawn_one_boost_kthread() is not used
	any longer.  This commit therefore changes its return type from
	int to void, and removes the cast to void from its callers.

Does that work for you?

						Thanx, Paul

> Changes from v2
> -. Port the patch to a1af11a24cb0 (Paul's request)
> -. Add a few new lines for a better look
> 
> Changes from v1
> -. WARN_ON_ONCE() on failing to create rcu_boost_kthread.
> -. Changed title and commit message a bit.
> 
> ---8<---
> >From 20c934c5657a7a0f13ebb050ffd350d4174965d0 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul.park@lge.com>
> Date: Mon, 1 Jul 2019 09:27:15 +0900
> Subject: [PATCH v3] rcu: Change return type of rcu_spawn_one_boost_kthread()
> 
> The return value of rcu_spawn_one_boost_kthread() is not used any
> longer. Change return type of that function from int to void.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/rcu/tree_plugin.h | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c588ef9..b8eea22 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1119,7 +1119,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
>   * already exist.  We only create this kthread for preemptible RCU.
>   * Returns zero if all is well, a negated errno otherwise.
>   */
> -static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> +static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  {
>  	int rnp_index = rnp - rcu_get_root();
>  	unsigned long flags;
> @@ -1127,25 +1127,27 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  	struct task_struct *t;
>  
>  	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> -		return 0;
> +		return;
>  
>  	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
> -		return 0;
> +		return;
>  
>  	rcu_state.boost = 1;
> +
>  	if (rnp->boost_kthread_task != NULL)
> -		return 0;
> +		return;
> +
>  	t = kthread_create(rcu_boost_kthread, (void *)rnp,
>  			   "rcub/%d", rnp_index);
> -	if (IS_ERR(t))
> -		return PTR_ERR(t);
> +	if (WARN_ON_ONCE(IS_ERR(t)))
> +		return;
> +
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	rnp->boost_kthread_task = t;
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	sp.sched_priority = kthread_prio;
>  	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
>  	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
> -	return 0;
>  }
>  
>  /*
> @@ -1186,7 +1188,7 @@ static void __init rcu_spawn_boost_kthreads(void)
>  	struct rcu_node *rnp;
>  
>  	rcu_for_each_leaf_node(rnp)
> -		(void)rcu_spawn_one_boost_kthread(rnp);
> +		rcu_spawn_one_boost_kthread(rnp);
>  }
>  
>  static void rcu_prepare_kthreads(int cpu)
> @@ -1196,7 +1198,7 @@ static void rcu_prepare_kthreads(int cpu)
>  
>  	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
>  	if (rcu_scheduler_fully_active)
> -		(void)rcu_spawn_one_boost_kthread(rnp);
> +		rcu_spawn_one_boost_kthread(rnp);
>  }
>  
>  #else /* #ifdef CONFIG_RCU_BOOST */
> -- 
> 1.9.1
> 

