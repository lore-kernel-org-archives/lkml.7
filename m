Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C2EC282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127AA21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQVCFkvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDEWMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:12:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44498 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDEWM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:12:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so3987978pfm.11;
        Fri, 05 Apr 2019 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dVuSGqGMdSL+lYB9NVdPOXJ/yezgrt5Vhv+/46VVp14=;
        b=JQVCFkvUkfWotyAFTK0D20cgOePlePMZbaEA60cegN8gvROzBwq6nj7PYVeXVjhR8g
         NZzIIiVk2R4QQvX6GA8mIKChjKmhPLCY+hYRKgEiuHzfsshVMvf0mOQlLzE+e0mG5L2U
         prbcDAvY/fTOQJSxxCXfORrqJuu4QoAEf0wXdalbKvLm/vf/DkOoQZdivMOpzrNZP/lN
         vkS06bjvHACsJldSdBM0ThykU5zprTeBnS46dQ8JZ9hcpXn47Zjhtzeah/QrVfh5i7Vh
         PVnpqnU7tXzqfiMoHOm76lWBBUH+Mx2uwHhcCELcSLVlkTi6xJuNGIX7/LefnnkIlzvL
         fIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dVuSGqGMdSL+lYB9NVdPOXJ/yezgrt5Vhv+/46VVp14=;
        b=hfHdQE/Oy2cjdyKjt0olQRiI3WzSDWZbExk5SCHUBbwBIVVhnymS7YUx0njiQVPR/h
         bPRe679slXRdnmDljkx8YWsgsRoSsFqkcoRvqP1Z9zGBHg4LBBf4dGOaxwLvmakGq8Xs
         2cn8YZ+5ITCYae89tTOVynzrBWWRv84TUmdZyB8Vpgh6joxgbeTIHsYq5KQNRlwBOJfu
         teRGu72MTm7Xccas2Ptr4DUocP9D3Mo7diSGTkkVgY5H9uEDOlQz+zyhZaGyPF5zz2FP
         plXzMxCRX1+bl8FfC23jnD8Mu50ya6bY9dmEQeDcwpZnjKaYofbjsYZkVjKmborcaFoM
         dd+Q==
X-Gm-Message-State: APjAAAV7FN+12ExA5MSKwruoOBFNCZGMh+Z/eTspJzBHwNY9cpIq2MKJ
        xTtEuHEV6auOjnw+rxL1WY8=
X-Google-Smtp-Source: APXvYqxKbwb1VzShMBMk6QhT/5s3udfUks/YgS3lLw5sgTjR3Ne4rhJN++RLqGAP8qX1lUodDpAx3g==
X-Received: by 2002:aa7:8289:: with SMTP id s9mr15095613pfm.208.1554502346930;
        Fri, 05 Apr 2019 15:12:26 -0700 (PDT)
Received: from localhost.localdomain (50-126-100-225.drr01.csby.or.frontiernet.net. [50.126.100.225])
        by smtp.gmail.com with ESMTPSA id f63sm30382350pfc.180.2019.04.05.15.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 15:12:26 -0700 (PDT)
Subject: [mm PATCH v7 3/4] mm: Implement new zone specific memblock iterator
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
Date:   Fri, 05 Apr 2019 15:12:25 -0700
Message-ID: <20190405221225.12227.22573.stgit@localhost.localdomain>
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

Introduce a new iterator for_each_free_mem_pfn_range_in_zone.

This iterator will take care of making sure a given memory range provided
is in fact contained within a zone. It takes are of all the bounds checking
we were doing in deferred_grow_zone, and deferred_init_memmap. In addition
it should help to speed up the search a bit by iterating until the end of a
range is greater than the start of the zone pfn range, and will exit
completely if the start is beyond the end of the zone.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/linux/memblock.h |   25 ++++++++++++++++++
 mm/memblock.c            |   64 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c          |   31 +++++++++-------------
 3 files changed, 101 insertions(+), 19 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 294d5d80e150..f8b78892b977 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -240,6 +240,31 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
