Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AB0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488542084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfHNPlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:41:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfHNPlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:41:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 540D2C069B52;
        Wed, 14 Aug 2019 15:41:20 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A720080693;
        Wed, 14 Aug 2019 15:41:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 2/5] mm/memory_hotplug: Drop PageReserved() check in online_pages_range()
Date:   Wed, 14 Aug 2019 17:41:06 +0200
Message-Id: <20190814154109.3448-3-david@redhat.com>
In-Reply-To: <20190814154109.3448-1-david@redhat.com>
References: <20190814154109.3448-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 14 Aug 2019 15:41:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move_pfn_range_to_zone() will set all pages to PG_reserved via
memmap_init_zone(). The only way a page could no longer be reserved
would be if a MEM_GOING_ONLINE notifier would clear PG_reserved - which
is not done (the online_page callback is used for that purpose by
e.g., Hyper-V instead). walk_system_ram_range() will never call
online_pages_range() with duplicate PFNs, so drop the PageReserved() check.

This seems to be a leftover from ancient times where the memmap was
initialized when adding memory and we wanted to check for already
onlined memory.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3706a137d880..10ad970f3f14 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -653,9 +653,7 @@ static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
 {
 	unsigned long onlined_pages = *(unsigned long *)arg;
 
-	if (PageReserved(pfn_to_page(start_pfn)))
-		onlined_pages += online_pages_blocks(start_pfn, nr_pages);
-
+	onlined_pages += online_pages_blocks(start_pfn, nr_pages);
 	online_mem_sections(start_pfn, start_pfn + nr_pages);
 
 	*(unsigned long *)arg = onlined_pages;
-- 
2.21.0

