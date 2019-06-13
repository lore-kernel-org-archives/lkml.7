Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B87C46477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195A221537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfFMXaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:30:05 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:47063 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbfFMXaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:30:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TU6DYEz_1560468591;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU6DYEz_1560468591)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jun 2019 07:29:58 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/9] mm: define N_CPU_MEM node states
Date:   Fri, 14 Jun 2019 07:29:29 +0800
Message-Id: <1560468577-101178-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel has some pre-defined node masks called node states, i.e.
N_MEMORY, N_CPU, etc.  But, there might be cpuless nodes, i.e. PMEM
nodes, and some architectures, i.e. Power, may have memoryless nodes.
It is not very straight forward to get the nodes with both CPUs and
memory.  So, define N_CPU_MEMORY node states.  The nodes with both CPUs
and memory are called "primary" nodes.  /sys/devices/system/node/primary
would show the current online "primary" nodes.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 drivers/base/node.c      |  2 ++
 include/linux/nodemask.h |  3 ++-
 mm/memory_hotplug.c      |  6 ++++++
 mm/page_alloc.c          |  1 +
 mm/vmstat.c              | 11 +++++++++--
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 8598fcb..4d80fc8 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -984,6 +984,7 @@ static ssize_t show_node_state(struct device *dev,
 #endif
 	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
 	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
+	[N_CPU_MEM] = _NODE_ATTR(primary, N_CPU_MEM),
 };
 
 static struct attribute *node_state_attrs[] = {
@@ -995,6 +996,7 @@ static ssize_t show_node_state(struct device *dev,
 #endif
 	&node_state_attr[N_MEMORY].attr.attr,
 	&node_state_attr[N_CPU].attr.attr,
+	&node_state_attr[N_CPU_MEM].attr.attr,
 	NULL
 };
 
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 27e7fa3..66a8964 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -398,7 +398,8 @@ enum node_states {
 	N_HIGH_MEMORY = N_NORMAL_MEMORY,
 #endif
 	N_MEMORY,		/* The node has memory(regular, high, movable) */
-	N_CPU,		/* The node has one or more cpus */
+	N_CPU,			/* The node has one or more cpus */
+	N_CPU_MEM,		/* The node has both cpus and memory */
 	NR_NODE_STATES
 };
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 328878b..7c29282 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -709,6 +709,9 @@ static void node_states_set_node(int node, struct memory_notify *arg)
 
 	if (arg->status_change_nid >= 0)
 		node_set_state(node, N_MEMORY);
+
+	if (node_state(node, N_CPU))
+		node_set_state(node, N_CPU_MEM);
 }
 
 static void __meminit resize_zone_range(struct zone *zone, unsigned long start_pfn,
@@ -1526,6 +1529,9 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
 
 	if (arg->status_change_nid >= 0)
 		node_clear_state(node, N_MEMORY);
+
+	if (node_state(node, N_CPU))
+		node_clear_state(node, N_CPU_MEM);
 }
 
 static int __ref __offline_pages(unsigned long start_pfn,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b13d39..757db89e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -124,6 +124,7 @@ struct pcpu_drain {
 #endif
 	[N_MEMORY] = { { [0] = 1UL } },
 	[N_CPU] = { { [0] = 1UL } },
+	[N_CPU_MEM] = { { [0] = 1UL } },
 #endif	/* NUMA */
 };
 EXPORT_SYMBOL(node_states);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a7d4933..d876ac0 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1905,15 +1905,22 @@ static void __init init_cpu_node_state(void)
 	int node;
 
 	for_each_online_node(node) {
-		if (cpumask_weight(cpumask_of_node(node)) > 0)
+		if (cpumask_weight(cpumask_of_node(node)) > 0) {
 			node_set_state(node, N_CPU);
+			if (node_state(node, N_MEMORY))
+				node_set_state(node, N_CPU_MEM);
+		}
 	}
 }
 
 static int vmstat_cpu_online(unsigned int cpu)
 {
+	int node = cpu_to_node(cpu);
+
 	refresh_zone_stat_thresholds();
-	node_set_state(cpu_to_node(cpu), N_CPU);
+	node_set_state(node, N_CPU);
+	if (node_state(node, N_MEMORY))
+		node_set_state(node, N_CPU_MEM);
 	return 0;
 }
 
-- 
1.8.3.1

