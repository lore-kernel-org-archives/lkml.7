Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F9CC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AA525CBF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfE3PTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:19:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbfE3PTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:19:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UFICVM061534;
        Thu, 30 May 2019 11:18:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stf218kx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 11:18:39 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4UFIPFo063401;
        Thu, 30 May 2019 11:18:25 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stf218jq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 11:18:25 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4UDFQ3A006878;
        Thu, 30 May 2019 13:17:26 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 2spwb96tkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 13:17:26 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UFHCuv38273106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:17:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09962B2066;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEC44B206A;
        Thu, 30 May 2019 15:17:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:17:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9FAB116C5D8A; Thu, 30 May 2019 08:17:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/21] torture: Allow inter-stutter interval to be specified
Date:   Thu, 30 May 2019 08:16:56 -0700
Message-Id: <20190530151712.1612-5-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530151650.GA422@linux.ibm.com>
References: <20190530151650.GA422@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the inter-stutter interval is the same as the stutter duration,
that is, whatever number of jiffies is passed into torture_stutter_init().
This has worked well for quite some time, but the addition of
forward-progress testing to rcutorture can delay processes for several
seconds, which can triple the time that they are stuttered.

This commit therefore adds a second argument to torture_stutter_init()
that specifies the inter-stutter interval.  While locktorture preserves
the current behavior, rcutorture uses the RCU CPU stall warning interval
to provide a wider inter-stutter interval.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/torture.h      | 2 +-
 kernel/locking/locktorture.c | 2 +-
 kernel/rcu/rcutorture.c      | 5 ++++-
 kernel/torture.c             | 6 ++++--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 23d80db426d7..a620118385bb 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -66,7 +66,7 @@ int torture_shutdown_init(int ssecs, void (*cleanup)(void));
 
 /* Task stuttering, which forces load/no-load transitions. */
 bool stutter_wait(const char *title);
-int torture_stutter_init(int s);
+int torture_stutter_init(int s, int sgap);
 
 /* Initialization and cleanup. */
 bool torture_init_begin(char *ttype, int v);
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 80a463d31a8d..c513031cd7e3 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -975,7 +975,7 @@ static int __init lock_torture_init(void)
 			goto unwind;
 	}
 	if (stutter > 0) {
-		firsterr = torture_stutter_init(stutter);
+		firsterr = torture_stutter_init(stutter, stutter);
 		if (firsterr)
 			goto unwind;
 	}
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 954ac2b98619..a16d6abe1715 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2373,7 +2373,10 @@ rcu_torture_init(void)
 	if (stutter < 0)
 		stutter = 0;
 	if (stutter) {
-		firsterr = torture_stutter_init(stutter * HZ);
+		int t;
+
+		t = cur_ops->stall_dur ? cur_ops->stall_dur() : stutter * HZ;
+		firsterr = torture_stutter_init(stutter * HZ, t);
 		if (firsterr)
 			goto unwind;
 	}
diff --git a/kernel/torture.c b/kernel/torture.c
index de0e0ecf88e1..a8d9bdfba7c3 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -570,6 +570,7 @@ static void torture_shutdown_cleanup(void)
 static struct task_struct *stutter_task;
 static int stutter_pause_test;
 static int stutter;
+static int stutter_gap;
 
 /*
  * Block until the stutter interval ends.  This must be called periodically
@@ -621,7 +622,7 @@ static int torture_stutter(void *arg)
 		}
 		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
-			schedule_timeout_interruptible(stutter);
+			schedule_timeout_interruptible(stutter_gap);
 		torture_shutdown_absorb("torture_stutter");
 	} while (!torture_must_stop());
 	torture_kthread_stopping("torture_stutter");
@@ -631,9 +632,10 @@ static int torture_stutter(void *arg)
 /*
  * Initialize and kick off the torture_stutter kthread.
  */
-int torture_stutter_init(const int s)
+int torture_stutter_init(const int s, const int sgap)
 {
 	stutter = s;
+	stutter_gap = sgap;
 	return torture_create_kthread(torture_stutter, NULL, stutter_task);
 }
 EXPORT_SYMBOL_GPL(torture_stutter_init);
-- 
2.17.1

