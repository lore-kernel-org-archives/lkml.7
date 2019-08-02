Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F678C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF679204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395142AbfHBPQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:16:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389375AbfHBPPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:15:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72F7Vnw070327;
        Fri, 2 Aug 2019 11:15:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4nafec63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 11:15:03 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x72F7m5a071925;
        Fri, 2 Aug 2019 11:15:02 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4nafec52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 11:15:02 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x72FAp1C019938;
        Fri, 2 Aug 2019 15:15:01 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 2u0e85wtd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 15:15:01 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72FF1t750397454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 15:15:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00176B2074;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D45CCB2066;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0DABB16C9A4C; Fri,  2 Aug 2019 08:15:02 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC tip/core/rcu 08/14] rcu/nocb: Reduce __call_rcu_nocb_wake() leaf rcu_node ->lock contention
Date:   Fri,  2 Aug 2019 08:14:55 -0700
Message-Id: <20190802151501.13069-8-paulmck@linux.ibm.com>
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

Currently, __call_rcu_nocb_wake() advances callbacks each time that it
detects excessive numbers of callbacks, though only if it succeeds in
conditionally acquiring its leaf rcu_node structure's ->lock.  Despite
the conditional acquisition of ->lock, this does increase contention.
This commit therefore avoids advancing callbacks unless there are
callbacks in ->cblist whose grace period has completed and advancing
has not yet been done during this jiffy.

Note that this decision does not take the presence of new callbacks
into account.  That is because on this code path, there will always be
at least one new callback, namely the one we just enqueued.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 02739366ef5d..efd7f6fa2790 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1869,6 +1869,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 				 unsigned long flags)
 				 __releases(rdp->nocb_lock)
 {
+	unsigned long cur_gp_seq;
+	unsigned long j;
 	long len;
 	struct task_struct *t;
 
@@ -1897,12 +1899,17 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
 		/* ... or if many callbacks queued. */
 		rdp->qlen_last_fqs_check = len;
-		if (rdp->nocb_cb_sleep ||
-		    !rcu_segcblist_ready_cbs(&rdp->cblist)) {
+		j = jiffies;
+		if (j != rdp->nocb_gp_adv_time &&
+		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
+			rdp->nocb_gp_adv_time = j;
+		}
+		if (rdp->nocb_cb_sleep ||
+		    !rcu_segcblist_ready_cbs(&rdp->cblist))
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
-		}
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 	} else {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
-- 
2.17.1

