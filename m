Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5F420661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCGSZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:25:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:38107 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfCGSZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:25:06 -0500
Received: by mail-io1-f69.google.com with SMTP id z22so13442765iog.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=P7jkAY/IaiunUTM+5aI/eZef90H1kJjE88SMFc7v0Ok=;
        b=fKPG9JkqiliCXWOh8K72D9pvxWOnlc62XM33BiXoQMNEOCNlSk0DImvvS1jFanW38T
         SUh2DKFrrJ+uRn9VwiLqvvNS8GQESQ7HevSqoJ9KfEHVdscD0ZfObXbvdSbEEOHcBjmX
         2AtfPyvZy1EZp3SKKzmVNfnXmTciQmIb/DIxIuwgRgovjaMEpLoTuQqqDCI24kI+6EcQ
         FvVwuzYnevHEJMlHTm5Mem+zZDY/J+Onsho1zlGBtz5moCKshQFWKkFGnlT7cHs5GaQw
         luBAGRGdWQjYt7L6PflrecYY3u08115jQULZBvbAGBXGh/e7L0kDT7BQ9HjaZCUgHqlm
         YIsg==
X-Gm-Message-State: APjAAAVX9YdQhpa8VMphUL1shBrAOErkPFh5IpUt4YuaotKOAsKZ6/0i
        r1a91r/gv8e7AlxesdTCe221x6juH+X7RJTDqbwPRTdv6ApC
X-Google-Smtp-Source: APXvYqycw4rJvdH5k9rygmQkD9rAsaj2YALbTypGP8yyOyqiV7dcb+mYCQFQg0W54LYlfvtehW3KLXyEOll4d6sNyXozqxZ3mDRs
MIME-Version: 1.0
X-Received: by 2002:a6b:b608:: with SMTP id g8mr8183327iof.37.1551983105194;
 Thu, 07 Mar 2019 10:25:05 -0800 (PST)
Date:   Thu, 07 Mar 2019 10:25:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aec29a0583853924@google.com>
Subject: general protection fault in __queue_work
From:   syzbot <syzbot+b26e643d0aa2822e9c87@syzkaller.appspotmail.com>
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

HEAD commit:    3717f613f48d Merge branch 'core-rcu-for-linus' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156e100b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73d88a42238825ad
dashboard link: https://syzkaller.appspot.com/bug?extid=b26e643d0aa2822e9c87
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b26e643d0aa2822e9c87@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 23765 Comm: syz-executor.2 Not tainted 5.0.0+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:strlen+0x1f/0xa0 lib/string.c:483
Code: 00 66 2e 0f 1f 84 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48  
89 fa 48 89 e5 48 c1 ea 03 41 54 49 89 fc 53 48 83 ec 08 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 4d 41 80 3c 24
RSP: 0018:ffff88801b96f080 EFLAGS: 00010082
RAX: dffffc0000000000 RBX: ffff88809fe08428 RCX: 0000000000000000
kobject: 'loop0' (00000000c40c285a): kobject_uevent_env
RDX: 1d00000000200062 RSI: ffff8880ae82c831 RDI: e800000001000313
RBP: ffff88801b96f098 R08: 0000000000000000 R09: 0000000000000001
R10: ffffed1015d05bcf R11: 0000000000000001 R12: e800000001000313
R13: 0000000000000000 R14: ffff8880ae82c831 R15: ffff88801b96f168
FS:  00007f08e786c700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
kobject: 'loop0' (00000000c40c285a): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000004f616000 CR4: 00000000001426f0
Call Trace:
  trace_event_get_offsets_lock_acquire include/trace/events/lock.h:13  
[inline]
  perf_trace_lock_acquire+0xb9/0x580 include/trace/events/lock.h:13
  trace_lock_acquire include/trace/events/lock.h:13 [inline]
  lock_acquire+0x29c/0x3f0 kernel/locking/lockdep.c:3840
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  __queue_work+0x23d/0x1180 kernel/workqueue.c:1437
  __queue_delayed_work+0x1d6/0x270 kernel/workqueue.c:1542
  mod_delayed_work_on+0xd8/0x200 kernel/workqueue.c:1616
  mod_delayed_work include/linux/workqueue.h:542 [inline]
  addrconf_mod_dad_work+0x3f/0xa0 net/ipv6/addrconf.c:328
  addrconf_dad_start+0x76/0xb0 net/ipv6/addrconf.c:4012
  addrconf_add_linklocal+0x28c/0x3c0 net/ipv6/addrconf.c:3191
  addrconf_addr_gen+0x34d/0x3a0 net/ipv6/addrconf.c:3314
  addrconf_dev_config+0x1ea/0x2c0 net/ipv6/addrconf.c:3357
  addrconf_notify+0x3c5/0x2280 net/ipv6/addrconf.c:3592
  notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
  call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
  call_netdevice_notifiers net/core/dev.c:1765 [inline]
  __dev_notify_flags+0x121/0x2c0 net/core/dev.c:7605
  dev_change_flags+0x10d/0x170 net/core/dev.c:7643
  devinet_ioctl+0x1396/0x1c60 net/ipv4/devinet.c:1104
  inet_ioctl+0x1fc/0x370 net/ipv4/af_inet.c:954
  packet_ioctl+0xcb/0x2b0 net/packet/af_packet.c:4099
  sock_do_ioctl+0xde/0x300 net/socket.c:972
  sock_ioctl+0x32b/0x610 net/socket.c:1096
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457f29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f08e786bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457f29
RDX: 0000000020000240 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f08e786c6d4
R13: 00000000004c35d0 R14: 00000000004d6408 R15: 00000000ffffffff
Modules linked in:
---[ end trace 2c7811a1cf58c24e ]---
RIP: 0010:strlen+0x1f/0xa0 lib/string.c:483
Code: 00 66 2e 0f 1f 84 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48  
89 fa 48 89 e5 48 c1 ea 03 41 54 49 89 fc 53 48 83 ec 08 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 4d 41 80 3c 24
RSP: 0018:ffff88801b96f080 EFLAGS: 00010082
RAX: dffffc0000000000 RBX: ffff88809fe08428 RCX: 0000000000000000
RDX: 1d00000000200062 RSI: ffff8880ae82c831 RDI: e800000001000313
RBP: ffff88801b96f098 R08: 0000000000000000 R09: 0000000000000001
R10: ffffed1015d05bcf R11: 0000000000000001 R12: e800000001000313
kobject: 'kvm' (000000007d76adfd): kobject_uevent_env
R13: 0000000000000000 R14: ffff8880ae82c831 R15: ffff88801b96f168
FS:  00007f08e786c700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000004f616000 CR4: 00000000001426f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
