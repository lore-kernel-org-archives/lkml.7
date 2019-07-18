Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA78C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762E620873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390622AbfGROWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:22:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbfGROWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:22:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07B1D6EB88;
        Thu, 18 Jul 2019 14:22:42 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-157.ams2.redhat.com [10.36.117.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D073A60A35;
        Thu, 18 Jul 2019 14:22:39 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1] drivers/base/node.c: Simplify unregister_memory_block_under_nodes()
Date:   Thu, 18 Jul 2019 16:22:39 +0200
Message-Id: <20190718142239.7205-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 18 Jul 2019 14:22:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't allow to offline memory block devices that belong to multiple
numa nodes. Therefore, such devices can never get removed. It is
sufficient to process a single node when removing the memory block.

Remember for each memory block if it belongs to no, a single, or mixed
nodes, so we can use that information to skip unregistering or print a
warning (essentially a safety net to catch BUGs).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  |  1 +
 drivers/base/node.c    | 40 ++++++++++++++++------------------------
 include/linux/memory.h |  4 +++-
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 20c39d1bcef8..154d5d4a0779 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -674,6 +674,7 @@ static int init_memory_block(struct memory_block **memory,
 	mem->state = state;
 	start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	mem->phys_device = arch_get_memory_phys_device(start_pfn);
+	mem->nid = NUMA_NO_NODE;
 
 	ret = register_memory(mem);
 
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 75b7e6f6535b..29d27b8d5fda 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -759,8 +759,6 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
 	int ret, nid = *(int *)arg;
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
 
-	mem_blk->nid = nid;
-
 	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
 	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
 	sect_end_pfn += PAGES_PER_SECTION - 1;
@@ -789,6 +787,13 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
 			if (page_nid != nid)
 				continue;
 		}
+
+		/* this memory block spans this node */
+		if (mem_blk->nid == NUMA_NO_NODE)
+			mem_blk->nid = nid;
+		else
+			mem_blk->nid = NUMA_NO_NODE - 1;
+
 		ret = sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
 					&mem_blk->dev.kobj,
 					kobject_name(&mem_blk->dev.kobj));
@@ -804,32 +809,19 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
 }
 
 /*
- * Unregister memory block device under all nodes that it spans.
- * Has to be called with mem_sysfs_mutex held (due to unlinked_nodes).
+ * Unregister a memory block device under the node it spans. Memory blocks
+ * with multiple nodes cannot be offlined and therefore also never be removed.
  */
 void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
 {
-	unsigned long pfn, sect_start_pfn, sect_end_pfn;
-	static nodemask_t unlinked_nodes;
-
-	nodes_clear(unlinked_nodes);
-	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
-	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
-	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
-		int nid;
+	if (mem_blk->nid == NUMA_NO_NODE ||
+	    WARN_ON_ONCE(mem_blk->nid == NUMA_NO_NODE - 1))
+		return;
 
-		nid = get_nid_for_pfn(pfn);
-		if (nid < 0)
-			continue;
-		if (!node_online(nid))
-			continue;
-		if (node_test_and_set(nid, unlinked_nodes))
-			continue;
-		sysfs_remove_link(&node_devices[nid]->dev.kobj,
-			 kobject_name(&mem_blk->dev.kobj));
-		sysfs_remove_link(&mem_blk->dev.kobj,
-			 kobject_name(&node_devices[nid]->dev.kobj));
-	}
+	sysfs_remove_link(&node_devices[mem_blk->nid]->dev.kobj,
+		 kobject_name(&mem_blk->dev.kobj));
+	sysfs_remove_link(&mem_blk->dev.kobj,
+		 kobject_name(&node_devices[mem_blk->nid]->dev.kobj));
 }
 
 int link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn)
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 02e633f3ede0..c91af10d5fb4 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -33,7 +33,9 @@ struct memory_block {
 	void *hw;			/* optional pointer to fw/hw data */
 	int (*phys_callback)(struct memory_block *);
 	struct device dev;
-	int nid;			/* NID for this memory block */
+	int nid;			/* NID for this memory block.
+					   - NUMA_NO_NODE: uninitialized
+					   - NUMA_NO_NODE - 1: mixed nodes */
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
-- 
2.21.0

