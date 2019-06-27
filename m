Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0536C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8202D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfF0MwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:52:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:36562 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfF0MwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:52:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 05:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="245805965"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2019 05:52:01 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 2/9] intel_th: msu: Support multipage blocks
Date:   Thu, 27 Jun 2019 15:51:45 +0300
Message-Id: <20190627125152.54905-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the MSU is using scatterlist, we can support multipage blocks.
At the moment, the code assumes that all blocks are page-sized, but in
larger buffers it may make sense to chunk together larger blocks of
memory. One place where one-to-many relationship needs to be handled is
the MSU buffer's mmap path.

Get rid of the implicit assumption that all blocks are page-sized.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 56 ++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 8c568b5c8920..45af29af2473 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -33,12 +33,14 @@
  * @entry:	window list linkage (msc::win_list)
  * @pgoff:	page offset into the buffer that this window starts at
  * @nr_blocks:	number of blocks (pages) in this window
+ * @nr_segs:	number of segments in this window (<= @nr_blocks)
  * @sgt:	array of block descriptors
  */
 struct msc_window {
 	struct list_head	entry;
 	unsigned long		pgoff;
 	unsigned int		nr_blocks;
+	unsigned int		nr_segs;
 	struct msc		*msc;
 	struct sg_table		sgt;
 };
@@ -141,6 +143,12 @@ msc_win_block(struct msc_window *win, unsigned int block)
 	return sg_virt(&win->sgt.sgl[block]);
 }
 
