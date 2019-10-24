Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC03CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF5C2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393858AbfJXN6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:58:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49433 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfJXN6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:58:09 -0400
Received: by mail-il1-f197.google.com with SMTP id c2so9834356ilj.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XMhtoQE6n6s1s4RJwmBzEVfMR+PkZiZDpFcK7EHHzt8=;
        b=go4Mj9ZNQCLSe2OOV/PP7urxAb1PQ9GuBBPY0+N4ImNVmLeSqZVGOXE+zuZrfTfzvW
         ZorN2E1HpLTShtVam+7OE8fhvherC8fV1PusY/LjkpwDVs75yGM4bW2wcFdTDCz2yBSI
         h48ARVF6uDUxkiBrO01ysoxKkWhCkWg74I1Gkp5du7qmm9TbQpUIsUrfC4WAedxY5vqC
         bnCRvHq1qKSyPWPOxaWgyFZT/4JffLDiYU2kVczj8jmc9Vfjw8QRvM5NE6z8CEbAW2F0
         7z4evcjtqwKwSNh09qCoG/+q1LqV7pjg/qgNXYHbngqgOp30LvhxhCDjo3Zu9QTwjdQd
         le3Q==
X-Gm-Message-State: APjAAAWGFIBgncFNghyJ+FPiMyaVXNVYwrciTd05J8I9G4LgGk0ILQ02
        Mzq0OPvjBMURZM2Ybz7Oh6lyDbSf94Xg8r5hZ6Mz4rq4w+D6
X-Google-Smtp-Source: APXvYqxMCvqWm48JN5auyWtzJpi9Im1KYzF9piWZosE0fB77rjohVZKPqgWI171m3yAZSnApvi50KO8QMbVo0DfQFXAnpqHus1sg
MIME-Version: 1.0
X-Received: by 2002:a92:ce12:: with SMTP id b18mr31312783ilo.130.1571925487720;
 Thu, 24 Oct 2019 06:58:07 -0700 (PDT)
Date:   Thu, 24 Oct 2019 06:58:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f221d0595a86c33@google.com>
Subject: divide error in dummy_timer
From:   syzbot <syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com>
To:     Jacky.Cao@sony.com, andreyknvl@google.com, balbi@kernel.org,
        chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=11e2fda7600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fe29bc39eff9627
dashboard link: https://syzkaller.appspot.com/bug?extid=8ab8bf161038a8768553
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f664e4e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14674000e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com

divide error: 0000 [#1] SMP KASAN
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:transfer drivers/usb/gadget/udc/dummy_hcd.c:1426 [inline]
RIP: 0010:dummy_timer+0xad5/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1950
Code: 0f 84 f5 fd ff ff e8 8a 55 ab fd 89 de 44 89 e7 e8 70 56 ab fd 41 39  
dc 0f 82 b0 08 00 00 e8 72 55 ab fd 44 89 e0 31 d2 31 ff <f7> f3 89 d6 89  
94 24 c0 00 00 00 e8 cb 56 ab fd 8b 94 24 c0 00 00
RSP: 0018:ffff8881db209b20 EFLAGS: 00010046
RAX: 0000000000000040 RBX: 0000000000000000 RCX: ffffffff8392c330
RDX: 0000000000000000 RSI: ffffffff8392c33e RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff86c2b200 R09: ffffed103b641353
R10: ffffed103b641352 R11: 0000000000000003 R12: 0000000000000040
R13: ffff8881d58c0000 R14: dffffc0000000000 R15: ffff8881d78d5a00
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb771a61000 CR3: 00000001d2295000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  call_timer_fn+0x179/0x650 kernel/time/timer.c:1404
  expire_timers kernel/time/timer.c:1449 [inline]
  __run_timers kernel/time/timer.c:1773 [inline]
  __run_timers kernel/time/timer.c:1740 [inline]
  run_timer_softirq+0x5e3/0x1490 kernel/time/timer.c:1786
  __do_softirq+0x221/0x912 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x178/0x1a0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x12f/0x500 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  </IRQ>
RIP: 0010:default_idle+0x28/0x2e0 arch/x86/kernel/process.c:581
Code: 90 90 41 56 41 55 65 44 8b 2d f4 00 92 7a 41 54 55 53 0f 1f 44 00 00  
e8 c6 b2 d3 fb e9 07 00 00 00 0f 00 2d ea a5 52 00 fb f4 <65> 44 8b 2d d0  
00 92 7a 0f 1f 44 00 00 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffffff86c07da8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: ffffffff86c2b200 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffff86c2ba4c
RBP: fffffbfff0d85640 R08: ffffffff86c2b200 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x3b6/0x500 kernel/sched/idle.c:263
  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:355
  start_kernel+0x82a/0x864 init/main.c:784
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
Modules linked in:
---[ end trace 02e2d9c7c53d85a5 ]---
RIP: 0010:transfer drivers/usb/gadget/udc/dummy_hcd.c:1426 [inline]
RIP: 0010:dummy_timer+0xad5/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1950
Code: 0f 84 f5 fd ff ff e8 8a 55 ab fd 89 de 44 89 e7 e8 70 56 ab fd 41 39  
dc 0f 82 b0 08 00 00 e8 72 55 ab fd 44 89 e0 31 d2 31 ff <f7> f3 89 d6 89  
94 24 c0 00 00 00 e8 cb 56 ab fd 8b 94 24 c0 00 00
RSP: 0018:ffff8881db209b20 EFLAGS: 00010046
RAX: 0000000000000040 RBX: 0000000000000000 RCX: ffffffff8392c330
RDX: 0000000000000000 RSI: ffffffff8392c33e RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff86c2b200 R09: ffffed103b641353
R10: ffffed103b641352 R11: 0000000000000003 R12: 0000000000000040
R13: ffff8881d58c0000 R14: dffffc0000000000 R15: ffff8881d78d5a00
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb771a61000 CR3: 00000001d2295000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
