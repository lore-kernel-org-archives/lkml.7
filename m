Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E831DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5C4206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389739AbfHAWh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:37:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388193AbfHAWhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:37:55 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71Mb6Bo057660
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 18:37:54 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u488k9fqw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:37:54 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:37:53 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:37:48 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MblKW52756766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:37:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19303B2070;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED573B2076;
        Thu,  1 Aug 2019 22:37:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:37:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 52C0416C9A4B; Thu,  1 Aug 2019 15:37:48 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 04/12] rcu: Add kernel parameter to dump trace after RCU CPU stall warning
Date:   Thu,  1 Aug 2019 15:37:39 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801223708.GA14862@linux.ibm.com>
References: <20190801223708.GA14862@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080122-0064-0000-0000-000004057876
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240734; UDB=6.00654294; IPR=6.01022158;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 22:37:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0065-0000-0000-00003E81E9CE
Message-Id: <20190801223747.15560-4-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a rcu_cpu_stall_ftrace_dump kernel boot parameter, that,
when set, causes the trace buffer to be dumped after an RCU CPU stall
warning is printed.  This kernel boot parameter is disabled by default,
maintaining compatibility with previous behavior.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 kernel/rcu/rcu.h                                | 1 +
 kernel/rcu/tree_stall.h                         | 4 ++++
 kernel/rcu/update.c                             | 2 ++
 4 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7ccd158b3894..f3fcd6140ee1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4047,6 +4047,10 @@
 	rcutorture.verbose= [KNL]
 			Enable additional printk() statements.
 
+	rcupdate.rcu_cpu_stall_ftrace_dump= [KNL]
+			Dump ftrace buffer after reporting RCU CPU
+			stall warning.
+
 	rcupdate.rcu_cpu_stall_suppress= [KNL]
 			Suppress RCU CPU stall warning messages.
 
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 5290b01de534..8fd4f82c9b3d 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -227,6 +227,7 @@ static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
 
 #ifdef CONFIG_RCU_STALL_COMMON
 
+extern int rcu_cpu_stall_ftrace_dump;
 extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
 int rcu_jiffies_till_stall_check(void);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 065183391f75..0627a66699a6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -527,6 +527,8 @@ static void check_cpu_stall(struct rcu_data *rdp)
 
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall();
+		if (rcu_cpu_stall_ftrace_dump)
+			rcu_ftrace_dump(DUMP_ALL);
 
 	} else if (rcu_gp_in_progress() &&
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
@@ -534,6 +536,8 @@ static void check_cpu_stall(struct rcu_data *rdp)
 
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(gs2);
+		if (rcu_cpu_stall_ftrace_dump)
+			rcu_ftrace_dump(DUMP_ALL);
 	}
 }
 
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 61df2bf08563..249517058b13 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -437,6 +437,8 @@ EXPORT_SYMBOL_GPL(rcutorture_sched_setaffinity);
 #endif
 
 #ifdef CONFIG_RCU_STALL_COMMON
+int rcu_cpu_stall_ftrace_dump __read_mostly;
+module_param(rcu_cpu_stall_ftrace_dump, int, 0644);
 int rcu_cpu_stall_suppress __read_mostly; /* 1 = suppress stall warnings. */
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
 module_param(rcu_cpu_stall_suppress, int, 0644);
-- 
2.17.1

