Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9540C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7286E21823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfLECP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:15:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:44514 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbfLECP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:15:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 18:15:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="263147698"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2019 18:15:53 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     richard.weiyang@gmail.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or, tglx@linutronix.de,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 6/6] x86/mm: Refactor split_mem_range with proper helper and loop
Date:   Thu,  5 Dec 2019 10:14:03 +0800
Message-Id: <20191205021403.25606-7-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205021403.25606-1-richardw.yang@linux.intel.com>
References: <20191205021403.25606-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

split_mem_range() splits memory range into 4K, 2M or 1G regions to fit
into page table. Current approach is simply a certain of iteration on
the address boundary. When the address meets a boundary, it is saved
into the map_range structure.

This approach has many copied code for boundary check, while we could
improve this by using loop with helper function.

Thomas draft the patch and Wei apply this and test it. To verify the
functionality, Wei abstract the code into userland and did following
test cases:

    * ranges fits only 4K
    * ranges fits only 2M
    * ranges fits only 1G
    * ranges fits 4K and 2M
    * ranges fits 2M and 1G
    * ranges fits 4K, 2M and 1G
    * ranges fits 4K, 2M and 1G but w/o 1G size
    * ranges fits 4K, 2M and 1G with only 4K size

Below is the test result:

    ### Split [4K, 16K][0x00001000-0x00004000]:
    [mem 0x00001000-0x00003fff] page size 4K
    ### Split [4M, 64M][0x00400000-0x04000000]:
    [mem 0x00400000-0x03ffffff] page size 2M
    ### Split [0G, 2G][0000000000-0x80000000]:
    [mem 0000000000-0x7fffffff] page size 1G
    ### Split [16K, 4M + 16K][0x00004000-0x00404000]:
    [mem 0x00004000-0x001fffff] page size 4K
    [mem 0x00200000-0x003fffff] page size 2M
    [mem 0x00400000-0x00403fff] page size 4K
    ### Split [4M, 2G + 2M][0x00400000-0x80200000]:
    [mem 0x00400000-0x3fffffff] page size 2M
    [mem 0x40000000-0x7fffffff] page size 1G
    [mem 0x80000000-0x801fffff] page size 2M
    ### Split [4M - 16K, 2G + 2M + 16K][0x003fc000-0x80204000]:
    [mem 0x003fc000-0x003fffff] page size 4K
    [mem 0x00400000-0x3fffffff] page size 2M
    [mem 0x40000000-0x7fffffff] page size 1G
    [mem 0x80000000-0x801fffff] page size 2M
    [mem 0x80200000-0x80203fff] page size 4K
    ### Split w/o 1G size [4M - 16K, 2G + 2M + 16K][0x003fc000-0x80204000]:
    [mem 0x003fc000-0x003fffff] page size 4K
    [mem 0x00400000-0x801fffff] page size 2M
    [mem 0x80200000-0x80203fff] page size 4K
    ### Split w/ only 4K [4M - 16K, 2G + 2M + 16K][0x003fc000-0x80204000]:
    [mem 0x003fc000-0x80203fff] page size 4K

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Tested-by: Wei Yang <richardw.yang@linux.intel.com>

---
Thomas's SOB is added by me since he is the original author. If this is
not proper please let me know.
---
 arch/x86/mm/init.c | 225 +++++++++++++++++++--------------------------
 1 file changed, 93 insertions(+), 132 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 5fe3f645f02c..14d6d90268f7 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -164,6 +164,17 @@ int after_bootmem __ro_after_init;
 
 early_param_on_off("gbpages", "nogbpages", direct_gbpages, CONFIG_X86_DIRECT_GBPAGES);
 
+#ifdef CONFIG_X86_32
+#define NR_RANGE_MR 3
+#else
+#define NR_RANGE_MR 5
+#endif
+
+struct mapinfo {
+	unsigned int	mask;
+	unsigned int	size;
+};
+
 struct map_range {
 	unsigned long	start;
 	unsigned long	end;
@@ -252,62 +263,6 @@ static void setup_pcid(void)
 	}
 }
 
