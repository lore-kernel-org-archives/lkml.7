Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E0020856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140032;
	bh=ftDurHYMP0vsQPUcAc5RcoACCRv/jeWPAHN0VsC5bKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y3kO3UhSswUueMR/uF4hHxYFZ3Nca61T5cqQG8lmhc8Rl4URnTjaq/DI6sKFoC5dz
	 Wzsuyikm084x4QOYlfF7MLGKdke5GB0qgT3+KEzMjGVCnwktSn1QEjZP+sB9n/y/M8
	 sJ3quHaVFqEUC1fPGi65HrBRrRWO7Cu7IEPiLPuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387672AbfDARdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730671AbfDARds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B746020856;
        Mon,  1 Apr 2019 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140027;
        bh=ftDurHYMP0vsQPUcAc5RcoACCRv/jeWPAHN0VsC5bKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XX8nonzS81rjcAyEAUq6Jq2FU7k546y/meaBFLl873/OEj4iObyoHRRrUZJkPu6a5
         9BnxoHXiE/bwiqz9u/xcTCwAhvWQgcC+0cQdHueQUB9NNdMpm4S0dyqaBemgCYEFR3
         ZcBzjvIot3zQB4b+mTOJYwGo9Z9NTcfbSc4MsPLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 047/131] vmstat: make vmstat_updater deferrable again and shut down on idle
Date:   Mon,  1 Apr 2019 19:01:57 +0200
Message-Id: <20190401170056.239951880@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0eb77e9880321915322d42913c3b53241739c8aa ]

Currently the vmstat updater is not deferrable as a result of commit
ba4877b9ca51 ("vmstat: do not use deferrable delayed work for
vmstat_update").  This in turn can cause multiple interruptions of the
applications because the vmstat updater may run at

Make vmstate_update deferrable again and provide a function that folds
the differentials when the processor is going to idle mode thus
addressing the issue of the above commit in a clean way.

Note that the shepherd thread will continue scanning the differentials
from another processor and will reenable the vmstat workers if it
detects any changes.

Fixes: ba4877b9ca51 ("vmstat: do not use deferrable delayed work for vmstat_update")
Signed-off-by: Christoph Lameter <cl@linux.com>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/vmstat.h |  2 ++
 kernel/sched/idle.c    |  1 +
 mm/vmstat.c            | 69 +++++++++++++++++++++++++++---------------
 3 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 3e5d9075960f..73fae8c4a5fb 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -189,6 +189,7 @@ extern void __inc_zone_state(struct zone *, enum zone_stat_item);
 extern void dec_zone_state(struct zone *, enum zone_stat_item);
 extern void __dec_zone_state(struct zone *, enum zone_stat_item);
 
+void quiet_vmstat(void);
 void cpu_vm_stats_fold(int cpu);
 void refresh_zone_stat_thresholds(void);
 
@@ -249,6 +250,7 @@ static inline void __dec_zone_page_state(struct page *page,
 
 static inline void refresh_zone_stat_thresholds(void) { }
 static inline void cpu_vm_stats_fold(int cpu) { }
+static inline void quiet_vmstat(void) { }
 
 static inline void drain_zonestat(struct zone *zone,
 			struct per_cpu_pageset *pset) { }
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index bfd573122e0d..306a859b36f0 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -219,6 +219,7 @@ static void cpu_idle_loop(void)
 		 */
 
 		__current_set_polling();
+		quiet_vmstat();
 		tick_nohz_idle_enter();
 
 		while (!need_resched()) {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a2d70ef74db7..6af9bbad94c7 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -460,7 +460,7 @@ static int fold_diff(int *diff)
  *
  * The function returns the number of global counters updated.
  */
-static int refresh_cpu_vm_stats(void)
+static int refresh_cpu_vm_stats(bool do_pagesets)
 {
 	struct zone *zone;
 	int i;
@@ -484,33 +484,35 @@ static int refresh_cpu_vm_stats(void)
 #endif
 			}
 		}
-		cond_resched();
 #ifdef CONFIG_NUMA
-		/*
-		 * Deal with draining the remote pageset of this
-		 * processor
-		 *
-		 * Check if there are pages remaining in this pageset
-		 * if not then there is nothing to expire.
-		 */
-		if (!__this_cpu_read(p->expire) ||
+		if (do_pagesets) {
+			cond_resched();
+			/*
+			 * Deal with draining the remote pageset of this
+			 * processor
+			 *
+			 * Check if there are pages remaining in this pageset
+			 * if not then there is nothing to expire.
+			 */
+			if (!__this_cpu_read(p->expire) ||
 			       !__this_cpu_read(p->pcp.count))
-			continue;
+				continue;
 
-		/*
-		 * We never drain zones local to this processor.
-		 */
-		if (zone_to_nid(zone) == numa_node_id()) {
-			__this_cpu_write(p->expire, 0);
-			continue;
-		}
+			/*
+			 * We never drain zones local to this processor.
+			 */
+			if (zone_to_nid(zone) == numa_node_id()) {
+				__this_cpu_write(p->expire, 0);
+				continue;
+			}
 
-		if (__this_cpu_dec_return(p->expire))
-			continue;
+			if (__this_cpu_dec_return(p->expire))
+				continue;
 
-		if (__this_cpu_read(p->pcp.count)) {
-			drain_zone_pages(zone, this_cpu_ptr(&p->pcp));
-			changes++;
+			if (__this_cpu_read(p->pcp.count)) {
+				drain_zone_pages(zone, this_cpu_ptr(&p->pcp));
+				changes++;
+			}
 		}
 #endif
 	}
@@ -1393,7 +1395,7 @@ static cpumask_var_t cpu_stat_off;
 
 static void vmstat_update(struct work_struct *w)
 {
-	if (refresh_cpu_vm_stats()) {
+	if (refresh_cpu_vm_stats(true)) {
 		/*
 		 * Counters were updated so we expect more updates
 		 * to occur in the future. Keep on running the
@@ -1424,6 +1426,23 @@ static void vmstat_update(struct work_struct *w)
 	}
 }
 
+/*
+ * Switch off vmstat processing and then fold all the remaining differentials
+ * until the diffs stay at zero. The function is used by NOHZ and can only be
+ * invoked when tick processing is not active.
+ */
+void quiet_vmstat(void)
+{
+	if (system_state != SYSTEM_RUNNING)
+		return;
+
+	do {
+		if (!cpumask_test_and_set_cpu(smp_processor_id(), cpu_stat_off))
+			cancel_delayed_work(this_cpu_ptr(&vmstat_work));
+
+	} while (refresh_cpu_vm_stats(false));
+}
+
 /*
  * Check if the diffs for a certain cpu indicate that
  * an update is needed.
@@ -1456,7 +1475,7 @@ static bool need_update(int cpu)
  */
 static void vmstat_shepherd(struct work_struct *w);
 
-static DECLARE_DELAYED_WORK(shepherd, vmstat_shepherd);
+static DECLARE_DEFERRABLE_WORK(shepherd, vmstat_shepherd);
 
 static void vmstat_shepherd(struct work_struct *w)
 {
-- 
2.19.1



