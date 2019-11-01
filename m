Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F2CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419E9208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfKAPmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:42:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51739 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfKAPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:42:10 -0400
Received: by mail-io1-f71.google.com with SMTP id r11so7579810iom.18
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 08:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wdqcWsqWdSsBAG/dCLAgxIEVzXRX6deKIAs09SVnMZs=;
        b=IfeHcFTRnXp3eyFvTy9kznpgJGypXzlk2FeMXrsGcMMlx465X8F49/2ymkoFM0pmXf
         BYQtIPKhjr9Ps+Z20owdiH2n/Jb76lwq3WhPXHw0RLXvrgfeBfe4PTcRkXnoUoYpDQl7
         YZBt/ISfYUNfVsZt+ih5lZfmjS5lfzLQtUp8YhdAUefEUpG9Irx1p+lQM3WJmcPknnoi
         VuEFzg3xU7wixIsmQIr85qvu+4gTv3kvhvrndbM1AiLUrw1uQky0bg5ShsSSkHI+NF4P
         yvHdbrzw18y4+b66BwkzKdcNXH8E7Nj1H8BxH68ShjlDHRfTBk3bkamzbeZLckPs9G7E
         qmYw==
X-Gm-Message-State: APjAAAVrOq+dz6iGPWy9Hjhtmx2Jm+4HkQRnLb35cqJaR3DwKNrwHSRS
        GCwYr0LbyM8dQT72otG/4HTfamg9rHas1UnU63qbH5hvLM2f
X-Google-Smtp-Source: APXvYqyodoJd51JHbzrVVaK6Phs9Rizelp3eqImGo4R+EsNeyQaOEjFmhkaudr/ihAR7PxV7wJUE2xthpGfFs+/FzMs2KEh57rl0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:119:: with SMTP id s25mr4962087iot.111.1572622929269;
 Fri, 01 Nov 2019 08:42:09 -0700 (PDT)
Date:   Fri, 01 Nov 2019 08:42:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000109f9605964acf6c@google.com>
Subject: KASAN: invalid-free in skb_free_head
From:   syzbot <syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com, tomasbortoli@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e472c64a Merge tag 'dmaengine-fix-5.4-rc6' of git://git.in..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c36998e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bcb64e504d04eff
dashboard link: https://syzkaller.appspot.com/bug?extid=a0d209a4676664613e76
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b881f4e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17713f82e00000

The bug was bisected to:

commit 4ce9146e0370fcd573f0372d9b4e5a211112567c
Author: Tomas Bortoli <tomasbortoli@gmail.com>
Date:   Tue May 28 13:42:58 2019 +0000

     Bluetooth: hci_bcsp: Fix memory leak in rx_skb

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133d1684e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10bd1684e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=173d1684e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
Fixes: 4ce9146e0370 ("Bluetooth: hci_bcsp: Fix memory leak in rx_skb")

==================================================================
BUG: KASAN: double-free or invalid-free in skb_free_head+0x93/0xb0  
net/core/skbuff.c:591

CPU: 1 PID: 9156 Comm: syz-executor213 Not tainted 5.4.0-rc5+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  kasan_report_invalid_free+0x65/0xa0 mm/kasan/report.c:468
  __kasan_slab_free+0x13a/0x150 mm/kasan/common.c:450
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3756
  skb_free_head+0x93/0xb0 net/core/skbuff.c:591
  skb_release_data+0x42d/0x7c0 net/core/skbuff.c:611
  skb_release_all+0x4d/0x60 net/core/skbuff.c:665
  __kfree_skb net/core/skbuff.c:679 [inline]
  kfree_skb net/core/skbuff.c:697 [inline]
  kfree_skb+0x101/0x3c0 net/core/skbuff.c:691
  bcsp_close+0xc7/0x130 drivers/bluetooth/hci_bcsp.c:748
  hci_uart_tty_close+0x21e/0x280 drivers/bluetooth/hci_ldisc.c:548
  tty_ldisc_close.isra.0+0x119/0x1a0 drivers/tty/tty_ldisc.c:494
  tty_ldisc_kill+0x9c/0x160 drivers/tty/tty_ldisc.c:642
  tty_ldisc_release+0xe9/0x2b0 drivers/tty/tty_ldisc.c:814
  tty_release_struct+0x1b/0x50 drivers/tty/tty_io.c:1612
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1785
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x904/0x2e60 kernel/exit.c:817
  do_group_exit+0x135/0x360 kernel/exit.c:921
  get_signal+0x47c/0x2500 kernel/signal.c:2734
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446809
Code: Bad RIP value.
RSP: 002b:00007feedabcfdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 00000000006dbc38 RCX: 0000000000446809
RDX: 000000000000005b RSI: 0000000020000080 RDI: 0000000000000007
RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00007fff8abe57cf R14: 00007feedabd09c0 R15: 0000000000000000

Allocated by task 9184:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  __do_kmalloc_node mm/slab.c:3615 [inline]
  __kmalloc_node_track_caller+0x4e/0x70 mm/slab.c:3629
  __kmalloc_reserve.isra.0+0x40/0xf0 net/core/skbuff.c:141
  __alloc_skb+0x10b/0x5e0 net/core/skbuff.c:209
  alloc_skb include/linux/skbuff.h:1049 [inline]
  bt_skb_alloc include/net/bluetooth/bluetooth.h:339 [inline]
  bcsp_recv+0x8c1/0x13a0 drivers/bluetooth/hci_bcsp.c:670
  hci_uart_tty_receive+0x279/0x6e0 drivers/bluetooth/hci_ldisc.c:613
  tty_ldisc_receive_buf+0x15f/0x1c0 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x7d/0xb0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x222/0x390 drivers/tty/tty_buffer.c:533
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 9184:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3756
  skb_free_head+0x93/0xb0 net/core/skbuff.c:591
  skb_release_data+0x42d/0x7c0 net/core/skbuff.c:611
  skb_release_all+0x4d/0x60 net/core/skbuff.c:665
  __kfree_skb net/core/skbuff.c:679 [inline]
  kfree_skb net/core/skbuff.c:697 [inline]
  kfree_skb+0x101/0x3c0 net/core/skbuff.c:691
  bcsp_recv+0x2d8/0x13a0 drivers/bluetooth/hci_bcsp.c:608
  hci_uart_tty_receive+0x279/0x6e0 drivers/bluetooth/hci_ldisc.c:613
  tty_ldisc_receive_buf+0x15f/0x1c0 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x7d/0xb0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x222/0x390 drivers/tty/tty_buffer.c:533
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8880946e4000
  which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 0 bytes inside of
  8192-byte region [ffff8880946e4000, ffff8880946e6000)
The buggy address belongs to the page:
page:ffffea000251b900 refcount:1 mapcount:0 mapping:ffff8880aa4021c0  
index:0x0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00024a2e08 ffffea0002631c08 ffff8880aa4021c0
raw: 0000000000000000 ffff8880946e4000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880946e3f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880946e3f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8880946e4000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff8880946e4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880946e4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
