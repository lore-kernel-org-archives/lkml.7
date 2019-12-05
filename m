Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87404C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625D4214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfLECP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:15:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:44514 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbfLECPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:15:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 18:15:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="263147689"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2019 18:15:51 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     richard.weiyang@gmail.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or, tglx@linutronix.de,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 5/6] x86/mm: Use address directly in split_mem_range()
Date:   Thu,  5 Dec 2019 10:14:02 +0800
Message-Id: <20191205021403.25606-6-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205021403.25606-1-richardw.yang@linux.intel.com>
References: <20191205021403.25606-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not necessary to convert address to pfn to split range. And
finally, convert back to address and store it to map_range.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/init.c | 73 +++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index ded58a31c679..5fe3f645f02c 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -259,14 +259,14 @@ static void setup_pcid(void)
 #endif
 
 static int __meminit save_mr(struct map_range *mr, int nr_range,
-			     unsigned long start_pfn, unsigned long end_pfn,
+			     unsigned long start, unsigned long end,
 			     unsigned long page_size_mask)
 {
 	if (start_pfn < end_pfn) {
 		if (nr_range >= NR_RANGE_MR)
 			panic("run out of range for init_memory_mapping\n");
-		mr[nr_range].start = start_pfn<<PAGE_SHIFT;
-		mr[nr_range].end   = end_pfn<<PAGE_SHIFT;
+		mr[nr_range].start = start_pfn;
+		mr[nr_range].end   = end_pfn;
 		mr[nr_range].page_size_mask = page_size_mask;
 		nr_range++;
 	}
@@ -328,14 +328,13 @@ static int __meminit split_mem_range(struct map_range *mr,
 				     unsigned long start,
 				     unsigned long end)
 {
-	unsigned long start_pfn, end_pfn, limit_pfn;
-	unsigned long pfn;
+	unsigned long addr, limit;
 	int i, nr_range = 0;
 
-	limit_pfn = PFN_DOWN(end);
+	limit = end;
 
 	/* head if not big page alignment ? */
-	pfn = start_pfn = PFN_DOWN(start);
+	addr = start;
 #ifdef CONFIG_X86_32
 	/*
 	 * Don't use a large page for the first 2/4MB of memory
@@ -343,61 +342,61 @@ static int __meminit split_mem_range(struct map_range *mr,
 	 * and overlapping MTRRs into large pages can cause
 	 * slowdowns.
 	 */
-	if (pfn == 0)
-		end_pfn = PFN_DOWN(PMD_SIZE);
+	if (addr == 0)
+		end = PMD_SIZE;
 	else
-		end_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
+		end = round_up(addr, PMD_SIZE);
 #else /* CONFIG_X86_64 */
-	end_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
+	end = round_up(addr, PMD_SIZE);
 #endif
-	if (end_pfn > limit_pfn)
-		end_pfn = limit_pfn;
-	if (start_pfn < end_pfn) {
-		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn, 0);
-		pfn = end_pfn;
+	if (end > limit)
+		end = limit;
+	if (start < end) {
+		nr_range = save_mr(mr, nr_range, start, end, 0);
+		addr = end;
 	}
 
 	/* big page (2M) range */
-	start_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
+	start = round_up(addr, PMD_SIZE);
 #ifdef CONFIG_X86_32
-	end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
+	end = round_down(limit, PMD_SIZE);
 #else /* CONFIG_X86_64 */
-	end_pfn = round_up(pfn, PFN_DOWN(PUD_SIZE));
-	if (end_pfn > round_down(limit_pfn, PFN_DOWN(PMD_SIZE)))
-		end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
+	end = round_up(addr, PUD_SIZE);
+	if (end > round_down(limit, PMD_SIZE))
+		end = round_down(limit, PMD_SIZE);
 #endif
 
-	if (start_pfn < end_pfn) {
-		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
+	if (start < end) {
+		nr_range = save_mr(mr, nr_range, start, end,
 				page_size_mask & (1U<<PG_LEVEL_2M));
-		pfn = end_pfn;
+		addr = end;
 	}
 
 #ifdef CONFIG_X86_64
 	/* big page (1G) range */
-	start_pfn = round_up(pfn, PFN_DOWN(PUD_SIZE));
-	end_pfn = round_down(limit_pfn, PFN_DOWN(PUD_SIZE));
-	if (start_pfn < end_pfn) {
-		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
+	start = round_up(addr, PUD_SIZE);
+	end = round_down(limit, PUD_SIZE);
+	if (start < end) {
+		nr_range = save_mr(mr, nr_range, start, end,
 				page_size_mask &
 				 ((1U<<PG_LEVEL_2M)|(1U<<PG_LEVEL_1G)));
-		pfn = end_pfn;
+		addr = end;
 	}
 
 	/* tail is not big page (1G) alignment */
-	start_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
-	end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
-	if (start_pfn < end_pfn) {
-		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
+	start = round_up(addr, PMD_SIZE);
+	end = round_down(limit, PMD_SIZE);
+	if (start < end) {
+		nr_range = save_mr(mr, nr_range, start, end,
 				page_size_mask & (1U<<PG_LEVEL_2M));
-		pfn = end_pfn;
+		addr = end;
 	}
 #endif
 
 	/* tail is not big page (2M) alignment */
-	start_pfn = pfn;
-	end_pfn = limit_pfn;
-	nr_range = save_mr(mr, nr_range, start_pfn, end_pfn, 0);
+	start = addr;
+	end = limit;
+	nr_range = save_mr(mr, nr_range, start, end, 0);
 
 	if (!after_bootmem)
 		adjust_range_page_size_mask(mr, nr_range);
-- 
2.17.1