-#ifdef CONFIG_X86_32
-#define NR_RANGE_MR 3
-#else /* CONFIG_X86_64 */
-#define NR_RANGE_MR 5
-#endif
-
-static int __meminit save_mr(struct map_range *mr, int nr_range,
-			     unsigned long start, unsigned long end,
-			     unsigned long page_size_mask)
-{
-	if (start_pfn < end_pfn) {
-		if (nr_range >= NR_RANGE_MR)
-			panic("run out of range for init_memory_mapping\n");
-		mr[nr_range].start = start_pfn;
-		mr[nr_range].end   = end_pfn;
-		mr[nr_range].page_size_mask = page_size_mask;
-		nr_range++;
-	}
-
-	return nr_range;
-}
-
-/*
- * adjust the page_size_mask for small range to go with
- *	big page size instead small one if nearby are ram too.
- */
-static void __ref adjust_range_page_size_mask(struct map_range *mr,
-							 int nr_range)
-{
-	int i;
-
-	for (i = 0; i < nr_range; i++) {
-		if ((page_size_mask & (1U<<PG_LEVEL_2M)) &&
-		    !(mr[i].page_size_mask & (1U<<PG_LEVEL_2M))) {
-			unsigned long start = round_down(mr[i].start, PMD_SIZE);
-			unsigned long end = round_up(mr[i].end, PMD_SIZE);
-
-#ifdef CONFIG_X86_32
-			if ((end >> PAGE_SHIFT) > max_low_pfn)
-				continue;
-#endif
-
-			if (memblock_is_region_memory(start, end - start))
-				mr[i].page_size_mask |= 1U<<PG_LEVEL_2M;
-		}
-		if ((page_size_mask & (1U<<PG_LEVEL_1G)) &&
-		    !(mr[i].page_size_mask & (1U<<PG_LEVEL_1G))) {
-			unsigned long start = round_down(mr[i].start, PUD_SIZE);
-			unsigned long end = round_up(mr[i].end, PUD_SIZE);
-
-			if (memblock_is_region_memory(start, end - start))
-				mr[i].page_size_mask |= 1U<<PG_LEVEL_1G;
-		}
-	}
-}
-
 static void __meminit mr_print(struct map_range *mr, unsigned int maxidx)
 {
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
@@ -324,99 +279,105 @@ static void __meminit mr_print(struct map_range *mr, unsigned int maxidx)
 	}
 }
 
