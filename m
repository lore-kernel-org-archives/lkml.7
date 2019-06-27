Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56FEC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9509F208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfF0MwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:52:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:36562 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbfF0MwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:52:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 05:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="245806000"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2019 05:52:10 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 7/9] intel_th: msu: Get rid of the window size limit
Date:   Thu, 27 Jun 2019 15:51:50 +0300
Message-Id: <20190627125152.54905-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the window size is limited to the maximum number of sg entries
in one table. This is because the code addresses individual blocks within
the window by their numeric index. In reality, though, the blocks most
often are iterated through sequentially. By rewriting the logic to use sg
pointers instead of block indices we loose the necessity to dereference
them directly and gain the ability to use multiple chained tables if
necessary.

Get rid of the limitation by replacing index-based block accesses with
sequential block accesses.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 139 +++++++++++++++----------------
 1 file changed, 68 insertions(+), 71 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index f2d52c025528..58dd381debd2 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -70,8 +70,8 @@ struct msc_iter {
 	struct msc_window	*start_win;
 	struct msc_window	*win;
 	unsigned long		offset;
-	int			start_block;
-	int			block;
+	struct scatterlist	*start_block;
+	struct scatterlist	*block;
 	unsigned int		block_off;
 	unsigned int		wrap_count;
 	unsigned int		eof;
@@ -251,28 +251,25 @@ static inline bool msc_block_is_empty(struct msc_block_desc *bdesc)
 	return false;
 }
 
-static inline struct msc_block_desc *
-msc_win_block(struct msc_window *win, unsigned int block)
+static inline struct scatterlist *msc_win_base_sg(struct msc_window *win)
 {
-	return sg_virt(&win->sgt->sgl[block]);
+	return win->sgt->sgl;
 }
 
-static inline size_t
-msc_win_actual_bsz(struct msc_window *win, unsigned int block)
+static inline struct msc_block_desc *msc_win_base(struct msc_window *win)
 {
-	return win->sgt->sgl[block].length;
+	return sg_virt(msc_win_base_sg(win));
 }
 
-static inline dma_addr_t
-msc_win_baddr(struct msc_window *win, unsigned int block)
+static inline dma_addr_t msc_win_base_dma(struct msc_window *win)
 {
-	return sg_dma_address(&win->sgt->sgl[block]);
+	return sg_dma_address(msc_win_base_sg(win));
 }
 
 static inline unsigned long
-msc_win_bpfn(struct msc_window *win, unsigned int block)
+msc_win_base_pfn(struct msc_window *win)
 {
-	return msc_win_baddr(win, block) >> PAGE_SHIFT;
+	return PFN_DOWN(msc_win_base_dma(win));
 }
 
 /**
@@ -302,11 +299,12 @@ static struct msc_window *msc_next_window(struct msc_window *win)
 
 static size_t msc_win_total_sz(struct msc_window *win)
 {
+	struct scatterlist *sg;
 	unsigned int blk;
 	size_t size = 0;
 
-	for (blk = 0; blk < win->nr_segs; blk++) {
-		struct msc_block_desc *bdesc = msc_win_block(win, blk);
+	for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
+		struct msc_block_desc *bdesc = sg_virt(sg);
 
 		if (msc_block_wrapped(bdesc))
 			return win->nr_blocks << PAGE_SHIFT;
@@ -347,7 +345,7 @@ msc_find_window(struct msc *msc, struct sg_table *sgt, bool nonempty)
 			found++;
 
 		/* skip the empty ones */
-		if (nonempty && msc_block_is_empty(msc_win_block(win, 0)))
+		if (nonempty && msc_block_is_empty(msc_win_base(win)))
 			continue;
 
 		if (found)
@@ -381,44 +379,38 @@ static struct msc_window *msc_oldest_window(struct msc *msc)
 }
 
 /**
- * msc_win_oldest_block() - locate the oldest block in a given window
+ * msc_win_oldest_sg() - locate the oldest block in a given window
  * @win:	window to look at
  *
  * Return:	index of the block with the oldest data
  */
-static unsigned int msc_win_oldest_block(struct msc_window *win)
+static struct scatterlist *msc_win_oldest_sg(struct msc_window *win)
 {
 	unsigned int blk;
-	struct msc_block_desc *bdesc = msc_win_block(win, 0);
+	struct scatterlist *sg;
+	struct msc_block_desc *bdesc = msc_win_base(win);
 
 	/* without wrapping, first block is the oldest */
 	if (!msc_block_wrapped(bdesc))
-		return 0;
+		return msc_win_base_sg(win);
 
 	/*
 	 * with wrapping, last written block contains both the newest and the
 	 * oldest data for this window.
 	 */
-	for (blk = 0; blk < win->nr_segs; blk++) {
-		bdesc = msc_win_block(win, blk);
+	for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
+		struct msc_block_desc *bdesc = sg_virt(sg);
 
 		if (msc_block_last_written(bdesc))
-			return blk;
+			return sg;
 	}
 
-	return 0;
+	return msc_win_base_sg(win);
 }
 
 static struct msc_block_desc *msc_iter_bdesc(struct msc_iter *iter)
 {
-	return msc_win_block(iter->win, iter->block);
-}
-
-static void msc_iter_init(struct msc_iter *iter)
-{
-	memset(iter, 0, sizeof(*iter));
-	iter->start_block = -1;
-	iter->block = -1;
+	return sg_virt(iter->block);
 }
 
 static struct msc_iter *msc_iter_install(struct msc *msc)
