Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52DCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAA1207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567541122;
	bh=B604DJtcbchDhoWcRSXAzluu/YDFHz4o+bNtfjaMBY4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=fvrDSkNL7yeCKGaotwljMRHf4nzYDUru6CtVP+SUHkvPNtAFz8tM9zzHXK9o77VgF
	 otWylV1Dc4E40l4g+Dpsq7/L7WBsZhiVOk9PBqA7tKvbsvNsG7dmtLLas+cRTwPdRB
	 FI8Dafhn3ysQAILn0hKAnghvN5mG8NkM8gYoIJk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfICUFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:05:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbfICUFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:05:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83K4VuQ112369;
        Tue, 3 Sep 2019 16:04:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usx1nskjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 16:04:45 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x83K4iqV113755;
        Tue, 3 Sep 2019 16:04:44 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usx1nskhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 16:04:44 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x83K4IwQ010729;
        Tue, 3 Sep 2019 20:04:43 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 2uqgh6vpsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 20:04:43 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83K4gIN8388940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 20:04:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58B28B205F;
        Tue,  3 Sep 2019 20:04:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 257F9B2065;
        Tue,  3 Sep 2019 20:04:42 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 20:04:42 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4C2E616C1074; Tue,  3 Sep 2019 13:04:46 -0700 (PDT)
Date:   Tue, 3 Sep 2019 13:04:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH -rcu dev 2/2] rcu/dyntick-idle: Add better tracing
Message-ID: <20190903200446.GE4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190830162348.192303-1-joel@joelfernandes.org>
 <20190830162348.192303-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830162348.192303-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=970 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 12:23:48PM -0400, Joel Fernandes (Google) wrote:
> The dyntick-idle traces are a bit confusing. This patch makes it simpler
> and adds some missing cases such as EQS-enter due to user vs idle mode.
> 
> Following are the changes:
> (1) Add a new context field to trace_rcu_dyntick tracepoint. This
>     context field can be "USER", "IDLE" or "IRQ".
> 
> (2) Remove the "++=" and "--=" strings and replace them with
>    "StillNonIdle". This is much easier on the eyes, and the -- and ++
>    are easily apparent in the dynticks_nesting counters we are printing
>    anyway.
> 
> This patch is based on the previous patches to simplify rcu_dyntick
> counters [1] and with these traces, I have verified the counters are
> working properly.
> 
> [1]
> Link: https://lore.kernel.org/patchwork/patch/1120021/
> Link: https://lore.kernel.org/patchwork/patch/1120022/
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

This looks fine, but depends on the earlier patch.

							Thanx, Paul

> ---
>  include/trace/events/rcu.h | 13 ++++++++-----
>  kernel/rcu/tree.c          | 19 +++++++++++++------
>  2 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 66122602bd08..474c1f7e7104 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -449,12 +449,14 @@ TRACE_EVENT_RCU(rcu_fqs,
>   */
>  TRACE_EVENT_RCU(rcu_dyntick,
>  
> -	TP_PROTO(const char *polarity, long oldnesting, long newnesting, atomic_t dynticks),
> +	TP_PROTO(const char *polarity, const char *context, long oldnesting,
> +		 long newnesting, atomic_t dynticks),
>  
> -	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
> +	TP_ARGS(polarity, context, oldnesting, newnesting, dynticks),
>  
>  	TP_STRUCT__entry(
>  		__field(const char *, polarity)
> +		__field(const char *, context)
>  		__field(long, oldnesting)
>  		__field(long, newnesting)
>  		__field(int, dynticks)
> @@ -462,14 +464,15 @@ TRACE_EVENT_RCU(rcu_dyntick,
>  
>  	TP_fast_assign(
>  		__entry->polarity = polarity;
> +		__entry->context = context;
>  		__entry->oldnesting = oldnesting;
>  		__entry->newnesting = newnesting;
>  		__entry->dynticks = atomic_read(&dynticks);
>  	),
>  
> -	TP_printk("%s %lx %lx %#3x", __entry->polarity,
> -		  __entry->oldnesting, __entry->newnesting,
> -		  __entry->dynticks & 0xfff)
> +	TP_printk("%s %s %lx %lx %#3x", __entry->polarity,
> +		__entry->context, __entry->oldnesting, __entry->newnesting,
> +		__entry->dynticks & 0xfff)
>  );
>  
>  /*
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 417dd00b9e87..463407762b5a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -533,7 +533,8 @@ static void rcu_eqs_enter(bool user)
>  	}
>  
>  	lockdep_assert_irqs_disabled();
> -	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
> +	trace_rcu_dyntick(TPS("Start"), (user ? TPS("USER") : TPS("IDLE")),
> +			  rdp->dynticks_nesting, 0, rdp->dynticks);
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	rdp = this_cpu_ptr(&rcu_data);
>  	do_nocb_deferred_wakeup(rdp);
> @@ -606,14 +607,17 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
>  	 * leave it in non-RCU-idle state.
>  	 */
>  	if (rdp->dynticks_nmi_nesting != 1) {
> -		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> +		trace_rcu_dyntick(TPS("StillNonIdle"), TPS("IRQ"),
> +				  rdp->dynticks_nmi_nesting,
> +				  rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
>  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
>  			   rdp->dynticks_nmi_nesting - 2);
>  		return;
>  	}
>  
>  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> -	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdp->dynticks);
> +	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nmi_nesting,
> +			  0, rdp->dynticks);
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
>  
>  	if (irq)
> @@ -700,7 +704,8 @@ static void rcu_eqs_exit(bool user)
>  	rcu_dynticks_task_exit();
>  	rcu_dynticks_eqs_exit();
>  	rcu_cleanup_after_idle();
> -	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
> +	trace_rcu_dyntick(TPS("End"), (user ? TPS("USER") : TPS("IDLE")),
> +			  rdp->dynticks_nesting, 1, rdp->dynticks);
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	WRITE_ONCE(rdp->dynticks_nesting, 1);
>  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> @@ -787,9 +792,11 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>  		rdp->rcu_forced_tick = true;
>  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
>  	}
> -	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> -			  rdp->dynticks_nmi_nesting,
> +
> +	trace_rcu_dyntick(incby == 1 ? TPS("End") : TPS("StillNonIdle"),
> +			  TPS("IRQ"), rdp->dynticks_nmi_nesting,
>  			  rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
> +
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
>  		   rdp->dynticks_nmi_nesting + incby);
>  	barrier();
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
