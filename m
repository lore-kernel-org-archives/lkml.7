Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE90BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8982420896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfFMXa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:30:56 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55390 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbfFMXa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:30:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TU6DYEz_1560468591;
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
Subject: [v3 PATCH 3/9] mm: page_alloc: make find_next_best_node find return migration target node
Date:   Fri, 14 Jun 2019 07:29:31 +0800
Message-Id: <1560468577-101178-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need find the cloest migration target node to demote DRAM pages.  Add
"migration" parameter to find_next_best_node() to skip DRAM node on
demand.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/internal.h   | 11 +++++++++++
 mm/page_alloc.c | 14 ++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9eeaf2b..a3181e2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -292,6 +292,17 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
 }
 
+#ifdef CONFIG_NUMA
+extern int find_next_best_node(int node, nodemask_t *used_node_mask,
+			       bool migration);
+#else
+static inline int find_next_best_node(int node, nodemask_t *used_node_mask,
+				      bool migtation)
+{
+	return 0;
+}
+#endif
+
 /* mm/util.c */
 void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct rb_node *rb_parent);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b37c71..917f64d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5425,6 +5425,7 @@ int numa_zonelist_order_handler(struct ctl_table *table, int write,
  * find_next_best_node - find the next node that should appear in a given node's fallback list
  * @node: node whose fallback list we're appending
  * @used_node_mask: nodemask_t of already used nodes
+ * @migration: find next best migration target node
  *
  * We use a number of factors to determine which is the next node that should
  * appear on a given node's fallback list.  The node should not have appeared
@@ -5436,7 +5437,8 @@ int numa_zonelist_order_handler(struct ctl_table *table, int write,
  *
  * Return: node id of the found node or %NUMA_NO_NODE if no node is found.
  */
-static int find_next_best_node(int node, nodemask_t *used_node_mask)
+int find_next_best_node(int node, nodemask_t *used_node_mask,
+			bool migration)
 {
 	int n, val;
 	int min_val = INT_MAX;
@@ -5444,13 +5446,18 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
 	const struct cpumask *tmp = cpumask_of_node(0);
 
 	/* Use the local node if we haven't already */
-	if (!node_isset(node, *used_node_mask)) {
+	if (!node_isset(node, *used_node_mask) &&
+	    !migration) {
 		node_set(node, *used_node_mask);
 		return node;
 	}
 
 	for_each_node_state(n, N_MEMORY) {
 
+		/* Find next best migration target node */
+		if (migration && !node_state(n, N_MIGRATE_TARGET))
+			continue;
+
 		/* Don't want a node to appear more than once */
 		if (node_isset(n, *used_node_mask))
 			continue;
@@ -5482,7 +5489,6 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
 	return best_node;
 }
 
-
 /*
  * Build zonelists ordered by node and zones within node.
  * This results in maximum locality--normal zone overflows into local
@@ -5544,7 +5550,7 @@ static void build_zonelists(pg_data_t *pgdat)
 	nodes_clear(used_mask);
 
 	memset(node_order, 0, sizeof(node_order));
-	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
+	while ((node = find_next_best_node(local_node, &used_mask, false)) >= 0) {
 		/*
 		 * We don't want to pressure a particular node.
 		 * So adding penalty to the first node in same
-- 
1.8.3.1

