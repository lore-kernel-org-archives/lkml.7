Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EFB2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPIgIt5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfLKQc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:32:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730618AbfLKQcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576081941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/C4YIdlR5iqkfH1F0GZE8e7zY3LS+jdEFCQMbUyxA8=;
        b=BPIgIt5sejw0qUppnMAcUQZp/I2u5X3S+77l5Zhvlylh69UI2T/x+pKIwxc6ITU++xyq90
        DtBFQrK/y8lr33IXbVx9mTQwzFDNl98iD/FCOyihwFfOAwXIWjMEop1D2PR4KfTYCUqCKq
        I6GwoHyuyB94eG+ZSUbv5W4o/LB6j1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-9O8TlD6XNTKheEeUUzWing-1; Wed, 11 Dec 2019 11:32:16 -0500
X-MC-Unique: 9O8TlD6XNTKheEeUUzWing-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 536C2100FD59;
        Wed, 11 Dec 2019 16:32:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-148.ams2.redhat.com [10.36.117.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1AAB60BA8;
        Wed, 11 Dec 2019 16:32:13 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: [PATCH v2 3/3] mm: initialize memmap of unavailable memory directly
Date:   Wed, 11 Dec 2019 17:32:01 +0100
Message-Id: <20191211163201.17179-4-david@redhat.com>
In-Reply-To: <20191211163201.17179-1-david@redhat.com>
References: <20191211163201.17179-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make sure that all memory holes are actually marked
PageReserved(), that page_to_pfn() produces reliable results, and that
these pages are not detected as "mmap" pages due to the mapcount.

E.g., booting a x86-64 QEMU guest with 4160 MB:

[    0.010585] Early memory node ranges
[    0.010586]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.010588]   node   0: [mem 0x0000000000100000-0x00000000bffdefff]
[    0.010589]   node   0: [mem 0x0000000100000000-0x0000000143ffffff]

max_pfn is 0x144000.

Before this change:

[root@localhost ~]# ./page-types -r -a 0x144000,
             flags      page-count       MB  symbolic-flags              =
       long-symbolic-flags
0x0000000000000800           16384       64  ___________M________________=
_______________        mmap
             total           16384       64

After this change:

[root@localhost ~]# ./page-types -r -a 0x144000,
             flags      page-count       MB  symbolic-flags              =
       long-symbolic-flags
0x0000000100000000           16384       64  ___________________________r=
_______________        reserved
             total           16384       64

IOW, especially the unavailable physical memory ("memory hole") in the la=
st
section would not get properly marked PageReserved() and is indicated to =
be
"mmap" memory.

Drop the trace of that function from include/linux/mm.h - nobody else
needs it, and rename it accordingly.

Note: The fake zone/node might not be covered by the zone/node span. This
is not an urgent issue (for now, we had the same node/zone due to the
zeroing). We'll need a clean way to mark memory holes (e.g., using a page
type PageHole() if possible or a fake ZONE_INVALID) and eventually stop
marking these memory holes PageReserved().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  6 ------
 mm/page_alloc.c    | 33 ++++++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5dfbc0e56e67..93ee776c2a1e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2176,12 +2176,6 @@ extern int __meminit __early_pfn_to_nid(unsigned l=
ong pfn,
 					struct mminit_pfnnid_cache *state);
 #endif
