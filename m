Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238FCC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF2524678
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfLEWAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:00:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:49243 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfLEWAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:00:09 -0500
Received: by mail-il1-f197.google.com with SMTP id t13so3653059ilk.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 14:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rqKNJoogyBIXbrrIQOudJFLVAY8klXYSSzbXypPx8rY=;
        b=NzGUzy9+SsspEshQr5Du/iarTGEWu2Zs1VIFiVlSQZFhEmb8e6jTZZqOuoM+Jm7AS4
         CBhJv3xHTfBjkiHNKeXk3lo4kVrDRuDf7j0slyHBU+Z5k4IYxwbjp7EPDO6bhl4+tFRB
         9ei4U7S7VrzmREf4yj2Z3634W+d5h9ydw7GWksCVcCBvmZZ/ZIn4cFjguqcSrSGqj/jF
         hv+fRmvAA5VUWUiXmxq2zew7Ws1iFalqVEa1YHaUZVxFgLkDQjNcoMpNRa4KS3j4XXfD
         bf02XPdDdmeqU+K42dkCnWzwmW+9V4MuL+XYhBCqbx0U+Idg8jRATr9jzx+0BXb/iwRx
         r1Dw==
X-Gm-Message-State: APjAAAU6W4av8N11VYxWmekjo3TAiy/xR7NJ6melXy8QBP/r2D/qIc2E
        16Qm8k/qUnTxxIGWptP7m5vTlaWQxdjz0wFnw2FxgD0hs7Qt
X-Google-Smtp-Source: APXvYqyE9PkibPNobZ7dU9QSFTt3qJLMtiwgZJ4QcmOmhpqP52xB/eawHA1fzjRV1ZBCCn8gaguYA+bPELElLCHZBVlGtxY+TqEj
MIME-Version: 1.0
X-Received: by 2002:a05:6638:404:: with SMTP id q4mr4105868jap.115.1575583208802;
 Thu, 05 Dec 2019 14:00:08 -0800 (PST)
Date:   Thu, 05 Dec 2019 14:00:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007992840598fc0d2b@google.com>
Subject: WARNING: refcount bug in put_watch
From:   syzbot <syzbot+f4c16a389966647e346e@syzkaller.appspotmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    282ffdf3 Add linux-next specific files for 20191205
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17897aeae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29372c0243b4b980
dashboard link: https://syzkaller.appspot.com/bug?extid=f4c16a389966647e346e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131aa42ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168dcb7ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f4c16a389966647e346e@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 9318 at lib/refcount.c:28  
refcount_warn_saturate+0x1dc/0x1f0 lib/refcount.c:28
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9318 Comm: syz-executor327 Not tainted  
5.4.0-next-20191205-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x3e kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:refcount_warn_saturate+0x1dc/0x1f0 lib/refcount.c:28
Code: e9 d8 fe ff ff 48 89 df e8 01 52 23 fe e9 85 fe ff ff e8 b7 ae e5 fd  
48 c7 c7 e0 b7 6f 88 c6 05 5d d5 ec 06 01 e8 b3 5a b6 fd <0f> 0b e9 ac fe  
ff ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 55 48
RSP: 0018:ffffc90001e77bf0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815e5896 RDI: fffff520003cef70
RBP: ffffc90001e77c00 R08: ffff8880a7154640 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
R13: ffff8880950c5e58 R14: ffff8880950c5e00 R15: ffffffff8a0218c0
  refcount_sub_and_test include/linux/refcount.h:261 [inline]
  refcount_dec_and_test include/linux/refcount.h:281 [inline]
  kref_put include/linux/kref.h:64 [inline]
  put_watch+0xa2/0xb0 drivers/misc/watch_queue.c:633
  watch_queue_clear drivers/misc/watch_queue.c:826 [inline]
  watch_queue_release+0x34b/0xc40 drivers/misc/watch_queue.c:842
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x8e7/0x2ef0 kernel/exit.c:797
  do_group_exit+0x135/0x360 kernel/exit.c:895
  __do_sys_exit_group kernel/exit.c:906 [inline]
  __se_sys_exit_group kernel/exit.c:904 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:904
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43edb8
Code: Bad RIP value.
RSP: 002b:00007ffc74c09078 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043edb8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004be5c8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000
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
