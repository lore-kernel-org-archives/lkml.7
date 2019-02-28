Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88242C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473DC218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320372;
	bh=v9mDijWaX3F3vHDfgCUvH2Sy51ZIrx5Y3gaLF3kJ50s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jl5lV3r2Bbyu0jZ9koaAAVHwLrJRssf9BB3MhNTWQVyCN9958jWwNDjpVf3W2IUeb
	 ZBx8MkzwqGajJcw5Vwq3Bm3Svy4bnDa88HgCPD2MCq8ob4W6C06ANOxBK+S0mrpLNZ
	 gyZ0Hhq5eAov1gj79dGl9yLVp/8b/ItL+Zmy5eKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfB1CT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:19:26 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37126 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbfB1CSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:18:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so21842111qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OJpWsbdBIyGG6Z7ONuMnLcPyaANJkTqPOgPDMD+CsEE=;
        b=JR+/c1KPUcq8trGibc/No21jPMDIWkqtW3vTvgArlxB3IMchn4rdVBIoHnyTixuAkL
         uGMg5sdxilDvMUNxr223olw4/1Ypa4cfJakIJBLhYHWfxePzoi+AJooYlRMwr3IquUha
         VNPL7nv9sYpHs8DXiudwvISxipfo7Q/r4slpIBVJ7uA144JkGtT6rGwr5t8tiIyCRHlo
         /lhegTAsI3oitJM+SXP1Nt4gme53LxB2bzj84dL5J2QvEL2zszm1OMifvGmMPMsdEdHQ
         scnrz+2yuiOgnlvKdmc+X5dxTxicWVgZj2m+S91fbb1hKS4eBk0WpXX4sq2/3+ZUFXMu
         +iWg==
X-Gm-Message-State: APjAAAVchqMnwcUBzS+IMmM3Smoy+38tUHcWcLnsASK/TkpVukDhfqv4
        jWi/hOTK8fAXPJcOJ6EWfoM=
X-Google-Smtp-Source: APXvYqxEf9YG/zZ2e72+bT/axnwcoZq+Gcmlr3nYUbo4CauEC6c/+4TlIkIgc9rbYfwL02WxjTt1hg==
X-Received: by 2002:a0c:d0b6:: with SMTP id z51mr4431252qvg.20.1551320334375;
        Wed, 27 Feb 2019 18:18:54 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:18:53 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] percpu: add block level scan_hint
Date:   Wed, 27 Feb 2019 21:18:34 -0500
Message-Id: <20190228021839.55779-8-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
References: <20190228021839.55779-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fragmentation can cause both blocks and chunks to have an early
first_firee bit available, but only able to satisfy allocations much
later on. This patch introduces a scan_hint to help mitigate some
unnecessary scanning.

The scan_hint remembers the largest area prior to the contig_hint. If
the contig_hint == scan_hint, then scan_hint_start > contig_hint_start.
This is necessary for scan_hint discovery when refreshing a block.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu-internal.h |   9 ++++
 mm/percpu.c          | 101 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 7 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index b1739dc06b73..ec58b244545d 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -9,8 +9,17 @@
  * pcpu_block_md is the metadata block struct.
  * Each chunk's bitmap is split into a number of full blocks.
  * All units are in terms of bits.
+ *
+ * The scan hint is the largest known contiguous area before the contig hint.
+ * It is not necessarily the actual largest contig hint though.  There is an
+ * invariant that the scan_hint_start > contig_hint_start iff
+ * scan_hint == contig_hint.  This is necessary because when scanning forward,
+ * we don't know if a new contig hint would be better than the current one.
  */
 struct pcpu_block_md {
+	int			scan_hint;	/* scan hint for block */
+	int			scan_hint_start; /* block relative starting
+						    position of the scan hint */
 	int                     contig_hint;    /* contig hint for block */
 	int                     contig_hint_start; /* block relative starting
 						      position of the contig hint */
diff --git a/mm/percpu.c b/mm/percpu.c
index 967c9cc3a928..df1aacf58ac8 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -320,6 +320,34 @@ static unsigned long pcpu_block_off_to_off(int index, int off)
 	return index * PCPU_BITMAP_BLOCK_BITS + off;
 }
 
+/*
+ * pcpu_next_hint - determine which hint to use
+ * @block: block of interest
+ * @alloc_bits: size of allocation
+ *
+ * This determines if we should scan based on the scan_hint or first_free.
+ * In general, we want to scan from first_free to fulfill allocations by
+ * first fit.  However, if we know a scan_hint at position scan_hint_start
+ * cannot fulfill an allocation, we can begin scanning from there knowing
+ * the contig_hint will be our fallback.
+ */
+static int pcpu_next_hint(struct pcpu_block_md *block, int alloc_bits)
+{
+	/*
+	 * The three conditions below determine if we can skip past the
+	 * scan_hint.  First, does the scan hint exist.  Second, is the
+	 * contig_hint after the scan_hint (possibly not true iff
+	 * contig_hint == scan_hint).  Third, is the allocation request
+	 * larger than the scan_hint.
+	 */
+	if (block->scan_hint &&
+	    block->contig_hint_start > block->scan_hint_start &&
+	    alloc_bits > block->scan_hint)
+		return block->scan_hint_start + block->scan_hint;
+
+	return block->first_free;
+}
+
 /**
  * pcpu_next_md_free_region - finds the next hint free area
  * @chunk: chunk of interest
@@ -415,9 +443,11 @@ static void pcpu_next_fit_region(struct pcpu_chunk *chunk, int alloc_bits,
 		if (block->contig_hint &&
 		    block->contig_hint_start >= block_off &&
 		    block->contig_hint >= *bits + alloc_bits) {
+			int start = pcpu_next_hint(block, alloc_bits);
+
 			*bits += alloc_bits + block->contig_hint_start -
-				 block->first_free;
-			*bit_off = pcpu_block_off_to_off(i, block->first_free);
+				 start;
+			*bit_off = pcpu_block_off_to_off(i, start);
 			return;
 		}
 		/* reset to satisfy the second predicate above */
