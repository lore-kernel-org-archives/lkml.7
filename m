Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91219C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5B221726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbfHBPPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:15:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387655AbfHBPPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:15:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72F6kPu074883
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 11:15:08 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4p3rckvy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 11:15:08 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Aug 2019 16:15:07 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 16:15:02 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72FF1Bl35783164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 15:15:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09DA4B2067;
        Fri,  2 Aug 2019 15:15:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5252B206E;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2E6E316C9A56; Fri,  2 Aug 2019 08:15:02 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop() enable tick on all online CPUs
Date:   Fri,  2 Aug 2019 08:15:01 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802151435.GA1081@linux.ibm.com>
References: <20190802151435.GA1081@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080215-0072-0000-0000-0000045004AA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011538; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01241059; UDB=6.00654493; IPR=6.01022491;
 MB=3.00028010; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-02 15:15:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080215-0073-0000-0000-00004CC104B1
Message-Id: <20190802151501.13069-14-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=558 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The multi_cpu_stop() function relies on the scheduler to gain control from
whatever is running on the various online CPUs, including any nohz_full
CPUs running long loops in kernel-mode code.  Lack of the scheduler-clock
interrupt on such CPUs can delay multi_cpu_stop() for several minutes
and can also result in RCU CPU stall warnings.  This commit therefore
causes multi_cpu_stop() to enable the scheduler-clock interrupt on all
online CPUs.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/stop_machine.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b4f83f7bdf86..a2659f61ed92 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -20,6 +20,7 @@
 #include <linux/smpboot.h>
 #include <linux/atomic.h>
 #include <linux/nmi.h>
+#include <linux/tick.h>
 #include <linux/sched/wake_q.h>
 
 /*
@@ -187,15 +188,19 @@ static int multi_cpu_stop(void *data)
 {
 	struct multi_stop_data *msdata = data;
 	enum multi_stop_state curstate = MULTI_STOP_NONE;
-	int cpu = smp_processor_id(), err = 0;
+	int cpu, err = 0;
 	const struct cpumask *cpumask;
 	unsigned long flags;
 	bool is_active;
 
+	for_each_online_cpu(cpu)
+		tick_nohz_dep_set_cpu(cpu, TICK_DEP_MASK_RCU);
+
 	/*
 	 * When called from stop_machine_from_inactive_cpu(), irq might
 	 * already be disabled.  Save the state and restore it on exit.
 	 */
+	cpu = smp_processor_id();
 	local_save_flags(flags);
 
 	if (!msdata->active_cpus) {
@@ -236,6 +241,8 @@ static int multi_cpu_stop(void *data)
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);
+	for_each_online_cpu(cpu)
+		tick_nohz_dep_clear_cpu(cpu, TICK_DEP_MASK_RCU);
 	return err;
 }
 
-- 
2.17.1

