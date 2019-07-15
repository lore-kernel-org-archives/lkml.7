Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7ADC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748CF20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfGOIQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:16:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:54308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729360AbfGOIP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:15:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB217AFDB;
        Mon, 15 Jul 2019 08:15:57 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        aneesh.kumar@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/2] mm,sparse: Fix deactivate_section for early sections
Date:   Mon, 15 Jul 2019 10:15:48 +0200
Message-Id: <20190715081549.32577-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190715081549.32577-1-osalvador@suse.de>
References: <20190715081549.32577-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

deactivate_section checks whether a section is early or not
in order to either call free_map_bootmem() or depopulate_section_memmap().
Being the former for sections added at boot time, and the latter for
sections hotplugged.

The problem is that we zero section_mem_map, so the last early_section()
will always report false and the section will not be removed.

Fix this checking whether a section is early or not at function
entry.

Fixes: mmotm ("mm/sparsemem: Support sub-section hotplug")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/sparse.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 3267c4001c6d..1e224149aab6 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -738,6 +738,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
 	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
 	struct mem_section *ms = __pfn_to_section(pfn);
+	bool section_is_early = early_section(ms);
 	struct page *memmap = NULL;
 	unsigned long *subsection_map = ms->usage
 		? &ms->usage->subsection_map[0] : NULL;
@@ -772,7 +773,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
-		if (!early_section(ms)) {
+		if (!section_is_early) {
 			kfree(ms->usage);
 			ms->usage = NULL;
 		}
@@ -780,7 +781,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
 	}
 
-	if (early_section(ms) && memmap)
+	if (section_is_early && memmap)
 		free_map_bootmem(memmap);
 	else
 		depopulate_section_memmap(pfn, nr_pages, altmap);
-- 
2.12.3

