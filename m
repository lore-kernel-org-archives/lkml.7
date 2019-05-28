Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9164320665
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZB9Q1Edh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfE1EcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 00:32:22 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35822 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfE1EcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 00:32:22 -0400
Received: by mail-pf1-f201.google.com with SMTP id 205so8291071pfx.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 21:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nXukZfkXi9PXrxYM6I081R9mWVihxST+vyBNiwxZToQ=;
        b=ZB9Q1EdhMbEMQMnaSmiQmhcsggplsSuthfrmrh5/e+JmMNjK+bTPrTzFtkblNgXZrm
         +aetRiOi5x1cc672Y08peUe+WtFYVgK513wOOnf/GDhCbDJdefw4XfhBVhSluTsoHxMS
         SPadlG5cjYjC4ITdPgYlc2VezNl2qGvtrfqo6RLUzecc/kqjl3l22dRhgRvUwm5+IRp2
         Wz25pboSmrUWlg7cqJByWYBKVsRqGzPeyRkiH/ODnyD08hvpjxfRrGD3o5kjkNw7RiyC
         dLPFibVUvUl4FGZZnP8/PJfrBH2WNN6wKD7B4+ybi0zZm7sn+WztwnnLVQNhqhNnDuD5
         S3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nXukZfkXi9PXrxYM6I081R9mWVihxST+vyBNiwxZToQ=;
        b=cPeDj6dG8L+RTbJQjKLrOZicU40Bshr6nYrMrGa327hLyVgn6e9Fclxz1ybAmnwyDU
         4V2IZyHJl2QMYfQt7zTYbObxcvSgIdMBBwK+Tq9JLiT0YNGRPZCQdfFIhgJNA/tDth+Z
         5W7sH/Q3QgsC1F0KDHYhKn7dOey8oP7c7XhaWlMXRpFWJQFGvyoePZuyQQjJhf4bkAV9
         1+8LheJdV9vqnx6XMMl1As71G2z0AeQvoKflSFtDJABBHbaEJhW70NMjirWA7mBxMfA2
         Ohn9/DX3LCkZ4Kn7shH7HXGr+s+N748t9/EC0HFPmJZ86SGq5yoDVgaLxrTh0UaSL4yl
         PpSw==
X-Gm-Message-State: APjAAAWBm7eD12CP0dZdP6dasGN1YZEt9u7kbUyhA8WJ5jkVs+eWgaLF
        cLOObUM+iqTqVRykdmZWbu/vs+bQANf3Ow==
X-Google-Smtp-Source: APXvYqwytf1qBZjKBb8f7c+lPPFyGQLNV0DxPBbuMzMX1/pVMWPQZKlYgkW4p2DbQRkVymjU5c+QYeOmhFLFiA==
X-Received: by 2002:a65:5248:: with SMTP id q8mr6095475pgp.92.1559017941057;
 Mon, 27 May 2019 21:32:21 -0700 (PDT)
Date:   Mon, 27 May 2019 21:32:02 -0700
Message-Id: <20190528043202.99980-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] list_lru: fix memory leak in __memcg_init_list_lru_node
From:   Shakeel Butt <shakeelb@google.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        syzbot+f90a420dfe2b1b03cb2c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported following memory leak:

ffffffffda RBX: 0000000000000003 RCX: 0000000000441f79
BUG: memory leak
unreferenced object 0xffff888114f26040 (size 32):
  comm "syz-executor626", pid 7056, jiffies 4294948701 (age 39.410s)
  hex dump (first 32 bytes):
    40 60 f2 14 81 88 ff ff 40 60 f2 14 81 88 ff ff  @`......@`......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000018f36b56>] kmemleak_alloc_recursive include/linux/kmemleak.h:55 [inline]
    [<0000000018f36b56>] slab_post_alloc_hook mm/slab.h:439 [inline]
    [<0000000018f36b56>] slab_alloc mm/slab.c:3326 [inline]
    [<0000000018f36b56>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
    [<0000000055b9a1a5>] kmalloc include/linux/slab.h:547 [inline]
    [<0000000055b9a1a5>] __memcg_init_list_lru_node+0x58/0xf0 mm/list_lru.c:352
    [<000000001356631d>] memcg_init_list_lru_node mm/list_lru.c:375 [inline]
    [<000000001356631d>] memcg_init_list_lru mm/list_lru.c:459 [inline]
    [<000000001356631d>] __list_lru_init+0x193/0x2a0 mm/list_lru.c:626
    [<00000000ce062da3>] alloc_super+0x2e0/0x310 fs/super.c:269
    [<000000009023adcf>] sget_userns+0x94/0x2a0 fs/super.c:609
    [<0000000052182cd8>] sget+0x8d/0xb0 fs/super.c:660
    [<0000000006c24238>] mount_nodev+0x31/0xb0 fs/super.c:1387
    [<0000000006016a76>] fuse_mount+0x2d/0x40 fs/fuse/inode.c:1236
    [<000000009a61ec1d>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
    [<0000000096cd9ef8>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
    [<000000005b8f472d>] do_new_mount fs/namespace.c:2790 [inline]
    [<000000005b8f472d>] do_mount+0x932/0xc50 fs/namespace.c:3110
    [<00000000afb009b4>] ksys_mount+0xab/0x120 fs/namespace.c:3319
    [<0000000018f8c8ee>] __do_sys_mount fs/namespace.c:3333 [inline]
    [<0000000018f8c8ee>] __se_sys_mount fs/namespace.c:3330 [inline]
    [<0000000018f8c8ee>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
    [<00000000f42066da>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
    [<0000000043d74ca0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

This is a simple off by one bug on the error path.

Reported-by: syzbot+f90a420dfe2b1b03cb2c@syzkaller.appspotmail.com
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/list_lru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0bdf3152735e..92870be4a322 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -358,7 +358,7 @@ static int __memcg_init_list_lru_node(struct list_lru_memcg *memcg_lrus,
 	}
 	return 0;
 fail:
-	__memcg_destroy_list_lru_node(memcg_lrus, begin, i - 1);
+	__memcg_destroy_list_lru_node(memcg_lrus, begin, i);
 	return -ENOMEM;
 }
 
-- 
2.22.0.rc1.257.g3120a18244-goog

