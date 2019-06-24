Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136E2C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E368320674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfFXH1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:27:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42736 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfFXH1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:27:09 -0400
Received: by mail-io1-f71.google.com with SMTP id f22so20913632ioj.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 00:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DEVVWbQIpcKiGaEL1OeL/uHZLC+7iHXkjElkvv6yNDs=;
        b=W2ckJ32S329IgaMDrFlX0YngGg2DRdaafLMsCqqI6tgs1stozZMUkWnUugSuFpPJCl
         daxi3cvW2+fD680nqCwCbFPFxElbKXxx9yD5/QlRaTGBgeHvlXv5UHVqPpLDdFINaCIE
         2aqvpk5M93WgmxDNdkTVnpvU/tMOL+LDscyBYmwCt+mBmDiaKWaTrkqaPcW+HMH3XiT5
         Fwv1tG72PEYuTSyK84/e31PMHFm0P+3UlBUeAvYhYr2wHEcIbg0Mh5oX0EKO1miEK1+Q
         quJWzW1UedyPJ7J02WjUDBOi3JefshQrhcC5mnW8LyVEW0jOvNGO6T1bqNT65hZJomd9
         8JxQ==
X-Gm-Message-State: APjAAAXXwXkmyaWeYbNXV3gdQJkWr2OLfVskmac7xpxci/UiBeQw5xOd
        QNE43CMcjhCHKu2FofUI15VHMfhs1FMGmKFeqPCoiFdFJxE/
X-Google-Smtp-Source: APXvYqxk/7wWV7qeNRICEoEKQ5nLZqTZ2KrzWfgQqu8WmCNIav+2pgUhXSO8eHF8oD5GO+nZPJUoawqg2tUUMMQvI/+i26en7GQg
MIME-Version: 1.0
X-Received: by 2002:a02:b395:: with SMTP id p21mr39171996jan.31.1561361228546;
 Mon, 24 Jun 2019 00:27:08 -0700 (PDT)
Date:   Mon, 24 Jun 2019 00:27:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064c849058c0cbdc9@google.com>
Subject: memory leak in sctp_v4_create_accept_sk
From:   syzbot <syzbot+afabda3890cc2f765041@syzkaller.appspotmail.com>
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

HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13470eb2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce
dashboard link: https://syzkaller.appspot.com/bug?extid=afabda3890cc2f765041
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15100a91a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c46026a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+afabda3890cc2f765041@syzkaller.appspotmail.com

ffffffffda RBX: 00000000006fbc38 RCX: 0000000000446a79
BUG: memory leak
unreferenced object 0xffff888118137680 (size 1352):
   comm "syz-executor360", pid 7164, jiffies 4294941839 (age 13.960s)
   hex dump (first 32 bytes):
     ac 14 ff aa 0a 80 01 1a 00 00 00 00 00 00 00 00  ................
     02 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
   backtrace:
     [<000000006c358063>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000006c358063>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000006c358063>] slab_alloc mm/slab.c:3326 [inline]
     [<000000006c358063>] kmem_cache_alloc+0x134/0x270 mm/slab.c:3488
     [<00000000f2fb26e7>] sk_prot_alloc+0x41/0x170 net/core/sock.c:1596
     [<000000003c036edc>] sk_alloc+0x35/0x2f0 net/core/sock.c:1656
     [<00000000c25725a4>] sctp_v4_create_accept_sk+0x32/0xb0  
net/sctp/protocol.c:556
     [<0000000049bd7e55>] sctp_accept+0x1df/0x290 net/sctp/socket.c:4913
     [<00000000d287a63e>] inet_accept+0x4e/0x1d0 net/ipv4/af_inet.c:734
     [<00000000acb0fc20>] __sys_accept4+0x12a/0x280 net/socket.c:1760
     [<00000000bbdaf60b>] __do_sys_accept4 net/socket.c:1795 [inline]
     [<00000000bbdaf60b>] __se_sys_accept4 net/socket.c:1792 [inline]
     [<00000000bbdaf60b>] __x64_sys_accept4+0x22/0x30 net/socket.c:1792
     [<000000006da547ee>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000025f5c93>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
