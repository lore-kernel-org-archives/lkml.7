Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF155C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E2721900
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCWEqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:46:02 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:44016 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfCWEqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:46:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TNPuxAM_1553316293;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNPuxAM_1553316293)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 23 Mar 2019 12:45:03 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] mm: vmscan: add page demotion counter
Date:   Sat, 23 Mar 2019 12:44:32 +0800
Message-Id: <1553316275-21985-8-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demoted pages are counted into reclaim_state->nr_demoted instead of
nr_reclaimed since they are not reclaimed actually.  They are still in
memory, but just migrated to PMEM.

Add pgdemote_kswapd and pgdemote_direct VM counters showed in
/proc/vmstat.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/vm_event_item.h |  2 ++
 include/linux/vmstat.h        |  1 +
 mm/vmscan.c                   | 14 ++++++++++++++
 mm/vmstat.c                   |  2 ++
 4 files changed, 19 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 47a3441..499a3aa 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -32,6 +32,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGREFILL,
 		PGSTEAL_KSWAPD,
 		PGSTEAL_DIRECT,
+		PGDEMOTE_KSWAPD,
+		PGDEMOTE_DIRECT,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
 		PGSCAN_DIRECT_THROTTLE,
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 2db8d60..eb5d21c 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -29,6 +29,7 @@ struct reclaim_stat {
 	unsigned nr_activate;
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
+	unsigned nr_demoted;
 };
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bdcab6b..3c7ba7e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1286,6 +1286,10 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 
 			if (has_nonram_online()) {
 				list_add(&page->lru, &demote_pages);
+				if (PageTransHuge(page))
+					stat->nr_demoted += HPAGE_PMD_NR;
+				else
+					stat->nr_demoted++;
 				unlock_page(page);
 				continue;
 			}
@@ -1523,7 +1527,17 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			putback_movable_pages(&demote_pages);
 
 			list_splice(&ret_pages, &demote_pages);
+
+			if (err > 0)
+				stat->nr_demoted -= err;
+			else
+				stat->nr_demoted = 0;
 		}
+
+		if (current_is_kswapd())
+			__count_vm_events(PGDEMOTE_KSWAPD, stat->nr_demoted);
+		else
+			__count_vm_events(PGDEMOTE_DIRECT, stat->nr_demoted);
 	}
 
 	mem_cgroup_uncharge_list(&free_pages);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 36b56f8..0e863e7 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1192,6 +1192,8 @@ int fragmentation_index(struct zone *zone, unsigned int order)
 	"pgrefill",
 	"pgsteal_kswapd",
 	"pgsteal_direct",
+	"pgdemote_kswapd",
+	"pgdemote_direct",
 	"pgscan_kswapd",
 	"pgscan_direct",
 	"pgscan_direct_throttle",
-- 
1.8.3.1