+static inline size_t
+msc_win_actual_bsz(struct msc_window *win, unsigned int block)
+{
+	return win->sgt.sgl[block].length;
+}
+
 static inline dma_addr_t
 msc_win_baddr(struct msc_window *win, unsigned int block)
 {
@@ -234,7 +242,7 @@ static unsigned int msc_win_oldest_block(struct msc_window *win)
 	 * with wrapping, last written block contains both the newest and the
 	 * oldest data for this window.
 	 */
-	for (blk = 0; blk < win->nr_blocks; blk++) {
+	for (blk = 0; blk < win->nr_segs; blk++) {
 		bdesc = msc_win_block(win, blk);
 
 		if (msc_block_last_written(bdesc))
@@ -366,7 +374,7 @@ static int msc_iter_block_advance(struct msc_iter *iter)
 		return msc_iter_win_advance(iter);
 
 	/* block advance */
-	if (++iter->block == iter->win->nr_blocks)
+	if (++iter->block == iter->win->nr_segs)
 		iter->block = 0;
 
 	/* no wrapping, sanity check in case there is no last written block */
@@ -478,7 +486,7 @@ static void msc_buffer_clear_hw_header(struct msc *msc)
 		size_t hw_sz = sizeof(struct msc_block_desc) -
 			offsetof(struct msc_block_desc, hw_tag);
 
-		for (blk = 0; blk < win->nr_blocks; blk++) {
+		for (blk = 0; blk < win->nr_segs; blk++) {
 			struct msc_block_desc *bdesc = msc_win_block(win, blk);
 
 			memset(&bdesc->hw_tag, 0, hw_sz);
@@ -734,17 +742,17 @@ static struct page *msc_buffer_contig_get_page(struct msc *msc,
 }
 
 static int __msc_buffer_win_alloc(struct msc_window *win,
-				  unsigned int nr_blocks)
+				  unsigned int nr_segs)
 {
 	struct scatterlist *sg_ptr;
 	void *block;
 	int i, ret;
 
-	ret = sg_alloc_table(&win->sgt, nr_blocks, GFP_KERNEL);
+	ret = sg_alloc_table(&win->sgt, nr_segs, GFP_KERNEL);
 	if (ret)
 		return -ENOMEM;
 
-	for_each_sg(win->sgt.sgl, sg_ptr, nr_blocks, i) {
+	for_each_sg(win->sgt.sgl, sg_ptr, nr_segs, i) {
 		block = dma_alloc_coherent(msc_dev(win->msc)->parent->parent,
 					  PAGE_SIZE, &sg_dma_address(sg_ptr),
 					  GFP_KERNEL);
@@ -754,7 +762,7 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 		sg_set_buf(sg_ptr, block, PAGE_SIZE);
 	}
 
-	return nr_blocks;
+	return nr_segs;
 
 err_nomem:
 	for (i--; i >= 0; i--)
@@ -768,11 +776,11 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 }
 
 #ifdef CONFIG_X86
-static void msc_buffer_set_uc(struct msc_window *win, unsigned int nr_blocks)
+static void msc_buffer_set_uc(struct msc_window *win, unsigned int nr_segs)
 {
 	int i;
 
-	for (i = 0; i < nr_blocks; i++)
+	for (i = 0; i < nr_segs; i++)
 		/* Set the page as uncached */
 		set_memory_uc((unsigned long)msc_win_block(win, i), 1);
 }
@@ -781,13 +789,13 @@ static void msc_buffer_set_wb(struct msc_window *win)
 {
 	int i;
 
-	for (i = 0; i < win->nr_blocks; i++)
+	for (i = 0; i < win->nr_segs; i++)
 		/* Reset the page to write-back */
 		set_memory_wb((unsigned long)msc_win_block(win, i), 1);
 }
 #else /* !X86 */
 static inline void
-msc_buffer_set_uc(struct msc_window *win, unsigned int nr_blocks) {}
+msc_buffer_set_uc(struct msc_window *win, unsigned int nr_segs) {}
 static inline void msc_buffer_set_wb(struct msc_window *win) {}
 #endif /* CONFIG_X86 */
 
@@ -827,7 +835,6 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 							  struct msc_window,
 							  entry);
 
-		/* This works as long as blocks are page-sized */
 		win->pgoff = prev->pgoff + prev->nr_blocks;
 	}
 
@@ -837,7 +844,8 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 
 	msc_buffer_set_uc(win, ret);
 
-	win->nr_blocks = ret;
+	win->nr_segs = ret;
+	win->nr_blocks = nr_blocks;
 
 	if (list_empty(&msc->win_list)) {
 		msc->base = msc_win_block(win, 0);
@@ -860,7 +868,7 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 {
 	int i;
 
-	for (i = 0; i < win->nr_blocks; i++) {
+	for (i = 0; i < win->nr_segs; i++) {
 		struct page *page = sg_page(&win->sgt.sgl[i]);
 
 		page->mapping = NULL;
@@ -923,7 +931,7 @@ static void msc_buffer_relink(struct msc *msc)
 			next_win = list_next_entry(win, entry);
 		}
 
-		for (blk = 0; blk < win->nr_blocks; blk++) {
+		for (blk = 0; blk < win->nr_segs; blk++) {
 			struct msc_block_desc *bdesc = msc_win_block(win, blk);
 
 			memset(bdesc, 0, sizeof(*bdesc));
@@ -934,7 +942,7 @@ static void msc_buffer_relink(struct msc *msc)
 			 * Similarly to last window, last block should point
 			 * to the first one.
 			 */
-			if (blk == win->nr_blocks - 1) {
+			if (blk == win->nr_segs - 1) {
 				sw_tag |= MSC_SW_TAG_LASTBLK;
 				bdesc->next_blk = msc_win_bpfn(win, 0);
 			} else {
@@ -942,7 +950,7 @@ static void msc_buffer_relink(struct msc *msc)
 			}
 
 			bdesc->sw_tag = sw_tag;
-			bdesc->block_sz = PAGE_SIZE / 64;
+			bdesc->block_sz = msc_win_actual_bsz(win, blk) / 64;
 		}
 	}
 
@@ -1101,6 +1109,7 @@ static int msc_buffer_free_unless_used(struct msc *msc)
 static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 {
 	struct msc_window *win;
+	unsigned int blk;
 
 	if (msc->mode == MSC_MODE_SINGLE)
 		return msc_buffer_contig_get_page(msc, pgoff);
@@ -1113,7 +1122,18 @@ static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 
 found:
 	pgoff -= win->pgoff;
-	return sg_page(&win->sgt.sgl[pgoff]);
+
+	for (blk = 0; blk < win->nr_segs; blk++) {
+		struct page *page = sg_page(&win->sgt.sgl[blk]);
+		size_t pgsz = PFN_DOWN(msc_win_actual_bsz(win, blk));
+
+		if (pgoff < pgsz)
+			return page + pgoff;
+
+		pgoff -= pgsz;
+	}
+
+	return NULL;
 }
 
 /**
-- 
2.20.1

