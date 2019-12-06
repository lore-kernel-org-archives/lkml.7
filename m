Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03425C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D112121823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfLFJbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:31:08 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:54410 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:31:08 -0500
Received: by mail-il1-f197.google.com with SMTP id t4so4791709ili.21
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 01:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pK4ZxCKpiJAZoUDvMUbG0xETDdTCbYaw+qcyxpMMxhE=;
        b=ZeJ+ujsVg7J4pTt/h7vXeMg5r50pGgYDulHJQbuw/uGRywgZQjhG7yOv1hQVONYCKJ
         m+IWkq86Az8H+HKDLs/f4YzkUK72v1qaITCXa23HZE4/PloGUP80nEkVvOuOaMcw0sX6
         X3x4daCkqdbQTtSF4oXNaq3wkC3PfNwiddrjfpzAEkVY9i0U3jtGBzseKyjKCA6LIikQ
         SINpZr5vsTcFtvjhYGLprqgul47OrYd5GsiPuQVakkZtVqF0F1m9Ay/lhEDVIGfjR9RE
         PzBdq2rbtnWgBoEqkWuzB8J/M2K682rjdQQLCVWorypZ1ZVeLTW337VtAJ2aWi+aWfPL
         oPMg==
X-Gm-Message-State: APjAAAXC5RNEqYvGkGHvygA2yMyokF/RgaVxnViSjR48xcFviDTNgC6l
        3pKpWTy2N9r5QPBMYh1CpclUWqDQZVdi8LGk9YK/ONXexwcX
X-Google-Smtp-Source: APXvYqy95rnuJMV5lS2hLIZWCWb+DeCFrODLR9MKwd92TZONaIkoJH5Q0ZxjeW164xKajVXjxbYGi+TqJkLk+HGr5KmyvCa5JE+5
MIME-Version: 1.0
X-Received: by 2002:a02:aa0c:: with SMTP id r12mr6353295jam.75.1575624667549;
 Fri, 06 Dec 2019 01:31:07 -0800 (PST)
Date:   Fri, 06 Dec 2019 01:31:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bd693059905b445@google.com>
Subject: KASAN: null-ptr-deref Write in x25_connect
From:   syzbot <syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andrew.hendry@gmail.com, arnd@arndb.de,
        davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, willemb@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9bd19c63 net: emulex: benet: indent a Kconfig depends cont..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14b858eae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333b76551307b2a0
dashboard link: https://syzkaller.appspot.com/bug?extid=429c200ffc8772bfe070
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in atomic_fetch_sub  
include/asm-generic/atomic-instrumented.h:199 [inline]
BUG: KASAN: null-ptr-deref in refcount_sub_and_test  
include/linux/refcount.h:253 [inline]
BUG: KASAN: null-ptr-deref in refcount_dec_and_test  
include/linux/refcount.h:281 [inline]
BUG: KASAN: null-ptr-deref in x25_neigh_put include/net/x25.h:252 [inline]
BUG: KASAN: null-ptr-deref in x25_connect+0x974/0x1020 net/x25/af_x25.c:820
Write of size 4 at addr 00000000000000c8 by task syz-executor.5/32400

CPU: 1 PID: 32400 Comm: syz-executor.5 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  __kasan_report.cold+0x5/0x41 mm/kasan/report.c:510
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  __kasan_check_write+0x14/0x20 mm/kasan/common.c:98
  atomic_fetch_sub include/asm-generic/atomic-instrumented.h:199 [inline]
  refcount_sub_and_test include/linux/refcount.h:253 [inline]
  refcount_dec_and_test include/linux/refcount.h:281 [inline]
  x25_neigh_put include/net/x25.h:252 [inline]
  x25_connect+0x974/0x1020 net/x25/af_x25.c:820
  __sys_connect_file+0x25d/0x2e0 net/socket.c:1847
  __sys_connect+0x51/0x90 net/socket.c:1860
  __do_sys_connect net/socket.c:1871 [inline]
  __se_sys_connect net/socket.c:1868 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1868
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a679
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa58a10ec78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 0000000000000012 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa58a10f6d4
R13: 00000000004c0f1c R14: 00000000004d4088 R15: 00000000ffffffff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
