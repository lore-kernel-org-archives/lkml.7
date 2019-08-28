Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1396FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81E822CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfH1PCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:02:08 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48024 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfH1PCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:02:07 -0400
Received: by mail-io1-f71.google.com with SMTP id b22so3953674iod.14
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eu539FS/Z7Btb3QzUArh3SmOtWSvireNfrFuvIPgtBE=;
        b=gFdIFAxMqBiY/TFl9oeLYmr9DJpgT4DEa8luH8aiERpgUtyRzUecUJzCuuoa+I1uNl
         gtEdgp/ggqtaJWFHOujxhuwFFEy4t+dNxF7VpvvG3KA4qVscPOBH1spGNKb6mdGsuQ26
         C1v/B1D/DLChIvUR8Ct4LpYnhKN6wIA+T3wdEFByEguA9H7hPrJ+Acu73+cYJLZ2G783
         eMVfjQ0z52ZWfeZ+9i4WYAbe4UHMAax1qHXiSoEzrKSyp9YCWy0X1rY8ugFSb3zdjTuj
         /nA5u+WxGpt7fDwXay8CB0KXpEi+v4fWTJAnUfMORPyzD3eNeT7iYlhFYfDK4Twrmitd
         DcsQ==
X-Gm-Message-State: APjAAAUBhElRVY8jZbOEBjFATsIgSdsQTXFBhuh0iLpbZ+DUaui+XvlB
        YjAb8QRPJQdO4QtwZRCJRIMBmpnyv6X1/Ji85BzZtRYULdrz
X-Google-Smtp-Source: APXvYqzwE8A19rSH3hcqIFHzR8UX7yHb38ttALYpTM8PGsuecOx6RGW76+8BmerxLnoVe4V/c19tCJ74GeBDJUhqc0C1Bh31/URj
MIME-Version: 1.0
X-Received: by 2002:a5d:8c8b:: with SMTP id g11mr5136835ion.134.1567004526196;
 Wed, 28 Aug 2019 08:02:06 -0700 (PDT)
Date:   Wed, 28 Aug 2019 08:02:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025435f05912eacc8@google.com>
Subject: KASAN: slab-out-of-bounds Write in usb_hcd_poll_rh_status
From:   syzbot <syzbot+4f11661279f916ba5627@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, chunfeng.yun@mediatek.com,
        dtor@chromium.org, gregkh@linuxfoundation.org, jwilk@jwilk.net,
        laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rrangel@chromium.org,
        stern@rowland.harvard.edu, suwan.kim027@gmail.com,
        syzkaller-bugs@googlegroups.com, tweek@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a55aa89a Linux 5.3-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12899ca2600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a6a2b9826fdadf9
dashboard link: https://syzkaller.appspot.com/bug?extid=4f11661279f916ba5627
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4f11661279f916ba5627@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:359 [inline]
BUG: KASAN: slab-out-of-bounds in usb_hcd_poll_rh_status+0x423/0x6b0  
drivers/usb/core/hcd.c:774
Write of size 2 at addr ffff8880a8e964c0 by task syz-executor.4/9841

