Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB04C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbfDARfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:35:17 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53236 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387863AbfDARfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:07 -0400
Received: by mail-io1-f69.google.com with SMTP id p143so8811902iod.19
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iGLlZX2B33Bw1O5ccLT+UrabXFiYoqEKO9VXGwpqw4I=;
        b=J1loLBFI3rdID49Fm2J22CNw3/+I416vdJUXrw2l8IflLWi45q+mCUqpvfgLUxjwNO
         y22letseAorjTXezvnYC9vdEp4r01JADyoeRBUXNULLkd8L0D5J1bJUHBPVT1ZlvenU5
         zEJmp356HgShivS/5I///jkFRpGad6lozmEXhKmiLowo6xKivBnPLauqV9rkyqJmsdjO
         zl35JKkReU17X5pjIxrmdYftPbXA4IsSNashawiou+H73z6KesUeY6Vnw66zsgIju3uW
         Oo+twPhPZrPkJggKbN1R5VcCAS8C4wxMT7xlCrdd6mAiAPD5nORjkkUiec5+txRheH+y
         McnA==
X-Gm-Message-State: APjAAAUwpQl2sh8d0pjKZMgzdvvjWw8EkYYQ9d5xtiM1hTj2ygQ+3Y+c
        R8pnhozX+VbqWYHEmwEI616uxD0kIWG0+JZrM4hvJ1w/mc4p
X-Google-Smtp-Source: APXvYqyCKbAPJNQoZhFI5Sc0Lh7fV0mpzjbJpITuPhi1fYYJ5K5fs38qEwEHkvT5O8ksdIU4juY4SbgKjEhU9WrxzZDlyHo85P1n
MIME-Version: 1.0
X-Received: by 2002:a05:660c:288:: with SMTP id s8mr6427090itl.25.1554140106719;
 Mon, 01 Apr 2019 10:35:06 -0700 (PDT)
Date:   Mon, 01 Apr 2019 10:35:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe0a0c05857b70ed@google.com>
Subject: KASAN: use-after-free Read in cma_check_port
From:   syzbot <syzbot+70f6c187224c333bb8da@syzkaller.appspotmail.com>
To:     danielj@mellanox.com, danitg@mellanox.com, dledford@redhat.com,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e3ecb83e Add linux-next specific files for 20190401
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e48937200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db6c9f2bfeb91a99
dashboard link: https://syzkaller.appspot.com/bug?extid=70f6c187224c333bb8da
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+70f6c187224c333bb8da@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in cma_check_port+0x8ce/0x8f0  
drivers/infiniband/core/cma.c:3354
Read of size 8 at addr ffff88809a6e7a08 by task syz-executor.2/901

CPU: 0 PID: 901 Comm: syz-executor.2 Not tainted 5.1.0-rc2-next-20190401 #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  cma_check_port+0x8ce/0x8f0 drivers/infiniband/core/cma.c:3354
  cma_use_port drivers/infiniband/core/cma.c:3391 [inline]
  cma_get_port drivers/infiniband/core/cma.c:3473 [inline]
  rdma_bind_addr+0x19c3/0x1f80 drivers/infiniband/core/cma.c:3591
  cma_bind_addr drivers/infiniband/core/cma.c:3121 [inline]
  rdma_resolve_addr+0x437/0x21f0 drivers/infiniband/core/cma.c:3132
  ucma_resolve_ip+0x153/0x210 drivers/infiniband/core/ucma.c:715
  ucma_write+0x2da/0x3c0 drivers/infiniband/core/ucma.c:1696
  __vfs_write+0x8d/0x110 fs/read_write.c:485
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0xea/0x1f0 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458209
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1cae168c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458209
RDX: 0000000000000048 RSI: 00000000200001c0 RDI: 000000000000000b
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1cae1696d4
R13: 00000000004ce0e8 R14: 00000000004dd828 R15: 00000000ffffffff

Allocated by task 884:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3622
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  cma_alloc_port+0x4f/0x1a0 drivers/infiniband/core/cma.c:3241
  cma_use_port drivers/infiniband/core/cma.c:3389 [inline]
  cma_get_port drivers/infiniband/core/cma.c:3473 [inline]
  rdma_bind_addr+0x1bc0/0x1f80 drivers/infiniband/core/cma.c:3591
  cma_bind_addr drivers/infiniband/core/cma.c:3121 [inline]
  rdma_resolve_addr+0x437/0x21f0 drivers/infiniband/core/cma.c:3132
  ucma_resolve_ip+0x153/0x210 drivers/infiniband/core/ucma.c:715
  ucma_write+0x2da/0x3c0 drivers/infiniband/core/ucma.c:1696
  __vfs_write+0x8d/0x110 fs/read_write.c:485
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0xea/0x1f0 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 881:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3499 [inline]
  kfree+0xcf/0x230 mm/slab.c:3822
  cma_release_port drivers/infiniband/core/cma.c:1773 [inline]
  rdma_destroy_id+0x7fc/0xaa0 drivers/infiniband/core/cma.c:1840
  ucma_close+0x115/0x320 drivers/infiniband/core/ucma.c:1777
  __fput+0x2e5/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809a6e7a00
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 8 bytes inside of
  32-byte region [ffff88809a6e7a00, ffff88809a6e7a20)
The buggy address belongs to the page:
page:ffffea000269b9c0 count:1 mapcount:0 mapping:ffff88812c3f01c0  
index:0xffff88809a6e7fc1
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002945248 ffffea00023b0f48 ffff88812c3f01c0
raw: ffff88809a6e7fc1 ffff88809a6e7000 0000000100000039 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809a6e7900: 00 01 fc fc fc fc fc fc fb fb fb fb fc fc fc fc
  ffff88809a6e7980: fb fb fb fb fc fc fc fc 00 00 fc fc fc fc fc fc
> ffff88809a6e7a00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                       ^
  ffff88809a6e7a80: 00 00 00 00 fc fc fc fc fb fb fb fb fc fc fc fc
  ffff88809a6e7b00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
