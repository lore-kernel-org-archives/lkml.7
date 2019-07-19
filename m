Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3760EC76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108DC2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfGSFsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 01:48:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55823 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfGSFsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 01:48:08 -0400
Received: by mail-io1-f70.google.com with SMTP id f22so33456159ioh.22
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 22:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mAbaI3Y7gAq8xuRN88WT8zwadiR0n/z66oivoGE4Y7E=;
        b=Z1lIqVo2cN3TVPgL+t3ej1G5vLio1vYGYA8+QvrULM0Pa+tRKppaJuYdWxXSLhZDA7
         u7qnrmpEdrnKcTEIVw3q5bJ5s3vin1uLAsZAFSJEu4KLkDJRguIxw6OI9XSe/3jye37q
         zJ5iFcc7K9F1f7RBh9Nicyy3EosVAa2A1idiXXSPKPij/MRw5lbC81bwFKgNBRkJQNod
         rvTedcRQpprncAWDgkW/LVxt9hnjqYBf8WUFCcFsvm4kEvzXz0NQdLvenl49yCehYtAQ
         XyY4BcTi73ywYQKFehmdmwZ3Tgmg744HI7Jnmkf1lJ6nySkfTy6XsQsXntzwL/5Z2I4s
         2doA==
X-Gm-Message-State: APjAAAWXX1hFd7Aff2P/56p0y6hrF+k6IOPaR5p26/cuzwQreUbV0pxw
        B8NwSft+EMy/OQ53fZUmlko06NWIB73LxwcpRnm30dqQHXi7
X-Google-Smtp-Source: APXvYqwCUuaQ1WBJg0hBed3mztdteSY0Y3rHCLHmEoRCqjSh9ZJmNskIspwzOQGajGm3TSendKijQjDdC0uFzcjkwI2ffgNbsUmY
MIME-Version: 1.0
X-Received: by 2002:a5d:8b52:: with SMTP id c18mr46942971iot.89.1563515287043;
 Thu, 18 Jul 2019 22:48:07 -0700 (PDT)
Date:   Thu, 18 Jul 2019 22:48:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000490679058e0245ee@google.com>
Subject: KASAN: use-after-free Read in finish_task_switch (2)
From:   syzbot <syzbot+7f067c796eee2acbc57a@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12dab5a4600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135cb826ac59d7fc
dashboard link: https://syzkaller.appspot.com/bug?extid=7f067c796eee2acbc57a
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c1898fa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7f067c796eee2acbc57a@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
8021q: adding VLAN 0 to HW filter on device batadv0
==================================================================
BUG: KASAN: use-after-free in atomic_read  
/./include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in membarrier_mm_sync_core_before_usermode  
/./include/linux/sched/mm.h:365 [inline]
BUG: KASAN: use-after-free in finish_task_switch+0x331/0x550  
/kernel/sched/core.c:3122
Read of size 4 at addr ffff88808e6c18f8 by task syz-executor.0/8218

CPU: 0 PID: 8218 Comm: syz-executor.0 Not tainted 5.2.0+ #34
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack /lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 /lib/dump_stack.c:113
  print_address_description+0x75/0x5b0 /mm/kasan/report.c:351
  __kasan_report+0x14b/0x1c0 /mm/kasan/report.c:482
  kasan_report+0x26/0x50 /mm/kasan/common.c:612
  check_memory_region_inline /mm/kasan/generic.c:182 [inline]
  check_memory_region+0x2cf/0x2e0 /mm/kasan/generic.c:192
  __kasan_check_read+0x11/0x20 /mm/kasan/common.c:92
  atomic_read /./include/asm-generic/atomic-instrumented.h:26 [inline]
  membarrier_mm_sync_core_before_usermode /./include/linux/sched/mm.h:365  
