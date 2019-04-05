Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF2BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC6A21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnKcALRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDEWMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:12:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46300 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDEWMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:12:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so3741904pgv.13;
        Fri, 05 Apr 2019 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uA3ehOa7Jw+A2AorvTLb7I9vCJ3fGJ8/5DDYOfi5sas=;
        b=WnKcALRdTyp6pCXsE8JbLXwNSXmiTwrFsD86/ca15xC7u7WFUMr1dE7ApT0PWfBIj/
         fVBe++igQ81F0zOktIZCozX8rjRSnoaY/GpBr5fuTvNnGBXAU/EDVdcQ0j+YK8gSJeFp
         SozQ8JmKuk9ZMiwRigZonoRQ1Kju/DEIKDhTYiizw22qlnPVmsaxixL9bcZW32E+OvG7
         XHC2vZ1cNV5OSM9zq4yYXWIslODYdwvFMAYTmV7/VnGEQQYwI/TRwTOOL8ladUa+HnhF
         1iCWT8NRfzQ4w7IDGGxbRN7d6C/Zjv1zIzS70/GaGt3PS1S0zVGPPvA/WQa7F3kdFjsY
         gkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uA3ehOa7Jw+A2AorvTLb7I9vCJ3fGJ8/5DDYOfi5sas=;
        b=r/UMhVHGHpBZ65584OIuBFMhyCnZSwShGSdqfWvX21s9hkJmrzrXf8Rc9hOB0c3QOP
         Yn+wX4l6XfeoZWBFUf+FRo4jkwa2/CR5jJX1TYp3WEuVNFSnw+6PKLvDx8xh3cdVxDr4
         6JEp+vYkqESgiDYX+tbUOMbqc37nbrVZclnU14exkweRUwyTaZqI8g6TOmBu9SxUk0Zr
         rsaWi+Eysv6pBnXNjeEI3an+yojkJtNiACqdJWEtf6TSpmpfNyBFVBdUCekM8wWYVtJm
         O360Klp7i9/4pdmiewftKRcsQ8pXCQKVHnwXaBmKwwwiZpmDmeQ5a97bl2kzO9kaNqH1
         qzhg==
X-Gm-Message-State: APjAAAXai2lIXPdulB1iunVXc8Dgfq2WdbuoTfvT+saeVIyQb+dx2tjO
        MlJ1jNIO+bVaHe0m2a3VCI0=
X-Google-Smtp-Source: APXvYqyGZ2UBm/RKCejvVc5BO/RoTRbaNNjBjAA4639olLhxNtuws2N0qQgEDERakVOHFz2Xtsl69Q==
X-Received: by 2002:a65:5183:: with SMTP id h3mr14500620pgq.53.1554502353162;
        Fri, 05 Apr 2019 15:12:33 -0700 (PDT)
Received: from localhost.localdomain (50-126-100-225.drr01.csby.or.frontiernet.net. [50.126.100.225])
        by smtp.gmail.com with ESMTPSA id a3sm39604616pfn.182.2019.04.05.15.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 15:12:32 -0700 (PDT)
Subject: [mm PATCH v7 4/4] mm: Initialize MAX_ORDER_NR_PAGES at a time
 instead of doing larger sections
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, linux-nvdimm@lists.01.org,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, mingo@kernel.org, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        davem@davemloft.net, kirill.shutemov@linux.intel.com
Date:   Fri, 05 Apr 2019 15:12:32 -0700
Message-ID: <20190405221231.12227.85836.stgit@localhost.localdomain>
In-Reply-To: <20190405221043.12227.19679.stgit@localhost.localdomain>
References: <20190405221043.12227.19679.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Add yet another iterator, for_each_free_mem_range_in_zone_from, and then
use it to support initializing and freeing pages in groups no larger than
MAX_ORDER_NR_PAGES. By doing this we can greatly improve the cache locality
of the pages while we do several loops over them in the init and freeing
process.

We are able to tighten the loops further as a result of the "from" iterator
as we can perform the initial checks for first_init_pfn in our first call
to the iterator, and continue without the need for those checks via the
"from" iterator. I have added this functionality in the function called
deferred_init_mem_pfn_range_in_zone that primes the iterator and causes us
to exit if we encounter any failure.

