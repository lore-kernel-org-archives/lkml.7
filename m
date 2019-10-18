Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3176FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03200222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408405AbfJRK4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:56:11 -0400
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:40894 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407543AbfJRK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:56:09 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id E4F591C3283
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:56:07 +0100 (IST)
Received: (qmail 30764 invoked from network); 18 Oct 2019 10:56:07 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPA; 18 Oct 2019 10:56:07 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/3] mm, pcp: Share common code between memory hotplug and percpu sysctl handler
Date:   Fri, 18 Oct 2019 11:56:04 +0100
Message-Id: <20191018105606.3249-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191018105606.3249-1-mgorman@techsingularity.net>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the percpu_pagelist_fraction sysctl handler and memory hotplug
have a common requirement of updating the pcpu page allocation batch
and high values. Split the relevant helper to share common code.

No functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c0b2e0306720..cafe568d36f6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7983,6 +7983,15 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
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
@@ -8014,13 +8023,8 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
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
@@ -8519,11 +8523,8 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
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

