Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A1EC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEA32070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKUPW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:22:26 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53811 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfKUPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:22:25 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 28E351C0012;
        Thu, 21 Nov 2019 15:22:15 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 16/19] mm, page_alloc: cleanup build_zonelists
Date:   Thu, 21 Nov 2019 23:18:08 +0800
Message-Id: <20191121151811.49742-17-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup patch.

Renaming some functions and variables when initializing nodelist
is xxx_nodelist instead of xxx_zonelist.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 include/linux/mmzone.h |  2 +-
 init/main.c            |  2 +-
 mm/memory_hotplug.c    |  6 +++---
 mm/page_alloc.c        | 20 ++++++++++----------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 599b30620aa1..f1a492c13037 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -813,7 +813,7 @@ static inline bool pgdat_is_empty(pg_data_t *pgdat)
 
 #include <linux/memory_hotplug.h>
 
-void build_all_zonelists(pg_data_t *pgdat);
+void build_all_nodelists(pg_data_t *pgdat);
 void wakeup_kswapd(pg_data_t *pgdat, gfp_t gfp_mask, int order,
 		   enum zone_type classzone_idx);
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
diff --git a/init/main.c b/init/main.c
index 4d814de017ee..d561bdc537eb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -602,7 +602,7 @@ asmlinkage __visible void __init start_kernel(void)
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
 	boot_cpu_hotplug_init();
 
-	build_all_zonelists(NULL);
+	build_all_nodelists(NULL);
 	page_alloc_init();
 
 	pr_notice("Kernel command line: %s\n", boot_command_line);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 46b2e056a43f..3c63529df112 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -821,7 +821,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
-		build_all_zonelists(NULL);
+		build_all_nodelists(NULL);
 	else
 		zone_pcp_update(zone);
 
@@ -904,7 +904,7 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
 	 * The node we allocated has no zone fallback lists. For avoiding
 	 * to access not-initialized zonelist, build here.
 	 */
-	build_all_zonelists(pgdat);
+	build_all_nodelists(pgdat);
 
 	/*
 	 * When memory is hot-added, all the memory is in offline state. So
@@ -1565,7 +1565,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
-		build_all_zonelists(NULL);
+		build_all_nodelists(NULL);
 	} else
 		zone_pcp_update(zone);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5b735eb88c0d..146abe537300 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5631,7 +5631,7 @@ static void build_thisnode_nodelists(pg_data_t *pgdat)
  * may still exist in local DMA zone.
  */
 
-static void build_zonelists(pg_data_t *pgdat)
+static void build_nodelists(pg_data_t *pgdat)
 {
 	static int node_order[MAX_NUMNODES];
 	int node, load, nr_nodes = 0;
@@ -5682,7 +5682,7 @@ static void setup_min_unmapped_ratio(void);
 static void setup_min_slab_ratio(void);
 #else	/* CONFIG_NUMA */
 
-static void build_zonelists(pg_data_t *pgdat)
+static void build_nodelists(pg_data_t *pgdat)
 {
 	int node, local_node;
 	struct nlist_entry *entry;
@@ -5737,7 +5737,7 @@ static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch);
 static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
-static void __build_all_zonelists(void *data)
+static void __build_all_nodelists(void *data)
 {
 	int nid;
 	int __maybe_unused cpu;
@@ -5755,12 +5755,12 @@ static void __build_all_zonelists(void *data)
 	 * building zonelists is fine - no need to touch other nodes.
 	 */
 	if (self && !node_online(self->node_id)) {
-		build_zonelists(self);
+		build_nodelists(self);
 	} else {
 		for_each_online_node(nid) {
 			pg_data_t *pgdat = NODE_DATA(nid);
 
-			build_zonelists(pgdat);
+			build_nodelists(pgdat);
 		}
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
@@ -5781,11 +5781,11 @@ static void __build_all_zonelists(void *data)
 }
 
 static noinline void __init
-build_all_zonelists_init(void)
+build_all_nodelists_init(void)
 {
 	int cpu;
 
-	__build_all_zonelists(NULL);
+	__build_all_nodelists(NULL);
 
 	/*
 	 * Initialize the boot_pagesets that are going to be used
@@ -5813,12 +5813,12 @@ build_all_zonelists_init(void)
  * __ref due to call of __init annotated helper build_all_zonelists_init
  * [protected by SYSTEM_BOOTING].
  */
-void __ref build_all_zonelists(pg_data_t *pgdat)
+void __ref build_all_nodelists(pg_data_t *pgdat)
 {
 	if (system_state == SYSTEM_BOOTING) {
-		build_all_zonelists_init();
+		build_all_nodelists_init();
 	} else {
-		__build_all_zonelists(pgdat);
+		__build_all_nodelists(pgdat);
 		/* cpuset refresh routine should be here */
 	}
 	vm_total_pages = nr_free_pagecache_pages();
-- 
2.23.0

