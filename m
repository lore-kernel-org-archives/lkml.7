Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157A2C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AE7255FA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfE3PRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:17:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbfE3PRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:17:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UFHRtF144539
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:17:31 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sthm1g70m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:17:29 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:17:19 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:17:13 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UFHC8930736452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:17:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44A26B2075;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F4DDB206E;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BC50916C5D9F; Thu, 30 May 2019 08:17:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 10/21] rcutorture: Give the scheduler a chance on PREEMPT && NO_HZ_FULL kernels
Date:   Thu, 30 May 2019 08:17:01 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530151650.GA422@linux.ibm.com>
References: <20190530151650.GA422@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-0072-0000-0000-000004354F4A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210791; UDB=6.00636161; IPR=6.00991825;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:17:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0073-0000-0000-00004C6B6B5C
Message-Id: <20190530151712.1612-10-paulmck@linux.ibm.com>
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

In !PREEMPT kernels, cond_resched() is a no-op.  In NO_HZ_FULL kernels,
in-kernel execution (such as that of rcutorture's kthreads) might extend
indefinitely without the scheduler gaining the aid of a scheduling-clock
interrupt.  This combination can make the interaction of an rcutorture
forward-progress test and a CPU-hotplug stop_machine operation make less
forward progress than one might like.  Additionally, Sebastian Siewior
notes that NO_HZ_FULL kernels have a scheduler check upon return to
userspace execution, which suggests that in-kernel emulation of tight
userspace loops containing system calls doing call_rcu() might also need
explicit checks in the PREEMPT && NO_HZ_FULL case.

This commit therefore introduces a rcu_torture_fwd_prog_cond_resched()
function that explicitly invokes schedule() in such kernels whenever
need_resched() returns true, while retaining use of cond_resched()
for kernels that are either !PREEMPT or !NO_HZ_FULL.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcutorture.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6a4558532eac..ef6f6dedf4c4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1667,6 +1667,17 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 	spin_unlock_irqrestore(&rcu_fwd_lock, flags);
 }
 
+// Give the scheduler a chance, even on nohz_full CPUs.
+static void rcu_torture_fwd_prog_cond_resched(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT) && IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+		if (need_resched())
+			schedule();
+	} else {
+		cond_resched();
+	}
+}
+
 /*
  * Free all callbacks on the rcu_fwd_cb_head list, either because the
  * test is over or because we hit an OOM event.
@@ -1690,7 +1701,7 @@ static unsigned long rcu_torture_fwd_prog_cbfree(void)
 		spin_unlock_irqrestore(&rcu_fwd_lock, flags);
 		kfree(rfcp);
 		freed++;
-		cond_resched();
+		rcu_torture_fwd_prog_cond_resched();
 	}
 	return freed;
 }
@@ -1734,7 +1745,7 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 		udelay(10);
 		cur_ops->readunlock(idx);
 		if (!fwd_progress_need_resched || need_resched())
-			cond_resched();
+			rcu_torture_fwd_prog_cond_resched();
 	}
 	(*tested_tries)++;
 	if (!time_before(jiffies, stopat) &&
@@ -1817,7 +1828,7 @@ static void rcu_torture_fwd_prog_cr(void)
 			rfcp->rfc_gps = 0;
 		}
 		cur_ops->call(&rfcp->rh, rcu_torture_fwd_cb_cr);
-		cond_resched();
+		rcu_torture_fwd_prog_cond_resched();
 	}
 	stoppedat = jiffies;
 	n_launders_cb_snap = READ_ONCE(n_launders_cb);
-- 
2.17.1

