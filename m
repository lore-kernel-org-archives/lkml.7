Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBAC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB0520859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbfFJJaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:30:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37469 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388380AbfFJJaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:30:06 -0400
Received: by mail-io1-f69.google.com with SMTP id j18so7108277ioj.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 02:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Np+xPJWikxtIIlIvGvVx4ZfVKde2a2GTO356MNseHYo=;
        b=jgqjHfoqTDqz37qexxOpEsTq11cEhkUCvsOoqKbFCe5Y/H3sPCzUsN22D+kyPvMYyQ
         sH+K/Hvd5BiSe4lOIBtoHn8D5+p1lWH3NLxAFBtAwmUizDt5zYr8F0z/xds+Ukiv8qcU
         a5LMhPaTa4DSHiTZp2ucfCXFNaV6cIV/1VK9Yq/J8YhqKDMKI66Wp3rcARAxZF2Cj4vH
         5Z0N8IYl/FA0cD+vbP8Gpmuu6QlpTG4K+rq15oT/vJMwO649xoocvycwUbG4hpeeYeM2
         uPQ3s1ombALYCz9sYiPECwtAe/AQEZoHiLkTZt1AMkNs+bkKgMIzSIDVEMvnc+zTH0m6
         wk+Q==
X-Gm-Message-State: APjAAAWZY37a5iHX+KVacln6SeUROd3RbJHVF3Si7+G4/9X1tgrijUN/
        ligBzPzkV0Pa3FNidoDZjWIdDJLD4/WfiaD/om5qvlBPkr8d
X-Google-Smtp-Source: APXvYqz2M+f0Q17h76RoBB7choSL+vGIvH++EpNIaPAzhimyQwDJcGoElZVdPCA72l9rTJFgMT/hvree53vNcYjlWWDhxWCDz0Rs
MIME-Version: 1.0
X-Received: by 2002:a24:690f:: with SMTP id e15mr378569itc.31.1560159005811;
 Mon, 10 Jun 2019 02:30:05 -0700 (PDT)
Date:   Mon, 10 Jun 2019 02:30:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055aba7058af4d378@google.com>
Subject: KASAN: null-ptr-deref Read in css_task_iter_advance
From:   syzbot <syzbot+d4bba5ccd4f9a2a68681@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
        daniel@iogearbox.net, hannes@cmpxchg.org, kafai@fb.com,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3f310e51 Add linux-next specific files for 20190607
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=170acfa6a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d176e1849bbc45
dashboard link: https://syzkaller.appspot.com/bug?extid=d4bba5ccd4f9a2a68681
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d4bba5ccd4f9a2a68681@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in atomic_read  
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: null-ptr-deref in css_task_iter_advance+0x240/0x540  
kernel/cgroup/cgroup.c:4503
Read of size 4 at addr 0000000000000004 by task syz-executor.2/26575

CPU: 1 PID: 26575 Comm: syz-executor.2 Not tainted 5.2.0-rc3-next-20190607  
#11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __kasan_report.cold+0x5/0x36 mm/kasan/report.c:486
  kasan_report+0x12/0x20 mm/kasan/common.c:614
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_read+0x11/0x20 mm/kasan/common.c:94
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  css_task_iter_advance+0x240/0x540 kernel/cgroup/cgroup.c:4503
  css_task_iter_start+0x18b/0x230 kernel/cgroup/cgroup.c:4543
  __cgroup_procs_start.isra.0+0x32f/0x400 kernel/cgroup/cgroup.c:4638
  cgroup_procs_start kernel/cgroup/cgroup.c:4660 [inline]
  cgroup_procs_start+0x1e7/0x260 kernel/cgroup/cgroup.c:4647
  cgroup_seqfile_start+0xa4/0xd0 kernel/cgroup/cgroup.c:3752
  kernfs_seq_start+0xdc/0x190 fs/kernfs/file.c:118
  seq_read+0x2a7/0x1110 fs/seq_file.c:224
  kernfs_fop_read+0xed/0x560 fs/kernfs/file.c:252
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_loop_readv_writev fs/read_write.c:701 [inline]
  do_iter_read+0x4a4/0x660 fs/read_write.c:935
  vfs_readv+0xf0/0x160 fs/read_write.c:997
  do_preadv+0x1c4/0x280 fs/read_write.c:1089
  __do_sys_preadv fs/read_write.c:1139 [inline]
  __se_sys_preadv fs/read_write.c:1134 [inline]
  __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1134
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459279
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4ee9fa8c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000459279
RDX: 0000000000000001 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4ee9fa96d4
R13: 00000000004c6376 R14: 00000000004dae78 R15: 00000000ffffffff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
