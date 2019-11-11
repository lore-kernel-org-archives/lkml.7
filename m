Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1746DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC23A214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfKKRMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:12:09 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:41888 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKRMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:12:09 -0500
Received: by mail-io1-f71.google.com with SMTP id p2so1589883ioh.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yM/UpwGqJ2Iq9llUcUVI+4Q+oGbiDijz949nOElRGZY=;
        b=YERRYKds5l6btKd7pSpkdLiiD73EhdLVLvX9vbyFOMcv0Pj0NxH+juKNckVqQBEY+b
         DYDRjFnwFeMtATvebpVPki3DAVMWGK8TDdqS1ySRpITvyJoEvnFEI8PvVa3C7wLo/J2e
         ZdW3j6rS5z9+l8B7n0UNrcbBWA2CexvYNXCRf0VrcSHh/+tx7E0Xp/LvKqntwhfO5Bb+
         vigVeWBD3g3xxb1/PfD65dnH/5NCdLPvn9wBvMybEl3jd1i+8QVB3tI4ytHdzBMq+lx+
         0AFVc+y3dVuf0S6pO7V8ZMcW07JyM3jsG+HdN/MjP04FS5oQgzMCojKIOHJ/UgCvmz+m
         XGxA==
X-Gm-Message-State: APjAAAUUuBX0xjHI/UnQhmiFge4A1V2IWhvIT14St4oMfNhfc7iRgHNC
        GFCyS55cnCxmZpg7c+qOJejWwvP/3p8dzEBX+VSYjgrArFSs
X-Google-Smtp-Source: APXvYqwv1e16900Cr2dC2eH58JKjwfDIIYRWf5MtJFzqWbpAZYp0khw926tNiihZcF9XwRTsfFQiJZv+SqjWAmP3he8a3qUswLIk
MIME-Version: 1.0
X-Received: by 2002:a5e:d70c:: with SMTP id v12mr22955105iom.284.1573492328484;
 Mon, 11 Nov 2019 09:12:08 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:12:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bddcf0597153b91@google.com>
Subject: KASAN: use-after-free Read in check_matching_master_slave
From:   syzbot <syzbot+5ab7470f121c0165470f@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, enric.balletbo@collabora.com,
        gregkh@linuxfoundation.org, kirr@nexedi.com,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, perex@perex.cz,
        rfontana@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6980b7f6 Add linux-next specific files for 20191111
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1658f9fce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2af7db1972ec750e
dashboard link: https://syzkaller.appspot.com/bug?extid=5ab7470f121c0165470f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5ab7470f121c0165470f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x9a/0xa0 lib/list_debug.c:26
Read of size 8 at addr ffff888095ac8078 by task syz-executor.0/4457

CPU: 1 PID: 4457 Comm: syz-executor.0 Not tainted 5.4.0-rc6-next-20191111 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __list_add_valid+0x9a/0xa0 lib/list_debug.c:26
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  list_move_tail include/linux/list.h:214 [inline]
  check_matching_master_slave.part.0+0x116/0x550 sound/core/timer.c:179
  check_matching_master_slave sound/core/timer.c:177 [inline]
  snd_timer_check_slave sound/core/timer.c:207 [inline]
  snd_timer_open+0x466/0x1150 sound/core/timer.c:270
  snd_timer_user_tselect sound/core/timer.c:1738 [inline]
  __snd_timer_user_ioctl.isra.0+0x7ed/0x2070 sound/core/timer.c:2008
  snd_timer_user_ioctl+0x7a/0xa7 sound/core/timer.c:2038
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a219
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f41e77d2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a219
RDX: 0000000020029fcc RSI: 0000000040345410 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f41e77d36d4
R13: 00000000004cf428 R14: 00000000004d9760 R15: 00000000ffffffff

Allocated by task 4339:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  snd_timer_instance_new+0x4a/0x300 sound/core/timer.c:96
  snd_timer_user_tselect sound/core/timer.c:1725 [inline]
  __snd_timer_user_ioctl.isra.0+0x665/0x2070 sound/core/timer.c:2008
  snd_timer_user_ioctl+0x7a/0xa7 sound/core/timer.c:2038
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4339:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  snd_timer_instance_free sound/core/timer.c:120 [inline]
  snd_timer_instance_free+0x7c/0xa0 sound/core/timer.c:114
  snd_timer_user_tselect sound/core/timer.c:1740 [inline]
  __snd_timer_user_ioctl.isra.0+0x160d/0x2070 sound/core/timer.c:2008
  snd_timer_user_ioctl+0x7a/0xa7 sound/core/timer.c:2038
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888095ac8000
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 120 bytes inside of
  256-byte region [ffff888095ac8000, ffff888095ac8100)
The buggy address belongs to the page:
page:ffffea000256b200 refcount:1 mapcount:0 mapping:ffff8880aa4008c0  
index:0xffff888095ac8c00
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0001815608 ffffea0001eb9308 ffff8880aa4008c0
raw: ffff888095ac8c00 ffff888095ac8000 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888095ac7f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff888095ac7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff888095ac8000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff888095ac8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888095ac8100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
