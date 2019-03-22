Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2C6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2384218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254417;
	bh=NtsUMFoHaSSZT9viitKF5gUdPOwCXVQVZ7erNnVQ/e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E66bKypsqhgW3Gi7EyGGZYmOcTXiGhocsuEYRjtYJTkw66xfbFX433uJPaHQloqgx
	 0LQobcbHC3MX0vOH5NOu7Daps+PfXE3Og4SJLi3U0G0LzAEk+nNMHypTlU8Y7bfQOW
	 NUPuEiHUHp4XA34wMSdszDiz9/NC6pCxHgicNr58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfCVLdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730274AbfCVLdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1866B21916;
        Fri, 22 Mar 2019 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254410;
        bh=NtsUMFoHaSSZT9viitKF5gUdPOwCXVQVZ7erNnVQ/e8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sif5hHBjJ4nhVOfJnZlBK556O6bH+cL5YLUdY4MGwCI22Wn/5F4kCcm+niGShAsU9
         UfRzEiuNUV87waTeDbsTCdyOulusNuWCnI1+XXgunF7hEPHtkFtGKvC/MCwEpp9/5w
         3tc64aUDHX0JP931+PF1D6+llkjJLvMl/g4XNZQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot+04babcefcd396fabec37@syzkaller.appspotmail.com,
        andrew hendry <andrew.hendry@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 128/230] net/x25: fix use-after-free in x25_device_event()
Date:   Fri, 22 Mar 2019 12:14:26 +0100
Message-Id: <20190322111245.657735738@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 95d6ebd53c79522bf9502dbc7e89e0d63f94dae4 ]

In case of failure x25_connect() does a x25_neigh_put(x25->neighbour)
but forgets to clear x25->neighbour pointer, thus triggering use-after-free.

Since the socket is visible in x25_list, we need to hold x25_list_lock
to protect the operation.

syzbot report :

BUG: KASAN: use-after-free in x25_kill_by_device net/x25/af_x25.c:217 [inline]
BUG: KASAN: use-after-free in x25_device_event+0x296/0x2b0 net/x25/af_x25.c:252
Read of size 8 at addr ffff8880a030edd0 by task syz-executor003/7854

CPU: 0 PID: 7854 Comm: syz-executor003 Not tainted 5.0.0+ #97
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x172/0x1f0 lib/dump_stack.c:113
 print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
 kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
 x25_kill_by_device net/x25/af_x25.c:217 [inline]
 x25_device_event+0x296/0x2b0 net/x25/af_x25.c:252
 notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
 __raw_notifier_call_chain kernel/notifier.c:394 [inline]
 raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
 call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
 call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
 call_netdevice_notifiers net/core/dev.c:1765 [inline]
 __dev_notify_flags+0x1e9/0x2c0 net/core/dev.c:7607
 dev_change_flags+0x10d/0x170 net/core/dev.c:7643
 dev_ifsioc+0x2b0/0x940 net/core/dev_ioctl.c:237
 dev_ioctl+0x1b8/0xc70 net/core/dev_ioctl.c:488
 sock_do_ioctl+0x1bd/0x300 net/socket.c:995
 sock_ioctl+0x32b/0x610 net/socket.c:1096
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:509 [inline]
 do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
 ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
 __do_sys_ioctl fs/ioctl.c:720 [inline]
 __se_sys_ioctl fs/ioctl.c:718 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4467c9
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fdbea222d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc58 RCX: 00000000004467c9
RDX: 0000000020000340 RSI: 0000000000008914 RDI: 0000000000000003
RBP: 00000000006dbc50 R08: 00007fdbea223700 R09: 0000000000000000
R10: 00007fdbea223700 R11: 0000000000000246 R12: 00000000006dbc5c
R13: 6000030030626669 R14: 0000000000000000 R15: 0000000030626669

Allocated by task 7843:
 save_stack+0x45/0xd0 mm/kasan/common.c:73
 set_track mm/kasan/common.c:85 [inline]
 __kasan_kmalloc mm/kasan/common.c:495 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:468
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:509
 kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3615
 kmalloc include/linux/slab.h:545 [inline]
 x25_link_device_up+0x46/0x3f0 net/x25/x25_link.c:249
 x25_device_event+0x116/0x2b0 net/x25/af_x25.c:242
 notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
 __raw_notifier_call_chain kernel/notifier.c:394 [inline]
 raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
 call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
 call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
 call_netdevice_notifiers net/core/dev.c:1765 [inline]
 __dev_notify_flags+0x121/0x2c0 net/core/dev.c:7605
 dev_change_flags+0x10d/0x170 net/core/dev.c:7643
 dev_ifsioc+0x2b0/0x940 net/core/dev_ioctl.c:237
 dev_ioctl+0x1b8/0xc70 net/core/dev_ioctl.c:488
 sock_do_ioctl+0x1bd/0x300 net/socket.c:995
 sock_ioctl+0x32b/0x610 net/socket.c:1096
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:509 [inline]
 do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
 ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
 __do_sys_ioctl fs/ioctl.c:720 [inline]
 __se_sys_ioctl fs/ioctl.c:718 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7865:
 save_stack+0x45/0xd0 mm/kasan/common.c:73
 set_track mm/kasan/common.c:85 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:457
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:465
 __cache_free mm/slab.c:3494 [inline]
 kfree+0xcf/0x230 mm/slab.c:3811
 x25_neigh_put include/net/x25.h:253 [inline]
 x25_connect+0x8d8/0xde0 net/x25/af_x25.c:824
 __sys_connect+0x266/0x330 net/socket.c:1685
 __do_sys_connect net/socket.c:1696 [inline]
 __se_sys_connect net/socket.c:1693 [inline]
 __x64_sys_connect+0x73/0xb0 net/socket.c:1693
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a030edc0
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 16 bytes inside of
 256-byte region [ffff8880a030edc0, ffff8880a030eec0)
The buggy address belongs to the page:
page:ffffea000280c380 count:1 mapcount:0 mapping:ffff88812c3f07c0 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002806788 ffffea00027f0188 ffff88812c3f07c0
raw: 0000000000000000 ffff8880a030e000 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+04babcefcd396fabec37@syzkaller.appspotmail.com
Cc: andrew hendry <andrew.hendry@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/x25/af_x25.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -812,8 +812,12 @@ static int x25_connect(struct socket *so
 	sock->state = SS_CONNECTED;
 	rc = 0;
 out_put_neigh:
-	if (rc)
+	if (rc) {
+		read_lock_bh(&x25_list_lock);
 		x25_neigh_put(x25->neighbour);
+		x25->neighbour = NULL;
+		read_unlock_bh(&x25_list_lock);
+	}
 out_put_route:
 	x25_route_put(rt);
 out:


