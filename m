Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B50C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB607205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbfHWC2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:28:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51641 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389429AbfHWC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:09 -0400
Received: by mail-io1-f71.google.com with SMTP id a13so8876035ioh.18
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 19:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=k+TPgBXPm6Ne0/lp7Dg6G91cDEKVOdGQH22JkWRhdX4=;
        b=Md+ddPZaVnxnhKzwTWZPHBDJnGpZpDadp/mIDYxjEy5DveSzRo8CEAj6Be0AtKr9/0
         pUlakbl6+FHaFQH/SfIgElc50qQxJgxrgcQzR0wStSM3G4p/ssP8+31kEz2BzP+BupJr
         6icNo2zdzdSSXHwh+qLiPaQ4BxTufuDwEIbThdWz9CqSDvXQ5Y6R3Um7rK64fIOQY1VY
         DxjhwDMID39x1mgn4kfk6imP4puLgDRmdkujTjaHjL2pJd4tNQ3lV1VckYBUi8r6uq/O
         ANVlL55q6w986rY1ELG76rGV771XcERqOjUCZkHfEWkOGrd8RYOrwxj1mEzsTjJ195Dn
         fvOA==
X-Gm-Message-State: APjAAAW5aGS6PS7i1MNZBqkcD3U4aqASVrnDK97s1GZr4fbdBz95ZwEp
        tPikxtGsoHXaOwhqRGEHP/BKhGgqB2pfQStPJGHKwTtJyCMY
X-Google-Smtp-Source: APXvYqya+K1W6MWnFCJTkoIaRo3JP3vr0FS2WHEvS8Hl+bbUXA3t688lruvYkFKYWbFcjodOCKVqbDnm9Vf9B/CD3GgzMt4d7Dwk
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2585:: with SMTP id p5mr2235235ioo.183.1566527288633;
 Thu, 22 Aug 2019 19:28:08 -0700 (PDT)
Date:   Thu, 22 Aug 2019 19:28:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091f4960590bf8e8c@google.com>
Subject: WARNING in loop_add
From:   syzbot <syzbot+f41893bb8c45cd18cf08@syzkaller.appspotmail.com>
To:     akinobu.mita@gmail.com, akpm@linux-foundation.org, axboe@kernel.dk,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bb7ba806 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1272e012600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6919752cc1b760b4
dashboard link: https://syzkaller.appspot.com/bug?extid=f41893bb8c45cd18cf08
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12aa5af2600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173eea1e600000

The bug was bisected to:

commit e41d58185f1444368873d4d7422f7664a68be61d
Author: Dmitry Vyukov <dvyukov@google.com>
Date:   Wed Jul 12 21:34:35 2017 +0000

     fault-inject: support systematic fault injection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12979da6600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11979da6600000
console output: https://syzkaller.appspot.com/x/log.txt?x=16979da6600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f41893bb8c45cd18cf08@syzkaller.appspotmail.com
Fixes: e41d58185f14 ("fault-inject: support systematic fault injection")

RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007fff862aa420 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
------------[ cut here ]------------
WARNING: CPU: 0 PID: 10346 at block/genhd.c:732  
__device_add_disk.cold+0x11/0x19e block/genhd.c:732
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 10346 Comm: syz-executor227 Not tainted 5.3.0-rc5+ #139
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:__device_add_disk.cold+0x11/0x19e block/genhd.c:732
Code: 41 bc f0 ff ff ff e8 ff c7 2c fe 48 8b 7d d0 e8 52 ed 7c fe e9 ba 7a  
ff ff e8 18 27 43 fe 48 c7 c7 40 c5 c4 87 e8 e0 c7 2c fe <0f> 0b e9 7b de  
ff ff e8 00 27 43 fe 48 c7 c7 40 c5 c4 87 e8 c8 c7
RSP: 0018:ffff88808899faf8 EFLAGS: 00010286
RAX: 0000000000000024 RBX: 00000000fffffff4 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815c2526 RDI: ffffed1011133f51
RBP: ffff88808899fc10 R08: 0000000000000024 R09: ffffed1015d060d1
R10: ffffed1015d060d0 R11: ffff8880ae830687 R12: ffff8880a9a895c0
R13: ffff8880a9a89650 R14: ffff88808899fbe8 R15: ffff8880a9a895c4
  device_add_disk+0x2b/0x40 block/genhd.c:754
  add_disk include/linux/genhd.h:429 [inline]
  loop_add+0x635/0x8d0 drivers/block/loop.c:2050
  loop_control_ioctl drivers/block/loop.c:2151 [inline]
  loop_control_ioctl+0x165/0x360 drivers/block/loop.c:2133
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441319
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff862aa408 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441319
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007fff862aa420 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
