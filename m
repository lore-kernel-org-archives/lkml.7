Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D00AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAB72054F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hZfDTYCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfC2PVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:21:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43818 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbfC2PVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:21:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TFJ43L063193;
        Fri, 29 Mar 2019 15:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=w+evLWsMFvjPXIBz6Od7CHW+kfY4wZu8WvnaS4DHA/M=;
 b=hZfDTYClpsOkMfQAvshN+SrkQcURLKQz+yzSCwT7OXdK28xBLXed/kcnhvyst5n1FPZl
 Fbgz+iWhzhTCCELUIVfMUQOGIwqJ8qWoZ+uV5WFKmUDbrq13IbVhakovv8mAunfsq78J
 qO0tSHvWbxttyvHW9bQcVEA0HeHdCuXVq1VogU1sd4pLze8sLI8O65xP5SQ1ODCt+5/T
 RwKVCnNCq6gBV9fDWPtaKNa98Nv5mho5gbTztMt3/xNDFV3Uz9Ovs7ceaGd8r/kPO8pz
 LxjO6aV4QTnGYaM6eM8eIG4jpmcb3NVz6hQ00qgwVIA4xINjVHkJ9HbT4KN80x2ke3hn aw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g1n24q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:20:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TFKMaU017337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:20:22 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TFKIVA017743;
        Fri, 29 Mar 2019 15:20:18 GMT
Received: from ol-bur-x5-4.us.oracle.com (/10.152.128.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 08:20:17 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: [PATCH v2 2/5] locking/qspinlock: Refactor the qspinlock slow path
Date:   Fri, 29 Mar 2019 11:20:03 -0400
Message-Id: <20190329152006.110370-3-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329152006.110370-1-alex.kogan@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9211 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some of the code manipulating MCS nodes into separate functions.
This would allow easier integration of alternative ways to manipulate
those nodes.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock.c | 48 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 5941ce3527ce..074f65b9bedc 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -297,6 +297,43 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
 #endif
 
+static __always_inline int get_node_index(struct mcs_spinlock *node)
+{
+	return node->count++;
+}
+
+static __always_inline void release_mcs_node(struct mcs_spinlock *node)
+{
+	__this_cpu_dec(node->count);
+}
+
+/*
+ * set_locked_empty_mcs - Try to set the spinlock value to _Q_LOCKED_VAL,
+ * and by doing that unlock the MCS lock when its waiting queue is empty
+ * @lock: Pointer to queued spinlock structure
+ * @val: Current value of the lock
+ * @node: Pointer to the MCS node of the lock holder
+ *
+ *  *,*,* -> 0,0,1
+ */
+static __always_inline bool set_locked_empty_mcs(struct qspinlock *lock,
+						 u32 val,
+						 struct mcs_spinlock *node)
+{
+	return atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL);
+}
+
+/*
+ * pass_mcs_lock - pass the MCS lock to the next waiter
+ * @node: Pointer to the MCS node of the lock holder
+ * @next: Pointer to the MCS node of the first waiter in the MCS queue
+ */
+static __always_inline void pass_mcs_lock(struct mcs_spinlock *node,
+					  struct mcs_spinlock *next)
+{
+	arch_mcs_spin_unlock_contended(&next->locked, 1);
+}
+
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
 /**
@@ -406,7 +443,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	qstat_inc(qstat_lock_slowpath, true);
 pv_queue:
 	node = this_cpu_ptr(&qnodes[0].mcs);
-	idx = node->count++;
+	idx = get_node_index(node);
 	tail = encode_tail(smp_processor_id(), idx);
 
 	/*
@@ -541,7 +578,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *       PENDING will make the uncontended transition fail.
 	 */
 	if ((val & _Q_TAIL_MASK) == tail) {
-		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+		if (set_locked_empty_mcs(lock, val, node))
 			goto release; /* No contention */
 	}
 
@@ -558,14 +595,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_spin_unlock_contended(&next->locked, 1);
+	pass_mcs_lock(node, next);
 	pv_kick_node(lock, next);
 
 release:
-	/*
-	 * release the node
-	 */
-	__this_cpu_dec(qnodes[0].mcs.count);
+	release_mcs_node(&qnodes[0].mcs);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
-- 
2.11.0 (Apple Git-81)

