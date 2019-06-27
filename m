Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A9C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AACA2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfF0MwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:52:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:36562 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfF0MwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:52:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 05:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="245805951"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2019 05:52:00 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 1/9] intel_th: msu: Fix unused variable warning on arm64 platform
Date:   Thu, 27 Jun 2019 15:51:44 +0300
Message-Id: <20190627125152.54905-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

Commit ba39bd8306057 ("intel_th: msu: Switch over to scatterlist")
introduced the following warnings on non-x86 architectures, as a result
of reordering the multi mode buffer allocation sequence:

> drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_alloc’:
> drivers/hwtracing/intel_th/msu.c:783:21: warning: unused variable ‘i’
> [-Wunused-variable]
> int ret = -ENOMEM, i;
>                    ^
> drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_free’:
> drivers/hwtracing/intel_th/msu.c:863:6: warning: unused variable ‘i’
> [-Wunused-variable]
> int i;
>     ^

Fix this compiler warning by factoring out set_memory sequences and making
them x86-only.

Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Fixes: ba39bd8306057 ("intel_th: msu: Switch over to scatterlist")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 40 +++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 81bb54fa3ce8..8c568b5c8920 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -767,6 +767,30 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 	return -ENOMEM;
 }
 
+#ifdef CONFIG_X86
+static void msc_buffer_set_uc(struct msc_window *win, unsigned int nr_blocks)
+{
+	int i;
+
+	for (i = 0; i < nr_blocks; i++)
+		/* Set the page as uncached */
+		set_memory_uc((unsigned long)msc_win_block(win, i), 1);
+}
+
+static void msc_buffer_set_wb(struct msc_window *win)
+{
+	int i;
+
+	for (i = 0; i < win->nr_blocks; i++)
+		/* Reset the page to write-back */
+		set_memory_wb((unsigned long)msc_win_block(win, i), 1);
+}
+#else /* !X86 */
+static inline void
+msc_buffer_set_uc(struct msc_window *win, unsigned int nr_blocks) {}
+static inline void msc_buffer_set_wb(struct msc_window *win) {}
+#endif /* CONFIG_X86 */
+
 /**
  * msc_buffer_win_alloc() - alloc a window for a multiblock mode
  * @msc:	MSC device
@@ -780,7 +804,7 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 {
 	struct msc_window *win;
-	int ret = -ENOMEM, i;
+	int ret = -ENOMEM;
 
 	if (!nr_blocks)
 		return 0;
@@ -811,11 +835,7 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 	if (ret < 0)
 		goto err_nomem;
 
-#ifdef CONFIG_X86
-	for (i = 0; i < ret; i++)
-		/* Set the page as uncached */
-		set_memory_uc((unsigned long)msc_win_block(win, i), 1);
-#endif
+	msc_buffer_set_uc(win, ret);
 
 	win->nr_blocks = ret;
 
@@ -860,8 +880,6 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
  */
 static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 {
-	int i;
-
 	msc->nr_pages -= win->nr_blocks;
 
 	list_del(&win->entry);
@@ -870,11 +888,7 @@ static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 		msc->base_addr = 0;
 	}
 
-#ifdef CONFIG_X86
-	for (i = 0; i < win->nr_blocks; i++)
-		/* Reset the page to write-back */
-		set_memory_wb((unsigned long)msc_win_block(win, i), 1);
-#endif
+	msc_buffer_set_wb(win);
 
 	__msc_buffer_win_free(msc, win);
 
-- 
2.20.1

