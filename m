Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB88FC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8972070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgAHJON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:14:13 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:45462 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgAHJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:14:12 -0500
Received: by mail-il1-f198.google.com with SMTP id w6so1628090ill.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EXQiOJPWQzOdrnnnIVhQj5CxHMZ/Ttuo08w2o7RVgDg=;
        b=AK0yPy2uaDrUN9OPuZ+X4rc2X3sJ0IoMjq3hNZ0Th+y+5b7N7mmmGC/ewYzcyzMhZV
         3qOQDdibobVvNEyzqQrmF4hRAUxC2TQ91CQNBv+/Bql9RxdtR9+IbtKH/+m9plxA20I3
         nc0pTW62NKk/XXfPXGZe00ZQ2FcCe1tEPmjMOwfN0tTKaleaX/DC2slGTxEofAWetPGM
         rRfumV7qBr/K9QwLPLkAG6RTmRmblYtoR5lpIUYN0YzQbO2wlK422DEBqku4EbWgAZX3
         k0F1/LHYkQU1sDz9f2v3rzITSpyAxBNOwr0s8gf3hLzqF6gAmADP8KzA6gEApBH3Kb2T
         OWvQ==
X-Gm-Message-State: APjAAAXTa9djan59JrRVKSvpKDv1QWBudHoVPbZGta7RG1DqzJ9psrK2
        W6fndKbhaqfx03yLJKzNhWsVfHzPJL3RTq5Z/D8c9UWjMSpy
X-Google-Smtp-Source: APXvYqwfVSkmxGwkNEiPAJpAf39zH1AilktfOrPFBR3seMwM5nBaHEO1knHovLNrxYRn0CF97VroIGlrV7tGlyYzcXvf28Ji2v3x
MIME-Version: 1.0
X-Received: by 2002:a6b:7e02:: with SMTP id i2mr2528960iom.172.1578474851558;
 Wed, 08 Jan 2020 01:14:11 -0800 (PST)
Date:   Wed, 08 Jan 2020 01:14:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d06ea3059b9d5097@google.com>
Subject: general protection fault in hash_netport4_uadt
From:   syzbot <syzbot+83fef78f45f4342655d8@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        gregkh@linuxfoundation.org, jeremy@azazel.net,
        kadlec@netfilter.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ae608821 Merge tag 'trace-v5.5-rc5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cd963ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18698c0c240ba616
dashboard link: https://syzkaller.appspot.com/bug?extid=83fef78f45f4342655d8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ac4076e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f582aee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83fef78f45f4342655d8@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9442 Comm: syz-executor534 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:hash_netport4_uadt+0x218/0xff0  
net/netfilter/ipset/ip_set_hash_netport.c:166
Code: 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 4d 0a 00 00 4c 89  
e2 45 8b 6d 04 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 4c  
89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 4c
RSP: 0018:ffffc90001e07160 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90001e07320 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff86811235 RDI: ffff888097483030
RBP: ffffc90001e072b8 R08: 0000000000000000 R09: 0000000000000000
R10: ffffed1015d0703c R11: ffff8880ae8381e3 R12: 0000000000000000
R13: 0000000004000000 R14: ffffc90001e07220 R15: 0000000000000002
FS:  0000000002029880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000f86 CR3: 000000009d29d000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip_set_utest+0x55b/0x890 net/netfilter/ipset/ip_set_core.c:1867
  nfnetlink_rcv_msg+0xcf2/0xfb0 net/netfilter/nfnetlink.c:229
  netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
  nfnetlink_rcv+0x1ba/0x460 net/netfilter/nfnetlink.c:563
  netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
  netlink_unicast+0x58c/0x7d0 net/netlink/af_netlink.c:1328
  netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:639 [inline]
  sock_sendmsg+0xd7/0x130 net/socket.c:659
  ____sys_sendmsg+0x753/0x880 net/socket.c:2330
  ___sys_sendmsg+0x100/0x170 net/socket.c:2384
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2417
  __do_sys_sendmsg net/socket.c:2426 [inline]
  __se_sys_sendmsg net/socket.c:2424 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2424
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4405e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffed104de78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004405e9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000024 R09: 00000000004002c8
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000401e70
R13: 0000000000401f00 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 0f2c9f8c52df08d8 ]---
RIP: 0010:hash_netport4_uadt+0x218/0xff0  
net/netfilter/ipset/ip_set_hash_netport.c:166
Code: 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 4d 0a 00 00 4c 89  
e2 45 8b 6d 04 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 4c  
89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 4c
RSP: 0018:ffffc90001e07160 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90001e07320 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff86811235 RDI: ffff888097483030
RBP: ffffc90001e072b8 R08: 0000000000000000 R09: 0000000000000000
R10: ffffed1015d0703c R11: ffff8880ae8381e3 R12: 0000000000000000
R13: 0000000004000000 R14: ffffc90001e07220 R15: 0000000000000002
FS:  0000000002029880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000f86 CR3: 000000009d29d000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
