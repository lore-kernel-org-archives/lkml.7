Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F127C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D85218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254502;
	bh=NcOJM3/f0vbCBqv5DZXLxCwdRDkaZKcTcs6XPPs0eQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qvfAHXc6G1A6/zFjsCIzwTS8+/Uk+6ADi5EHWj0+4m30dG9K2WSwDyxtjkZXRudwT
	 6+FYwQlIL70hFWH1BL/tEcV/iCI/J+W+Tpee5S6N6wi2HQmAyrcGVMxnC4vKs4PiP0
	 GLsE7zEGmWES5PsdW9lN3JfVn10Ca//KPohCUquw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfCVLfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730506AbfCVLe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D5842183E;
        Fri, 22 Mar 2019 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254497;
        bh=NcOJM3/f0vbCBqv5DZXLxCwdRDkaZKcTcs6XPPs0eQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDX/tsltR0GYaxroo2LumK+4JhINtoSP7H9NK8qeXnwAmvCwYOKXp48z5H3qJ/CMc
         Typ4UnGfPlu1syFJXugMjdevGd8Qmk8XQDSxuz2l9b3qMGYFosfsIoPtm+n7YcuKkz
         VanAUcgE7a2LsynqKQyczETWhXKQ7KB6eqHbSjEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        andrew hendry <andrew.hendry@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 136/230] net/x25: fix a race in x25_bind()
Date:   Fri, 22 Mar 2019 12:14:34 +0100
Message-Id: <20190322111246.228589144@linuxfoundation.org>
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

[ Upstream commit 797a22bd5298c2674d927893f46cadf619dad11d ]

syzbot was able to trigger another soft lockup [1]

