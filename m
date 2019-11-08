Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83616C5DF61
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443CB21D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKHAPV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:15:21 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:54995 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKHAPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:15:20 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id xA80Ew8r002048
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Nov 2019 09:14:58 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xA80EwTT009552;
        Fri, 8 Nov 2019 09:14:58 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xA80DeGm009682;
        Fri, 8 Nov 2019 09:14:57 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-10186096; Fri, 8 Nov 2019 09:08:11 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0439.000; Fri, 8
 Nov 2019 09:08:11 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: [PATCH 2/3] mm: Introduce subsection_dev_map
Thread-Topic: [PATCH 2/3] mm: Introduce subsection_dev_map
Thread-Index: AQHVlciaV4LdiB2s4UGTCvjTchQqtg==
Date:   Fri, 8 Nov 2019 00:08:10 +0000
Message-ID: <20191108000855.25209-3-t-fukasawa@vx.jp.nec.com>
References: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
In-Reply-To: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no way to identify pfn on ZONE_DEVICE.
Identifying pfn on system memory can be done by using a
section-level flag. On the other hand, identifying pfn on
ZONE_DEVICE requires a subsection-level flag since ZONE_DEVICE
can be created in units of subsections.

This patch introduces a new bitmap subsection_dev_map so that
we can identify pfn on ZONE_DEVICE.

Also, subsection_dev_map is used to prove that struct pages
included in the subsection have been initialized since it is
set after memmap_init_zone_device(). We can avoid accessing
pages currently being initialized by checking subsection_dev_map.

Signed-off-by: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
---
 include/linux/mmzone.h | 19 +++++++++++++++++++
 mm/memremap.c          |  2 ++
 mm/sparse.c            | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index bda2028..11376c4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1174,11 +1174,17 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
 
 struct mem_section_usage {
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
+#ifdef CONFIG_ZONE_DEVICE
+	DECLARE_BITMAP(subsection_dev_map, SUBSECTIONS_PER_SECTION);
+#endif
 	/* See declaration of similar field in struct zone */
 	unsigned long pageblock_flags[0];
 };
 
 void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
+#ifdef CONFIG_ZONE_DEVICE
+void subsections_mark_device(unsigned long start_pfn, unsigned long size);
+#endif
 
 struct page;
 struct page_ext;
@@ -1367,6 +1373,19 @@ static inline int pfn_present(unsigned long pfn)
 	return present_section(__nr_to_section(pfn_to_section_nr(pfn)));
 }
 
+static inline int pfn_zone_device(unsigned long pfn)
+{
+#ifdef CONFIG_ZONE_DEVICE
+	if (pfn_valid(pfn)) {
+		struct mem_section *ms = __pfn_to_section(pfn);
+		int idx = subsection_map_index(pfn);
+
+		return test_bit(idx, ms->usage->subsection_dev_map);
+	}
+#endif
+	return 0;
+}
+
 /*
  * These are _only_ used during initialisation, therefore they
  * can use __initdata ...  They could have names to indicate
diff --git a/mm/memremap.c b/mm/memremap.c
index 03ccbdf..8a97fd4 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -303,6 +303,8 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
 				PHYS_PFN(res->start),
 				PHYS_PFN(resource_size(res)), pgmap);
+	subsections_mark_device(PHYS_PFN(res->start),
+				PHYS_PFN(resource_size(res)));
 	percpu_ref_get_many(pgmap->ref, pfn_end(pgmap) - pfn_first(pgmap));
 	return __va(res->start);
 
diff --git a/mm/sparse.c b/mm/sparse.c
index f6891c1..a3fc9e0a 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -603,6 +603,31 @@ void __init sparse_init(void)
 	vmemmap_populate_print_last();
 }
 
+#ifdef CONFIG_ZONE_DEVICE
+void subsections_mark_device(unsigned long start_pfn, unsigned long size)
+{
+	struct mem_section *ms;
+	unsigned long *dev_map;
+	unsigned long sec, start_sec, end_sec, pfns;
+
+	start_sec = pfn_to_section_nr(start_pfn);
+	end_sec = pfn_to_section_nr(start_pfn + size - 1);
+	for (sec = start_sec; sec <= end_sec;
+	     sec++, start_pfn += pfns, size -= pfns) {
+		pfns = min(size, PAGES_PER_SECTION
+			- (start_pfn & ~PAGE_SECTION_MASK));
+		if (WARN_ON(!valid_section_nr(sec)))
+			continue;
+		ms = __pfn_to_section(start_pfn);
+		if (!ms->usage)
+			continue;
+
+		dev_map = &ms->usage->subsection_dev_map[0];
+		subsection_mask_set(dev_map, start_pfn, pfns);
+	}
+}
+#endif
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 
 /* Mark all memory sections within the pfn range as online */
@@ -782,7 +807,14 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
 		ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
 	}
+#ifdef CONFIG_ZONE_DEVICE
+	/* deactivation of a partial section on ZONE_DEVICE */
+	if (ms->usage) {
+		unsigned long *dev_map = &ms->usage->subsection_dev_map[0];
 
+		bitmap_andnot(dev_map, dev_map, map, SUBSECTIONS_PER_SECTION);
+	}
+#endif
 	if (section_is_early && memmap)
 		free_map_bootmem(memmap);
 	else
-- 
1.8.3.1

