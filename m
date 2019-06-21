Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E279CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEDA2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfFUAVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 20:21:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:1876 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFUAVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:21:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 17:21:04 -0700
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="168671081"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 17:21:03 -0700
Subject: [PATCH] mm/sparsemem: Cleanup 'section number' data types
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Jun 2019 17:06:46 -0700
Message-ID: <156107543656.1329419.11505835211949439815.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David points out that there is a mixture of 'int' and 'unsigned long'
usage for section number data types. Update the memory hotplug path to
use 'unsigned long' consistently for section numbers.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Andrew,

This patch belatedly fixes up David's review feedback about moving over
to 'unsigned long' for section numbers. Let me know if you want me to
respin the full series, or if you'll just apply / fold this patch on
top.

 mm/memory_hotplug.c |   10 +++++-----
 mm/sparse.c         |    8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4e8e65954f31..92bc44a73fc5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -288,8 +288,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 		struct mhp_restrictions *restrictions)
 {
-	unsigned long i;
-	int start_sec, end_sec, err;
+	int err;
+	unsigned long nr, start_sec, end_sec;
 	struct vmem_altmap *altmap = restrictions->altmap;
 
 	if (altmap) {
@@ -310,7 +310,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 
 	start_sec = pfn_to_section_nr(pfn);
 	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
-	for (i = start_sec; i <= end_sec; i++) {
+	for (nr = start_sec; nr <= end_sec; nr++) {
 		unsigned long pfns;
 
 		pfns = min(nr_pages, PAGES_PER_SECTION
@@ -541,7 +541,7 @@ void __remove_pages(struct zone *zone, unsigned long pfn,
 		    unsigned long nr_pages, struct vmem_altmap *altmap)
 {
 	unsigned long map_offset = 0;
-	int i, start_sec, end_sec;
+	unsigned long nr, start_sec, end_sec;
 
 	if (altmap)
 		map_offset = vmem_altmap_offset(altmap);
@@ -553,7 +553,7 @@ void __remove_pages(struct zone *zone, unsigned long pfn,
 
 	start_sec = pfn_to_section_nr(pfn);
 	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
-	for (i = start_sec; i <= end_sec; i++) {
+	for (nr = start_sec; nr <= end_sec; nr++) {
 		unsigned long pfns;
 
 		cond_resched();
diff --git a/mm/sparse.c b/mm/sparse.c
index b77ca21a27a4..6c4eab2b2bb0 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -229,21 +229,21 @@ void subsection_mask_set(unsigned long *map, unsigned long pfn,
 void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
 {
 	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
-	int i, start_sec = pfn_to_section_nr(pfn);
+	unsigned long nr, start_sec = pfn_to_section_nr(pfn);
 
 	if (!nr_pages)
 		return;
 
-	for (i = start_sec; i <= end_sec; i++) {
+	for (nr = start_sec; nr <= end_sec; nr++) {
 		struct mem_section *ms;
 		unsigned long pfns;
 
 		pfns = min(nr_pages, PAGES_PER_SECTION
 				- (pfn & ~PAGE_SECTION_MASK));
-		ms = __nr_to_section(i);
+		ms = __nr_to_section(nr);
 		subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
 
-		pr_debug("%s: sec: %d pfns: %ld set(%d, %d)\n", __func__, i,
+		pr_debug("%s: sec: %d pfns: %ld set(%d, %d)\n", __func__, nr,
 				pfns, subsection_map_index(pfn),
 				subsection_map_index(pfn + pfns - 1));
 

