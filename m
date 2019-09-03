Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C5DC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DF5207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567541042;
	bh=J9tUIJuc0G6R7yFZCA/L7bHHl4eFauWBv01VK+7nQoQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=j0hr3yZOWORC5/NGRiTly+yHZcl2AnELMlWtPsQa8Wf1lpyb4hFazvCLoESgOxTAX
	 mvFMKrKtAmw9WmNYn2TLTQuUgtq9cqRMxtA4T9on632gh87cL/A3ZZGGTJ+RKIn7rK
	 Ij3At3QjLbN5kuT7GgR2ws6QFvQxw+9PZt6YcT/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfICUEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:04:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbfICUEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:04:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83K0Nlg121651;
        Tue, 3 Sep 2019 16:02:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usxpwrape-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 16:02:48 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x83K0Swg122300;
        Tue, 3 Sep 2019 16:02:47 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usxpwrap0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 16:02:47 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x83K0HML006524;
        Tue, 3 Sep 2019 20:02:46 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 2uqgh6vpg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 20:02:46 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83K2je154460696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 20:02:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4B28B2064;
        Tue,  3 Sep 2019 20:02:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B117B205F;
        Tue,  3 Sep 2019 20:02:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 20:02:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C3BC816C1074; Tue,  3 Sep 2019 13:02:49 -0700 (PDT)
