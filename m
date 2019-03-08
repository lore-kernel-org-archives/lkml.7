Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC64C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2075720684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCHHM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:12:57 -0500
Received: from mx57.baidu.com ([61.135.168.57]:51510 "EHLO
        tc-sys-mailedm05.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725308AbfCHHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:12:55 -0500
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm05.tc.baidu.com (Postfix) with ESMTP id 05FD41EBA005;
        Fri,  8 Mar 2019 15:12:42 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH][v2] ipc: prevent lockup on alloc_msg and free_msg
Date:   Fri,  8 Mar 2019 15:12:41 +0800
Message-Id: <1552029161-4957-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Rongqing <lirongqing@baidu.com>

msgctl10 of ltp triggers the following lockup When CONFIG_KASAN
is enabled on large memory SMP systems, the pages initialization
can take a long time, if msgctl10 requests a huge block memory,
and it will block rcu scheduler, so release cpu actively.

After adding schedule() in free_msg, free_msg can not be called
when holding spinlock, so adding msg to a tmp list, and free it
out of spinlock

[79441.630467] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[79441.637566] rcu:     Tasks blocked on level-1 rcu_node (CPUs 16-31): P32505
[79441.645355] rcu:     Tasks blocked on level-1 rcu_node (CPUs 48-63): P34978
[79441.653149] rcu:     (detected by 11, t=35024 jiffies, g=44237529, q=16542267)
[79441.661247] msgctl10        R  running task    21608 32505   2794 0x00000082
[79441.669455] Call Trace:
[79441.736659]  preempt_schedule_irq+0x4c/0xb0
[79441.741578]  retint_kernel+0x1b/0x2d
[79441.745796] RIP: 0010:__is_insn_slot_addr+0xfb/0x250
[79441.751595] Code: 82 1d 00 48 8b 9b 90 00 00 00 4c 89 f7 49 c1 ee 03 e8 59 83 1d 00 48 b8 00 00 00 00 00 fc ff df 4c 39 eb 48 89 9d 58 ff ff ff <41> c6 04 06 f8 74 66 4c 8d 75 98 4c 89 f1 48 c1 e9 03 48 01 c8 48
[79441.773232] RSP: 0018:ffff88bce041f758 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[79441.782071] RAX: dffffc0000000000 RBX: ffffffff8471bc50 RCX: ffffffff828a2a57
[79441.790337] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffff88bce041f780
[79441.798612] RBP: ffff88bce041f828 R08: ffffed15f3f4c5b3 R09: ffffed15f3f4c5b3
[79441.806877] R10: 0000000000000001 R11: ffffed15f3f4c5b2 R12: 000000318aee9b73
[79441.815139] R13: ffffffff8471bc50 R14: 1ffff1179c083ef0 R15: 1ffff1179c083eec
[79441.848618]  kernel_text_address+0xc1/0x100
[79441.853542]  __kernel_text_address+0xe/0x30
[79441.858453]  unwind_get_return_address+0x2f/0x50
[79441.863864]  __save_stack_trace+0x92/0x100
[79441.868742]  create_object+0x380/0x650
[79441.911831]  __kmalloc+0x14c/0x2b0
[79441.915874]  load_msg+0x38/0x1a0
[79441.919726]  do_msgsnd+0x19e/0xcf0
[79442.006475]  do_syscall_64+0x117/0x400
[79442.037964]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[79386.022357] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[79386.029455] rcu:     Tasks blocked on level-1 rcu_node (CPUs 0-15): P32170
[79386.037146] rcu:     (detected by 14, t=35016 jiffies, g=44237525, q=12423063)
[79386.045242] msgctl10        R  running task    21608 32170  32155 0x00000082
[79386.053447] Call Trace:
[79386.107584]  preempt_schedule_irq+0x4c/0xb0
[79386.112495]  retint_kernel+0x1b/0x2d
[79386.116712] RIP: 0010:lock_acquire+0x4d/0x340
[79386.121816] Code: 48 81 ec c0 00 00 00 45 89 c6 4d 89 cf 48 8d 6c 24 20 48 89 3c 24 48 8d bb e4 0c 00 00 89 74 24 0c 48 c7 44 24 20 b3 8a b5 41 <48> c1 ed 03 48 c7 44 24 28 b4 25 18 84 48 c7 44 24 30 d0 54 7a 82
[79386.143446] RSP: 0018:ffff88af83417738 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
[79386.152278] RAX: dffffc0000000000 RBX: ffff88bd335f3080 RCX: 0000000000000002
[79386.160543] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88bd335f3d64
[79386.168798] RBP: ffff88af83417758 R08: 0000000000000000 R09: 0000000000000000
[79386.177049] R10: 0000000000000001 R11: ffffed13f3f745b2 R12: 0000000000000000
[79386.185308] R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
[79386.213791]  is_bpf_text_address+0x32/0xe0
[79386.223516]  kernel_text_address+0xec/0x100
[79386.233532]  __kernel_text_address+0xe/0x30
[79386.238448]  unwind_get_return_address+0x2f/0x50
[79386.243858]  __save_stack_trace+0x92/0x100
[79386.252648]  save_stack+0x32/0xb0
[79386.357923]  __kasan_slab_free+0x130/0x180
[79386.362745]  kfree+0xfa/0x2d0
[79386.366291]  free_msg+0x24/0x50
[79386.370020]  do_msgrcv+0x508/0xe60
[79386.446596]  do_syscall_64+0x117/0x400
[79386.478122]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
v1 -->v2: move free_msg out of spinlock in mqueue_evict_inode
          move schedule() from loop end to loop start, since it does not isolate two kmallocs in loop end


 ipc/mqueue.c  | 10 ++++++++--
 ipc/msgutil.c |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c0d58f390..bce7af154 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -391,7 +391,8 @@ static void mqueue_evict_inode(struct inode *inode)
 	struct user_struct *user;
 	unsigned long mq_bytes, mq_treesize;
 	struct ipc_namespace *ipc_ns;
