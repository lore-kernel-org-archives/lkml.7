Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B51FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D384D21848
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfKGBns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:43:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6165 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbfKGBns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:43:48 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 44752C23CA24D6C78A18;
        Thu,  7 Nov 2019 09:43:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 7 Nov 2019 09:43:35 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     yuqi jin <jinyuqi@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michal Hocko <mhocko@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH v3] lib: optimize cpumask_local_spread()
Date:   Thu, 7 Nov 2019 09:44:08 +0800
Message-ID: <1573091048-10595-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuqi jin <jinyuqi@huawei.com>

In the multi-processors and NUMA system, I/O driver will find cpu cores
that which shall be bound IRQ. When cpu cores in the local numa have
been used, it is better to find the node closest to the local numa node,
instead of choosing any online cpu immediately.

On Huawei Kunpeng 920 server, there are 4 NUMA node(0 -3) in the 2-cpu
system(0 - 1). We perform PS (parameter server) business test, the
behavior of the service is that the client initiates a request through
the network card, the server responds to the request after calculation. 
When two PS processes run on node2 and node3 separately and the
network card is located on 'node2' which is in cpu1, the performance
of node2 (26W QPS) and node3 (22W QPS) was different.
It is better that the NIC queues are bound to the cpu1 cores in turn,
then XPS will also be properly initialized, while cpumask_local_spread
only considers the local node. When the number of NIC queues exceeds
the number of cores in the local node, it returns to the online core
directly. So when PS runs on node3 sending a calculated request,
the performance is not as good as the node2. It is considered that
the NIC and other I/O devices shall initialize the interrupt binding,
if the cores of the local node are used up, it is reasonable to return
the node closest to it.

Let's optimize it and find the nearest node through NUMA distance for the
non-local NUMA nodes. The performance will be better if it return the
nearest node than the random node.

After this patch, the performance of the node3 is the same as node2
that is 26W QPS when the network card is still in 'node2'. Since it will
return the closest non-local NUMA code rather than random node, it is no
harm to others at least.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: yuqi jin <jinyuqi@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
ChangeLog from v2:
    1. Change the variables as static and use spinlock to protect;
    2. Give more explantation on test and performance;
 lib/cpumask.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 12 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 0cb672eb107c..b98a2256bc5a 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/memblock.h>
 #include <linux/numa.h>
+#include <linux/spinlock.h>
 
 /**
  * cpumask_next - get the next cpu in a cpumask
@@ -192,18 +193,39 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
 }
 #endif
 
-/**
- * cpumask_local_spread - select the i'th cpu with local numa cpu's first
- * @i: index number
- * @node: local numa_node
- *
- * This function selects an online CPU according to a numa aware policy;
- * local cpus are returned first, followed by non-local ones, then it
- * wraps around.
- *
- * It's not very efficient, but useful for setup.
- */
-unsigned int cpumask_local_spread(unsigned int i, int node)
+static void calc_node_distance(int *node_dist, int node)
+{
+	int i;
+
+	for (i = 0; i < nr_node_ids; i++)
+		node_dist[i] = node_distance(node, i);
+}
+
+static int find_nearest_node(int *node_dist, bool *used)
+{
+	int i, min_dist = node_dist[0], node_id = -1;
+
+	/* Choose the first unused node to compare */
+	for (i = 0; i < nr_node_ids; i++) {
+		if (used[i] == 0) {
+			min_dist = node_dist[i];
+			node_id = i;
+			break;
+		}
+	}
+
+	/* Compare and return the nearest node */
+	for (i = 0; i < nr_node_ids; i++) {
+		if (node_dist[i] < min_dist && used[i] == 0) {
+			min_dist = node_dist[i];
+			node_id = i;
+		}
+	}
+
+	return node_id;
+}
+
+static unsigned int __cpumask_local_spread(unsigned int i, int node)
 {
 	int cpu;
 
@@ -231,4 +253,60 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 	}
 	BUG();
 }
+
+static DEFINE_SPINLOCK(spread_lock);
+/**
+ * cpumask_local_spread - select the i'th cpu with local numa cpu's first
+ * @i: index number
+ * @node: local numa_node
+ *
+ * This function selects an online CPU according to a numa aware policy;
+ * local cpus are returned first, followed by the nearest non-local ones,
+ * then it wraps around.
+ *
+ * It's not very efficient, but useful for setup.
+ */
+unsigned int cpumask_local_spread(unsigned int i, int node)
+{
+	static int node_dist[MAX_NUMNODES];
+	static bool used[MAX_NUMNODES];
+	unsigned long flags;
+	int cpu, j, id;
+
+	/* Wrap: we always want a cpu. */
+	i %= num_online_cpus();
+
+	if (node == NUMA_NO_NODE) {
+		for_each_cpu(cpu, cpu_online_mask)
+			if (i-- == 0)
+				return cpu;
+	} else {
+		if (nr_node_ids > MAX_NUMNODES)
+			return __cpumask_local_spread(i, node);
+
+		spin_lock_irqsave(&spread_lock, flags);
+		memset(used, 0, nr_node_ids * sizeof(bool));
+		calc_node_distance(node_dist, node);
+		for (j = 0; j < nr_node_ids; j++) {
+			id = find_nearest_node(node_dist, used);
+			if (id < 0)
+				break;
+
+			for_each_cpu_and(cpu, cpumask_of_node(id),
+					 cpu_online_mask)
+				if (i-- == 0) {
+					spin_unlock_irqrestore(&spread_lock,
+							       flags);
+					return cpu;
+				}
+			used[id] = 1;
+		}
+		spin_unlock_irqrestore(&spread_lock, flags);
+
+		for_each_cpu(cpu, cpu_online_mask)
+			if (i-- == 0)
+				return cpu;
+	}
+	BUG();
+}
 EXPORT_SYMBOL(cpumask_local_spread);
-- 
2.7.4

