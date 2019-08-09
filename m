Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACD4C32756
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1DB21743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406927AbfHIM5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:57:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406971AbfHIM5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8711BC0BBE4F;
        Fri,  9 Aug 2019 12:57:38 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-120.ams2.redhat.com [10.36.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B569161F48;
        Fri,  9 Aug 2019 12:57:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 2/4] mm/memory_hotplug: Handle unaligned start and nr_pages in online_pages_blocks()
Date:   Fri,  9 Aug 2019 14:56:59 +0200
Message-Id: <20190809125701.3316-3-david@redhat.com>
In-Reply-To: <20190809125701.3316-1-david@redhat.com>
References: <20190809125701.3316-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 09 Aug 2019 12:57:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take care of nr_pages not being a power of two and start not being
properly aligned. Essentially, what walk_system_ram_range() could provide
to us. get_order() will round-up in case it's not a power of two.

This should only apply to memory blocks that contain strange memory
resources (especially with holes), not to ordinary DIMMs.

Fixes: a9cd410a3d29 ("mm/page_alloc.c: memory hotplug: free pages as higher order")
Cc: Arun KS <arunks@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3706a137d880..2abd938c8c45 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -640,6 +640,10 @@ static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
 	while (start < end) {
 		order = min(MAX_ORDER - 1,
 			get_order(PFN_PHYS(end) - PFN_PHYS(start)));
+		/* make sure the PFN is aligned and we don't exceed the range */
+		while (!IS_ALIGNED(start, 1ul << order) ||
+		       (1ul << order) > end - start)
+			order--;
 		(*online_page_callback)(pfn_to_page(start), order);
 
 		onlined_pages += (1UL << order);
-- 
2.21.0

