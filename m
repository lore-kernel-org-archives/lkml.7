Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742D5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A812341C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfH2HA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 03:00:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2HAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:00:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D634C10F23E8;
        Thu, 29 Aug 2019 07:00:53 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-166.ams2.redhat.com [10.36.117.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5F221001B05;
        Thu, 29 Aug 2019 07:00:51 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 06/11] mm/memory_hotplug: Fix crashes in shrink_zone_span()
Date:   Thu, 29 Aug 2019 09:00:14 +0200
Message-Id: <20190829070019.12714-7-david@redhat.com>
In-Reply-To: <20190829070019.12714-1-david@redhat.com>
References: <20190829070019.12714-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 29 Aug 2019 07:00:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can currently crash in shrink_zone_span() in case we access an
uninitialized memmap (via page_to_nid()). Root issue is that we cannot
always identify which memmap was actually initialized.

Let's improve the situation by looking only at online PFNs for
!ZONE_DEVICE memory. This is now very reliable - similar to
set_zone_contiguous(). (Side note: set_zone_contiguous() will never
succeed on ZONE_DEVICE memory right now as we have no online PFNs ...).

For ZONE_DEVICE memory, make sure we don't crash by special-casing
poisoned pages and always checking that the NID has a sane value. We
might still read garbage and get false positives, but it certainly
improves the situation.

Note: Especially subsections make it very hard to detect which parts of
a ZONE_DEVICE memmap were actually initialized - otherwise we could just
have reused SECTION_IS_ONLINE. This needs more thought.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 663853bf97ed..65b3fdf7f838 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -334,6 +334,17 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
 		if (unlikely(!pfn_valid(start_pfn)))
 			continue;
 
+		/*
+		 * TODO: There is no way we can identify whether the memmap
+		 * of ZONE_DEVICE memory was initialized. We might get
+		 * false positives when reading garbage.
+		 */
+		if (zone_idx(zone) == ZONE_DEVICE) {
+			if (PagePoisoned(pfn_to_page(start_pfn)))
+				continue;
+		} else if (!pfn_to_online_page(start_pfn))
+			continue;
+
 		if (unlikely(pfn_to_nid(start_pfn) != nid))
 			continue;
 
@@ -359,6 +370,17 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
 		if (unlikely(!pfn_valid(pfn)))
 			continue;
 
+		/*
+		 * TODO: There is no way we can identify whether the memmap
+		 * of ZONE_DEVICE memory was initialized. We might get
+		 * false positives when reading garbage.
+		 */
+		if (zone_idx(zone) == ZONE_DEVICE) {
+			if (PagePoisoned(pfn_to_page(pfn)))
+				continue;
+		} else if (!pfn_to_online_page(pfn))
+			continue;
+
 		if (unlikely(pfn_to_nid(pfn) != nid))
 			continue;
 
-- 
2.21.0

