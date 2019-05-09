Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E4AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492BC20989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEIPQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:16:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbfEIPQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:16:19 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F276B41CE563CF9AD641;
        Thu,  9 May 2019 23:16:08 +0800 (CST)
Received: from huawei.com (10.184.227.228) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 May 2019
 23:16:01 +0800
From:   Wang Hai <wanghai26@huawei.com>
To:     <alexander.shishkin@linux.intel.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghai26@huawei.com>
Subject: [PATCH] stm class: fix possible double-free in stm_source_register_device()
Date:   Thu, 9 May 2019 23:14:24 +0800
Message-ID: <20190509151424.31612-1-wanghai26@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.227.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller report this:

BUG: KASAN: double-free or invalid-free in stm_source_register_device+0x137/0x2b0 [stm_core]

CPU: 1 PID: 6763 Comm: syz-executor.0 Tainted: G         C        5.0.0+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xa9/0x10e lib/dump_stack.c:113
 print_address_description+0x65/0x270 mm/kasan/report.c:187
 kasan_report_invalid_free+0x60/0xa0 mm/kasan/report.c:278
 __kasan_slab_free+0x159/0x180 mm/kasan/common.c:438
 slab_free_hook mm/slub.c:1429 [inline]
 slab_free_freelist_hook mm/slub.c:1456 [inline]
 slab_free mm/slub.c:3003 [inline]
 kfree+0xe1/0x270 mm/slub.c:3955
 stm_source_register_device+0x137/0x2b0 [stm_core]
 do_one_initcall+0xbc/0x47d init/main.c:887
 do_init_module+0x1b5/0x547 kernel/module.c:3456
 load_module+0x6405/0x8c10 kernel/module.c:3804
 __do_sys_finit_module+0x162/0x190 kernel/module.c:3898
 do_syscall_64+0x9f/0x450 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Allocated by task 6763:
 set_track mm/kasan/common.c:87 [inline]
 __kasan_kmalloc.constprop.3+0xa0/0xd0 mm/kasan/common.c:497
 stm_source_register_device+0x5c/0x2b0 [stm_core]
 do_one_initcall+0xbc/0x47d init/main.c:887
 do_init_module+0x1b5/0x547 kernel/module.c:3456
 load_module+0x6405/0x8c10 kernel/module.c:3804
 __do_sys_finit_module+0x162/0x190 kernel/module.c:3898
 do_syscall_64+0x9f/0x450 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 6763:
 set_track mm/kasan/common.c:87 [inline]
 __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
 slab_free_hook mm/slub.c:1429 [inline]
 slab_free_freelist_hook mm/slub.c:1456 [inline]
 slab_free mm/slub.c:3003 [inline]
 kfree+0xe1/0x270 mm/slub.c:3955
 device_release+0x78/0x200 drivers/base/core.c:1064
 kobject_cleanup lib/kobject.c:662 [inline]
 kobject_release lib/kobject.c:691 [inline]
 kref_put include/linux/kref.h:67 [inline]
 kobject_put+0x2a8/0x400 lib/kobject.c:708
 put_device+0x1c/0x30 drivers/base/core.c:2205
 stm_source_register_device+0x12f/0x2b0 [stm_core]
 do_one_initcall+0xbc/0x47d init/main.c:887
 do_init_module+0x1b5/0x547 kernel/module.c:3456
 load_module+0x6405/0x8c10 kernel/module.c:3804
 __do_sys_finit_module+0x162/0x190 kernel/module.c:3898
 do_syscall_64+0x9f/0x450 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

int stm_source_register_device(){
	...
    src->dev.release = stm_source_device_release;
	...
    err:
         put_device(&src->dev);
         kfree(src);

         return err;
}
In the error handling path of stm_source_register_device
Put_device() causes stm_source_device_release->kfree(src) to be
called. So calling kfree(src) again will cause double free

Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai26@huawei.com>
---
 drivers/hwtracing/stm/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index e55b902560de..181e7ff1ec4f 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -1276,7 +1276,6 @@ int stm_source_register_device(struct device *parent,
 
 err:
 	put_device(&src->dev);
-	kfree(src);
 
 	return err;
 }
-- 
2.17.1


