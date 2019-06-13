Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E360DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C145621537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFMXaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:30:01 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40670 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbfFMXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:30:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TU6DYEz_1560468591;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU6DYEz_1560468591)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jun 2019 07:29:59 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/9] mm: Introduce migrate target nodemask
Date:   Fri, 14 Jun 2019 07:29:30 +0800
Message-Id: <1560468577-101178-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With more memory types are invented, the system may have heterogeneous
memory hierarchy, i.e. DRAM and PMEM.  Some of them are cheaper and
slower than DRAM, may be good candidates to be used as secondary memory
to store not recently or frequently used data.

Introduce the "migrate target" nodemask for such memory nodes.  The
migrate target could be any memory types which are cheaper and/or
slower than DRAM.  Currently PMEM is one of such memory.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 drivers/acpi/numa.c      | 12 ++++++++++++
 drivers/base/node.c      |  2 ++
 include/linux/nodemask.h |  1 +
 mm/page_alloc.c          |  1 +
 4 files changed, 16 insertions(+)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 3099583..f75adba 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -296,6 +296,18 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 		goto out_err_bad_srat;
 	}
 
+	/*
+	 * The system may have memory hierarchy, some memory may be good
+	 * candidate for migration target, i.e. PMEM is one of them.  Mark
+	 * such memory as migration target.
+	 *
+	 * It may be better to retrieve such information from HMAT, but
+	 * SRAT sounds good enough for now.  May switch to HMAT in the
+	 * future.
+	 */ 
+	if (ma->flags & ACPI_SRAT_MEM_NON_VOLATILE)
+		node_set_state(node, N_MIGRATE_TARGET);
+
 	node_set(node, numa_nodes_parsed);
 
 	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 4d80fc8..351b694 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -985,6 +985,7 @@ static ssize_t show_node_state(struct device *dev,
 	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
 	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
 	[N_CPU_MEM] = _NODE_ATTR(primary, N_CPU_MEM),
+	[N_MIGRATE_TARGET] = _NODE_ATTR(migrate_target, N_MIGRATE_TARGET),
 };
 
 static struct attribute *node_state_attrs[] = {
@@ -997,6 +998,7 @@ static ssize_t show_node_state(struct device *dev,
 	&node_state_attr[N_MEMORY].attr.attr,
 	&node_state_attr[N_CPU].attr.attr,
 	&node_state_attr[N_CPU_MEM].attr.attr,
+	&node_state_attr[N_MIGRATE_TARGET].attr.attr,
 	NULL
 };
 
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 66a8964..411618c 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -400,6 +400,7 @@ enum node_states {
 	N_MEMORY,		/* The node has memory(regular, high, movable) */
 	N_CPU,			/* The node has one or more cpus */
 	N_CPU_MEM,		/* The node has both cpus and memory */
+	N_MIGRATE_TARGET,	/* The node is suitable migrate target */
 	NR_NODE_STATES
 };
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 757db89e..3b37c71 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -125,6 +125,7 @@ struct pcpu_drain {
 	[N_MEMORY] = { { [0] = 1UL } },
 	[N_CPU] = { { [0] = 1UL } },
 	[N_CPU_MEM] = { { [0] = 1UL } },
+	[N_MIGRATE_TARGET] = { { [0] = 1UL } },
 #endif	/* NUMA */
 };
 EXPORT_SYMBOL(node_states);
-- 
1.8.3.1