-static int __meminit split_mem_range(struct map_range *mr,
-				     unsigned long start,
-				     unsigned long end)
+/*
+ * Try to preserve large mappings during bootmem by expanding the current
+ * range to large page mapping of @size and verifying that the result is
+ * within a memory region.
+ */
+static void __meminit mr_expand(struct map_range *mr, unsigned int size)
 {
-	unsigned long addr, limit;
-	int i, nr_range = 0;
+	unsigned long start = round_down(mr->start, size);
+	unsigned long end = round_up(mr->end, size);
 
-	limit = end;
+	if (IS_ENABLED(CONFIG_X86_32) && (end >> PAGE_SHIFT) > max_low_pfn)
+		return;
 
-	/* head if not big page alignment ? */
-	addr = start;
-#ifdef CONFIG_X86_32
-	/*
-	 * Don't use a large page for the first 2/4MB of memory
-	 * because there are often fixed size MTRRs in there
-	 * and overlapping MTRRs into large pages can cause
-	 * slowdowns.
-	 */
-	if (addr == 0)
-		end = PMD_SIZE;
-	else
-		end = round_up(addr, PMD_SIZE);
-#else /* CONFIG_X86_64 */
-	end = round_up(addr, PMD_SIZE);
-#endif
-	if (end > limit)
-		end = limit;
-	if (start < end) {
-		nr_range = save_mr(mr, nr_range, start, end, 0);
-		addr = end;
+	if (memblock_is_region_memory(start, end - start)) {
+		mr->start = start;
+		mr->end = end;
 	}
+}
 
-	/* big page (2M) range */
-	start = round_up(addr, PMD_SIZE);
-#ifdef CONFIG_X86_32
-	end = round_down(limit, PMD_SIZE);
-#else /* CONFIG_X86_64 */
-	end = round_up(addr, PUD_SIZE);
-	if (end > round_down(limit, PMD_SIZE))
-		end = round_down(limit, PMD_SIZE);
-#endif
+static bool __meminit mr_try_map(struct map_range *mr, const struct mapinfo *mi)
+{
+	unsigned long len;
+
+	/* Check whether the map size is supported. PAGE_SIZE always is. */
+	if (mi->mask && !(mr->page_size_mask & mi->mask))
+		return false;
+
+	if (!after_bootmem)
+		mr_expand(mr, mi->size);
 
-	if (start < end) {
-		nr_range = save_mr(mr, nr_range, start, end,
-				page_size_mask & (1U<<PG_LEVEL_2M));
-		addr = end;
+	if (!IS_ALIGNED(mr->start, mi->size)) {
+		/* Limit the range to the next boundary of this size. */
+		mr->end = min_t(unsigned long, mr->end,
+				round_up(mr->start, mi->size));
+		return false;
 	}
 
-#ifdef CONFIG_X86_64
-	/* big page (1G) range */
-	start = round_up(addr, PUD_SIZE);
-	end = round_down(limit, PUD_SIZE);
-	if (start < end) {
-		nr_range = save_mr(mr, nr_range, start, end,
-				page_size_mask &
-				 ((1U<<PG_LEVEL_2M)|(1U<<PG_LEVEL_1G)));
-		addr = end;
+	if (!IS_ALIGNED(mr->end, mi->size)) {
+		/* Try to fit as much as possible */
+		len = round_down(mr->end - mr->start, mi->size);
+		if (!len)
+			return false;
+		mr->end = mr->start + len;
 	}
 
-	/* tail is not big page (1G) alignment */
-	start = round_up(addr, PMD_SIZE);
-	end = round_down(limit, PMD_SIZE);
-	if (start < end) {
-		nr_range = save_mr(mr, nr_range, start, end,
-				page_size_mask & (1U<<PG_LEVEL_2M));
-		addr = end;
+	/* Store the effective page size mask */
+	mr->page_size_mask = mi->mask;
+	return true;
+}
+
+static void __meminit mr_setup(struct map_range *mr, unsigned long start,
+			       unsigned long end)
+{
+	/*
+	 * On 32bit the first 2/4MB are often covered by fixed size MTRRs.
+	 * Overlapping MTRRs on large pages can cause slowdowns. Force 4k
+	 * mappings.
+	 */
+	if (IS_ENABLED(CONFIG_X86_32) && start < PMD_SIZE) {
+		mr->page_size_mask = 0;
+		mr->end = min_t(unsigned long, end, PMD_SIZE);
+	} else {
+		/* Set the possible mapping sizes and allow full range. */
+		mr->page_size_mask = page_size_mask;
+		mr->end = end;
 	}
+	mr->start = start;
+}
+
+static int __meminit split_mem_range(struct map_range *mr, unsigned long start,
+				     unsigned long end)
+{
+	static const struct mapinfo mapinfos[] = {
+#ifdef CONFIG_X86_64
+		{ .mask = 1U << PG_LEVEL_1G, .size = PUD_SIZE },
 #endif
+		{ .mask = 1U << PG_LEVEL_2M, .size = PMD_SIZE },
+		{ .mask = 0, .size = PAGE_SIZE },
+	};
+	const struct mapinfo *mi;
+	struct map_range *curmr;
+	unsigned long addr;
+	int idx;
 
-	/* tail is not big page (2M) alignment */
-	start = addr;
-	end = limit;
-	nr_range = save_mr(mr, nr_range, start, end, 0);
+	for (idx = 0, addr = start, curmr = mr; addr < end; idx++, curmr++) {
+		BUG_ON(idx == NR_RANGE_MR);
 
-	if (!after_bootmem)
-		adjust_range_page_size_mask(mr, nr_range);
+		mr_setup(curmr, addr, end);
 
-	/* try to merge same page size and continuous */
-	for (i = 0; nr_range > 1 && i < nr_range - 1; i++) {
-		unsigned long old_start;
-		if (mr[i].end != mr[i+1].start ||
-		    mr[i].page_size_mask != mr[i+1].page_size_mask)
-			continue;
-		/* move it */
-		old_start = mr[i].start;
-		memmove(&mr[i], &mr[i+1],
-			(nr_range - 1 - i) * sizeof(struct map_range));
-		mr[i--].start = old_start;
-		nr_range--;
+		/* Try map sizes top down. PAGE_SIZE will always succeed. */
+		for (mi = mapinfos; !mr_try_map(curmr, mi); mi++)
+			;
+
+		/* Get the start address for the next range */
+		addr = curmr->end;
 	}
 
-	mr_print(mr, nr_range);
-	return nr_range;
+	mr_print(mr, idx);
+	return idx;
 }
 
 struct range pfn_mapped[E820_MAX_ENTRIES];
-- 
2.17.1

