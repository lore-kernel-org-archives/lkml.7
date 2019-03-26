Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A028C10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CA02087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfCZXWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:22:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732884AbfCZXWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:22:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNItbS098893
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rft2r0dxj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:22:32 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:22:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNMPRg18874594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:22:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7757B206C;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99011B2068;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:22:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B398B16C60F3; Tue, 26 Mar 2019 16:22:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 01/11] rcu: Move RCU CPU stall-warning code out of update.c
Date:   Tue, 26 Mar 2019 16:22:15 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326232208.GA20384@linux.ibm.com>
References: <20190326232208.GA20384@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0072-0000-0000-00000410BB4F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180136; UDB=6.00617574; IPR=6.00960851;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:22:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0073-0000-0000-00004B9D5B97
Message-Id: <20190326232225.21332-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU CPU stall-warning code for normal grace periods is currently
scattered across three files, due to earlier Tiny RCU support for RCU
CPU stall warnings and for old Kconfig options that have long since
been retired.  Given that it is hard for the lead RCU maintainer to
find relevant stall-warning code, it would be good to consolidate it.
This commit starts this process by moving stall-warning code from
kernel/rcu/update.c to a new kernel/rcu/tree_stall.h file.

Note that the definitions of rcu_cpu_stall_suppress and
rcu_cpu_stall_timeout must remain in kernel/rcu/update.h to provide
compatibility for kernel boot parameter lists.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcu.h        |  1 +
 kernel/rcu/tree.c       |  1 +
 kernel/rcu/tree_stall.h | 63 +++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/update.c     | 59 +-------------------------------------
 4 files changed, 66 insertions(+), 58 deletions(-)
 create mode 100644 kernel/rcu/tree_stall.h

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index acee72c0b24b..4b58c907b4b7 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -233,6 +233,7 @@ static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
 #ifdef CONFIG_RCU_STALL_COMMON
 
 extern int rcu_cpu_stall_suppress;
+extern int rcu_cpu_stall_timeout;
 int rcu_jiffies_till_stall_check(void);
 
 #define rcu_ftrace_dump_stall_suppress() \
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index acd6ccf56faf..424d50ccf9e6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3858,5 +3858,6 @@ void __init rcu_init(void)
 	srcu_init();
 }
 
+#include "tree_stall.h"
 #include "tree_exp.h"
 #include "tree_plugin.h"
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
new file mode 100644
index 000000000000..682189f4d083
--- /dev/null
+++ b/kernel/rcu/tree_stall.h
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RCU CPU stall warnings for normal RCU grace periods
+ *
+ * Copyright IBM Corporation, 2019
+ *
+ * Author: Paul E. McKenney <paulmck@linux.ibm.com>
+ */
+
+
+#ifdef CONFIG_PROVE_RCU
+#define RCU_STALL_DELAY_DELTA	       (5 * HZ)
+#else
+#define RCU_STALL_DELAY_DELTA	       0
+#endif
+
+int rcu_jiffies_till_stall_check(void)
+{
+	int till_stall_check = READ_ONCE(rcu_cpu_stall_timeout);
+
+	/*
+	 * Limit check must be consistent with the Kconfig limits
+	 * for CONFIG_RCU_CPU_STALL_TIMEOUT.
+	 */
+	if (till_stall_check < 3) {
+		WRITE_ONCE(rcu_cpu_stall_timeout, 3);
+		till_stall_check = 3;
+	} else if (till_stall_check > 300) {
+		WRITE_ONCE(rcu_cpu_stall_timeout, 300);
+		till_stall_check = 300;
+	}
+	return till_stall_check * HZ + RCU_STALL_DELAY_DELTA;
+}
+EXPORT_SYMBOL_GPL(rcu_jiffies_till_stall_check);
+
+void rcu_sysrq_start(void)
+{
+	if (!rcu_cpu_stall_suppress)
+		rcu_cpu_stall_suppress = 2;
+}
+
+void rcu_sysrq_end(void)
+{
+	if (rcu_cpu_stall_suppress == 2)
+		rcu_cpu_stall_suppress = 0;
+}
+
+static int rcu_panic(struct notifier_block *this, unsigned long ev, void *ptr)
+{
+	rcu_cpu_stall_suppress = 1;
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block rcu_panic_block = {
+	.notifier_call = rcu_panic,
+};
+
+static int __init check_cpu_stall_init(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list, &rcu_panic_block);
+	return 0;
+}
+early_initcall(check_cpu_stall_init);
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index cbaa976c5945..c3bf44ba42e5 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -424,68 +424,11 @@ EXPORT_SYMBOL_GPL(do_trace_rcu_torture_read);
 #endif
 
 #ifdef CONFIG_RCU_STALL_COMMON
-
-#ifdef CONFIG_PROVE_RCU
-#define RCU_STALL_DELAY_DELTA	       (5 * HZ)
-#else
-#define RCU_STALL_DELAY_DELTA	       0
-#endif
-
 int rcu_cpu_stall_suppress __read_mostly; /* 1 = suppress stall warnings. */
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
-static int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
-
 module_param(rcu_cpu_stall_suppress, int, 0644);
+int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
 module_param(rcu_cpu_stall_timeout, int, 0644);
-
-int rcu_jiffies_till_stall_check(void)
-{
-	int till_stall_check = READ_ONCE(rcu_cpu_stall_timeout);
-
-	/*
-	 * Limit check must be consistent with the Kconfig limits
-	 * for CONFIG_RCU_CPU_STALL_TIMEOUT.
-	 */
-	if (till_stall_check < 3) {
-		WRITE_ONCE(rcu_cpu_stall_timeout, 3);
-		till_stall_check = 3;
-	} else if (till_stall_check > 300) {
-		WRITE_ONCE(rcu_cpu_stall_timeout, 300);
-		till_stall_check = 300;
-	}
-	return till_stall_check * HZ + RCU_STALL_DELAY_DELTA;
-}
-EXPORT_SYMBOL_GPL(rcu_jiffies_till_stall_check);
-
-void rcu_sysrq_start(void)
-{
-	if (!rcu_cpu_stall_suppress)
-		rcu_cpu_stall_suppress = 2;
-}
-
-void rcu_sysrq_end(void)
-{
-	if (rcu_cpu_stall_suppress == 2)
-		rcu_cpu_stall_suppress = 0;
-}
-
-static int rcu_panic(struct notifier_block *this, unsigned long ev, void *ptr)
-{
-	rcu_cpu_stall_suppress = 1;
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block rcu_panic_block = {
-	.notifier_call = rcu_panic,
-};
-
-static int __init check_cpu_stall_init(void)
-{
-	atomic_notifier_chain_register(&panic_notifier_list, &rcu_panic_block);
-	return 0;
-}
-early_initcall(check_cpu_stall_init);
-
 #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
 
 #ifdef CONFIG_TASKS_RCU
-- 
2.17.1

