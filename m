Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF036C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875AF204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392654AbfHBPPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:15:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392137AbfHBPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:15:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72F7CfB025441;
        Fri, 2 Aug 2019 11:15:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4n01f6q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 11:15:03 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x72F7eic028198;
        Fri, 2 Aug 2019 11:15:03 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4n01f6nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 11:15:03 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x72FAv7M026242;
        Fri, 2 Aug 2019 15:15:01 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 2u0e85wtxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 15:15:01 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72FF1pM41419066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 15:15:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16233B205F;
        Fri,  2 Aug 2019 15:15:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D50ACB206A;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1ABAF16C9A4F; Fri,  2 Aug 2019 08:15:02 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC tip/core/rcu 10/14] rcu: Allow rcu_do_batch() to dynamically adjust batch sizes
Date:   Fri,  2 Aug 2019 08:14:57 -0700
Message-Id: <20190802151501.13069-10-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802151435.GA1081@linux.ibm.com>
References: <20190802151435.GA1081@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Bimodal behavior of rcu_do_batch() is not really suited to Google
applications like gfe servers.

When a process with millions of sockets exits, closing all files
queues two rcu callbacks per socket.

This eventually reaches the point where RCU enters an emergency
mode, where rcu_do_batch() do not return until whole queue is flushed.

Each rcu callback lasts at least 70 nsec, so with millions of
elements, we easily spend more than 100 msec without rescheduling.

Goal of this patch is to avoid the infamous message like following
"need_resched set for > 51999388 ns (52 ticks) without schedule"

We dynamically adjust the number of elements we process, instead
of 10 / INFINITE choices, we use a floor of ~1 % of current entries.

If the number is above 1000, we switch to a time based limit of 3 msec
per batch, adjustable with /sys/module/rcutree/parameters/rcu_resched_ns

Signed-off-by: Eric Dumazet <edumazet@google.com>
[ paulmck: Forward-port and remove debug statements. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3e89b5b83ea0..71395e91b876 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -56,6 +56,7 @@
 #include <linux/smpboot.h>
 #include <linux/jiffies.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/clock.h>
 #include "../time/tick-internal.h"
 
 #include "tree.h"
@@ -416,6 +417,12 @@ module_param(qlowmark, long, 0444);
 static ulong jiffies_till_first_fqs = ULONG_MAX;
 static ulong jiffies_till_next_fqs = ULONG_MAX;
 static bool rcu_kick_kthreads;
+static int rcu_divisor = 7;
+module_param(rcu_divisor, int, 0644);
+
+/* Force an exit from rcu_do_batch() after 3 milliseconds. */
+static long rcu_resched_ns = 3 * NSEC_PER_MSEC;
+module_param(rcu_resched_ns, long, 0644);
 
 /*
  * How long the grace period must be before we start recruiting
@@ -2109,6 +2116,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count;
+	long pending, tlimit = 0;
 
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
@@ -2130,7 +2138,10 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	local_irq_save(flags);
 	rcu_nocb_lock(rdp);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
-	bl = rdp->blimit;
+	pending = rcu_segcblist_n_cbs(&rdp->cblist);
+	bl = max(rdp->blimit, pending >> rcu_divisor);
+	if (unlikely(bl > 100))
+		tlimit = local_clock() + rcu_resched_ns;
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
@@ -2153,6 +2164,13 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		    (need_resched() ||
 		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
 			break;
+		if (unlikely(tlimit)) {
+			/* only call local_clock() every 32 callbacks */
+			if (likely((-rcl.len & 31) || local_clock() < tlimit))
+				continue;
+			/* Exceeded the time limit, so leave. */
+			break;
+		}
 		if (offloaded) {
 			WARN_ON_ONCE(in_serving_softirq());
 			local_bh_enable();
-- 
2.17.1

