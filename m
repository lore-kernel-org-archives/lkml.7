Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51056C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2185020665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfFUJ7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:59:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55534 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:59:15 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5L9wsSw043865;
        Fri, 21 Jun 2019 18:58:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Fri, 21 Jun 2019 18:58:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5L9wnGD043834
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 21 Jun 2019 18:58:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task syz-executor can't die for more than 143 seconds.
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <000000000000a861f6058b2699e0@google.com>
Cc:     syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp>
Date:   Fri, 21 Jun 2019 18:58:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <000000000000a861f6058b2699e0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I noticed (using below debug patch and reproducer) that memory allocation from
ion_system_heap_allocate() is calling ion_system_heap_shrink(). Is such behavior
what we want?

----------------------------------------
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index e291299fd35f..ce096d520915 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -168,6 +168,8 @@ struct ion_heap {
 
 	/* protect heap statistics */
 	spinlock_t stat_lock;
+
+	bool no_shrink;
 };
 
 /**
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index aa8d8425be25..ecc22eb870d0 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -114,6 +114,7 @@ static int ion_system_heap_allocate(struct ion_heap *heap,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&pages);
+	heap->no_shrink = true;
 	while (size_remaining > 0) {
 		page = alloc_largest_available(sys_heap, buffer, size_remaining,
 					       max_order);
@@ -139,6 +140,7 @@ static int ion_system_heap_allocate(struct ion_heap *heap,
 	}
 
 	buffer->sg_table = table;
+	heap->no_shrink = false;
 	return 0;
 
 free_table:
@@ -146,6 +148,7 @@ static int ion_system_heap_allocate(struct ion_heap *heap,
 free_pages:
 	list_for_each_entry_safe(page, tmp_page, &pages, lru)
 		free_buffer_page(sys_heap, buffer, page);
+	heap->no_shrink = false;
 	return -ENOMEM;
 }
 
@@ -200,6 +203,7 @@ static int ion_system_heap_shrink(struct ion_heap *heap, gfp_t gfp_mask,
 				break;
 		}
 	}
+	BUG_ON(heap->no_shrink && nr_total);
 	return nr_total;
 }
 
----------------------------------------

----------------------------------------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	struct ion_allocation_data {
		unsigned long long len;
		unsigned int heap_id_mask;
		unsigned int flags;
		unsigned int fd;
		unsigned int unused;
	} data = {
		3ULL * 1048576 * 1024, -1, 1, -1, 0
	};
	int i;

	for (i = 0; i < 10; i++) {
		if (fork() == 0) {
			ioctl(open("/dev/ion", 0, 0), 0xc0184900, &data);
			pause();
		}
	}
	return 0;
}
----------------------------------------

----------------------------------------
[  182.907464][ T7500] ------------[ cut here ]------------
[  182.907468][ T7500] kernel BUG at drivers/staging/android/ion/ion_system_heap.c:206!
[  182.907477][ T7500] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
[  182.907481][ T7500] CPU: 4 PID: 7500 Comm: a.out Not tainted 5.2.0-rc5+ #207
[  182.907483][ T7500] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[  182.907491][ T7500] RIP: 0010:ion_system_heap_shrink+0xbf/0xd0
[  182.907495][ T7500] Code: 41 5f 5d c3 e8 02 91 8f fe 8b 75 d4 44 89 ea 48 8b 7d c0 e8 23 0d 00 00 41 29 c5 41 01 c4 45 85 ed 7f a7 eb b4 e8 e1 90 8f fe <0f> 0b 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41
[  182.907497][ T7500] RSP: 0000:ffffc90001de77d0 EFLAGS: 00010293
[  182.907501][ T7500] RAX: ffff888212698700 RBX: ffff88822985fba8 RCX: ffffffff82a398af
[  182.907503][ T7500] RDX: 0000000000000000 RSI: 0000000000140dc2 RDI: ffff888229927b00
[  182.907506][ T7500] RBP: ffffc90001de7810 R08: 0000000000000000 R09: 0000000000000004
[  182.907508][ T7500] R10: ffffc90001de7790 R11: 0000000000000001 R12: 0000000000002021
[  182.907511][ T7500] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88822985fa00
[  182.907515][ T7500] FS:  00007fe4034934c0(0000) GS:ffff888235d00000(0000) knlGS:0000000000000000
[  182.907520][ T7500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  182.907522][ T7500] CR2: 00007fe402f9e5ad CR3: 0000000215075003 CR4: 00000000003606e0
[  182.907556][ T7500] Call Trace:
[  182.907562][ T7500]  ? order_to_index+0x50/0x50
[  182.907566][ T7500]  ion_heap_shrink_count+0x5b/0x80
[  182.907572][ T7500]  do_shrink_slab+0x66/0x570
[  182.907578][ T7500]  shrink_slab+0x288/0x360
[  182.907583][ T7500]  shrink_node+0x1f6/0x5e0
[  182.907589][ T7500]  do_try_to_free_pages+0x118/0x520
[  182.907594][ T7500]  try_to_free_pages+0x138/0x420
[  182.907601][ T7500]  __alloc_pages_slowpath+0x452/0x1150
[  182.907610][ T7500]  __alloc_pages_nodemask+0x3ac/0x440
[  182.907615][ T7500]  alloc_pages_current+0x7a/0x110
[  182.907620][ T7500]  ion_page_pool_alloc+0x62/0xd0
[  182.907624][ T7500]  ion_system_heap_allocate+0xb4/0x420
[  182.907628][ T7500]  ? ion_ioctl+0x364/0x800
[  182.907633][ T7500]  ion_ioctl+0x332/0x800
[  182.907641][ T7500]  ? _ion_buffer_destroy+0x80/0x80
[  182.907645][ T7500]  do_vfs_ioctl+0xc1/0x8a0
[  182.907650][ T7500]  ? tomoyo_file_ioctl+0x23/0x30
[  182.907655][ T7500]  ksys_ioctl+0x94/0xb0
[  182.907660][ T7500]  __x64_sys_ioctl+0x1e/0x30
[  182.907665][ T7500]  do_syscall_64+0x81/0x2b0
[  182.907670][ T7500]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  182.907674][ T7500] RIP: 0033:0x7fe402f9e5d7
[  182.907679][ T7500] Code: Bad RIP value.
[  182.907681][ T7500] RSP: 002b:00007fff65b39098 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  182.907685][ T7500] RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007fe402f9e5d7
[  182.907688][ T7500] RDX: 00007fff65b390a0 RSI: 00000000c0184900 RDI: 0000000000000003
[  182.907690][ T7500] RBP: 00007fff65b390a0 R08: 00007fe4034934c0 R09: 00007fe403274d80
[  182.907693][ T7500] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c9049dd720
[  182.907695][ T7500] R13: 00007fff65b391b0 R14: 0000000000000000 R15: 0000000000000000
[  182.907699][ T7500] Modules linked in:
[  182.907738][ T7500] ---[ end trace b9487e8931865499 ]---
[  182.907745][ T7500] RIP: 0010:ion_system_heap_shrink+0xbf/0xd0
[  182.907752][ T7500] Code: 41 5f 5d c3 e8 02 91 8f fe 8b 75 d4 44 89 ea 48 8b 7d c0 e8 23 0d 00 00 41 29 c5 41 01 c4 45 85 ed 7f a7 eb b4 e8 e1 90 8f fe <0f> 0b 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41
[  182.907756][ T7500] RSP: 0000:ffffc90001de77d0 EFLAGS: 00010293
[  182.907765][ T7500] RAX: ffff888212698700 RBX: ffff88822985fba8 RCX: ffffffff82a398af
[  182.907771][ T7500] RDX: 0000000000000000 RSI: 0000000000140dc2 RDI: ffff888229927b00
[  182.907775][ T7500] RBP: ffffc90001de7810 R08: 0000000000000000 R09: 0000000000000004
[  182.907780][ T7500] R10: ffffc90001de7790 R11: 0000000000000001 R12: 0000000000002021
[  182.907784][ T7500] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88822985fa00
[  182.907789][ T7500] FS:  00007fe4034934c0(0000) GS:ffff888235d00000(0000) knlGS:0000000000000000
[  182.907793][ T7500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  182.907798][ T7500] CR2: 00007fe402f9e5ad CR3: 0000000215075003 CR4: 00000000003606e0
----------------------------------------

Below is a patch for the original problem reported by syzbot
( https://syzkaller.appspot.com/text?tag=CrashLog&x=11bb246ea00000 ).

----------------------------------------

From e0758655727044753399fb4f7c5f3eb25ac5cccd Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 21 Jun 2019 11:22:51 +0900
Subject: [PATCH] staging: android: ion: Bail out upon SIGKILL when allocating memory.

syzbot found that a thread can stall for minutes inside
ion_system_heap_allocate() after that thread was killed by SIGKILL [1].
Let's check for SIGKILL before doing memory allocation.

[1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index fd4995fb676e..f85ec5b16b65 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -8,11 +8,14 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
+#include <linux/sched/signal.h>
 
 #include "ion.h"
 
 static inline struct page *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
 {
+	if (fatal_signal_pending(current))
+		return NULL;
 	return alloc_pages(pool->gfp_mask, pool->order);
 }
 
-- 
2.17.1

