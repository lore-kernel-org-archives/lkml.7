Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DE1C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015E0214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfLECPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:15:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:44502 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfLECPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:15:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 18:15:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="263147669"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2019 18:15:46 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     richard.weiyang@gmail.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or, tglx@linutronix.de,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 3/6] x86/mm: Make page_size_mask unsigned int clearly
Date:   Thu,  5 Dec 2019 10:14:00 +0800
Message-Id: <20191205021403.25606-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205021403.25606-1-richardw.yang@linux.intel.com>
References: <20191205021403.25606-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_size_mask is defined as unsigned, so it would be more proper to use
1U to assign and compare this value.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/init.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 4fa5fd641865..0eb5edb63fa2 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -165,12 +165,12 @@ int after_bootmem __ro_after_init;
 early_param_on_off("gbpages", "nogbpages", direct_gbpages, CONFIG_X86_DIRECT_GBPAGES);
 
 struct map_range {
-	unsigned long start;
-	unsigned long end;
-	unsigned page_size_mask;
+	unsigned long	start;
+	unsigned long	end;
+	unsigned int	page_size_mask;
 };
 
-static int page_size_mask;
+static unsigned int page_size_mask __ro_after_init;
 
 static void __init probe_page_size_mask(void)
 {
@@ -180,7 +180,7 @@ static void __init probe_page_size_mask(void)
 	 * large pages into small in interrupt context, etc.
 	 */
 	if (boot_cpu_has(X86_FEATURE_PSE) && !debug_pagealloc_enabled())
-		page_size_mask |= 1 << PG_LEVEL_2M;
+		page_size_mask |= 1U << PG_LEVEL_2M;
 	else
 		direct_gbpages = 0;
 
@@ -204,7 +204,7 @@ static void __init probe_page_size_mask(void)
 	/* Enable 1 GB linear kernel mappings if available: */
 	if (direct_gbpages && boot_cpu_has(X86_FEATURE_GBPAGES)) {
 		printk(KERN_INFO "Using GB pages for direct mapping\n");
-		page_size_mask |= 1 << PG_LEVEL_1G;
+		page_size_mask |= 1U << PG_LEVEL_1G;
 	} else {
 		direct_gbpages = 0;
 	}
@@ -284,8 +284,8 @@ static void __ref adjust_range_page_size_mask(struct map_range *mr,
 	int i;
 
 	for (i = 0; i < nr_range; i++) {
-		if ((page_size_mask & (1<<PG_LEVEL_2M)) &&
-		    !(mr[i].page_size_mask & (1<<PG_LEVEL_2M))) {
+		if ((page_size_mask & (1U<<PG_LEVEL_2M)) &&
+		    !(mr[i].page_size_mask & (1U<<PG_LEVEL_2M))) {
 			unsigned long start = round_down(mr[i].start, PMD_SIZE);
 			unsigned long end = round_up(mr[i].end, PMD_SIZE);
 
@@ -295,15 +295,15 @@ static void __ref adjust_range_page_size_mask(struct map_range *mr,
 #endif
 
 			if (memblock_is_region_memory(start, end - start))
-				mr[i].page_size_mask |= 1<<PG_LEVEL_2M;
+				mr[i].page_size_mask |= 1U<<PG_LEVEL_2M;
 		}
-		if ((page_size_mask & (1<<PG_LEVEL_1G)) &&
-		    !(mr[i].page_size_mask & (1<<PG_LEVEL_1G))) {
+		if ((page_size_mask & (1U<<PG_LEVEL_1G)) &&
+		    !(mr[i].page_size_mask & (1U<<PG_LEVEL_1G))) {
 			unsigned long start = round_down(mr[i].start, PUD_SIZE);
 			unsigned long end = round_up(mr[i].end, PUD_SIZE);
 
 			if (memblock_is_region_memory(start, end - start))
-				mr[i].page_size_mask |= 1<<PG_LEVEL_1G;
+				mr[i].page_size_mask |= 1U<<PG_LEVEL_1G;
 		}
 	}
 }
@@ -315,7 +315,7 @@ static const char *page_size_string(struct map_range *mr)
 	static const char str_4m[] = "4M";
 	static const char str_4k[] = "4k";
 
-	if (mr->page_size_mask & (1<<PG_LEVEL_1G))
+	if (mr->page_size_mask & (1U<<PG_LEVEL_1G))
 		return str_1g;
 	/*
 	 * 32-bit without PAE has a 4M large page size.
@@ -324,10 +324,10 @@ static const char *page_size_string(struct map_range *mr)
 	 */
 	if (IS_ENABLED(CONFIG_X86_32) &&
 	    !IS_ENABLED(CONFIG_X86_PAE) &&
-	    mr->page_size_mask & (1<<PG_LEVEL_2M))
+	    mr->page_size_mask & (1U<<PG_LEVEL_2M))
 		return str_4m;
 
-	if (mr->page_size_mask & (1<<PG_LEVEL_2M))
+	if (mr->page_size_mask & (1U<<PG_LEVEL_2M))
 		return str_2m;
 
 	return str_4k;
@@ -378,7 +378,7 @@ static int __meminit split_mem_range(struct map_range *mr,
 
 	if (start_pfn < end_pfn) {
 		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
-				page_size_mask & (1<<PG_LEVEL_2M));
+				page_size_mask & (1U<<PG_LEVEL_2M));
 		pfn = end_pfn;
 	}
 
@@ -389,7 +389,7 @@ static int __meminit split_mem_range(struct map_range *mr,
 	if (start_pfn < end_pfn) {
 		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
 				page_size_mask &
-				 ((1<<PG_LEVEL_2M)|(1<<PG_LEVEL_1G)));
+				 ((1U<<PG_LEVEL_2M)|(1U<<PG_LEVEL_1G)));
 		pfn = end_pfn;
 	}
 
@@ -398,7 +398,7 @@ static int __meminit split_mem_range(struct map_range *mr,
 	end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
 	if (start_pfn < end_pfn) {
 		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
-				page_size_mask & (1<<PG_LEVEL_2M));
+				page_size_mask & (1U<<PG_LEVEL_2M));
 		pfn = end_pfn;
 	}
 #endif
-- 
2.17.1