@@ -632,12 +662,57 @@ static void pcpu_block_update(struct pcpu_block_md *block, int start, int end)
 		block->right_free = contig;
 
 	if (contig > block->contig_hint) {
+		/* promote the old contig_hint to be the new scan_hint */
+		if (start > block->contig_hint_start) {
+			if (block->contig_hint > block->scan_hint) {
+				block->scan_hint_start =
+					block->contig_hint_start;
+				block->scan_hint = block->contig_hint;
+			} else if (start < block->scan_hint_start) {
+				/*
+				 * The old contig_hint == scan_hint.  But, the
+				 * new contig is larger so hold the invariant
+				 * scan_hint_start < contig_hint_start.
+				 */
+				block->scan_hint = 0;
+			}
+		} else {
+			block->scan_hint = 0;
+		}
 		block->contig_hint_start = start;
 		block->contig_hint = contig;
-	} else if (block->contig_hint_start && contig == block->contig_hint &&
-		   (!start || __ffs(start) > __ffs(block->contig_hint_start))) {
-		/* use the start with the best alignment */
-		block->contig_hint_start = start;
+	} else if (contig == block->contig_hint) {
+		if (block->contig_hint_start &&
+		    (!start ||
+		     __ffs(start) > __ffs(block->contig_hint_start))) {
+			/* start has a better alignment so use it */
+			block->contig_hint_start = start;
+			if (start < block->scan_hint_start &&
+			    block->contig_hint > block->scan_hint)
+				block->scan_hint = 0;
+		} else if (start > block->scan_hint_start ||
+			   block->contig_hint > block->scan_hint) {
+			/*
+			 * Knowing contig == contig_hint, update the scan_hint
+			 * if it is farther than or larger than the current
+			 * scan_hint.
+			 */
+			block->scan_hint_start = start;
+			block->scan_hint = contig;
+		}
+	} else {
+		/*
+		 * The region is smaller than the contig_hint.  So only update
+		 * the scan_hint if it is larger than or equal and farther than
+		 * the current scan_hint.
+		 */
+		if ((start < block->contig_hint_start &&
+		     (contig > block->scan_hint ||
+		      (contig == block->scan_hint &&
+		       start > block->scan_hint_start)))) {
+			block->scan_hint_start = start;
+			block->scan_hint = contig;
+		}
 	}
 }
 
@@ -656,7 +731,7 @@ static void pcpu_block_refresh_hint(struct pcpu_chunk *chunk, int index)
 	int rs, re;	/* region start, region end */
 
 	/* clear hints */
-	block->contig_hint = 0;
+	block->contig_hint = block->scan_hint = 0;
 	block->left_free = block->right_free = 0;
 
 	/* iterate over free areas and update the contig hints */
@@ -713,6 +788,12 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 					PCPU_BITMAP_BLOCK_BITS,
 					s_off + bits);
 
+	if (pcpu_region_overlap(s_block->scan_hint_start,
+				s_block->scan_hint_start + s_block->scan_hint,
+				s_off,
+				s_off + bits))
+		s_block->scan_hint = 0;
+
 	if (pcpu_region_overlap(s_block->contig_hint_start,
 				s_block->contig_hint_start +
 				s_block->contig_hint,
@@ -749,6 +830,9 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 			/* reset the block */
 			e_block++;
 		} else {
+			if (e_off > e_block->scan_hint_start)
+				e_block->scan_hint = 0;
+
 			if (e_off > e_block->contig_hint_start) {
 				/* contig hint is broken - scan to fix it */
 				pcpu_block_refresh_hint(chunk, e_index);
@@ -763,6 +847,7 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 		/* update in-between md_blocks */
 		nr_empty_pages += (e_index - s_index - 1);
 		for (block = s_block + 1; block < e_block; block++) {
+			block->scan_hint = 0;
 			block->contig_hint = 0;
 			block->left_free = 0;
 			block->right_free = 0;
@@ -873,6 +958,7 @@ static void pcpu_block_update_hint_free(struct pcpu_chunk *chunk, int bit_off,
 		nr_empty_pages += (e_index - s_index - 1);
 		for (block = s_block + 1; block < e_block; block++) {
 			block->first_free = 0;
+			block->scan_hint = 0;
 			block->contig_hint_start = 0;
 			block->contig_hint = PCPU_BITMAP_BLOCK_BITS;
 			block->left_free = PCPU_BITMAP_BLOCK_BITS;
@@ -1084,6 +1170,7 @@ static void pcpu_init_md_blocks(struct pcpu_chunk *chunk)
 	for (md_block = chunk->md_blocks;
 	     md_block != chunk->md_blocks + pcpu_chunk_nr_blocks(chunk);
 	     md_block++) {
+		md_block->scan_hint = 0;
 		md_block->contig_hint = PCPU_BITMAP_BLOCK_BITS;
 		md_block->left_free = PCPU_BITMAP_BLOCK_BITS;
 		md_block->right_free = PCPU_BITMAP_BLOCK_BITS;
-- 
2.17.1

