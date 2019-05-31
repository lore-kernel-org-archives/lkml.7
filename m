Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A0EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4ED26F38
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfEaVSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:18:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42330 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfEaVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:18:07 -0400
Received: by mail-io1-f71.google.com with SMTP id v187so8622392ioe.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9vJ5p7g65WszXpcgdHNrhcEVIXylvGJSGHu7KxUMRl0=;
        b=GjZCYpL0MtNOcebeRLhgiLryElqqAjy9bX8yBUJ02py6Gvald72ogF4kqugb9skj3U
         GmcZzzY8qGumK3mGION2Ggp0pLbd3l8TwU7eFLHBqiNwb0qFs1Z7EAZ5sT0ocmYHPxsE
         fLfyfg6xYQd+RjoN6Rjv6LxP6pHHpYhtVfQPtyztApf1QYpLYvv7ssq92Pt82sV4thJp
         rp8szy8C5X64QjuTF8mpJiPTsXebsYbeSLVyf0ONujKI2ejjgEsB77odQz48zudROwCz
         1yt1gBvMjVQNzzIy0oTUELleQn7Rbvj00fFc3eUgYP33qkkAdu/GCsfVhsSNqF/hTDAS
         85kg==
X-Gm-Message-State: APjAAAWYT23VQsOIbj5XuiKEUwQNp5H7PkOE/o9F6PrZ3KXxGP/dxDGQ
        F4f/NIKLNUc927y4kSEqK/JK6yDg0dMOBj8edzVAKYHSzueM
X-Google-Smtp-Source: APXvYqyQthWYZkYEzHAw27Fklkf9ijpz/D7EU/qN25ZeTvfoP8xszP9EdDcihQRxiZOU0u7xwOU77U09S102kJHodTHCUDVE0ATP
MIME-Version: 1.0
X-Received: by 2002:a05:660c:6c1:: with SMTP id z1mr9492253itk.126.1559337486489;
 Fri, 31 May 2019 14:18:06 -0700 (PDT)
Date:   Fri, 31 May 2019 14:18:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7a443058a358cb4@google.com>
Subject: memory leak in sctp_send_reset_streams
From:   syzbot <syzbot+6ad9c3bd0a218a2ab41d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    036e3431 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153cff12a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f0f63a62bb5b13c
dashboard link: https://syzkaller.appspot.com/bug?extid=6ad9c3bd0a218a2ab41d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12561c86a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b76fd8a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6ad9c3bd0a218a2ab41d@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888123894820 (size 32):
   comm "syz-executor045", pid 7267, jiffies 4294943559 (age 13.660s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000c7e71c69>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000c7e71c69>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000c7e71c69>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000c7e71c69>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000c7e71c69>] __kmalloc+0x161/0x2c0 mm/slab.c:3669
     [<000000003250ed8e>] kmalloc_array include/linux/slab.h:670 [inline]
     [<000000003250ed8e>] kcalloc include/linux/slab.h:681 [inline]
     [<000000003250ed8e>] sctp_send_reset_streams+0x1ab/0x5a0  
net/sctp/stream.c:302
     [<00000000cd899c6e>] sctp_setsockopt_reset_streams  
net/sctp/socket.c:4314 [inline]
     [<00000000cd899c6e>] sctp_setsockopt net/sctp/socket.c:4765 [inline]
     [<00000000cd899c6e>] sctp_setsockopt+0xc23/0x2bf0 net/sctp/socket.c:4608
     [<00000000ff3a21a2>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3130
     [<000000009eb87ae7>] __sys_setsockopt+0x98/0x120 net/socket.c:2078
     [<00000000e0ede6ca>] __do_sys_setsockopt net/socket.c:2089 [inline]
     [<00000000e0ede6ca>] __se_sys_setsockopt net/socket.c:2086 [inline]
     [<00000000e0ede6ca>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2086
     [<00000000c61155f5>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000e540958c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888123894980 (size 32):
   comm "syz-executor045", pid 7268, jiffies 4294944145 (age 7.800s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000c7e71c69>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000c7e71c69>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000c7e71c69>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000c7e71c69>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000c7e71c69>] __kmalloc+0x161/0x2c0 mm/slab.c:3669
     [<000000003250ed8e>] kmalloc_array include/linux/slab.h:670 [inline]
     [<000000003250ed8e>] kcalloc include/linux/slab.h:681 [inline]
     [<000000003250ed8e>] sctp_send_reset_streams+0x1ab/0x5a0  
net/sctp/stream.c:302
     [<00000000cd899c6e>] sctp_setsockopt_reset_streams  
net/sctp/socket.c:4314 [inline]
     [<00000000cd899c6e>] sctp_setsockopt net/sctp/socket.c:4765 [inline]
     [<00000000cd899c6e>] sctp_setsockopt+0xc23/0x2bf0 net/sctp/socket.c:4608
     [<00000000ff3a21a2>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3130
     [<000000009eb87ae7>] __sys_setsockopt+0x98/0x120 net/socket.c:2078
     [<00000000e0ede6ca>] __do_sys_setsockopt net/socket.c:2089 [inline]
     [<00000000e0ede6ca>] __se_sys_setsockopt net/socket.c:2086 [inline]
     [<00000000e0ede6ca>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2086
     [<00000000c61155f5>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000e540958c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
