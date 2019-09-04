Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5A4C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA2621726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567638833;
	bh=yYjOoOHFpY/2te3Kqt2elSogWYh5XMg5mlrkr2JEXLY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Cs7rwe609Krfl76jMS4DgXdlY5RLMTRjO69nR/zmF7XW2QU4q8P7M0hDZVaL32Ykl
	 +fZaWrCUekvroaOc0a3HFr1hqnImJONYA5MhKh1eThEKTm5Oc3ig5tPr+UnH15y6r0
	 hg2588p3VaAFrJs44QT2Z2O4u48W1kUxyD2z1UhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfIDXNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 19:13:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728286AbfIDXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:13:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x84NCYwa061652;
        Wed, 4 Sep 2019 19:13:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2utmfamb4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 19:13:09 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x84ND9Ga063593;
        Wed, 4 Sep 2019 19:13:09 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2utmfamb3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 19:13:08 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x84NA26u010149;
        Wed, 4 Sep 2019 23:13:08 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 2uqgh73fm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 23:13:07 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x84ND7cP13828750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 23:13:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FA3CB2067;
        Wed,  4 Sep 2019 23:13:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4E5DB205F;
        Wed,  4 Sep 2019 23:13:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Sep 2019 23:13:06 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3941316C3CAB; Wed,  4 Sep 2019 16:13:08 -0700 (PDT)
Date:   Wed, 4 Sep 2019 16:13:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20190904231308.GB4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190830162348.192303-1-joel@joelfernandes.org>
 <20190903200249.GD4125@linux.ibm.com>
 <20190904045910.GC144846@google.com>
 <20190904101210.GM4125@linux.ibm.com>
 <20190904135420.GB240514@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904135420.GB240514@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:54:20AM -0400, Joel Fernandes wrote:
> On Wed, Sep 04, 2019 at 03:12:10AM -0700, Paul E. McKenney wrote:
> > On Wed, Sep 04, 2019 at 12:59:10AM -0400, Joel Fernandes wrote:
> > > On Tue, Sep 03, 2019 at 01:02:49PM -0700, Paul E. McKenney wrote:

[ . . . ]

> > If this task gets delayed betweentimes, rcu_implicit_dynticks_qs() would
> > fail to set .rcu_need_heavy_qs because it saw it already being set,
> > even though the corresponding ->dynticks update had already happened.
> > (It might be a new grace period, given that the old grace period might
> > have ended courtesy of the atomic_add_return().)
> 
> Makes sense and I agree.
> 
> Also, I would really appreciate if you can correct the nits in the above
> patch we're reviewing, and apply them (if you can).
> I think, there are only 2 changes left:
> - rename special to seq.
> - reorder the rcu_need_heavy_qs write.
> 
>  On a related point, when I was working on the NOHZ_FULL testing I noticed a
>  weird issue where rcu_urgent_qs was reset but rcu_need_heavy_qs was still
>  set indefinitely. I am a bit afraid our hints are not being cleared
>  appropriately and I believe I fixed a similar issue a few months ago. I
>  would rather have them cleared once they are no longer needed.  What do you
>  think about the below patch? I did not submit it yet because I was working
>  on other patches. 
> 
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [RFC] rcu/tree: Reset CPU hints when reporting a quiescent state
> 
> While tracing, I am seeing cases where need_heavy_qs is still set even
> though urgent_qs was cleared, after a quiescent state is reported. One
> such case is when the softirq reports that a CPU has passed quiescent
> state.
> 
> Previously in 671a63517cf9 ("rcu: Avoid unnecessary softirq when system
> is idle"), I had fixed a bug where core_needs_qs was not being cleared.
> I worry we keep running into similar situations. Let us just add a
> function to clear hints and call it from all relevant places to make the
> code more robust and avoid such stale hints which could in theory at
> least, cause false hints after the quiescent state was already reported.
> 
> Tested overnight with rcutorture running for 60 minutes on all
> configurations of RCU.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Excellent point!  But how about if we combine it with the existing
disabling of the scheduler tick, perhaps something like the following?

Note that the FQS clearing can come from some other CPU, hence the added
{READ,WRITE}_ONCE() calls.  The call is moved down in rcu_report_qs_rdp()
because something would have had to clear the bit to prevent execution
from getting there, and I believe that the other bit-clearing events
have calls to rcu_disable_urgency_upon_qs().  (But I easily could have
missed something!)

I am OK leaving RCU urgency set on offline CPUs, hence clearing things
at online time.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 68ebf0eb64c8..2b74b6c94086 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -827,7 +827,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		incby = 1;
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
-		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+		   READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
 		rdp->rcu_forced_tick = true;
 		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 	}
@@ -892,11 +892,15 @@ void rcu_irq_enter_irqson(void)
 }
 
 /*
- * If the scheduler-clock interrupt was enabled on a nohz_full CPU
- * in order to get to a quiescent state, disable it.
+ * If any sort of urgency was applied to the current CPU (for example,
+ * the scheduler-clock interrupt was enabled on a nohz_full CPU) in order
+ * to get to a quiescent state, disable it.
  */
-void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
+void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 {
+	WRITE_ONCE(rdp->core_needs_qs, false);
+	WRITE_ONCE(rdp->rcu_urgent_qs, false);
+	WRITE_ONCE(rdp->rcu_need_heavy_qs, false);
 	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
 		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 		rdp->rcu_forced_tick = false;
@@ -1417,7 +1421,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		trace_rcu_grace_period(rcu_state.name, rnp->gp_seq, TPS("cpustart"));
 		need_gp = !!(rnp->qsmask & rdp->grpmask);
 		rdp->cpu_no_qs.b.norm = need_gp;
-		rdp->core_needs_qs = need_gp;
+		WRITE_ONCE(rdp->core_needs_qs, need_gp);
 		zero_cpu_stall_ticks(rdp);
 	}
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
@@ -1987,7 +1991,6 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		return;
 	}
 	mask = rdp->grpmask;
-	rdp->core_needs_qs = false;
 	if ((rnp->qsmask & mask) == 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
@@ -1998,7 +2001,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		if (!offloaded)
 			needwake = rcu_accelerate_cbs(rnp, rdp);
 
-		rcu_disable_tick_upon_qs(rdp);
+		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
@@ -2022,7 +2025,7 @@ rcu_check_quiescent_state(struct rcu_data *rdp)
 	 * Does this CPU still need to do its part for current grace period?
 	 * If no, return and let the other CPUs do their part as well.
 	 */
-	if (!rdp->core_needs_qs)
+	if (!READ_ONCE(rdp->core_needs_qs))
 		return;
 
 	/*
@@ -2316,7 +2319,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 				rdp = per_cpu_ptr(&rcu_data, cpu);
 				if (f(rdp)) {
 					mask |= bit;
-					rcu_disable_tick_upon_qs(rdp);
+					rcu_disable_urgency_upon_qs(rdp);
 				}
 			}
 		}
@@ -3004,7 +3007,7 @@ static int rcu_pending(void)
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
-	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm)
+	if (READ_ONCE(rdp->core_needs_qs) && !rdp->cpu_no_qs.b.norm)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
@@ -3244,7 +3247,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->gp_seq = rnp->gp_seq;
 	rdp->gp_seq_needed = rnp->gp_seq;
 	rdp->cpu_no_qs.b.norm = true;
-	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
 	rdp->rcu_iw_gp_seq = rnp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
@@ -3359,7 +3361,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
-		rcu_disable_tick_upon_qs(rdp);
+		rcu_disable_urgency_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 	} else {
