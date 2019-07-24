Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D568BC41517
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1850217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfGXOXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfGXOX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:23:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D300307D851;
        Wed, 24 Jul 2019 14:23:29 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-47.ams2.redhat.com [10.36.117.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06CCB600C4;
        Wed, 24 Jul 2019 14:23:24 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1] mm/memory_hotplug: Remove move_pfn_range()
Date:   Wed, 24 Jul 2019 16:23:24 +0200
Message-Id: <20190724142324.3686-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 24 Jul 2019 14:23:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's remove this indirection. We need the zone in the caller either
way, so let's just detect it there. Add some documentation for
move_pfn_range_to_zone() instead.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index efa5283be36c..e7c3b219a305 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -715,7 +715,11 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
 
 	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
 }
-
+/*
+ * Associate the pfn range with the given zone, initializing the memmaps
+ * and resizing the pgdat/zone data to span the added pages. After this
+ * call, all affected pages are PG_reserved.
+ */
 void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap)
 {
@@ -804,20 +808,6 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
 	return default_zone_for_pfn(nid, start_pfn, nr_pages);
 }
 
-/*
- * Associates the given pfn range with the given node and the zone appropriate
- * for the given online type.
- */
-static struct zone * __meminit move_pfn_range(int online_type, int nid,
-		unsigned long start_pfn, unsigned long nr_pages)
-{
-	struct zone *zone;
-
-	zone = zone_for_pfn_range(online_type, nid, start_pfn, nr_pages);
-	move_pfn_range_to_zone(zone, start_pfn, nr_pages, NULL);
-	return zone;
-}
-
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_type)
 {
 	unsigned long flags;
@@ -840,7 +830,8 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 	put_device(&mem->dev);
 
 	/* associate pfn range with the zone */
-	zone = move_pfn_range(online_type, nid, pfn, nr_pages);
+	zone = zone_for_pfn_range(online_type, nid, pfn, nr_pages);
+	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL);
 
 	arg.start_pfn = pfn;
 	arg.nr_pages = nr_pages;
-- 
2.21.0

