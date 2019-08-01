Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A665C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F11206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbfHAXQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:16:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733139AbfHAXQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:16:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71NDANJ129361
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 19:16:42 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u488kadt6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 19:16:41 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Aug 2019 00:16:41 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 00:16:36 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71NGZoF54788428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:16:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A259BB206A;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8407AB2064;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E7BF016C9A39; Thu,  1 Aug 2019 16:16:36 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 01/10] rcu/nocb: Enable re-awakening under high callback load
Date:   Thu,  1 Aug 2019 16:16:26 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801231619.GA22610@linux.ibm.com>
References: <20190801231619.GA22610@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080123-0072-0000-0000-0000044F7380
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240746; UDB=6.00654301; IPR=6.01022170;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 23:16:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080123-0073-0000-0000-00004CC074AA
Message-Id: <20190801231636.23115-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=868 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __call_rcu_nocb_wake() function and its predecessors set
->qlen_last_fqs_check to zero for the first callback and to LONG_MAX / 2
for forced reawakenings.  The former can result in a too-quick reawakening
when there are many callbacks ready to invoke and the latter prevents a
second reawakening.  This commit therefore sets ->qlen_last_fqs_check
to the current number of callbacks in both cases.  While in the area,
this commit also moves both assignments under ->nocb_lock.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c1dfbac8cd39..297b38732e28 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1626,6 +1626,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	// Need to actually to a wakeup.
 	len = rcu_segcblist_n_cbs(&rdp->cblist);
 	if (was_alldone) {
+		rdp->qlen_last_fqs_check = len;
 		if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
 			wake_nocb_gp(rdp, false, flags);
@@ -1636,9 +1637,9 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 					   TPS("WakeEmptyIsDeferred"));
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 		}
-		rdp->qlen_last_fqs_check = 0;
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
 		/* ... or if many callbacks queued. */
+		rdp->qlen_last_fqs_check = len;
 		if (!irqs_disabled_flags(flags)) {
 			wake_nocb_gp(rdp, true, flags);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
@@ -1648,7 +1649,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 					   TPS("WakeOvfIsDeferred"));
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 		}
-		rdp->qlen_last_fqs_check = LONG_MAX / 2;
 	} else {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
-- 
2.17.1

