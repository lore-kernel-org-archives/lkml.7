Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2D4CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FA0205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504003AbfJXSIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:08:02 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:48393 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389845AbfJXSIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:08:01 -0400
Received: by mail-il1-f199.google.com with SMTP id d15so16369862iln.15
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NiUb+1/9zk9RM8zpiK6RfXG2arGnHThZU4Kmn/hrAhY=;
        b=enIjT7m6Wo7qxID8ozx7U7fVqrhhl92B1B9TDTGv9u2AhTR15dn01KMF/RmGPt7yHZ
         +4oJ7phObGCCjmNw2fKuiY/OXT58/OW/RCzHjYbCJfMBAWwdeAmK2IZieCsSC4jaYdpD
         kKqcM4lznRpXkaAWKyE086NPHg12EQ8C7cjJ4U0qgsq+HxI5gVx4RmDku8Tnb+cUna9f
         FsJjYpBREgFnx/P4Y9vNbQTQyX6RIbwqjKveKj+41Yenvz+rjwN6AprI0JAxwbwiq5aD
         eTg4RR4mpKbcYNd+ApVcAZbyM8Gg8xWbE3wrA24n5kPU3z5Ux4SZ7WjOX2bYPDoEddjO
         oFRw==
X-Gm-Message-State: APjAAAXme89V8MsfL2w1bC6cIwiarw5uKj1MnvftcZXLNh16yG63e8CQ
        vHI9HTZyJygDIsKrR/g0fEQMzp6gzRRMLB45HBaiPNHa3d1G
X-Google-Smtp-Source: APXvYqx+Qtxk4eDXUdnjwlmQ53oVUvxEET2CDlMxPoMRJBlr9LT+0ObgTxWDy+n5D0e85JoyqzS/m28Oc1UlMLNMkiZ9rz+AhGX5
MIME-Version: 1.0
X-Received: by 2002:a92:ccd0:: with SMTP id u16mr1041605ilq.227.1571940480765;
 Thu, 24 Oct 2019 11:08:00 -0700 (PDT)
Date:   Thu, 24 Oct 2019 11:08:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1910241336130.1318-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6d5ed0595abe964@google.com>
Subject: Re: divide error in dummy_timer
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

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
divide error in dummy_timer

divide error: 0000 [#1] SMP KASAN
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:transfer drivers/usb/gadget/udc/dummy_hcd.c:1426 [inline]
RIP: 0010:dummy_timer+0xad5/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1950
Code: 0f 84 f5 fd ff ff e8 2a 54 ab fd 89 de 44 89 e7 e8 10 55 ab fd 41 39  
dc 0f 82 b0 08 00 00 e8 12 54 ab fd 44 89 e0 31 d2 31 ff <f7> f3 89 d6 89  
94 24 c0 00 00 00 e8 6b 55 ab fd 8b 94 24 c0 00 00
RSP: 0018:ffff8881db309b20 EFLAGS: 00010046
RAX: 0000000000000040 RBX: 0000000000000000 RCX: ffffffff8392c490
RDX: 0000000000000000 RSI: ffffffff8392c49e RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8881da213000 R09: ffffed103b661353
R10: ffffed103b661352 R11: 0000000000000003 R12: 0000000000000040
R13: ffff8881d4712a00 R14: dffffc0000000000 R15: ffff8881d20a2200
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb31aad7000 CR3: 00000001d4b0e000 CR4: 00000000001406e0
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
RSP: 0018:ffff8881da22fdc8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: ffff8881da213000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8881da21384c
RBP: ffffed103b442600 R08: ffff8881da213000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x3b6/0x500 kernel/sched/idle.c:263
  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:355
  start_secondary+0x27d/0x330 arch/x86/kernel/smpboot.c:264
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
Modules linked in:
---[ end trace e6cab2429e956502 ]---
RIP: 0010:transfer drivers/usb/gadget/udc/dummy_hcd.c:1426 [inline]
RIP: 0010:dummy_timer+0xad5/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1950
Code: 0f 84 f5 fd ff ff e8 2a 54 ab fd 89 de 44 89 e7 e8 10 55 ab fd 41 39  
dc 0f 82 b0 08 00 00 e8 12 54 ab fd 44 89 e0 31 d2 31 ff <f7> f3 89 d6 89  
94 24 c0 00 00 00 e8 6b 55 ab fd 8b 94 24 c0 00 00
RSP: 0018:ffff8881db309b20 EFLAGS: 00010046
RAX: 0000000000000040 RBX: 0000000000000000 RCX: ffffffff8392c490
RDX: 0000000000000000 RSI: ffffffff8392c49e RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8881da213000 R09: ffffed103b661353
R10: ffffed103b661352 R11: 0000000000000003 R12: 0000000000000040
R13: ffff8881d4712a00 R14: dffffc0000000000 R15: ffff8881d20a2200
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb31aad7000 CR3: 00000001d4b0e000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17b3e44ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fe29bc39eff9627
dashboard link: https://syzkaller.appspot.com/bug?extid=8ab8bf161038a8768553
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ea0a97600000

