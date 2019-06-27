Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8323C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B651E2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfF0SLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:11:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726498AbfF0SLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:11:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RI74Hu126637
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:11:16 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td2fh13xp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:11:15 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 19:11:15 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 19:11:11 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RIBALb42402090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 18:11:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4805AB2071;
        Thu, 27 Jun 2019 18:11:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24866B2068;
        Thu, 27 Jun 2019 18:11:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 18:11:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 286E716C1C01; Thu, 27 Jun 2019 11:11:12 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:11:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Reply-To: paulmck@linux.ibm.com
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <CAEXW_YT5LgdP_9SrachU4ZrhV9a7o_DM8eBfgxj=n7yRRyS-TQ@mail.gmail.com>
 <20190627154011.vbje64x6auaknhx4@linutronix.de>
 <CAEXW_YTvkSTqwi_jOE2Pr+uD-GC4Xv0CtBEL9YO7=LvJcM3FBQ@mail.gmail.com>
 <CAEXW_YTmx3wFKuiLyrQO6uSPYAL179EPa6N3WO7qZahccCs-pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTmx3wFKuiLyrQO6uSPYAL179EPa6N3WO7qZahccCs-pg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062718-0052-0000-0000-000003D70729
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011342; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224108; UDB=6.00644250; IPR=6.01005296;
 MB=3.00027492; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 18:11:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062718-0053-0000-0000-0000617B9650
Message-Id: <20190627181112.GY26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 01:46:27PM -0400, Joel Fernandes wrote:
> On Thu, Jun 27, 2019 at 1:43 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, Jun 27, 2019 at 11:40 AM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2019-06-27 11:37:10 [-0400], Joel Fernandes wrote:
> > > > Sebastian it would be nice if possible to trace where the
> > > > t->rcu_read_unlock_special is set for this scenario of calling
> > > > rcu_read_unlock_special, to give a clear idea about whether it was
> > > > really because of an IPI. I guess we could also add additional RCU
> > > > debug fields to task_struct (just for debugging) to see where there
> > > > unlock_special is set.
> > > >
> > > > Is there a test to reproduce this, or do I just boot an intel x86_64
> > > > machine with "threadirqs" and run into it?
> > >
> > > Do you want to send me a patch or should I send you my kvm image which
> > > triggers the bug on boot?
> >
> > I could reproduce this as well just booting Linus tree with threadirqs
> > command line and running rcutorture. In 15 seconds or so it locks
> > up... gdb backtrace shows the recursive lock:
> 
> Sorry that got badly wrapped, so I pasted it here:
> https://hastebin.com/ajivofomik.shell

Which rcutorture scenario would that be?  TREE03 is thus far refusing
to fail for me when run this way:

$ tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 5 --trust-make --configs "TREE03" --bootargs "threadirqs"

If it had failed, I would have tried the patch shown below.  I know that
Sebastian has some concerns about the bug happening anyway, but we have
to start somewhere!  ;-)

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 82c925df1d92..be7bafc2c0a0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -624,25 +624,16 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		      (rdp->grpmask & rnp->expmask) ||
 		      tick_nohz_full_cpu(rdp->cpu);
 		// Need to defer quiescent state until everything is enabled.
-		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
-		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
-			// Using softirq, safe to awaken, and we get
-			// no help from enabling irqs, unlike bh/preempt.
-			raise_softirq_irqoff(RCU_SOFTIRQ);
-		} else {
-			// Enabling BH or preempt does reschedule, so...
-			// Also if no expediting or NO_HZ_FULL, slow is OK.
-			set_tsk_need_resched(current);
-			set_preempt_need_resched();
-			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    !rdp->defer_qs_iw_pending && exp) {
-				// Get scheduler to re-evaluate and call hooks.
-				// If !IRQ_WORK, FQS scan will eventually IPI.
-				init_irq_work(&rdp->defer_qs_iw,
-					      rcu_preempt_deferred_qs_handler);
-				rdp->defer_qs_iw_pending = true;
-				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
-			}
+		set_tsk_need_resched(current);
+		set_preempt_need_resched();
+		if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
+		    !rdp->defer_qs_iw_pending && exp) {
+			// Get scheduler to re-evaluate and call hooks.
+			// If !IRQ_WORK, FQS scan will eventually IPI.
+			init_irq_work(&rdp->defer_qs_iw,
+				      rcu_preempt_deferred_qs_handler);
+			rdp->defer_qs_iw_pending = true;
+			irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 		}
 		t->rcu_read_unlock_special.b.deferred_qs = true;
 		local_irq_restore(flags);

