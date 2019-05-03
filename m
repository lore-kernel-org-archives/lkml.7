Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC90C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324CE2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfECIpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:5545 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfECIpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811602"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:48 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 18/22] intel_th: msu: Add current window tracking
Date:   Fri,  3 May 2019 11:44:51 +0300
Message-Id: <20190503084455.23436-19-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a way to switch between MSC buffer windows, add code to
track the current window. The hardware register NWSA that contains the
address of the next window is unfortunately not always usable, and since
the driver has full control of the window switching, there is no reason
not to keep this on the software side.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 79 ++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 089fd1f90a9f..2916de5651aa 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -77,6 +77,7 @@ struct msc_iter {
  * @thdev:		intel_th_device pointer
  * @win_list:		list of windows in multiblock mode
  * @single_sgt:		single mode buffer
+ * @cur_win:		current window
  * @nr_pages:		total number of pages allocated for this buffer
  * @single_sz:		amount of data in single mode
  * @single_wrap:	single mode wrap occurred
@@ -99,6 +100,7 @@ struct msc {
 
 	struct list_head	win_list;
 	struct sg_table		single_sgt;
+	struct msc_window	*cur_win;
 	unsigned long		nr_pages;
 	unsigned long		single_sz;
 	unsigned int		single_wrap : 1;
@@ -159,6 +161,31 @@ msc_win_bpfn(struct msc_window *win, unsigned int block)
 	return msc_win_baddr(win, block) >> PAGE_SHIFT;
 }
 
+/**
+ * msc_is_last_win() - check if a window is the last one for a given MSC
+ * @win:	window
+ * Return:	true if @win is the last window in MSC's multiblock buffer
+ */
+static inline bool msc_is_last_win(struct msc_window *win)
+{
+	return win->entry.next == &win->msc->win_list;
+}
+
+/**
+ * msc_next_window() - return next window in the multiblock buffer
+ * @win:	current window
+ *
+ * Return:	window following the current one
+ */
+static struct msc_window *msc_next_window(struct msc_window *win)
+{
+	if (msc_is_last_win(win))
+		return list_first_entry(&win->msc->win_list, struct msc_window,
+					entry);
+
+	return list_next_entry(win, entry);
+}
+
 /**
  * msc_oldest_window() - locate the window with oldest data
  * @msc:	MSC device
@@ -170,9 +197,7 @@ msc_win_bpfn(struct msc_window *win, unsigned int block)
  */
 static struct msc_window *msc_oldest_window(struct msc *msc)
 {
-	struct msc_window *win;
-	u32 reg = ioread32(msc->reg_base + REG_MSU_MSC0NWSA);
-	unsigned long win_addr = (unsigned long)reg << PAGE_SHIFT;
+	struct msc_window *win, *next = msc_next_window(msc->cur_win);
 	unsigned int found = 0;
 
 	if (list_empty(&msc->win_list))
@@ -184,7 +209,7 @@ static struct msc_window *msc_oldest_window(struct msc *msc)
 	 * something like 2, in which case we're good
 	 */
 	list_for_each_entry(win, &msc->win_list, entry) {
-		if (sg_dma_address(win->sgt.sgl) == win_addr)
+		if (win == next)
 			found++;
 
 		/* skip the empty ones */
@@ -227,31 +252,6 @@ static unsigned int msc_win_oldest_block(struct msc_window *win)
 	return 0;
 }
 
-/**
- * msc_is_last_win() - check if a window is the last one for a given MSC
- * @win:	window
- * Return:	true if @win is the last window in MSC's multiblock buffer
- */
-static inline bool msc_is_last_win(struct msc_window *win)
-{
-	return win->entry.next == &win->msc->win_list;
-}
-
-/**
- * msc_next_window() - return next window in the multiblock buffer
- * @win:	current window
- *
- * Return:	window following the current one
- */
-static struct msc_window *msc_next_window(struct msc_window *win)
-{
-	if (msc_is_last_win(win))
-		return list_first_entry(&win->msc->win_list, struct msc_window,
-					entry);
-
-	return list_next_entry(win, entry);
-}
-
 static struct msc_block_desc *msc_iter_bdesc(struct msc_iter *iter)
 {
 	return msc_win_block(iter->win, iter->block);
@@ -830,6 +830,7 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_pages)
 	if (list_empty(&msc->win_list)) {
 		msc->base = msc_win_block(win, 0);
 		msc->base_addr = msc_win_baddr(win, 0);
+		msc->cur_win = win;
 	}
 
 	list_add_tail(&win->entry, &msc->win_list);
@@ -1403,6 +1404,24 @@ static int intel_th_msc_init(struct msc *msc)
 	return 0;
 }
 
+static void msc_win_switch(struct msc *msc)
+{
+	struct msc_window *last, *first;
+
+	first = list_first_entry(&msc->win_list, struct msc_window, entry);
+	last = list_last_entry(&msc->win_list, struct msc_window, entry);
+
+	if (msc_is_last_win(msc->cur_win))
+		msc->cur_win = first;
+	else
+		msc->cur_win = list_next_entry(msc->cur_win, entry);
+
+	msc->base = msc_win_block(msc->cur_win, 0);
+	msc->base_addr = msc_win_baddr(msc->cur_win, 0);
+
+	intel_th_trace_switch(msc->thdev);
+}
+
 static irqreturn_t intel_th_msc_interrupt(struct intel_th_device *thdev)
 {
 	struct msc *msc = dev_get_drvdata(&thdev->dev);
@@ -1611,7 +1630,7 @@ win_switch_store(struct device *dev, struct device_attribute *attr,
 	if (msc->mode != MSC_MODE_MULTI)
 		ret = -ENOTSUPP;
 	else
-		ret = intel_th_trace_switch(msc->thdev);
+		msc_win_switch(msc);
 	mutex_unlock(&msc->buf_mutex);
 
 	return ret ? ret : size;
-- 
2.20.1

