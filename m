Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95109C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E101208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfETG2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:28:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729725AbfETG2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:28:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CE9BFC881F498E87A3B8;
        Mon, 20 May 2019 14:28:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 May 2019 14:27:57 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH] intel_th: msu: Fix unused variable warning on arm64 platform
Date:   Mon, 20 May 2019 14:26:37 +0800
Message-ID: <1558333597-63774-1-git-send-email-zhangshaokun@hisilicon.com>
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
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/hwtracing/intel_th/msu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 81bb54fa3ce8..833a5a8f13ad 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -780,7 +780,10 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 {
 	struct msc_window *win;
-	int ret = -ENOMEM, i;
+	int ret = -ENOMEM;
+#ifdef CONFIG_X86
+	int i;
+#endif
 
 	if (!nr_blocks)
 		return 0;
@@ -860,7 +863,9 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
  */
 static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 {
+#ifdef CONFIG_X86
 	int i;
+#endif
 
 	msc->nr_pages -= win->nr_blocks;
 
-- 
2.7.4

