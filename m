Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E620C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0895B206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390340AbfHAXI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:08:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732942AbfHAXIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:08:53 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71N7CKQ100356;
        Thu, 1 Aug 2019 19:08:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u46dux61e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:13 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71N7W4B101353;
        Thu, 1 Aug 2019 19:08:12 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u46dux60q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:12 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71N53Bc013053;
        Thu, 1 Aug 2019 23:08:11 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 2u0e85w7ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 23:08:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71N8AFO14025482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:08:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6159B205F;
        Thu,  1 Aug 2019 23:08:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7543B2065;
        Thu,  1 Aug 2019 23:08:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:08:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2081C16C9A46; Thu,  1 Aug 2019 16:08:12 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 03/18] rcu/nocb: Add checks for offloaded callback processing
Date:   Thu,  1 Aug 2019 16:07:55 -0700
Message-Id: <20190801230810.21570-3-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801230744.GA19115@linux.ibm.com>
References: <20190801230744.GA19115@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is a preparatory patch for offloaded callbacks using the
same ->cblist structure used by non-offloaded callbacks.  It therefore
adds rcu_segcblist_is_offloaded() calls where they will be needed when
!rcu_segcblist_is_enabled() no longer flags the offloaded case.  It also
adds checks in rcu_do_batch() to ensure that there are no missed checks:
Currently, it should not be possible for offloaded execution to reach
rcu_do_batch(), though this will change later in this series.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6f5c96c4f9a3..969ba292a669 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -210,7 +210,8 @@ static long rcu_get_n_cbs_cpu(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
-	if (rcu_segcblist_is_enabled(&rdp->cblist)) /* Online normal CPU? */
+	if (rcu_segcblist_is_enabled(&rdp->cblist) &&
+	    !rcu_segcblist_is_offloaded(&rdp->cblist)) /* Online normal CPU? */
 		return rcu_segcblist_n_cbs(&rdp->cblist);
 	return rcu_get_n_cbs_nocb_cpu(rdp); /* Works for offline, too. */
 }
@@ -2081,6 +2082,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count;
 
+	WARN_ON_ONCE(rdp->cblist.offloaded);
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
 		trace_rcu_batch_start(rcu_state.name,
@@ -2299,7 +2301,8 @@ static __latent_entropy void rcu_core(void)
 
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
-	    rcu_segcblist_is_enabled(&rdp->cblist)) {
+	    rcu_segcblist_is_enabled(&rdp->cblist) &&
+	    !rcu_segcblist_is_offloaded(&rdp->cblist)) {
 		local_irq_save(flags);
 		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 			rcu_accelerate_cbs_unlocked(rnp, rdp);
@@ -2514,7 +2517,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, int cpu, bool lazy)
 	rdp = this_cpu_ptr(&rcu_data);
 
 	/* Add the callback to our list. */
-	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist)) || cpu != -1) {
+	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist)) ||
+	    rcu_segcblist_is_offloaded(&rdp->cblist) || cpu != -1) {
 		int offline;
 
 		if (cpu != -1)
@@ -2750,6 +2754,7 @@ static int rcu_pending(void)
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!rcu_gp_in_progress() &&
 	    rcu_segcblist_is_enabled(&rdp->cblist) &&
+	    !rcu_segcblist_is_offloaded(&rdp->cblist) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
-- 
2.17.1

