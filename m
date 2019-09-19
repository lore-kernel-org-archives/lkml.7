Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E0CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B246B20882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390420AbfISOXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:23:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389303AbfISOXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:23:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4B40C057F20;
        Thu, 19 Sep 2019 14:23:15 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0C6A60872;
        Thu, 19 Sep 2019 14:23:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH RFC v3 4/9] mm: Export alloc_contig_range() / free_contig_range()
Date:   Thu, 19 Sep 2019 16:22:23 +0200
Message-Id: <20190919142228.5483-5-david@redhat.com>
In-Reply-To: <20190919142228.5483-1-david@redhat.com>
References: <20190919142228.5483-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 19 Sep 2019 14:23:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A virtio-mem device wants to allocate memory from the memory region it
manages in order to unplug it in the hypervisor - similar to
a balloon driver. Also, it might want to plug previously unplugged
(allocated) memory and give it back to Linux. alloc_contig_range() /
free_contig_range() seem to be the perfect interface for this task.

In contrast to existing balloon devices, a virtio-mem device operates
on bigger chunks (e.g., 4MB) and only on physical memory it manages. It
tracks which chunks (subblocks) are still plugged, so it can go ahead
and try to alloc_contig_range()+unplug them on unplug request, or
plug+free_contig_range() unplugged chunks on plug requests.

A virtio-mem device will use alloc_contig_range() / free_contig_range()
only on ranges that belong to the same node/zone in at least
MAX(MAX_ORDER - 1, pageblock_order) order granularity - e.g., 4MB on
x86-64. The virtio-mem device added that memory, so the memory
exists and does not contain any holes. virtio-mem will only try to allocate
on ZONE_NORMAL, never on ZONE_MOVABLE, just like when allocating
gigantic pages (we don't put unmovable data into the movable zone).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3334a769eb91..d5d7944954b3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8469,6 +8469,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 				pfn_max_align_up(end), migratetype);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(alloc_contig_range);
 #endif /* CONFIG_CONTIG_ALLOC */
 
 void free_contig_range(unsigned long pfn, unsigned int nr_pages)
@@ -8483,6 +8484,7 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
 	}
 	WARN(count != 0, "%d pages are still in use!\n", count);
 }
+EXPORT_SYMBOL_GPL(free_contig_range);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
-- 
2.21.0

