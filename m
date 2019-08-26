Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F338FC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BB321852
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfHZKKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:10:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfHZKKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:10:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5866981DF1;
        Mon, 26 Aug 2019 10:10:30 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-227.ams2.redhat.com [10.36.116.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72C27608C1;
        Mon, 26 Aug 2019 10:10:28 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v2 1/6] mm/memory_hotplug: Exit early in __remove_pages() on BUGs
Date:   Mon, 26 Aug 2019 12:10:07 +0200
Message-Id: <20190826101012.10575-2-david@redhat.com>
In-Reply-To: <20190826101012.10575-1-david@redhat.com>
References: <20190826101012.10575-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 26 Aug 2019 10:10:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error path should never happen in practice (unless bringing up a new
device driver, or on BUGs). However, it's clearer to not touch anything
in case we are going to return right away. Move the check/return.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 32a5386758ce..71779b7b14df 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -542,13 +542,13 @@ void __remove_pages(struct zone *zone, unsigned long pfn,
 	unsigned long map_offset = 0;
 	unsigned long nr, start_sec, end_sec;
 
+	if (check_pfn_span(pfn, nr_pages, "remove"))
+		return;
+
 	map_offset = vmem_altmap_offset(altmap);
 
 	clear_zone_contiguous(zone);
 
-	if (check_pfn_span(pfn, nr_pages, "remove"))
-		return;
-
 	start_sec = pfn_to_section_nr(pfn);
 	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
 	for (nr = start_sec; nr <= end_sec; nr++) {
-- 
2.21.0