Date:   Tue, 3 Sep 2019 13:02:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH -rcu dev 1/2] Revert b8c17e6664c4 ("rcu: Maintain special
 bits at bottom of ->dynticks counter")
Message-ID: <20190903200249.GD4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190830162348.192303-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830162348.192303-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 12:23:47PM -0400, Joel Fernandes (Google) wrote:
> This code is unused and can be removed now. Revert was straightforward.
> 
> Tested with light rcutorture.
> 
> Link: http://lore.kernel.org/r/CALCETrWNPOOdTrFabTDd=H7+wc6xJ9rJceg6OL1S0rTV5pfSsA@mail.gmail.com
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Some questions below.

> ---
>  include/linux/rcutiny.h |  3 --
>  kernel/rcu/tree.c       | 82 ++++++++++-------------------------------
>  2 files changed, 19 insertions(+), 66 deletions(-)
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index b7607e2667ae..b3f689711289 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -14,9 +14,6 @@
>  
>  #include <asm/param.h> /* for HZ */
>  
> -/* Never flag non-existent other CPUs! */
> -static inline bool rcu_eqs_special_set(int cpu) { return false; }
> -
>  static inline unsigned long get_state_synchronize_rcu(void)
>  {
>  	return 0;
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 68ebf0eb64c8..417dd00b9e87 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -69,20 +69,10 @@
>  
>  /* Data structures. */
>  
> -/*
> - * Steal a bit from the bottom of ->dynticks for idle entry/exit
> - * control.  Initially this is for TLB flushing.
> - */
> -#define RCU_DYNTICK_CTRL_MASK 0x1
> -#define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
> -#ifndef rcu_eqs_special_exit
> -#define rcu_eqs_special_exit() do { } while (0)
> -#endif
> -
>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
>  	.dynticks_nesting = 1,
>  	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
> -	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
> +	.dynticks = ATOMIC_INIT(1),
>  };
>  struct rcu_state rcu_state = {
>  	.level = { &rcu_state.node[0] },
> @@ -229,20 +219,15 @@ void rcu_softirq_qs(void)
>  static void rcu_dynticks_eqs_enter(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> -	int seq;
> +	int special;

Given that we really are now loading a pure sequence number, why
change the name to "special"?  This revert is after all removing
the ability of ->dynticks to be special.

>  	/*
> -	 * CPUs seeing atomic_add_return() must see prior RCU read-side
> +	 * CPUs seeing atomic_inc_return() must see prior RCU read-side
>  	 * critical sections, and we also must force ordering with the
>  	 * next idle sojourn.
>  	 */
> -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> -	/* Better be in an extended quiescent state! */
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> -		     (seq & RCU_DYNTICK_CTRL_CTR));
> -	/* Better not have special action (TLB flush) pending! */
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> -		     (seq & RCU_DYNTICK_CTRL_MASK));
> +	special = atomic_inc_return(&rdp->dynticks);
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && special & 0x1);
>  }
>  
>  /*
> @@ -252,22 +237,15 @@ static void rcu_dynticks_eqs_enter(void)
>  static void rcu_dynticks_eqs_exit(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> -	int seq;
> +	int special;

Ditto.

>  	/*
> -	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
> +	 * CPUs seeing atomic_inc_return() must see prior idle sojourns,
>  	 * and we also must force ordering with the next RCU read-side
>  	 * critical section.
>  	 */
> -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> -		     !(seq & RCU_DYNTICK_CTRL_CTR));
> -	if (seq & RCU_DYNTICK_CTRL_MASK) {
> -		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> -		smp_mb__after_atomic(); /* _exit after clearing mask. */
> -		/* Prefer duplicate flushes to losing a flush. */
> -		rcu_eqs_special_exit();
> -	}
> +	special = atomic_inc_return(&rdp->dynticks);
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(special & 0x1));
>  }
>  
>  /*
> @@ -284,9 +262,9 @@ static void rcu_dynticks_eqs_online(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> -	if (atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR)
> +	if (atomic_read(&rdp->dynticks) & 0x1)
>  		return;
> -	atomic_add(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> +	atomic_add(0x1, &rdp->dynticks);

This could be atomic_inc(), right?

>  }
>  
>  /*
> @@ -298,7 +276,7 @@ bool rcu_dynticks_curr_cpu_in_eqs(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> -	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> +	return !(atomic_read(&rdp->dynticks) & 0x1);
>  }
>  
>  /*
> @@ -309,7 +287,7 @@ int rcu_dynticks_snap(struct rcu_data *rdp)
>  {
>  	int snap = atomic_add_return(0, &rdp->dynticks);
>  
> -	return snap & ~RCU_DYNTICK_CTRL_MASK;
> +	return snap;
>  }
>  
>  /*
> @@ -318,7 +296,7 @@ int rcu_dynticks_snap(struct rcu_data *rdp)
>   */
>  static bool rcu_dynticks_in_eqs(int snap)
>  {
> -	return !(snap & RCU_DYNTICK_CTRL_CTR);
> +	return !(snap & 0x1);
>  }
>  
>  /*
> @@ -331,28 +309,6 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
>  	return snap != rcu_dynticks_snap(rdp);
>  }
>  
> -/*
> - * Set the special (bottom) bit of the specified CPU so that it
> - * will take special action (such as flushing its TLB) on the
> - * next exit from an extended quiescent state.  Returns true if
> - * the bit was successfully set, or false if the CPU was not in
> - * an extended quiescent state.
> - */
> -bool rcu_eqs_special_set(int cpu)
> -{
> -	int old;
> -	int new;
> -	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> -
> -	do {
> -		old = atomic_read(&rdp->dynticks);
> -		if (old & RCU_DYNTICK_CTRL_CTR)
> -			return false;
> -		new = old | RCU_DYNTICK_CTRL_MASK;
> -	} while (atomic_cmpxchg(&rdp->dynticks, old, new) != old);
> -	return true;
> -}
> -
>  /*
>   * Let the RCU core know that this CPU has gone through the scheduler,
>   * which is a quiescent state.  This is called when the need for a
> @@ -366,13 +322,13 @@ bool rcu_eqs_special_set(int cpu)
>   */
>  void rcu_momentary_dyntick_idle(void)
>  {
> -	int special;
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> +	int special = atomic_add_return(2, &rdp->dynticks);
>  
> -	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
> -	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR,
> -				    &this_cpu_ptr(&rcu_data)->dynticks);
>  	/* It is illegal to call this from idle state. */
> -	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
> +	WARN_ON_ONCE(!(special & 0x1));
> +
> +	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);

Is it really OK to clear .rcu_need_heavy_qs after the atomic_add_return()?

>  	rcu_preempt_deferred_qs(current);
>  }
>  EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
