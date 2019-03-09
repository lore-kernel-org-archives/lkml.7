Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58423C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2732E2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCIOmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:42:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33811 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbfCIOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:42:44 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29EgKLq3109863
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:42:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29EgK0o3109860;
        Sat, 9 Mar 2019 06:42:20 -0800
Date:   Sat, 9 Mar 2019 06:42:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-009bb421b6ceb7916ce627023d0eb7ced04c8910@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, luto@kernel.org,
        dave.hansen@linux.intel.com, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, mingo@kernel.org, bp@alien8.de,
        bvanassche@acm.org, will.deacon@arm.com, akpm@linux-foundation.org,
        riel@surriel.com, torvalds@linux-foundation.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, luto@kernel.org, paulmck@linux.vnet.ibm.com,
          dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
          bp@alien8.de, peterz@infradead.org, mingo@kernel.org,
          bvanassche@acm.org, will.deacon@arm.com,
          torvalds@linux-foundation.org, hpa@zytor.com,
          akpm@linux-foundation.org, riel@surriel.com
In-Reply-To: <20190303220046.29448-1-bvanassche@acm.org>
References: <20190303220046.29448-1-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] workqueue, lockdep: Fix an alloc_workqueue()
 error path
Git-Commit-ID: 009bb421b6ceb7916ce627023d0eb7ced04c8910
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  009bb421b6ceb7916ce627023d0eb7ced04c8910
Gitweb:     https://git.kernel.org/tip/009bb421b6ceb7916ce627023d0eb7ced04c8910
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Sun, 3 Mar 2019 14:00:46 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:15:52 +0100

workqueue, lockdep: Fix an alloc_workqueue() error path

This patch fixes a use-after-free and a memory leak in an alloc_workqueue()
error path.

Repoted by syzkaller and KASAN:

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
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")
Link: https://lkml.kernel.org/r/20190303220046.29448-1-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/workqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e163e7a7f5e5..ecdd5e6f2166 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4194,6 +4194,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	return wq;
 
 err_free_wq:
+	wq_unregister_lockdep(wq);
+	wq_free_lockdep(wq);
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
 	return NULL;
