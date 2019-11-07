Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A4C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE0F21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbfKGPeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:34:11 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:51382 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbfKGPeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:34:10 -0500
Received: by mail-io1-f71.google.com with SMTP id v14so2098617iob.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 07:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KbKo0EGgbCJTMaorCNXk3oahYHxGIFUYR9SCUsVQivM=;
        b=EpwpIfjnZPQ9eGbwQOwTcUh5l39bG5CYj67exsIF5mGGlL6BzDot6yIbVeZaVMzmkl
         Bx4V7nXikISNsOs+TTX+ib/AuyVsidP8nxHjTBLV9xdwHC3VDw1y512i1dwkJXzSFpGx
         QDKatqEXC9KqBuB/mo/wgrwkETT/e/EVKXHyN34G7JAWjJ8uH4QU12Eee6KuMBrXFvpf
         vpkwZS6SD69S8Zvw5SAE/crQAjHnxmUHvTfIYlKH/98eobGDNtEPzEhwADi/Q/m/czBD
         otxbawdgr1Cs+sbKjuv8eiwVF5JHCd1hANHkmNxq41D0qUwFQ3j7avnDKksl98gMh5jh
         VeTA==
X-Gm-Message-State: APjAAAXg5qu6Nd3fvTIQlfps/1t8/SVHYLQHtLntuy888YVNN4qAOowK
        Rsw4byxMbcI8W3CZiFLoqV+7Xnyks1jPNqKr++IlSti6L/BH
X-Google-Smtp-Source: APXvYqywuKZWdpzD0TsBKYs5A/WKHD0jOb9ohviiHqjOTPat2gdHEACkIYwzUbprGuGa3UdWaMfOPuHrpWWPRhiKfEpJwM0+Obub
MIME-Version: 1.0
X-Received: by 2002:a5e:c649:: with SMTP id s9mr4138001ioo.194.1573140849644;
 Thu, 07 Nov 2019 07:34:09 -0800 (PST)
Date:   Thu, 07 Nov 2019 07:34:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008660cb0596c3654d@google.com>
Subject: KASAN: use-after-free Read in fn_hold
From:   syzbot <syzbot+ac91f8663f751c733e18@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rei4dan@gmail.com, slyfox@gentoo.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d60bbfea usb: raw: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=168e5f42e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79de80330003b5f7
dashboard link: https://syzkaller.appspot.com/bug?extid=ac91f8663f751c733e18
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ac91f8663f751c733e18@syzkaller.appspotmail.com

raw: raw_ioctl_run: fail, usb_gadget_probe_driver returned -16
==================================================================
BUG: KASAN: use-after-free in debug_spin_unlock  
kernel/locking/spinlock_debug.c:97 [inline]
BUG: KASAN: use-after-free in do_raw_spin_unlock+0x1ea/0x220  
kernel/locking/spinlock_debug.c:138
Read of size 4 at addr ffff8881c1b9237c by task syz-executor.2/7977

CPU: 0 PID: 7977 Comm: syz-executor.2 Not tainted 5.4.0-rc6+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
  kasan_report+0xe/0x20 mm/kasan/common.c:634
  debug_spin_unlock kernel/locking/spinlock_debug.c:97 [inline]
  do_raw_spin_unlock+0x1ea/0x220 kernel/locking/spinlock_debug.c:138
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:159 [inline]
  _raw_spin_unlock_irqrestore+0x23/0x50 kernel/locking/spinlock.c:191
  fn_hold+0xbd/0xe0 drivers/tty/vt/keyboard.c:497
  k_spec drivers/tty/vt/keyboard.c:636 [inline]
  k_spec+0xdc/0x120 drivers/tty/vt/keyboard.c:625
  kbd_keycode drivers/tty/vt/keyboard.c:1477 [inline]
  kbd_event+0x927/0x3790 drivers/tty/vt/keyboard.c:1495
  input_to_handler+0x3b6/0x4c0 drivers/input/input.c:118
  input_pass_values.part.0+0x2e3/0x720 drivers/input/input.c:145
  input_pass_values drivers/input/input.c:134 [inline]
  input_handle_event+0x326/0x13a0 drivers/input/input.c:398
  input_inject_event+0x30a/0x323 drivers/input/input.c:470
  evdev_write+0x2c9/0x410 drivers/input/evdev.c:542
  __vfs_write+0x76/0x100 fs/read_write.c:494
  vfs_write+0x262/0x5c0 fs/read_write.c:558
  ksys_write+0x1e8/0x250 fs/read_write.c:611
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a219
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb8b17c7c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a219
RDX: 00000000000001e8 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb8b17c86d4
R13: 00000000004cabbd R14: 00000000004e30a8 R15: 00000000ffffffff

Allocated by task 7990:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:483
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:690 [inline]
  alloc_tty_struct+0x94/0x7e0 drivers/tty/tty_io.c:2975
  tty_init_dev drivers/tty/tty_io.c:1333 [inline]
  tty_init_dev+0x73/0x450 drivers/tty/tty_io.c:1317
  tty_open_by_driver drivers/tty/tty_io.c:1984 [inline]
  tty_open+0x47f/0xa80 drivers/tty/tty_io.c:2032
  chrdev_open+0x219/0x5c0 fs/char_dev.c:414
  do_dentry_open+0x494/0x1120 fs/open.c:797
  do_last fs/namei.c:3408 [inline]
  path_openat+0x1430/0x3ff0 fs/namei.c:3525
  do_filp_open+0x1a1/0x280 fs/namei.c:3555
  do_sys_open+0x3c0/0x580 fs/open.c:1097
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 17:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:471
  slab_free_hook mm/slub.c:1424 [inline]
  slab_free_freelist_hook mm/slub.c:1475 [inline]
  slab_free mm/slub.c:3025 [inline]
  kfree+0xe4/0x320 mm/slub.c:3977
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881c1b92000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 892 bytes inside of
  2048-byte region [ffff8881c1b92000, ffff8881c1b92800)
The buggy address belongs to the page:
page:ffffea000706e400 refcount:1 mapcount:0 mapping:ffff8881da00c000  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 0000000000000000 0000000100000001 ffff8881da00c000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881c1b92200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881c1b92280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881c1b92300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff8881c1b92380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881c1b92400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
