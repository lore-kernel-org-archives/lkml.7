Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFBEC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1294720857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDIKCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfDIKCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:02:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16EEC3001A68;
        Tue,  9 Apr 2019 10:02:13 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-49.ams2.redhat.com [10.36.117.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37FE75D71F;
        Tue,  9 Apr 2019 10:02:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH v1 3/4] mm/memory_hotplug: Make __remove_section() never fail
Date:   Tue,  9 Apr 2019 12:01:47 +0200
Message-Id: <20190409100148.24703-4-david@redhat.com>
In-Reply-To: <20190409100148.24703-1-david@redhat.com>
References: <20190409100148.24703-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 09 Apr 2019 10:02:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's just warn in case a section is not valid instead of failing to
remove somewhere in the middle of the process, returning an error that
will be mostly ignored by callers.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Mathieu Malaterre <malat@debian.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b0cb05748f99..17a60281c36f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -517,15 +517,15 @@ static void __remove_zone(struct zone *zone, unsigned long start_pfn)
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 }
 
-static int __remove_section(struct zone *zone, struct mem_section *ms,
-		unsigned long map_offset, struct vmem_altmap *altmap)
+static void __remove_section(struct zone *zone, struct mem_section *ms,
+			     unsigned long map_offset,
+			     struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn;
 	int scn_nr;
-	int ret = -EINVAL;
 
-	if (!valid_section(ms))
-		return ret;
+	if (WARN_ON_ONCE(!valid_section(ms)))
+		return;
 
 	unregister_memory_section(ms);
 
@@ -534,7 +534,6 @@ static int __remove_section(struct zone *zone, struct mem_section *ms,
 	__remove_zone(zone, start_pfn);
 
 	sparse_remove_one_section(zone, ms, map_offset, altmap);
-	return 0;
 }
 
 /**
@@ -554,7 +553,7 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
 {
 	unsigned long i;
 	unsigned long map_offset = 0;
-	int sections_to_remove, ret = 0;
+	int sections_to_remove;
 
 	/* In the ZONE_DEVICE case device driver owns the memory region */
 	if (is_dev_zone(zone)) {
@@ -575,16 +574,13 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
 		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
 
 		cond_resched();
-		ret = __remove_section(zone, __pfn_to_section(pfn), map_offset,
-				altmap);
+		__remove_section(zone, __pfn_to_section(pfn), map_offset,
+				 altmap);
 		map_offset = 0;
-		if (ret)
-			break;
 	}
 
 	set_zone_contiguous(zone);
-
-	return ret;
+	return 0;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-- 
2.17.2

