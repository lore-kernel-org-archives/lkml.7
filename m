Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5357FECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D0921906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389308AbfJAOln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:41:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389116AbfJAOll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:41:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D28D757C7;
        Tue,  1 Oct 2019 14:41:41 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04D405D9C9;
        Tue,  1 Oct 2019 14:41:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v5 10/10] mm/memory_hotplug: Cleanup __remove_pages()
Date:   Tue,  1 Oct 2019 16:40:11 +0200
Message-Id: <20191001144011.3801-11-david@redhat.com>
In-Reply-To: <20191001144011.3801-1-david@redhat.com>
References: <20191001144011.3801-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 01 Oct 2019 14:41:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's drop the basically unused section stuff and simplify.

Also, let's use a shorter variant to calculate the number of pages to
the next section boundary.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index ffb514e3b090..0fa99e5a657e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -488,25 +488,20 @@ static void __remove_section(unsigned long pfn, unsigned long nr_pages,
 void __remove_pages(unsigned long pfn, unsigned long nr_pages,
 		    struct vmem_altmap *altmap)
 {
+	const unsigned long end_pfn = pfn + nr_pages;
+	unsigned long cur_nr_pages;
 	unsigned long map_offset = 0;
-	unsigned long nr, start_sec, end_sec;
 
 	map_offset = vmem_altmap_offset(altmap);
 
 	if (check_pfn_span(pfn, nr_pages, "remove"))
 		return;
 
-	start_sec = pfn_to_section_nr(pfn);
-	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
-	for (nr = start_sec; nr <= end_sec; nr++) {
-		unsigned long pfns;
-
+	for (; pfn < end_pfn; pfn += cur_nr_pages) {
 		cond_resched();
-		pfns = min(nr_pages, PAGES_PER_SECTION
-				- (pfn & ~PAGE_SECTION_MASK));
-		__remove_section(pfn, pfns, map_offset, altmap);
-		pfn += pfns;
-		nr_pages -= pfns;
+		/* Select all remaining pages up to the next section boundary */
+		cur_nr_pages = min(end_pfn - pfn, -(pfn | PAGE_SECTION_MASK));
+		__remove_section(pfn, cur_nr_pages, map_offset, altmap);
 		map_offset = 0;
 	}
 }
-- 
2.21.0

