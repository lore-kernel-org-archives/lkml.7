Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B97C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36DC2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFEWMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:12:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:54517 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfFEWMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:12:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 15:12:49 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2019 15:12:49 -0700
Subject: [PATCH v9 06/12] mm: Kill is_dev_zone() helper
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        osalvador@suse.de, mhocko@suse.com
Date:   Wed, 05 Jun 2019 14:58:32 -0700
Message-ID: <155977191260.2443951.15908146523735681570.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given there are no more usages of is_dev_zone() outside of 'ifdef
CONFIG_ZONE_DEVICE' protection, kill off the compilation helper.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mmzone.h |   12 ------------
 mm/page_alloc.c        |    2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6dd52d544857..49e7fb452dfd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -855,18 +855,6 @@ static inline int local_memory_node(int node_id) { return node_id; };
  */
 #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
 
-#ifdef CONFIG_ZONE_DEVICE
-static inline bool is_dev_zone(const struct zone *zone)
-{
-	return zone_idx(zone) == ZONE_DEVICE;
-}
-#else
-static inline bool is_dev_zone(const struct zone *zone)
-{
-	return false;
-}
-#endif
-
 /*
  * Returns true if a zone has pages managed by the buddy allocator.
  * All the reclaim decisions have to use this function rather than
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bd773efe5b82..5dff3f49a372 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5865,7 +5865,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
 
-	if (WARN_ON_ONCE(!pgmap || !is_dev_zone(zone)))
+	if (WARN_ON_ONCE(!pgmap || zone_idx(zone) != ZONE_DEVICE))
 		return;
 
 	/*

