Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E48C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26CD2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="li7YnFoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfC2PV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:21:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41594 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbfC2PVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:21:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TFJ9uR067555;
        Fri, 29 Mar 2019 15:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=yXQMczNgjul7VL930c3ZTKnC2uen09i4zxBNa94N9kE=;
 b=li7YnFoUTEpkTNDgDsCO6dnPR1b8kId+fPfnZKGZLR32Uh+H2eHA07gjQjiq/k06qnnV
 5DdoJ2qBZ3fS8SJL1pUumU+oiRlT7iRGsEj//hYrt28Nbx5qewY0pEynMjx23x7EjOtz
 cM8N1vo6z8SiSQbAnJpfr4Gn12182Z0wgLjjsdST5ak8n9u/wodzHMS5U57VTNA19a0p
 2nVmxGehbCjUISOBWM+PEKREkdFlbI1uoowi3vGAa0Z/lnULZB576/JyYyPQlpPEj0on
 jFRy65a6pRCIDpmlzfPwbFd5z/r47SOVik/sBmBpPjJgH1jFOn8OXGWdHiI/HZkOPhSm Hw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2re6g1d3g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:20:23 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2TFKMnB012620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:20:22 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2TFKK9W012711;
        Fri, 29 Mar 2019 15:20:20 GMT
Received: from ol-bur-x5-4.us.oracle.com (/10.152.128.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 08:20:20 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: [PATCH v2 4/5] locking/qspinlock: Introduce starvation avoidance into CNA
Date:   Fri, 29 Mar 2019 11:20:05 -0400
Message-Id: <20190329152006.110370-5-alex.kogan@oracle.com>
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

Choose the next lock holder among spinning threads running on the same
node with high probability rather than always. With small probability,
hand the lock to the first thread in the secondary queue or, if that
queue is empty, to the immediate successor of the current lock holder
in the main queue.  Thus, assuming no failures while threads hold the
lock, every thread would be able to acquire the lock after a bounded
number of lock transitions, with high probability.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 55 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 5bc5fd9586ea..5addf6439326 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -3,6 +3,8 @@
 #error "do not include this file"
 #endif
 
+#include <linux/random.h>
+
 /*
  * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
  *
@@ -15,7 +17,9 @@
  * secondary queue, and the lock is passed to T. If such T is not found, the
  * lock is passed to the first node in the secondary queue. Finally, if the
  * secondary queue is empty, the lock is passed to the next thread in the
- * main queue.
+ * main queue. To avoid starvation of threads in the secondary queue,
+ * those threads are moved back to the head of the main queue
+ * after a certain expected number of intra-node lock hand-offs.
  *
  * For details, see https://arxiv.org/abs/1810.05600.
  *
@@ -25,6 +29,18 @@
 
 #define MCS_NODE(ptr) ((struct mcs_spinlock *)(ptr))
 
+/* Per-CPU pseudo-random number seed */
+static DEFINE_PER_CPU(u32, seed);
+
+/*
+ * Controls the probability for intra-node lock hand-off. It can be
+ * tuned and depend, e.g., on the number of CPUs per node. For now,
+ * choose a value that provides reasonable long-term fairness without
+ * sacrificing performance compared to a version that does not have any
+ * fairness guarantees.
+ */
+#define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
+
 static inline __pure int decode_numa_node(u32 node_and_count)
 {
 	int node = (node_and_count >> _Q_NODE_OFFSET) - 1;
@@ -102,6 +118,35 @@ static struct mcs_spinlock *find_successor(struct mcs_spinlock *me)
 	return NULL;
 }
 
+/*
+ * xorshift function for generating pseudo-random numbers:
+ * https://en.wikipedia.org/wiki/Xorshift
+ */
+static inline u32 xor_random(void)
+{
+	u32 v;
+
+	v = this_cpu_read(seed);
+	if (v == 0)
+		get_random_bytes(&v, sizeof(u32));
+
+	v ^= v << 6;
+	v ^= v >> 21;
+	v ^= v << 7;
+	this_cpu_write(seed, v);
+
+	return v;
+}
+
+/*
+ * Return false with probability 1 / @range.
+ * @range must be a power of 2.
+ */
+static bool probably(unsigned int range)
+{
+	return xor_random() & (range - 1);
+}
+
 static __always_inline int get_node_index(struct mcs_spinlock *node)
 {
 	return decode_count(node->node_and_count++);
@@ -151,7 +196,13 @@ static inline void pass_mcs_lock(struct mcs_spinlock *node,
 {
 	struct mcs_spinlock *succ = NULL;
 
-	succ = find_successor(node);
+	/*
+	 * Try to pass the lock to a thread running on the same node.
+	 * For long-term fairness, search for such a thread with high
+	 * probability rather than always.
+	 */
+	if (probably(INTRA_NODE_HANDOFF_PROB_ARG))
+		succ = find_successor(node);
 
 	if (succ) {
 		arch_mcs_spin_unlock_contended(&succ->locked, node->locked);
-- 
2.11.0 (Apple Git-81)

