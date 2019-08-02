Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67798C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1E421726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389385AbfHBPPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:15:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732141AbfHBPPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:15:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72F8Pu7062470
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 11:15:08 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4p3ev090-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 11:15:08 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Aug 2019 16:15:07 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 16:15:02 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72FF1T450397458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 15:15:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22508B2068;
        Fri,  2 Aug 2019 15:15:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E39B2B206C;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2A72E16C9A55; Fri,  2 Aug 2019 08:15:02 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC tip/core/rcu 13/14] rcutorture: Force on tick for readers and callback flooders
Date:   Fri,  2 Aug 2019 08:15:00 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802151435.GA1081@linux.ibm.com>
References: <20190802151435.GA1081@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080215-2213-0000-0000-000003B904C5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011538; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01241059; UDB=6.00654494; IPR=6.01022491;
 MB=3.00028010; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-02 15:15:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080215-2214-0000-0000-00005F7E5AAB
Message-Id: <20190802151501.13069-13-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Readers and callback flooders in the rcutorture stress-test suite run for
extended time periods by design.  They do take pains to relinquish the
CPU from time to time, but in some cases this relies on the scheduler
being active, which in turn relies on the scheduler-clock interrupt
firing from time to time.

This commit therefore forces scheduling-clock interrupts within
these loops.  While in the area, this commit also prevents
rcu_torture_reader()'s occasional timed sleeps from delaying shutdown.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcutorture.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3c9feca1eab1..bf08aa783ecc 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -44,6 +44,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/sysctl.h>
 #include <linux/oom.h>
+#include <linux/tick.h>
 
 #include "rcu.h"
 
@@ -1363,15 +1364,16 @@ rcu_torture_reader(void *arg)
 	set_user_nice(current, MAX_NICE);
 	if (irqreader && cur_ops->irq_capable)
 		timer_setup_on_stack(&t, rcu_torture_timer, 0);
-
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_set_task(current, TICK_DEP_MASK_RCU);
 	do {
 		if (irqreader && cur_ops->irq_capable) {
 			if (!timer_pending(&t))
 				mod_timer(&t, jiffies + 1);
 		}
-		if (!rcu_torture_one_read(&rand))
+		if (!rcu_torture_one_read(&rand) && !torture_must_stop())
 			schedule_timeout_interruptible(HZ);
-		if (time_after(jiffies, lastsleep)) {
+		if (time_after(jiffies, lastsleep) && !torture_must_stop()) {
 			schedule_timeout_interruptible(1);
 			lastsleep = jiffies + 10;
 		}
@@ -1383,6 +1385,8 @@ rcu_torture_reader(void *arg)
 		del_timer_sync(&t);
 		destroy_timer_on_stack(&t);
 	}
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_clear_task(current, TICK_DEP_MASK_RCU);
 	torture_kthread_stopping("rcu_torture_reader");
 	return 0;
 }
@@ -1729,10 +1733,10 @@ static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
 		// Real call_rcu() floods hit userspace, so emulate that.
 		if (need_resched() || (iter & 0xfff))
 			schedule();
-	} else {
-		// No userspace emulation: CB invocation throttles call_rcu()
-		cond_resched();
+		return;
 	}
+	// No userspace emulation: CB invocation throttles call_rcu()
+	cond_resched();
 }
 
 /*
@@ -1781,6 +1785,8 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 		init_rcu_head_on_stack(&fcs.rh);
 		selfpropcb = true;
 	}
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_set_task(current, TICK_DEP_MASK_RCU);
 
 	/* Tight loop containing cond_resched(). */
 	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
@@ -1826,6 +1832,8 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 		destroy_rcu_head_on_stack(&fcs.rh);
 	}
 	schedule_timeout_uninterruptible(HZ / 10); /* Let kthreads recover. */
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_clear_task(current, TICK_DEP_MASK_RCU);
 	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
 }
 
@@ -1865,6 +1873,8 @@ static void rcu_torture_fwd_prog_cr(void)
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
 	rcu_launder_gp_seq_start = gps;
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_set_task(current, TICK_DEP_MASK_RCU);
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
@@ -1911,6 +1921,8 @@ static void rcu_torture_fwd_prog_cr(void)
 		rcu_torture_fwd_cb_hist();
 	}
 	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_clear_task(current, TICK_DEP_MASK_RCU);
 	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
 }
 
-- 
2.17.1

