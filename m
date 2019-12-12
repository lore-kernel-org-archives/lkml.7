Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A431C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15898214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfLLXdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:33:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:45844 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbfLLXdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:33:10 -0500
Received: by mail-io1-f71.google.com with SMTP id m18so421008ioj.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 15:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=az5DuF1alBK/2C/X8kBxQrX+6pJZmNF6wl9c7tpV3lo=;
        b=mE3YPi47mjO0UVgN1//xOD8+BxlDIRiJjiq9ArzYBND51eW/feKr0vtHjIZoWimDyp
         7QyBS2xz1iBxEie0vLKyZEyxUomCBFyqNZbdqn3Z0tlGh592rDq/64xsy7S4jtmNDOTz
         QNiky0JBoIdFPr5ziz6kaJpo7v+OhYa7J6TsCzNP2n5nzPY9Q03/R+5N9aRttpO+b/Ig
         fgbmNBPQ2i0pEuSF1MmfGDwaPamfZQqbfeI2PIWg8BI8C+5DSr5n3MlCFZb0ZHC7FCq+
         pk/hwvURI73l80CCkdEkAB/NsBD9EGQZ3QpqLTF2dyOxJy4vBLxkESMjePk17Q0LKBqh
         kgfg==
X-Gm-Message-State: APjAAAXwafnMaHqfUDQImsMtg3Wm7HupRQZJG/z5CAdbE4O8v3zEnyTi
        qFyLr7kDRKltSR2oO/gU2WjBBZribzj36HH6jxdci0Ro69hx
X-Google-Smtp-Source: APXvYqxGIhpUq2Ta2me1n35TUp99Om4bxMFVM6Z6vlAx3gNI2Gir2nRgvbWbgIQZNvn9/aduwA/ZHCQXiLujH6NoAjRsBqhCGjr6
MIME-Version: 1.0
X-Received: by 2002:a92:d610:: with SMTP id w16mr10414196ilm.283.1576193590003;
 Thu, 12 Dec 2019 15:33:10 -0800 (PST)
Date:   Thu, 12 Dec 2019 15:33:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000790ac05998a2ba3@google.com>
Subject: KCSAN: data-race in timer_clear_idle / trigger_dyntick_cpu.isra.0 (2)
From:   syzbot <syzbot+62407dedb3b93892c631@syzkaller.appspotmail.com>
To:     elver@google.com, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ef798c30 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=14e7ae61e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8077a73bd604a9d4
dashboard link: https://syzkaller.appspot.com/bug?extid=62407dedb3b93892c631
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+62407dedb3b93892c631@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in timer_clear_idle / trigger_dyntick_cpu.isra.0

read to 0xffff88812be1b6e4 of 1 bytes by interrupt on cpu 1:
  trigger_dyntick_cpu.isra.0+0x75/0x100 kernel/time/timer.c:577
  internal_add_timer kernel/time/timer.c:596 [inline]
  add_timer_on+0x186/0x2d0 kernel/time/timer.c:1174
  clocksource_watchdog+0x63f/0x760 kernel/time/clocksource.c:297
  call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
  expire_timers kernel/time/timer.c:1449 [inline]
  __run_timers kernel/time/timer.c:1773 [inline]
  __run_timers kernel/time/timer.c:1740 [inline]
  run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
  __do_softirq+0x115/0x33f kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0xbb/0xe0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60
  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:571
  default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x1af/0x280 kernel/sched/idle.c:263
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
  start_secondary+0x168/0x1b0 arch/x86/kernel/smpboot.c:264
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

write to 0xffff88812be1b6e4 of 1 bytes by task 0 on cpu 0:
  timer_clear_idle+0x42/0x50 kernel/time/timer.c:1675
  tick_nohz_next_event+0x15d/0x370 kernel/time/tick-sched.c:708
  __tick_nohz_idle_stop_tick kernel/time/tick-sched.c:943 [inline]
  tick_nohz_idle_stop_tick+0x3c2/0x670 kernel/time/tick-sched.c:973
  cpuidle_idle_call kernel/sched/idle.c:151 [inline]
  do_idle+0x1a5/0x280 kernel/sched/idle.c:263
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
  rest_init+0xec/0xf6 init/main.c:452
  arch_call_rest_init+0x17/0x37
  start_kernel+0x838/0x85e init/main.c:786
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
  x86_64_start_kernel+0x72/0x76 arch/x86/kernel/head64.c:471
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
