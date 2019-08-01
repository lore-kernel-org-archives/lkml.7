Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24928C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0F0206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390072AbfHAWul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:50:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390043AbfHAWuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:50:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MlMVD058127
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 18:50:36 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u46duwqch-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:50:36 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:50:35 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:50:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MoTgl15663600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:50:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1594B206C;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCD26B2079;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DF9ED16C9A54; Thu,  1 Aug 2019 15:50:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 10/11] rcu/nocb: Rename rcu_nocb_leader_stride kernel boot parameter
Date:   Thu,  1 Aug 2019 15:50:27 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801225009.GA17155@linux.ibm.com>
References: <20190801225009.GA17155@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080122-0060-0000-0000-00000367718D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240738; UDB=6.00654297; IPR=6.01022163;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 22:50:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0061-0000-0000-00004A627D3F
Message-Id: <20190801225028.18225-10-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit changes the name of the rcu_nocb_leader_stride kernel
boot parameter to rcu_nocb_gp_stride in order to account for the new
distinction between callback and grace-period no-CBs kthreads.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++------
 kernel/rcu/tree_plugin.h                        |  8 ++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f3fcd6140ee1..79b983bedcaa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3837,12 +3837,13 @@
 			RCU_BOOST is not set, valid values are 0-99 and
 			the default is zero (non-realtime operation).
 
-	rcutree.rcu_nocb_leader_stride= [KNL]
-			Set the number of NOCB kthread groups, which
-			defaults to the square root of the number of
-			CPUs.  Larger numbers reduces the wakeup overhead
-			on the per-CPU grace-period kthreads, but increases
-			that same overhead on each group's leader.
+	rcutree.rcu_nocb_gp_stride= [KNL]
+			Set the number of NOCB callback kthreads in
+			each group, which defaults to the square root
+			of the number of CPUs.	Larger numbers reduce
+			the wakeup overhead on the global grace-period
+			kthread, but increases that same overhead on
+			each group's NOCB grace-period kthread.
 
 	rcutree.qhimark= [KNL]
 			Set threshold of queued RCU callbacks beyond which
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index be065aacd63b..80b27a9f306d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2126,8 +2126,8 @@ static void __init rcu_spawn_nocb_kthreads(void)
 }
 
 /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
-static int rcu_nocb_leader_stride = -1;
-module_param(rcu_nocb_leader_stride, int, 0444);
+static int rcu_nocb_gp_stride = -1;
+module_param(rcu_nocb_gp_stride, int, 0444);
 
 /*
  * Initialize GP-CB relationships for all no-CBs CPU.
@@ -2135,7 +2135,7 @@ module_param(rcu_nocb_leader_stride, int, 0444);
 static void __init rcu_organize_nocb_kthreads(void)
 {
 	int cpu;
-	int ls = rcu_nocb_leader_stride;
+	int ls = rcu_nocb_gp_stride;
 	int nl = 0;  /* Next GP kthread. */
 	struct rcu_data *rdp;
 	struct rcu_data *rdp_gp = NULL;  /* Suppress misguided gcc warn. */
@@ -2145,7 +2145,7 @@ static void __init rcu_organize_nocb_kthreads(void)
 		return;
 	if (ls == -1) {
 		ls = int_sqrt(nr_cpu_ids);
-		rcu_nocb_leader_stride = ls;
+		rcu_nocb_gp_stride = ls;
 	}
 
 	/*
-- 
2.17.1

