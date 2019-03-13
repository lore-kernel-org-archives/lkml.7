Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5203DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183792177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="e7XyM4kB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCMBme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 21:42:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38650 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCMBmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 21:42:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id z3so167903qkf.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 18:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NQfucrhbD0VzPNhfRkKgVrADDarqnaY6kdS2R65H4Ys=;
        b=e7XyM4kBeSQFwVYWCx0/Yxi0Qx9ADcd3TwYCdYNRuNf4al9WnSxZAeYjZmNPaWxyIs
         VklR/LEo84lmUJia9s7w5DrGdLEj87JIckavIKkKWVWYSt9UNH808J3ffoqwtRkv7Oz+
         RZFUe1YXjz+HvfvVk7+ztrqd1/2HkC03kOUJw9t5KpLZyCqBysEdOV/8Hs6k+e53j0ah
         ajHGF4iWjvHYXnnv3jAqn+LTemgh8BV34HyFwH23ao/qh8oHehgXhJro34Gc/uY8kWhZ
         Qfog2rea4i0y8vTER1HoCgAB7WhHgnO43D8lhVoOi+0DgNU0Chk4IVgKZk947gvy3rRz
         tR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NQfucrhbD0VzPNhfRkKgVrADDarqnaY6kdS2R65H4Ys=;
        b=ame3cm63n9srbNzT/eMe9mSzT60A/FaRs7/Zznyny6u3WEVm8GeADePoCd0DX1Kxlt
         w5y1TSDg7GRuoAqvx8IhC7OLx/fc38dixfZrUYK+9pRAccBByYFxGui9AI1HLyYfdqh+
         RpKEsXmfT00EyZQb2C5dLwfoQvoPJ3CpzZUNgBELZlUj80cDyG0iHDDFhQKybSDuAXNA
         3BEHNwOGF06uOIZnvZdHue8Wy6pw/IxV+NVycvESok5eq81pBxfDV4pnOv+qAT8GacRy
         uZDOhRZ0JN9XEw67mpwKxbafsE5KKaIEenZ7a4do0cwf5s34+adjBxt49/m3R6D+BxC2
         EUzg==
X-Gm-Message-State: APjAAAXC2nEXXSsUhrM4Tg4HkOIYbMSqgVsiGSnuKWvXkvoL21rePRp8
        R+BJg50EIQfnbSOWllfVHOpC1A==
X-Google-Smtp-Source: APXvYqxYSU6Hctdcn1af2We1tjwMEFTeS7kbgBVB6LLHwgPjs07KCSeVn3dtDT4JtYQzYlmbGQD9zQ==
X-Received: by 2002:a37:c9d9:: with SMTP id m86mr11303831qkl.174.1552441352093;
        Tue, 12 Mar 2019 18:42:32 -0700 (PDT)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s187sm4894678qkh.76.2019.03.12.18.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 18:42:31 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     osalvador@suse.de, mhocko@kernel.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/hotplug: fix offline undo_isolate_page_range()
Date:   Tue, 12 Mar 2019 21:42:16 -0400
Message-Id: <20190313014216.36782-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
memory to zones until online") introduced move_pfn_range_to_zone() which
calls memmap_init_zone() during onlining a memory block.
memmap_init_zone() will reset pagetype flags and makes migrate type to
be MOVABLE.

However, in __offline_pages(), it also call undo_isolate_page_range()
after offline_isolated_pages() to do the same thing. Due to
the commit 2ce13640b3f4 ("mm: __first_valid_page skip over offline
pages") changed __first_valid_page() to skip offline pages,
undo_isolate_page_range() here just waste CPU cycles looping around the
offlining PFN range while doing nothing, because __first_valid_page()
will return NULL as offline_isolated_pages() has already marked all
memory sections within the pfn range as offline via
offline_mem_sections().

Also, after calling the "useless" undo_isolate_page_range() here, it
reaches the point of no returning by notifying MEM_OFFLINE. Those pages
will be marked as MIGRATE_MOVABLE again once onlining. The only thing
left to do is to decrease the number of isolated pageblocks zone
counter which would make some paths of the page allocation slower that
the above commit introduced. Fix an incorrect comment along the way.

Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/memory_hotplug.c | 18 ++++++++++++++++--
 mm/sparse.c         |  2 +-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index cd23c081924d..260a8e943483 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1661,8 +1661,22 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	/* Ok, all of our target is isolated.
 	   We cannot do rollback at this point. */
 	offline_isolated_pages(start_pfn, end_pfn);
-	/* reset pagetype flags and makes migrate type to be MOVABLE */
-	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
+
+	/*
+	 * Onlining will reset pagetype flags and makes migrate type
+	 * MOVABLE, so just need to decrease the number of isolated
+	 * pageblocks zone counter here.
+	 */
+	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
+		int i;
+
+		for (i = 0; i < pageblock_nr_pages; i++)
+			if (pfn_valid_within(pfn + i)) {
+				zone->nr_isolate_pageblock--;
+				break;
+			}
+	}
+
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
 	zone->present_pages -= offlined_pages;
diff --git a/mm/sparse.c b/mm/sparse.c
index 69904aa6165b..56e057c432f9 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -567,7 +567,7 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-/* Mark all memory sections within the pfn range as online */
+/* Mark all memory sections within the pfn range as offline */
 void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
-- 
2.17.2 (Apple Git-113)

