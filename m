Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0B1C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777E621995
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfFQHqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:46:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:49699 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:46:05 -0400
Received: by mail-io1-f69.google.com with SMTP id x24so11232110ioh.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 00:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TRwP9iBnWIcCZj4VxVwQzGg8mKKux61Ksuz73VA06GU=;
        b=n12lyMgdcUyYk3kT/21acPwZghcgpoxIcyd6nU1uxeLz0roIeRfcEMYKjSwOf9zkyR
         pGhcYnV254AgE5eaDD48/xCamfrBhdLooW8WyRsdjJHZtKPO/Yy5T7Z1t1frzl8I86ev
         My11ojoyYJXuGhGqgybB27D3gOf1/x1rNvvoCa1aJNenybKpDOFuGDq6gEZ07NVWQDx2
         Ojno2rw2YIrY6kt9/gZomhJS34Y+2Z0JzBUCIuRZXEr2KdfHY1OFkL2+cS4leIOTFSBC
         7t9DIaWOLTQs1tADAxjA0db3IhQM5PP3gl7uOz4teh5VwIWfFT2SHyCwHhgGJ3fwzVGY
         nzBA==
X-Gm-Message-State: APjAAAUeWSHmXjwu51n2MzpYJoV+hJlpPXV04f5LgU7lZgztGcau6Usx
        IIj5ewZmMD8qaqxEeTs1mDv0ry+imTm5eh01g2auBLHLpmc2
X-Google-Smtp-Source: APXvYqy2wU5BPCaBvuETRe+d1zv8l1FuIXnavXvLXwjEVz9HnpkWjib53e2BlUB2jIZ1V13PTJg3zIpfexyycoOXMBJZIlbXV7rb
MIME-Version: 1.0
X-Received: by 2002:a6b:7b01:: with SMTP id l1mr19538142iop.60.1560757565063;
 Mon, 17 Jun 2019 00:46:05 -0700 (PDT)
Date:   Mon, 17 Jun 2019 00:46:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f07fe058b803013@google.com>
Subject: general protection fault in rb_next (3)
From:   syzbot <syzbot+ab4c44191771d56c4eda@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0011572c Merge branch 'for-5.2-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147fbc56a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
dashboard link: https://syzkaller.appspot.com/bug?extid=ab4c44191771d56c4eda
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c17076a00000

The bug was bisected to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c090eaa00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16c090eaa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c090eaa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ab4c44191771d56c4eda@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8856 Comm: syz-executor.2 Not tainted 5.2.0-rc4+ #32
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rb_next+0xd7/0x140 lib/rbtree.c:529
Code: 49 89 dc 4c 89 eb 48 83 e3 fc 48 89 d8 75 c8 48 83 c4 08 5b 41 5c 41  
5d 41 5e 5d c3 48 89 d0 48 8d 78 10 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 75  
1a 48 8b 50 10 48 85 d2 75 e3 48 83 c4 08 5b 41 5c
RSP: 0018:ffff8880ae809d70 EFLAGS: 00010007
RAX: 26f1e8c689c389ff RBX: dffffc0000000000 RCX: ffffffff87185c81
RDX: 04de3d18d1387141 RSI: ffffffff87185d10 RDI: 26f1e8c689c38a0f
RBP: ffff8880ae809d98 R08: ffff88808a51a440 R09: ffffed1015d06be0
R10: ffffed1015d06bdf R11: ffff8880ae835efb R12: ffff8880ae8275c0
R13: ffff8880ae827861 R14: dffffc0000000000 R15: ffff8880ae826d00
FS:  0000555555728940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000a8dc78 CR3: 00000000992f7000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  timerqueue_del+0xd8/0x150 lib/timerqueue.c:70
  __remove_hrtimer+0xa8/0x1c0 kernel/time/hrtimer.c:975
  __run_hrtimer kernel/time/hrtimer.c:1371 [inline]
  __hrtimer_run_queues+0x2a8/0xdd0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
  smp_apic_timer_interrupt+0x111/0x550 arch/x86/kernel/apic/apic.c:1066
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
  </IRQ>
Modules linked in:

======================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
