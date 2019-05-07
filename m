Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416F3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FF8206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfEGSi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:38:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfEGSi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:38:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF6BDC05FBCB;
        Tue,  7 May 2019 18:38:57 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-95.ams2.redhat.com [10.36.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0C683DA5;
        Tue,  7 May 2019 18:38:55 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 8/8] mm/memory_hotplug: Remove "zone" parameter from sparse_remove_one_section
Date:   Tue,  7 May 2019 20:38:04 +0200
Message-Id: <20190507183804.5512-9-david@redhat.com>
In-Reply-To: <20190507183804.5512-1-david@redhat.com>
References: <20190507183804.5512-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 07 May 2019 18:38:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused, and memory unplug path should never care about zones. This is
the job of memory offlining. ZONE_DEVICE might require special care -
the caller of arch_remove_memory() should handle this.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h | 2 +-
 mm/memory_hotplug.c            | 2 +-
 mm/sparse.c                    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 2f1f87e13baa..1a4257c5f74c 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -346,7 +346,7 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 extern bool is_memblock_offlined(struct memory_block *mem);
 extern int sparse_add_one_section(int nid, unsigned long start_pfn,
 				  struct vmem_altmap *altmap);
-extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
+extern void sparse_remove_one_section(struct mem_section *ms,
 		unsigned long map_offset, struct vmem_altmap *altmap);
 extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 527fe4f9c620..e0340c8f6df4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -523,7 +523,7 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
 	start_pfn = section_nr_to_pfn((unsigned long)scn_nr);
 	__remove_zone(zone, start_pfn);
 
-	sparse_remove_one_section(zone, ms, map_offset, altmap);
+	sparse_remove_one_section(ms, map_offset, altmap);
 }
 
 /**
diff --git a/mm/sparse.c b/mm/sparse.c
index d1d5e05f5b8d..1552c855d62a 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -800,8 +800,8 @@ static void free_section_usemap(struct page *memmap, unsigned long *usemap,
 		free_map_bootmem(memmap);
 }
 
-void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
-		unsigned long map_offset, struct vmem_altmap *altmap)
+void sparse_remove_one_section(struct mem_section *ms, unsigned long map_offset,
+			       struct vmem_altmap *altmap)
 {
 	struct page *memmap = NULL;
 	unsigned long *usemap = NULL;
-- 
2.20.1

