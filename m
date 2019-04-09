Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B47C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDD820833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDIHOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:14:07 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:58300 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:14:06 -0400
Received: by mail-it1-f200.google.com with SMTP id p23so1835865itc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 00:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UfpHkKT029kfqYf4bo8pBi7pw5DpFQWnV/BH+jmrdsk=;
        b=LM60EMLEzIX/VNpi0yFPM+3PAGq0GdgYUAA2v2NUj7n/4Mvlh6vtNYSibJFBuVnToK
         6ecMbycmXhu0de3l6J6WJL9WlNA1JcIwjY/NMtOeoOFaf6nXP/RQ3qLhe5qMIGNPZEl8
         j64ZTMAZ4Z/7Tn2MFPpqvDylmg+qU3lGjjJa0rajQF9HkR60rU4AFqp2SHrNh1gBuCop
         seequuy7mUZlJNea5ON5eDv94Ck24YicUZSIbasL7auWtXGcfUQ6tGgQuBLNYghe0sSK
         JhTNbt0/cgm8lNqCZiIwrF3D0CxKWFwkI4yXtAnliprBmWdAjrB63LuOAaRbT0I3VMSj
         ySGA==
X-Gm-Message-State: APjAAAVDTc7A09pTNNngNtzxL2PtiKbitZm7YqVqbxv8jTTBqt6dHlS9
        kg1cFvf6mFPaRgGN9p1EipGEodrEn57fwouGQVlxbukQOZK6
X-Google-Smtp-Source: APXvYqyBkSrFiqTzX/dEfA1ZqesrFu5z0/6wkOMEuhusXUnEOCX08/9IPLlK9eA5IFSNK7v+CUjRed22ZfFLrWb33qfUChBn3CjO
MIME-Version: 1.0
X-Received: by 2002:a02:620c:: with SMTP id d12mr5814027jac.4.1554794045589;
 Tue, 09 Apr 2019 00:14:05 -0700 (PDT)
Date:   Tue, 09 Apr 2019 00:14:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c956f2058613b25c@google.com>
Subject: KASAN: use-after-free Read in snd_timer_process_callbacks
From:   syzbot <syzbot+58813d77154713f4de15@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, ben.hutchings@codethink.co.uk,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        srikanth.h@samsung.com, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ac5b84a1 Add linux-next specific files for 20190408
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ae80b7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a33a21877c9c95
dashboard link: https://syzkaller.appspot.com/bug?extid=58813d77154713f4de15
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102b9f5d200000

The bug was bisected to:

commit a7588c896b05444929ecb3d0115481988720abf6
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed Mar 27 15:56:08 2019 +0000

     ALSA: timer: Check ack_list emptiness instead of bit flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1100d3ab200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1300d3ab200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1500d3ab200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+58813d77154713f4de15@syzkaller.appspotmail.com
