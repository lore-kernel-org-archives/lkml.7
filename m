Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E608CC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9316206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfIPKTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:19:14 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42234 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbfIPKTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:19:08 -0400
Received: by mail-io1-f70.google.com with SMTP id x9so50052935ior.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 03:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2TY2lBFk1if3tC3oyWyoCR1kViN6/jvV9jPqbnjNioI=;
        b=hP+wsbu7gpT9pOZK92IIPhN7q73qacgsY8DwOpFZ03/fcLqMfM58C0NTpE2YZS6+xN
         4153BALRx4D5ZXCeJgOnKiLAIufBO50EnTHj4rqXVW6JBbyES0WIEl7MwldavbXtl+2I
         fshK+xJ+UdPHMU2XAjd/n+yeJXvErvafdvZbDbRyKnQPDK2o6/lMzqKYGNahpShRDjbc
         DCoUPJJARXcC7IWD2rOZepRxiEVMsqAbNPDq1s0SDqEET76k65MVk0cOjrYBr2GjvrpU
         hpWh1/uIoviI8RSGI9nCqFG71VEEM82uAfPYiQOmFWDM3D7XiBLZWHpo9X7uNjRE4P7E
         nrJw==
X-Gm-Message-State: APjAAAVqqklK1NuRRPCFxA/gM1byVPyMS2zGeN8dOgC77d4WoZ8CwUL/
        5C1HdZYP7VSu5Sk87wxu4r/f0hwwmlPFoUslVX1VkFl+nNX6
X-Google-Smtp-Source: APXvYqyRthIhVDzE4entVdIPKBCLHpjSnWAPjUTOwDLGwJZVXGGKsPpL9V6dX6zkX6+fnjW0TCnYj3jdSsqmKqhz7m/wC+035od6
MIME-Version: 1.0
X-Received: by 2002:a5e:da4d:: with SMTP id o13mr14353100iop.124.1568629147163;
 Mon, 16 Sep 2019 03:19:07 -0700 (PDT)
Date:   Mon, 16 Sep 2019 03:19:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019e6c20592a8ef5d@google.com>
Subject: KMSAN: uninit-value in __request_module
From:   syzbot <syzbot+618aacd49e8c8b8486bd@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    014077b5 DO-NOT-SUBMIT: usb-fuzzer: main usb gadget fuzzer..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10820859600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
dashboard link: https://syzkaller.appspot.com/bug?extid=618aacd49e8c8b8486bd
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171a72f1600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162ff949600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+618aacd49e8c8b8486bd@syzkaller.appspotmail.com

netlink: 76 bytes leftover after parsing attributes in process  
`syz-executor501'.
==================================================================
BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:606 [inline]
BUG: KMSAN: uninit-value in string+0x4be/0x600 lib/vsprintf.c:668
CPU: 1 PID: 12341 Comm: syz-executor501 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  string_nocheck lib/vsprintf.c:606 [inline]
  string+0x4be/0x600 lib/vsprintf.c:668
  vsnprintf+0x218f/0x3210 lib/vsprintf.c:2503
  __request_module+0x2b1/0x11c0 kernel/kmod.c:143
  tcf_proto_lookup_ops+0x3e7/0x700 net/sched/cls_api.c:80
  tcf_proto_is_unlocked net/sched/cls_api.c:168 [inline]
  tc_new_tfilter+0xfe0/0x4ce0 net/sched/cls_api.c:2041
  rtnetlink_rcv_msg+0xcb6/0x1580 net/core/rtnetlink.c:5214
  netlink_rcv_skb+0x431/0x620 net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:5241
  netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
  netlink_unicast+0xf6c/0x1050 net/netlink/af_netlink.c:1328
  netlink_sendmsg+0x110f/0x1330 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg net/socket.c:657 [inline]
  ___sys_sendmsg+0x14ff/0x1590 net/socket.c:2311
  __sys_sendmsg net/socket.c:2356 [inline]
  __do_sys_sendmsg net/socket.c:2365 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2363
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2363
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:297
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x4401e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc3690c568 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401e9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a70
R13: 0000000000401b00 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:189 [inline]
  kmsan_internal_poison_shadow+0x58/0xb0 mm/kmsan/kmsan.c:148
  kmsan_slab_alloc+0xaa/0x120 mm/kmsan/kmsan_hooks.c:175
  slab_alloc_node mm/slub.c:2790 [inline]
  __kmalloc_node_track_caller+0xb55/0x1320 mm/slub.c:4388
  __kmalloc_reserve net/core/skbuff.c:141 [inline]
  __alloc_skb+0x306/0xa10 net/core/skbuff.c:209
  alloc_skb include/linux/skbuff.h:1056 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1174 [inline]
  netlink_sendmsg+0x783/0x1330 net/netlink/af_netlink.c:1892
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg net/socket.c:657 [inline]
  ___sys_sendmsg+0x14ff/0x1590 net/socket.c:2311
  __sys_sendmsg net/socket.c:2356 [inline]
  __do_sys_sendmsg net/socket.c:2365 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2363
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2363
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:297
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
