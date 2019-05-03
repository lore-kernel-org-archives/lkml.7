Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E63C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B752081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfECIpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:5536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfECIpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811572"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:36 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 11/22] intel_th: msu: Switch over to scatterlist
Date:   Fri,  3 May 2019 11:44:44 +0300
Message-Id: <20190503084455.23436-12-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a home-grown array of pointers to the DMA pages, switch
over to scatterlist data types and accessors, which has all the convenient
accessors, can be used to batch-map DMA memory and is convenient for
passing around between different layers, which will be useful when MSU
buffer management has to cross the boundaries of the MSU driver.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 163 ++++++++++++++++++++-----------
 1 file changed, 104 insertions(+), 59 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index f5d5cb862a81..0e7fbef8dee0 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -28,29 +28,19 @@
 
 #define msc_dev(x) (&(x)->thdev->dev)
 
-/**
- * struct msc_block - multiblock mode block descriptor
- * @bdesc:	pointer to hardware descriptor (beginning of the block)
- * @addr:	physical address of the block
- */
-struct msc_block {
-	struct msc_block_desc	*bdesc;
-	dma_addr_t		addr;
-};
-
 /**
  * struct msc_window - multiblock mode window descriptor
  * @entry:	window list linkage (msc::win_list)
  * @pgoff:	page offset into the buffer that this window starts at
  * @nr_blocks:	number of blocks (pages) in this window
- * @block:	array of block descriptors
+ * @sgt:	array of block descriptors
  */
 struct msc_window {
 	struct list_head	entry;
 	unsigned long		pgoff;
 	unsigned int		nr_blocks;
 	struct msc		*msc;
-	struct msc_block	block[0];
+	struct sg_table		sgt;
 };
 
 /**
@@ -143,6 +133,24 @@ static inline bool msc_block_is_empty(struct msc_block_desc *bdesc)
 	return false;
 }
 
+static inline struct msc_block_desc *
+msc_win_block(struct msc_window *win, unsigned int block)
+{
+	return sg_virt(&win->sgt.sgl[block]);
+}
+
+static inline dma_addr_t
+msc_win_baddr(struct msc_window *win, unsigned int block)
+{
+	return sg_dma_address(&win->sgt.sgl[block]);
+}
+
+static inline unsigned long
+msc_win_bpfn(struct msc_window *win, unsigned int block)
+{
+	return msc_win_baddr(win, block) >> PAGE_SHIFT;
+}
+
 /**
  * msc_oldest_window() - locate the window with oldest data
  * @msc:	MSC device
@@ -168,11 +176,11 @@ static struct msc_window *msc_oldest_window(struct msc *msc)
 	 * something like 2, in which case we're good
 	 */
 	list_for_each_entry(win, &msc->win_list, entry) {
-		if (win->block[0].addr == win_addr)
+		if (sg_dma_address(win->sgt.sgl) == win_addr)
 			found++;
 
 		/* skip the empty ones */
-		if (msc_block_is_empty(win->block[0].bdesc))
+		if (msc_block_is_empty(msc_win_block(win, 0)))
 			continue;
 
 		if (found)
@@ -191,7 +199,7 @@ static struct msc_window *msc_oldest_window(struct msc *msc)
 static unsigned int msc_win_oldest_block(struct msc_window *win)
 {
 	unsigned int blk;
-	struct msc_block_desc *bdesc = win->block[0].bdesc;
+	struct msc_block_desc *bdesc = msc_win_block(win, 0);
 
 	/* without wrapping, first block is the oldest */
 	if (!msc_block_wrapped(bdesc))
@@ -202,7 +210,7 @@ static unsigned int msc_win_oldest_block(struct msc_window *win)
 	 * oldest data for this window.
 	 */
 	for (blk = 0; blk < win->nr_blocks; blk++) {
-		bdesc = win->block[blk].bdesc;
+		bdesc = msc_win_block(win, blk);
 
 		if (msc_block_last_written(bdesc))
 			return blk;
@@ -238,7 +246,7 @@ static struct msc_window *msc_next_window(struct msc_window *win)
 
 static struct msc_block_desc *msc_iter_bdesc(struct msc_iter *iter)
 {
-	return iter->win->block[iter->block].bdesc;
+	return msc_win_block(iter->win, iter->block);
 }
 
 static void msc_iter_init(struct msc_iter *iter)
@@ -471,7 +479,7 @@ static void msc_buffer_clear_hw_header(struct msc *msc)
 			offsetof(struct msc_block_desc, hw_tag);
 
 		for (blk = 0; blk < win->nr_blocks; blk++) {
-			struct msc_block_desc *bdesc = win->block[blk].bdesc;
+			struct msc_block_desc *bdesc = msc_win_block(win, blk);
 
 			memset(&bdesc->hw_tag, 0, hw_sz);
 		}
@@ -734,6 +742,40 @@ static struct page *msc_buffer_contig_get_page(struct msc *msc,
 	return virt_to_page(msc->base + (pgoff << PAGE_SHIFT));
 }
 
+static int __msc_buffer_win_alloc(struct msc_window *win,
+				  unsigned int nr_blocks)
+{
+	struct scatterlist *sg_ptr;
+	void *block;
+	int i, ret;
+
+	ret = sg_alloc_table(&win->sgt, nr_blocks, GFP_KERNEL);
+	if (ret)
+		return -ENOMEM;
+
+	for_each_sg(win->sgt.sgl, sg_ptr, nr_blocks, i) {
+		block = dma_alloc_coherent(msc_dev(win->msc)->parent->parent,
+					  PAGE_SIZE, &sg_dma_address(sg_ptr),
+					  GFP_KERNEL);
+		if (!block)
+			goto err_nomem;
+
+		sg_set_buf(sg_ptr, block, PAGE_SIZE);
+	}
+
+	return nr_blocks;
+
+err_nomem:
+	for (i--; i >= 0; i--)
+		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
+				  msc_win_block(win, i),
+				  msc_win_baddr(win, i));
+
+	sg_free_table(&win->sgt);
+
+	return -ENOMEM;
+}
+
 /**
  * msc_buffer_win_alloc() - alloc a window for a multiblock mode
  * @msc:	MSC device
@@ -747,45 +789,48 @@ static struct page *msc_buffer_contig_get_page(struct msc *msc,
 static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 {
 	struct msc_window *win;
-	unsigned long size = PAGE_SIZE;
-	int i, ret = -ENOMEM;
+	int ret = -ENOMEM, i;
 
 	if (!nr_blocks)
 		return 0;
 
-	win = kzalloc(offsetof(struct msc_window, block[nr_blocks]),
-		      GFP_KERNEL);
+	/*
+	 * This limitation hold as long as we need random access to the
+	 * block. When that changes, this can go away.
+	 */
+	if (nr_blocks > SG_MAX_SINGLE_ALLOC)
+		return -EINVAL;
+
+	win = kzalloc(sizeof(*win), GFP_KERNEL);
 	if (!win)
 		return -ENOMEM;
 
+	win->msc = msc;
+
 	if (!list_empty(&msc->win_list)) {
 		struct msc_window *prev = list_last_entry(&msc->win_list,
 							  struct msc_window,
 							  entry);
 
+		/* This works as long as blocks are page-sized */
 		win->pgoff = prev->pgoff + prev->nr_blocks;
 	}
 
-	for (i = 0; i < nr_blocks; i++) {
-		win->block[i].bdesc =
-			dma_alloc_coherent(msc_dev(msc)->parent->parent, size,
-					   &win->block[i].addr, GFP_KERNEL);
-
-		if (!win->block[i].bdesc)
-			goto err_nomem;
+	ret = __msc_buffer_win_alloc(win, nr_blocks);
+	if (ret < 0)
+		goto err_nomem;
 
 #ifdef CONFIG_X86
+	for (i = 0; i < ret; i++)
 		/* Set the page as uncached */
-		set_memory_uc((unsigned long)win->block[i].bdesc, 1);
+		set_memory_uc((unsigned long)msc_win_block(win, i), 1);
 #endif
-	}
 
-	win->msc = msc;
-	win->nr_blocks = nr_blocks;
+	win->nr_blocks = ret;
 
 	if (list_empty(&msc->win_list)) {
-		msc->base = win->block[0].bdesc;
-		msc->base_addr = win->block[0].addr;
+		msc->base = msc_win_block(win, 0);
+		msc->base_addr = msc_win_baddr(win, 0);
 	}
 
 	list_add_tail(&win->entry, &msc->win_list);
@@ -794,19 +839,25 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 	return 0;
 
 err_nomem:
-	for (i--; i >= 0; i--) {
-#ifdef CONFIG_X86
-		/* Reset the page to write-back before releasing */
-		set_memory_wb((unsigned long)win->block[i].bdesc, 1);
-#endif
-		dma_free_coherent(msc_dev(msc)->parent->parent, size,
-				  win->block[i].bdesc, win->block[i].addr);
-	}
 	kfree(win);
 
 	return ret;
 }
 
+static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
+{
+	int i;
+
+	for (i = 0; i < win->nr_blocks; i++) {
+		struct page *page = sg_page(&win->sgt.sgl[i]);
+
+		page->mapping = NULL;
+		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
+				  msc_win_block(win, i), msc_win_baddr(win, i));
+	}
+	sg_free_table(&win->sgt);
+}
+
 /**
  * msc_buffer_win_free() - free a window from MSC's window list
  * @msc:	MSC device
@@ -827,17 +878,13 @@ static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 		msc->base_addr = 0;
 	}
 
-	for (i = 0; i < win->nr_blocks; i++) {
-		struct page *page = virt_to_page(win->block[i].bdesc);
-
-		page->mapping = NULL;
 #ifdef CONFIG_X86
-		/* Reset the page to write-back before releasing */
-		set_memory_wb((unsigned long)win->block[i].bdesc, 1);
+	for (i = 0; i < win->nr_blocks; i++)
+		/* Reset the page to write-back */
+		set_memory_wb((unsigned long)msc_win_block(win, i), 1);
 #endif
