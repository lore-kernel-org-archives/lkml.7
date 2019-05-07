Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41315C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E41205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEGJgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:36:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50795 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGJgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:36:06 -0400
Received: by mail-io1-f72.google.com with SMTP id t7so10743667iod.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 02:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=k2pRyG7vK/1j3fVv4DVkzCWppahXNJlURyzypYD7+1w=;
        b=lkaQOjunAaPfEdszBEfb67eIw/JEuZDNGbdclG5HyPohDKofvG9Gm/HGL6MsS2xz3C
         MFu0ne4rAjHyphnV0wzjEfmFD+hs1ltLHsoLOrSxvGcBFaNVFuSvgyvFy0K+jd/5T6Dk
         ta3u2GjHZgyXJYAbr0NmbkFUn8pa3fDfn4GT/HKjGgJDPr6k2mhBlXc2YePB2rIdvKZM
         m97NAIwquYIA6Sqb+7I6pW6GpwzlhHrjQ144UTaCrKZq32Bj+itCcxIMSegnHpgupRSF
         3L0Y75XnqkNG+2DXjOlpyVzhqs21KCIYNv3s0DEdt2SKBBSnJap62Ht/WxvYRDqLzLyH
         yycg==
X-Gm-Message-State: APjAAAV0rLkh4wBCP/LWl07QrfZmwz8AQ4Ny1BEmqU44XCYPCYjTFl0u
        7nFGMirVkw5H+WUC9I3pyc1Wzs410OyMB32iKi9jPudD8rBG
X-Google-Smtp-Source: APXvYqz8hJFf5rvwdjuQrnHXAuprdWyiTdbNxligrkWJekg0wapLWivP35RnM33Rx7FYqFqdEGox804t8vg9vdsxMNh2QQkCGtAH
MIME-Version: 1.0
X-Received: by 2002:a02:6209:: with SMTP id d9mr22415754jac.34.1557221765780;
 Tue, 07 May 2019 02:36:05 -0700 (PDT)
Date:   Tue, 07 May 2019 02:36:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f9ef4058848f26d@google.com>
Subject: KASAN: use-after-free Read in kfree_skb (3)
From:   syzbot <syzbot+dcb1305dd05699c40640@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    085b7755 Linux 5.1-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f6876b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
dashboard link: https://syzkaller.appspot.com/bug?extid=dcb1305dd05699c40640
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dcb1305dd05699c40640@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in refcount_read include/linux/refcount.h:43  
[inline]
BUG: KASAN: use-after-free in skb_unref include/linux/skbuff.h:1022 [inline]
BUG: KASAN: use-after-free in kfree_skb+0x38/0x390 net/core/skbuff.c:659
Read of size 4 at addr ffff888091576a54 by task syz-executor.0/10940

CPU: 0 PID: 10940 Comm: syz-executor.0 Not tainted 5.1.0-rc6 #78
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_read+0x11/0x20 mm/kasan/common.c:102
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  refcount_read include/linux/refcount.h:43 [inline]
  skb_unref include/linux/skbuff.h:1022 [inline]
  kfree_skb+0x38/0x390 net/core/skbuff.c:659
  bcsp_recv+0x66b/0x13e0 drivers/bluetooth/hci_bcsp.c:623
  hci_uart_tty_receive+0x22b/0x530 drivers/bluetooth/hci_ldisc.c:607
  tiocsti drivers/tty/tty_io.c:2195 [inline]
  tty_ioctl+0x4ed/0x15c0 drivers/tty/tty_io.c:2571
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7c0d8adc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7c0d8adc90 RCX: 0000000000458c29
RDX: 0000000020000200 RSI: 0000000000005412 RDI: 0000000000000003
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7c0d8ae6d4
R13: 00000000004c3082 R14: 00000000004d6428 R15: 0000000000000004

Allocated by task 21:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:505
  slab_post_alloc_hook mm/slab.h:437 [inline]
  slab_alloc_node mm/slab.c:3336 [inline]
  kmem_cache_alloc_node+0x131/0x710 mm/slab.c:3646
  __alloc_skb+0xd5/0x5e0 net/core/skbuff.c:196
  alloc_skb include/linux/skbuff.h:1058 [inline]
  bt_skb_alloc include/net/bluetooth/bluetooth.h:339 [inline]
  bcsp_recv+0x8fb/0x13e0 drivers/bluetooth/hci_bcsp.c:685
  hci_uart_tty_receive+0x22b/0x530 drivers/bluetooth/hci_ldisc.c:607
  tty_ldisc_receive_buf+0x164/0x1c0 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x7d/0xb0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x228/0x390 drivers/tty/tty_buffer.c:533
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 21:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3499 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3765
  kfree_skbmem net/core/skbuff.c:589 [inline]
  kfree_skbmem+0xc5/0x150 net/core/skbuff.c:583
  __kfree_skb net/core/skbuff.c:646 [inline]
  kfree_skb net/core/skbuff.c:663 [inline]
  kfree_skb+0xf0/0x390 net/core/skbuff.c:657
  bcsp_recv+0x66b/0x13e0 drivers/bluetooth/hci_bcsp.c:623
  hci_uart_tty_receive+0x22b/0x530 drivers/bluetooth/hci_ldisc.c:607
  tty_ldisc_receive_buf+0x164/0x1c0 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x7d/0xb0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x228/0x390 drivers/tty/tty_buffer.c:533
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff888091576980
  which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 212 bytes inside of
  224-byte region [ffff888091576980, ffff888091576a60)
The buggy address belongs to the page:
page:ffffea0002455d80 count:1 mapcount:0 mapping:ffff8880aa23bcc0 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00023eb4c8 ffffea00020a7c48 ffff8880aa23bcc0
raw: 0000000000000000 ffff8880915760c0 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888091576900: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888091576980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888091576a00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                                  ^
  ffff888091576a80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff888091576b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
