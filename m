Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A23C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB6B20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCGSYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:24:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:52284 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfCGSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:24:05 -0500
Received: by mail-io1-f71.google.com with SMTP id s18so13636420ioe.19
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Z53JwIHDEkc69tZ4tX9P34Szhzj2Z1J469Ll3jRCLqw=;
        b=nv+qvRnYGOLyYaMtLSiiQjxk167f+Nnw2wg+e6c6hqmXOSds3pwmODjJKdeGIJl0B5
         bkHrOieK7wkds3oKi+6dNSw24x//BKHBkCpXW6z66kZWNjF+uyZQmz3F1HXOXvDtIoqn
         NYdilN/dLjGYfiEJ3n86/UE6I5t1rRrKYs6nS7XH+oyczIjx+a/z2DwOCSuxZqsZyqNi
         13t51mSchLdIszywoiYuWm8LK5OAXnvZzH0o3KAfKRUl2p0iy/FLmeCXIluAIkw8Vcmi
         LvcTIC8DKxJpxwcDO1vQugyYl2saqKu8hSxozLPx6l/iRFvUfkrJ5jO5HMatnmBxroZh
         e4uQ==
X-Gm-Message-State: APjAAAX39YnSMg/sluDV8hDn3wyhyfP5DKWkVXDbI7PJ5pqoy0J640X9
        KSf/84HwQ0pw/c7Z/eMYDV/ktUeanl1fnNxjEsRaBkzLFjhK
X-Google-Smtp-Source: APXvYqw/5T9mIB8jzvkEdFviJartR3ei1Pqslr6fSY1mHKv4DPOCRu0ElpgMO/K9Bu3dewFlY+SaVKuZw8NsF+Qo81Z//wKS5e4t
MIME-Version: 1.0
X-Received: by 2002:a6b:c9c4:: with SMTP id z187mr72483iof.4.1551983043875;
 Thu, 07 Mar 2019 10:24:03 -0800 (PST)
Date:   Thu, 07 Mar 2019 10:24:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000071b3c05838536b8@google.com>
Subject: KASAN: slab-out-of-bounds Read in tcp_sk_exit
From:   syzbot <syzbot+dfc9db054bca3a83f4a0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e15aa3b2b138 ucc_geth: Reset BQL queue when stopping device
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=149b240f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
dashboard link: https://syzkaller.appspot.com/bug?extid=dfc9db054bca3a83f4a0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dfc9db054bca3a83f4a0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in inet_ctl_sock_destroy  
include/net/inet_common.h:56 [inline]
BUG: KASAN: slab-out-of-bounds in tcp_sk_exit+0x203/0x230  
net/ipv4/tcp_ipv4.c:2588
Read of size 8 at addr ffff88808a260bac by task kworker/u4:4/2564

CPU: 0 PID: 2564 Comm: kworker/u4:4 Not tainted 5.0.0-rc4+ #53
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  inet_ctl_sock_destroy include/net/inet_common.h:56 [inline]
  tcp_sk_exit+0x203/0x230 net/ipv4/tcp_ipv4.c:2588
  ops_exit_list.isra.0+0xb0/0x160 net/core/net_namespace.c:153
  cleanup_net+0x51d/0xb10 net/core/net_namespace.c:551
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 8016:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:496 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
  kasan_kmalloc mm/kasan/common.c:504 [inline]
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:411
  kmem_cache_alloc+0x12d/0x710 mm/slab.c:3543
  getname_flags fs/namei.c:140 [inline]
  getname_flags+0xd6/0x5b0 fs/namei.c:129
  user_path_at_empty+0x2f/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  vfs_statx+0x129/0x210 fs/stat.c:185
  vfs_lstat include/linux/fs.h:3175 [inline]
  __do_sys_newlstat+0xa4/0x130 fs/stat.c:352
  __se_sys_newlstat fs/stat.c:346 [inline]
  __x64_sys_newlstat+0x54/0x80 fs/stat.c:346
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8016:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
  __cache_free mm/slab.c:3487 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3749
  putname+0xef/0x130 fs/namei.c:261
  filename_lookup+0x359/0x530 fs/namei.c:2357
  user_path_at_empty+0x43/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  vfs_statx+0x129/0x210 fs/stat.c:185
  vfs_lstat include/linux/fs.h:3175 [inline]
  __do_sys_newlstat+0xa4/0x130 fs/stat.c:352
  __se_sys_newlstat fs/stat.c:346 [inline]
  __x64_sys_newlstat+0x54/0x80 fs/stat.c:346
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808a260e80
  which belongs to the cache names_cache of size 4096
The buggy address is located 724 bytes to the left of
  4096-byte region [ffff88808a260e80, ffff88808a261e80)
The buggy address belongs to the page:
page:ffffea0002289800 count:1 mapcount:0 mapping:ffff88821bc45380 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002289888 ffffea000257cf88 ffff88821bc45380
raw: 0000000000000000 ffff88808a260e80 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808a260a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88808a260b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88808a260b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                   ^
  ffff88808a260c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88808a260c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
