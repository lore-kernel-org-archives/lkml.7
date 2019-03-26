Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB18C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195DA20685
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfCZOdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:33:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730587AbfCZOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:33:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QEUDbE138012
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:33:01 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfm97wgmn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:32:48 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 14:32:05 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 14:32:02 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QEW0Ri13500506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 14:32:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91FE9B206E;
        Tue, 26 Mar 2019 14:32:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61B05B2065;
        Tue, 26 Mar 2019 14:32:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 14:32:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CEED116C2A54; Tue, 26 Mar 2019 07:32:00 -0700 (PDT)
Date:   Tue, 26 Mar 2019 07:32:00 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        shaoyafang@didiglobal.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rcu: validate arguments for rcu tracepoints
Reply-To: paulmck@linux.ibm.com
References: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
 <1553564407-1162-4-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553564407-1162-4-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032614-0052-0000-0000-000003A156AD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010818; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01179959; UDB=6.00617468; IPR=6.00960674;
 MB=3.00026164; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 14:32:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032614-0053-0000-0000-00006047D262
Message-Id: <20190326143200.GH4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:40:07AM +0800, Yafang Shao wrote:
> When CONFIG_RCU_TRACE is not set, all these tracepoints are define as
> do-nothing macro.
> We'd better make those inline functions that take proper arguments.
> 
> As RCU_TRACE() is defined as do-nothing marco as well when
> CONFIG_RCU_TRACE is not set, so we can clean it up.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

With the naming changes suggested by Steven:

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

This area of the code should be relatively free from conflicts, so please
feel free to take it with the tracing updates.

