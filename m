Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55254C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022AA2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfECIp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:5545 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfECIpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811603"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:49 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 19/22] intel_th: msu: Introduce buffer driver interface
Date:   Fri,  3 May 2019 11:44:52 +0300
Message-Id: <20190503084455.23436-20-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces a concept of buffer drivers, which is a mechanism for creating
trace sinks that would receive trace data from MSC buffers and transfer it
elsewhere.

A buffer driver can implement its own window allocation/deallocation if
it has to. It must provide a callback that's used to notify it when a
window fills up, so that it can then start a DMA transaction from that
window 'elsewhere'. This window remains in a 'locked' state and won't be
used for storing new trace data until the buffer driver 'unlocks' it with
a provided API call, at which point the window can be used again for
storing trace data.

This relies on a functional "last block" interrupt, so not all versions of
Trace Hub can use this feature.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 .../testing/sysfs-bus-intel_th-devices-msc    |   3 +-
 MAINTAINERS                                   |   1 +
 drivers/hwtracing/intel_th/msu.c              | 448 ++++++++++++++++--
 drivers/hwtracing/intel_th/msu.h              |  23 +-
 include/linux/intel_th.h                      |  67 +++
 5 files changed, 485 insertions(+), 57 deletions(-)
 create mode 100644 include/linux/intel_th.h

diff --git a/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc b/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
index f54ae244f3f1..7da00601afdc 100644
--- a/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
+++ b/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
@@ -12,7 +12,8 @@ Description:	(RW) Configure MSC operating mode:
 		  - "single", for contiguous buffer mode (high-order alloc);
 		  - "multi", for multiblock mode;
 		  - "ExI", for DCI handler mode;
-		  - "debug", for debug mode.
+		  - "debug", for debug mode;
+		  - any of the currently loaded buffer drivers.
 		If operating mode changes, existing buffer is deallocated,
 		provided there are no active users and tracing is not enabled,
 		otherwise the write will fail.
diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..69d845f5401b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8027,6 +8027,7 @@ M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 S:	Supported
 F:	Documentation/trace/intel_th.rst
 F:	drivers/hwtracing/intel_th/
+F:	include/linux/intel_th.h
 
 INTEL(R) TRUSTED EXECUTION TECHNOLOGY (TXT)
 M:	Ning Sun <ning.sun@intel.com>
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 2916de5651aa..04bfe4dbf325 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -17,12 +17,14 @@
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/io.h>
+#include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
 
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
 #endif
 
+#include <linux/intel_th.h>
 #include "intel_th.h"
 #include "msu.h"
 
@@ -32,17 +34,21 @@
  * struct msc_window - multiblock mode window descriptor
  * @entry:	window list linkage (msc::win_list)
  * @pgoff:	page offset into the buffer that this window starts at
+ * @lockout:	lockout state, see comment below
  * @nr_blocks:	number of blocks in this window (<= @nr_pages)
  * @nr_pages:	number of pages in this window
