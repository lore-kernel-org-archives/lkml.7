Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A87C32792
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A24120862
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfJEE0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 00:26:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56374 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEE0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 00:26:07 -0400
Received: by mail-io1-f69.google.com with SMTP id a22so16590248ioq.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 21:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JicPHQHtTSbBshE8bs+6VPJwLYumWiA15ciS+bvP4iE=;
        b=c80FhJPWq8GkP2TO3Q9iNfMAG5scAKuGu+tk3PrNmBsLXChCaXDKeqso7RytekQkFe
         ctNX/mZ39uvAFlHVKDvSDAb6/BiaIEuDid2mhzDs/zO1NIzOcsygCTT0VJ9iG29X52fL
         4G6N7Citm3e/VsF0yqS32BLq5IOjDMi1Ph/9dLuaOTsU4i52gT9rpaIgVTwO4RAx5t4a
         AqsKTNPKZ4v+2jTrIqGHST/1CpXOVmIyoXy86e1UEStY6B6u+oh1Ps1IhgKxjY1UzRKs
         bRArxK4zo3aTGjyuH0e1vdycoGneKBV7n0Mb+7kr8F/VY6sUAUHIPL0Ydou9WKoZshoj
         Fxdg==
X-Gm-Message-State: APjAAAWs5eA5SBTDsN/s/erPuMuxwJ3l0UYlZveN7Mcx9L3n8xdczqvV
        1EH4ngUKPpGUGZkGf6lFvOuip2vXAPkF3WWRujMGHgsiU2N1
X-Google-Smtp-Source: APXvYqwFL3hynsbxDl5d1CSWTQeQYw1RNZmAEsoxPfIuOumah/1EdLfRbDT+3MzFnyFOUdW6ndKA3mcR4QiLd7xS/5B9ySAX/POb
MIME-Version: 1.0
X-Received: by 2002:a92:d282:: with SMTP id p2mr19669488ilp.238.1570249566270;
 Fri, 04 Oct 2019 21:26:06 -0700 (PDT)
Date:   Fri, 04 Oct 2019 21:26:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b403005942237bf@google.com>
Subject: KCSAN: data-race in taskstats_exit / taskstats_exit
From:   syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>
To:     bsingharora@gmail.com, elver@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b4bd9343 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=125329db600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
dashboard link: https://syzkaller.appspot.com/bug?extid=c5d03165a1bd1dead0c1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in taskstats_exit / taskstats_exit

write to 0xffff8881157bbe10 of 8 bytes by task 7951 on cpu 0:
  taskstats_tgid_alloc kernel/taskstats.c:567 [inline]
  taskstats_exit+0x6b7/0x717 kernel/taskstats.c:596
  do_exit+0x2c2/0x18e0 kernel/exit.c:864
  do_group_exit+0xb4/0x1c0 kernel/exit.c:983
  get_signal+0x2a2/0x1320 kernel/signal.c:2734
  do_signal+0x3b/0xc00 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x250/0x2c0 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x2d7/0x2f0 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff8881157bbe10 of 8 bytes by task 7949 on cpu 1:
  taskstats_tgid_alloc kernel/taskstats.c:559 [inline]
  taskstats_exit+0xb2/0x717 kernel/taskstats.c:596
  do_exit+0x2c2/0x18e0 kernel/exit.c:864
  do_group_exit+0xb4/0x1c0 kernel/exit.c:983
  __do_sys_exit_group kernel/exit.c:994 [inline]
  __se_sys_exit_group kernel/exit.c:992 [inline]
  __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:992
  do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 7949 Comm: syz-executor.3 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7949 Comm: syz-executor.3 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xf5/0x159 lib/dump_stack.c:113
  panic+0x209/0x639 kernel/panic.c:219
  end_report kernel/kcsan/report.c:135 [inline]
  kcsan_report.cold+0x57/0xeb kernel/kcsan/report.c:283
  __kcsan_setup_watchpoint+0x342/0x500 kernel/kcsan/core.c:456
  __tsan_read8 kernel/kcsan/kcsan.c:31 [inline]
  __tsan_read8+0x2c/0x30 kernel/kcsan/kcsan.c:31
  taskstats_tgid_alloc kernel/taskstats.c:559 [inline]
  taskstats_exit+0xb2/0x717 kernel/taskstats.c:596
  do_exit+0x2c2/0x18e0 kernel/exit.c:864
  do_group_exit+0xb4/0x1c0 kernel/exit.c:983
  __do_sys_exit_group kernel/exit.c:994 [inline]
  __se_sys_exit_group kernel/exit.c:992 [inline]
  __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:992
  do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x459a59
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc4ccf3408 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 0000000000459a59
RDX: 0000000000413741 RSI: fffffffffffffff7 RDI: 0000000000000000
RBP: 0000000000000000 R08: 000000007f8e4506 R09: 00007ffc4ccf3460
R10: ffffffff81007108 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc4ccf3460 R14: 0000000000000000 R15: 00007ffc4ccf3470
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
