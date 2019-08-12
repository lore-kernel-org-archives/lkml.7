Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FB2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C004220820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfHLKwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:52:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58911 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfHLKwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:52:23 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7CAq3DV087905;
        Mon, 12 Aug 2019 19:52:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Mon, 12 Aug 2019 19:52:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7CApwhv087660
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 19:52:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] /dev/kmem : Debug preadv() progress.
Date:   Mon, 12 Aug 2019 19:51:43 +0900
Message-Id: <1565607103-6175-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting unkillable thread when reading /dev/mem . To check
whether this is merely due to lack of fatal_signal_pending(current) test
or unexpectedly fallen into infinite loop, add debug printk(). This patch
is intended for linux-next only, and will be removed after the cause is
fixed.

  INFO: task syz-executor.4:25539 can't die for more than 143 seconds.
  syz-executor.4  R  running task    28400 25539  25531 0x80004006
  Call Trace:
   context_switch kernel/sched/core.c:3265 [inline]
   __schedule+0x76e/0x17d0 kernel/sched/core.c:3937
   preempt_schedule_irq+0xb5/0x160 kernel/sched/core.c:4185
   retint_kernel+0x1b/0x2b
  RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20 arch/x86/lib/copy_user_64.S:205
  Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f 80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f 1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 89 d1 f3 a4
  RSP: 0018:ffff88808d76fb68 EFLAGS: 00010206 ORIG_RAX: ffffffffffffff13
  RAX: 0000000000040000 RBX: ffff8880925be2c0 RCX: 0000000000000c00
  RDX: 0000000000001000 RSI: ffffc9000fbb2c00 RDI: ffff8880925beec0
  RBP: ffff88808d76fb98 R08: ffff888060288440 R09: ffff8880aa402000
  R10: 0000000000000000 R11: ffffea0002496f87 R12: 0000000000001000
  R13: 00007ffffffff000 R14: ffffc9000fbb8000 R15: ffff888060288440
   read_mem+0xfc/0x2c0 drivers/char/mem.c:163
   do_loop_readv_writev fs/read_write.c:714 [inline]
   do_loop_readv_writev fs/read_write.c:701 [inline]
   do_iter_read+0x4a4/0x660 fs/read_write.c:935
   vfs_readv+0xf0/0x160 fs/read_write.c:997
   do_preadv+0x1c4/0x280 fs/read_write.c:1089
   __do_sys_preadv fs/read_write.c:1139 [inline]
   __se_sys_preadv fs/read_write.c:1134 [inline]
   __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1134
   do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

  https://syzkaller.appspot.com/text?tag=CrashLog&x=1469b8a6600000
  https://syzkaller.appspot.com/text?tag=CrashLog&x=160a00a6600000
  https://syzkaller.appspot.com/text?tag=CrashLog&x=16255326600000

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/mem.c | 9 +++++++++
 fs/read_write.c    | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50..4c0225e 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -140,6 +140,9 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 		int allowed, probe;
 
 		sz = size_inside_page(p, count);
+		if (IS_ENABLED(CONFIG_DEBUG_AID_FOR_SYZBOT) &&
+		    fatal_signal_pending(current))
+			printk("read_mem: sz=%ld count=%ld\n", sz, count);
 
 		err = -EPERM;
 		allowed = page_is_allowed(p >> PAGE_SHIFT);
@@ -179,9 +182,15 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 	kfree(bounce);
 
 	*ppos += read;
+	if (IS_ENABLED(CONFIG_DEBUG_AID_FOR_SYZBOT) &&
+	    fatal_signal_pending(current))
+		printk("read_mem: read=%ld *ppos=%lld\n", read, *ppos);
 	return read;
 
 failed:
+	if (IS_ENABLED(CONFIG_DEBUG_AID_FOR_SYZBOT) &&
+	    fatal_signal_pending(current))
+		printk("read_mem: err=%d\n", err);
 	kfree(bounce);
 	return err;
 }
diff --git a/fs/read_write.c b/fs/read_write.c
index 1f5088d..f5c7da1 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -710,6 +710,9 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 		struct iovec iovec = iov_iter_iovec(iter);
 		ssize_t nr;
 
+		if (IS_ENABLED(CONFIG_DEBUG_AID_FOR_SYZBOT) &&
+		    fatal_signal_pending(current))
+			printk("do_loop_readv_writev: iter->count=%ld iovec.iov_len=%ld\n", iter->count, iovec.iov_len);
 		if (type == READ) {
 			nr = filp->f_op->read(filp, iovec.iov_base,
 					      iovec.iov_len, ppos);
@@ -717,6 +720,9 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 			nr = filp->f_op->write(filp, iovec.iov_base,
 					       iovec.iov_len, ppos);
 		}
+		if (IS_ENABLED(CONFIG_DEBUG_AID_FOR_SYZBOT) &&
+		    fatal_signal_pending(current))
+			printk("do_loop_readv_writev: nr=%ld\n", nr);
 
 		if (nr < 0) {
 			if (!ret)
-- 
1.8.3.1

