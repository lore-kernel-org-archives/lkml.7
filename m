Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283BECA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048B121D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfKDK1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:27:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727499AbfKDK1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:27:23 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E75C6DF7F8F51AADF68;
        Mon,  4 Nov 2019 18:27:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 4 Nov 2019 18:27:14 +0800
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
Subject: [PATCH v2] lib: optimize cpumask_local_spread()
Date:   Mon, 4 Nov 2019 18:27:48 +0800
Message-ID: <1572863268-28585-1-git-send-email-zhangshaokun@hisilicon.com>
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

In the multi-processor and NUMA system, I/O device may have many numa
nodes belonging to multiple cpus. When we get a local numa, it is
better to find the node closest to the local numa node, instead
of choosing any online cpu immediately.

For the current code, it only considers the local NUMA node and it
doesn't compute the distances between different NUMA nodes for the
non-local NUMA nodes. Let's optimize it and find the nearest node
through NUMA distance. The performance will be better if it return
the nearest node than the random node.

When Parameter Server workload is tested using NIC device on Huawei
Kunpeng 920 SoC:
Without the patch, the performance is 22W QPS;
Added this patch, the performance become better and it is 26W QPS.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: yuqi jin <jinyuqi@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 lib/cpumask.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 81 insertions(+), 12 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 0cb672eb107c..15d8940f32a8 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -192,18 +192,39 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
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
 
@@ -231,4 +252,52 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 	}
 	BUG();
 }
+
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
+	int node_dist[MAX_NUMNODES] = {0};
+	bool used[MAX_NUMNODES] = {0};
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
+		calc_node_distance(node_dist, node);
+		for (j = 0; j < nr_node_ids; j++) {
+			id = find_nearest_node(node_dist, used);
+			if (id < 0)
+				break;
+
+			for_each_cpu_and(cpu, cpumask_of_node(id),
+					 cpu_online_mask)
+				if (i-- == 0)
+					return cpu;
+			used[id] = 1;
+		}
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