=20
-#if !defined(CONFIG_FLAT_NODE_MEM_MAP)
-void zero_resv_unavail(void);
-#else
-static inline void zero_resv_unavail(void) {}
-#endif
-
 extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned=
 long,
 		enum memmap_context, struct vmem_altmap *);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1eb2ce7c79e4..85064abafcc3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6901,10 +6901,10 @@ void __init free_area_init_node(int nid, unsigned=
 long *zones_size,
=20
 #if !defined(CONFIG_FLAT_NODE_MEM_MAP)
 /*
- * Zero all valid struct pages in range [spfn, epfn), return number of s=
truct
- * pages zeroed
+ * Initialize all valid struct pages in the range [spfn, epfn) and mark =
them
+ * PageReserved(). Return the number of struct pages that were initializ=
ed.
  */
-static u64 zero_pfn_range(unsigned long spfn, unsigned long epfn)
+static u64 __init init_unavailable_range(unsigned long spfn, unsigned lo=
ng epfn)
 {
 	unsigned long pfn;
 	u64 pgcnt =3D 0;
@@ -6915,7 +6915,13 @@ static u64 zero_pfn_range(unsigned long spfn, unsi=
gned long epfn)
 				+ pageblock_nr_pages - 1;
 			continue;
 		}
-		mm_zero_struct_page(pfn_to_page(pfn));
+		/*
+		 * Use a fake node/zone (0) for now. Some of these pages
+		 * (in memblock.reserved but not in memblock.memory) will
+		 * get re-initialized via reserve_bootmem_region() later.
+		 */
+		__init_single_page(pfn_to_page(pfn), pfn, 0, 0);
+		__SetPageReserved(pfn_to_page(pfn));
 		pgcnt++;
 	}
=20
@@ -6927,7 +6933,7 @@ static u64 zero_pfn_range(unsigned long spfn, unsig=
ned long epfn)
  * initialized by going through __init_single_page(). But, there are som=
e
  * struct pages which are reserved in memblock allocator and their field=
s
  * may be accessed (for example page_to_pfn() on some configuration acce=
sses
- * flags). We must explicitly zero those struct pages.
+ * flags). We must explicitly initialize those struct pages.
  *
  * This function also addresses a similar issue where struct pages are l=
eft
  * uninitialized because the physical address range is not covered by
@@ -6935,7 +6941,7 @@ static u64 zero_pfn_range(unsigned long spfn, unsig=
ned long epfn)
  * layout is manually configured via memmap=3D, or when the highest phys=
ical
  * address (max_pfn) does not end on a section boundary.
  */
-void __init zero_resv_unavail(void)
+static void __init init_unavailable_mem(void)
 {
 	phys_addr_t start, end;
 	u64 i, pgcnt;
@@ -6948,7 +6954,8 @@ void __init zero_resv_unavail(void)
 	for_each_mem_range(i, &memblock.memory, NULL,
 			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
 		if (next < start)
-			pgcnt +=3D zero_pfn_range(PFN_DOWN(next), PFN_UP(start));
+			pgcnt +=3D init_unavailable_range(PFN_DOWN(next),
+							PFN_UP(start));
 		next =3D end;
 	}
=20
@@ -6959,8 +6966,8 @@ void __init zero_resv_unavail(void)
 	 * considered initialized. Make sure that memmap has a well defined
 	 * state.
 	 */
-	pgcnt +=3D zero_pfn_range(PFN_DOWN(next),
-				round_up(max_pfn, PAGES_PER_SECTION));
+	pgcnt +=3D init_unavailable_range(PFN_DOWN(next),
+					round_up(max_pfn, PAGES_PER_SECTION));
=20
 	/*
 	 * Struct pages that do not have backing memory. This could be because
@@ -6969,6 +6976,10 @@ void __init zero_resv_unavail(void)
 	if (pgcnt)
 		pr_info("Zeroed struct page in unavailable ranges: %lld pages", pgcnt)=
;
 }
+#else
+static inline void __init init_unavailable_mem(void)
+{
+}
 #endif /* !CONFIG_FLAT_NODE_MEM_MAP */
=20
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
@@ -7398,7 +7409,7 @@ void __init free_area_init_nodes(unsigned long *max=
_zone_pfn)
 	/* Initialise every node */
 	mminit_verify_pageflags_layout();
 	setup_nr_node_ids();
-	zero_resv_unavail();
+	init_unavailable_mem();
 	for_each_online_node(nid) {
 		pg_data_t *pgdat =3D NODE_DATA(nid);
 		free_area_init_node(nid, NULL,
@@ -7593,7 +7604,7 @@ void __init set_dma_reserve(unsigned long new_dma_r=
eserve)
=20
 void __init free_area_init(unsigned long *zones_size)
 {
-	zero_resv_unavail();
+	init_unavailable_mem();
 	free_area_init_node(0, zones_size,
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 }
--=20
2.23.0

