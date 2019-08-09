Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE5EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEED221783
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407012AbfHIM5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12365 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406992AbfHIM5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:57:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82E5FC0A1971;
        Fri,  9 Aug 2019 12:57:40 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-120.ams2.redhat.com [10.36.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D61EC5D6A0;
        Fri,  9 Aug 2019 12:57:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 3/4] mm/memory_hotplug: Simplify online_pages_range()
Date:   Fri,  9 Aug 2019 14:57:00 +0200
Message-Id: <20190809125701.3316-4-david@redhat.com>
In-Reply-To: <20190809125701.3316-1-david@redhat.com>
References: <20190809125701.3316-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 09 Aug 2019 12:57:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move_pfn_range_to_zone() will set all pages to PG_reserved via
memmap_init_zone(). The only way a page could no longer be reserved
would be if a MEM_GOING_ONLINE notifier would clear PG_reserved - which
is not done (the online_page callback is used for that purpose by
e.g., Hyper-V instead). walk_system_ram_range() will never call
online_pages_range() with duplicate PFNs, so drop the PageReserved() check.

Simplify the handling, as online_pages always corresponds to nr_pages.
There is no need for online_pages_blocks() anymore.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2abd938c8c45..87f85597a19e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -632,37 +632,31 @@ static void generic_online_page(struct page *page, unsigned int order)
 #endif
 }
 
-static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
+static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
+			void *arg)
 {
-	unsigned long end = start + nr_pages;
-	int order, onlined_pages = 0;
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn;
+	int order;
 
-	while (start < end) {
-		order = min(MAX_ORDER - 1,
-			get_order(PFN_PHYS(end) - PFN_PHYS(start)));
+	/*
+	 * Online the pages. The callback might decide to keep some pages
+	 * PG_reserved (to add them to the buddy later), but we still account
+	 * them as being online/belonging to this zone ("present").
+	 */
+	for (pfn = start_pfn; pfn < end_pfn; pfn += 1ul << order) {
+		order = min(MAX_ORDER - 1, get_order(PFN_PHYS(end_pfn - pfn)));
 		/* make sure the PFN is aligned and we don't exceed the range */
-		while (!IS_ALIGNED(start, 1ul << order) ||
-		       (1ul << order) > end - start)
+		while (!IS_ALIGNED(start_pfn, 1ul << order) ||
+		       (1ul << order) > end_pfn - pfn)
 			order--;
-		(*online_page_callback)(pfn_to_page(start), order);
-
-		onlined_pages += (1UL << order);
-		start += (1UL << order);
+		(*online_page_callback)(pfn_to_page(pfn), order);
 	}
-	return onlined_pages;
-}
-
-static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
-			void *arg)
-{
-	unsigned long onlined_pages = *(unsigned long *)arg;
-
-	if (PageReserved(pfn_to_page(start_pfn)))
-		onlined_pages += online_pages_blocks(start_pfn, nr_pages);
 
-	online_mem_sections(start_pfn, start_pfn + nr_pages);
+	/* mark all involved sections as online */
+	online_mem_sections(start_pfn, end_pfn);
 
-	*(unsigned long *)arg = onlined_pages;
+	*(unsigned long *)arg += nr_pages;
 	return 0;
 }
 
-- 
2.21.0

