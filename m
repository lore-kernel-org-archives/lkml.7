Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521C6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA75218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLRGpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:45:10 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:37275 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRGpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 01:45:09 -0500
Received: by mail-io1-f70.google.com with SMTP id t70so746317iof.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 22:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XM4VHZZxDNQDC/kIQ5AODC3T43vl8f+astb44lDm/ek=;
        b=TvxRTtZCHFJXjcEDTe729Z5zQUosIb8pDGby8fA+bwIxe0zQMwECeEjnDV0H78GevY
         mPewl1FNXp4V58v+tHz6MevspveFanUf+kdxZHI/TYjWXfhYGl2I1FK6ATML55wA9OoY
         aVRdDHGub3RFSuKwmxvZroy8DVxCsq9nHe7nxOKd/GIlZuTTQgGBPQgowrcXd7AP/uQ8
         F7Yql+3+qYitUF3kHH5YK0bguracKQsp7oKwFv8EC9KaM6zJLxMkOGVVm7xvb1gW4EaL
         806BDqyuXIeROMV8IPhJrlNrGH0e+prf3QUJ0YMOx3HImEY1KeDcvNxVZOq6Lrf3oAW0
         T01w==
X-Gm-Message-State: APjAAAUKFfNz+KEY411qaeIhaZH1W3ZRpUq7sOHyU9BHpxp0dnjdwCvn
        ZZnMvEIljAWnh3Ltb0V1BwCzTOZ2ul4nazdfZaMaleWDZErD
X-Google-Smtp-Source: APXvYqyC8J+B8Rj5TDfbhYgaGQN6Fm/JA1N0Pe0qCc84I5RYprAZT7sEAc2G807/efvhb1WzEXk8e0AWPRvcKq0K+1UAoqkFgvOe
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a2c:: with SMTP id 12mr1017068jao.60.1576651509244;
 Tue, 17 Dec 2019 22:45:09 -0800 (PST)
Date:   Tue, 17 Dec 2019 22:45:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024aa520599f4c933@google.com>
Subject: KASAN: slab-out-of-bounds Write in watch_queue_ioctl
From:   syzbot <syzbot+5a774ffe70862ca9ebc7@syzkaller.appspotmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fca4fe89 Add linux-next specific files for 20191217
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13447c71e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634b7ce01f79423d
dashboard link: https://syzkaller.appspot.com/bug?extid=5a774ffe70862ca9ebc7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13df92fee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1003cafee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5a774ffe70862ca9ebc7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in watch_queue_set_filter  
drivers/misc/watch_queue.c:516 [inline]
BUG: KASAN: slab-out-of-bounds in watch_queue_ioctl+0x15ed/0x16e0  
drivers/misc/watch_queue.c:555
Write of size 4 at addr ffff8880a9b31ddc by task syz-executor545/9097

CPU: 1 PID: 9097 Comm: syz-executor545 Not tainted  
5.5.0-rc2-next-20191217-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_store4_noabort+0x17/0x20 mm/kasan/generic_report.c:139
  watch_queue_set_filter drivers/misc/watch_queue.c:516 [inline]
  watch_queue_ioctl+0x15ed/0x16e0 drivers/misc/watch_queue.c:555
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4401e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe295d2878 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401e9
RDX: 0000000020000240 RSI: 0000000000005761 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a70
R13: 0000000000401b00 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9097:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc include/linux/slab.h:561 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  watch_queue_set_filter drivers/misc/watch_queue.c:505 [inline]
  watch_queue_ioctl+0xf57/0x16e0 drivers/misc/watch_queue.c:555
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8821:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  single_release+0x95/0xc0 fs/seq_file.c:609
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a9b31dc0
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 28 bytes inside of
  32-byte region [ffff8880a9b31dc0, ffff8880a9b31de0)
The buggy address belongs to the page:
page:ffffea0002a6cc40 refcount:1 mapcount:0 mapping:ffff8880aa4001c0  
index:0xffff8880a9b31fc1
raw: 00fffe0000000200 ffffea00029efd48 ffffea0002a6d4c8 ffff8880aa4001c0
raw: ffff8880a9b31fc1 ffff8880a9b31000 000000010000003b 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a9b31c80: 00 fc fc fc fc fc fc fc 00 fc fc fc fc fc fc fc
  ffff8880a9b31d00: 00 03 fc fc fc fc fc fc 00 fc fc fc fc fc fc fc
> ffff8880a9b31d80: 00 fc fc fc fc fc fc fc 00 00 00 fc fc fc fc fc
                                                     ^
  ffff8880a9b31e00: 00 fc fc fc fc fc fc fc 00 fc fc fc fc fc fc fc
  ffff8880a9b31e80: 00 fc fc fc fc fc fc fc 00 fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