+				  unsigned long *out_spfn,
+				  unsigned long *out_epfn);
+/**
+ * for_each_free_mem_range_in_zone - iterate through zone specific free
+ * memblock areas
+ * @i: u64 used as loop variable
+ * @zone: zone in which all of the memory blocks reside
+ * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
+ * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
+ *
+ * Walks over free (memory && !reserved) areas of memblock in a specific
+ * zone. Available once memblock and an empty zone is initialized. The main
+ * assumption is that the zone start, end, and pgdat have been associated.
+ * This way we can use the zone to determine NUMA node, and if a given part
+ * of the memblock is valid for the zone.
+ */
+#define for_each_free_mem_pfn_range_in_zone(i, zone, p_start, p_end)	\
+	for (i = 0,							\
+	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end);	\
+	     i != U64_MAX;					\
+	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
+#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
+
 /**
  * for_each_free_mem_range - iterate through free memblock areas
  * @i: u64 used as loop variable
diff --git a/mm/memblock.c b/mm/memblock.c
index e7665cf914b1..28fa8926d9f8 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1255,6 +1255,70 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 	return 0;
 }
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+/**
+ * __next_mem_pfn_range_in_zone - iterator for for_each_*_range_in_zone()
+ *
+ * @idx: pointer to u64 loop variable
+ * @zone: zone in which all of the memory blocks reside
+ * @out_spfn: ptr to ulong for start pfn of the range, can be %NULL
+ * @out_epfn: ptr to ulong for end pfn of the range, can be %NULL
+ *
+ * This function is meant to be a zone/pfn specific wrapper for the
+ * for_each_mem_range type iterators. Specifically they are used in the
+ * deferred memory init routines and as such we were duplicating much of
+ * this logic throughout the code. So instead of having it in multiple
+ * locations it seemed like it would make more sense to centralize this to
+ * one new iterator that does everything they need.
+ */
+void __init_memblock
+__next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
+			     unsigned long *out_spfn, unsigned long *out_epfn)
+{
+	int zone_nid = zone_to_nid(zone);
+	phys_addr_t spa, epa;
+	int nid;
+
+	__next_mem_range(idx, zone_nid, MEMBLOCK_NONE,
+			 &memblock.memory, &memblock.reserved,
+			 &spa, &epa, &nid);
+
+	while (*idx != U64_MAX) {
+		unsigned long epfn = PFN_DOWN(epa);
+		unsigned long spfn = PFN_UP(spa);
+
+		/*
+		 * Verify the end is at least past the start of the zone and
+		 * that we have at least one PFN to initialize.
+		 */
+		if (zone->zone_start_pfn < epfn && spfn < epfn) {
+			/* if we went too far just stop searching */
+			if (zone_end_pfn(zone) <= spfn) {
+				*idx = U64_MAX;
+				break;
+			}
+
+			if (out_spfn)
+				*out_spfn = max(zone->zone_start_pfn, spfn);
+			if (out_epfn)
+				*out_epfn = min(zone_end_pfn(zone), epfn);
+
+			return;
+		}
+
+		__next_mem_range(idx, zone_nid, MEMBLOCK_NONE,
+				 &memblock.memory, &memblock.reserved,
+				 &spa, &epa, &nid);
+	}
+
+	/* signal end of iteration */
+	if (out_spfn)
+		*out_spfn = ULONG_MAX;
+	if (out_epfn)
+		*out_epfn = 0;
+}
+
+#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
 /**
  * memblock_alloc_range_nid - allocate boot memory block
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2d2bca9803d2..61467e28c966 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1613,11 +1613,9 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 static int __init deferred_init_memmap(void *data)
 {
 	pg_data_t *pgdat = data;
-	int nid = pgdat->node_id;
 	unsigned long start = jiffies;
 	unsigned long nr_pages = 0;
 	unsigned long spfn, epfn, first_init_pfn, flags;
-	phys_addr_t spa, epa;
 	int zid;
 	struct zone *zone;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
@@ -1654,14 +1652,12 @@ static int __init deferred_init_memmap(void *data)
 	 * freeing pages we can access pages that are ahead (computing buddy
 	 * page in __free_one_page()).
 	 */
-	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &spa, &epa, NULL) {
-		spfn = max_t(unsigned long, first_init_pfn, PFN_UP(spa));
-		epfn = min_t(unsigned long, zone_end_pfn(zone), PFN_DOWN(epa));
+	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
+		spfn = max_t(unsigned long, first_init_pfn, spfn);
 		nr_pages += deferred_init_pages(zone, spfn, epfn);
 	}
-	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &spa, &epa, NULL) {
-		spfn = max_t(unsigned long, first_init_pfn, PFN_UP(spa));
-		epfn = min_t(unsigned long, zone_end_pfn(zone), PFN_DOWN(epa));
+	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
+		spfn = max_t(unsigned long, first_init_pfn, spfn);
 		deferred_free_pages(spfn, epfn);
 	}
 	pgdat_resize_unlock(pgdat, &flags);
@@ -1669,8 +1665,8 @@ static int __init deferred_init_memmap(void *data)
 	/* Sanity check that the next zone really is unpopulated */
 	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
 
-	pr_info("node %d initialised, %lu pages in %ums\n", nid, nr_pages,
-					jiffies_to_msecs(jiffies - start));
+	pr_info("node %d initialised, %lu pages in %ums\n",
+		pgdat->node_id,	nr_pages, jiffies_to_msecs(jiffies - start));
 
 	pgdat_init_report_one_done();
 	return 0;
@@ -1694,13 +1690,11 @@ static int __init deferred_init_memmap(void *data)
 static noinline bool __init
 deferred_grow_zone(struct zone *zone, unsigned int order)
 {
-	int nid = zone_to_nid(zone);
-	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
+	pg_data_t *pgdat = zone->zone_pgdat;
 	unsigned long nr_pages = 0;
 	unsigned long first_init_pfn, spfn, epfn, t, flags;
 	unsigned long first_deferred_pfn = pgdat->first_deferred_pfn;
-	phys_addr_t spa, epa;
 	u64 i;
 
 	/* Only the last zone may have deferred pages */
@@ -1736,9 +1730,8 @@ static int __init deferred_init_memmap(void *data)
 		return false;
 	}
 
-	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &spa, &epa, NULL) {
-		spfn = max_t(unsigned long, first_init_pfn, PFN_UP(spa));
-		epfn = min_t(unsigned long, zone_end_pfn(zone), PFN_DOWN(epa));
+	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
+		spfn = max_t(unsigned long, first_init_pfn, spfn);
 
 		while (spfn < epfn && nr_pages < nr_pages_needed) {
 			t = ALIGN(spfn + PAGES_PER_SECTION, PAGES_PER_SECTION);
@@ -1752,9 +1745,9 @@ static int __init deferred_init_memmap(void *data)
 			break;
 	}
 
-	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &spa, &epa, NULL) {
-		spfn = max_t(unsigned long, first_init_pfn, PFN_UP(spa));
-		epfn = min_t(unsigned long, first_deferred_pfn, PFN_DOWN(epa));
+	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
+		spfn = max_t(unsigned long, first_init_pfn, spfn);
+		epfn = min_t(unsigned long, first_deferred_pfn, epfn);
 		deferred_free_pages(spfn, epfn);
 
 		if (first_deferred_pfn == epfn)

