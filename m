Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639FFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F0F233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfH2HAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 03:00:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2HAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:00:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 871E43B738;
        Thu, 29 Aug 2019 07:00:51 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-166.ams2.redhat.com [10.36.117.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0D861001B07;
        Thu, 29 Aug 2019 07:00:49 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v3 05/11] mm/memory_hotplug: Optimize zone shrinking code when checking for holes
Date:   Thu, 29 Aug 2019 09:00:13 +0200
Message-Id: <20190829070019.12714-6-david@redhat.com>
In-Reply-To: <20190829070019.12714-1-david@redhat.com>
References: <20190829070019.12714-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 29 Aug 2019 07:00:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... and clarify why this is needed at all right now. It all boils down
to false positives. We will try to remove the false positives for
!ZONE_DEVICE memory, soon, however, for ZONE_DEVICE memory we won't be
able to easily get rid of false positives.

Don't only detect "all holes" but try to shrink using the existing
functions we have.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d3c34bbeb36d..663853bf97ed 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -411,32 +411,33 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		}
 	}
 
-	/*
-	 * The section is not biggest or smallest mem_section in the zone, it
-	 * only creates a hole in the zone. So in this case, we need not
-	 * change the zone. But perhaps, the zone has only hole data. Thus
-	 * it check the zone has only hole or not.
-	 */
-	for (pfn = zone->zone_start_pfn;
-	     pfn < zone_end_pfn(zone); pfn += PAGES_PER_SUBSECTION) {
-		if (unlikely(!pfn_valid(pfn)))
-			continue;
-
-		if (page_zone(pfn_to_page(pfn)) != zone)
-			continue;
-
-		/* Skip range to be removed */
-		if (pfn >= start_pfn && pfn < end_pfn)
-			continue;
-
-		/* If we find valid section, we have nothing to do */
+	if (!zone->spanned_pages) {
 		zone_span_writeunlock(zone);
 		return;
 	}
 
-	/* The zone has no valid section */
-	zone->zone_start_pfn = 0;
-	zone->spanned_pages = 0;
+	/*
+	 * Due to false positives in previous skrink attempts, it can happen
+	 * that we can shrink the zones further (possibly to zero). Once we
+	 * can reliably detect which PFNs actually belong to a zone
+	 * (especially for ZONE_DEVICE memory where we don't have online
+	 * sections), this can go.
+	 */
+	pfn = find_smallest_section_pfn(nid, zone, zone->zone_start_pfn,
+					zone_end_pfn(zone));
+	if (pfn) {
+		zone->spanned_pages = zone_end_pfn(zone) - pfn;
+		zone->zone_start_pfn = pfn;
+
+		pfn = find_biggest_section_pfn(nid, zone, zone->zone_start_pfn,
+					       zone_end_pfn(zone));
+		if (pfn)
+			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
+	}
+	if (!pfn) {
+		zone->zone_start_pfn = 0;
+		zone->spanned_pages = 0;
+	}
 	zone_span_writeunlock(zone);
 }
 
-- 
2.21.0

