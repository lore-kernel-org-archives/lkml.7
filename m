Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC2FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85D521882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGCRZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:25:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726430AbfGCRZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:25:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63HNZEZ127516
        for <linux-kernel@vger.kernel.org>; Wed, 3 Jul 2019 13:25:02 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgxn158sd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:25:02 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 3 Jul 2019 18:25:01 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 18:24:58 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x63HNhUe48693676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 17:23:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0028B205F;
        Wed,  3 Jul 2019 17:23:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3067B2064;
        Wed,  3 Jul 2019 17:23:42 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 17:23:42 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4BDC716C1F1D; Wed,  3 Jul 2019 10:23:44 -0700 (PDT)
Date:   Wed, 3 Jul 2019 10:23:44 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] rcuperf: Make rcuperf test more robust for !expedited mode
Reply-To: paulmck@linux.ibm.com
References: <20190703043945.128825-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703043945.128825-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070317-0052-0000-0000-000003D9F86B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011372; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226933; UDB=6.00645968; IPR=6.01008160;
 MB=3.00027570; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-03 17:25:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070317-0053-0000-0000-0000618E3F84
Message-Id: <20190703172344.GR26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 12:39:45AM -0400, Joel Fernandes (Google) wrote:
> It is possible that rcuperf run concurrently with init starting up.
> During this time, the system is running all grace periods as expedited.
> However, rcuperf can also be run in a normal mode. The rcuperf test
> depends on a holdoff before starting the test to ensure grace periods
> start later. This works fine with the default holdoff time however it is
> not robust in situations where init takes greater than the holdoff time
> the finish running. Or, as in my case:
> 
> I modified the rcuperf test locally to also run a thread that did
> preempt disable/enable in a loop. This had the effect of slowing down
> init. The end result was "batches:" counter was 0. This was because only
> expedited GPs seem to happen, not normal ones which led to the
> rcu_state.gp_seq counter remaining constant across grace periods which
> unexpectedly happen to be expedited.
> 
> This led me to debug that even though the test could be for normal GP
> performance, because init has still not run enough, the
> rcu_unexpedited_gp() call would not have run yet. In other words, the
> test would concurrently with init booting in expedited GP mode.
> 
> To fix this properly, let us just check for whether rcu_unexpedited_gp()
> was called yet before starting the writer test. With this, the holdoff
> parameter could also be dropped or reduced to speed up the test.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> Please consider this patch as an RFC only! This is the first time I am
> running the RCU performance tests, thanks!

Another approach is to create (say) a late_initcall() function that
sets a global variable.  Then have the wait loop wait for that global
variable to be set.  Or use an explicit wait/wakeup scheme, if you wish.

This has the virtue of keeping this (admittedly small) bit of complexit
out of the core kernel.

> Question:
> I actually did not know that expedited gp does not increment
> rcu_state.gp_seq. Does expedited GPs not go through the same RCU-tree
> machinery as non-expedited? If yes, why doesn't rcu_state.gp_seq
> increment when we are expedited? If no, why not?

They are indeed (mostly) independent mechanisms.

This is in contrast to SRCU, where an expedited grace period does what
you expect, causing all grace periods to do less waiting until the
most recent expedited grace period has completed.

Why the difference?

o	Current SRCU uses have relatively few updates, so the decreases
	in batching effectiveness for normal grace periods are less
	troublesome than they would be for RCU.  Shortening RCU grace
	periods would significantly increase per-update overhead, for
	example, and less so for SRCU.

o	RCU uses a much more distributed design, which means that
	expediting an already-started RCU grace period would be more
	challenging than it is for SRCU.  The race conditions between
	an "expedite now!" event and the various changes in state for
	a normal RCU grace period would be challenging.

o	In addition, RCU's more distributed design results in
	higher latencies.  Expedited RCU grace periods simply bypass
	this and get much better latencies.

So, yes, normal and expedited RCU grace periods could be converged, but
it does not seem like a good idea given current requirements.

							Thanx, Paul

>  kernel/rcu/rcu.h     | 2 ++
>  kernel/rcu/rcuperf.c | 5 +++++
>  kernel/rcu/update.c  | 9 +++++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 8fd4f82c9b3d..5d30dbc7000b 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -429,12 +429,14 @@ static inline void srcu_init(void) { }
>  static inline bool rcu_gp_is_normal(void) { return true; }
>  static inline bool rcu_gp_is_expedited(void) { return false; }
>  static inline void rcu_expedite_gp(void) { }
> +static inline bool rcu_expedite_gp_called(void) { }
>  static inline void rcu_unexpedite_gp(void) { }
>  static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
>  #else /* #ifdef CONFIG_TINY_RCU */
>  bool rcu_gp_is_normal(void);     /* Internal RCU use. */
>  bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
>  void rcu_expedite_gp(void);
> +bool rcu_expedite_gp_called(void);
>  void rcu_unexpedite_gp(void);
>  void rcupdate_announce_bootup_oddness(void);
>  void rcu_request_urgent_qs_task(struct task_struct *t);
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 4513807cd4c4..9902857d3cc6 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -375,6 +375,11 @@ rcu_perf_writer(void *arg)
>  	if (holdoff)
>  		schedule_timeout_uninterruptible(holdoff * HZ);
>  
> +	// Wait for rcu_unexpedite_gp() to be called from init to avoid
> +	// doing expedited GPs if we are not supposed to
> +	while (!gp_exp && rcu_expedite_gp_called())
> +		schedule_timeout_uninterruptible(1);
> +
>  	t = ktime_get_mono_fast_ns();
>  	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
>  		t_rcu_perf_writer_started = t;
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 249517058b13..840f62805d62 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -154,6 +154,15 @@ void rcu_expedite_gp(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_expedite_gp);
>  
> +/**
> + * rcu_expedite_gp_called - Was there a prior call to rcu_expedite_gp()?
> + */
> +bool rcu_expedite_gp_called(void)
> +{
> +	return (atomic_read(&rcu_expedited_nesting) != 0);
> +}
> +EXPORT_SYMBOL_GPL(rcu_expedite_gp_called);
> +
>  /**
>   * rcu_unexpedite_gp - Cancel prior rcu_expedite_gp() invocation
>   *
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

