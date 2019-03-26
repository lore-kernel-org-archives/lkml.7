Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D857C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A822087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbfCZXNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:13:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732835AbfCZXNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:13:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QN9KAq144634
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:13:22 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfvt9sfxe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:13:22 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:13:21 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:13:16 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNDEDl21889044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:13:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7667DB2066;
        Tue, 26 Mar 2019 23:13:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CB41B2067;
        Tue, 26 Mar 2019 23:13:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:13:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6549D16C60F9; Tue, 26 Mar 2019 16:13:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 04/18] rcu: Make exit_rcu() handle non-preempted RCU readers
Date:   Tue, 26 Mar 2019 16:13:00 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326231253.GA18343@linux.ibm.com>
References: <20190326231253.GA18343@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0040-0000-0000-000004D7AEA3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180133; UDB=6.00606765; IPR=6.00960848;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:13:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0041-0000-0000-000008E2CFEE
Message-Id: <20190326231314.19518-4-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=75 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of exit_rcu() is to handle cases where buggy code causes a
task to exit within an RCU read-side critical section.  It currently
does that in the case where said RCU read-side critical section was
preempted at least once, but fails to handle cases where preemption did
not occur.  This case needs to be handled because otherwise the final
context switch away from the exiting task will incorrectly behave as if
task exit were instead a preemption of an RCU read-side critical section,
and will therefore queue the exiting task.  The exiting task will have
exited, and thus won't ever execute rcu_read_unlock(), which means that
it will remain queued forever, blocking all subsequent grace periods,
and eventually resulting in OOM.

Although this is arguably better than letting grace periods proceed
and having a later rcu_read_unlock() access the now-freed task
structure that once belonged to the exiting tasks, it would obviously
be better to correctly handle this case.  This commit therefore sets
->rcu_read_lock_nesting to 1 in that case, so that the subsequence call
to __rcu_read_unlock() causes the exiting task to exit its dangling RCU
read-side critical section.

Note that deferred quiescent states need not be considered.  The reason
is that removing the task from the ->blkd_tasks[] list in the call to
rcu_preempt_deferred_qs() handles the per-task component of any deferred
quiescent state, and all other components of any deferred quiescent state
are associated with the CPU, which isn't going anywhere until some later
CPU-hotplug operation, which will report any remaining deferred quiescent
states from within the rcu_report_dead() function.

Note also that negative values of ->rcu_read_lock_nesting need not be
considered.  First, these won't show up in exit_rcu() unless there is
a serious bug in RCU, and second, setting ->rcu_read_lock_nesting sets
the state so that the RCU read-side critical section will be exited
normally.

Again, this code has no effect unless there has been some prior bug
that prevents a task from leaving an RCU read-side critical section
before exiting.  Furthermore, there have been no reports of the bug
fixed by this commit appearing in production.  This commit is therefore
absolutely -not- recommended for backporting to -stable.

Reported-by: ABHISHEK DUBEY <dabhishek@iisc.ac.in>
Reported-by: BHARATH Y MOURYA <bharathm@iisc.ac.in>
Reported-by: Aravinda Prasad <aravinda@iisc.ac.in>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: ABHISHEK DUBEY <dabhishek@iisc.ac.in>
---
 kernel/rcu/tree_plugin.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 97dba50f6fb2..d408661d5fb7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -804,19 +804,25 @@ static void rcu_flavor_sched_clock_irq(int user)
 
 /*
  * Check for a task exiting while in a preemptible-RCU read-side
- * critical section, clean up if so.  No need to issue warnings,
- * as debug_check_no_locks_held() already does this if lockdep
- * is enabled.
+ * critical section, clean up if so.  No need to issue warnings, as
+ * debug_check_no_locks_held() already does this if lockdep is enabled.
+ * Besides, if this function does anything other than just immediately
+ * return, there was a bug of some sort.  Spewing warnings from this
+ * function is like as not to simply obscure important prior warnings.
  */
 void exit_rcu(void)
 {
 	struct task_struct *t = current;
 
-	if (likely(list_empty(&current->rcu_node_entry)))
+	if (unlikely(!list_empty(&current->rcu_node_entry))) {
+		t->rcu_read_lock_nesting = 1;
+		barrier();
+		t->rcu_read_unlock_special.b.blocked = true;
+	} else if (unlikely(t->rcu_read_lock_nesting)) {
+		t->rcu_read_lock_nesting = 1;
+	} else {
 		return;
-	t->rcu_read_lock_nesting = 1;
-	barrier();
-	t->rcu_read_unlock_special.b.blocked = true;
+	}
 	__rcu_read_unlock();
 	rcu_preempt_deferred_qs(current);
 }
-- 
2.17.1

