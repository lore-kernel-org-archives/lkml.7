Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B59C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA71F20836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8DTVJdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfLIRtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:49:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726818AbfLIRs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575913734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIMYiSqspAv8n61S8tgbkZ68HfWcOMbw8/ayJuQpZ20=;
        b=I8DTVJdzSSw7ZHW/VL1UJuUCQuY9SPRBbFiSzrLxrOEnC8atQWLTVXE90iXLfoO2Y+kRBr
        R5/DsP9rqRerNwQ/z+Epg0Y7F17LiB2lJ5Jlm0J0s64maCB5PGbdUJm7rAhNV/i8ff5AI1
        LgGcmDNzEGQlJQC03LOCH1/7VzSaM28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-J57-AI3yNo22k9uftEx15w-1; Mon, 09 Dec 2019 12:48:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B6B6801E77;
        Mon,  9 Dec 2019 17:48:50 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-214.ams2.redhat.com [10.36.116.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 580941001938;
        Mon,  9 Dec 2019 17:48:48 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: [PATCH v1 3/3] mm: initialize memmap of unavailable memory directly
Date:   Mon,  9 Dec 2019 18:48:36 +0100
Message-Id: <20191209174836.11063-4-david@redhat.com>
In-Reply-To: <20191209174836.11063-1-david@redhat.com>
References: <20191209174836.11063-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: J57-AI3yNo22k9uftEx15w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
             flags      page-count       MB  symbolic-flags                =
     long-symbolic-flags
0x0000000000000800           16384       64  ___________M__________________=
_____________        mmap
             total           16384       64

After this change:

[root@localhost ~]# ./page-types -r -a 0x144000,
             flags      page-count       MB  symbolic-flags                =
     long-symbolic-flags
0x0000000100000000           16384       64  ___________________________r__=
_____________        reserved
             total           16384       64

IOW, especially the unavailable physical memory ("memory hole") in the last
section would not get properly marked PageReserved() and is indicated to be
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
@@ -2176,12 +2176,6 @@ extern int __meminit __early_pfn_to_nid(unsigned lon=
g pfn,
 =09=09=09=09=09struct mminit_pfnnid_cache *state);
 #endif
=20
-#if !defined(CONFIG_FLAT_NODE_MEM_MAP)
-void zero_resv_unavail(void);
-#else
-static inline void zero_resv_unavail(void) {}
-#endif
-
 extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned l=
ong,
 =09=09enum memmap_context, struct vmem_altmap *);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1eb2ce7c79e4..85064abafcc3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6901,10 +6901,10 @@ void __init free_area_init_node(int nid, unsigned l=
ong *zones_size,
=20
 #if !defined(CONFIG_FLAT_NODE_MEM_MAP)
 /*
- * Zero all valid struct pages in range [spfn, epfn), return number of str=
uct
- * pages zeroed
+ * Initialize all valid struct pages in the range [spfn, epfn) and mark th=
em
+ * PageReserved(). Return the number of struct pages that were initialized=
.
  */
-static u64 zero_pfn_range(unsigned long spfn, unsigned long epfn)
+static u64 __init init_unavailable_range(unsigned long spfn, unsigned long=
 epfn)
 {
 =09unsigned long pfn;
 =09u64 pgcnt =3D 0;
@@ -6915,7 +6915,13 @@ static u64 zero_pfn_range(unsigned long spfn, unsign=
ed long epfn)
 =09=09=09=09+ pageblock_nr_pages - 1;
 =09=09=09continue;
 =09=09}
-=09=09mm_zero_struct_page(pfn_to_page(pfn));
+=09=09/*
+=09=09 * Use a fake node/zone (0) for now. Some of these pages
+=09=09 * (in memblock.reserved but not in memblock.memory) will
+=09=09 * get re-initialized via reserve_bootmem_region() later.
+=09=09 */
+=09=09__init_single_page(pfn_to_page(pfn), pfn, 0, 0);
+=09=09__SetPageReserved(pfn_to_page(pfn));
 =09=09pgcnt++;
 =09}
=20
@@ -6927,7 +6933,7 @@ static u64 zero_pfn_range(unsigned long spfn, unsigne=
d long epfn)
  * initialized by going through __init_single_page(). But, there are some
  * struct pages which are reserved in memblock allocator and their fields
  * may be accessed (for example page_to_pfn() on some configuration access=
es
- * flags). We must explicitly zero those struct pages.
+ * flags). We must explicitly initialize those struct pages.
  *
  * This function also addresses a similar issue where struct pages are lef=
t
  * uninitialized because the physical address range is not covered by
@@ -6935,7 +6941,7 @@ static u64 zero_pfn_range(unsigned long spfn, unsigne=
d long epfn)
  * layout is manually configured via memmap=3D, or when the highest physic=
al
  * address (max_pfn) does not end on a section boundary.
  */
-void __init zero_resv_unavail(void)
+static void __init init_unavailable_mem(void)
 {
 =09phys_addr_t start, end;
 =09u64 i, pgcnt;
@@ -6948,7 +6954,8 @@ void __init zero_resv_unavail(void)
 =09for_each_mem_range(i, &memblock.memory, NULL,
 =09=09=09NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
 =09=09if (next < start)
-=09=09=09pgcnt +=3D zero_pfn_range(PFN_DOWN(next), PFN_UP(start));
+=09=09=09pgcnt +=3D init_unavailable_range(PFN_DOWN(next),
+=09=09=09=09=09=09=09PFN_UP(start));
 =09=09next =3D end;
 =09}
=20
@@ -6959,8 +6966,8 @@ void __init zero_resv_unavail(void)
 =09 * considered initialized. Make sure that memmap has a well defined
 =09 * state.
 =09 */
-=09pgcnt +=3D zero_pfn_range(PFN_DOWN(next),
-=09=09=09=09round_up(max_pfn, PAGES_PER_SECTION));
+=09pgcnt +=3D init_unavailable_range(PFN_DOWN(next),
+=09=09=09=09=09round_up(max_pfn, PAGES_PER_SECTION));
=20
 =09/*
 =09 * Struct pages that do not have backing memory. This could be because
@@ -6969,6 +6976,10 @@ void __init zero_resv_unavail(void)
 =09if (pgcnt)
 =09=09pr_info("Zeroed struct page in unavailable ranges: %lld pages", pgcn=
t);
 }
+#else
+static inline void __init init_unavailable_mem(void)
+{
+}
 #endif /* !CONFIG_FLAT_NODE_MEM_MAP */
=20
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
@@ -7398,7 +7409,7 @@ void __init free_area_init_nodes(unsigned long *max_z=
one_pfn)
 =09/* Initialise every node */
 =09mminit_verify_pageflags_layout();
 =09setup_nr_node_ids();
-=09zero_resv_unavail();
+=09init_unavailable_mem();
 =09for_each_online_node(nid) {
 =09=09pg_data_t *pgdat =3D NODE_DATA(nid);
 =09=09free_area_init_node(nid, NULL,
@@ -7593,7 +7604,7 @@ void __init set_dma_reserve(unsigned long new_dma_res=
erve)
=20
 void __init free_area_init(unsigned long *zones_size)
 {
-=09zero_resv_unavail();
+=09init_unavailable_mem();
 =09free_area_init_node(0, zones_size,
 =09=09=09__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 }
--=20
2.21.0