On my x86_64 test system with 384GB of memory per node I saw a reduction in
initialization time from 1.85s to 1.38s as a result of this patch.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/linux/memblock.h |   16 +++++
 mm/page_alloc.c          |  162 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 137 insertions(+), 41 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f8b78892b977..47e3c0612592 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -263,6 +263,22 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end);	\
 	     i != U64_MAX;					\
 	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
+
+/**
+ * for_each_free_mem_range_in_zone_from - iterate through zone specific
+ * free memblock areas from a given point
+ * @i: u64 used as loop variable
+ * @zone: zone in which all of the memory blocks reside
+ * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
+ * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
+ *
+ * Walks over free (memory && !reserved) areas of memblock in a specific
+ * zone, continuing from current position. Available as soon as memblock is
+ * initialized.
+ */
+#define for_each_free_mem_pfn_range_in_zone_from(i, zone, p_start, p_end) \
+	for (; i != U64_MAX;					  \
+	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 61467e28c966..06fbec9edf84 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1609,16 +1609,100 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 	return (nr_pages);
 }
 
+/*
+ * This function is meant to pre-load the iterator for the zone init.
+ * Specifically it walks through the ranges until we are caught up to the
+ * first_init_pfn value and exits there. If we never encounter the value we
+ * return false indicating there are no valid ranges left.
+ */
+static bool __init
+deferred_init_mem_pfn_range_in_zone(u64 *i, struct zone *zone,
+				    unsigned long *spfn, unsigned long *epfn,
+				    unsigned long first_init_pfn)
+{
+	u64 j;
+
+	/*
+	 * Start out by walking through the ranges in this zone that have
+	 * already been initialized. We don't need to do anything with them
+	 * so we just need to flush them out of the system.
+	 */
+	for_each_free_mem_pfn_range_in_zone(j, zone, spfn, epfn) {
+		if (*epfn <= first_init_pfn)
+			continue;
+		if (*spfn < first_init_pfn)
+			*spfn = first_init_pfn;
+		*i = j;
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Initialize and free pages. We do it in two loops: first we initialize
+ * struct page, then free to buddy allocator, because while we are
+ * freeing pages we can access pages that are ahead (computing buddy
+ * page in __free_one_page()).
+ *
+ * In order to try and keep some memory in the cache we have the loop
+ * broken along max page order boundaries. This way we will not cause
+ * any issues with the buddy page computation.
+ */
+static unsigned long __init
+deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
+		       unsigned long *end_pfn)
+{
+	unsigned long mo_pfn = ALIGN(*start_pfn + 1, MAX_ORDER_NR_PAGES);
+	unsigned long spfn = *start_pfn, epfn = *end_pfn;
+	unsigned long nr_pages = 0;
+	u64 j = *i;
+
+	/* First we loop through and initialize the page values */
+	for_each_free_mem_pfn_range_in_zone_from(j, zone, start_pfn, end_pfn) {
+		unsigned long t;
+
+		if (mo_pfn <= *start_pfn)
+			break;
+
+		t = min(mo_pfn, *end_pfn);
+		nr_pages += deferred_init_pages(zone, *start_pfn, t);
+
+		if (mo_pfn < *end_pfn) {
+			*start_pfn = mo_pfn;
+			break;
+		}
+	}
+
+	/* Reset values and now loop through freeing pages as needed */
+	swap(j, *i);
+
+	for_each_free_mem_pfn_range_in_zone_from(j, zone, &spfn, &epfn) {
+		unsigned long t;
+
+		if (mo_pfn <= spfn)
+			break;
+
+		t = min(mo_pfn, epfn);
+		deferred_free_pages(spfn, t);
+
+		if (mo_pfn <= epfn)
+			break;
+	}
+
+	return nr_pages;
+}
+
 /* Initialise remaining memory on a node */
 static int __init deferred_init_memmap(void *data)
 {
 	pg_data_t *pgdat = data;
+	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
+	unsigned long spfn = 0, epfn = 0, nr_pages = 0;
+	unsigned long first_init_pfn, flags;
 	unsigned long start = jiffies;
-	unsigned long nr_pages = 0;
-	unsigned long spfn, epfn, first_init_pfn, flags;
-	int zid;
 	struct zone *zone;
-	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
+	int zid;
 	u64 i;
 
 	/* Bind memory initialisation thread to a local node if possible */
@@ -1644,22 +1728,20 @@ static int __init deferred_init_memmap(void *data)
 		if (first_init_pfn < zone_end_pfn(zone))
 			break;
 	}
-	first_init_pfn = max(zone->zone_start_pfn, first_init_pfn);
+
+	/* If the zone is empty somebody else may have cleared out the zone */
+	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
+						 first_init_pfn))
+		goto zone_empty;
 
 	/*
-	 * Initialize and free pages. We do it in two loops: first we initialize
-	 * struct page, than free to buddy allocator, because while we are
-	 * freeing pages we can access pages that are ahead (computing buddy
-	 * page in __free_one_page()).
+	 * Initialize and free pages in MAX_ORDER sized increments so
+	 * that we can avoid introducing any issues with the buddy
+	 * allocator.
 	 */
