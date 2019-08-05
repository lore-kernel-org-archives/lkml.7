Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2FDC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D80120B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfHEMiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:38:12 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:39341 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfHEMiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:38:08 -0400
Received: by mail-io1-f69.google.com with SMTP id y13so91981926iol.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HZdhLj0O75Ng7akN6Onv+fy8trbuFE7Ss5Yu/JZAlv0=;
        b=OVqbq4DRKUnPPlE6fc521TFIafhraFzojsedMEWJn44oZi6SXdP5UgVvkXsVIGnvZr
         U1jA/Er4s5NnzbJn9Tbvj9GaZ++J8VXG3X0S8DPkdJJskmrbRJXvcHQ5fZFOCdL8C2rD
         XiCXlzslwULy3/5eSsBHtY63HPBD+nJFcsJjknGV9uVQUtK69fpZi3CwEb7mGbM0JbHz
         KRAqcbNjO8/34a+c+AHQPkVmksICRZtxpm72ENPVi2zzXX5xZjtpGkaHB/IHiJrPapLb
         nJjL6PXlJCDcfK3CD1Ep2cm7/hoa1zK/VquO5nDSCU4SQNudf3fJ4jJVbrhk5/9WSXra
         3Qmg==
X-Gm-Message-State: APjAAAXKKaRJi6ZCxiMyEyfifgu+GMqPlFJ5Yi2iUSr/IvWph0Sf3ZbQ
        kcnvGtix/TJssRUQREAhpExcPbbg+CsUWD4eC7cWIsVb4nKk
X-Google-Smtp-Source: APXvYqzNIZ9GgKoZyed1achZuQFZvckuFTbMR0m9Lz3oRMBM862gchE7M6TvUiRxLz7tAQAO5QW6TlBuOBI0rIh1xdgG1G34lESE
MIME-Version: 1.0
X-Received: by 2002:a6b:f910:: with SMTP id j16mr18568149iog.256.1565008687873;
 Mon, 05 Aug 2019 05:38:07 -0700 (PDT)
Date:   Mon, 05 Aug 2019 05:38:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e94632058f5dfabc@google.com>
Subject: WARNING in __blkdev_put (2)
From:   syzbot <syzbot+34a8ffb71f7fb32ecca2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    dcb8cfbd Merge tag 'for-linus-5.3a-rc3-tag' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1478050c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7b914a2680c9c6
dashboard link: https://syzkaller.appspot.com/bug?extid=34a8ffb71f7fb32ecca2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17190230600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+34a8ffb71f7fb32ecca2@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device batadv0
WARNING: CPU: 1 PID: 10201 at fs/block_dev.c:1899 __blkdev_put+0x6ba/0x810  
fs/block_dev.c:1899
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 10201 Comm: syz-executor.0 Not tainted 5.3.0-rc2+ #114
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
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1026
RIP: 0010:__blkdev_put+0x6ba/0x810 fs/block_dev.c:1899
Code: 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 84 24 fd ff ff 48 8b bd  
50 ff ff ff e8 90 75 e6 ff e9 13 fd ff ff e8 56 5e ac ff <0f> 0b e9 dc fa  
ff ff 48 89 cf e8 57 75 e6 ff e9 6a fa ff ff 48 8b
RSP: 0018:ffff888094a87c90 EFLAGS: 00010293
RAX: ffff888091ccc2c0 RBX: ffff8880a3182740 RCX: ffffffff81c63be4
RDX: 0000000000000000 RSI: ffffffff81c6410a RDI: 0000000000000005
RBP: ffff888094a87d88 R08: ffff888091ccc2c0 R09: ffffed10146304ec
R10: ffff888094a87c80 R11: ffff8880a318275f R12: 0000000000000002
R13: dffffc0000000000 R14: ffff8880a3182758 R15: ffff8880a3182758
  blkdev_put+0x98/0x560 fs/block_dev.c:1969
  blkdev_close+0x8b/0xb0 fs/block_dev.c:1976
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x5a9/0x6a0 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4134f0
Code: 01 f0 ff ff 0f 83 30 1b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d 9d 2d 66 00 00 75 14 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 04 1b 00 00 c3 48 83 ec 08 e8 0a fc ff ff
RSP: 002b:00007fffd29519c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000004134f0
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000003
RBP: 00000000007104e0 R08: 0000000000000000 R09: 000000000000000a
R10: 0000000000000075 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffd2951a00 R14: 0000000000000003 R15: 00007fffd2951a10
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
