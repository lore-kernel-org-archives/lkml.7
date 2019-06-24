Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D051C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783192073F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfFXC4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:56:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:56924 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfFXC4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:56:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2019 19:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,410,1557212400"; 
   d="scan'208";a="171838542"
Received: from yhuang-mobile.sh.intel.com ([10.239.197.69])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2019 19:56:08 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Rik van Riel <riel@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, jhladky@redhat.com,
        lvenanci@redhat.com, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH -mm] autonuma: Fix scan period updating
Date:   Mon, 24 Jun 2019 10:56:04 +0800
Message-Id: <20190624025604.30896-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The autonuma scan period should be increased (scanning is slowed down)
if the majority of the page accesses are shared with other processes.
But in current code, the scan period will be decreased (scanning is
speeded up) in that situation.

This patch fixes the code.  And this has been tested via tracing the
scan period changing and /proc/vmstat numa_pte_updates counter when
running a multi-threaded memory accessing program (most memory
areas are accessed by multiple threads).

Fixes: 37ec97deb3a8 ("sched/numa: Slow down scan rate if shared faults dominate")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: jhladky@redhat.com
Cc: lvenanci@redhat.com
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..79bc4d2d1e58 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1923,7 +1923,7 @@ static void update_task_scan_period(struct task_struct *p,
 			unsigned long shared, unsigned long private)
 {
 	unsigned int period_slot;
-	int lr_ratio, ps_ratio;
+	int lr_ratio, sp_ratio;
 	int diff;
 
 	unsigned long remote = p->numa_faults_locality[0];
@@ -1954,22 +1954,22 @@ static void update_task_scan_period(struct task_struct *p,
 	 */
 	period_slot = DIV_ROUND_UP(p->numa_scan_period, NUMA_PERIOD_SLOTS);
 	lr_ratio = (local * NUMA_PERIOD_SLOTS) / (local + remote);
-	ps_ratio = (private * NUMA_PERIOD_SLOTS) / (private + shared);
+	sp_ratio = (shared * NUMA_PERIOD_SLOTS) / (private + shared);
 
-	if (ps_ratio >= NUMA_PERIOD_THRESHOLD) {
+	if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
 		/*
-		 * Most memory accesses are local. There is no need to
-		 * do fast NUMA scanning, since memory is already local.
+		 * Most memory accesses are shared with other tasks.
+		 * There is no point in continuing fast NUMA scanning,
+		 * since other tasks may just move the memory elsewhere.
 		 */
-		int slot = ps_ratio - NUMA_PERIOD_THRESHOLD;
+		int slot = sp_ratio - NUMA_PERIOD_THRESHOLD;
 		if (!slot)
 			slot = 1;
 		diff = slot * period_slot;
 	} else if (lr_ratio >= NUMA_PERIOD_THRESHOLD) {
 		/*
-		 * Most memory accesses are shared with other tasks.
-		 * There is no point in continuing fast NUMA scanning,
-		 * since other tasks may just move the memory elsewhere.
+		 * Most memory accesses are local. There is no need to
+		 * do fast NUMA scanning, since memory is already local.
 		 */
 		int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;
 		if (!slot)
@@ -1981,7 +1981,7 @@ static void update_task_scan_period(struct task_struct *p,
 		 * yet they are not on the local NUMA node. Speed up
 		 * NUMA scanning to get the memory moved over.
 		 */
-		int ratio = max(lr_ratio, ps_ratio);
+		int ratio = max(lr_ratio, sp_ratio);
 		diff = -(NUMA_PERIOD_THRESHOLD - ratio) * period_slot;
 	}
 
-- 
2.21.0

