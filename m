Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A15C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8967F20644
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfH0SsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:48:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37861 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbfH0SsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:48:09 -0400
Received: by mail-io1-f70.google.com with SMTP id m7so353020ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sQ8MNdMNmLlB3NIanyL0OpPLIbX3QOpCLANyJoIpL54=;
        b=Bwr4cx3va2/glXJNmy7bK1JOSIUAV4gK30FZ7UiT+OO748IZVZ84g6sGBKblzyulXj
         1rUbI2cE0f1h4UwE1p0znG/soEmOOl24CgXVSZjKlCcqQjYtlgIo6IY7GNhkN+rZW7Hi
         EF/GYKOULETJ/G2ijnX59w3Cc64j9m13KUxfPce6P7Tr1Kj+et1fvrHgX26lLTrCAjbw
         vWVExksSCerIZn01q+DcYqjsBlxDKLg8rZFgE9Jn3HsXMhXeHVaWm0A6k99V4kjze1T/
         316l+J59jpg4C0duVLu+lk7uXhOPSeZDLqKhLL2+0/0wyK8Xvz7B9vEj7Xvk4omWmq04
         HuqQ==
X-Gm-Message-State: APjAAAUHuyiBf7C0HmM+dBkP40ZXY3aEupikfMq+JmDkotBoIzUcZCdv
        7jcRmrKSTKsR+n7Kz1mmnwRNXRFxzu8ai5Ovg6t8X18pXV6U
X-Google-Smtp-Source: APXvYqwRLYYYUtIrkcr8H1T3H/EhrEfG8b4d/BakqKtif5mnwoh76GPAv0p7y+dW8tByNrRZ/GiS6ABZalfopNg5+21+TArgUXnU
MIME-Version: 1.0
X-Received: by 2002:a5d:9750:: with SMTP id c16mr5252841ioo.260.1566931687980;
 Tue, 27 Aug 2019 11:48:07 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:48:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a64c4a05911db6fe@google.com>
Subject: WARNING in posix_cpu_timer_del
From:   syzbot <syzbot+654f89dafed9092dac4d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ed858b88 Add linux-next specific files for 20190826
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=130c2eca600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee8373cd9733e305
dashboard link: https://syzkaller.appspot.com/bug?extid=654f89dafed9092dac4d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133cbeb6600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e931ca600000

Bisection is inconclusive: the first bad commit could be any of:

fc0a4de8 posix-cpu-timers: Provide array based access to expiry cache
4cc12137 posix-cpu-timers: Move expiry cache into struct posix_cputimers
6f440f88 posix-cpu-timers: Simplify timer queueing
2fcd363a sched: Move struct task_cputime to types.h
95c0e29a posix-cpu-timers: Simplify set_process_cpu_timer()
05c191a0 posix-cpu-timers: Create a container struct
ca2258d8 posix-cpu-timers: Switch check_*_timers() to array cache
080b3114 posix-cpu-timers: Remove the odd field rename defines
4663b7f4 posix-cpu-timers: Move prof/virt_ticks into caller
c663b713 posix-cpu-timers: Sample task times once in expiry check
c96d6e59 posix-cpu-timers: Provide array based sample functions
957d8bca posix-cpu-timers: Get rid of pointer indirection
e762ac92 posix-cpu-timers: Make expiry checks array based
8dc06959 posix-cpu-timers: Remove cputime_expires
9459311b posix-cpu-timers: Simplify sample functions
0102a96d posix-cpu-timers: Restructure expiry array
9ebc1ad3 posix-cpu-timers: Remove pointless return value check
8c768bb8 posix-cpu-timers: Use clock ID in posix_cpu_timer_rearm()
8e8c6459 posix-cpu-timers: Switch thread group sampling to array
13aa8bba posix-cpu-timers: Use clock ID in posix_cpu_timer_get()
d9f868a0 posix-cpu-timers: Respect INFINITY for hard RTTIME limit
9336cd13 rlimit: Rewrite non-sensical RLIMIT_CPU comment
e70ad8c0 posix-cpu-timers: Use clock ID in posix_cpu_timer_set()
5786d249 posix-cpu-timers: Get rid of zero checks
b141b8de posix-cpu-timers: Consolidate thread group sample code
8f8fb8af posix-cpu-timers: Rename thread_group_cputimer() and make it static
ac1089cb posix-cpu-timers: Consolidate timer expiry further
c895a99d posix-cpu-timers: Sample directly in timer check
c9401dda posix-cpu-timers: Get rid of 64bit divisions
ae5366ec itimers: Use quick sample function
f0610ad1 posix-cpu-timers: Remove pointless comparisons
6add2f23 posix-cpu-timers: Provide quick sample function for itimer
f4a2ed1b posix-cpu-timers: Deduplicate rlimit handling
cc1f6a2e posix-cpu-timers: Move state tracking to struct posix_cputimers
dd73866d posix-cpu-timers: Use common permission check in  
posix_cpu_timer_create()
4d9b4beb posix-cpu-timers: Use common permission check in  
posix_cpu_clock_get()
ce709abd posix-cpu-timers: Utilize timerqueue for storage
5b67bc20 posix-cpu-timers: Provide task validation functions
d1543e48 posix-cpu-timers: Fix build on !CONFIG_POSIX_TIMERS
02c12a14 Merge branch 'WIP.timers/core'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1490f4de600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+654f89dafed9092dac4d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8887 at kernel/time/posix-cpu-timers.c:401  
posix_cpu_timer_del+0x2f0/0x3b0 kernel/time/posix-cpu-timers.c:401
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8887 Comm: syz-executor029 Not tainted 5.3.0-rc6-next-20190826  
#73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:220
  __warn.cold+0x2f/0x3c kernel/panic.c:581
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:posix_cpu_timer_del+0x2f0/0x3b0 kernel/time/posix-cpu-timers.c:401
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85  
b5 00 00 00 48 83 bb c8 00 00 00 00 74 16 e8 10 58 0d 00 <0f> 0b e9 87 fe  
ff ff e8 44 41 48 00 e9 dd fd ff ff e8 fa 57 0d 00
RSP: 0018:ffff888093297a30 EFLAGS: 00010093
RAX: ffff8880939a20c0 RBX: ffff8880a8968450 RCX: 1ffff1101273452a
RDX: 0000000000000000 RSI: ffffffff8164d5c0 RDI: ffff8880a8968518
RBP: ffff888093297ac0 R08: 0000000000000002 R09: ffff8880939a2958
R10: fffffbfff138b0f8 R11: ffffffff89c587c7 R12: ffff88809157a100
R13: 1ffff11012652f47 R14: ffff888093297a98 R15: ffff8880a89684a8
  timer_delete_hook kernel/time/posix-timers.c:978 [inline]
  itimer_delete kernel/time/posix-timers.c:1021 [inline]
  exit_itimers+0xdb/0x2e0 kernel/time/posix-timers.c:1041
  do_exit+0x1980/0x2e60 kernel/exit.c:853
  do_group_exit+0x135/0x360 kernel/exit.c:983
  get_signal+0x47c/0x2500 kernel/signal.c:2734
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4466b9
Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffbc0b8368 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000000 RBX: 0000000000010bca RCX: 00000000004466b9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc2c
RBP: 00000000006dbc2c R08: 000000037ffffa00 R09: 000000037ffffa00
R10: 00007fffbc0b8380 R11: 0000000000000246 R12: 00000000006dbc20
R13: 0000000000000000 R14: 000000000000002d R15: 20c49ba5e353f7cf
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
