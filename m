Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13427C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 22:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB7820815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 22:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCCWAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 17:00:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40357 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfCCWAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 17:00:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id u9so1580672pgo.7;
        Sun, 03 Mar 2019 14:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOxcJj2JeDBzju7CadzruEc/ZHnJa/uKtghWKpZJdhI=;
        b=iSTxcJYrUTCKgqpgG3nl2EPC3+LV9Wn3ioH+LHKGrVNvT+eLm3R7CXjWhUYKVuGnwB
         X7z/fsTIJ1qTQ7YO028reQzVwc5gA0yj9DdlsKkDg4Kztq9G+Wcgm1zRl9qvGH8dkv5f
         TB1WvtnmJvdbSeF+N55HMxT2dhKcRPl0ZHDJwS9wtpEgyNSu+5nsoqv0txS6JTH/9uhJ
         7d+Sak7953IjZ8VDhqNKp8HAZNWtKUR8I9Cuv4YkLXAYIswRjfWP0L1Wj7fvp+smtT1r
         NeY9OYuZZryAHlPQrigtLUsHvmGWe0yTRvGHdhOrwBQZPU4JbhNXOyfGvkMewx7QwRYS
         y0oA==
X-Gm-Message-State: APjAAAUOE+FNQ9uykTZhfGS/E4l9/oMWq2+46ryFkWPRdq65yZxXTjbl
        tTp5RN/j2oHBb3LkaWxzaFs=
X-Google-Smtp-Source: APXvYqwFCpq0U4lf4zoebEobAKk50Db/gxITdBT0eqb+BrCa9Uzu5Bu7lur9ao1r4t6AMt9j+6xJoA==
X-Received: by 2002:a17:902:12e:: with SMTP id 43mr17178570plb.31.1551650454021;
        Sun, 03 Mar 2019 14:00:54 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id z12sm5294062pgv.0.2019.03.03.14.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 14:00:53 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        syzbot+17335689e239ce135d8b@syzkaller.appspotmail.com
Subject: [PATCH] kernel/wq: Fix a alloc_workqueue() error path
Date:   Sun,  3 Mar 2019 14:00:46 -0800
Message-Id: <20190303220046.29448-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a use-after-free and a memory leak in an alloc_workqueue()
error path. This patch avoids that e.g. the following complaint gets
reported:

BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:197 [inline]
BUG: KASAN: use-after-free in lockdep_register_key+0x3b9/0x490 kernel/locking/lockdep.c:1023
Read of size 8 at addr ffff888090fc2698 by task syz-executor134/7858

CPU: 1 PID: 7858 Comm: syz-executor134 Not tainted 5.0.0-rc8-next-20190301 #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x172/0x1f0 lib/dump_stack.c:113
 print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
 kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
 __read_once_size include/linux/compiler.h:197 [inline]
 lockdep_register_key+0x3b9/0x490 kernel/locking/lockdep.c:1023
 wq_init_lockdep kernel/workqueue.c:3444 [inline]
 alloc_workqueue+0x427/0xe70 kernel/workqueue.c:4263
 ucma_open+0x76/0x290 drivers/infiniband/core/ucma.c:1732
 misc_open+0x398/0x4c0 drivers/char/misc.c:141
 chrdev_open+0x247/0x6b0 fs/char_dev.c:417
 do_dentry_open+0x488/0x1160 fs/open.c:771
 vfs_open+0xa0/0xd0 fs/open.c:880
 do_last fs/namei.c:3416 [inline]
 path_openat+0x10e9/0x46e0 fs/namei.c:3533
 do_filp_open+0x1a1/0x280 fs/namei.c:3563
 do_sys_open+0x3fe/0x5d0 fs/open.c:1063
 __do_sys_openat fs/open.c:1090 [inline]
 __se_sys_openat fs/open.c:1084 [inline]
 __x64_sys_openat+0x9d/0x100 fs/open.c:1084
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Allocated by task 7789:
 save_stack+0x45/0xd0 mm/kasan/common.c:75
 set_track mm/kasan/common.c:87 [inline]
 __kasan_kmalloc mm/kasan/common.c:497 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
 __do_kmalloc mm/slab.c:3726 [inline]
 __kmalloc+0x15c/0x740 mm/slab.c:3735
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:743 [inline]
 alloc_workqueue+0x13c/0xe70 kernel/workqueue.c:4236
 ucma_open+0x76/0x290 drivers/infiniband/core/ucma.c:1732
 misc_open+0x398/0x4c0 drivers/char/misc.c:141
 chrdev_open+0x247/0x6b0 fs/char_dev.c:417
 do_dentry_open+0x488/0x1160 fs/open.c:771
 vfs_open+0xa0/0xd0 fs/open.c:880
 do_last fs/namei.c:3416 [inline]
 path_openat+0x10e9/0x46e0 fs/namei.c:3533
 do_filp_open+0x1a1/0x280 fs/namei.c:3563
 do_sys_open+0x3fe/0x5d0 fs/open.c:1063
 __do_sys_openat fs/open.c:1090 [inline]
 __se_sys_openat fs/open.c:1084 [inline]
 __x64_sys_openat+0x9d/0x100 fs/open.c:1084
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7789:
 save_stack+0x45/0xd0 mm/kasan/common.c:75
 set_track mm/kasan/common.c:87 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
 __cache_free mm/slab.c:3498 [inline]
 kfree+0xcf/0x230 mm/slab.c:3821
 alloc_workqueue+0xc3e/0xe70 kernel/workqueue.c:4295
 ucma_open+0x76/0x290 drivers/infiniband/core/ucma.c:1732
 misc_open+0x398/0x4c0 drivers/char/misc.c:141
 chrdev_open+0x247/0x6b0 fs/char_dev.c:417
 do_dentry_open+0x488/0x1160 fs/open.c:771
 vfs_open+0xa0/0xd0 fs/open.c:880
 do_last fs/namei.c:3416 [inline]
 path_openat+0x10e9/0x46e0 fs/namei.c:3533
 do_filp_open+0x1a1/0x280 fs/namei.c:3563
 do_sys_open+0x3fe/0x5d0 fs/open.c:1063
 __do_sys_openat fs/open.c:1090 [inline]
 __se_sys_openat fs/open.c:1084 [inline]
 __x64_sys_openat+0x9d/0x100 fs/open.c:1084
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888090fc2580
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 280 bytes inside of
 512-byte region [ffff888090fc2580, ffff888090fc2780)

Reported-by: syzbot+17335689e239ce135d8b@syzkaller.appspotmail.com
Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/workqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 497900263dbc..35fd0e697087 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4291,6 +4291,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	return wq;
 
 err_free_wq:
+	wq_unregister_lockdep(wq);
+	wq_free_lockdep(wq);
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
 	return NULL;
-- 
2.20.1