-	struct msg_msg *msg;
+	struct msg_msg *msg, *nmsg;
+	LIST_HEAD(tmp_msg);
 
 	clear_inode(inode);
 
@@ -402,10 +403,15 @@ static void mqueue_evict_inode(struct inode *inode)
 	info = MQUEUE_I(inode);
 	spin_lock(&info->lock);
 	while ((msg = msg_get(info)) != NULL)
-		free_msg(msg);
+		list_add_tail(&msg->m_list, &tmp_msg);
 	kfree(info->node_cache);
 	spin_unlock(&info->lock);
 
+	list_for_each_entry_safe(msg, nmsg, &tmp_msg, m_list) {
+		list_del(&msg->m_list);
+		free_msg(msg);
+	}
+
 	/* Total amount of bytes accounted for the mqueue */
 	mq_treesize = info->attr.mq_maxmsg * sizeof(struct msg_msg) +
 		min_t(unsigned int, info->attr.mq_maxmsg, MQ_PRIO_MAX) *
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index 84598025a..e65593742 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -18,6 +18,7 @@
 #include <linux/utsname.h>
 #include <linux/proc_ns.h>
 #include <linux/uaccess.h>
+#include <linux/sched.h>
 
 #include "util.h"
 
@@ -64,6 +65,9 @@ static struct msg_msg *alloc_msg(size_t len)
 	pseg = &msg->next;
 	while (len > 0) {
 		struct msg_msgseg *seg;
+
+		cond_resched();
+
 		alen = min(len, DATALEN_SEG);
 		seg = kmalloc(sizeof(*seg) + alen, GFP_KERNEL_ACCOUNT);
 		if (seg == NULL)
@@ -176,6 +180,8 @@ void free_msg(struct msg_msg *msg)
 	kfree(msg);
 	while (seg != NULL) {
 		struct msg_msgseg *tmp = seg->next;
+
+		cond_resched();
 		kfree(seg);
 		seg = tmp;
 	}
-- 
2.16.2

