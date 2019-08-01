Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54036C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9592083B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbfHAXQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:16:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732853AbfHAXQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:16:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71NDAxi072144
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 19:16:43 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hahy7y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 19:16:42 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Aug 2019 00:16:41 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 00:16:37 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71NGaJV26804712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:16:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13E08B2068;
        Thu,  1 Aug 2019 23:16:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBC91B206C;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1A9E116C9A2E; Thu,  1 Aug 2019 16:16:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/10] rcu/nocb: Reduce contention at no-CBs invocation-done time
Date:   Thu,  1 Aug 2019 16:16:33 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801231619.GA22610@linux.ibm.com>
References: <20190801231619.GA22610@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080123-0052-0000-0000-000003E776FC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240747; UDB=6.00654302; IPR=6.01022170;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 23:16:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080123-0053-0000-0000-000061EE8DBD
Message-Id: <20190801231636.23115-8-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=609 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, nocb_cb_wait() unconditionally acquires the leaf rcu_node
->lock to advance callbacks when done invoking the previous batch.
It does this while holding ->nocb_lock, which means that contention on
the leaf rcu_node ->lock visits itself on the ->nocb_lock.  This commit
therefore makes this lock acquisition conditional, forgoing callback
advancement when the leaf rcu_node ->lock is not immediately available.
(In this case, the no-CBs grace-period kthread will eventually do any
needed callback advancement.)

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index a1a2fc9df6d8..7fbf2c4411a1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1803,9 +1803,10 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	local_bh_enable();
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
-	raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-	needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
-	raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
+	if (raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
+		needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
+		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
+	}
 	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		if (needwake_gp)
-- 
2.17.1

