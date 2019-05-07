Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE72C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA13E204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEGJmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:42:05 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33653 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfEGJmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:42:05 -0400
Received: by mail-io1-f71.google.com with SMTP id s24so1726886iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 02:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1kVNvqakmicf7aNhAvhZA1wt0SIlOobV5WRUyLotBRI=;
        b=bCV9qR8uzdFWUTS/ZPKuQP7kSdEOa5KiFt9s/ARp9AQkSWF/RALUYEwC+44wZGSTuh
         icAZjRSajaOyucJ5UySTCskKzUl1CVRDZiWWSpf50fqjdkNdhBBxPCHWWLS7s+NZZflz
         YOgvPjzypAVCSVi/Kq5SejIgcc5V7tmrEfTTMXizRvRVPtDU1Gm5sAAYyW3mGYUmfOvn
         muH7D48yp7UGq1yoJv0O6VWmhtbpz9+9Q7hEgi37Jfbso/Cv1/gwbb97X2+XGQHNIgL0
         ZJSSsJc4UGJRDkWxKZE2X6ka53YB/eSzFcQw+m2wAbP/JgaHudYGwvm6Lp9KU0ArcRYq
         pgvw==
X-Gm-Message-State: APjAAAVydpjsU0i+mV8JByo4IJCeTObJq4vWB7ljldJp46K33BMoOckw
        /PJwsYbWOwSmMGS0oW7Ac6kmUrdrr/tybdpWXbiX5/NZimxb
X-Google-Smtp-Source: APXvYqz7jnXKDGwwNP7mFFwyRYlU5bTL7KRJHg86d2aVwxwMVJ1zdvvmfFO8Oa41yobcBbvdBiQAMaQlTr5i51dp4kJE3Dg6zGDJ
MIME-Version: 1.0
X-Received: by 2002:a05:660c:ac6:: with SMTP id k6mr20929488itl.59.1557222124088;
 Tue, 07 May 2019 02:42:04 -0700 (PDT)
Date:   Tue, 07 May 2019 02:42:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008af53105884907e9@google.com>
Subject: KASAN: use-after-free Write in check_and_subscribe_port
From:   syzbot <syzbot+20ab495fadf081e8a2b0@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, colin.king@canonical.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bf3bd966 Merge tag 'usb-5.1-rc8' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1431a0e0a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef1b87b455c397cf
dashboard link: https://syzkaller.appspot.com/bug?extid=20ab495fadf081e8a2b0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+20ab495fadf081e8a2b0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add include/linux/list.h:64 [inline]
BUG: KASAN: use-after-free in list_add_tail include/linux/list.h:93 [inline]
BUG: KASAN: use-after-free in check_and_subscribe_port+0x7bd/0x860  
sound/core/seq/seq_ports.c:524
Write of size 8 at addr ffff88809587bba0 by task syz-executor.2/19168

CPU: 0 PID: 19168 Comm: syz-executor.2 Not tainted 5.1.0-rc7+ #95
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/generic_report.c:137
  __list_add include/linux/list.h:64 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  check_and_subscribe_port+0x7bd/0x860 sound/core/seq/seq_ports.c:524
  snd_seq_port_connect+0x388/0x510 sound/core/seq/seq_ports.c:587
  snd_seq_ioctl_subscribe_port+0x1e5/0x310  
sound/core/seq/seq_clientmgr.c:1458
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
RIP: 0033:0x458da9
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6a5c605c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458da9
RDX: 0000000020000000 RSI: 0000000040505330 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6a5c6066d4
R13: 00000000004cc598 R14: 00000000004d5ee8 R15: 00000000ffffffff

Allocated by task 19168:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3622
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  snd_seq_port_connect+0x60/0x510 sound/core/seq/seq_ports.c:571
  snd_seq_ioctl_subscribe_port+0x1e5/0x310  
sound/core/seq/seq_clientmgr.c:1458
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

Freed by task 19167:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3499 [inline]
  kfree+0xcf/0x230 mm/slab.c:3822
  snd_seq_port_disconnect+0x209/0x280 sound/core/seq/seq_ports.c:632
  snd_seq_ioctl_unsubscribe_port+0x1e5/0x310  
sound/core/seq/seq_clientmgr.c:1499
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

The buggy address belongs to the object at ffff88809587bb40
  which belongs to the cache kmalloc-128 of size 128
The buggy address is located 96 bytes inside of
  128-byte region [ffff88809587bb40, ffff88809587bbc0)
The buggy address belongs to the page:
page:ffffea0002561ec0 count:1 mapcount:0 mapping:ffff8880aa400640  
index:0xffff88809587bd80
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002949788 ffffea0002906888 ffff8880aa400640
raw: ffff88809587bd80 ffff88809587b000 000000010000000f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809587ba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809587bb00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff88809587bb80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                ^
  ffff88809587bc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809587bc80: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
