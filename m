Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32540ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E36621872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbfJAOlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:41:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25499 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388938AbfJAOlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:41:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 707903060850;
        Tue,  1 Oct 2019 14:41:11 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF3045D9D5;
        Tue,  1 Oct 2019 14:40:43 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Potapenko <glider@google.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 02/10] mm/memmap_init: Update variable name in memmap_init_zone
Date:   Tue,  1 Oct 2019 16:40:03 +0200
Message-Id: <20191001144011.3801-3-david@redhat.com>
In-Reply-To: <20191001144011.3801-1-david@redhat.com>
References: <20191001144011.3801-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 01 Oct 2019 14:41:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

The third argument is actually number of pages. Changes the variable name
from size to nr_pages to indicate this better.

No functional change in this patch.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: Alexander Potapenko <glider@google.com>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 15c2050c629b..b0b2d5464000 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5936,10 +5936,10 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 #ifdef CONFIG_ZONE_DEVICE
 void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long start_pfn,
-				   unsigned long size,
+				   unsigned long nr_pages,
 				   struct dev_pagemap *pgmap)
 {
-	unsigned long pfn, end_pfn = start_pfn + size;
+	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
 	unsigned long zone_idx = zone_idx(zone);
@@ -5956,7 +5956,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	 */
 	if (altmap) {
 		start_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
-		size = end_pfn - start_pfn;
+		nr_pages = end_pfn - start_pfn;
 	}
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
@@ -6003,7 +6003,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	}
 
 	pr_info("%s initialised %lu pages in %ums\n", __func__,
-		size, jiffies_to_msecs(jiffies - start));
+		nr_pages, jiffies_to_msecs(jiffies - start));
 }
 
 #endif
-- 
2.21.0

