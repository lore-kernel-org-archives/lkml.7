Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F0CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6E12082C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442054AbfJRFpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:45:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40537 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390035AbfJRFpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:45:10 -0400
Received: by mail-io1-f70.google.com with SMTP id r20so7197317ioh.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vCOypHBh3OECg2Eq/MSq4Gogvi0GJhz25khFxxlbxeM=;
        b=bfv7oBhWzYsUrlpA9OHuyq01hbxsF3oJkOv1+3b1V8CijQPv+Co4b7VrvQNMTs/qPb
         slPwrvq6FCHsiFPPzyxbbF21U9JYjt7n27R9t/0sB5P4TrAyQXiDpPVXKpafugbebusF
         brcYCkrWnsxr5haj9rsLlYdQ3k7mUnWdMsYhJ3sB280TFgA9fGhgIcQDiy99gd9e4NaZ
         DAxdgUoYiR2QrTjP9YI4Qr1ISOkyOxOYcanDBGbnK+ak2nMRzFEoC8TNDw/SRQLq+2bj
         HwCgfibLa1w73P4uom0vEwXJBMZHpiU4UgwcZdZxj1L4vVjge29Es8z8lEdgUR0UuRA1
         wdug==
X-Gm-Message-State: APjAAAUW3fHIVa4KyeQnSsICBz9ZYnqFcdbEPpG8aP6w1bhWORfPvUH+
        /50QWkArGvbPh6EdYPEFqknEoj4bvrSWfapENSSTeCY2mv7U
X-Google-Smtp-Source: APXvYqyU7ec5NOQhQcBvzoX8VA2HSA6C/TBnohh8EXdUdOyEEpcGW3LriSforDgxomfKpOf62LRNhxOtq3gF3yVfbY5D0x5zW/jx
MIME-Version: 1.0
X-Received: by 2002:a6b:d104:: with SMTP id l4mr6984812iob.50.1571377509368;
 Thu, 17 Oct 2019 22:45:09 -0700 (PDT)
Date:   Thu, 17 Oct 2019 22:45:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000410cbb059528d6f7@google.com>
Subject: BUG: unable to handle kernel paging request in is_bpf_text_address
From:   syzbot <syzbot+710043c5d1d5b5013bc7@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    283ea345 coccinelle: api/devm_platform_ioremap_resource: r..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122f199b600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0a8b0a0736a2ac1
dashboard link: https://syzkaller.appspot.com/bug?extid=710043c5d1d5b5013bc7
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142676bb600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a2cebb600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+710043c5d1d5b5013bc7@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffc90001923030
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD aa551067 P4D aa551067 PUD aa552067 PMD a572b067 PTE 80000000a1173163
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7982 Comm: syz-executor912 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_jit_binary_hdr include/linux/filter.h:787 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:531 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:600 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find kernel/bpf/core.c:674 [inline]
RIP: 0010:is_bpf_text_address+0x184/0x3b0 kernel/bpf/core.c:709
Code: 89 df e8 ff dd 2e 00 48 8b 1b 48 8d 7b 30 48 89 f8 48 c1 e8 03 48 b9  
00 00 00 00 00 fc ff df 80 3c 08 00 74 05 e8 dc dd 2e 00 <4c> 8b 63 30 48  
c7 c0 00 f0 ff ff 49 21 c4 48 83 c3 02 48 89 d8 48
RSP: 0018:ffff88809569f9c8 EFLAGS: 00010246
RAX: 1ffff92000324606 RBX: ffffc90001923000 RCX: dffffc0000000000
RDX: ffff88809d900500 RSI: ffff8880a8227838 RDI: ffffc90001923030
RBP: ffff88809569fa00 R08: ffffffff817d9d5a R09: ffffed1015d46b05
R10: ffffed1015d46b05 R11: 0000000000000000 R12: ffff88809d900500
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880a8227838
FS:  0000000000728880(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001923030 CR3: 0000000096dc4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kernel_text_address kernel/extable.c:147 [inline]
  __kernel_text_address+0x9a/0x110 kernel/extable.c:102
  unwind_get_return_address+0x4c/0x90 arch/x86/kernel/unwind_frame.c:19
  arch_stack_walk+0x98/0xe0 arch/x86/kernel/stacktrace.c:26
  stack_trace_save+0xb6/0x150 kernel/stacktrace.c:123
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc+0x11c/0x1b0 mm/kasan/common.c:510
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:518
  slab_post_alloc_hook mm/slab.h:584 [inline]
  slab_alloc mm/slab.c:3319 [inline]
  kmem_cache_alloc+0x1f5/0x2e0 mm/slab.c:3483
  getname_flags+0xba/0x640 fs/namei.c:138
  getname+0x19/0x20 fs/namei.c:209
  do_sys_open+0x261/0x560 fs/open.c:1091
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x87/0x90 fs/open.c:1110
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4011a0
Code: 01 f0 ff ff 0f 83 c0 0b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d 2d 15 2d 00 00 75 14 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 94 0b 00 00 c3 48 83 ec 08 e8 fa 00 00 00
RSP: 002b:00007ffd6d953f58 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffd6d953f84 RCX: 00000000004011a0
RDX: 00007ffd6d953f8a RSI: 0000000000080001 RDI: 00000000004a2422
RBP: 00007ffd6d953f80 R08: 0000000000000000 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004021c0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: ffffc90001923030
---[ end trace a62c6ddd9792af6a ]---
RIP: 0010:bpf_jit_binary_hdr include/linux/filter.h:787 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:531 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:600 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find kernel/bpf/core.c:674 [inline]
RIP: 0010:is_bpf_text_address+0x184/0x3b0 kernel/bpf/core.c:709
Code: 89 df e8 ff dd 2e 00 48 8b 1b 48 8d 7b 30 48 89 f8 48 c1 e8 03 48 b9  
00 00 00 00 00 fc ff df 80 3c 08 00 74 05 e8 dc dd 2e 00 <4c> 8b 63 30 48  
c7 c0 00 f0 ff ff 49 21 c4 48 83 c3 02 48 89 d8 48
RSP: 0018:ffff88809569f9c8 EFLAGS: 00010246
RAX: 1ffff92000324606 RBX: ffffc90001923000 RCX: dffffc0000000000
RDX: ffff88809d900500 RSI: ffff8880a8227838 RDI: ffffc90001923030
RBP: ffff88809569fa00 R08: ffffffff817d9d5a R09: ffffed1015d46b05
R10: ffffed1015d46b05 R11: 0000000000000000 R12: ffff88809d900500
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880a8227838
FS:  0000000000728880(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001923030 CR3: 0000000096dc4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
