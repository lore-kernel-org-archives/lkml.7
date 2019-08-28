Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2394C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C37217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567023344;
	bh=966BrQrsdCJCCMocMLQhHr3852AfA4kfcckyfobWd14=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=IomlC2eU/Vzv1pWroz3qf5roD4R7It5nA+bVgA2jB5tyI5uvdgbD4uKVvYBMaok6+
	 eVk2TdcFANcstA2OvWwQdxhmHnEPPmEwy84OmiMieAdvwZdHv06r5uZLlfiomjVdb/
	 IthctG6bTzJr9dnvbJmIqdcCC3Eyi6wxzdZs74S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfH1UPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:15:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfH1UPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:15:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SKC9hG061262;
        Wed, 28 Aug 2019 16:15:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unwebx6bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 16:13:45 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SKDiPr064791;
        Wed, 28 Aug 2019 16:13:44 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unwebx6be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 16:13:44 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SK9xIl028283;
        Wed, 28 Aug 2019 20:13:43 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 2unb3syxe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 20:13:43 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SKDgBn38338942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 20:13:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9ABAB2065;
        Wed, 28 Aug 2019 20:13:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7998DB205F;
        Wed, 28 Aug 2019 20:13:42 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 20:13:42 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3893516C65DE; Wed, 28 Aug 2019 13:13:44 -0700 (PDT)
Date:   Wed, 28 Aug 2019 13:13:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 1/2] rcu/tree: Clean up dynticks counter usage
Message-ID: <20190828201344.GR26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d648895.1c69fb81.5e60a.fc6f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d648895.1c69fb81.5e60a.fc6f@mx.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 09:33:53PM -0400, Joel Fernandes (Google) wrote:
> The dynticks counter are confusing due to crowbar writes of
> DYNTICK_IRQ_NONIDLE whose purpose is to detect half-interrupts (i.e. we
> see rcu_irq_enter() but not rcu_irq_exit() due to a usermode upcall) and
> if so then do a reset of the dyntick_nmi_nesting counters. This patch
> tries to get rid of DYNTICK_IRQ_NONIDLE while still keeping the code
> working, fully functional, and less confusing. The confusion recently
> has even led to patches forgetting that DYNTICK_IRQ_NONIDLE was written
> to which wasted lots of time.
> 
> The patch has the following changes:
> 
> (1) Use dynticks_nesting instead of dynticks_nmi_nesting for determining
> outer most "EQS exit". This is needed to detect in
> rcu_nmi_enter_common() if we have already EQS-exited, such as because of
> a syscall. Currently we rely on a forced write of DYNTICK_IRQ_NONIDLE
> from rcu_eqs_exit() for this purpose. This is one purpose of the
> DYNTICK_IRQ_NONIDLE write (other than detecting half-interrupts).
> However, we do not need to do that. dyntick_nesting already tells us that
> we have EQS-exited so just use that thus removing the dependence of
> dynticks_nmi_nesting for this purpose.
> 
> (2) Keep dynticks_nmi_nesting around because:
> 
>   (a) rcu_is_cpu_rrupt_from_idle() needs to be able to detect first
>       interrupt nesting level.
> 
>   (b) We need to detect half-interrupts till we are sure they're not an
>       issue. However, change the comparison to DYNTICK_IRQ_NONIDLE with 0.
> 
> (3) Since we got rid of DYNTICK_IRQ_NONIDLE, we also do cheaper
> comparisons with zero instead for the code that keeps the tick on in
> rcu_nmi_enter_common().
> 
> In the next patch, both of the concerns of (2) will be addressed and
> then we can get rid of dynticks_nmi_nesting, however one step at a time.

Postponing discussion of the commit log for the moment.

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcu.h  |  4 ----
>  kernel/rcu/tree.c | 60 ++++++++++++++++++++++++++++-------------------
>  2 files changed, 36 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index aeec70fda82c..046833f3784b 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -12,10 +12,6 @@
>  
>  #include <trace/events/rcu.h>
>  
> -/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
> -#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
> -
> -

OK.

>  /*
>   * Grace-period counter management.
>   */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 68ebf0eb64c8..255cd6835526 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -81,7 +81,7 @@
>  
>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
>  	.dynticks_nesting = 1,
> -	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
> +	.dynticks_nmi_nesting = 0,

C initializes to zero by default, so this can simply be deleted.

