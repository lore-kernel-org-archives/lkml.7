Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC2CC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F281A2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfGSFsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 01:48:15 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52426 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfGSFsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 01:48:07 -0400
Received: by mail-io1-f72.google.com with SMTP id p12so33443196iog.19
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 22:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=C1gseWnfrQFRFLQuSEK1UBX/9rw2imdV5fJGCdBR8GE=;
        b=QdHRLG2vN7j5+B63dqizgwQZVQy9P0KRs2IhbKRYmclI2YmI5Np4O/zHGd1/z0Tuc+
         NezE6GTSME+VrNH24meUU5H7v4dZ+oIXUFxjT/jrELQPfwy/NCO3PPuWX3XF6kWNEpFk
         3XwtLBy5Q5cpZvusTCI7llNv9CkM6LU3CJ77zlJ1s//PXrsQcmoDV8dl09AXpQNp+5OP
         3Sj0tEv8zZ8juisRLoAY7TWLJxqvzxcANBVIRo8EK02SDf/CC9/Az8AIlLTDgrNrj0E0
         5ZiNLLTJ31ihm2yovbxCd7RsdHmKrKwACSkE5F7eDBS4/vGQTpWsw9zpFDV/GR8UnfiJ
         uk6A==
X-Gm-Message-State: APjAAAUhJXmEF8JCGTK7eVz2kapOKKsw/ruFOcz/Rbzgj8asGl7jB2Vo
        1UUE4lB7/WHpkeoOzuvn3Bsd1dkbqJFZqnOxi1W5jiqHqJc+
X-Google-Smtp-Source: APXvYqxAM9hzc05M56PiKE4hwGzUqQm3ZAaDGDDWdJFbbvy25Rp2XVbad9o1fRKj3+ItHwOKCUxif/XuxytC6gZxMo6h12UM6EZL
MIME-Version: 1.0
X-Received: by 2002:a5d:9957:: with SMTP id v23mr46031157ios.117.1563515286838;
 Thu, 18 Jul 2019 22:48:06 -0700 (PDT)
Date:   Thu, 18 Jul 2019 22:48:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045e7a1058e02458a@google.com>
Subject: KASAN: use-after-free Write in tlb_finish_mmu
From:   syzbot <syzbot+8267e9af795434ffadad@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    22051d9c Merge tag 'platform-drivers-x86-v5.3-2' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130c6ad0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d831b9cbe82e79e4
dashboard link: https://syzkaller.appspot.com/bug?extid=8267e9af795434ffadad
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d58784600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8267e9af795434ffadad@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_dec  
/./include/asm-generic/atomic-instrumented.h:329 [inline]
BUG: KASAN: use-after-free in dec_tlb_flush_pending  
/./include/linux/mm_types.h:598 [inline]
BUG: KASAN: use-after-free in tlb_finish_mmu+0x136/0x3b0  
/mm/mmu_gather.c:279
Write of size 4 at addr ffff8880912433f4 by task syz-executor.0/9266

CPU: 1 PID: 9266 Comm: syz-executor.0 Not tainted 5.2.0+ #61
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack /lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 /lib/dump_stack.c:113
  print_address_description.cold+0xd4/0x306 /mm/kasan/report.c:351
  __kasan_report.cold+0x1b/0x36 /mm/kasan/report.c:482
  kasan_report+0x12/0x17 /mm/kasan/common.c:612
  check_memory_region_inline /mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 /mm/kasan/generic.c:192
  __kasan_check_write+0x14/0x20 /mm/kasan/common.c:98
  atomic_dec /./include/asm-generic/atomic-instrumented.h:329 [inline]
  dec_tlb_flush_pending /./include/linux/mm_types.h:598 [inline]
  tlb_finish_mmu+0x136/0x3b0 /mm/mmu_gather.c:279
  exit_mmap+0x2da/0x530 /mm/mmap.c:3147
  __mmput /kernel/fork.c:1064 [inline]
  mmput+0x179/0x4d0 /kernel/fork.c:1085
  exit_mm /kernel/exit.c:547 [inline]
  do_exit+0x84e/0x2ea0 /kernel/exit.c:864
  do_group_exit+0x135/0x360 /kernel/exit.c:981
  get_signal+0x47c/0x2500 /kernel/signal.c:2728
  do_signal+0x87/0x1670 /arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 /arch/x86/entry/common.c:159
  prepare_exit_to_usermode /arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath /arch/x86/entry/common.c:274 [inline]
  do_syscall_32_irqs_on /arch/x86/entry/common.c:347 [inline]
  do_fast_syscall_32+0xb87/0xdb3 /arch/x86/entry/common.c:403
  entry_SYSENTER_compat+0x70/0x7f /arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f139c9
