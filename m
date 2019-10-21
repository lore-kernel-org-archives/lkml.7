Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB06CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEA420830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfJUJsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:48:15 -0400
Received: from outbound-smtp06.blacknight.com ([81.17.249.39]:55058 "EHLO
        outbound-smtp06.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbfJUJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:48:13 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 48BD19891D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:48:11 +0100 (IST)
Received: (qmail 32608 invoked from network); 21 Oct 2019 09:48:11 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPA; 21 Oct 2019 09:48:10 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/3] mm, pcp: Share common code between memory hotplug and percpu sysctl handler
Date:   Mon, 21 Oct 2019 10:48:07 +0100
Message-Id: <20191021094808.28824-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021094808.28824-1-mgorman@techsingularity.net>
References: <20191021094808.28824-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the percpu_pagelist_fraction sysctl handler and memory hotplug
have a common requirement of updating the pcpu page allocation batch
and high values. Split the relevant helper to share common code.

No functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f972076d0f6b..4179376bb336 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7991,6 +7991,15 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
+static void __zone_pcp_update(struct zone *zone)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		pageset_set_high_and_batch(zone,
+				per_cpu_ptr(zone->pageset, cpu));
+}
+
 /*
  * percpu_pagelist_fraction - changes the pcp->high for each zone on each
  * cpu.  It is the fraction of total pages in each zone that a hot per cpu
@@ -8022,13 +8031,8 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 	if (percpu_pagelist_fraction == old_percpu_pagelist_fraction)
 		goto out;
 
-	for_each_populated_zone(zone) {
-		unsigned int cpu;
-
-		for_each_possible_cpu(cpu)
-			pageset_set_high_and_batch(zone,
-					per_cpu_ptr(zone->pageset, cpu));
-	}
+	for_each_populated_zone(zone)
+		__zone_pcp_update(zone);
 out:
 	mutex_unlock(&pcp_batch_high_lock);
 	return ret;
@@ -8527,11 +8531,8 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
  */
 void __meminit zone_pcp_update(struct zone *zone)
 {
-	unsigned cpu;
 	mutex_lock(&pcp_batch_high_lock);
-	for_each_possible_cpu(cpu)
-		pageset_set_high_and_batch(zone,
-				per_cpu_ptr(zone->pageset, cpu));
+	__zone_pcp_update(zone);
 	mutex_unlock(&pcp_batch_high_lock);
 }
 #endif
-- 
2.16.4

