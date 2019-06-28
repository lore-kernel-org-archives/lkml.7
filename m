Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DEBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD13208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfF1WZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:25:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbfF1WZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:25:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SMLl82044790
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 18:25:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdtn1sv7n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 18:25:53 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 28 Jun 2019 23:25:51 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 23:25:48 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SMPlPC47972702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 22:25:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33011B2064;
        Fri, 28 Jun 2019 22:25:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 056AAB205F;
        Fri, 28 Jun 2019 22:25:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 22:25:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EC07D16C2EA4; Fri, 28 Jun 2019 15:25:47 -0700 (PDT)
Date:   Fri, 28 Jun 2019 15:25:47 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Reply-To: paulmck@linux.ibm.com
References: <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628135433.GE3402@hirez.programming.kicks-ass.net>
 <20190628153050.GU26519@linux.ibm.com>
 <20190628184026.fds6scgi2pnjnc5p@linutronix.de>
 <20190628185219.GA26519@linux.ibm.com>
 <20190628192407.GA89956@google.com>
 <20190628200423.GB26519@linux.ibm.com>
 <20190628214018.GB249127@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628214018.GB249127@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062822-0072-0000-0000-0000044253D7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011348; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224669; UDB=6.00644589; IPR=6.01005861;
 MB=3.00027512; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-28 22:25:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062822-0073-0000-0000-00004CB284B7
Message-Id: <20190628222547.GE26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 05:40:18PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Fri, Jun 28, 2019 at 01:04:23PM -0700, Paul E. McKenney wrote:
> [snip]
> > > > > Commit
> > > > > - 23634ebc1d946 ("rcu: Check for wakeup-safe conditions in
> > > > >    rcu_read_unlock_special()") does not trigger the bug within 94
> > > > >    attempts.
> > > > > 
> > > > > - 48d07c04b4cc1 ("rcu: Enable elimination of Tree-RCU softirq
> > > > >   processing") needed 12 attempts to trigger the bug.
> > > > 
> > > > That matches my belief that 23634ebc1d946 ("rcu: Check for wakeup-safe
> > > > conditions in rcu_read_unlock_special()") will at least greatly decrease
> > > > the probability of this bug occurring.
> > > 
> > > I was just typing a reply that I can't reproduce it with:
> > >   rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()
> > > 
> > > I am trying to revert enough of this patch to see what would break things,
> > > however I think a better exercise might be to understand more what the patch
> > > does why it fixes things in the first place ;-) It is probably the
> > > deferred_qs thing.
> > 
> > The deferred_qs flag is part of it!  Looking forward to hearing what
> > you come up with as being the critical piece of this commit.
> 
> The new deferred_qs flag indeed saves the machine from the dead-lock.
> 
> If we don't want the deferred_qs, then the below patch also fixes the issue.
> However, I am more sure than not that it does not handle all cases (such as
> what if we previously had an expedited grace period IPI in a previous reader
> section and had to to defer processing. Then it seems a similar deadlock
> would present. But anyway, the below patch does fix it for me! It is based on
> your -rcu tree commit 23634ebc1d946f19eb112d4455c1d84948875e31 (rcu: Check
> for wakeup-safe conditions in rcu_read_unlock_special()).

The point here being that you rely on .b.blocked rather than
.b.deferred_qs.  Hmmm...  There are a number of places that check all
the bits via the .s leg of the rcu_special union.  The .s check in
rcu_preempt_need_deferred_qs() should be OK because it is conditioned
on t->rcu_read_lock_nesting of zero or negative.

Do rest of those also work out OK?

It would be nice to remove the flag, but doing so clearly needs careful
review and testing.

							Thanx, Paul

> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] Fix RCU recursive deadlock
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/sched.h    |  2 +-
>  kernel/rcu/tree_plugin.h | 17 +++++++++++++----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 942a44c1b8eb..347e6dfcc91b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -565,7 +565,7 @@ union rcu_special {
>  		u8			blocked;
>  		u8			need_qs;
>  		u8			exp_hint; /* Hint for performance. */
> -		u8			deferred_qs;
> +		u8			pad;
>  	} b; /* Bits. */
>  	u32 s; /* Set of bits. */
>  };
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 75110ea75d01..5b9b12c1ba5c 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -455,7 +455,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  		local_irq_restore(flags);
>  		return;
>  	}
> -	t->rcu_read_unlock_special.b.deferred_qs = false;
>  	if (special.b.need_qs) {
>  		rcu_qs();
>  		t->rcu_read_unlock_special.b.need_qs = false;
> @@ -608,13 +607,24 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  	if (preempt_bh_were_disabled || irqs_were_disabled) {
>  		t->rcu_read_unlock_special.b.exp_hint = false;
>  		// Need to defer quiescent state until everything is enabled.
> +
> +		/* If unlock_special was called in the current reader section
> +		 * just because we were blocked in a previous reader section,
> +		 * then raising softirqs can deadlock. This is because the
> +		 * scheduler executes RCU sections with preemption disabled,
> +		 * however it may have previously blocked in a previous
> +		 * non-scheduler reader section and .blocked got set.  It is
> +		 * never safe to call unlock_special from the scheduler path
> +		 * due to recursive wake ups (unless we are in_irq(), so
> +		 * prevent this by checking if we were previously blocked.
> +		 */
>  		if (irqs_were_disabled && use_softirq &&
> -		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> +		    (!t->rcu_read_unlock_special.b.blocked || in_irq())) {
>  			// Using softirq, safe to awaken, and we get
>  			// no help from enabling irqs, unlike bh/preempt.
>  			raise_softirq_irqoff(RCU_SOFTIRQ);
>  		} else if (irqs_were_disabled && !use_softirq &&
> -			   !t->rcu_read_unlock_special.b.deferred_qs) {
> +			   !t->rcu_read_unlock_special.b.blocked) {
>  			// Safe to awaken and we get no help from enabling
>  			// irqs, unlike bh/preempt.
>  			invoke_rcu_core();
> @@ -623,7 +633,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  		}
> -		t->rcu_read_unlock_special.b.deferred_qs = true;
>  		local_irq_restore(flags);
>  		return;
>  	}
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

