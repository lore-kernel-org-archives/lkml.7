Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF394C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59402086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfHPRZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:25:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbfHPRZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:25:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GHPVZb001123
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 13:25:36 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udxshd1u3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 13:25:34 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 16 Aug 2019 18:25:33 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Aug 2019 18:25:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7GHPTOW51118444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 17:25:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF942B205F;
        Fri, 16 Aug 2019 17:25:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A347CB2064;
        Fri, 16 Aug 2019 17:25:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 17:25:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7ECB416C28A9; Fri, 16 Aug 2019 10:25:29 -0700 (PDT)
Date:   Fri, 16 Aug 2019 10:25:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [PATCH -rcu dev 1/3] rcu/tree: tick_dep_set/clear_cpu should
 accept bits instead of masks
Reply-To: paulmck@linux.ibm.com
References: <20190816025311.241257-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816025311.241257-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081617-2213-0000-0000-000003BCB00B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011600; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01247738; UDB=6.00658543; IPR=6.01029248;
 MB=3.00028203; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-16 17:25:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081617-2214-0000-0000-00005FABA701
Message-Id: <20190816172529.GU28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:53:09PM -0400, Joel Fernandes (Google) wrote:
> This commit fixes the issue.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And I am squashing these into their respective commits with attribution.
Good eyes, thank you very much!!!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0512de9ead20..322b1b57967c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -829,7 +829,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>  		   !rdp->dynticks_nmi_nesting &&
>  		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
>  		rdp->rcu_forced_tick = true;
> -		tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> +		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
>  	}
>  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
>  			  rdp->dynticks_nmi_nesting,
> @@ -898,7 +898,7 @@ void rcu_irq_enter_irqson(void)
>  void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
>  {
>  	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
> -		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> +		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
>  		rdp->rcu_forced_tick = false;
>  	}
>  }
> @@ -2123,8 +2123,9 @@ int rcutree_dead_cpu(unsigned int cpu)
>  	do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
>  
>  	// Stop-machine done, so allow nohz_full to disable tick.
> -	for_each_online_cpu(c)
> -		tick_dep_clear_cpu(c, TICK_DEP_MASK_RCU);
> +	for_each_online_cpu(c) {
> +		tick_dep_clear_cpu(c, TICK_DEP_BIT_RCU);
> +	}
>  	return 0;
>  }
>  
> @@ -2175,8 +2176,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	rcu_nocb_unlock_irqrestore(rdp, flags);
>  
>  	/* Invoke callbacks. */
> -	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
> -		tick_dep_set_task(current, TICK_DEP_MASK_RCU);
> +	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
> +		tick_dep_set_task(current, TICK_DEP_BIT_RCU);
> +	}
>  	rhp = rcu_cblist_dequeue(&rcl);
>  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>  		debug_rcu_head_unqueue(rhp);
> @@ -2243,8 +2245,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	/* Re-invoke RCU core processing if there are callbacks remaining. */
>  	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
>  		invoke_rcu_core();
> -	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
> -		tick_dep_clear_task(current, TICK_DEP_MASK_RCU);
> +	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
> +		tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
> +	}
>  }
>  
>  /*
> @@ -3118,8 +3121,9 @@ int rcutree_online_cpu(unsigned int cpu)
>  	rcutree_affinity_setting(cpu, -1);
>  
>  	// Stop-machine done, so allow nohz_full to disable tick.
> -	for_each_online_cpu(c)
> -		tick_dep_clear_cpu(c, TICK_DEP_MASK_RCU);
> +	for_each_online_cpu(c) {
> +		tick_dep_clear_cpu(c, TICK_DEP_BIT_RCU);
> +	}
>  	return 0;
>  }
>  
> @@ -3143,8 +3147,9 @@ int rcutree_offline_cpu(unsigned int cpu)
>  	rcutree_affinity_setting(cpu, cpu);
>  
>  	// nohz_full CPUs need the tick for stop-machine to work quickly
> -	for_each_online_cpu(c)
> -		tick_dep_set_cpu(c, TICK_DEP_MASK_RCU);
> +	for_each_online_cpu(c) {
> +		tick_dep_set_cpu(c, TICK_DEP_BIT_RCU);
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 

