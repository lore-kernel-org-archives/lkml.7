Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569D72081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfECIpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:5540 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfECIpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811577"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:37 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 12/22] intel_th: msu: Support multipage blocks
Date:   Fri,  3 May 2019 11:44:45 +0300
Message-Id: <20190503084455.23436-13-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
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
---
 drivers/hwtracing/intel_th/msu.c | 48 ++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 0e7fbef8dee0..a4f7a5b21d48 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -32,13 +32,15 @@
  * struct msc_window - multiblock mode window descriptor
  * @entry:	window list linkage (msc::win_list)
  * @pgoff:	page offset into the buffer that this window starts at
- * @nr_blocks:	number of blocks (pages) in this window
+ * @nr_blocks:	number of blocks in this window (<= @nr_pages)
+ * @nr_pages:	number of pages in this window
  * @sgt:	array of block descriptors
  */
 struct msc_window {
 	struct list_head	entry;
 	unsigned long		pgoff;
 	unsigned int		nr_blocks;
+	unsigned int		nr_pages;
 	struct msc		*msc;
 	struct sg_table		sgt;
 };
@@ -139,6 +141,12 @@ msc_win_block(struct msc_window *win, unsigned int block)
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
@@ -779,26 +787,26 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 /**
  * msc_buffer_win_alloc() - alloc a window for a multiblock mode
  * @msc:	MSC device
- * @nr_blocks:	number of pages in this window
+ * @nr_pages:	number of pages in this window
  *
  * This modifies msc::win_list and msc::base, which requires msc::buf_mutex
  * to serialize, so the caller is expected to hold it.
  *
  * Return:	0 on success, -errno otherwise.
  */
-static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
+static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_pages)
 {
 	struct msc_window *win;
 	int ret = -ENOMEM, i;
 
-	if (!nr_blocks)
+	if (!nr_pages)
 		return 0;
 
 	/*
 	 * This limitation hold as long as we need random access to the
 	 * block. When that changes, this can go away.
 	 */
-	if (nr_blocks > SG_MAX_SINGLE_ALLOC)
+	if (nr_pages > SG_MAX_SINGLE_ALLOC)
 		return -EINVAL;
 
 	win = kzalloc(sizeof(*win), GFP_KERNEL);
@@ -812,11 +820,10 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 							  struct msc_window,
 							  entry);
 
-		/* This works as long as blocks are page-sized */
-		win->pgoff = prev->pgoff + prev->nr_blocks;
+		win->pgoff = prev->pgoff + prev->nr_pages;
 	}
 
-	ret = __msc_buffer_win_alloc(win, nr_blocks);
+	ret = __msc_buffer_win_alloc(win, nr_pages);
 	if (ret < 0)
 		goto err_nomem;
 
@@ -827,6 +834,7 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 #endif
 
 	win->nr_blocks = ret;
+	win->nr_pages = nr_pages;
 
 	if (list_empty(&msc->win_list)) {
 		msc->base = msc_win_block(win, 0);
@@ -834,7 +842,7 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 	}
 
 	list_add_tail(&win->entry, &msc->win_list);
-	msc->nr_pages += nr_blocks;
+	msc->nr_pages += nr_pages;
 
 	return 0;
 
@@ -870,7 +878,7 @@ static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 {
 	int i;
 
-	msc->nr_pages -= win->nr_blocks;
+	msc->nr_pages -= win->nr_pages;
 
 	list_del(&win->entry);
 	if (list_empty(&msc->win_list)) {
@@ -936,7 +944,7 @@ static void msc_buffer_relink(struct msc *msc)
 			}
 
 			bdesc->sw_tag = sw_tag;
-			bdesc->block_sz = PAGE_SIZE / 64;
+			bdesc->block_sz = msc_win_actual_bsz(win, blk) / 64;
 		}
 	}
 
@@ -1095,19 +1103,31 @@ static int msc_buffer_free_unless_used(struct msc *msc)
 static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 {
 	struct msc_window *win;
+	unsigned int blk;
 
 	if (msc->mode == MSC_MODE_SINGLE)
 		return msc_buffer_contig_get_page(msc, pgoff);
 
 	list_for_each_entry(win, &msc->win_list, entry)
-		if (pgoff >= win->pgoff && pgoff < win->pgoff + win->nr_blocks)
+		if (pgoff >= win->pgoff && pgoff < win->pgoff + win->nr_pages)
 			goto found;
 
 	return NULL;
 
 found:
 	pgoff -= win->pgoff;
-	return sg_page(&win->sgt.sgl[pgoff]);
+
+	for (blk = 0; blk < win->nr_blocks; blk++) {
+		struct page *page = sg_page(&win->sgt.sgl[blk]);
+		size_t pgsz = win->sgt.sgl[blk].length >> PAGE_SHIFT;
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
@@ -1481,7 +1501,7 @@ nr_pages_show(struct device *dev, struct device_attribute *attr, char *buf)
 	else if (msc->mode == MSC_MODE_MULTI) {
 		list_for_each_entry(win, &msc->win_list, entry) {
 			count += scnprintf(buf + count, PAGE_SIZE - count,
-					   "%d%c", win->nr_blocks,
+					   "%d%c", win->nr_pages,
 					   msc_is_last_win(win) ? '\n' : ',');
 		}
 	} else {
-- 
2.20.1

