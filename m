Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74453C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE27214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbfHFDIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:08:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:6367 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbfHFDIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:08:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 20:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,352,1559545200"; 
   d="scan'208";a="168166998"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga008.jf.intel.com with ESMTP; 05 Aug 2019 20:08:40 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V2] fork: Improve error message for corrupted page tables
Date:   Mon,  5 Aug 2019 20:05:27 -0700
Message-Id: <3ef8a340deb1c87b725d44edb163073e2b6eca5a.1565059496.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user process exits, the kernel cleans up the mm_struct of the user
process and during cleanup, check_mm() checks the page tables of the user
process for corruption (E.g: unexpected page flags set/cleared). For
corrupted page tables, the error message printed by check_mm() isn't very
clear as it prints the loop index instead of page table type (E.g: Resident
file mapping pages vs Resident shared memory pages). The loop index in
check_mm() is used to index rss_stat[] which represents individual memory
type stats. Hence, instead of printing index, print memory type, thereby
improving error message.

Without patch:
--------------
[  204.836425] mm/pgtable-generic.c:29: bad p4d 0000000089eb4e92(800000025f941467)
[  204.836544] BUG: Bad rss-counter state mm:00000000f75895ea idx:0 val:2
[  204.836615] BUG: Bad rss-counter state mm:00000000f75895ea idx:1 val:5
[  204.836685] BUG: non-zero pgtables_bytes on freeing mm: 20480

With patch:
-----------
[   69.815453] mm/pgtable-generic.c:29: bad p4d 0000000084653642(800000025ca37467)
[   69.815872] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_FILEPAGES val:2
[   69.815962] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_ANONPAGES val:5
[   69.816050] BUG: non-zero pgtables_bytes on freeing mm: 20480

Also, change print function (from printk(KERN_ALERT, ..) to pr_alert()) so
that it matches the other print statement.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---

Changes from V1 to V2:
----------------------
1. Move struct definition from header file to fork.c file, so that it won't be
   included in every compilation unit. As this struct is used *only* in fork.c,
   include the definition in fork.c itself.
2. Index the struct to match respective macros.
3. Mention about print function change in commit message.

 kernel/fork.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d8ae0f1b4148..f34f441c50c0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -125,6 +125,13 @@ int nr_threads;			/* The idle threads do not count.. */
 
 static int max_threads;		/* tunable limit on nr_threads */
 
+static const char * const resident_page_types[NR_MM_COUNTERS] = {
+	[MM_FILEPAGES]		= "MM_FILEPAGES",
+	[MM_ANONPAGES]		= "MM_ANONPAGES",
+	[MM_SWAPENTS]		= "MM_SWAPENTS",
+	[MM_SHMEMPAGES]		= "MM_SHMEMPAGES",
+};
+
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
 __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
@@ -649,8 +656,8 @@ static void check_mm(struct mm_struct *mm)
 		long x = atomic_long_read(&mm->rss_stat.count[i]);
 
 		if (unlikely(x))
-			printk(KERN_ALERT "BUG: Bad rss-counter state "
-					  "mm:%p idx:%d val:%ld\n", mm, i, x);
+			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
+				 mm, resident_page_types[i], x);
 	}
 
 	if (mm_pgtables_bytes(mm))
-- 
2.7.4