- * @sgt:	array of block descriptors
+ * @_sgt:	array of block descriptors
+ * @sgt:	pointer to @sgt or whatever bdrv allocates
  */
 struct msc_window {
 	struct list_head	entry;
 	unsigned long		pgoff;
+	atomic_t		lockout;
 	unsigned int		nr_blocks;
 	unsigned int		nr_pages;
 	struct msc		*msc;
-	struct sg_table		sgt;
+	struct sg_table		_sgt;
+	struct sg_table		*sgt;
 };
 
 /**
@@ -98,6 +104,10 @@ struct msc {
 	void __iomem		*msu_base;
 	struct intel_th_device	*thdev;
 
+	const struct msu_buffer_driver	*bdrv;
+	void				*bdrv_priv;
+
+	struct work_struct	work;
 	struct list_head	win_list;
 	struct sg_table		single_sgt;
 	struct msc_window	*cur_win;
@@ -124,6 +134,110 @@ struct msc {
 	unsigned int		index;
 };
 
+/*
+ * Lockout state transitions:
+ *   READY -> INUSE -+-> LOCKED -+-> READY -> etc.
+ *		     \-----------/
+ * WIN_READY:	window can be used by HW
+ * WIN_INUSE:	window is in use
+ * WIN_LOCKED:	window is filled up and is being processed by the buffer driver
+ *
+ * All state transitions happen automatically, except for the LOCKED->READY,
+ * which needs to be signalled by the buffer driver by calling
+ * intel_th_msc_window_unlock().
+ *
+ * When the interrupt handler has to switch to the next window, it checks
+ * whether it's READY, and if it is, it performs the switch and tracing
+ * continues. If it's LOCKED, it stops the trace.
+ */
+enum {
+	WIN_READY = 0,
+	WIN_INUSE,
+	WIN_LOCKED
+};
+
+static LIST_HEAD(msu_buffer_list);
+static struct mutex msu_buffer_mutex;
+
+struct msu_buffer {
+	struct list_head		entry;
+	const struct msu_buffer_driver	*bdrv;
+};
+
+static struct msu_buffer *__msu_buffer_find(const char *name)
+{
+	struct msu_buffer *buf;
+
+	list_for_each_entry(buf, &msu_buffer_list, entry) {
+		if (!strcmp(buf->bdrv->name, name))
+			return buf;
+	}
+
+	return NULL;
+}
+
+static const struct msu_buffer_driver *
+__msu_buffer_driver_find(const char *name)
+{
+	struct msu_buffer *buf = __msu_buffer_find(name);
+
+	return buf ? buf->bdrv : NULL;
+}
+
+static const struct msu_buffer_driver *
+msu_buffer_driver_get(const char *name)
+{
+	const struct msu_buffer_driver *bdrv;
+
+	mutex_lock(&msu_buffer_mutex);
+	bdrv = __msu_buffer_driver_find(name);
+	if (bdrv && !try_module_get(bdrv->owner))
+		bdrv = NULL;
+	mutex_unlock(&msu_buffer_mutex);
+
+	return bdrv ? : NULL;
+}
+
+int intel_th_msu_buffer_register(const struct msu_buffer_driver *bdrv)
+{
+	struct msu_buffer *buf;
+	int ret = -EEXIST;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	mutex_lock(&msu_buffer_mutex);
+	if (__msu_buffer_driver_find(bdrv->name))
+		goto out;
+
+	buf->bdrv = bdrv;
+	list_add_tail(&buf->entry, &msu_buffer_list);
+	ret = 0;
+out:
+	mutex_unlock(&msu_buffer_mutex);
+
+	if (ret)
+		kfree(buf);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(intel_th_msu_buffer_register);
+
+void intel_th_msu_buffer_unregister(const struct msu_buffer_driver *bdrv)
+{
+	struct msu_buffer *buf;
+
+	mutex_lock(&msu_buffer_mutex);
+	buf = __msu_buffer_find(bdrv->name);
+	if (buf) {
+		list_del(&buf->entry);
+		kfree(buf);
+	}
+	mutex_unlock(&msu_buffer_mutex);
+}
+EXPORT_SYMBOL_GPL(intel_th_msu_buffer_unregister);
+
 static inline bool msc_block_is_empty(struct msc_block_desc *bdesc)
 {
 	/* header hasn't been written */
@@ -140,19 +254,19 @@ static inline bool msc_block_is_empty(struct msc_block_desc *bdesc)
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
@@ -187,42 +301,105 @@ static struct msc_window *msc_next_window(struct msc_window *win)
 }
 
 /**
- * msc_oldest_window() - locate the window with oldest data
+ * msc_find_window() - find a window matching a given sg_table
  * @msc:	MSC device
- *
- * This should only be used in multiblock mode. Caller should hold the
- * msc::user_count reference.
- *
- * Return:	the oldest window with valid data
+ * @sgt:	SG table of the window
+ * @nonempty:	skip over empty windows
+ * Return:	MSC window structure pointer or NULL if the window
+ *		could not be found.
  */
-static struct msc_window *msc_oldest_window(struct msc *msc)
+static struct msc_window *
+msc_find_window(struct msc *msc, struct sg_table *sgt, bool nonempty)
 {
-	struct msc_window *win, *next = msc_next_window(msc->cur_win);
+	struct msc_window *win;
 	unsigned int found = 0;
 
 	if (list_empty(&msc->win_list))
 		return NULL;
 
+	if (!sgt) {
+		if (!nonempty)
+			return msc->cur_win;
+
+		sgt = msc->cur_win->sgt;
+	}
+
 	/*
 	 * we might need a radix tree for this, depending on how
 	 * many windows a typical user would allocate; ideally it's
 	 * something like 2, in which case we're good
 	 */
 	list_for_each_entry(win, &msc->win_list, entry) {
-		if (win == next)
+		if (win->sgt == sgt)
 			found++;
 
 		/* skip the empty ones */
-		if (msc_block_is_empty(msc_win_block(win, 0)))
+		if (nonempty && msc_block_is_empty(msc_win_block(win, 0)))
 			continue;
 
 		if (found)
 			return win;
 	}
 
+	return NULL;
+}
+
+/**
+ * msc_oldest_window() - locate the window with oldest data
+ * @msc:	MSC device
+ *
+ * This should only be used in multiblock mode. Caller should hold the
+ * msc::user_count reference.
+ *
+ * Return:	the oldest window with valid data
+ */
+static struct msc_window *msc_oldest_window(struct msc *msc)
+{
+	struct msc_window *win;
+
+	if (list_empty(&msc->win_list))
+		return NULL;
+
+	win = msc_find_window(msc, msc_next_window(msc->cur_win)->sgt, true);
+	if (win)
+		return win;
+
 	return list_first_entry(&msc->win_list, struct msc_window, entry);
 }
 
+static size_t msc_win_total_sz(struct msc_window *win)
+{
+	unsigned int blk;
+	size_t size = 0;
+
+	for (blk = 0; blk < win->nr_blocks; blk++) {
+		struct msc_block_desc *bdesc = msc_win_block(win, blk);
+
+		if (msc_block_wrapped(bdesc))
+			return win->nr_pages << PAGE_SHIFT;
+
+		size += msc_total_sz(bdesc);
+		if (msc_block_last_written(bdesc))
+			break;
+	}
+
+	return size;
+}
+
+static unsigned int msc_win_newest_block(struct msc_window *win)
+{
+	unsigned int blk;
+
+	for (blk = 0; blk < win->nr_blocks; blk++) {
+		struct msc_block_desc *bdesc = msc_win_block(win, blk);
+
+		if (msc_block_last_written(bdesc))
+			return blk;
+	}
+
+	return 0;
+}
+
 /**
  * msc_win_oldest_block() - locate the oldest block in a given window
  * @win:	window to look at
@@ -231,7 +408,6 @@ static struct msc_window *msc_oldest_window(struct msc *msc)
  */
 static unsigned int msc_win_oldest_block(struct msc_window *win)
 {
-	unsigned int blk;
 	struct msc_block_desc *bdesc = msc_win_block(win, 0);
 
 	/* without wrapping, first block is the oldest */
@@ -242,14 +418,7 @@ static unsigned int msc_win_oldest_block(struct msc_window *win)
 	 * with wrapping, last written block contains both the newest and the
 	 * oldest data for this window.
 	 */
-	for (blk = 0; blk < win->nr_blocks; blk++) {
-		bdesc = msc_win_block(win, blk);
-
-		if (msc_block_last_written(bdesc))
-			return blk;
-	}
-
-	return 0;
+	return msc_win_newest_block(win);
 }
 
 static struct msc_block_desc *msc_iter_bdesc(struct msc_iter *iter)
@@ -501,6 +670,9 @@ static int intel_th_msu_init(struct msc *msc)
 	if (!msc->do_irq)
 		return 0;
 
+	if (!msc->bdrv)
+		return 0;
+
 	mintctl = ioread32(msc->msu_base + REG_MSU_MINTCTL);
 	mintctl |= msc->index ? M1BLIE : M0BLIE;
 	iowrite32(mintctl, msc->msu_base + REG_MSU_MINTCTL);
@@ -528,6 +700,27 @@ static void intel_th_msu_deinit(struct msc *msc)
 	iowrite32(mintctl, msc->msu_base + REG_MSU_MINTCTL);
 }
 
