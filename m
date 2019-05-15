Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E032EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6892084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfEOOjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:39:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfEOOjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:39:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AF3D9B02FB4AF1FEF342;
        Wed, 15 May 2019 22:39:45 +0800 (CST)
Received: from huawei.com (10.184.227.228) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 May 2019
 22:39:37 +0800
From:   Wang Hai <wanghai26@huawei.com>
To:     <maximlevitsky@gmail.com>, <oakad@yahoo.com>,
        <ulf.hansson@linaro.org>, <kai.heng.feng@canonical.com>
CC:     <wanghai26@huawei.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] memstick: Fix error cleanup path of memstick_init
Date:   Wed, 15 May 2019 22:37:25 +0800
Message-ID: <20190515143725.18872-1-wanghai26@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.227.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bus_register fails. On its error handling path, it has cleaned up
what it has done. There is no need to call bus_unregister again.
Otherwise, if bus_unregister is called, issues such as null-ptr-deref
will arise.

Syzkaller report this:

kobject_add_internal failed for memstick (error: -12 parent: bus)
BUG: KASAN: null-ptr-deref in sysfs_remove_file_ns+0x1b/0x40 fs/sysfs/file.c:467
Read of size 8 at addr 0000000000000078 by task syz-executor.0/4460

Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xa9/0x10e lib/dump_stack.c:113
 __kasan_report+0x171/0x18d mm/kasan/report.c:321
 kasan_report+0xe/0x20 mm/kasan/common.c:614
 sysfs_remove_file_ns+0x1b/0x40 fs/sysfs/file.c:467
 sysfs_remove_file include/linux/sysfs.h:519 [inline]
 bus_remove_file+0x6c/0x90 drivers/base/bus.c:145
 remove_probe_files drivers/base/bus.c:599 [inline]
 bus_unregister+0x6e/0x100 drivers/base/bus.c:916 ? 0xffffffffc1590000
 memstick_init+0x7a/0x1000 [memstick]
 do_one_initcall+0xb9/0x3b5 init/main.c:914
 do_init_module+0xe0/0x330 kernel/module.c:3468
 load_module+0x38eb/0x4270 kernel/module.c:3819
 __do_sys_finit_module+0x162/0x190 kernel/module.c:3909
 do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai26@huawei.com>
---
 drivers/memstick/core/memstick.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 1246d69ba187..b1564cacd19e 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -629,13 +629,18 @@ static int __init memstick_init(void)
 		return -ENOMEM;
 
 	rc = bus_register(&memstick_bus_type);
-	if (!rc)
-		rc = class_register(&memstick_host_class);
+	if (rc)
+		goto error_destroy_workqueue;
 
-	if (!rc)
-		return 0;
+	rc = class_register(&memstick_host_class);
+	if (rc)
+		goto error_bus_unregister;
+
+	return 0;
 
+error_bus_unregister:
 	bus_unregister(&memstick_bus_type);
+error_destroy_workqueue:
 	destroy_workqueue(workqueue);
 
 	return rc;
-- 
2.17.1


