Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FD9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC199218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfCWEpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:45:41 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52300 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbfCWEpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:45:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TNPuxAM_1553316293;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNPuxAM_1553316293)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 23 Mar 2019 12:45:02 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] mm: numa: promote pages to DRAM when it is accessed twice
Date:   Sat, 23 Mar 2019 12:44:29 +0800
Message-Id: <1553316275-21985-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA balancing would promote the pages to DRAM once it is accessed, but
it might be just one off access.  To reduce migration thrashing and
memory bandwidth pressure, introduce PG_promote flag to mark promote
candidate.  The page will be promoted to DRAM when it is accessed twice.
This might be a good way to filter out those one-off access pages.

PG_promote flag will be inherited by tail pages when THP gets split.
But, it will not be copied to the new page once the migration is done.

This approach is not definitely the optimal one to distinguish the
hot or cold pages.  It may need much more sophisticated algorithm to
distinguish hot or cold pages accurately.  Kernel may be not the good
place to implement such algorithm considering the complexity and potential
overhead.  But, kernel may still need such capability.

With NUMA balancing the whole workingset of the process may end up being
promoted to DRAM finally.  It depends on the page reclaim to demote
inactive pages to PMEM implemented by the following patch.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/page-flags.h     |  4 ++++
 include/trace/events/mmflags.h |  3 ++-
 mm/huge_memory.c               | 10 ++++++++++
 mm/memory.c                    |  8 ++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9f8712a..2d53166 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -131,6 +131,7 @@ enum pageflags {
 	PG_young,
 	PG_idle,
 #endif
+	PG_promote,		/* Promote candidate for NUMA balancing */
 	__NR_PAGEFLAGS,
 
 	/* Filesystems */
@@ -348,6 +349,9 @@ static inline void page_init_poison(struct page *page, size_t size)
 PAGEFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
 	TESTCLEARFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
 
+PAGEFLAG(Promote, promote, PF_ANY) __SETPAGEFLAG(Promote, promote, PF_ANY)
+	__CLEARPAGEFLAG(Promote, promote, PF_ANY)
+
 /*
  * Only test-and-set exist for PG_writeback.  The unconditional operators are
  * risky: they bypass page accounting.
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a1675d4..f13c2a1 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -100,7 +100,8 @@
 	{1UL << PG_mappedtodisk,	"mappedtodisk"	},		\
 	{1UL << PG_reclaim,		"reclaim"	},		\
 	{1UL << PG_swapbacked,		"swapbacked"	},		\
-	{1UL << PG_unevictable,		"unevictable"	}		\
+	{1UL << PG_unevictable,		"unevictable"	},		\
+	{1UL << PG_promote,		"promote"	}		\
 IF_HAVE_PG_MLOCK(PG_mlocked,		"mlocked"	)		\
 IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
 IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 404acdc..8268a3c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1589,6 +1589,15 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 					      haddr + HPAGE_PMD_SIZE);
 	}
 
+	/* Promote page to DRAM when referenced twice */
+	if (!(node_isset(page_nid, def_alloc_nodemask)) &&
+	    !PagePromote(page)) {
+		SetPagePromote(page);
+		put_page(page);
+		page_nid = -1;
+		goto clear_pmdnuma;
+	}
+
 	/*
 	 * Migrate the THP to the requested node, returns with page unlocked
 	 * and access rights restored.
@@ -2396,6 +2405,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			 (1L << PG_workingset) |
 			 (1L << PG_locked) |
 			 (1L << PG_unevictable) |
+			 (1L << PG_promote) |
 			 (1L << PG_dirty)));
 
 	/* ->mapping in first tail page is compound_mapcount */
diff --git a/mm/memory.c b/mm/memory.c
index 47fe250..2494c11 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3680,6 +3680,14 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		goto out;
 	}
 
+	/* Promote the non-DRAM page when it is referenced twice */
+	if (!(node_isset(page_nid, def_alloc_nodemask)) &&
+	    !PagePromote(page)) {
+		SetPagePromote(page);
+		put_page(page);
+		goto out;
+	}
+
 	/* Migrate to the requested node */
 	migrated = migrate_misplaced_page(page, vma, target_nid);
 	if (migrated) {
-- 
1.8.3.1