-		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
-				  win->block[i].bdesc, win->block[i].addr);
-	}
+
+	__msc_buffer_win_free(msc, win);
 
 	kfree(win);
 }
@@ -871,11 +918,11 @@ static void msc_buffer_relink(struct msc *msc)
 		}
 
 		for (blk = 0; blk < win->nr_blocks; blk++) {
-			struct msc_block_desc *bdesc = win->block[blk].bdesc;
+			struct msc_block_desc *bdesc = msc_win_block(win, blk);
 
 			memset(bdesc, 0, sizeof(*bdesc));
 
-			bdesc->next_win = next_win->block[0].addr >> PAGE_SHIFT;
+			bdesc->next_win = msc_win_bpfn(next_win, 0);
 
 			/*
 			 * Similarly to last window, last block should point
@@ -883,11 +930,9 @@ static void msc_buffer_relink(struct msc *msc)
 			 */
 			if (blk == win->nr_blocks - 1) {
 				sw_tag |= MSC_SW_TAG_LASTBLK;
-				bdesc->next_blk =
-					win->block[0].addr >> PAGE_SHIFT;
+				bdesc->next_blk = msc_win_bpfn(win, 0);
 			} else {
-				bdesc->next_blk =
-					win->block[blk + 1].addr >> PAGE_SHIFT;
+				bdesc->next_blk = msc_win_bpfn(win, blk + 1);
 			}
 
 			bdesc->sw_tag = sw_tag;
@@ -1062,7 +1107,7 @@ static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 
 found:
 	pgoff -= win->pgoff;
-	return virt_to_page(win->block[pgoff].bdesc);
+	return sg_page(&win->sgt.sgl[pgoff]);
 }
 
 /**
-- 
2.20.1

