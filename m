Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DABECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EC020659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfJUKeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:34:09 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42723 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfJUKeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:34:08 -0400
Received: by mail-il1-f199.google.com with SMTP id y4so283359ilg.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xeJD1J3sxHF8HzH+tELeff0MBc2EfUs2+L1MDM5KLIQ=;
        b=YwPk/15HPCFSS1sdmTArXHZRECAi8M46ySGjfLYRUkQwYT/7yBkI9hDpV1vNQbx/75
         cX0YzOaWqHPeqsEUazk8Te8/Ys/PQD1ZXFnvMgeeA+JminrR0bZ/ifqedai3BahcJNWW
         pKBS7h1Kz6cjQeBaPEK7QI5V5UWP8Itqo++joV/vPpdb+A1P/EcoebQLwK//cCS/l/rr
         8rtM2yWvZbX4HdKK1cQncVoNPvUZwo9ThWC//s1VQ/0662QLnnSZ1MmN+8XanDCotcjL
         Mivz25COj4QHfks6pXKAd1mNDRwhIRC6ZDrE+BmGwF4qvU7cy6OmYBG5PKoKhl64/PL8
         DDRA==
X-Gm-Message-State: APjAAAWzauzDBK3Sg+rWE7JqaAsRU3uQVThsKB8QcZLHZapwn88SmKHK
        hsJ3gi9nXRo96zOoophZRNm2AUeGxlOAnCSwricuucpmGjm4
X-Google-Smtp-Source: APXvYqw18cRS9npf3vfFpl5ymyIwbq6jsOFDvL55896DsR/nO1Rv6hMXuKbUUA+nfR6swdzrdTb2Yeu/1ToP7k0y5nfXKYiugIms
MIME-Version: 1.0
X-Received: by 2002:a05:6638:c:: with SMTP id z12mr2749314jao.105.1571654047830;
 Mon, 21 Oct 2019 03:34:07 -0700 (PDT)
Date:   Mon, 21 Oct 2019 03:34:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b1e8005956939f1@google.com>
Subject: KCSAN: data-race in exit_signals / prepare_signal
From:   syzbot <syzbot+492a4acccd8fc75ddfd0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, elver@google.com,
        guro@fb.com, linux-kernel@vger.kernel.org, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d724f94f x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=13eab79f600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
dashboard link: https://syzkaller.appspot.com/bug?extid=492a4acccd8fc75ddfd0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+492a4acccd8fc75ddfd0@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in exit_signals / prepare_signal

read to 0xffff888103566064 of 4 bytes by interrupt on cpu 0:
  sig_task_ignored kernel/signal.c:94 [inline]
  sig_ignored kernel/signal.c:119 [inline]
  prepare_signal+0x1f5/0x790 kernel/signal.c:956
  send_sigqueue+0xc1/0x4b0 kernel/signal.c:1859
  posix_timer_event kernel/time/posix-timers.c:328 [inline]
  posix_timer_fn+0x10d/0x230 kernel/time/posix-timers.c:354
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x288/0x600 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x22a/0x480 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
  smp_apic_timer_interrupt+0xdc/0x280 arch/x86/kernel/apic/apic.c:1135
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  arch_local_irq_enable arch/x86/include/asm/paravirt.h:778 [inline]
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
  _raw_spin_unlock_irq+0x4e/0x80 kernel/locking/spinlock.c:199
  spin_unlock_irq include/linux/spinlock.h:388 [inline]
  get_signal+0x1f4/0x1320 kernel/signal.c:2707
  do_signal+0x3b/0xc00 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x250/0x2c0 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x2d7/0x2f0 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff888103566064 of 4 bytes by task 7604 on cpu 1:
  exit_signals+0x13b/0x490 kernel/signal.c:2822
  do_exit+0x1af/0x18e0 kernel/exit.c:825
  do_group_exit+0xb4/0x1c0 kernel/exit.c:983
  __do_sys_exit_group kernel/exit.c:994 [inline]
  __se_sys_exit_group kernel/exit.c:992 [inline]
  __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:992
  do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 7604 Comm: syz-executor.4 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
