Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3BDCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAF8217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfKAH6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:58:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:16169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfKAH6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:58:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 00:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="225962499"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 00:58:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [RFC 06/10] autonuma, memory tiering: Skip to scan fastest memory
Date:   Fri,  1 Nov 2019 15:57:23 +0800
Message-Id: <20191101075727.26683-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101075727.26683-1-ying.huang@intel.com>
References: <20191101075727.26683-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In memory tiering NUMA balancing mode, the hot pages of the workload
in the fastest memory node couldn't be promoted to anywhere, so it's
unnecessary to identify the hot pages in the fastest memory node via
changing their PTE mapping to have PROT_NONE.  So that the page faults
could be avoided too.

The patch improves the score of pmbench memory accessing benchmark
with 80:20 read/write ratio and normal access address distribution by
4.6% on a 2 socket Intel server with Optance DC Persistent Memory.
The autonuma hint faults for DRAM node is reduced to almost 0 in the
test.

Known problem: the statistics of autonuma such as per-node memory
accesses, and local/remote ratio, etc. will be influenced.  Especially
the NUMA scanning period automatic adjustment will not work
reasonably.  So we cannot rely on that.  Fortunately, there's no CPU
in the PMEM NUMA nodes, so we will not move tasks there because of
the statistics issue.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/huge_memory.c | 30 +++++++++++++++++++++---------
 mm/mprotect.c    | 14 +++++++++++++-
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 885642c82aaa..61e241ce20fa 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -32,6 +32,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/sched/sysctl.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -1937,17 +1938,28 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 #endif
 
-	/*
-	 * Avoid trapping faults against the zero page. The read-only
-	 * data is likely to be read-cached on the local CPU and
-	 * local/remote hits to the zero page are not interesting.
-	 */
-	if (prot_numa && is_huge_zero_pmd(*pmd))
-		goto unlock;
+	if (prot_numa) {
+		struct page *page;
+		/*
+		 * Avoid trapping faults against the zero page. The read-only
+		 * data is likely to be read-cached on the local CPU and
+		 * local/remote hits to the zero page are not interesting.
+		 */
+		if (is_huge_zero_pmd(*pmd))
+			goto unlock;
 
-	if (prot_numa && pmd_protnone(*pmd))
-		goto unlock;
+		if (pmd_protnone(*pmd))
+			goto unlock;
 
+		page = pmd_page(*pmd);
+		/*
+		 * Skip if normal numa balancing is disabled and no
+		 * faster memory node to promote to
+		 */
+		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+		    next_promotion_node(page_to_nid(page)) == -1)
+			goto unlock;
+	}
 	/*
 	 * In case prot_numa, we are under down_read(mmap_sem). It's critical
 	 * to not clear pmd intermittently to avoid race with MADV_DONTNEED
diff --git a/mm/mprotect.c b/mm/mprotect.c
index d69b9913388e..0636f2e5e05b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -28,6 +28,7 @@
 #include <linux/ksm.h>
 #include <linux/uaccess.h>
 #include <linux/mm_inline.h>
+#include <linux/sched/sysctl.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
@@ -79,6 +80,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			 */
 			if (prot_numa) {
 				struct page *page;
+				int nid;
 
 				/* Avoid TLB flush if possible */
 				if (pte_protnone(oldpte))
@@ -105,7 +107,17 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				 * Don't mess with PTEs if page is already on the node
 				 * a single-threaded process is running on.
 				 */
-				if (target_node == page_to_nid(page))
+				nid = page_to_nid(page);
+				if (target_node == nid)
+					continue;
+
+				/*
+				 * Skip scanning if normal numa
+				 * balancing is disabled and no faster
+				 * memory node to promote to
+				 */
+				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+				    next_promotion_node(nid) == -1)
 					continue;
 			}
 
-- 
2.23.0

