Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D4C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7256321726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391633AbfHBPPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:15:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388504AbfHBPPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:15:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72F6d7I126230
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 11:15:08 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4pjqk6v0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 11:15:08 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Aug 2019 16:15:07 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 16:15:02 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72FF1Xb12452106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 15:15:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09D56B2065;
        Fri,  2 Aug 2019 15:15:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2E85B206B;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2510616C9A53; Fri,  2 Aug 2019 08:15:02 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC tip/core/rcu 12/14] rcu/nohz: Force on tick when invoking lots of callbacks
Date:   Fri,  2 Aug 2019 08:14:59 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802151435.GA1081@linux.ibm.com>
References: <20190802151435.GA1081@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080215-0064-0000-0000-00000405A2A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011538; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01241059; UDB=6.00654494; IPR=6.01022491;
 MB=3.00028010; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-02 15:15:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080215-0065-0000-0000-00003E8452ED
Message-Id: <20190802151501.13069-12-paulmck@linux.ibm.com>
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

Callback invocation can run for a significant time period, and within
CONFIG_NO_HZ_FULL=y kernels, this period will be devoid of scheduler-clock
interrupts.  In-kernel execution without such interrupts can cause all
manner of malfunction, with RCU CPU stall warnings being but one result.

This commit therefore forces scheduling-clock interrupts on whenever more
than a few RCU callbacks are invoked.  Because offloaded callback invocation
can be preempted, this forcing is withdrawn on each context switch.  This
in turn requires that the loop invoking RCU callbacks reiterate the forcing
periodically.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 71395e91b876..b80eb11c19e1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2151,6 +2151,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_set_task(current, TICK_DEP_MASK_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		debug_rcu_head_unqueue(rhp);
@@ -2217,6 +2219,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Re-invoke RCU core processing if there are callbacks remaining. */
 	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
 		invoke_rcu_core();
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_clear_task(current, TICK_DEP_MASK_RCU);
 }
 
 /*
-- 
2.17.1

