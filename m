Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EC7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5F120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfDIKCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:02:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfDIKCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:02:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98722307D860;
        Tue,  9 Apr 2019 10:02:03 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-49.ams2.redhat.com [10.36.117.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5767F5D721;
        Tue,  9 Apr 2019 10:02:00 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH v1 1/4] mm/memory_hotplug: Release memory resource after arch_remove_memory()
Date:   Tue,  9 Apr 2019 12:01:45 +0200
Message-Id: <20190409100148.24703-2-david@redhat.com>
In-Reply-To: <20190409100148.24703-1-david@redhat.com>
References: <20190409100148.24703-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 09 Apr 2019 10:02:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__add_pages() doesn't add the memory resource, so __remove_pages()
shouldn't remove it. Let's factor it out. Especially as it is a special
case for memory used as system memory, added via add_memory() and
friends.

We now remove the resource after removing the sections instead of doing
it the other way around. I don't think this change is problematic.

add_memory()
	register memory resource
	arch_add_memory()

remove_memory
	arch_remove_memory()
	release memory resource

While at it, explain why we ignore errors and that it only happeny if
we remove memory in a different granularity as we added it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Mathieu Malaterre <malat@debian.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4970ff658055..696ed7ee5e28 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -562,20 +562,6 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
 	if (is_dev_zone(zone)) {
 		if (altmap)
 			map_offset = vmem_altmap_offset(altmap);
-	} else {
-		resource_size_t start, size;
-
-		start = phys_start_pfn << PAGE_SHIFT;
-		size = nr_pages * PAGE_SIZE;
-
-		ret = release_mem_region_adjustable(&iomem_resource, start,
-					size);
-		if (ret) {
-			resource_size_t endres = start + size - 1;
-
-			pr_warn("Unable to release resource <%pa-%pa> (%d)\n",
-					&start, &endres, ret);
-		}
 	}
 
 	clear_zone_contiguous(zone);
@@ -1820,6 +1806,25 @@ void try_offline_node(int nid)
 }
 EXPORT_SYMBOL(try_offline_node);
 
+static void __release_memory_resource(u64 start, u64 size)
+{
+	int ret;
+
+	/*
+	 * When removing memory in the same granularity as it was added,
+	 * this function never fails. It might only fail if resources
+	 * have to be adjusted or split. We'll ignore the error, as
+	 * removing of memory cannot fail.
+	 */
+	ret = release_mem_region_adjustable(&iomem_resource, start, size);
+	if (ret) {
+		resource_size_t endres = start + size - 1;
+
+		pr_warn("Unable to release resource <%pa-%pa> (%d)\n",
+			&start, &endres, ret);
+	}
+}
+
 /**
  * remove_memory
  * @nid: the node ID
@@ -1854,6 +1859,7 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 	memblock_remove(start, size);
 
 	arch_remove_memory(nid, start, size, NULL);
+	__release_memory_resource(start, size);
 
 	try_offline_node(nid);
 
-- 
2.17.2

