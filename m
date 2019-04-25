Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEA0C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699A6206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfDYBmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:42:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:25341 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388188AbfDYBms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:42:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 18:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,391,1549958400"; 
   d="scan'208";a="152134236"
Received: from zz23f_aep_wp03.sh.intel.com ([10.239.85.39])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2019 18:42:47 -0700
From:   Fan Du <fan.du@intel.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, fengguang.wu@intel.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        xishi.qiuxishi@alibaba-inc.com, ying.huang@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Fan Du <fan.du@intel.com>
Subject: [RFC PATCH 4/5] mm, page alloc: build fallback list on per node type basis
Date:   Thu, 25 Apr 2019 09:21:34 +0800
Message-Id: <1556155295-77723-5-git-send-email-fan.du@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556155295-77723-1-git-send-email-fan.du@intel.com>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On box with both DRAM and PMEM managed by mm system,
Usually node 0, 1 are DRAM nodes, nodes 2, 3 are PMEM nodes.
nofallback list are same as before, fallback list are not
redesigned to be arranged by node type basis, iow,
allocation request of DRAM page start from node 0 will go
through node0->node1->node2->node3 zonelists.

Signed-off-by: Fan Du <fan.du@intel.com>
---
 include/linux/mmzone.h |  8 ++++++++
 mm/page_alloc.c        | 42 ++++++++++++++++++++++++++----------------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d3ee9f9..8c37e1c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -939,6 +939,14 @@ static inline int is_node_dram(int nid)
 	return test_bit(PGDAT_DRAM, &pgdat->flags);
 }
 
+static inline int is_node_same_type(int nida, int nidb)
+{
+	if (node_isset(nida, numa_nodes_pmem))
+		return node_isset(nidb, numa_nodes_pmem);
+	else
+		return node_isset(nidb, numa_nodes_dram);
+}
+
 static inline void set_node_type(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c6ce20a..a408a91 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5372,7 +5372,7 @@ int numa_zonelist_order_handler(struct ctl_table *table, int write,
  *
  * Return: node id of the found node or %NUMA_NO_NODE if no node is found.
  */
-static int find_next_best_node(int node, nodemask_t *used_node_mask)
+static int find_next_best_node(int node, nodemask_t *used_node_mask, int need_same_type)
 {
 	int n, val;
 	int min_val = INT_MAX;
@@ -5380,7 +5380,7 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
 	const struct cpumask *tmp = cpumask_of_node(0);
 
 	/* Use the local node if we haven't already */
-	if (!node_isset(node, *used_node_mask)) {
+	if (need_same_type && !node_isset(node, *used_node_mask)) {
 		node_set(node, *used_node_mask);
 		return node;
 	}
@@ -5391,6 +5391,12 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
 		if (node_isset(n, *used_node_mask))
 			continue;
 
+		if (need_same_type && !is_node_same_type(node, n))
+			continue;
+
+		if (!need_same_type && is_node_same_type(node, n))
+			continue;
+
 		/* Use the distance array to find the distance */
 		val = node_distance(node, n);
 
@@ -5472,31 +5478,35 @@ static void build_zonelists(pg_data_t *pgdat)
 	int node, load, nr_nodes = 0;
 	nodemask_t used_mask;
 	int local_node, prev_node;
+	int need_same_type;
 
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
 	load = nr_online_nodes;
 	prev_node = local_node;
-	nodes_clear(used_mask);
 
 	memset(node_order, 0, sizeof(node_order));
-	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
-		/*
-		 * We don't want to pressure a particular node.
-		 * So adding penalty to the first node in same
-		 * distance group to make it round-robin.
-		 */
-		if (node_distance(local_node, node) !=
-		    node_distance(local_node, prev_node))
-			node_load[node] = load;
+	for (need_same_type = 1; need_same_type >= 0; need_same_type--) {
+		nodes_clear(used_mask);
+		while ((node = find_next_best_node(local_node, &used_mask,
+				need_same_type)) >= 0) {
+			/*
+			 * We don't want to pressure a particular node.
+			 * So adding penalty to the first node in same
+			 * distance group to make it round-robin.
+			 */
+			if (node_distance(local_node, node) !=
+			    node_distance(local_node, prev_node))
+				node_load[node] = load;
 
-		node_order[nr_nodes++] = node;
-		prev_node = node;
-		load--;
+			node_order[nr_nodes++] = node;
+			prev_node = node;
+			load--;
+		}
 	}
-
 	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
 	build_thisnode_zonelists(pgdat);
+
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
1.8.3.1