-	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
-		spfn = max_t(unsigned long, first_init_pfn, spfn);
-		nr_pages += deferred_init_pages(zone, spfn, epfn);
-	}
-	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
-		spfn = max_t(unsigned long, first_init_pfn, spfn);
-		deferred_free_pages(spfn, epfn);
-	}
+	while (spfn < epfn)
+		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+zone_empty:
 	pgdat_resize_unlock(pgdat, &flags);
 
 	/* Sanity check that the next zone really is unpopulated */
@@ -1692,9 +1774,9 @@ static int __init deferred_init_memmap(void *data)
 {
 	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
 	pg_data_t *pgdat = zone->zone_pgdat;
-	unsigned long nr_pages = 0;
-	unsigned long first_init_pfn, spfn, epfn, t, flags;
 	unsigned long first_deferred_pfn = pgdat->first_deferred_pfn;
+	unsigned long spfn, epfn, flags;
+	unsigned long nr_pages = 0;
 	u64 i;
 
 	/* Only the last zone may have deferred pages */
@@ -1723,37 +1805,35 @@ static int __init deferred_init_memmap(void *data)
 		return true;
 	}
 
-	first_init_pfn = max(zone->zone_start_pfn, first_deferred_pfn);
-
-	if (first_init_pfn >= pgdat_end_pfn(pgdat)) {
+	/* If the zone is empty somebody else may have cleared out the zone */
+	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
+						 first_deferred_pfn)) {
+		pgdat->first_deferred_pfn = ULONG_MAX;
 		pgdat_resize_unlock(pgdat, &flags);
-		return false;
+		return true;
 	}
 
-	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
-		spfn = max_t(unsigned long, first_init_pfn, spfn);
+	/*
+	 * Initialize and free pages in MAX_ORDER sized increments so
+	 * that we can avoid introducing any issues with the buddy
+	 * allocator.
+	 */
+	while (spfn < epfn) {
+		/* update our first deferred PFN for this section */
+		first_deferred_pfn = spfn;
+
+		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
 
-		while (spfn < epfn && nr_pages < nr_pages_needed) {
-			t = ALIGN(spfn + PAGES_PER_SECTION, PAGES_PER_SECTION);
-			first_deferred_pfn = min(t, epfn);
-			nr_pages += deferred_init_pages(zone, spfn,
-							first_deferred_pfn);
-			spfn = first_deferred_pfn;
-		}
+		/* We should only stop along section boundaries */
+		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
+			continue;
 
+		/* If our quota has been met we can stop here */
 		if (nr_pages >= nr_pages_needed)
 			break;
 	}
 
-	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
-		spfn = max_t(unsigned long, first_init_pfn, spfn);
-		epfn = min_t(unsigned long, first_deferred_pfn, epfn);
-		deferred_free_pages(spfn, epfn);
-
-		if (first_deferred_pfn == epfn)
-			break;
-	}
-	pgdat->first_deferred_pfn = first_deferred_pfn;
+	pgdat->first_deferred_pfn = spfn;
 	pgdat_resize_unlock(pgdat, &flags);
 
 	return nr_pages > 0;

