Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FBE206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbfDQSxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:53:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:19200 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731358AbfDQSxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:53:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 11:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,362,1549958400"; 
   d="scan'208";a="143759198"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 17 Apr 2019 11:53:01 -0700
Subject: [PATCH v6 04/12] mm/hotplug: Prepare shrink_{zone,
 pgdat}_span for sub-section removal
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, david@redhat.com
Date:   Wed, 17 Apr 2019 11:39:16 -0700
Message-ID: <155552635609.2015392.6246305135559796835.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sub-section hotplug support reduces the unit of operation of hotplug
from section-sized-units (PAGES_PER_SECTION) to sub-section-sized units
(PAGES_PER_SUBSECTION). Teach shrink_{zone,pgdat}_span() to consider
PAGES_PER_SUBSECTION boundaries as the points where pfn_valid(), not
valid_section(), can toggle.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mmzone.h |    2 ++
 mm/memory_hotplug.c    |   16 ++++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index cffde898e345..b13f0cddf75e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1164,6 +1164,8 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
 
 #define SECTION_ACTIVE_SIZE ((1UL << SECTION_SIZE_BITS) / BITS_PER_LONG)
 #define SECTION_ACTIVE_MASK (~(SECTION_ACTIVE_SIZE - 1))
+#define PAGES_PER_SUB_SECTION (SECTION_ACTIVE_SIZE / PAGE_SIZE)
+#define PAGE_SUB_SECTION_MASK (~(PAGES_PER_SUB_SECTION-1))
 
 struct mem_section_usage {
 	/*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8b7415736d21..d5874f9d4043 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -327,10 +327,10 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
 {
 	struct mem_section *ms;
 
-	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SECTION) {
+	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SUB_SECTION) {
 		ms = __pfn_to_section(start_pfn);
 
-		if (unlikely(!valid_section(ms)))
+		if (unlikely(!pfn_valid(start_pfn)))
 			continue;
 
 		if (unlikely(pfn_to_nid(start_pfn) != nid))
@@ -355,10 +355,10 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
 
 	/* pfn is the end pfn of a memory section. */
 	pfn = end_pfn - 1;
-	for (; pfn >= start_pfn; pfn -= PAGES_PER_SECTION) {
+	for (; pfn >= start_pfn; pfn -= PAGES_PER_SUB_SECTION) {
 		ms = __pfn_to_section(pfn);
 
-		if (unlikely(!valid_section(ms)))
+		if (unlikely(!pfn_valid(pfn)))
 			continue;
 
 		if (unlikely(pfn_to_nid(pfn) != nid))
@@ -417,10 +417,10 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 	 * it check the zone has only hole or not.
 	 */
 	pfn = zone_start_pfn;
-	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SECTION) {
+	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUB_SECTION) {
 		ms = __pfn_to_section(pfn);
 
-		if (unlikely(!valid_section(ms)))
+		if (unlikely(!pfn_valid(pfn)))
 			continue;
 
 		if (page_zone(pfn_to_page(pfn)) != zone)
@@ -485,10 +485,10 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
 	 * has only hole or not.
 	 */
 	pfn = pgdat_start_pfn;
-	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SECTION) {
+	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SUB_SECTION) {
 		ms = __pfn_to_section(pfn);
 
-		if (unlikely(!valid_section(ms)))
+		if (unlikely(!pfn_valid(pfn)))
 			continue;
 
 		if (pfn_to_nid(pfn) != nid)

