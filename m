Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CB0C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D02B222CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfIZIlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:41:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2787 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbfIZIlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:41:25 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48A8CE50F4E61526E17C;
        Thu, 26 Sep 2019 16:41:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 16:41:18 +0800
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        <bvanassche@acm.org>, <bhelgaas@google.com>, <dsterba@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        <sakari.ailus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] async: Using current_work() to implement current_is_async()
Message-ID: <395617ec-ef92-c20f-d5c1-550b47a07f6d@huawei.com>
Date:   Thu, 26 Sep 2019 16:40:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current_is_async() can be implemented using current_work(), it's better
not to be aware of the workqueue's internal information.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/async.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/async.c b/kernel/async.c
index 1de270d..a849f98 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -53,8 +53,6 @@ asynchronous and synchronous parts of the kernel.
 #include <linux/slab.h>
 #include <linux/workqueue.h>

-#include "workqueue_internal.h"
-
 static async_cookie_t next_cookie = 1;

 #define MAX_WORK		32768
@@ -327,8 +325,8 @@ EXPORT_SYMBOL_GPL(async_synchronize_cookie);
  */
 bool current_is_async(void)
 {
-	struct worker *worker = current_wq_worker();
+	struct work_struct *work = current_work();

-	return worker && worker->current_func == async_run_entry_fn;
+	return work && work->func == async_run_entry_fn;
 }
 EXPORT_SYMBOL_GPL(current_is_async);
-- 
2.7.4

