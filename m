Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3435C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C402081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbfETLec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:34:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727626AbfETLeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:34:31 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 711B07BA39250D23F014;
        Mon, 20 May 2019 19:34:29 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 May 2019 19:34:19 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] intel_th: msu: Fix unused variable warning on arm64 platform
Date:   Mon, 20 May 2019 19:32:53 +0800
Message-ID: <1558351973-62643-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_alloc’:
drivers/hwtracing/intel_th/msu.c:783:21: warning: unused variable ‘i’ [-Wunused-variable]
  int ret = -ENOMEM, i;
                     ^
drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_free’:
drivers/hwtracing/intel_th/msu.c:863:6: warning: unused variable ‘i’ [-Wunused-variable]
  int i;
      ^
Fix this compiler warning on arm64 platform.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/hwtracing/intel_th/msu.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 81bb54fa3ce8..49e64ca760e6 100644
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
+static inline void msc_buffer_set_uc(struct msc_window *win,
+				     unsigned int nr_blocks) {}
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
2.7.4

