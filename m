Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84ADC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9580A206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbfHAWcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:32:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727498AbfHAWcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:32:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MW5jA087958
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 18:32:07 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u45u86pvf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:32:05 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:32:04 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:31:59 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MVwDn47972688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:31:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ECFEB206C;
        Thu,  1 Aug 2019 22:31:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FE3AB206B;
        Thu,  1 Aug 2019 22:31:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:31:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A644116C9A3A; Thu,  1 Aug 2019 15:31:59 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/3] rcu: Make rcu_read_unlock_special() checks match raise_softirq_irqoff()
Date:   Thu,  1 Aug 2019 15:31:57 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801223132.GA14044@linux.ibm.com>
References: <20190801223132.GA14044@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080122-0064-0000-0000-000004057838
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240732; UDB=6.00654293; IPR=6.01022156;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 22:32:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0065-0000-0000-00003E81E6B3
Message-Id: <20190801223158.14407-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Threaded interrupts provide additional interesting interactions between
RCU and raise_softirq() that can result in self-deadlocks in v5.0-2 of
the Linux kernel.  These self-deadlocks can be provoked in susceptible
kernels within a few minutes using the following rcutorture command on
an 8-CPU system:

tools/testing/selftests/rcutorture/bin/kvm.sh --duration 5 --configs "TREE03" --bootargs "threadirqs"

Although post-v5.2 RCU commits have at least greatly reduced the
probability of these self-deadlocks, this was entirely by accident.
Although this sort of accident should be rowdily celebrated on those
rare occasions when it does occur, such celebrations should be quickly
followed by a principled patch, which is what this patch purports to be.

The key point behind this patch is that when in_interrupt() returns
true, __raise_softirq_irqoff() will never attempt a wakeup.  Therefore,
if in_interrupt(), calls to raise_softirq*() are both safe and
extremely cheap.

This commit therefore replaces the in_irq() calls in the "if" statement
in rcu_read_unlock_special() with in_interrupt() and simplifies the
"if" condition to the following:

	if (irqs_were_disabled && use_softirq &&
	    (in_interrupt() ||
	     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
		raise_softirq_irqoff(RCU_SOFTIRQ);
	} else {
		/* Appeal to the scheduler. */
	}

The rationale behind the "if" condition is as follows:

1.	irqs_were_disabled:  If interrupts are enabled, we should
	instead appeal to the scheduler so as to let the upcoming
	irq_enable()/local_bh_enable() do the rescheduling for us.
2.	use_softirq: If this kernel isn't using softirq, then
	raise_softirq_irqoff() will be unhelpful.
3.	a.	in_interrupt(): If this returns true, the subsequent
		call to raise_softirq_irqoff() is guaranteed not to
		do a wakeup, so that call will be both very cheap and
		quite safe.
	b.	Otherwise, if !in_interrupt() the raise_softirq_irqoff()
		might do a wakeup, which is expensive and, in some
		contexts, unsafe.
		i.	The "exp" (an expedited RCU grace period is being
			blocked) says that the wakeup is worthwhile, and:
		ii.	The !.deferred_qs says that scheduler locks
			cannot be held, so the wakeup will be safe.

Backporting this requires considerable care, so no auto-backport, please!

Fixes: 05f415715ce45 ("rcu: Speed up expedited GPs when interrupting RCU reader")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3f0701e860e4..1fd3ca4ffc1d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -626,8 +626,9 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		      (rdp->grpmask & rnp->expmask) ||
 		      tick_nohz_full_cpu(rdp->cpu);
 		// Need to defer quiescent state until everything is enabled.
-		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
-		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
+		if (irqs_were_disabled && use_softirq &&
+		    (in_interrupt() ||
+		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
 			// Using softirq, safe to awaken, and we get
 			// no help from enabling irqs, unlike bh/preempt.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
-- 
2.17.1