CPU: 1 PID: 9841 Comm: syz-executor.4 Not tainted 5.3.0-rc6 #146
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0xd4/0x306 mm/kasan/report.c:351
  __kasan_report.cold+0x1b/0x36 mm/kasan/report.c:482
  kasan_report+0x12/0x17 mm/kasan/common.c:618
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memcpy+0x38/0x50 mm/kasan/common.c:123
  memcpy include/linux/string.h:359 [inline]
  usb_hcd_poll_rh_status+0x423/0x6b0 drivers/usb/core/hcd.c:774
  rh_timer_func+0x19/0x20 drivers/usb/core/hcd.c:800
  call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1322
  expire_timers kernel/time/timer.c:1366 [inline]
  __run_timers kernel/time/timer.c:1685 [inline]
  __run_timers kernel/time/timer.c:1653 [inline]
  run_timer_softirq+0x697/0x17a0 kernel/time/timer.c:1698
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:537 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1133
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  </IRQ>
RIP: 0010:check_memory_region+0x1f/0x1a0 mm/kasan/generic.c:191
Code: 00 66 2e 0f 1f 84 00 00 00 00 00 48 85 f6 0f 84 34 01 00 00 48 b8 ff  
ff ff ff ff 7f ff ff 55 0f b6 d2 48 39 c7 48 89 e5 41 55 <41> 54 53 0f 86  
07 01 00 00 4c 8d 5c 37 ff 49 89 f8 48 b8 00 00 00
RSP: 0018:ffff88805ef17aa8 EFLAGS: 00000212 ORIG_RAX: ffffffffffffff13
RAX: ffff7fffffffffff RBX: 0000000000000000 RCX: ffffffff873d1e85
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff897e2fc0
RBP: ffff88805ef17ab0 R08: 1ffffffff12fc5f8 R09: fffffbfff12fc5f9
R10: fffffbfff12fc5f8 R11: ffffffff897e2fc7 R12: fffffbfff134b5c6
R13: ffff88805ef0e2c0 R14: ffffffff897e2fc0 R15: 0000000000000000
  __kasan_check_write+0x14/0x20 mm/kasan/common.c:98
  atomic64_cmpxchg include/asm-generic/atomic-instrumented.h:1463 [inline]
  atomic_long_cmpxchg_acquire include/asm-generic/atomic-long.h:418 [inline]
  __mutex_trylock_or_owner kernel/locking/mutex.c:111 [inline]
  __mutex_trylock kernel/locking/mutex.c:126 [inline]
  __mutex_lock_common kernel/locking/mutex.c:932 [inline]
  __mutex_lock+0x425/0x13c0 kernel/locking/mutex.c:1077
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1092
  nf_sockopt_find.constprop.0+0x2d/0x290 net/netfilter/nf_sockopt.c:67
  nf_sockopt net/netfilter/nf_sockopt.c:99 [inline]
  nf_getsockopt+0x30/0xd0 net/netfilter/nf_sockopt.c:122
  ip_getsockopt net/ipv4/ip_sockglue.c:1576 [inline]
  ip_getsockopt+0x176/0x1d0 net/ipv4/ip_sockglue.c:1556
  tcp_getsockopt net/ipv4/tcp.c:3665 [inline]
  tcp_getsockopt+0x8f/0xe0 net/ipv4/tcp.c:3659
  sock_common_getsockopt+0x94/0xd0 net/core/sock.c:3098
  __sys_getsockopt+0x16d/0x310 net/socket.c:2129
  __do_sys_getsockopt net/socket.c:2144 [inline]
  __se_sys_getsockopt net/socket.c:2141 [inline]
  __x64_sys_getsockopt+0xbe/0x150 net/socket.c:2141
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c38a
Code: b8 34 01 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 dd 8c fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 37 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ba 8c fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:0000000000a6f618 EFLAGS: 00000202 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 0000000000a6f640 RCX: 000000000045c38a
RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000714e80 R08: 0000000000a6f63c R09: 0000000000004000
R10: 0000000000a6f740 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000713380

Allocated by task 29984:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:493 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:466
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:507
  __do_kmalloc mm/slab.c:3655 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3664
  kmalloc include/linux/slab.h:557 [inline]
  proc_bulk+0x2f5/0x7f0 drivers/usb/core/devio.c:1168
  usbdev_do_ioctl+0x525/0x2d10 drivers/usb/core/devio.c:2443
  usbdev_ioctl+0x26/0x30 drivers/usb/core/devio.c:2600
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 25754:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:455
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:463
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3756
  kvfree+0x61/0x70 mm/util.c:488
  __vunmap+0x6c5/0x920 mm/vmalloc.c:2255
  __vfree+0x41/0xd0 mm/vmalloc.c:2299
  vfree+0x5f/0x90 mm/vmalloc.c:2329
  copy_entries_to_user net/ipv4/netfilter/ip_tables.c:867 [inline]
  get_entries net/ipv4/netfilter/ip_tables.c:1024 [inline]
  do_ipt_get_ctl+0x71a/0x930 net/ipv4/netfilter/ip_tables.c:1700
  nf_sockopt net/netfilter/nf_sockopt.c:104 [inline]
  nf_getsockopt+0x7a/0xd0 net/netfilter/nf_sockopt.c:122
  ip_getsockopt net/ipv4/ip_sockglue.c:1576 [inline]
  ip_getsockopt+0x176/0x1d0 net/ipv4/ip_sockglue.c:1556
  tcp_getsockopt net/ipv4/tcp.c:3665 [inline]
  tcp_getsockopt+0x8f/0xe0 net/ipv4/tcp.c:3659
  sock_common_getsockopt+0x94/0xd0 net/core/sock.c:3098
  __sys_getsockopt+0x16d/0x310 net/socket.c:2129
  __do_sys_getsockopt net/socket.c:2144 [inline]
  __se_sys_getsockopt net/socket.c:2141 [inline]
  __x64_sys_getsockopt+0xbe/0x150 net/socket.c:2141
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a8e964c0
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8880a8e964c0, ffff8880a8e964e0)
The buggy address belongs to the page:
page:ffffea0002a3a580 refcount:1 mapcount:0 mapping:ffff8880aa4001c0  
index:0xffff8880a8e96fc1
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000269fe08 ffffea000161c988 ffff8880aa4001c0
raw: ffff8880a8e96fc1 ffff8880a8e96000 000000010000003b 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a8e96380: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
  ffff8880a8e96400: 00 00 00 fc fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8880a8e96480: 00 00 fc fc fc fc fc fc 01 fc fc fc fc fc fc fc
                                            ^
  ffff8880a8e96500: 00 00 fc fc fc fc fc fc 00 00 fc fc fc fc fc fc
  ffff8880a8e96580: fb fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
