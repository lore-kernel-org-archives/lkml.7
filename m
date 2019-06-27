Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044BFC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DB82085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfF0MwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:52:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:36562 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbfF0MwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:52:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 05:52:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="245805980"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2019 05:52:05 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 4/9] intel_th: msu: Start read iterator from a non-empty window
Date:   Thu, 27 Jun 2019 15:51:47 +0300
Message-Id: <20190627125152.54905-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multi-window mode, the read iterator is supposed to start from the
window with the oldest data, which is, chronologically, the next window
after the one with the newest data. This, however, fails to take into
account the potentially empty windows, so in short trace sessions it's
possible to have a lot of zeroes read from the character device first.

Fix this by skipping over the empty windows in initialization of the
read iterator.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 42 +++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 8efd2510192f..59a596911e54 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -189,17 +189,18 @@ static struct msc_window *msc_next_window(struct msc_window *win)
 }
 
 /**
- * msc_oldest_window() - locate the window with oldest data
+ * msc_find_window() - find a window matching a given sg_table
  * @msc:	MSC device
+ * @sgt:	SG table of the window
+ * @nonempty:	skip over empty windows
  *
- * This should only be used in multiblock mode. Caller should hold the
- * msc::user_count reference.
- *
- * Return:	the oldest window with valid data
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
@@ -211,17 +212,40 @@ static struct msc_window *msc_oldest_window(struct msc *msc)
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
 
-- 
2.20.1

