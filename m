Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57B0C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ED4207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLILFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:05:14 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:37139 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfLILFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:05:11 -0500
Received: by mail-il1-f198.google.com with SMTP id t19so11362578ila.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 03:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FkCEOdhvgMw9DxYiG45rKRNFL4YjSybxgvChDYzQ4lw=;
        b=AC975592yJGTLNm9UN/a1hkS5b1F5OytbSaIgrQV59R1qSztXbUzsgtb1l8jQnYIob
         SEtYQX39iq4xJpRvy6U6BEtth1+RDDCwJ8kpkUHlB5DnZYuVRFw7+Ur6IeFJ4/Wa+lk3
         s5VXzWNAxtXzmpEevg9+kOOURb1eakjivbP+C3zB0J/5z0qdOaViBIOhs4R7zLyip5xV
         1HY6NLuhO0L2zFbJ3Q5ruX6CF6SG8tRvO0CStjiMPZVc0h286OpmB/JdgCPmYTWnDzXm
         O71E7Z2j/qA66NB1BBYwTUjBcGIejE8vMfvCr3Lk3q/qzm8nyFVGo5ecvynfOYp6z1mo
         5t2A==
X-Gm-Message-State: APjAAAWpW/9eCRpi5KH7bau40mVcEL1+SJZMMJ8kD6W4LK6jr9bwbtRf
        r4ueo8afrAFVvf6gJsNBHHzMpNCFL7q8v7yrRiTx/wjjGvHa
X-Google-Smtp-Source: APXvYqy0Eiz4i3U9+aD172tA2dwV/98dLE+n89X1DdYN9MKB1MdXAa0BbX0aiqiyfcdBs5MMGFnEpMqpRxjxwJn2wa0qBwhzv33X
MIME-Version: 1.0
X-Received: by 2002:a92:1a0a:: with SMTP id a10mr25882531ila.295.1575889509952;
 Mon, 09 Dec 2019 03:05:09 -0800 (PST)
Date:   Mon, 09 Dec 2019 03:05:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000723a620599435efd@google.com>
Subject: KASAN: slab-out-of-bounds Write in sysrq_filter
From:   syzbot <syzbot+00b7ed8a789d74bb5a4b@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1f22d15c usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=11110cdee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ccee2968018adcb
dashboard link: https://syzkaller.appspot.com/bug?extid=00b7ed8a789d74bb5a4b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1342f446e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155fd196e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+00b7ed8a789d74bb5a4b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in clear_bit  
include/asm-generic/bitops-instrumented.h:56 [inline]
BUG: KASAN: slab-out-of-bounds in sysrq_handle_keypress  
drivers/tty/sysrq.c:845 [inline]
BUG: KASAN: slab-out-of-bounds in sysrq_filter+0x8ff/0xeb0  
drivers/tty/sysrq.c:884
Write of size 8 at addr ffff8881cff93dc8 by task syz-executor237/1717

CPU: 1 PID: 1717 Comm: syz-executor237 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xef/0x16e lib/dump_stack.c:118
  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
  kasan_report+0xe/0x20 mm/kasan/common.c:638
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x128/0x190 mm/kasan/generic.c:192
  clear_bit include/asm-generic/bitops-instrumented.h:56 [inline]
  sysrq_handle_keypress drivers/tty/sysrq.c:845 [inline]
  sysrq_filter+0x8ff/0xeb0 drivers/tty/sysrq.c:884
  input_to_handler+0x152/0x4c0 drivers/input/input.c:102
  input_pass_values.part.0+0x2de/0x710 drivers/input/input.c:145
  input_pass_values drivers/input/input.c:949 [inline]
  input_set_keycode+0x290/0x320 drivers/input/input.c:954
  evdev_handle_set_keycode_v2+0xc4/0x120 drivers/input/evdev.c:882
  evdev_do_ioctl drivers/input/evdev.c:1150 [inline]
  evdev_ioctl_handler+0xd49/0x19f0 drivers/input/evdev.c:1284
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:539 [inline]
  do_vfs_ioctl+0xd2d/0x1330 fs/ioctl.c:726
  ksys_ioctl+0x9b/0xc0 fs/ioctl.c:743
  __do_sys_ioctl fs/ioctl.c:750 [inline]
  __se_sys_ioctl fs/ioctl.c:748 [inline]
  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:748
  do_syscall_64+0xb7/0x5b0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444dc9
