Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6FC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 04:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DE6207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 04:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFFEmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 00:42:06 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:51039 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfFFEmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 00:42:06 -0400
Received: by mail-it1-f199.google.com with SMTP id o128so793519ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 21:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jg3IMyICyAggAtYwu8gxaeTlXjrOeF/JlxaaJDAnWpo=;
        b=M8zdZ5GRugOTPH5/F8InRDUwYM4wBUL0DFGDFSMH/gVcpH+0O7KdvVWLS7wxQy98Fk
         Xz6XP1bEr/V6cCPbams3IrgHbXFGg3nr9VjI6MQk2Uy9bIkVAQ8AVj9/VH2eAH2SMJaG
         RpLGoXEe96y+hvLoLi5RgxHXDl+PygXroZiliqsntw/tMGax8nDkA4MABKHIrTrMmp05
         ZwFFKTVl0BXsJBCsyR6r9afflgLEC7QNbGxIedNvE6JbySJ4+tVYeCXGsS8GANn2yC5q
         LhiqNlFxp1NedGr7Mc5DCtEp9KFDobzUHObxBURSV9W0lQMKcxL3qA652g+cGl0z2y4M
         uJTw==
X-Gm-Message-State: APjAAAUbol6dXPha7S+ohqUt0EZ0m1F8hn6oKzllEFNF+PATs/V54J2k
        FhrKuQ5bwpg7AZOt9vFrSmtyjVknG1ktiXvPDSWJ5Ml2m/ws
X-Google-Smtp-Source: APXvYqzvHdt56nf9FXot+jE/QrOSTHEUB9+3Bmg9YdmN9gYDfYWFwguwADCpaqB7afJr5U9K/JBF4QlbTZ97iqTZ/NWh4v8SYQpF
MIME-Version: 1.0
X-Received: by 2002:a5d:8f86:: with SMTP id l6mr22117632iol.97.1559796125425;
 Wed, 05 Jun 2019 21:42:05 -0700 (PDT)
Date:   Wed, 05 Jun 2019 21:42:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa6b60058aa0559b@google.com>
Subject: memory leak in rawv6_sendmsg
From:   syzbot <syzbot+0210b383c62bb2a35e32@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c50bbf61 Merge tag 'platform-drivers-x86-v5.2-2' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e86bf8a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61dd9e15a761691d
dashboard link: https://syzkaller.appspot.com/bug?extid=0210b383c62bb2a35e32
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131e5c9aa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14092dbca00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0210b383c62bb2a35e32@syzkaller.appspotmail.com

ed '10.128.1.53' (ECDSA) to the list of known hosts.
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff8881099cc500 (size 224):
   comm "syz-executor618", pid 7230, jiffies 4294944637 (age 13.010s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000dc438dab>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000dc438dab>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000dc438dab>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000dc438dab>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<00000000fdd6976f>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<000000007051ec41>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<000000007051ec41>] alloc_skb_with_frags+0x5f/0x250  
net/core/skbuff.c:5327
     [<00000000ff05b767>] sock_alloc_send_pskb+0x269/0x2a0  
net/core/sock.c:2225
     [<0000000007cd012b>] sock_alloc_send_skb+0x32/0x40 net/core/sock.c:2242
     [<00000000e26691f9>] rawv6_send_hdrinc net/ipv6/raw.c:644 [inline]
     [<00000000e26691f9>] rawv6_sendmsg+0x9c9/0x12f0 net/ipv6/raw.c:935
     [<000000003e27012a>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<000000005750e5ca>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<000000005750e5ca>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<000000002a4faea6>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2292
     [<00000000aee219ed>] __sys_sendmsg+0x80/0xf0 net/socket.c:2330
     [<00000000d1f2b00e>] __do_sys_sendmsg net/socket.c:2339 [inline]
     [<00000000d1f2b00e>] __se_sys_sendmsg net/socket.c:2337 [inline]
     [<00000000d1f2b00e>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2337
     [<00000000388062fd>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000009c436e23>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
