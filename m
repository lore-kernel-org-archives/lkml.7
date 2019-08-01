Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64589C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34614206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390330AbfHAXI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:08:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732946AbfHAXIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:08:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71N7MAs143660;
        Thu, 1 Aug 2019 19:08:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u47v133f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:13 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71N8CqU146324;
        Thu, 1 Aug 2019 19:08:12 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u47v133ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:12 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71N4w93007170;
        Thu, 1 Aug 2019 23:08:12 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2u0e8701sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 23:08:12 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71N8BmZ53739974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:08:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 430DFB2064;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16086B205F;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:08:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 35DAB16C0E4B; Thu,  1 Aug 2019 16:08:12 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 07/18] rcu/nocb: Allow lockless use of rcu_segcblist_restempty()
Date:   Thu,  1 Aug 2019 16:07:59 -0700
Message-Id: <20190801230810.21570-7-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801230744.GA19115@linux.ibm.com>
References: <20190801230744.GA19115@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rcu_segcblist_restempty() assumes that the callback list
is not being changed by other CPUs, but upcoming changes will require
it to operate locklessly.  This commit therefore adds the needed
READ_ONCE() calls, along with the WRITE_ONCE() calls when updating
the callback list.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcu_segcblist.c | 30 +++++++++++++++---------------
 kernel/rcu/rcu_segcblist.h |  2 +-
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 700779f4c0cb..0e7fe678b6ac 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -147,8 +147,8 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 		rsclp->len_lazy++;
 	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
 	rhp->next = NULL;
-	*rsclp->tails[RCU_NEXT_TAIL] = rhp;
-	rsclp->tails[RCU_NEXT_TAIL] = &rhp->next;
+	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
+	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
 }
 
 /*
@@ -176,9 +176,9 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] != rsclp->tails[i - 1])
 			break;
-	*rsclp->tails[i] = rhp;
+	WRITE_ONCE(*rsclp->tails[i], rhp);
 	for (; i <= RCU_NEXT_TAIL; i++)
-		rsclp->tails[i] = &rhp->next;
+		WRITE_ONCE(rsclp->tails[i], &rhp->next);
 	return true;
 }
 
@@ -214,11 +214,11 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 		return; /* Nothing to do. */
 	*rclp->tail = rsclp->head;
 	rsclp->head = *rsclp->tails[RCU_DONE_TAIL];
-	*rsclp->tails[RCU_DONE_TAIL] = NULL;
+	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
 	rclp->tail = rsclp->tails[RCU_DONE_TAIL];
 	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
-			rsclp->tails[i] = &rsclp->head;
+			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
 }
 
 /*
@@ -237,9 +237,9 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 		return; /* Nothing to do. */
 	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
 	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
-	*rsclp->tails[RCU_DONE_TAIL] = NULL;
+	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
 	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
-		rsclp->tails[i] = rsclp->tails[RCU_DONE_TAIL];
+		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
 }
 
 /*
@@ -271,7 +271,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 	rsclp->head = rclp->head;
 	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
 		if (&rsclp->head == rsclp->tails[i])
-			rsclp->tails[i] = rclp->tail;
+			WRITE_ONCE(rsclp->tails[i], rclp->tail);
 		else
 			break;
 	rclp->head = NULL;
@@ -287,8 +287,8 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 {
 	if (!rclp->head)
 		return; /* Nothing to do. */
-	*rsclp->tails[RCU_NEXT_TAIL] = rclp->head;
-	rsclp->tails[RCU_NEXT_TAIL] = rclp->tail;
+	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
+	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
 	rclp->head = NULL;
 	rclp->tail = &rclp->head;
 }
@@ -312,7 +312,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
 		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
 			break;
-		rsclp->tails[RCU_DONE_TAIL] = rsclp->tails[i];
+		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
 	}
 
 	/* If no callbacks moved, nothing more need be done. */
@@ -321,7 +321,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 
 	/* Clean up tail pointers that might have been misordered above. */
 	for (j = RCU_WAIT_TAIL; j < i; j++)
-		rsclp->tails[j] = rsclp->tails[RCU_DONE_TAIL];
+		WRITE_ONCE(rsclp->tails[j], rsclp->tails[RCU_DONE_TAIL]);
 
 	/*
 	 * Callbacks moved, so clean up the misordered ->tails[] pointers
@@ -332,7 +332,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 	for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++, j++) {
 		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
 			break;  /* No more callbacks. */
-		rsclp->tails[j] = rsclp->tails[i];
+		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
 		rsclp->gp_seq[j] = rsclp->gp_seq[i];
 	}
 }
@@ -397,7 +397,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * structure other than in the RCU_NEXT_TAIL segment.
 	 */
 	for (; i < RCU_NEXT_TAIL; i++) {
-		rsclp->tails[i] = rsclp->tails[RCU_NEXT_TAIL];
+		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_NEXT_TAIL]);
 		rsclp->gp_seq[i] = seq;
 	}
 	return true;
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 8f3783391075..f74960f0305c 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -79,7 +79,7 @@ static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
  */
 static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 {
-	return !*rsclp->tails[seg];
+	return !READ_ONCE(*READ_ONCE(rsclp->tails[seg]));
 }
 
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
-- 
2.17.1

