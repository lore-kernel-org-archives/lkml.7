Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF958C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFA52190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389286AbfJAOlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:41:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389116AbfJAOlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:41:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3213316E536;
        Tue,  1 Oct 2019 14:41:35 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 117335D9C9;
        Tue,  1 Oct 2019 14:41:32 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v5 08/10] mm/memory_hotplug: Don't check for "all holes" in shrink_zone_span()
Date:   Tue,  1 Oct 2019 16:40:09 +0200
Message-Id: <20191001144011.3801-9-david@redhat.com>
In-Reply-To: <20191001144011.3801-1-david@redhat.com>
References: <20191001144011.3801-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 01 Oct 2019 14:41:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have holes, the holes will automatically get detected and removed
once we remove the next bigger/smaller section. The extra checks can
go.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 273833612774..22b3623768c8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		if (pfn) {
 			zone->zone_start_pfn = pfn;
 			zone->spanned_pages = zone_end_pfn - pfn;
+		} else {
+			zone->zone_start_pfn = 0;
+			zone->spanned_pages = 0;
 		}
 	} else if (zone_end_pfn == end_pfn) {
 		/*
@@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 					       start_pfn);
 		if (pfn)
 			zone->spanned_pages = pfn - zone_start_pfn + 1;
+		else {
+			zone->zone_start_pfn = 0;
+			zone->spanned_pages = 0;
+		}
 	}
-
-	/*
-	 * The section is not biggest or smallest mem_section in the zone, it
-	 * only creates a hole in the zone. So in this case, we need not
-	 * change the zone. But perhaps, the zone has only hole data. Thus
-	 * it check the zone has only hole or not.
-	 */
-	pfn = zone_start_pfn;
-	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUBSECTION) {
-		if (unlikely(!pfn_to_online_page(pfn)))
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
-		zone_span_writeunlock(zone);
-		return;
-	}
-
-	/* The zone has no valid section */
-	zone->zone_start_pfn = 0;
-	zone->spanned_pages = 0;
 	zone_span_writeunlock(zone);
 }
 
-- 
2.21.0

