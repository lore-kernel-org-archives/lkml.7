Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A90CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107B9208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfKAH6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:58:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:16169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbfKAH6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:58:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 00:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="225962514"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 00:58:41 -0700
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
Subject: [RFC 09/10] autonuma, memory tiering: Double hot threshold for write hint page fault
Date:   Fri,  1 Nov 2019 15:57:26 +0800
Message-Id: <20191101075727.26683-10-ying.huang@intel.com>
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

The write performance of PMEM is much worse than its read
performance.  So even if a write-mostly pages is colder than a
read-mostly pages, it is usually better to put the write-mostly pages
in DRAM and read-mostly pages in PMEM.

To give write-mostly pages more opportunity to be promoted to DRAM, in
this patch, the hot threshold for write hint page fault is
doubled (easier to be promoted).

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
 include/linux/sched/numa_balancing.h | 1 +
 kernel/sched/fair.c                  | 2 ++
 mm/memory.c                          | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index e1c2728d5bb2..65dc8c6e8377 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -15,6 +15,7 @@
 #define TNF_FAULT_LOCAL	0x08
 #define TNF_MIGRATE_FAIL 0x10
 #define TNF_YOUNG	0x20
+#define TNF_WRITE	0x40
 
 #ifdef CONFIG_NUMA_BALANCING
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d6cf5832556e..0a83e9cf6685 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1513,6 +1513,8 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 
 		threshold = msecs_to_jiffies(
 			sysctl_numa_balancing_hot_threshold);
+		if (flags & TNF_WRITE)
+			threshold *= 2;
 		latency = numa_hint_fault_latency(p, addr);
 		if (latency > threshold)
 			return false;
diff --git a/mm/memory.c b/mm/memory.c
index 80902ff7f5de..fed6c943ba60 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3729,6 +3729,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (pte_young(old_pte))
 		flags |= TNF_YOUNG;
 
+	if (vmf->flags & FAULT_FLAG_WRITE)
+		flags |= TNF_WRITE;
+
 	page = vm_normal_page(vma, vmf->address, pte);
 	if (!page)
 		goto unmap_out;
-- 
2.23.0