[inline]
  finish_task_switch+0x331/0x550 /kernel/sched/core.c:3122
  context_switch /kernel/sched/core.c:3257 [inline]
  __schedule+0x8be/0xcd0 /kernel/sched/core.c:3880
  schedule+0x131/0x1e0 /kernel/sched/core.c:3944
  freezable_schedule /./include/linux/freezer.h:172 [inline]
  do_nanosleep+0x295/0x7d0 /kernel/time/hrtimer.c:1679
  hrtimer_nanosleep+0x3c2/0x5d0 /kernel/time/hrtimer.c:1733
  __do_sys_nanosleep /kernel/time/hrtimer.c:1767 [inline]
  __se_sys_nanosleep /kernel/time/hrtimer.c:1754 [inline]
  __x64_sys_nanosleep+0x1ef/0x230 /kernel/time/hrtimer.c:1754
  do_syscall_64+0xfe/0x140 /arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457cc0
Code: c0 5b 5d c3 66 0f 1f 44 00 00 8b 04 24 48 83 c4 18 5b 5d c3 66 0f 1f  
44 00 00 83 3d 91 ea 61 00 00 75 14 b8 23 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 24 d3 fb ff c3 48 83 ec 08 e8 ea 46 00 00
RSP: 002b:00007ffc89355738 EFLAGS: 00000246 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 000000000000ea43 RCX: 0000000000457cc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffc89355740
RBP: 000000000000000b R08: 0000000000000001 R09: 00005555559bf940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 00007ffc89355790 R14: 000000000000e9c0 R15: 00007ffc893557a0

Allocated by task 8218:
  save_stack /mm/kasan/common.c:69 [inline]
  set_track /mm/kasan/common.c:77 [inline]
  __kasan_kmalloc+0x11c/0x1b0 /mm/kasan/common.c:487
  kasan_slab_alloc+0xf/0x20 /mm/kasan/common.c:495
  slab_post_alloc_hook /mm/slab.h:520 [inline]
  slab_alloc /mm/slab.c:3319 [inline]
  kmem_cache_alloc+0x1f5/0x2e0 /mm/slab.c:3483
  dup_mm+0x29/0x340 /kernel/fork.c:1337
  copy_mm /kernel/fork.c:1402 [inline]
  copy_process+0x25ef/0x5bc0 /kernel/fork.c:2017
  _do_fork+0x179/0x630 /kernel/fork.c:2369
  __do_sys_clone /kernel/fork.c:2524 [inline]
  __se_sys_clone /kernel/fork.c:2505 [inline]
  __x64_sys_clone+0x247/0x2b0 /kernel/fork.c:2505
  do_syscall_64+0xfe/0x140 /arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8244:
  save_stack /mm/kasan/common.c:69 [inline]
  set_track /mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x12a/0x1e0 /mm/kasan/common.c:449
  kasan_slab_free+0xe/0x10 /mm/kasan/common.c:457
  __cache_free /mm/slab.c:3425 [inline]
  kmem_cache_free+0x81/0xf0 /mm/slab.c:3693
  __mmdrop+0x2c4/0x3b0 /kernel/fork.c:683
  mmdrop /./include/linux/sched/mm.h:49 [inline]
  __mmput+0x373/0x3a0 /kernel/fork.c:1074
  mmput+0x5d/0x70 /kernel/fork.c:1085
  exit_mm+0x585/0x640 /kernel/exit.c:547
  do_exit+0x5d0/0x2310 /kernel/exit.c:864
  do_group_exit+0x15c/0x2b0 /kernel/exit.c:981
  get_signal+0x51c/0x1dd0 /kernel/signal.c:2728
  do_signal+0x7b/0x720 /arch/x86/kernel/signal.c:815
  exit_to_usermode_loop /arch/x86/entry/common.c:159 [inline]
  prepare_exit_to_usermode+0x303/0x580 /arch/x86/entry/common.c:194
  syscall_return_slowpath+0x113/0x4a0 /arch/x86/entry/common.c:274
  do_syscall_64+0x126/0x140 /arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808e6c1400
  which belongs to the cache mm_struct(17:syz0) of size 1496
The buggy address is located 1272 bytes inside of
  1496-byte region [ffff88808e6c1400, ffff88808e6c19d8)
The buggy address belongs to the page:
page:ffffea000239b000 refcount:1 mapcount:0 mapping:ffff8880867de8c0  
index:0x0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002331108 ffff8880a380ff48 ffff8880867de8c0
raw: 0000000000000000 ffff88808e6c0080 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808e6c1780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808e6c1800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88808e6c1880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff88808e6c1900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808e6c1980: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
