Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91916C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4652085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfF0MwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:52:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:36562 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfF0MwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:52:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 05:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="245805971"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2019 05:52:03 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 3/9] intel_th: msu: Split sgt array and pointer in multiwindow mode
Date:   Thu, 27 Jun 2019 15:51:46 +0300
Message-Id: <20190627125152.54905-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow the use of externally allocated SG tables further down the line,
change the code to reference the table via a pointer and make it point to
the locally allocated table by default.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 45af29af2473..8efd2510192f 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -34,6 +34,7 @@
  * @pgoff:	page offset into the buffer that this window starts at
  * @nr_blocks:	number of blocks (pages) in this window
  * @nr_segs:	number of segments in this window (<= @nr_blocks)
+ * @_sgt:	array of block descriptors
  * @sgt:	array of block descriptors
  */
 struct msc_window {
@@ -42,7 +43,8 @@ struct msc_window {
 	unsigned int		nr_blocks;
 	unsigned int		nr_segs;
 	struct msc		*msc;
-	struct sg_table		sgt;
+	struct sg_table		_sgt;
+	struct sg_table		*sgt;
 };
 
 /**
@@ -140,19 +142,19 @@ static inline bool msc_block_is_empty(struct msc_block_desc *bdesc)
 static inline struct msc_block_desc *
 msc_win_block(struct msc_window *win, unsigned int block)
 {
-	return sg_virt(&win->sgt.sgl[block]);
+	return sg_virt(&win->sgt->sgl[block]);
 }
 
 static inline size_t
 msc_win_actual_bsz(struct msc_window *win, unsigned int block)
 {
-	return win->sgt.sgl[block].length;
+	return win->sgt->sgl[block].length;
 }
 
 static inline dma_addr_t
 msc_win_baddr(struct msc_window *win, unsigned int block)
 {
-	return sg_dma_address(&win->sgt.sgl[block]);
+	return sg_dma_address(&win->sgt->sgl[block]);
 }
 
 static inline unsigned long
@@ -748,11 +750,11 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 	void *block;
 	int i, ret;
 
-	ret = sg_alloc_table(&win->sgt, nr_segs, GFP_KERNEL);
+	ret = sg_alloc_table(win->sgt, nr_segs, GFP_KERNEL);
 	if (ret)
 		return -ENOMEM;
 
-	for_each_sg(win->sgt.sgl, sg_ptr, nr_segs, i) {
+	for_each_sg(win->sgt->sgl, sg_ptr, nr_segs, i) {
 		block = dma_alloc_coherent(msc_dev(win->msc)->parent->parent,
 					  PAGE_SIZE, &sg_dma_address(sg_ptr),
 					  GFP_KERNEL);
@@ -770,7 +772,7 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 				  msc_win_block(win, i),
 				  msc_win_baddr(win, i));
 
-	sg_free_table(&win->sgt);
+	sg_free_table(win->sgt);
 
 	return -ENOMEM;
 }
@@ -829,6 +831,7 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 		return -ENOMEM;
 
 	win->msc = msc;
+	win->sgt = &win->_sgt;
 
 	if (!list_empty(&msc->win_list)) {
 		struct msc_window *prev = list_last_entry(&msc->win_list,
@@ -869,13 +872,13 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 	int i;
 
 	for (i = 0; i < win->nr_segs; i++) {
-		struct page *page = sg_page(&win->sgt.sgl[i]);
+		struct page *page = sg_page(&win->sgt->sgl[i]);
 
 		page->mapping = NULL;
 		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
 				  msc_win_block(win, i), msc_win_baddr(win, i));
 	}
-	sg_free_table(&win->sgt);
+	sg_free_table(win->sgt);
 }
 
 /**
@@ -1124,7 +1127,7 @@ static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 	pgoff -= win->pgoff;
 
 	for (blk = 0; blk < win->nr_segs; blk++) {
-		struct page *page = sg_page(&win->sgt.sgl[blk]);
+		struct page *page = sg_page(&win->sgt->sgl[blk]);
 		size_t pgsz = PFN_DOWN(msc_win_actual_bsz(win, blk));
 
 		if (pgoff < pgsz)
-- 
2.20.1

