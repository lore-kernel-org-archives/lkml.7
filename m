Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EBCCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 19:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F302190F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 19:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfKCTmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 14:42:13 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:36102 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfKCTmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 14:42:12 -0500
Received: by mail-io1-f69.google.com with SMTP id g126so11854741iof.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 11:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=awQhjle+FaLC9uUjFXzhNsJ221l57a1RcSqWPFMPa5s=;
        b=N1LoeYCWbqqq9RWAgZUGGU7xEjffNYGibNV2OYlsCKIcDaVPfeY/6cQiVymrDJLzJL
         2tLuFd3W9IzBI7y8pr5a3oKf2jOfC+ZxjwUCAwp4bUFmLwaa/QSjt5/trk3Nz1uKezwQ
         E96tkX57RxbDDHIBVIokEaHFbTY8JoUkb36U2fruQPVc9Aed3FKcUxZBYzUGjQ6FT1yj
         JN9pdgoP7jXKhOAz9Muy4PKAxOMgdfrVECG3GJ0a3pPVpPt5gxfdkx8nibI7Bv32mPZC
         dYQS7ixxl2tadXxmcFDj3TbUA2Rd/YbmGfh5kGHebLMIHMDX9ahi2agXj6vl8NG19ggR
         APlA==
X-Gm-Message-State: APjAAAUk7XjlmAPwzmJnWVFn3km4MAkOVV9nFPW97XInU0qLYM/LjtIO
        A1w+aEBHHtTU5k6JQaxG+rcdK+nepsymMVjEGoWBlHlalpJq
X-Google-Smtp-Source: APXvYqxryy7TADqCTPAy7/I6C1Oi4J/Pvvl+29fRoQrDj0BQ0G2e8rUupbdtQigNWgrMFm2zryoD/seFOm/rFy8t9pn+Z3OpQTHr
MIME-Version: 1.0
X-Received: by 2002:a92:8459:: with SMTP id l86mr25301931ild.236.1572810130173;
 Sun, 03 Nov 2019 11:42:10 -0800 (PST)
Date:   Sun, 03 Nov 2019 11:42:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bb91805967665d9@google.com>
Subject: memory leak in smc_create
From:   syzbot <syzbot+4b73ad6fc767e576e275@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kgraul@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        ubraun@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9d234505 Merge tag 'hwmon-for-v5.4-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c4e4ece00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9bbb8fba7651600b
dashboard link: https://syzkaller.appspot.com/bug?extid=4b73ad6fc767e576e275
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f6dc68e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124c8934e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4b73ad6fc767e576e275@syzkaller.appspotmail.com

executing program
executing program
BUG: memory leak
unreferenced object 0xffff888121495640 (size 1376):
   comm "syz-executor038", pid 6906, jiffies 4294945610 (age 13.070s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
   backtrace:
     [<00000000930d5c59>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000930d5c59>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000930d5c59>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000930d5c59>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000249c491d>] sk_prot_alloc+0x41/0x170 net/core/sock.c:1599
     [<0000000035a03310>] sk_alloc+0x35/0x2f0 net/core/sock.c:1659
     [<00000000e79e3c49>] smc_sock_alloc+0x4a/0x1a0 net/smc/af_smc.c:222
     [<0000000079a84e95>] smc_create+0x6b/0x160 net/smc/af_smc.c:1979
     [<00000000607f3b4e>] __sock_create+0x164/0x250 net/socket.c:1418
     [<00000000fbb3e501>] sock_create net/socket.c:1469 [inline]
     [<00000000fbb3e501>] __sys_socket+0x69/0x110 net/socket.c:1511
     [<00000000d697ec9a>] __do_sys_socket net/socket.c:1520 [inline]
     [<00000000d697ec9a>] __se_sys_socket net/socket.c:1518 [inline]
     [<00000000d697ec9a>] __x64_sys_socket+0x1e/0x30 net/socket.c:1518
     [<00000000dcb4ba7a>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<000000009386b4f0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
