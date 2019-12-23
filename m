Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C633C2D0C8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D302053B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLWBt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:49:59 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:32910 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfLWBt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:49:58 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 6DB6E44C4802612FF7C7;
        Mon, 23 Dec 2019 09:49:55 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id xBN1nanf029636;
        Mon, 23 Dec 2019 09:49:36 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019122309493877-1467356 ;
          Mon, 23 Dec 2019 09:49:38 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     aryabinin@virtuozzo.com
Cc:     glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] lib: Use kzalloc() instead of kmalloc() with flag GFP_ZERO.
Date:   Mon, 23 Dec 2019 09:49:34 +0800
Message-Id: <1577065774-25142-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-12-23 09:49:38,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-12-23 09:49:37,
        Serialize complete at 2019-12-23 09:49:37
X-MAIL: mse-fl2.zte.com.cn xBN1nanf029636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Zijiang <huang.zijiang@zte.com.cn>

Use kzalloc instead of manually setting kmalloc
with flag GFP_ZERO since kzalloc sets allocated memory
to zero.

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 lib/test_kasan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 05686c8..ff5d21e 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -598,7 +598,7 @@ static noinline void __init kasan_memchr(void)
     size_t size = 24;
 
     pr_info("out-of-bounds in memchr\n");
-    ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+ptr = kzalloc(size, GFP_KERNEL);
     if (!ptr)
         return;
 
@@ -613,7 +613,7 @@ static noinline void __init kasan_memcmp(void)
     int arr[9];
 
     pr_info("out-of-bounds in memcmp\n");
-    ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+ptr = kzalloc(size, GFP_KERNEL);
     if (!ptr)
         return;
 
@@ -628,7 +628,7 @@ static noinline void __init kasan_strings(void)
     size_t size = 24;
 
     pr_info("use-after-free in strchr\n");
-    ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+ptr = kzalloc(size, GFP_KERNEL);
     if (!ptr)
         return;

-- 
1.9.1