I first thought it was the O(N^2) issue I mentioned in my
prior fix (f657d22ee1f "net/x25: do not hold the cpu
too long in x25_new_lci()"), but I eventually found
that x25_bind() was not checking SOCK_ZAPPED state under
socket lock protection.

This means that multiple threads can end up calling
x25_insert_socket() for the same socket, and corrupt x25_list

[1]
watchdog: BUG: soft lockup - CPU#0 stuck for 123s! [syz-executor.2:10492]
Modules linked in:
irq event stamp: 27515
hardirqs last  enabled at (27514): [<ffffffff81006673>] trace_hardirqs_on_thunk+0x1a/0x1c
hardirqs last disabled at (27515): [<ffffffff8100668f>] trace_hardirqs_off_thunk+0x1a/0x1c
softirqs last  enabled at (32): [<ffffffff8632ee73>] x25_get_neigh+0xa3/0xd0 net/x25/x25_link.c:336
softirqs last disabled at (34): [<ffffffff86324bc3>] x25_find_socket+0x23/0x140 net/x25/af_x25.c:341
CPU: 0 PID: 10492 Comm: syz-executor.2 Not tainted 5.0.0-rc7+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__sanitizer_cov_trace_pc+0x4/0x50 kernel/kcov.c:97
Code: f4 ff ff ff e8 11 9f ea ff 48 c7 05 12 fb e5 08 00 00 00 00 e9 c8 e9 ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 <48> 8b 75 08 65 48 8b 04 25 40 ee 01 00 65 8b 15 38 0c 92 7e 81 e2
RSP: 0018:ffff88806e94fc48 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffff1100d84dac5 RBX: 0000000000000001 RCX: ffffc90006197000
RDX: 0000000000040000 RSI: ffffffff86324bf3 RDI: ffff88806c26d628
RBP: ffff88806e94fc48 R08: ffff88806c1c6500 R09: fffffbfff1282561
R10: fffffbfff1282560 R11: ffffffff89412b03 R12: ffff88806c26d628
R13: ffff888090455200 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f3a107e4700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3a107e3db8 CR3: 00000000a5544000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __x25_find_socket net/x25/af_x25.c:327 [inline]
 x25_find_socket+0x7d/0x140 net/x25/af_x25.c:342
 x25_new_lci net/x25/af_x25.c:355 [inline]
 x25_connect+0x380/0xde0 net/x25/af_x25.c:784
 __sys_connect+0x266/0x330 net/socket.c:1662
 __do_sys_connect net/socket.c:1673 [inline]
 __se_sys_connect net/socket.c:1670 [inline]
 __x64_sys_connect+0x73/0xb0 net/socket.c:1670
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3a107e3c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e29
RDX: 0000000000000012 RSI: 0000000020000200 RDI: 0000000000000005
RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3a107e46d4
R13: 00000000004be362 R14: 00000000004ceb98 R15: 00000000ffffffff
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 10493 Comm: syz-executor.3 Not tainted 5.0.0-rc7+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:193 [inline]
RIP: 0010:queued_write_lock_slowpath+0x143/0x290 kernel/locking/qrwlock.c:86
Code: 4c 8d 2c 01 41 83 c7 03 41 0f b6 45 00 41 38 c7 7c 08 84 c0 0f 85 0c 01 00 00 8b 03 3d 00 01 00 00 74 1a f3 90 41 0f b6 55 00 <41> 38 d7 7c eb 84 d2 74 e7 48 89 df e8 cc aa 4e 00 eb dd be 04 00
RSP: 0018:ffff888085c47bd8 EFLAGS: 00000206
RAX: 0000000000000300 RBX: ffffffff89412b00 RCX: 1ffffffff1282560
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff89412b00
RBP: ffff888085c47c70 R08: 1ffffffff1282560 R09: fffffbfff1282561
R10: fffffbfff1282560 R11: ffffffff89412b03 R12: 00000000000000ff
R13: fffffbfff1282560 R14: 1ffff11010b88f7d R15: 0000000000000003
FS:  00007fdd04086700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdd04064db8 CR3: 0000000090be0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 queued_write_lock include/asm-generic/qrwlock.h:104 [inline]
 do_raw_write_lock+0x1d6/0x290 kernel/locking/spinlock_debug.c:203
 __raw_write_lock_bh include/linux/rwlock_api_smp.h:204 [inline]
 _raw_write_lock_bh+0x3b/0x50 kernel/locking/spinlock.c:312
 x25_insert_socket+0x21/0xe0 net/x25/af_x25.c:267
 x25_bind+0x273/0x340 net/x25/af_x25.c:703
 __sys_bind+0x23f/0x290 net/socket.c:1481
 __do_sys_bind net/socket.c:1492 [inline]
 __se_sys_bind net/socket.c:1490 [inline]
 __x64_sys_bind+0x73/0xb0 net/socket.c:1490
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29

Fixes: 90c27297a9bf ("X.25 remove bkl in bind")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: andrew hendry <andrew.hendry@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/x25/af_x25.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -678,8 +678,7 @@ static int x25_bind(struct socket *sock,
 	struct sockaddr_x25 *addr = (struct sockaddr_x25 *)uaddr;
 	int len, i, rc = 0;
 
-	if (!sock_flag(sk, SOCK_ZAPPED) ||
-	    addr_len != sizeof(struct sockaddr_x25) ||
+	if (addr_len != sizeof(struct sockaddr_x25) ||
 	    addr->sx25_family != AF_X25) {
 		rc = -EINVAL;
 		goto out;
@@ -694,9 +693,13 @@ static int x25_bind(struct socket *sock,
 	}
 
 	lock_sock(sk);
-	x25_sk(sk)->source_addr = addr->sx25_addr;
-	x25_insert_socket(sk);
-	sock_reset_flag(sk, SOCK_ZAPPED);
+	if (sock_flag(sk, SOCK_ZAPPED)) {
+		x25_sk(sk)->source_addr = addr->sx25_addr;
+		x25_insert_socket(sk);
+		sock_reset_flag(sk, SOCK_ZAPPED);
+	} else {
+		rc = -EINVAL;
+	}
 	release_sock(sk);
 	SOCK_DEBUG(sk, "x25_bind: socket is bound\n");
 out:


