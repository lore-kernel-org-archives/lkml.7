Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFF3C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD7825CC4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfE3PSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:18:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727913AbfE3PSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:18:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UFIQ7v126461
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:18:36 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stfevfftf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:18:28 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:17:17 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:17:13 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UFHCwE35782870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:17:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03253B2064;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9B83B2068;
        Thu, 30 May 2019 15:17:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:17:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 990CD16C5D85; Thu, 30 May 2019 08:17:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 04/21] rcutorture: Fix stutter_wait() return value and freelist checks
Date:   Thu, 30 May 2019 08:16:55 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530151650.GA422@linux.ibm.com>
References: <20190530151650.GA422@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-0060-0000-0000-00000349F81D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210791; UDB=6.00636161; IPR=6.00991826;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:17:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0061-0000-0000-0000498E0469
Message-Id: <20190530151712.1612-4-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stutter_wait() function is supposed to return true if it actually
waits and false otherwise, but it instead unconditionally returns false.
Which hides a bug in rcu_torture_writer() that fails to account for
the fact that one of the rcu_tortures[] array elements will normally be
referenced by rcu_torture_current, and thus not be on the freelist.

This commit therefore corrects the stutter_wait() return value and adds a
check for rcu_torture_current to rcu_torture_writer()'s check that things
get freed after everything goes quiescent.  In addition, this commit
causes torture_stutter() to give a bit more than one second (instead of
only one jiffy) warning of the end of the stutter interval.  Finally,
this commit disables long-delay readers and aggressive update-side
forward-progress checks while forward-progress testing is in flight.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcutorture.c | 16 ++++++++++++----
 kernel/torture.c        | 17 +++++++++++++----
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7906ba2d9dad..954ac2b98619 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1010,10 +1010,13 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
-		if (stutter_wait("rcu_torture_writer"))
+		if (stutter_wait("rcu_torture_writer") &&
+		    !READ_ONCE(rcu_fwd_cb_nodelay))
 			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
-				if (list_empty(&rcu_tortures[i].rtort_free))
-					WARN_ON_ONCE(1);
+				if (list_empty(&rcu_tortures[i].rtort_free) &&
+				    rcu_access_pointer(rcu_torture_current) !=
+				    &rcu_tortures[i])
+					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 	} while (!torture_must_stop());
 	/* Reset expediting back to unexpedited. */
 	if (expediting > 0)
@@ -1709,6 +1712,8 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 	}
 
 	/* Tight loop containing cond_resched(). */
+	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
+	cur_ops->sync(); /* Later readers see above write. */
 	if  (selfpropcb) {
 		WRITE_ONCE(fcs.stop, 0);
 		cur_ops->call(&fcs.rh, rcu_torture_fwd_prog_cb);
@@ -1747,6 +1752,8 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 		WARN_ON(READ_ONCE(fcs.stop) != 2);
 		destroy_rcu_head_on_stack(&fcs.rh);
 	}
+	schedule_timeout_uninterruptible(HZ / 10); /* Let kthreads recover. */
+	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
 }
 
 /* Carry out call_rcu() forward-progress testing. */
@@ -1816,7 +1823,6 @@ static void rcu_torture_fwd_prog_cr(void)
 	cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
 	(void)rcu_torture_fwd_prog_cbfree();
 
-	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
 	if (!torture_must_stop() && !READ_ONCE(rcu_fwd_emergency_stop)) {
 		WARN_ON(n_max_gps < MIN_FWD_CBS_LAUNDERED);
 		pr_alert("%s Duration %lu barrier: %lu pending %ld n_launders: %ld n_launders_sa: %ld n_max_gps: %ld n_max_cbs: %ld cver %ld gps %ld\n",
@@ -1827,6 +1833,8 @@ static void rcu_torture_fwd_prog_cr(void)
 			 n_max_gps, n_max_cbs, cver, gps);
 		rcu_torture_fwd_cb_hist();
 	}
+	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
+	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
 }
 
 
diff --git a/kernel/torture.c b/kernel/torture.c
index 17b2be9bde12..de0e0ecf88e1 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -578,10 +578,12 @@ static int stutter;
 bool stutter_wait(const char *title)
 {
 	int spt;
+	bool ret = false;
 
 	cond_resched_tasks_rcu_qs();
 	spt = READ_ONCE(stutter_pause_test);
 	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
+		ret = true;
 		if (spt == 1) {
 			schedule_timeout_interruptible(1);
 		} else if (spt == 2) {
@@ -592,7 +594,7 @@ bool stutter_wait(const char *title)
 		}
 		torture_shutdown_absorb(title);
 	}
-	return !!spt;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(stutter_wait);
 
@@ -602,13 +604,20 @@ EXPORT_SYMBOL_GPL(stutter_wait);
  */
 static int torture_stutter(void *arg)
 {
+	int wtime;
+
 	VERBOSE_TOROUT_STRING("torture_stutter task started");
 	do {
 		if (!torture_must_stop() && stutter > 1) {
-			WRITE_ONCE(stutter_pause_test, 1);
-			schedule_timeout_interruptible(stutter - 1);
+			wtime = stutter;
+			if (stutter > HZ + 1) {
+				WRITE_ONCE(stutter_pause_test, 1);
+				wtime = stutter - HZ - 1;
+				schedule_timeout_interruptible(wtime);
+				wtime = HZ + 1;
+			}
 			WRITE_ONCE(stutter_pause_test, 2);
-			schedule_timeout_interruptible(1);
+			schedule_timeout_interruptible(wtime);
 		}
 		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
-- 
2.17.1