Code: e8 bc af 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffea62b3f68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444dc9
RDX: 00000000200000c0 RSI: 0000000040284504 RDI: 0000000000000004
RBP: 00000000006cf018 R08: 7d03000000008300 R09: 00000000004002e0
R10: 000000000000000f R11: 0000000000000246 R12: 0000000000402a70
R13: 0000000000402b00 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 78:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:512 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:485
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  sysrq_connect+0x46/0x290 drivers/tty/sysrq.c:902
  input_attach_handler+0x194/0x200 drivers/input/input.c:1024
  input_register_device.cold+0xf5/0x246 drivers/input/input.c:2224
  hidinput_connect+0x4f8d/0xdb90 drivers/hid/hid-input.c:1927
  hid_connect+0x965/0xbb0 drivers/hid/hid-core.c:1923
  hid_hw_start drivers/hid/hid-core.c:2027 [inline]
  hid_hw_start+0xa2/0x130 drivers/hid/hid-core.c:2018
  ms_probe+0x159/0x4d0 drivers/hid/hid-microsoft.c:394
  hid_device_probe+0x2be/0x3f0 drivers/hid/hid-core.c:2255
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1480/0x1c20 drivers/base/core.c:2487
  hid_add_device drivers/hid/hid-core.c:2411 [inline]
  hid_add_device+0x33c/0x9a0 drivers/hid/hid-core.c:2360
  usbhid_probe+0xa81/0xfa0 drivers/hid/usbhid/hid-core.c:1386
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1480/0x1c20 drivers/base/core.c:2487
  usb_set_configuration+0xe67/0x1740 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1480/0x1c20 drivers/base/core.c:2487
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2537
  hub_port_connect drivers/usb/core/hub.c:5184 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5324 [inline]
  port_event drivers/usb/core/hub.c:5470 [inline]
  hub_event+0x1e59/0x3860 drivers/usb/core/hub.c:5552
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2264
  process_scheduled_works kernel/workqueue.c:2326 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2412
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 350:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  kasan_set_free_info mm/kasan/common.c:334 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:473
  slab_free_hook mm/slub.c:1425 [inline]
  slab_free_freelist_hook mm/slub.c:1458 [inline]
  slab_free mm/slub.c:3005 [inline]
  kfree+0xdc/0x310 mm/slub.c:3957
  load_elf_binary+0x2435/0x4f00 fs/binfmt_elf.c:1088
  search_binary_handler fs/exec.c:1658 [inline]
  search_binary_handler+0x16b/0x580 fs/exec.c:1635
  exec_binprm fs/exec.c:1701 [inline]
  __do_execve_file.isra.0+0x1304/0x21e0 fs/exec.c:1821
  do_execveat_common fs/exec.c:1867 [inline]
  do_execve fs/exec.c:1884 [inline]
  __do_sys_execve fs/exec.c:1960 [inline]
  __se_sys_execve fs/exec.c:1955 [inline]
  __x64_sys_execve+0x8a/0xb0 fs/exec.c:1955
  do_syscall_64+0xb7/0x5b0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881cff93c00
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 456 bytes inside of
  512-byte region [ffff8881cff93c00, ffff8881cff93e00)
The buggy address belongs to the page:
page:ffffea00073fe400 refcount:1 mapcount:0 mapping:ffff8881da402500  
index:0x0 compound_mapcount: 0
raw: 0200000000010200 0000000000000000 0000000100000001 ffff8881da402500
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cff93c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881cff93d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8881cff93d80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
                                               ^
  ffff8881cff93e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881cff93e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
