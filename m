Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD5B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfC0RyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:54:18 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43113 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfC0RyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:54:09 -0400
Received: by mail-io1-f71.google.com with SMTP id n23so13614110ioj.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=R2/HuzriwXNdGJ93S72o9PwYLEanpSbaAs2tbMwo4LA=;
        b=MbScyeTjLAZR7a8gUbuedPAKD7QKKU0hbUYqlO+ClXBatRUvHfFqPEkJ1vChElcp3e
         OOCmqFqhTMekrW+/yEYotK7yVeYaO06/bmu3+FT6hAoKev569ixl9obZzhU9um+gRxGj
         hQEBQpBwvRnZ7kI7BAnPtAywsqhQXY3NmyPiX8JJ3xne1LlOIA7nNEb3xaFjS3PVFyKv
         wAELZx1FSsfUudcaZSqo0B3UUDF2tr/WK3o4uf1Qn/b4V5iEBiflF9o8bKDUph+6U5Ax
         Y4bWzGICtaCilY+0zUWfXFX6ARuN7cUWFVXMdJdsIjRoye4W3A25tyBEdQyDhHs+WupL
         /0bg==
X-Gm-Message-State: APjAAAUeZu+B2NQQTT968amXOttyB4jONYC7h6r9MenPeo9591jaWkNg
        JynG/88ZSeMnyaDfyckDCRoRbEZwzAZFHhBvMuooOXg46bY1
X-Google-Smtp-Source: APXvYqxb7kAAIQOYi6NIO88tPaGB5WY6XFDxOwutSIA+5U15c210LsqChLQa8wZnfQmIja4EtVDOm50QmOP9Xwn9jT6+ULVV9hd4
MIME-Version: 1.0
X-Received: by 2002:a24:548:: with SMTP id 69mr872877itl.29.1553709248005;
 Wed, 27 Mar 2019 10:54:08 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:54:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfda050585171f3b@google.com>
Subject: KMSAN: uninit-value in tipc_nl_compat_bearer_enable (2)
From:   syzbot <syzbot+8b707430713eb46e1e45@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9536b452 kmsan: uaccess.h: fix variable name conflicts
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=15f5d583200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5675814e8eae69e
dashboard link: https://syzkaller.appspot.com/bug?extid=8b707430713eb46e1e45
compiler:       clang version 8.0.0 (trunk 350509)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16438e1b200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16898cd7200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8b707430713eb46e1e45@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in memchr+0xce/0x110 lib/string.c:961
CPU: 0 PID: 10526 Comm: syz-executor961 Not tainted 5.0.0+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:600
  __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
  memchr+0xce/0x110 lib/string.c:961
  string_is_valid net/tipc/netlink_compat.c:176 [inline]
  tipc_nl_compat_bearer_enable+0x2c4/0x910 net/tipc/netlink_compat.c:401
  __tipc_nl_compat_doit net/tipc/netlink_compat.c:321 [inline]
  tipc_nl_compat_doit+0x3aa/0xaf0 net/tipc/netlink_compat.c:354
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1162 [inline]
  tipc_nl_compat_recv+0x1ae7/0x2750 net/tipc/netlink_compat.c:1265
  genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
  genl_rcv_msg+0x185f/0x1a60 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x431/0x620 net/netlink/af_netlink.c:2477
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0xf3e/0x1020 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x127f/0x1300 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg net/socket.c:632 [inline]
  ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2115
  __sys_sendmsg net/socket.c:2153 [inline]
  __do_sys_sendmsg net/socket.c:2162 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2160
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2160
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440209
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc77bfd0a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440209
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a90
R13: 0000000000401b20 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:205 [inline]
  kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:159
  kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:176
  kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:185
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2773 [inline]
  __kmalloc_node_track_caller+0xe9e/0xff0 mm/slub.c:4398
  __kmalloc_reserve net/core/skbuff.c:140 [inline]
  __alloc_skb+0x309/0xa20 net/core/skbuff.c:208
  alloc_skb include/linux/skbuff.h:1012 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
  netlink_sendmsg+0xb82/0x1300 net/netlink/af_netlink.c:1892
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg net/socket.c:632 [inline]
  ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2115
  __sys_sendmsg net/socket.c:2153 [inline]
  __do_sys_sendmsg net/socket.c:2162 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2160
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2160
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