+static int msc_win_set_lockout(struct msc_window *win, int expect, int new)
+{
+	int old;
+
+	if (!win->msc->bdrv)
+		return 0;
+
+	old = atomic_cmpxchg(&win->lockout, expect, new);
+	if (expect == WIN_READY && old == WIN_LOCKED)
+		return -EBUSY;
+
+	/* from intel_th_msc_window_unlock(), don't warn if not locked */
+	if (expect == WIN_LOCKED && old == new)
+		return 0;
+
+	if (WARN_ONCE(old != expect, "expected lockout state %d, got %d\n",
+		      expect, old))
+		return -EINVAL;
+
+	return 0;
+}
 /**
  * msc_configure() - set up MSC hardware
  * @msc:	the MSC device to configure
@@ -545,8 +738,16 @@ static int msc_configure(struct msc *msc)
 	if (msc->mode > MSC_MODE_MULTI)
 		return -ENOTSUPP;
 
-	if (msc->mode == MSC_MODE_MULTI)
+	if (msc->mode == MSC_MODE_MULTI) {
+		/* Window allocation path makes sure this doesn't happen */
+		if (WARN_ON_ONCE(!msc->cur_win))
+			return -EINVAL;
+
+		if (msc_win_set_lockout(msc->cur_win, WIN_READY, WIN_INUSE))
+			return -EBUSY;
+
 		msc_buffer_clear_hw_header(msc);
+	}
 
 	reg = msc->base_addr >> PAGE_SHIFT;
 	iowrite32(reg, msc->reg_base + REG_MSU_MSC0BAR);
@@ -568,10 +769,14 @@ static int msc_configure(struct msc *msc)
 
 	iowrite32(reg, msc->reg_base + REG_MSU_MSC0CTL);
 
+	intel_th_msu_init(msc);
+
 	msc->thdev->output.multiblock = msc->mode == MSC_MODE_MULTI;
 	intel_th_trace_enable(msc->thdev);
 	msc->enabled = 1;
 
+	if (msc->bdrv && msc->bdrv->activate)
+		msc->bdrv->activate(msc->bdrv_priv);
 
 	return 0;
 }
@@ -585,10 +790,17 @@ static int msc_configure(struct msc *msc)
  */
 static void msc_disable(struct msc *msc)
 {
+	struct msc_window *win = msc->cur_win;
 	u32 reg;
 
 	lockdep_assert_held(&msc->buf_mutex);
 
+	if (msc->mode == MSC_MODE_MULTI)
+		msc_win_set_lockout(win, WIN_INUSE, WIN_LOCKED);
+
+	if (msc->bdrv && msc->bdrv->deactivate)
+		msc->bdrv->deactivate(msc->bdrv_priv);
+	intel_th_msu_deinit(msc);
 	intel_th_trace_disable(msc->thdev);
 
 	if (msc->mode == MSC_MODE_SINGLE) {
@@ -604,6 +816,11 @@ static void msc_disable(struct msc *msc)
 	reg = ioread32(msc->reg_base + REG_MSU_MSC0CTL);
 	reg &= ~MSC_EN;
 	iowrite32(reg, msc->reg_base + REG_MSU_MSC0CTL);
+
+	if (msc->bdrv && msc->bdrv->ready)
+		msc->bdrv->ready(msc->bdrv_priv, win->sgt,
+				 msc_win_total_sz(win));
+
 	msc->enabled = 0;
 
 	iowrite32(0, msc->reg_base + REG_MSU_MSC0BAR);
@@ -614,6 +831,11 @@ static void msc_disable(struct msc *msc)
 
 	reg = ioread32(msc->reg_base + REG_MSU_MSC0STS);
 	dev_dbg(msc_dev(msc), "MSCnSTS: %08x\n", reg);
+
+	reg = ioread32(msc->reg_base + REG_MSU_MSUSTS);
+	reg &= msc->index ? MSUSTS_MSC1BLAST : MSUSTS_MSC0BLAST;
+	iowrite32(reg, msc->reg_base + REG_MSU_MSUSTS);
+	dev_dbg(msc_dev(msc), "MSUSTS: %08x\n", reg);
 }
 
 static int intel_th_msc_activate(struct intel_th_device *thdev)
@@ -748,11 +970,11 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 	void *block;
 	int i, ret;
 
-	ret = sg_alloc_table(&win->sgt, nr_blocks, GFP_KERNEL);
+	ret = sg_alloc_table(win->sgt, nr_blocks, GFP_KERNEL);
 	if (ret)
 		return -ENOMEM;
 
-	for_each_sg(win->sgt.sgl, sg_ptr, nr_blocks, i) {
+	for_each_sg(win->sgt->sgl, sg_ptr, nr_blocks, i) {
 		block = dma_alloc_coherent(msc_dev(win->msc)->parent->parent,
 					  PAGE_SIZE, &sg_dma_address(sg_ptr),
 					  GFP_KERNEL);
@@ -770,7 +992,7 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 				  msc_win_block(win, i),
 				  msc_win_baddr(win, i));
 
-	sg_free_table(&win->sgt);
+	sg_free_table(win->sgt);
 
 	return -ENOMEM;
 }
@@ -805,6 +1027,7 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_pages)
 		return -ENOMEM;
 
 	win->msc = msc;
+	win->sgt = &win->_sgt;
 
 	if (!list_empty(&msc->win_list)) {
 		struct msc_window *prev = list_last_entry(&msc->win_list,
@@ -814,8 +1037,13 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_pages)
 		win->pgoff = prev->pgoff + prev->nr_pages;
 	}
 
-	ret = __msc_buffer_win_alloc(win, nr_pages);
-	if (ret < 0)
+	if (msc->bdrv && msc->bdrv->alloc_window)
+		ret = msc->bdrv->alloc_window(msc->bdrv_priv, &win->sgt,
+					      nr_pages << PAGE_SHIFT);
+	else
+		ret = __msc_buffer_win_alloc(win, nr_pages);
+
+	if (ret <= 0)
 		goto err_nomem;
 
 #ifdef CONFIG_X86
@@ -826,6 +1054,7 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_pages)
 
 	win->nr_blocks = ret;
 	win->nr_pages = nr_pages;
+	atomic_set(&win->lockout, WIN_READY);
 
 	if (list_empty(&msc->win_list)) {
 		msc->base = msc_win_block(win, 0);
@@ -849,13 +1078,13 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 	int i;
 
 	for (i = 0; i < win->nr_blocks; i++) {
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
@@ -884,7 +1113,10 @@ static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 		set_memory_wb((unsigned long)msc_win_block(win, i), 1);
 #endif
 
-	__msc_buffer_win_free(msc, win);
+	if (msc->bdrv && msc->bdrv->free_window)
+		msc->bdrv->free_window(msc->bdrv_priv, win->sgt);
+	else
+		__msc_buffer_win_free(msc, win);
 
 	kfree(win);
 }
@@ -1110,8 +1342,8 @@ static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 	pgoff -= win->pgoff;
 
 	for (blk = 0; blk < win->nr_blocks; blk++) {
-		struct page *page = sg_page(&win->sgt.sgl[blk]);
-		size_t pgsz = win->sgt.sgl[blk].length >> PAGE_SHIFT;
+		struct page *page = sg_page(&win->sgt->sgl[blk]);
+		size_t pgsz = win->sgt->sgl[blk].length >> PAGE_SHIFT;
 
 		if (pgoff < pgsz)
 			return page + pgoff;
@@ -1422,18 +1654,77 @@ static void msc_win_switch(struct msc *msc)
 	intel_th_trace_switch(msc->thdev);
 }
 
+/*
+ * @dev:	MSC device to which this relates
+ * @sgt:	window
+ */
+void intel_th_msc_window_unlock(struct device *dev, struct sg_table *sgt)
+{
+	struct msc *msc = dev_get_drvdata(dev);
+	struct msc_window *win = msc_find_window(msc, sgt, false);
+
+	if (!win)
+		return;
+
+	msc_win_set_lockout(win, WIN_LOCKED, WIN_READY);
+}
+EXPORT_SYMBOL_GPL(intel_th_msc_window_unlock);
+
+static void msc_work(struct work_struct *work)
+{
+	struct msc *msc = container_of(work, struct msc, work);
+
+	intel_th_msc_deactivate(msc->thdev);
+}
+
 static irqreturn_t intel_th_msc_interrupt(struct intel_th_device *thdev)
 {
 	struct msc *msc = dev_get_drvdata(&thdev->dev);
 	u32 msusts = ioread32(msc->msu_base + REG_MSU_MSUSTS);
 	u32 mask = msc->index ? MSUSTS_MSC1BLAST : MSUSTS_MSC0BLAST;
+	struct msc_window *win, *next_win;
+
+	if (!msc->do_irq || !msc->bdrv)
+		return IRQ_NONE;
 
 	if (!(msusts & mask)) {
 		if (msc->enabled)
-			return IRQ_HANDLED;
+			goto ack;
 		return IRQ_NONE;
 	}
 
+	msusts &= mask;
+
+	iowrite32(msusts, msc->msu_base + REG_MSU_MSUSTS);
+
+	if (!msc->enabled)
+		return IRQ_NONE;
+
+	/* grab the window before we do the switch */
+	win = msc->cur_win;
+	if (WARN_ON_ONCE(!win))
+		goto ack;
+	next_win = msc_next_window(win);
+	if (WARN_ON_ONCE(!next_win))
+		goto ack;
+
+	/* next window: if READY, proceed, if LOCKED, stop the trace */
+	if (msc_win_set_lockout(next_win, WIN_READY, WIN_INUSE)) {
+		schedule_work(&msc->work);
+		goto ack;
+	}
+
+	/* current window: INUSE -> LOCKED */
+	msc_win_set_lockout(win, WIN_INUSE, WIN_LOCKED);
+
+	msc_win_switch(msc);
+
+	if (msc->bdrv && msc->bdrv->ready)
+		msc->bdrv->ready(msc->bdrv_priv, win->sgt,
+				 msc_win_total_sz(win));
+ack:
+	iowrite32(msusts & mask, msc->msu_base + REG_MSU_MSUSTS);
+
 	return IRQ_HANDLED;
 }
 
@@ -1471,21 +1762,43 @@ wrap_store(struct device *dev, struct device_attribute *attr, const char *buf,
 
 static DEVICE_ATTR_RW(wrap);
 
+static void msc_buffer_unassign(struct msc *msc)
+{
+	lockdep_assert_held(&msc->buf_mutex);
+
+	if (!msc->bdrv)
+		return;
+
+	msc->bdrv->unassign(msc->bdrv_priv);
+	module_put(msc->bdrv->owner);
+	msc->bdrv_priv = NULL;
+	msc->bdrv = NULL;
+}
+
 static ssize_t
 mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct msc *msc = dev_get_drvdata(dev);
+	const char *mode = msc_mode[msc->mode];
+	ssize_t ret;
+
+	mutex_lock(&msc->buf_mutex);
+	if (msc->bdrv)
+		mode = msc->bdrv->name;
+	ret = scnprintf(buf, PAGE_SIZE, "%s\n", mode);
+	mutex_unlock(&msc->buf_mutex);
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", msc_mode[msc->mode]);
+	return ret;
 }
 
 static ssize_t
 mode_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	   size_t size)
 {
+	const struct msu_buffer_driver *bdrv = NULL;
 	struct msc *msc = dev_get_drvdata(dev);
 	size_t len = size;
-	char *cp;
+	char *cp, *mode;
 	int i, ret;
 
 	if (!capable(CAP_SYS_RAWIO))
@@ -1495,17 +1808,57 @@ mode_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	if (cp)
 		len = cp - buf;
 
+	mode = kstrndup(buf, len, GFP_KERNEL);
 	for (i = 0; i < ARRAY_SIZE(msc_mode); i++)
-		if (!strncmp(msc_mode[i], buf, len))
+		if (!strcmp(msc_mode[i], mode))
 			goto found;
 
+	/* Buffer drivers only work with a usable IRQ */
+	if (!msc->do_irq) {
+		kfree(mode);
+		return -EINVAL;
+	}
+
+	bdrv = msu_buffer_driver_get(mode);
+	kfree(mode);
+	if (bdrv)
+		goto found;
+
 	return -EINVAL;
 
 found:
 	mutex_lock(&msc->buf_mutex);
+	ret = 0;
+	if (bdrv && bdrv == msc->bdrv) {
+		/* matches try_module_get() in  msu_buffer_driver_get() */
+		module_put(bdrv->owner);
+		goto unlock;
+	}
+
 	ret = msc_buffer_unlocked_free_unless_used(msc);
-	if (!ret)
-		msc->mode = i;
+	if (ret)
+		goto unlock;
+
+	if (bdrv) {
+		void *bdrv_priv = bdrv->assign(dev, &i);
+
+		if (!bdrv_priv) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+
+		msc_buffer_unassign(msc);
+		msc->bdrv_priv = bdrv_priv;
+		msc->bdrv = bdrv;
+	} else {
+		msc_buffer_unassign(msc);
+	}
+
+	msc->mode = i;
+
+unlock:
+	if (ret && bdrv)
+		module_put(bdrv->owner);
 	mutex_unlock(&msc->buf_mutex);
 
 	return ret ? ret : size;
@@ -1627,7 +1980,12 @@ win_switch_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	mutex_lock(&msc->buf_mutex);
-	if (msc->mode != MSC_MODE_MULTI)
+	/*
+	 * Window switch can only happen in the "multi" mode.
+	 * If a buffer driver is engaged, they have the full
+	 * control over window switching.
+	 */
+	if (msc->mode != MSC_MODE_MULTI || msc->bdrv)
 		ret = -ENOTSUPP;
 	else
 		msc_win_switch(msc);
@@ -1680,10 +2038,7 @@ static int intel_th_msc_probe(struct intel_th_device *thdev)
 	msc->reg_base = base + msc->index * 0x100;
 	msc->msu_base = base;
 
-	err = intel_th_msu_init(msc);
-	if (err)
-		return err;
-
+	INIT_WORK(&msc->work, msc_work);
 	err = intel_th_msc_init(msc);
 	if (err)
 		return err;
@@ -1699,7 +2054,6 @@ static void intel_th_msc_remove(struct intel_th_device *thdev)
 	int ret;
 
 	intel_th_msc_deactivate(thdev);
-	intel_th_msu_deinit(msc);
 
 	/*
 	 * Buffers should not be used at this point except if the
diff --git a/drivers/hwtracing/intel_th/msu.h b/drivers/hwtracing/intel_th/msu.h
index 574c16004cb2..acd808e316f9 100644
--- a/drivers/hwtracing/intel_th/msu.h
+++ b/drivers/hwtracing/intel_th/msu.h
@@ -44,14 +44,6 @@ enum {
 #define M0BLIE		BIT(16)
 #define M1BLIE		BIT(24)
 
-/* MSC operating modes (MSC_MODE) */
-enum {
-	MSC_MODE_SINGLE	= 0,
-	MSC_MODE_MULTI,
-	MSC_MODE_EXI,
-	MSC_MODE_DEBUG,
-};
-
 /* MSCnSTS bits */
 #define MSCSTS_WRAPSTAT	BIT(1)	/* Wrap occurred */
 #define MSCSTS_PLE	BIT(2)	/* Pipeline Empty */
@@ -93,6 +85,19 @@ static inline unsigned long msc_data_sz(struct msc_block_desc *bdesc)
 	return bdesc->valid_dw * 4 - MSC_BDESC;
 }
 
+static inline unsigned long msc_total_sz(struct msc_block_desc *bdesc)
+{
+	if (!bdesc->valid_dw)
+		return 0;
+
+	return bdesc->valid_dw * 4;
+}
+
+static inline unsigned long msc_block_sz(struct msc_block_desc *bdesc)
+{
+	return bdesc->block_sz * 64 - MSC_BDESC;
+}
+
 static inline bool msc_block_wrapped(struct msc_block_desc *bdesc)
 {
 	if (bdesc->hw_tag & (MSC_HW_TAG_BLOCKWRAP | MSC_HW_TAG_WINWRAP))
@@ -104,7 +109,7 @@ static inline bool msc_block_wrapped(struct msc_block_desc *bdesc)
 static inline bool msc_block_last_written(struct msc_block_desc *bdesc)
 {
 	if ((bdesc->hw_tag & MSC_HW_TAG_ENDBIT) ||
-	    (msc_data_sz(bdesc) != DATA_IN_PAGE))
+	    (msc_data_sz(bdesc) != msc_block_sz(bdesc)))
 		return true;
 
 	return false;
diff --git a/include/linux/intel_th.h b/include/linux/intel_th.h
new file mode 100644
index 000000000000..b00b7e1254d9
--- /dev/null
+++ b/include/linux/intel_th.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel(R) Trace Hub data structures for implementing buffer drivers.
+ *
+ * Copyright (C) 2019 Intel Corporation.
+ */
+
+#ifndef _INTEL_TH_H_
+#define _INTEL_TH_H_
+
+#include <linux/scatterlist.h>
+
+/* MSC operating modes (MSC_MODE) */
+enum {
+	MSC_MODE_SINGLE	= 0,
+	MSC_MODE_MULTI,
+	MSC_MODE_EXI,
+	MSC_MODE_DEBUG,
+};
+
+struct msu_buffer_driver {
+	const char	*name;
+	struct module	*owner;
+	/*
+	 * ->assign() called when buffer 'mode' is set to this driver
+	 *   (aka mode_store())
+	 * @device:	struct device * of the msc
+	 * @mode:	allows the driver to set HW mode (see the enum above)
+	 * Returns:	a pointer to a private structure associated with this
+	 *		msc or NULL in case of error. This private structure
+	 *		will then be passed into all other callbacks.
+	 */
+	void	*(*assign)(struct device *dev, int *mode);
+	/* ->unassign():	some other mode is selected, clean up */
+	void	(*unassign)(void *priv);
+	/*
+	 * ->alloc_window(): allocate memory for the window of a given
+	 *		size
+	 * @sgt:	pointer to sg_table, can be overridden by the buffer
+	 *		driver, or kept intact
+	 * Returns:	number of sg table entries <= number of pages;
+	 *		0 is treated as an allocation failure.
+	 */
+	int	(*alloc_window)(void *priv, struct sg_table **sgt,
+				size_t size);
+	void	(*free_window)(void *priv, struct sg_table *sgt);
+	/* ->activate():	trace has started */
+	void	(*activate)(void *priv);
+	/* ->deactivate():	trace is about to stop */
+	void	(*deactivate)(void *priv);
+	/*
+	 * ->ready():	window @sgt is filled up to the last block OR
+	 *		tracing is stopped by the user; this window contains
+	 *		@bytes data. The window in question transitions into
+	 *		the "LOCKED" state, indicating that it can't be used
+	 *		by hardware. To clear this state and make the window
+	 *		available to the hardware again, call
+	 *		intel_th_msc_window_unlock().
+	 */
+	int	(*ready)(void *priv, struct sg_table *sgt, size_t bytes);
+};
+
+int intel_th_msu_buffer_register(const struct msu_buffer_driver *bdrv);
+void intel_th_msu_buffer_unregister(const struct msu_buffer_driver *bdrv);
+void intel_th_msc_window_unlock(struct device *dev, struct sg_table *sgt);
+
+#endif /* _INTEL_TH_H_ */
-- 
2.20.1

