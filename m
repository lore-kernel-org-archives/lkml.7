Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D877C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1AA2238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfGXTSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:18:13 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34971 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfGXTSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:18:09 -0400
Received: by mail-io1-f71.google.com with SMTP id w17so52134902iom.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JMjY9rUKBLdwOww6e46VyjrsGm+Dx3PkAqmrEVYhQvE=;
        b=MhK5VnPM7GRjsUN+33aIcH1DgHCyqi25ECHNeq2d1ra27Hc8r6E6Qklww1W2xIN44x
         5jD3/dNSh4clKyYCpALF0OT6s3ff0hEZvpSzXj/zztlh7mqYvcygg4WC7q0+i+3lLRWo
         w3j+9tOVtuw3TmEB+zhgzy8wZhLNi2yxBQstIG1UdG01RrDEyg7Pig29Mx1uC2zJ+WPQ
         Nsavm5MesMiA1+m26oQL5Tta3Kttoh48F34YvI+G5gheZlu8JjYFHwgfeXr8ZFlTDqts
         CodKEElXbV8i2pDelOqxcyuHxLH8Yqi0VmtBFUB7knn3aVnlsfcMnRFzNo8mp51cD1QQ
         PImQ==
X-Gm-Message-State: APjAAAXBU12WxSeW56HA3udkQvegigywH3CHEZgT+r7hgKYASQy4hQYz
        f+fD19SP6EQugCOmSGhb4RxKO+g1DDATRvHn/RpJIN8MmIdd
X-Google-Smtp-Source: APXvYqxjpSmy0hArvCBeLUImAFXrlGzZ8F6BaI2tBMFjQKQjqcZ0MGTX2yRCoxl2IuhNOdxdmqW8uKt7NZ6WOMzA/zdv0n7z7YYH
MIME-Version: 1.0
X-Received: by 2002:a5e:8f42:: with SMTP id x2mr75224371iop.35.1563995888361;
 Wed, 24 Jul 2019 12:18:08 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:18:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b2aad058e722bf3@google.com>
Subject: INFO: rcu detected stall in do_swap_page
From:   syzbot <syzbot+2a89b1fb6539ff150c16@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10502af4600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c8985c08e1f9727
dashboard link: https://syzkaller.appspot.com/bug?extid=2a89b1fb6539ff150c16
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1456f9d0600000

The bug was bisected to:

commit 575088f60021e69a9ee8292ddc33b3196c53c239
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri Jan 18 08:32:26 2019 +0000

     Merge tag 'fixes-for-v5.0-rc2' of  
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-linus

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100d107c600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=120d107c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=140d107c600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2a89b1fb6539ff150c16@syzkaller.appspotmail.com
Fixes: 575088f60021 ("Merge tag 'fixes-for-v5.0-rc2' of  
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-linus")

rcu: INFO: rcu_sched self-detected stall on CPU
rcu: 	0-...!: (10499 ticks this GP) idle=d4e/1/0x4000000000000002  
softirq=47134/47134 fqs=4
	(t=10500 jiffies g=91609 q=40)
rcu: rcu_sched kthread starved for 10492 jiffies! g91609 f0x0  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_sched       R  running task    29144    10      2 0x80004000
Call Trace:
  context_switch /kernel/sched/core.c:3254 [inline]
  __schedule+0x772/0x1530 /kernel/sched/core.c:3880
  schedule+0xa5/0x260 /kernel/sched/core.c:3944
  schedule_timeout+0x44e/0xbc0 /kernel/time/timer.c:1807
  rcu_gp_fqs_loop /kernel/rcu/tree.c:1611 [inline]
  rcu_gp_kthread+0x835/0x1320 /kernel/rcu/tree.c:1768
  kthread+0x361/0x430 /kernel/kthread.c:255
  ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
NMI backtrace for cpu 0
CPU: 0 PID: 28151 Comm: syz-executor.0 Not tainted 5.2.0+ #71
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack /lib/dump_stack.c:77 [inline]
  dump_stack+0x16f/0x1f0 /lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x70/0xb2 /lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x22d/0x25c /lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 /arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace /./include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x183/0x1cf /kernel/rcu/tree_stall.h:254
  print_cpu_stall /kernel/rcu/tree_stall.h:455 [inline]
  check_cpu_stall /kernel/rcu/tree_stall.h:529 [inline]
  rcu_pending /kernel/rcu/tree.c:2736 [inline]
  rcu_sched_clock_irq.cold+0x491/0x8c0 /kernel/rcu/tree.c:2183
  update_process_times+0x32/0x80 /kernel/time/timer.c:1639
  tick_sched_handle+0xa2/0x190 /kernel/time/tick-sched.c:167
  tick_sched_timer+0x47/0x130 /kernel/time/tick-sched.c:1296
  __run_hrtimer /kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x364/0xd90 /kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x2ea/0x730 /kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt /arch/x86/kernel/apic/apic.c:1068 [inline]
  smp_apic_timer_interrupt+0x10b/0x550 /arch/x86/kernel/apic/apic.c:1093
  apic_timer_interrupt+0xf/0x20 /arch/x86/entry/entry_64.S:828
  </IRQ>
RIP: 0010:__pte_needs_invert /./arch/x86/include/asm/pgtable-invert.h:18  
[inline]
RIP: 0010:protnone_mask /./arch/x86/include/asm/pgtable-invert.h:24 [inline]
RIP: 0010:pmd_pfn /./arch/x86/include/asm/pgtable.h:221 [inline]
RIP: 0010:pte_lockptr /./include/linux/mm.h:1937 [inline]
RIP: 0010:migration_entry_wait+0x1d0/0x260 /mm/migrate.c:341
Code: 00 00 00 80 88 ff ff 4d 21 e5 48 01 f3 4a 8d 34 2b e8 74 f8 ff ff 48  
83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 90 69 c5 ff <48> 89 de 31 ff  
83 e6 01 48 89 75 c8 e8 1f 6b c5 ff 48 8b 75 c8 48
RSP: 0018:ffff88809724f808 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff88808b58e700 RBX: 000000008fc6d067 RCX: ffffffff81abebab
RDX: 0000000000000000 RSI: ffffffff81abecf0 RDI: 0000000000000007
RBP: ffff88809724f840 R08: ffff88808b58e700 R09: fffffbfff13491e8
R10: fffffbfff13491e7 R11: ffffffff89a48f3b R12: ffff88808bb1e800
R13: 000000008fc6d067 R14: ffffffff88d2e4b8 R15: ffff888094d1c0c0
  do_swap_page+0x12d9/0x23e0 /mm/memory.c:2743
  handle_pte_fault /mm/memory.c:3844 [inline]
  __handle_mm_fault+0x19ae/0x3ce0 /mm/memory.c:3964
  handle_mm_fault+0x3bb/0xa90 /mm/memory.c:4001
  do_user_addr_fault /arch/x86/mm/fault.c:1444 [inline]
  __do_page_fault+0x536/0xdd0 /arch/x86/mm/fault.c:1509
  do_page_fault+0x38/0x536 /arch/x86/mm/fault.c:1533
  page_fault+0x39/0x40 /arch/x86/entry/entry_64.S:1200
RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20  
/arch/x86/lib/copy_user_64.S:205
Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f  
80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f  
1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 89 d1 f3 a4
RSP: 0018:ffff88809724fc70 EFLAGS: 00010206
RAX: 0000000000000001 RBX: 0000000000001000 RCX: 0000000000001000
RDX: 0000000000001000 RSI: 0000000020024080 RDI: ffff8880a7b6d000
RBP: ffff88809724fca8 R08: ffffed1014f6dc00 R09: 0000000000000000
R10: ffffed1014f6dbff R11: ffff8880a7b6dfff R12: 0000000020024080
R13: 0000000020025080 R14: ffff8880a7b6d000 R15: 00007ffffffff000
  copy_from_user /./include/linux/uaccess.h:144 [inline]
  mem_rw.isra.0+0x253/0x4f0 /fs/proc/base.c:841
  mem_write+0x55/0x70 /fs/proc/base.c:880
  __vfs_write+0x8a/0x110 /fs/read_write.c:494
  vfs_write+0x268/0x5d0 /fs/read_write.c:558
  ksys_write+0x14f/0x290 /fs/read_write.c:611
  __do_sys_write /fs/read_write.c:623 [inline]
  __se_sys_write /fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 /fs/read_write.c:620
  do_syscall_64+0xfd/0x6a0 /arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459819
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb3f618bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459819
RDX: 000000002000008f RSI: 0000000020000080 RDI: 0000000000000005
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb3f618c6d4
R13: 00000000004c9492 R14: 00000000004e0660 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
