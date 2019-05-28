Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942E2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DB3208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfE1S2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:28:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51206 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfE1S2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:28:07 -0400
Received: by mail-io1-f69.google.com with SMTP id i20so16435687ioo.18
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 11:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wStfY5SxDIxZd91+yxT/nL82TSXTHhm/NMlB2xHEX/A=;
        b=ighvUrIgRBzZ22b+ylkvZjLViUutjjdfhGXjSwONNPFI5LvmcWxcOR1XGPh4HUuU2I
         xL6pIJRSDblMZMOgsZXZeydbfGQp5naZLfOFFTtquSAuhfJyfwsyWcQSqb/hsDVTeRt5
         xRjQfXmL3sjPE5psEU8byDJGSXXlFksMfnCINiM0d6BBdQANDIi3+lHPUY5zEA/5qtY6
         aKflE+1jQ6KHi3I3V183RtHXQywL2VZKEGUkScSUqRBprHOFsbrP4tpjbNZJIHW7Loyy
         Ri8Ej9zrIq5JslmNvJxCyXSWqf1zXj+pA+UZmGcM9rHC2Q6sr3T0/2NrBUXYdiZcvgpQ
         nX+w==
X-Gm-Message-State: APjAAAUe8ULItmk6WK4HHD+FV6zBfOX5Kl86xdwqhq3zZfDCnNo2f3A6
        g6YEsrP28PBAMit6E6lx7bsQ0Sm2py/Hev7Z7eMC/V58ilgp
X-Google-Smtp-Source: APXvYqyXhAH/FRlDsdV97oRkUMOUekf3d8E19Vn9d1A4DEaa/dY9SeQWsHwrz1YafFdfImJuz4kIZNK3hQK9A4y2zGfX7MsNM/ts
MIME-Version: 1.0
X-Received: by 2002:a24:1455:: with SMTP id 82mr4455130itg.59.1559068085434;
 Tue, 28 May 2019 11:28:05 -0700 (PDT)
Date:   Tue, 28 May 2019 11:28:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069c3140589f6d3b7@google.com>
Subject: memory leak in sctp_get_port_local
From:   syzbot <syzbot+079bf326b38072f849d9@syzkaller.appspotmail.com>
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

HEAD commit:    cd6c84d8 Linux 5.2-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101a184aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64479170dcaf0e11
dashboard link: https://syzkaller.appspot.com/bug?extid=079bf326b38072f849d9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b5dbbca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1038444aa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+079bf326b38072f849d9@syzkaller.appspotmail.com

: Permanently added '10.128.0.127' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff8881288ca380 (size 64):
   comm "softirq", pid 0, jiffies 4294944468 (age 13.410s)
   hex dump (first 32 bytes):
     21 4e 00 00 00 00 00 00 00 00 00 00 00 00 00 00  !N..............
     28 ae 85 23 81 88 ff ff 00 00 00 00 00 00 00 00  (..#............
   backtrace:
     [<0000000054ece54d>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<0000000054ece54d>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000054ece54d>] slab_alloc mm/slab.c:3326 [inline]
     [<0000000054ece54d>] kmem_cache_alloc+0x134/0x270 mm/slab.c:3488
     [<00000000d992ea84>] sctp_bucket_create net/sctp/socket.c:8395 [inline]
     [<00000000d992ea84>] sctp_get_port_local+0x189/0x5b0  
net/sctp/socket.c:8142
     [<0000000099206d90>] sctp_do_bind+0xcc/0x1e0 net/sctp/socket.c:402
     [<00000000b8795757>] sctp_bind+0x44/0x70 net/sctp/socket.c:302
     [<00000000672a44aa>] inet6_bind+0x40/0xb7 net/ipv6/af_inet6.c:445
     [<0000000001400e1c>] __sys_bind+0x11c/0x140 net/socket.c:1659
     [<00000000e69e8036>] __do_sys_bind net/socket.c:1670 [inline]
     [<00000000e69e8036>] __se_sys_bind net/socket.c:1668 [inline]
     [<00000000e69e8036>] __x64_sys_bind+0x1e/0x30 net/socket.c:1668
     [<000000001644bb1f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000199a1ea2>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