Fixes: a7588c896b05 ("ALSA: timer: Check ack_list emptiness instead of bit  
flag")

==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xd2/0xf5  
lib/list_debug.c:42
Read of size 8 at addr ffff8880a497a7a0 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.1.0-rc3-next-20190408 #20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __list_del_entry_valid+0xd2/0xf5 lib/list_debug.c:42
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:176 [inline]
  snd_timer_process_callbacks+0x7f/0x2f0 sound/core/timer.c:763
  snd_timer_interrupt sound/core/timer.c:883 [inline]
  snd_timer_interrupt+0x578/0xdd0 sound/core/timer.c:804
  snd_hrtimer_callback+0x219/0x3e0 sound/core/hrtimer.c:64
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x33e/0xde0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x120/0x570 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:767  
[inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x95/0xe0  
kernel/locking/spinlock.c:184
Code: 48 c7 c0 70 9b 92 88 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c  
10 00 75 39 48 83 3d 22 d5 78 01 00 74 24 48 89 df 57 9d <0f> 1f 44 00 00  
bf 01 00 00 00 e8 dc e1 33 fa 65 8b 05 25 27 e8 78
RSP: 0018:ffff8880ae907920 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff112536e RBX: 0000000000000282 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffff8880aa292bc0 RDI: 0000000000000282
RBP: ffff8880ae907930 R08: ffff8880aa292340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888097bafab8
R13: ffff8880aa20bb00 R14: ffff888097baf8b0 R15: 0000000000000001
  spin_unlock_irqrestore include/linux/spinlock.h:384 [inline]
  test_clear_page_writeback+0x397/0x13b0 mm/page-writeback.c:2741
  end_page_writeback+0x22a/0x4f0 mm/filemap.c:1311
  ext4_finish_bio+0x63e/0xb10 fs/ext4/page-io.c:119
  ext4_end_bio+0x190/0x6a0 fs/ext4/page-io.c:343
  bio_endio+0x5f8/0xad0 block/bio.c:1879
  req_bio_endio block/blk-core.c:196 [inline]
  blk_update_request+0x317/0xba0 block/blk-core.c:1457
  scsi_end_request+0x7f/0x860 drivers/scsi/scsi_lib.c:579
  scsi_io_completion+0x20a/0x1420 drivers/scsi/scsi_lib.c:964
  scsi_finish_command+0x3ba/0x670 drivers/scsi/scsi.c:219
  scsi_softirq_done+0x33b/0x3e0 drivers/scsi/scsi_lib.c:1464
  blk_done_softirq+0x304/0x4d0 block/blk-softirq.c:37
  __do_softirq+0x266/0x95a kernel/softirq.c:293
  invoke_softirq kernel/softirq.c:374 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:414
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  do_IRQ+0x114/0x1d0 arch/x86/kernel/irq.c:258
  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:583
  </IRQ>
RIP: 0010:native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:58
Code: ff ff ff 48 89 c7 48 89 45 d8 e8 c9 80 8f fa 48 8b 45 d8 e9 ce fe ff  
ff 48 89 df e8 b8 80 8f fa eb 82 90 90 90 90 90 90 fb f4 <c3> 0f 1f 00 66  
2e 0f 1f 84 00 00 00 00 00 f4 c3 90 90 90 90 90 90
RSP: 0018:ffff8880aa2a7d78 EFLAGS: 00000282 ORIG_RAX: ffffffffffffffdd
RAX: 1ffffffff1125371 RBX: ffff8880aa292340 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffff8880aa292bbc
RBP: ffff8880aa2a7da8 R08: ffff8880aa292340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff88929b78 R14: 0000000000000001 R15: 0000000000000000
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:567
  default_idle_call+0x36/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x386/0x570 kernel/sched/idle.c:262
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:353
  start_secondary+0x360/0x4d0 arch/x86/kernel/smpboot.c:267
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

Allocated by task 7668:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3621
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  snd_timer_instance_new+0x4f/0x3d0 sound/core/timer.c:109
  snd_timer_open+0x8a7/0x1760 sound/core/timer.c:313
  snd_seq_timer_open+0x240/0x590 sound/core/seq/seq_timer.c:290
  queue_use+0xcb/0x240 sound/core/seq/seq_queue.c:502
  snd_seq_queue_alloc+0x2c5/0x4d0 sound/core/seq/seq_queue.c:189
  snd_seq_ioctl_create_queue+0xb0/0x330 sound/core/seq/seq_clientmgr.c:1522
  snd_seq_ioctl+0x224/0x3e0 sound/core/seq/seq_clientmgr.c:2138
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7668:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3821
  snd_timer_close_locked+0x6fd/0xd60 sound/core/timer.c:405
  snd_timer_close+0x2e/0x70 sound/core/timer.c:430
  snd_seq_timer_close+0x91/0xd0 sound/core/seq/seq_timer.c:329
  queue_delete+0x52/0xb0 sound/core/seq/seq_queue.c:147
  snd_seq_queue_client_leave+0x36/0x170 sound/core/seq/seq_queue.c:584
  seq_free_client1.part.0+0xf3/0x270 sound/core/seq/seq_clientmgr.c:263
  seq_free_client1 sound/core/seq/seq_clientmgr.c:256 [inline]
  seq_free_client+0x80/0xf0 sound/core/seq/seq_clientmgr.c:285
  snd_seq_release+0x55/0xf0 sound/core/seq/seq_clientmgr.c:366
  __fput+0x2e5/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  get_signal+0x1961/0x1d50 kernel/signal.c:2391
  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a497a700
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 160 bytes inside of
  256-byte region [ffff8880a497a700, ffff8880a497a800)
The buggy address belongs to the page:
page:ffffea0002925e80 count:1 mapcount:0 mapping:ffff88812c3f07c0  
index:0xffff8880a497a200
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffff88812c3f1638 ffff88812c3f1638 ffff88812c3f07c0
raw: ffff8880a497a200 ffff8880a497a0c0 000000010000000b 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a497a680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a497a700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880a497a780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff8880a497a800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a497a880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
