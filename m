Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0EA2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfCUUDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:03:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:5166 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfCUUC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:02:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 13:02:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="309246241"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2019 13:02:57 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/5] mm: Attempt to migrate page in lieu of discard
Date:   Thu, 21 Mar 2019 14:01:55 -0600
Message-Id: <20190321200157.29678-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190321200157.29678-1-keith.busch@intel.com>
References: <20190321200157.29678-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a memory node has a preferred migration path to demote cold pages,
attempt to move those inactive pages to that migration node before
reclaiming. This will better utilize available memory, provide a faster
tier than swapping or discarding, and allow such pages to be reused
immediately without IO to retrieve the data.

Some places we would like to see this used:

 1. Persistent memory being as a slower, cheaper DRAM replacement
 2. Remote memory-only "expansion" NUMA nodes
 3. Resolving memory imbalances where one NUMA node is seeing more
    allocation activity than another.  This helps keep more recent
    allocations closer to the CPUs on the node doing the allocating.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 include/linux/migrate.h        |  6 ++++++
 include/trace/events/migrate.h |  3 ++-
 mm/debug.c                     |  1 +
 mm/migrate.c                   | 45 ++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                    | 15 ++++++++++++++
 5 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index e13d9bf2f9a5..a004cb1b2dbb 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -25,6 +25,7 @@ enum migrate_reason {
 	MR_MEMPOLICY_MBIND,
 	MR_NUMA_MISPLACED,
 	MR_CONTIG_RANGE,
+	MR_DEMOTION,
 	MR_TYPES
 };
 
@@ -79,6 +80,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, enum migrate_mode mode,
 		int extra_count);
+extern bool migrate_demote_mapping(struct page *page);
 #else
 
 static inline void putback_movable_pages(struct list_head *l) {}
@@ -105,6 +107,10 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 	return -ENOSYS;
 }
 
+static inline bool migrate_demote_mapping(struct page *page)
+{
+	return false;
+}
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_COMPACTION
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 705b33d1e395..d25de0cc8714 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -20,7 +20,8 @@
 	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
 	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
-	EMe(MR_CONTIG_RANGE,	"contig_range")
+	EM(MR_CONTIG_RANGE,	"contig_range")			\
+	EMe(MR_DEMOTION,	"demotion")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff --git a/mm/debug.c b/mm/debug.c
index c0b31b6c3877..53d499f65199 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -25,6 +25,7 @@ const char *migrate_reason_names[MR_TYPES] = {
 	"mempolicy_mbind",
 	"numa_misplaced",
 	"cma",
+	"demotion",
 };
 
 const struct trace_print_flags pageflag_names[] = {
diff --git a/mm/migrate.c b/mm/migrate.c
index 705b320d4b35..83fad87361bf 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1152,6 +1152,51 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	return rc;
 }
 
+/**
+ * migrate_demote_mapping() - Migrate this page and its mappings to its
+ * 			      demotion node.
+ * @page: An isolated, non-compound page that should move to
+ * 	  its current node's migration path.
+ *
+ * @returns: True if migrate demotion was successful, false otherwise
+ */
+bool migrate_demote_mapping(struct page *page)
+{
+	int rc, next_nid = next_migration_node(page_to_nid(page));
+	struct page *newpage;
+
+	/*
+	 * The flags are set to allocate only on the desired node in the
+	 * migration path, and to fail fast if not immediately available. We
+	 * are already in the memory reclaim path, we don't want heroic
+	 * efforts to get a page.
+	 */
+	gfp_t mask = GFP_NOWAIT	| __GFP_NOWARN | __GFP_NORETRY |
+		     __GFP_NOMEMALLOC | __GFP_THISNODE;
+
+	VM_BUG_ON_PAGE(PageCompound(page), page);
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+
+	if (next_nid < 0)
+		return false;
+
+	newpage = alloc_pages_node(next_nid, mask, 0);
+	if (!newpage)
+		return false;
+
+	/*
+	 * MIGRATE_ASYNC is the most light weight and never blocks.
+	 */
+	rc = __unmap_and_move_locked(page, newpage, MIGRATE_ASYNC);
+	if (rc != MIGRATEPAGE_SUCCESS) {
+		__free_pages(newpage, 0);
+		return false;
+	}
+
+	set_page_owner_migrate_reason(newpage, MR_DEMOTION);
+	return true;
+}
+
 /*
  * gcc 4.7 and 4.8 on arm get an ICEs when inlining unmap_and_move().  Work
  * around it.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a5ad0b35ab8e..0a95804e946a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1261,6 +1261,21 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			; /* try to reclaim the page below */
 		}
 
+		if (!PageCompound(page)) {
+			if (migrate_demote_mapping(page)) {
+                                unlock_page(page);
+                                if (likely(put_page_testzero(page)))
+                                        goto free_it;
+
+                                /*
+				 * Speculative reference will free this page,
+				 * so leave it off the LRU.
+				 */
+                                nr_reclaimed++;
+                                continue;
+                        }
+		}
+
 		/*
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
-- 
2.14.4

