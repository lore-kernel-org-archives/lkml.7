Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1D9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE5B2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDKD5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:57:48 -0400
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:41139 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfDKD53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:57:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TP0I5rB_1554955031;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TP0I5rB_1554955031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Apr 2019 11:57:24 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 8/9] mm: vmscan: add page demotion counter
Date:   Thu, 11 Apr 2019 11:56:58 +0800
Message-Id: <1554955019-29472-9-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Account the number of demoted pages into reclaim_state->nr_demoted.

Add pgdemote_kswapd and pgdemote_direct VM counters showed in
/proc/vmstat.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/vm_event_item.h | 2 ++
 include/linux/vmstat.h        | 1 +
 mm/internal.h                 | 1 +
 mm/vmscan.c                   | 7 +++++++
 mm/vmstat.c                   | 2 ++
 5 files changed, 13 insertions(+)

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
diff --git a/mm/internal.h b/mm/internal.h
index 8c424b5..8ba4853 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -156,6 +156,7 @@ struct scan_control {
 		unsigned int immediate;
 		unsigned int file_taken;
 		unsigned int taken;
+		unsigned int demoted;
 	} nr;
 };
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50cde53..a52c8248 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1511,6 +1511,12 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 
 		nr_reclaimed += nr_succeeded;
 
+		stat->nr_demoted = nr_succeeded;
+		if (current_is_kswapd())
+			__count_vm_events(PGDEMOTE_KSWAPD, stat->nr_demoted);
+		else
+			__count_vm_events(PGDEMOTE_DIRECT, stat->nr_demoted);
+
 		if (err) {
 			if (err == -ENOMEM)
 				set_bit(PGDAT_CONTENDED,
@@ -2019,6 +2025,7 @@ static int current_may_throttle(void)
 	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
 	sc->nr.writeback += stat.nr_writeback;
 	sc->nr.immediate += stat.nr_immediate;
+	sc->nr.demoted += stat.nr_demoted;
 	sc->nr.taken += nr_taken;
 	if (file)
 		sc->nr.file_taken += nr_taken;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1a431dc..d1e4993 100644
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

