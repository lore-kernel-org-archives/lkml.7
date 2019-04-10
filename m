Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B3DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901102084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfDJFrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:47:06 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:58493 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfDJFrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 01:47:05 -0400
Received: by mail-it1-f199.google.com with SMTP id j203so1275460itb.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 22:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=m1JgYbzirOoCqcywm6C58EI2eGOzxYkL9b5WNPejtYU=;
        b=Fv5GqFMpPN4edH3TgXatqb9r8IVovIirRjqei3YXmWNUsz9cR9YwbbdFJvyCDM529V
         8MLfha8KHFltUUY0EcuYcLks5BN0tN/W1GKd2rK/LwWD/llWzdNiIcdWDxq8OYDeLQR7
         sFKksLxQvOlAndwCCIA99JA04RrCocBPPbRDKJwR2doI1SZ8fPa+tQzOP4xAWDNe+08E
         q137Ge4+ju0hic3lTIdXa3gZcuSNF7SbLX5k51+TW5ogTGAayDPHYVdc0npakH5Aj86x
         7wtfw01dcOTKkCFfqvYdSK4q+Qu8I1nnZkDhWuY0TIzFydXooaWCdKLkCeCuEKoh8lMx
         MPxQ==
X-Gm-Message-State: APjAAAXCLNRZRulX3Yo/NDDOD+4T6bqDETBUyYHpgPeCgC3jPjiFANgX
        7QVhfNG/+J3FhqXRIAU8UKCWPhfbrcGJSrL6OeiSw134i5sO
X-Google-Smtp-Source: APXvYqwsDVYNyx1JQ4xYl8yyi/BMzG/IvQvq96+slWtmXzxf5kndIcq9c+E7sdrkR2UHx0JG7s8RfzADXipb2KgPw8IrG/QjG8p9
MIME-Version: 1.0
X-Received: by 2002:a24:76c2:: with SMTP id z185mr415830itb.22.1554875225158;
 Tue, 09 Apr 2019 22:47:05 -0700 (PDT)
Date:   Tue, 09 Apr 2019 22:47:05 -0700
In-Reply-To: <000000000000c956f2058613b25c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000774327058626993b@google.com>
Subject: Re: KASAN: use-after-free Read in snd_timer_process_callbacks
From:   syzbot <syzbot+58813d77154713f4de15@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        ben.hutchings@codethink.co.uk, linux-kernel@vger.kernel.org,
        perex@perex.cz, srikanth.h@samsung.com,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    cfd24a53 Add linux-next specific files for 20190409
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111d56af200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75160b904dadd291
dashboard link: https://syzkaller.appspot.com/bug?extid=58813d77154713f4de15
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137ba6af200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1749585b200000

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
Read of size 8 at addr ffff8880a9363ee0 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.1.0-rc4-next-20190409 #21
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
  </IRQ>
RIP: 0010:native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:58
Code: ff ff ff 48 89 c7 48 89 45 d8 e8 99 65 8e fa 48 8b 45 d8 e9 ce fe ff  
ff 48 89 df e8 88 65 8e fa eb 82 90 90 90 90 90 90 fb f4 <c3> 0f 1f 00 66  
2e 0f 1f 84 00 00 00 00 00 f4 c3 90 90 90 90 90 90
RSP: 0018:ffffffff88807d08 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1124ad9 RBX: ffffffff8887a100 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffffffff8887a97c
RBP: ffffffff88807d38 R08: ffffffff8887a100 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff889256b8 R14: 0000000000000000 R15: 0000000000000000
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:567
  default_idle_call+0x36/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x386/0x570 kernel/sched/idle.c:262
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:353
  rest_init+0x245/0x37b init/main.c:450
  arch_call_rest_init+0xe/0x1b
  start_kernel+0x816/0x84f init/main.c:747
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
  x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

Allocated by task 7722:
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

Freed by task 7722:
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
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a9363e40
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 160 bytes inside of
  256-byte region [ffff8880a9363e40, ffff8880a9363f40)
The buggy address belongs to the page:
page:ffffea0002a4d8c0 count:1 mapcount:0 mapping:ffff88812c3f07c0  
index:0xffff8880a9363940
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002a21a48 ffffea0002a2e048 ffff88812c3f07c0
raw: ffff8880a9363940 ffff8880a9363080 0000000100000009 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a9363d80: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
  ffff8880a9363e00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8880a9363e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff8880a9363f00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8880a9363f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