>  	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
>  };
>  struct rcu_state rcu_state = {
> @@ -558,17 +558,18 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
>  /*
>   * Enter an RCU extended quiescent state, which can be either the
>   * idle loop or adaptive-tickless usermode execution.
> - *
> - * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
> - * the possibility of usermode upcalls having messed up our count
> - * of interrupt nesting level during the prior busy period.
>   */
>  static void rcu_eqs_enter(bool user)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> -	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
> -	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> +	/* Entering usermode/idle from interrupt is not handled. These would
> +	 * mean usermode upcalls or idle entry happened from interrupts. But,
> +	 * reset the counter if we warn.
> +	 */

Please either put the "/*" on its own line or use "//"-style comments.

> +	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
> +		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> +

@@@

>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>  		     rdp->dynticks_nesting == 0);
>  	if (rdp->dynticks_nesting != 1) {
> @@ -642,23 +643,27 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
>  	 * (We are exiting an NMI handler, so RCU better be paying attention
>  	 * to us!)
>  	 */
> +	WARN_ON_ONCE(rdp->dynticks_nesting <= 0);

This is fine.

>  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
>  	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
>  
> +	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> +		   rdp->dynticks_nmi_nesting - 1);

This is problematic.  The +/-1 and +/-2 dance is specifically for NMIs, so...

>  	/*
>  	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
>  	 * leave it in non-RCU-idle state.
>  	 */
> -	if (rdp->dynticks_nmi_nesting != 1) {
> -		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> -		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> -			   rdp->dynticks_nmi_nesting - 2);
> +	if (rdp->dynticks_nesting != 1) {
> +		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nesting,
> +				  rdp->dynticks_nesting - 2, rdp->dynticks);
> +		WRITE_ONCE(rdp->dynticks_nesting, /* No store tearing. */
> +			   rdp->dynticks_nesting - 2);

Making the dancer's name be ->dynticks_nesting instead of
->dynticks_nmi_nesting is going to be trouble.  (Yes, I did
take a quick look at the next patch, more on that when I get
there.)

>  		return;
>  	}
>  
>  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> -	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdp->dynticks);
> -	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> +	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nesting, 0, rdp->dynticks);
> +	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid store tearing. */

Same here...

>  	if (irq)
>  		rcu_prepare_for_idle();
> @@ -723,10 +728,6 @@ void rcu_irq_exit_irqson(void)
>  /*
>   * Exit an RCU extended quiescent state, which can be either the
>   * idle loop or adaptive-tickless usermode execution.
> - *
> - * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
> - * allow for the possibility of usermode upcalls messing up our count of
> - * interrupt nesting level during the busy period that is just now starting.
>   */
>  static void rcu_eqs_exit(bool user)
>  {
> @@ -747,8 +748,13 @@ static void rcu_eqs_exit(bool user)
>  	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	WRITE_ONCE(rdp->dynticks_nesting, 1);
> -	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> -	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
> +
> +	/* Exiting usermode/idle from interrupt is not handled. These would
> +	 * mean usermode upcalls or idle exit happened from interrupts. But,
> +	 * reset the counter if we warn.
> +	 */
> +	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
> +		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);

And here.  Plus this is adding a test and branch in the common case.
Given that the location being written to should be hot in the cache,
it is not clear that this is a win.

>  }
>  
>  /**
> @@ -804,6 +810,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>  	long incby = 2;
>  
>  	/* Complain about underflow. */
> +	WARN_ON_ONCE(rdp->dynticks_nesting < 0);

OK.

>  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
>  
>  	/*
> @@ -826,16 +833,21 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>  
>  		incby = 1;
>  	} else if (tick_nohz_full_cpu(rdp->cpu) &&
> -		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
> -		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> +		   !rdp->dynticks_nmi_nesting && rdp->rcu_urgent_qs &&
> +		   !rdp->rcu_forced_tick) {

OK.  Though you should be able to save a line by pulling the
"rdp->rcu_urgent_qs &&" onto the first line.

>  		rdp->rcu_forced_tick = true;
>  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
>  	}
> +

Not clear that the added blank line is a win, here or below.

>  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> -			  rdp->dynticks_nmi_nesting,
> -			  rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
> +			  rdp->dynticks_nesting,
> +			  rdp->dynticks_nesting + incby, rdp->dynticks);
> +
> +	WRITE_ONCE(rdp->dynticks_nesting, /* Prevent store tearing. */
> +		   rdp->dynticks_nesting + incby);
> +
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
> -		   rdp->dynticks_nmi_nesting + incby);
> +		   rdp->dynticks_nmi_nesting + 1);

And same naming issue here.

							Thanx, Paul

>  	barrier();
>  }
>  
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
