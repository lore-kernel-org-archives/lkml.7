Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A886C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2BB20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbfDARgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:36:08 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:39111 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfDARgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:36:06 -0400
Received: by mail-it1-f200.google.com with SMTP id e124so210525ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oYoF4wWutlhyvM9EivEwAfpM3+7xQNW77+I3kO5sBAI=;
        b=tlI3PuV8JdV3q6dldjj8z6dpDTS3uvZ/0KgJ4mcUaXQ4IK2DyfBbvyV4LWTVXU5zHr
         5RbzFNonD3Ds9XH4oEwC99+Cvj1vCkTcOSu70JYwThogKb2zFUui9Lxo90ejFTCG5m8x
         iwxiDvX4QYxP6A5YrWzG5U5FM/JDVoa0tCKA6kzlfSzF0TN8FfqLHTRF64j84mPXAt4T
         0OloVUoHe/5HA5ViHVtdIvkr+sv1wZ8WxB1/gSQkPub7mmQBj3icUUbec4wT+NQ1nsp3
         nQz4RJyYf4jHityFgrs6AubYKk+urvPUmdsi0QrBgz50c+7UYDS9bbqeSc6M5p7Cjy3p
         k39w==
X-Gm-Message-State: APjAAAUwzLf2O2asMS985TKspP75G2nmymnTum1Wqj2yXAsmvaOuqfj7
        Vs4INfwgPJQqCc3mwH3mTTWi7N5elOfhBPCrklvkmclHMr0h
X-Google-Smtp-Source: APXvYqycu3S2s2moCqnrkWqRS+aNoPsOtWfo+4BvV3lFhawC9rALQLeg7aYa9VCCD6Tym2pulg3Io8a6itnUVIGocIASsjEHRvjj
MIME-Version: 1.0
X-Received: by 2002:a6b:c403:: with SMTP id y3mr603291ioa.38.1554140165827;
 Mon, 01 Apr 2019 10:36:05 -0700 (PDT)
Date:   Mon, 01 Apr 2019 10:36:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008424a205857b74ef@google.com>
Subject: general protection fault in refcount_sub_and_test_checked
From:   syzbot <syzbot+31b6a0f5d6d5c3b75948@syzkaller.appspotmail.com>
To:     andrew.hendry@gmail.com, davem@davemloft.net, edumazet@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-x25@vger.kernel.org, ms@dev.tdt.de, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    35f861e3 net: bridge: use netif_is_bridge_port()
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10a188ab200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e9bc94c16d346a6
dashboard link: https://syzkaller.appspot.com/bug?extid=31b6a0f5d6d5c3b75948
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+31b6a0f5d6d5c3b75948@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 12245 Comm: syz-executor.4 Not tainted 5.1.0-rc2+ #115
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:193 [inline]
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
RIP: 0010:refcount_sub_and_test_checked+0x8e/0x200 lib/refcount.c:182
Code: f3 f3 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 36 8a 40 fe be  
04 00 00 00 48 89 df e8 29 65 78 fe 48 89 d8 48 c1 e8 03 <42> 0f b6 14 20  
48 89 d8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85
RSP: 0018:ffff88808d0bfbc8 EFLAGS: 00010202
RAX: 0000000000000019 RBX: 00000000000000c8 RCX: ffffffff832fe757
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00000000000000c8
RBP: ffff88808d0bfc60 R08: 1ffffffff12853c4 R09: fffffbfff12853c5
R10: fffffbfff12853c4 R11: ffffffff89429e23 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88808d0bfc38 R15: 1ffff11011a17f7b
FS:  00007f4fa8af9700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000680c78 CR3: 0000000090024000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  refcount_dec_and_test_checked+0x1b/0x20 lib/refcount.c:220
  x25_neigh_put include/net/x25.h:252 [inline]
  x25_connect+0x8d8/0xea0 net/x25/af_x25.c:825
  __sys_connect+0x266/0x330 net/socket.c:1808
  __do_sys_connect net/socket.c:1819 [inline]
  __se_sys_connect net/socket.c:1816 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1816
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458209
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4fa8af8c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458209
RDX: 0000000000000012 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 000000000073c220 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4fa8af96d4
R13: 00000000004be6b3 R14: 00000000004cf2f0 R15: 00000000ffffffff
Modules linked in:
---[ end trace 98127f094cb116c1 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:193 [inline]
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
RIP: 0010:refcount_sub_and_test_checked+0x8e/0x200 lib/refcount.c:182


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
