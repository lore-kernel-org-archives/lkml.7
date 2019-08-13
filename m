Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04867C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 02:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE5820673
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 02:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfHMCHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 22:07:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:31293 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfHMCHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 22:07:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 19:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,379,1559545200"; 
   d="scan'208";a="327539466"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga004.jf.intel.com with ESMTP; 12 Aug 2019 19:07:02 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, osalvador@suse.de, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/hotplug: prevent memory leak when reuse pgdat
Date:   Tue, 13 Aug 2019 10:06:08 +0800
Message-Id: <20190813020608.10194-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When offline a node in try_offline_node, pgdat is not released. So that
pgdat could be reused in hotadd_new_pgdat. While we re-allocate
pgdat->per_cpu_nodestats if this pgdat is reused.

This patch prevents the memory leak by just allocate per_cpu_nodestats
when it is a new pgdat.

NOTE: This is not tested since I didn't manage to create a case to
offline a whole node. If my analysis is not correct, please let me know.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/memory_hotplug.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c73f09913165..efaf9e6f580a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -933,8 +933,11 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
 		if (!pgdat)
 			return NULL;
 
+		pgdat->per_cpu_nodestats =
+			alloc_percpu(struct per_cpu_nodestat);
 		arch_refresh_nodedata(nid, pgdat);
 	} else {
+		int cpu;
 		/*
 		 * Reset the nr_zones, order and classzone_idx before reuse.
 		 * Note that kswapd will init kswapd_classzone_idx properly
@@ -943,6 +946,12 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
 		pgdat->nr_zones = 0;
 		pgdat->kswapd_order = 0;
 		pgdat->kswapd_classzone_idx = 0;
+		for_each_online_cpu(cpu) {
+			struct per_cpu_nodestat *p;
+
+			p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+			memset(p, 0, sizeof(*p));
+		}
 	}
 
 	/* we can use NODE_DATA(nid) from here */
@@ -952,7 +961,6 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
 
 	/* init node's zones as empty zones, we don't have any present pages.*/
 	free_area_init_core_hotplug(nid);
-	pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
 
 	/*
 	 * The node we allocated has no zone fallback lists. For avoiding
-- 
2.17.1

