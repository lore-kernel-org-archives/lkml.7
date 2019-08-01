Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75793C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F36206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbfHAWdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:33:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727498AbfHAWc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:32:59 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MW9qk085775;
        Thu, 1 Aug 2019 18:32:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u457uqnkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:32:11 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MWAeQ085816;
        Thu, 1 Aug 2019 18:32:10 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u457uqnfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:32:10 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MVMte017030;
        Thu, 1 Aug 2019 22:31:59 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 2u0e85xfpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:31:59 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MVwIV50528542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:31:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C2AEB2067;
        Thu,  1 Aug 2019 22:31:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 563C2B206E;
        Thu,  1 Aug 2019 22:31:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:31:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AD11816C9A4A; Thu,  1 Aug 2019 15:31:59 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        kernel-team@android.com,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 3/3] rcu: Simplify rcu_note_context_switch exit from critical section
Date:   Thu,  1 Aug 2019 15:31:58 -0700
Message-Id: <20190801223158.14407-3-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801223132.GA14044@linux.ibm.com>
References: <20190801223132.GA14044@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Because __rcu_read_unlock() can be preempted just before the call to
rcu_read_unlock_special(), it is possible for a task to be preempted just
before it would have fully exited its RCU read-side critical section.
This would result in a needless extension of that critical section until
that task was resumed, which might in turn result in a needlessly
long grace period, needless RCU priority boosting, and needless
force-quiescent-state actions.  Therefore, rcu_note_context_switch()
invokes __rcu_read_unlock() followed by rcu_preempt_deferred_qs() when
it detects this situation.  This action by rcu_note_context_switch()
ends the RCU read-side critical section immediately.

Of course, once the task resumes, it will invoke rcu_read_unlock_special()
redundantly.  This is harmless because the fact that a preemption
happened means that interrupts, preemption, and softirqs cannot
have been disabled, so there would be no deferred quiescent state.
While ->rcu_read_lock_nesting remains less than zero, none of the
->rcu_read_unlock_special.b bits can be set, and they were all zeroed by
the call to rcu_note_context_switch() at task-preemption time.  Therefore,
setting ->rcu_read_unlock_special.b.exp_hint to false has no effect.

Therefore, the extra call to rcu_preempt_deferred_qs_irqrestore()
would return immediately.  With one possible exception, which is
if an expedited grace period started just as the task was being
resumed, which could leave ->exp_deferred_qs set.  This will cause
rcu_preempt_deferred_qs_irqrestore() to invoke rcu_report_exp_rdp(),
reporting the quiescent state, just as it should.  (Such an expedited
grace period won't affect the preemption code path due to interrupts
having already been disabled.)

But when rcu_note_context_switch() invokes __rcu_read_unlock(), it
is doing so with preemption disabled, hence __rcu_read_unlock() will
unconditionally defer the quiescent state, only to immediately invoke
rcu_preempt_deferred_qs(), thus immediately reporting the deferred
quiescent state.  It turns out to be safe (and faster) to instead
just invoke rcu_preempt_deferred_qs() without the __rcu_read_unlock()
middleman.

Because this is the invocation during the preemption (as opposed to
the invocation just after the resume), at least one of the bits in
->rcu_read_unlock_special.b must be set and ->rcu_read_lock_nesting
must be negative.  This means that rcu_preempt_need_deferred_qs() must
return true, avoiding the early exit from rcu_preempt_deferred_qs().
Thus, rcu_preempt_deferred_qs_irqrestore() will be invoked immediately,
as required.

This commit therefore simplifies the CONFIG_PREEMPT=y version of
rcu_note_context_switch() by removing the "else if" branch of its
"if" statement.  This change means that all callers that would have
invoked rcu_read_unlock_special() followed by rcu_preempt_deferred_qs()
will now simply invoke rcu_preempt_deferred_qs(), thus avoiding the
rcu_read_unlock_special() middleman when __rcu_read_unlock() is preempted.

Cc: rcu@vger.kernel.org
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1fd3ca4ffc1d..ce6ef345102b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -314,15 +314,6 @@ void rcu_note_context_switch(bool preempt)
 				       ? rnp->gp_seq
 				       : rcu_seq_snap(&rnp->gp_seq));
 		rcu_preempt_ctxt_queue(rnp, rdp);
-	} else if (t->rcu_read_lock_nesting < 0 &&
-		   t->rcu_read_unlock_special.s) {
-
-		/*
-		 * Complete exit from RCU read-side critical section on
-		 * behalf of preempted instance of __rcu_read_unlock().
-		 */
-		rcu_read_unlock_special(t);
-		rcu_preempt_deferred_qs(t);
 	} else {
 		rcu_preempt_deferred_qs(t);
 	}
-- 
2.17.1

