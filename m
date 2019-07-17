Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761C5C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C262077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfGQJHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:07:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:47504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbfGQJHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:07:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBF48AF57;
        Wed, 17 Jul 2019 09:07:29 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        aneesh.kumar@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/2] mm,memory_hotplug: Fix shrink_{zone,node}_span
Date:   Wed, 17 Jul 2019 11:07:25 +0200
Message-Id: <20190717090725.23618-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190717090725.23618-1-osalvador@suse.de>
References: <20190717090725.23618-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since [1], shrink_{zone,node}_span work on PAGES_PER_SUBSECTION granularity.
We need to adapt the loop that checks whether a zone/node contains only holes,
and skip the whole range to be removed.

Otherwise, since sub-sections belonging to the range to be removed have not yet
been deactivated, pfn_valid() will return true on those and we will be left
with a wrong accounting of spanned_pages, both for the zone and the node.

Fixes: mmotm ("mm/hotplug: prepare shrink_{zone, pgdat}_span for sub-section removal")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b9ba5b85f9f7..2a9bbddb0e55 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -422,8 +422,8 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		if (page_zone(pfn_to_page(pfn)) != zone)
 			continue;
 
-		 /* If the section is current section, it continues the loop */
-		if (start_pfn == pfn)
+		/* Skip range to be removed */
+		if (pfn >= start_pfn && pfn < end_pfn)
 			continue;
 
 		/* If we find valid section, we have nothing to do */
@@ -487,8 +487,8 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
 		if (pfn_to_nid(pfn) != nid)
 			continue;
 
-		 /* If the section is current section, it continues the loop */
-		if (start_pfn == pfn)
+		/* Skip range to be removed */
+		if (pfn >= start_pfn && pfn < end_pfn)
 			continue;
 
 		/* If we find valid section, we have nothing to do */
-- 
2.12.3

