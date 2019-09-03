Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2943AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E052053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfICHiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:38:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbfICHir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:38:47 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3E0813730EF591927676;
        Tue,  3 Sep 2019 15:38:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 15:38:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jannh@google.com>, <axboe@kernel.dk>, <dhowells@redhat.com>,
        <james.morris@microsoft.com>, <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] misc: watch_queue: Fix build error
Date:   Tue, 3 Sep 2019 15:37:26 +0800
Message-ID: <20190903073726.21880-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/misc/watch_queue.c: In function watch_queue_account_mem:
drivers/misc/watch_queue.c:309:38: error: struct user_struct has no member named locked_vm; did you mean locked_shm?
  cur_pages = atomic_long_read(&user->locked_vm);
                                      ^~~~~~~~~
                                      locked_shm

struct user_struct {
...
   #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
       defined(CONFIG_NET) || defined(CONFIG_IO_URING)
           atomic_long_t locked_vm;
   #endif
...
}

If none of the CONFIGS is defined, locked_vm will be unavailable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 064756fb355a ("General notification queue with user mmap()'able ring buffer")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/sched/user.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 917d88e..126494d 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -33,7 +33,8 @@ struct user_struct {
 	kuid_t uid;
 
 #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
-    defined(CONFIG_NET) || defined(CONFIG_IO_URING)
+	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
+	defined(CONFIG_WATCH_QUEUE)
 	atomic_long_t locked_vm;
 #endif
 
-- 
2.7.4