@@ -443,7 +435,6 @@ static struct msc_iter *msc_iter_install(struct msc *msc)
 		goto unlock;
 	}
 
-	msc_iter_init(iter);
 	iter->msc = msc;
 
 	list_add_tail(&iter->entry, &msc->iter_list);
@@ -464,10 +455,10 @@ static void msc_iter_remove(struct msc_iter *iter, struct msc *msc)
 
 static void msc_iter_block_start(struct msc_iter *iter)
 {
-	if (iter->start_block != -1)
+	if (iter->start_block)
 		return;
 
-	iter->start_block = msc_win_oldest_block(iter->win);
+	iter->start_block = msc_win_oldest_sg(iter->win);
 	iter->block = iter->start_block;
 	iter->wrap_count = 0;
 
@@ -491,7 +482,7 @@ static int msc_iter_win_start(struct msc_iter *iter, struct msc *msc)
 		return -EINVAL;
 
 	iter->win = iter->start_win;
-	iter->start_block = -1;
+	iter->start_block = NULL;
 
 	msc_iter_block_start(iter);
 
@@ -501,7 +492,7 @@ static int msc_iter_win_start(struct msc_iter *iter, struct msc *msc)
 static int msc_iter_win_advance(struct msc_iter *iter)
 {
 	iter->win = msc_next_window(iter->win);
-	iter->start_block = -1;
+	iter->start_block = NULL;
 
 	if (iter->win == iter->start_win) {
 		iter->eof++;
@@ -531,8 +522,10 @@ static int msc_iter_block_advance(struct msc_iter *iter)
 		return msc_iter_win_advance(iter);
 
 	/* block advance */
-	if (++iter->block == iter->win->nr_segs)
-		iter->block = 0;
+	if (sg_is_last(iter->block))
+		iter->block = msc_win_base_sg(iter->win);
+	else
+		iter->block = sg_next(iter->block);
 
 	/* no wrapping, sanity check in case there is no last written block */
 	if (!iter->wrap_count && iter->block == iter->start_block)
@@ -637,14 +630,15 @@ msc_buffer_iterate(struct msc_iter *iter, size_t size, void *data,
 static void msc_buffer_clear_hw_header(struct msc *msc)
 {
 	struct msc_window *win;
+	struct scatterlist *sg;
 
 	list_for_each_entry(win, &msc->win_list, entry) {
 		unsigned int blk;
 		size_t hw_sz = sizeof(struct msc_block_desc) -
 			offsetof(struct msc_block_desc, hw_tag);
 
-		for (blk = 0; blk < win->nr_segs; blk++) {
-			struct msc_block_desc *bdesc = msc_win_block(win, blk);
+		for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
+			struct msc_block_desc *bdesc = sg_virt(sg);
 
 			memset(&bdesc->hw_tag, 0, hw_sz);
 		}
@@ -979,10 +973,9 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 	return nr_segs;
 
 err_nomem:
-	for (i--; i >= 0; i--)
+	for_each_sg(win->sgt->sgl, sg_ptr, i, ret)
 		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
-				  msc_win_block(win, i),
-				  msc_win_baddr(win, i));
+				  sg_virt(sg_ptr), sg_dma_address(sg_ptr));
 
 	sg_free_table(win->sgt);
 
@@ -992,20 +985,26 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 #ifdef CONFIG_X86
 static void msc_buffer_set_uc(struct msc_window *win, unsigned int nr_segs)
 {
+	struct scatterlist *sg_ptr;
 	int i;
 
-	for (i = 0; i < nr_segs; i++)
+	for_each_sg(win->sgt->sgl, sg_ptr, nr_segs, i) {
 		/* Set the page as uncached */
-		set_memory_uc((unsigned long)msc_win_block(win, i), 1);
+		set_memory_uc((unsigned long)sg_virt(sg_ptr),
+			      PFN_DOWN(sg_ptr->length));
+	}
 }
 
 static void msc_buffer_set_wb(struct msc_window *win)
 {
+	struct scatterlist *sg_ptr;
 	int i;
 
-	for (i = 0; i < win->nr_segs; i++)
+	for_each_sg(win->sgt->sgl, sg_ptr, win->nr_segs, i) {
 		/* Reset the page to write-back */
-		set_memory_wb((unsigned long)msc_win_block(win, i), 1);
+		set_memory_wb((unsigned long)sg_virt(sg_ptr),
+			      PFN_DOWN(sg_ptr->length));
+	}
 }
 #else /* !X86 */
 static inline void
@@ -1031,13 +1030,6 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 	if (!nr_blocks)
 		return 0;
 
-	/*
-	 * This limitation hold as long as we need random access to the
-	 * block. When that changes, this can go away.
-	 */
-	if (nr_blocks > SG_MAX_SINGLE_ALLOC)
-		return -EINVAL;
-
 	win = kzalloc(sizeof(*win), GFP_KERNEL);
 	if (!win)
 		return -ENOMEM;
@@ -1069,8 +1061,8 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 	atomic_set(&win->lockout, WIN_READY);
 
 	if (list_empty(&msc->win_list)) {
-		msc->base = msc_win_block(win, 0);
-		msc->base_addr = msc_win_baddr(win, 0);
+		msc->base = msc_win_base(win);
+		msc->base_addr = msc_win_base_dma(win);
 		msc->cur_win = win;
 	}
 
@@ -1087,14 +1079,15 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 
 static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 {
+	struct scatterlist *sg;
 	int i;
 
-	for (i = 0; i < win->nr_segs; i++) {
-		struct page *page = sg_page(&win->sgt->sgl[i]);
+	for_each_sg(win->sgt->sgl, sg, win->nr_segs, i) {
+		struct page *page = sg_page(sg);
 
 		page->mapping = NULL;
 		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
-				  msc_win_block(win, i), msc_win_baddr(win, i));
+				  sg_virt(sg), sg_dma_address(sg));
 	}
 	sg_free_table(win->sgt);
 }
@@ -1140,6 +1133,7 @@ static void msc_buffer_relink(struct msc *msc)
 
 	/* call with msc::mutex locked */
 	list_for_each_entry(win, &msc->win_list, entry) {
+		struct scatterlist *sg;
 		unsigned int blk;
 		u32 sw_tag = 0;
 
@@ -1155,12 +1149,12 @@ static void msc_buffer_relink(struct msc *msc)
 			next_win = list_next_entry(win, entry);
 		}
 
-		for (blk = 0; blk < win->nr_segs; blk++) {
-			struct msc_block_desc *bdesc = msc_win_block(win, blk);
+		for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
+			struct msc_block_desc *bdesc = sg_virt(sg);
 
 			memset(bdesc, 0, sizeof(*bdesc));
 
-			bdesc->next_win = msc_win_bpfn(next_win, 0);
+			bdesc->next_win = msc_win_base_pfn(next_win);
 
 			/*
 			 * Similarly to last window, last block should point
@@ -1168,13 +1162,15 @@ static void msc_buffer_relink(struct msc *msc)
 			 */
 			if (blk == win->nr_segs - 1) {
 				sw_tag |= MSC_SW_TAG_LASTBLK;
-				bdesc->next_blk = msc_win_bpfn(win, 0);
+				bdesc->next_blk = msc_win_base_pfn(win);
 			} else {
-				bdesc->next_blk = msc_win_bpfn(win, blk + 1);
+				dma_addr_t addr = sg_dma_address(sg_next(sg));
+
+				bdesc->next_blk = PFN_DOWN(addr);
 			}
 
 			bdesc->sw_tag = sw_tag;
-			bdesc->block_sz = msc_win_actual_bsz(win, blk) / 64;
+			bdesc->block_sz = sg->length / 64;
 		}
 	}
 
@@ -1333,6 +1329,7 @@ static int msc_buffer_free_unless_used(struct msc *msc)
 static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 {
 	struct msc_window *win;
+	struct scatterlist *sg;
 	unsigned int blk;
 
 	if (msc->mode == MSC_MODE_SINGLE)
@@ -1347,9 +1344,9 @@ static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 found:
 	pgoff -= win->pgoff;
 
-	for (blk = 0; blk < win->nr_segs; blk++) {
-		struct page *page = sg_page(&win->sgt->sgl[blk]);
-		size_t pgsz = PFN_DOWN(msc_win_actual_bsz(win, blk));
+	for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
+		struct page *page = sg_page(sg);
+		size_t pgsz = PFN_DOWN(sg->length);
 
 		if (pgoff < pgsz)
 			return page + pgoff;
@@ -1654,8 +1651,8 @@ static void msc_win_switch(struct msc *msc)
 	else
 		msc->cur_win = list_next_entry(msc->cur_win, entry);
 
-	msc->base = msc_win_block(msc->cur_win, 0);
-	msc->base_addr = msc_win_baddr(msc->cur_win, 0);
+	msc->base = msc_win_base(msc->cur_win);
+	msc->base_addr = msc_win_base_dma(msc->cur_win);
 
 	intel_th_trace_switch(msc->thdev);
 }
-- 
2.20.1

