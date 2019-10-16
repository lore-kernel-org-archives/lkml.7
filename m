Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57525FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEB2207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407381AbfJPWOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:14:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:13198 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404154AbfJPWOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 18:14:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 15:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,305,1566889200"; 
   d="scan'208";a="200197936"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 16 Oct 2019 15:14:13 -0700
Subject: [PATCH 3/4] mm/vmscan: Attempt to migrate page in lieu of discard
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, dan.j.williams@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        keith.busch@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 16 Oct 2019 15:11:52 -0700
References: <20191016221148.F9CCD155@viggo.jf.intel.com>
In-Reply-To: <20191016221148.F9CCD155@viggo.jf.intel.com>
Message-Id: <20191016221152.BF2171A3@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Keith Busch <keith.busch@intel.com>

If a memory node has a preferred migration path to demote cold pages,
attempt to move those inactive pages to that migration node before
reclaiming. This will better utilize available memory, provide a faster
tier than swapping or discarding, and allow such pages to be reused
immediately without IO to retrieve the data.

Much like swap, this is an opt-in feature that requires user defining
where to send pages when reclaiming them. When handling anonymous pages,
this will be considered before swap if enabled. Should the demotion fail
for any reason, the page reclaim will proceed as if the demotion feature
was not enabled.

Some places we would like to see this used:

  1. Persistent memory being as a slower, cheaper DRAM replacement
  2. Remote memory-only "expansion" NUMA nodes
  3. Resolving memory imbalances where one NUMA node is seeing more
     allocation activity than another.  This helps keep more recent
     allocations closer to the CPUs on the node doing the allocating.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Co-developed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/include/linux/migrate.h        |    6 ++++
 b/include/trace/events/migrate.h |    3 +-
 b/mm/debug.c                     |    1 
 b/mm/migrate.c                   |   51 +++++++++++++++++++++++++++++++++++++++
 b/mm/vmscan.c                    |   27 ++++++++++++++++++++
 5 files changed, 87 insertions(+), 1 deletion(-)

diff -puN include/linux/migrate.h~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard include/linux/migrate.h
--- a/include/linux/migrate.h~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2019-10-16 15:06:58.090952593 -0700
+++ b/include/linux/migrate.h	2019-10-16 15:06:58.103952593 -0700
@@ -25,6 +25,7 @@ enum migrate_reason {
 	MR_MEMPOLICY_MBIND,
 	MR_NUMA_MISPLACED,
 	MR_CONTIG_RANGE,
+	MR_DEMOTION,
 	MR_TYPES
 };
 
@@ -79,6 +80,7 @@ extern int migrate_huge_page_move_mappin
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, enum migrate_mode mode,
 		int extra_count);
+extern int migrate_demote_mapping(struct page *page);
 #else
 
 static inline void putback_movable_pages(struct list_head *l) {}
@@ -105,6 +107,10 @@ static inline int migrate_huge_page_move
 	return -ENOSYS;
 }
 
+static inline int migrate_demote_mapping(struct page *page)
+{
+	return -ENOSYS;
+}
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_COMPACTION
diff -puN include/trace/events/migrate.h~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard include/trace/events/migrate.h
--- a/include/trace/events/migrate.h~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2019-10-16 15:06:58.092952593 -0700
+++ b/include/trace/events/migrate.h	2019-10-16 15:06:58.103952593 -0700
@@ -20,7 +20,8 @@
 	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
 	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
-	EMe(MR_CONTIG_RANGE,	"contig_range")
+	EM( MR_CONTIG_RANGE,	"contig_range")			\
+	EMe(MR_DEMOTION,	"demotion")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff -puN mm/debug.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/debug.c
--- a/mm/debug.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2019-10-16 15:06:58.094952593 -0700
+++ b/mm/debug.c	2019-10-16 15:06:58.103952593 -0700
@@ -25,6 +25,7 @@ const char *migrate_reason_names[MR_TYPE
 	"mempolicy_mbind",
 	"numa_misplaced",
 	"cma",
+	"demotion",
 };
 
 const struct trace_print_flags pageflag_names[] = {
diff -puN mm/migrate.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/migrate.c
--- a/mm/migrate.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2019-10-16 15:06:58.097952593 -0700
+++ b/mm/migrate.c	2019-10-16 15:06:58.104952593 -0700
@@ -1119,6 +1119,57 @@ out:
 	return rc;
 }
 
+static struct page *alloc_demote_node_page(struct page *page, unsigned long node)
+{
+	/*
+	 * The flags are set to allocate only on the desired node in the
+	 * migration path, and to fail fast if not immediately available. We
+	 * are already doing memory reclaim, we don't want heroic efforts to
+	 * get a page.
+	 */
+	gfp_t mask = GFP_NOWAIT | __GFP_NOWARN | __GFP_NORETRY |
+			__GFP_NOMEMALLOC | __GFP_THISNODE | __GFP_MOVABLE;
+	struct page *newpage;
+
+	if (PageTransHuge(page)) {
+		mask |= __GFP_COMP;
+		newpage = alloc_pages_node(node, mask, HPAGE_PMD_ORDER);
+		if (newpage)
+			prep_transhuge_page(newpage);
+	} else
+		newpage = alloc_pages_node(node, mask, 0);
+
+	return newpage;
+}
+
+/**
+ * migrate_demote_mapping() - Migrate this page and its mappings to its
+ *                            demotion node.
+ * @page: A locked, isolated, non-huge page that should migrate to its current
+ *        node's demotion target, if available. Since this is intended to be
+ *        called during memory reclaim, all flag options are set to fail fast.
+ *
+ * @returns: MIGRATEPAGE_SUCCESS if successful, -errno otherwise.
+ */
+int migrate_demote_mapping(struct page *page)
+{
+	int next_nid = next_migration_node(page_to_nid(page));
+
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(PageHuge(page), page);
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+
+	if (next_nid < 0)
+		return -ENOSYS;
+	if (PageTransHuge(page) && !thp_migration_supported())
+		return -ENOMEM;
+
+	/* MIGRATE_ASYNC is the most light weight and never blocks.*/
+	return __unmap_and_move(alloc_demote_node_page, NULL, next_nid,
+				page, MIGRATE_ASYNC, MR_DEMOTION);
+}
+
+
 /*
  * gcc 4.7 and 4.8 on arm get an ICEs when inlining unmap_and_move().  Work
  * around it.
diff -puN mm/vmscan.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/vmscan.c
--- a/mm/vmscan.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2019-10-16 15:06:58.099952593 -0700
+++ b/mm/vmscan.c	2019-10-16 15:06:58.105952593 -0700
@@ -1262,6 +1262,33 @@ static unsigned long shrink_page_list(st
 			; /* try to reclaim the page below */
 		}
 
+		if (!PageHuge(page)) {
+			int rc = migrate_demote_mapping(page);
+
+			/*
+			 * -ENOMEM on a THP may indicate either migration is
+			 * unsupported or there was not enough contiguous
+			 * space. Split the THP into base pages and retry the
+			 * head immediately. The tail pages will be considered
+			 * individually within the current loop's page list.
+			 */
+			if (rc == -ENOMEM && PageTransHuge(page) &&
+			    !split_huge_page_to_list(page, page_list))
+				rc = migrate_demote_mapping(page);
+
+			if (rc == MIGRATEPAGE_SUCCESS) {
+				unlock_page(page);
+				if (likely(put_page_testzero(page)))
+					goto free_it;
+				/*
+				 * Speculative reference will free this page,
+				 * so leave it off the LRU.
+				 */
+				nr_reclaimed++;
+				continue;
+			}
+		}
+
 		/*
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
_
