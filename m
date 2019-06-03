Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BABC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E89E25ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFCVq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:46:57 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:33550 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFCVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 17:46:57 -0400
Received: by mail-it1-f200.google.com with SMTP id z7so691667itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 14:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zy+G7CpgELhLwgzs/ScfOsi6z+cOCikk738HcwlNl2M=;
        b=ktAveZjLvLXAVj7he284zzprV2fxMoOnOkxYbv+8Kh6YKwSxYSyvgK1chgR9Zw5Stc
         xQPDA0BlPxb44b7tvIfMgiOtQdGoc46FHKCdVpaB6uFsE9k8fhumYJWd5Y6f7k0n+Nve
         UnClmSOJ1CU6sOxCSwAaM77Bb2S0oGs9mXZVZfTjzOLWaSu/wOiW5WLb/l3UNm01lVCM
         TTzqEWIt8Cp/+w+LWz4i5LqY2sA3/lvtf6OUK9OmTT15BLjSGLoYdYr+qgFAtY2Urh90
         Z02DArhQVKpiHVgfkPA+cNuOx7tCUeOGWaovMbEHNf8W7jb4iBjvAGYTU+KIJ3EoXURt
         M8HQ==
X-Gm-Message-State: APjAAAXlSQk8GVULdWfDz33G6iyuKf18920vBv2ELWPPwEMD7phdce4Y
        SVoP441KV5PHIcxlijj9VhUXDNSooWwR6VoYfvgezVJa8/Q6
X-Google-Smtp-Source: APXvYqwmPGLNecgCGODGKgKJBDEzDLmk5wLcXzOhpW2pvyGFBZA3BINPBhUXmcKOpGkbD6FtVQKBDBIrb1Hwd/5PqbkyAfSsRKsZ
MIME-Version: 1.0
X-Received: by 2002:a6b:14c2:: with SMTP id 185mr3504074iou.69.1559594465472;
 Mon, 03 Jun 2019 13:41:05 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:41:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bb6d7058a716205@google.com>
Subject: memory leak in raw_sendmsg
From:   syzbot <syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3ab4436f Merge tag 'nfsd-5.2-1' of git://linux-nfs.org/~bf..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158090a6a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50393f7bfe444ff6
dashboard link: https://syzkaller.appspot.com/bug?extid=a90604060cb40f5bdd16
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e42092a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1327b0a6a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com

DRCONF(NETDEV_CHANGE): hsr_slave_0: link becomes ready
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88812af50600 (size 512):
   comm "syz-executor081", pid 7046, jiffies 4294948162 (age 13.870s)
   hex dump (first 32 bytes):
     0d 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
     9d 92 de d5 ec ad bc 02 6f 66 69 6c 65 3d 30 20  ........ofile=0
   backtrace:
     [<00000000c4297f99>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000c4297f99>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000c4297f99>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000c4297f99>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<0000000066d13723>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<0000000066d13723>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<00000000ed0585ca>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:138
     [<000000009a9dc318>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
     [<00000000926a7d5b>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<00000000926a7d5b>] alloc_skb_with_frags+0x5f/0x250  
net/core/skbuff.c:5327
     [<00000000c4ab3faa>] sock_alloc_send_pskb+0x269/0x2a0  
net/core/sock.c:2219
     [<00000000723cdeb0>] sock_alloc_send_skb+0x32/0x40 net/core/sock.c:2236
     [<000000009ba80e2d>] raw_sendmsg+0xce/0x300 net/can/raw.c:761
     [<0000000000a68d92>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<0000000000a68d92>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<000000004e3a95f6>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2286
     [<00000000ec078bc9>] __sys_sendmsg+0x80/0xf0 net/socket.c:2324
     [<0000000002d8ab21>] __do_sys_sendmsg net/socket.c:2333 [inline]
     [<0000000002d8ab21>] __se_sys_sendmsg net/socket.c:2331 [inline]
     [<0000000002d8ab21>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2331
     [<0000000007c3590d>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000003149a5e4>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888118308200 (size 224):
   comm "syz-executor081", pid 7046, jiffies 4294948162 (age 13.870s)
   hex dump (first 32 bytes):
     b0 64 19 2a 81 88 ff ff b0 64 19 2a 81 88 ff ff  .d.*.....d.*....
     00 90 28 24 81 88 ff ff 00 64 19 2a 81 88 ff ff  ..($.....d.*....
   backtrace:
     [<0000000085e706a4>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<0000000085e706a4>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000085e706a4>] slab_alloc mm/slab.c:3326 [inline]
     [<0000000085e706a4>] kmem_cache_alloc+0x134/0x270 mm/slab.c:3488
     [<000000005a366403>] skb_clone+0x6e/0x140 net/core/skbuff.c:1321
     [<00000000854d44b1>] __skb_tstamp_tx+0x19f/0x220 net/core/skbuff.c:4434
     [<0000000091e53e01>] __dev_queue_xmit+0x920/0xd60 net/core/dev.c:3813
     [<0000000043e22300>] dev_queue_xmit+0x18/0x20 net/core/dev.c:3910
     [<0000000091bdc746>] can_send+0x138/0x2b0 net/can/af_can.c:290
     [<000000002dddbaef>] raw_sendmsg+0x1bb/0x300 net/can/raw.c:780
     [<0000000000a68d92>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<0000000000a68d92>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<000000004e3a95f6>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2286
     [<00000000ec078bc9>] __sys_sendmsg+0x80/0xf0 net/socket.c:2324
     [<0000000002d8ab21>] __do_sys_sendmsg net/socket.c:2333 [inline]
     [<0000000002d8ab21>] __se_sys_sendmsg net/socket.c:2331 [inline]
     [<0000000002d8ab21>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2331
     [<0000000007c3590d>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000003149a5e4>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
