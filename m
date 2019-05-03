Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17ADC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFE42081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfECIpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:5536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfECIpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811566"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:34 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 10/22] intel_th: msu: Replace open-coded list_{first,last,next}_entry variants
Date:   Fri,  3 May 2019 11:44:43 +0300
Message-Id: <20190503084455.23436-11-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few places in the code where open-coded versions of list entry
accessors list_first_entry()/list_last_entry()/list_next_entry() are used.

Replace those with the standard macros.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 3716d312a4ee..f5d5cb862a81 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -179,7 +179,7 @@ static struct msc_window *msc_oldest_window(struct msc *msc)
 			return win;
 	}
 
-	return list_entry(msc->win_list.next, struct msc_window, entry);
+	return list_first_entry(&msc->win_list, struct msc_window, entry);
 }
 
 /**
@@ -230,10 +230,10 @@ static inline bool msc_is_last_win(struct msc_window *win)
 static struct msc_window *msc_next_window(struct msc_window *win)
 {
 	if (msc_is_last_win(win))
-		return list_entry(win->msc->win_list.next, struct msc_window,
-				  entry);
+		return list_first_entry(&win->msc->win_list, struct msc_window,
+					entry);
 
-	return list_entry(win->entry.next, struct msc_window, entry);
+	return list_next_entry(win, entry);
 }
 
 static struct msc_block_desc *msc_iter_bdesc(struct msc_iter *iter)
@@ -759,8 +759,9 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 		return -ENOMEM;
 
 	if (!list_empty(&msc->win_list)) {
-		struct msc_window *prev = list_entry(msc->win_list.prev,
-						     struct msc_window, entry);
+		struct msc_window *prev = list_last_entry(&msc->win_list,
+							  struct msc_window,
+							  entry);
 
 		win->pgoff = prev->pgoff + prev->nr_blocks;
 	}
@@ -863,11 +864,10 @@ static void msc_buffer_relink(struct msc *msc)
 		 */
 		if (msc_is_last_win(win)) {
 			sw_tag |= MSC_SW_TAG_LASTWIN;
-			next_win = list_entry(msc->win_list.next,
-					      struct msc_window, entry);
+			next_win = list_first_entry(&msc->win_list,
+						    struct msc_window, entry);
 		} else {
-			next_win = list_entry(win->entry.next,
-					      struct msc_window, entry);
+			next_win = list_next_entry(win, entry);
 		}
 
 		for (blk = 0; blk < win->nr_blocks; blk++) {
-- 
2.20.1