Code: d3 83 c4 10 5b 5e 5d c3 ba 80 96 98 00 eb a9 8b 04 24 c3 8b 34 24 c3  
8b 3c 24 c3 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7eee0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000004028af11
RDX: 00000000200023c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9107:
  save_stack+0x23/0x90 /mm/kasan/common.c:69
  set_track /mm/kasan/common.c:77 [inline]
  __kasan_kmalloc /mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 /mm/kasan/common.c:460
  kasan_slab_alloc+0xf/0x20 /mm/kasan/common.c:495
  slab_post_alloc_hook /mm/slab.h:520 [inline]
  slab_alloc /mm/slab.c:3319 [inline]
  kmem_cache_alloc+0x121/0x710 /mm/slab.c:3483
  dup_mm+0x8a/0x1430 /kernel/fork.c:1337
  copy_mm /kernel/fork.c:1402 [inline]
  copy_process+0x28b7/0x6b00 /kernel/fork.c:2017
  _do_fork+0x146/0xfa0 /kernel/fork.c:2369
  __do_compat_sys_x86_clone /arch/x86/ia32/sys_ia32.c:253 [inline]
  __se_compat_sys_x86_clone /arch/x86/ia32/sys_ia32.c:236 [inline]
  __ia32_compat_sys_x86_clone+0x188/0x260 /arch/x86/ia32/sys_ia32.c:236
  do_syscall_32_irqs_on /arch/x86/entry/common.c:332 [inline]
  do_fast_syscall_32+0x27b/0xdb3 /arch/x86/entry/common.c:403
  entry_SYSENTER_compat+0x70/0x7f /arch/x86/entry/entry_64_compat.S:139

Freed by task 9107:
  save_stack+0x23/0x90 /mm/kasan/common.c:69
  set_track /mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x102/0x150 /mm/kasan/common.c:449
  kasan_slab_free+0xe/0x10 /mm/kasan/common.c:457
  __cache_free /mm/slab.c:3425 [inline]
  kmem_cache_free+0x86/0x320 /mm/slab.c:3693
  __mmdrop+0x238/0x320 /kernel/fork.c:683
  mmdrop /./include/linux/sched/mm.h:49 [inline]
  finish_task_switch+0x457/0x720 /kernel/sched/core.c:3123
  context_switch /kernel/sched/core.c:3257 [inline]
  __schedule+0x75d/0x1580 /kernel/sched/core.c:3880
  schedule+0xa8/0x270 /kernel/sched/core.c:3944
  freezable_schedule /./include/linux/freezer.h:172 [inline]
  do_nanosleep+0x201/0x6a0 /kernel/time/hrtimer.c:1679
  hrtimer_nanosleep+0x2a6/0x570 /kernel/time/hrtimer.c:1733
  __do_sys_nanosleep_time32 /kernel/time/hrtimer.c:1787 [inline]
  __se_sys_nanosleep_time32 /kernel/time/hrtimer.c:1774 [inline]
  __ia32_sys_nanosleep_time32+0x1ad/0x230 /kernel/time/hrtimer.c:1774
  do_syscall_32_irqs_on /arch/x86/entry/common.c:332 [inline]
  do_fast_syscall_32+0x27b/0xdb3 /arch/x86/entry/common.c:403
  entry_SYSENTER_compat+0x70/0x7f /arch/x86/entry/entry_64_compat.S:139

The buggy address belongs to the object at ffff888091242e80
  which belongs to the cache mm_struct(17:syz0) of size 1496
The buggy address is located 1396 bytes inside of
  1496-byte region [ffff888091242e80, ffff888091243458)
The buggy address belongs to the page:
page:ffffea0002449080 refcount:1 mapcount:0 mapping:ffff88809b48b700  
index:0x0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00021bb308 ffff8880a1533a48 ffff88809b48b700
raw: 0000000000000000 ffff888091242180 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888091243280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888091243300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888091243380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                              ^
  ffff888091243400: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
  ffff888091243480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