> ---
>  include/trace/events/rcu.h | 84 +++++++++++++++++++++++++++++-----------------
>  kernel/rcu/rcu.h           |  9 ++---
>  kernel/rcu/tree.c          |  8 ++---
>  3 files changed, 60 insertions(+), 41 deletions(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index f0c4d10..357e1b6 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -750,36 +750,60 @@
> 
>  #else /* #ifdef CONFIG_RCU_TRACE */
> 
> -#define trace_rcu_grace_period(rcuname, gp_seq, gpevent) do { } while (0)
> -#define trace_rcu_future_grace_period(rcuname, gp_seq, gp_seq_req, \
> -				      level, grplo, grphi, event) \
> -				      do { } while (0)
> -#define trace_rcu_grace_period_init(rcuname, gp_seq, level, grplo, grphi, \
> -				    qsmask) do { } while (0)
> -#define trace_rcu_exp_grace_period(rcuname, gqseq, gpevent) \
> -	do { } while (0)
> -#define trace_rcu_exp_funnel_lock(rcuname, level, grplo, grphi, gpevent) \
> -	do { } while (0)
> -#define trace_rcu_nocb_wake(rcuname, cpu, reason) do { } while (0)
> -#define trace_rcu_preempt_task(rcuname, pid, gp_seq) do { } while (0)
> -#define trace_rcu_unlock_preempted_task(rcuname, gp_seq, pid) do { } while (0)
> -#define trace_rcu_quiescent_state_report(rcuname, gp_seq, mask, qsmask, level, \
> -					 grplo, grphi, gp_tasks) do { } \
> -	while (0)
> -#define trace_rcu_fqs(rcuname, gp_seq, cpu, qsevent) do { } while (0)
> -#define trace_rcu_dyntick(polarity, oldnesting, newnesting, dyntick) do { } while (0)
> -#define trace_rcu_callback(rcuname, rhp, qlen_lazy, qlen) do { } while (0)
> -#define trace_rcu_kfree_callback(rcuname, rhp, offset, qlen_lazy, qlen) \
> -	do { } while (0)
> -#define trace_rcu_batch_start(rcuname, qlen_lazy, qlen, blimit) \
> -	do { } while (0)
> -#define trace_rcu_invoke_callback(rcuname, rhp) do { } while (0)
> -#define trace_rcu_invoke_kfree_callback(rcuname, rhp, offset) do { } while (0)
> -#define trace_rcu_batch_end(rcuname, callbacks_invoked, cb, nr, iit, risk) \
> -	do { } while (0)
> -#define trace_rcu_torture_read(rcutorturename, rhp, secs, c_old, c) \
> -	do { } while (0)
> -#define trace_rcu_barrier(name, s, cpu, cnt, done) do { } while (0)
> +TRACE_EVENT_NONE(rcu_grace_period,
> +	TP_PROTO(const char *rcuname, unsigned long gp_seq,
> +		 const char *gpevent));
> +TRACE_EVENT_NONE(rcu_future_grace_period,
> +	TP_PROTO(const char *rcuname, unsigned long gp_seq,
> +		 unsigned long gp_seq_req, u8 level, int grplo,
> +		 int grphi, const char *gpevent));
> +TRACE_EVENT_NONE(rcu_grace_period_init,
> +	TP_PROTO(const char *rcuname, unsigned long gp_seq, u8 level,
> +		 int grplo, int grphi, unsigned long qsmask));
> +TRACE_EVENT_NONE(rcu_exp_grace_period,
> +	TP_PROTO(const char *rcuname, unsigned long gpseq,
> +		 const char *gpevent));
> +TRACE_EVENT_NONE(rcu_exp_funnel_lock,
> +	TP_PROTO(const char *rcuname, u8 level, int grplo, int grphi,
> +		 const char *gpevent));
> +TRACE_EVENT_NONE(rcu_nocb_wake,
> +	TP_PROTO(const char *rcuname, int cpu, const char *reason));
> +TRACE_EVENT_NONE(rcu_preempt_task,
> +	TP_PROTO(const char *rcuname, int pid, unsigned long gp_seq));
> +TRACE_EVENT_NONE(rcu_unlock_preempted_task,
> +	TP_PROTO(const char *rcuname, unsigned long gp_seq, int pid));
> +TRACE_EVENT_NONE(rcu_quiescent_state_report,
> +	TP_PROTO(const char *rcuname, unsigned long gp_seq,
> +		 unsigned long mask, unsigned long qsmask,
> +		 u8 level, int grplo, int grphi, int gp_tasks));
> +TRACE_EVENT_NONE(rcu_fqs,
> +	TP_PROTO(const char *rcuname, unsigned long gp_seq, int cpu,
> +		 const char *qsevent));
> +TRACE_EVENT_NONE(rcu_dyntick,
> +	TP_PROTO(const char *polarity, long oldnesting, long newnesting,
> +		 atomic_t dynticks));
> +TRACE_EVENT_NONE(rcu_callback,
> +	TP_PROTO(const char *rcuname, struct rcu_head *rhp, long qlen_lazy,
> +		 long qlen));
> +TRACE_EVENT_NONE(rcu_kfree_callback,
> +	TP_PROTO(const char *rcuname, struct rcu_head *rhp,
> +		 unsigned long offset, long qlen_lazy, long qlen));
> +TRACE_EVENT_NONE(rcu_batch_start,
> +	TP_PROTO(const char *rcuname, long qlen_lazy, long qlen, long blimit));
> +TRACE_EVENT_NONE(rcu_invoke_callback,
> +	TP_PROTO(const char *rcuname, struct rcu_head *rhp));
> +TRACE_EVENT_NONE(rcu_invoke_kfree_callback,
> +	TP_PROTO(const char *rcuname, struct rcu_head *rhp,
> +		 unsigned long offset));
> +TRACE_EVENT_NONE(rcu_batch_end,
> +	TP_PROTO(const char *rcuname, int callbacks_invoked,
> +		 char cb, char nr, char iit, char risk));
> +TRACE_EVENT_NONE(rcu_torture_read,
> +	TP_PROTO(const char *rcutorturename, struct rcu_head *rhp,
> +		 unsigned long secs, unsigned long c_old, unsigned long c));
> +TRACE_EVENT_NONE(rcu_barrier,
> +	TP_PROTO(const char *rcuname, const char *s, int cpu, int cnt,
> +		 unsigned long done));
> 
>  #endif /* #else #ifdef CONFIG_RCU_TRACE */
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index a393e24..2778e44 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -24,11 +24,6 @@
>  #define __LINUX_RCU_H
> 
>  #include <trace/events/rcu.h>
> -#ifdef CONFIG_RCU_TRACE
> -#define RCU_TRACE(stmt) stmt
> -#else /* #ifdef CONFIG_RCU_TRACE */
> -#define RCU_TRACE(stmt)
> -#endif /* #else #ifdef CONFIG_RCU_TRACE */
> 
>  /* Offset to allow for unmatched rcu_irq_{enter,exit}(). */
>  #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
> @@ -229,12 +224,12 @@ static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
> 
>  	rcu_lock_acquire(&rcu_callback_map);
>  	if (__is_kfree_rcu_offset(offset)) {
> -		RCU_TRACE(trace_rcu_invoke_kfree_callback(rn, head, offset);)
> +		trace_rcu_invoke_kfree_callback(rn, head, offset);
>  		kfree((void *)head - offset);
>  		rcu_lock_release(&rcu_callback_map);
>  		return true;
>  	} else {
> -		RCU_TRACE(trace_rcu_invoke_callback(rn, head);)
> +		trace_rcu_invoke_callback(rn, head);
>  		f = head->func;
>  		WRITE_ONCE(head->func, (rcu_callback_t)0L);
>  		f(head);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9180158..d2ad39f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2329,14 +2329,14 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
>   */
>  int rcutree_dying_cpu(unsigned int cpu)
>  {
> -	RCU_TRACE(bool blkd;)
> -	RCU_TRACE(struct rcu_data *rdp = this_cpu_ptr(&rcu_data);)
> -	RCU_TRACE(struct rcu_node *rnp = rdp->mynode;)
> +	bool blkd;
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> +	struct rcu_node *rnp = rdp->mynode;
> 
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>  		return 0;
> 
> -	RCU_TRACE(blkd = !!(rnp->qsmask & rdp->grpmask);)
> +	blkd = !!(rnp->qsmask & rdp->grpmask);
>  	trace_rcu_grace_period(rcu_state.name, rnp->gp_seq,
>  			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
>  	return 0;
> -- 
> 1.8.3.1
> 

