Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2BCC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 02:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33822067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 02:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfJNCtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 22:49:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45301 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfJNCtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 22:49:10 -0400
Received: by mail-io1-f72.google.com with SMTP id o11so24458615iop.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 19:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=brK6Pe22BCheDH0r6EK7TH9JTuiXpjXVe6qNIAjBlGY=;
        b=pFCY9mGusKnpMk80HlHQYfK/F5s3/EugFwBxaNEW+15BgX8B02nuM9bpHB/fU/SLc4
         ph82NbjXbe/6exRC14hBUnsRhC7DHi3OGHtQzObxvHgtduzddia0WzOJD9fvmfJYeBeD
         UyzhVSljc/og+vG6fnvA5Bw+D5SWs+HYx52RyuXPsbeLMPkUwvAi81PFwaJTMjYHqxk3
         Qbr50tIeKqcnEZiMluuGM9/QtiC+2gA5U0LlMZ0MXQhVUUq80QyHoxZdBctbgkdU4B1A
         ix1QvtHEnWbj0duYyaIsWo3Jsp1e2PDbDq6RNNjYeLbsp93XQzveOUPFmo4CpQcGokx3
         MyDg==
X-Gm-Message-State: APjAAAUkayCD38wwh9O38KuHeSLX7tEwandWRG+S8wg0fMtXi1N1s1RV
        +F+xH1trXtvV94oXY/o/zQzfPWztV6u39sT89lsFoqvZJwoW
X-Google-Smtp-Source: APXvYqxeknaBYJVmnQjgdk1127GtZjIi7qUktFkjf5pYqMp/nouETGJ4Nb1wvTnHkm8D9pNfpVhH+zQALkMgBIv65enF/DpmoU4R
MIME-Version: 1.0
X-Received: by 2002:a02:9084:: with SMTP id x4mr34707800jaf.76.1571021348660;
 Sun, 13 Oct 2019 19:49:08 -0700 (PDT)
Date:   Sun, 13 Oct 2019 19:49:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bed900594d5e99a@google.com>
Subject: WARNING in vkms_gem_free_object
From:   syzbot <syzbot+e7ad70d406e74d8fc9d0@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        oleg.vasilev@intel.com, omrigann@gmail.com,
        rodrigosiqueiramelo@gmail.com, simon.ser@intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8ada228a Add linux-next specific files for 20191011
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c30b1b600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cf4eed5fe42c31a
dashboard link: https://syzkaller.appspot.com/bug?extid=e7ad70d406e74d8fc9d0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1087d31b600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e27c53600000

The bug was bisected to:

commit 94e2ec3f7fef86506293a448273b2b4ee21e6195
Author: Oleg Vasilev <omrigann@gmail.com>
Date:   Mon Sep 30 15:59:24 2019 +0000

     drm/vkms: prime import support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15ef2d57600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17ef2d57600000
console output: https://syzkaller.appspot.com/x/log.txt?x=13ef2d57600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e7ad70d406e74d8fc9d0@syzkaller.appspotmail.com
Fixes: 94e2ec3f7fef ("drm/vkms: prime import support")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 9040 at drivers/gpu/drm/vkms/vkms_gem.c:37  
vkms_gem_free_object+0x92/0xb0 drivers/gpu/drm/vkms/vkms_gem.c:37
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9040 Comm: syz-executor028 Not tainted 5.4.0-rc2-next-20191011  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x35 kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:vkms_gem_free_object+0x92/0xb0 drivers/gpu/drm/vkms/vkms_gem.c:37
Code: 44 68 7f fd 49 8d bc 24 f8 01 00 00 e8 c7 8d 64 fd 4c 89 e7 e8 3f 39  
ae ff 4c 89 e7 e8 f7 9a ba fd 41 5c 5d c3 e8 1e 68 7f fd <0f> 0b eb a2 e8  
15 68 7f fd 0f 0b eb c8 e8 2c e7 ba fd eb b6 e8 25
RSP: 0018:ffff8880971df9e8 EFLAGS: 00010293
RAX: ffff8880989c2200 RBX: ffffffff894e5000 RCX: ffffffff83a1eda6
RDX: 0000000000000000 RSI: ffffffff83f3ab02 RDI: ffff8880a8c4fa78
RBP: ffff8880971df9f0 R08: ffff8880989c2200 R09: ffffed1012e3bf36
R10: ffffed1012e3bf35 R11: 0000000000000003 R12: ffff8880a8c4f800
R13: ffff8880a3ab8000 R14: ffffffff83f3aa70 R15: ffff8880a3ab8020
  drm_gem_object_free+0x100/0x220 drivers/gpu/drm/drm_gem.c:983
  kref_put include/linux/kref.h:65 [inline]
  drm_gem_object_put_unlocked drivers/gpu/drm/drm_gem.c:1017 [inline]
  drm_gem_object_put_unlocked+0x127/0x170 drivers/gpu/drm/drm_gem.c:1002
  drm_gem_object_handle_put_unlocked+0x1ad/0x2d0  
drivers/gpu/drm/drm_gem.c:239
  drm_gem_object_release_handle+0x102/0x1c0 drivers/gpu/drm/drm_gem.c:261
  idr_for_each+0x138/0x250 lib/idr.c:208
  drm_gem_release+0x27/0x40 drivers/gpu/drm/drm_gem.c:939
  drm_file_free.part.0+0x7f4/0xc00 drivers/gpu/drm/drm_file.c:244
  drm_file_free drivers/gpu/drm/drm_file.c:213 [inline]
  drm_close_helper drivers/gpu/drm/drm_file.c:271 [inline]
  drm_release+0x286/0x3f0 drivers/gpu/drm/drm_file.c:443
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x904/0x2e60 kernel/exit.c:817
  do_group_exit+0x135/0x360 kernel/exit.c:921
  __do_sys_exit_group kernel/exit.c:932 [inline]
  __se_sys_exit_group kernel/exit.c:930 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:930
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x442bb8
Code: Bad RIP value.
RSP: 002b:00007ffd8fdc0b98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000442bb8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004c24c8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 00000000004002e0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d41a0 R14: 0000000000000000 R15: 0000000000000000
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
