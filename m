Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97CAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836312177E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDCG5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:57:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:43035 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfDCG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:57:06 -0400
Received: by mail-io1-f70.google.com with SMTP id n23so12926588ioj.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 23:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=S2hvMXzs+VNj3ka/A/l2KqIAsyczNg+PUTWaEpB8+t4=;
        b=E7leDKgDi1HpjIHvlAe0r1VU3oLiTE3+lfHyPqOhiEoMWYbGiL3pu+yV7+cSn+pvrc
         Ouq4UYDU2BrlzbC24lJqnXMNPcsQd8UYA70K5WGHPveYh10U1/VPhihMhPoOxoaEf4LU
         FW7T0xNZrwyPGtu/urMQJVRhV5oXB00SWnRniTZPHoEtZhgXsiFBH3QfK3ymM8HKCMVG
         09LOZ7dqh3wpxvexCyuWRZCC/D4zKfCylTQmOTVyc3DI6r5ui0f5aaSt7ipdWg6iUJYW
         sh86K7gfG8DRC6Jyip3YJgkVa7zQoPW+Rbh5LOhDeiDmbEAsBIbs8FH+DeTNkTwdfC8q
         X6LQ==
X-Gm-Message-State: APjAAAU9foAWyFDLxEJO49PRICaNUoqqTPNZpBqRrRR6/TaeNVJ5A54H
        x/uJDJxmonINvCo5rXEsHx8O19XzRyiYcHQhyIQ4tK7KTgSx
X-Google-Smtp-Source: APXvYqxEgPYneNKnjqa0+TC7/nWGIdIxxYQndjVN0YtpfYp7TrO0RqIk/BCPPbpfipo+iEMcrJK5THkWuvZSj4DNYeyV7fw++J2r
MIME-Version: 1.0
X-Received: by 2002:a24:e4a:: with SMTP id 71mr174922ite.0.1554274625236; Tue,
 02 Apr 2019 23:57:05 -0700 (PDT)
Date:   Tue, 02 Apr 2019 23:57:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebb6bc05859ac2cf@google.com>
Subject: KASAN: use-after-free Read in rdma_bind_addr
From:   syzbot <syzbot+68b44a1597636e0b342c@syzkaller.appspotmail.com>
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

HEAD commit:    05d08e29 Add linux-next specific files for 20190402
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10333a97200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96b7dfefc1d73906
dashboard link: https://syzkaller.appspot.com/bug?extid=68b44a1597636e0b342c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+68b44a1597636e0b342c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in cma_alloc_any_port  
drivers/infiniband/core/cma.c:3319 [inline]
BUG: KASAN: use-after-free in cma_get_port  
drivers/infiniband/core/cma.c:3471 [inline]
BUG: KASAN: use-after-free in rdma_bind_addr+0x1dfa/0x1f80  
drivers/infiniband/core/cma.c:3591
Read of size 8 at addr ffff88809a696448 by task syz-executor.3/28371

CPU: 1 PID: 28371 Comm: syz-executor.3 Not tainted 5.1.0-rc3-next-20190402  
#16
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  cma_alloc_any_port drivers/infiniband/core/cma.c:3319 [inline]
  cma_get_port drivers/infiniband/core/cma.c:3471 [inline]
  rdma_bind_addr+0x1dfa/0x1f80 drivers/infiniband/core/cma.c:3591
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
RIP: 0033:0x4582b9
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f98544c5c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004582b9
RDX: 0000000000000048 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f98544c66d4
R13: 00000000004ce188 R14: 00000000004dd8c8 R15: 00000000ffffffff

Allocated by task 28213:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  __do_kmalloc mm/slab.c:3727 [inline]
  __kmalloc+0x15c/0x740 mm/slab.c:3736
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  lsm_cred_alloc security/security.c:467 [inline]
  security_prepare_creds+0x123/0x190 security/security.c:1510
  prepare_creds+0x2f5/0x3f0 kernel/cred.c:280
  do_faccessat+0xa2/0x7f0 fs/open.c:359
  __do_sys_access fs/open.c:430 [inline]
  __se_sys_access fs/open.c:428 [inline]
  __x64_sys_access+0x59/0x80 fs/open.c:428
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3499 [inline]
  kfree+0xcf/0x230 mm/slab.c:3822
  security_cred_free+0xaf/0x110 security/security.c:1504
  put_cred_rcu+0x129/0x4b0 kernel/cred.c:118
  __rcu_reclaim kernel/rcu/rcu.h:227 [inline]
  rcu_do_batch kernel/rcu/tree.c:2475 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2788 [inline]
  rcu_core+0x928/0x1390 kernel/rcu/tree.c:2769
  __do_softirq+0x266/0x95a kernel/softirq.c:293

The buggy address belongs to the object at ffff88809a696440
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 8 bytes inside of
  32-byte region [ffff88809a696440, ffff88809a696460)
The buggy address belongs to the page:
page:ffffea000269a580 count:1 mapcount:0 mapping:ffff88812c3f01c0  
index:0xffff88809a696fc1
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000285d2c8 ffffea0002a0ab88 ffff88812c3f01c0
raw: ffff88809a696fc1 ffff88809a696000 000000010000003e 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809a696300: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff88809a696380: 00 00 fc fc fc fc fc fc fb fb fb fb fc fc fc fc
> ffff88809a696400: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                                               ^
  ffff88809a696480: 00 00 03 fc fc fc fc fc 00 00 03 fc fc fc fc fc
  ffff88809a696500: fb fb fb fb fc fc fc fc 00 00 02 fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
