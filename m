Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E12BC2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDC024673
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLGRfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:35:10 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:33490 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLGRfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 12:35:09 -0500
Received: by mail-il1-f198.google.com with SMTP id s14so8001130ila.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 09:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PssgSEg/sffQDcKK+621ku6PbuChp8EAKykjz+P/qoA=;
        b=UrvfBsqjoFg8l3g2UzTKZ7d/b2P2iWKaEy0TATNRzXS2azmy0wNcx4CpO8zOC/egHA
         mkSRa+Gqwen2DkHGkwGQ52hnwQmg/EFDOxV5ugoZJV592bTpbllBHL4VWPx6lENQPnCV
         pBbXnZ0gAbvMw+B1CE8/pt8Pula5JQ7WDcUxjWlu8MNZhYjbPuTLLpyUo/v6QFERt37W
         gBeblldB9/bLFnmMMd+CGlDYUHYvxHPPnPfLbMIvbXO4iAciibXGCrqm8sQzD6WnxImr
         FtlH+DYB8Yrf+qLURtaOq6uTn6FeCnyShifFpcLfzyNs3TCcXkGYh3f292B6ub3/OU67
         5rrw==
X-Gm-Message-State: APjAAAUC+mFdNgW3fphNfGfPncofZ94ui6tmIg5HZ/lkHa0EFB4j80SQ
        raCNJT/EpiPD28IwWdAlWvk5w5QZM7Fv1GjuOGmw6RlQUryE
X-Google-Smtp-Source: APXvYqzfmmLpffgywS+1zLmFa/YMDlmc9SXPol0s2NAySfPATYZliKe3wbaCdSZ3EZKOQ2a7FhhQXg+ZRIGKe6UmuHzE6z5dhuEV
MIME-Version: 1.0
X-Received: by 2002:a6b:e008:: with SMTP id z8mr14498726iog.246.1575740109054;
 Sat, 07 Dec 2019 09:35:09 -0800 (PST)
Date:   Sat, 07 Dec 2019 09:35:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000756ba505992095eb@google.com>
Subject: WARNING in video_unregister_device
From:   syzbot <syzbot+107e71ba620a63af4335@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1f22d15c usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1486d1bce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ccee2968018adcb
dashboard link: https://syzkaller.appspot.com/bug?extid=107e71ba620a63af4335
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1399bb7ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e80e41e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+107e71ba620a63af4335@syzkaller.appspotmail.com

usbvision_radio_close: Final disconnect
------------[ cut here ]------------
sysfs group 'power' not found for kobject 'radio5'
WARNING: CPU: 1 PID: 1791 at fs/sysfs/group.c:278 sysfs_remove_group  
fs/sysfs/group.c:278 [inline]
WARNING: CPU: 1 PID: 1791 at fs/sysfs/group.c:278  
sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 1791 Comm: v4l_id Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xef/0x16e lib/dump_stack.c:118
  panic+0x2aa/0x6e1 kernel/panic.c:221
  __warn.cold+0x2f/0x30 kernel/panic.c:582
  report_bug+0x27b/0x2f0 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:sysfs_remove_group fs/sysfs/group.c:278 [inline]
RIP: 0010:sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c  
01 00 75 41 48 8b 33 48 c7 c7 e0 ba d0 85 e8 73 1f 87 ff <0f> 0b eb 95 e8  
22 d4 d9 ff e9 d2 fe ff ff 48 89 df e8 15 d4 d9 ff
RSP: 0018:ffff8881ce73fc50 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff85f34ac0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8128ebcd RDI: ffffed1039ce7f7c
RBP: 0000000000000000 R08: ffff8881cf2f1880 R09: ffffed103b6a439f
R10: ffffed103b6a439e R11: ffff8881db521cf7 R12: ffff8881ce638af8
R13: ffffffff85f35060 R14: 0000000000000000 R15: ffff8881ce638fb8
  dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:741
  device_del+0x18b/0xd30 drivers/base/core.c:2641
  device_unregister+0x11/0x30 drivers/base/core.c:2696
  video_unregister_device+0xa2/0xc0 drivers/media/v4l2-core/v4l2-dev.c:1076
  usbvision_unregister_video+0x83/0x120  
drivers/media/usb/usbvision/usbvision-video.c:1244
  usbvision_release+0x10d/0x1c0  
drivers/media/usb/usbvision/usbvision-video.c:1357
  usbvision_radio_close.cold+0x2b/0x74  
drivers/media/usb/usbvision/usbvision-video.c:1130
  v4l2_release+0x2e7/0x390 drivers/media/v4l2-core/v4l2-dev.c:455
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:164
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_64+0x4d1/0x5b0 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f0fec1542b0
Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 32 08 00 e8 c0  
07 02 00 83 3d 45 a3 2b 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 ce 8a 01 00 48 89 04 24
RSP: 002b:00007ffd13444a48 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f0fec1542b0
RDX: 0000000000000013 RSI: 0000000080685600 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000400884
R13: 00007ffd13444ba0 R14: 0000000000000000 R15: 0000000000000000
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
