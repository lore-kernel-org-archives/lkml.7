Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF65C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CEF2075D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgAHGEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:04:11 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:36285 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAHGEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:04:10 -0500
Received: by mail-il1-f198.google.com with SMTP id t2so1389384ilp.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 22:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2pWA+wPXYkJszwSh6HspUbsQ9812iXeuZ2zT4wrLZA8=;
        b=VCUnGqh6TV/U/xi3YlPzYUvyN5f5OLKOnxsaG37k4AeOXf9RwSnxGdS/Fq7dvcFRxu
         EDwD1MVHDdQuvlz9Uro/3Htw3E3PqUJjHhiEZkUmCzTUXLTrXoeCT/ymZEJW2mDs/ya5
         b1ncuIQoB7HmVjmY0LHoVH72PzqPN8XA/UTt93RJYJxlcBnoDDe/QljVpuyCJjiEFaOM
         rb3SCi5v2XYtadWXAL9C9YtB14TTvDomTbsItBjj8GthxVM6c1AhKJoPDH0fyWN5UDty
         mjo3XkgZpz1liiW4G3dNJrtQJiysozSYj1hDDoWlMAxitzN/SYZvYLfQWatMrZOcIQ+k
         RKag==
X-Gm-Message-State: APjAAAX3BmM77fMBs0XI6mNlAwwgC71+1pFcAN2KS/dHep+iFq6HnQIh
        90Wh6aRx2O5cEpXfVdo11xyRTiAYH4Yf+hAYzwkQ1Zd9SxOF
X-Google-Smtp-Source: APXvYqwBm30A3CVynfJeLrP8ULcBigjZYixqfHNq60BtLZr890LAer43Koczc5tazE/YzwcNmzVSMI6l7z6LFXwQlKOW2uaspaUz
MIME-Version: 1.0
X-Received: by 2002:a5d:97c3:: with SMTP id k3mr2171364ios.38.1578463449742;
 Tue, 07 Jan 2020 22:04:09 -0800 (PST)
Date:   Tue, 07 Jan 2020 22:04:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003683a5059b9aa99c@google.com>
Subject: INFO: rcu detected stall in pipe_release (2)
From:   syzbot <syzbot+1e8dd3a6665d477d5835@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian@brauner.io,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ae608821 Merge tag 'trace-v5.5-rc5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a30876e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db5ff86cbb23b415
dashboard link: https://syzkaller.appspot.com/bug?extid=1e8dd3a6665d477d5835
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1e8dd3a6665d477d5835@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 1, t=10502 jiffies, g=7173, q=85)
rcu: All QSes seen, last rcu_preempt kthread activity 10503  
(4294955373-4294944870), jiffies_till_next_fqs=1, root ->qsmask 0x0
blkid           R  running task    28312  8628   8580 0x8000400a
Call Trace:
  <IRQ>
  sched_show_task+0x40f/0x560 kernel/sched/core.c:5954
  print_other_cpu_stall kernel/rcu/tree_stall.h:410 [inline]
  check_cpu_stall kernel/rcu/tree_stall.h:538 [inline]
  rcu_pending kernel/rcu/tree.c:2827 [inline]
  rcu_sched_clock_irq+0x1861/0x1ad0 kernel/rcu/tree.c:2271
  update_process_times+0x12d/0x180 kernel/time/timer.c:1726
  tick_sched_handle kernel/time/tick-sched.c:167 [inline]
  tick_sched_timer+0x263/0x420 kernel/time/tick-sched.c:1310
  __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
  __hrtimer_run_queues+0x403/0x840 kernel/time/hrtimer.c:1579
  hrtimer_interrupt+0x38c/0xda0 kernel/time/hrtimer.c:1641
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
  smp_apic_timer_interrupt+0x109/0x280 arch/x86/kernel/apic/apic.c:1135
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:get_current arch/x86/include/asm/current.h:15 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x4/0x50 kernel/kcov.c:186
Code: 84 00 00 00 00 00 55 48 89 e5 53 48 89 fb e8 13 00 00 00 48 8b 3d f4  
f4 ed 07 48 89 de e8 84 f4 3b 00 5b 5d c3 cc 48 8b 04 24 <65> 48 8b 0c 25  
c0 1d 02 00 65 8b 15 38 5f 8b 7e f7 c2 00 01 1f 00
RSP: 0018:ffffc900023079b8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffffffff814897d3 RBX: 0000000000000000 RCX: ffff88808c84a240
RDX: 0000000000000000 RSI: 00000000fffffffc RDI: ffffea000251a840
RBP: ffffc900023079e0 R08: dffffc0000000000 R09: fffffbfff12c962d
R10: fffffbfff12c962d R11: 0000000000000000 R12: dffffc0000000000
R13: dffffc0000000000 R14: 00000000fffffffc R15: ffff88808fb67538
  free_thread_stack+0x168/0x590 kernel/fork.c:280
  release_task_stack kernel/fork.c:440 [inline]
  put_task_stack+0xa3/0x130 kernel/fork.c:451
  finish_task_switch+0x3f1/0x550 kernel/sched/core.c:3256
  context_switch kernel/sched/core.c:3388 [inline]
  __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
  preempt_schedule_common kernel/sched/core.c:4236 [inline]
  preempt_schedule+0xdb/0x120 kernel/sched/core.c:4261
  ___preempt_schedule+0x16/0x18 arch/x86/entry/thunk_64.S:50
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
  _raw_spin_unlock_irqrestore+0xcc/0xe0 kernel/locking/spinlock.c:191
  spin_unlock_irqrestore include/linux/spinlock.h:393 [inline]
  __wake_up_common_lock kernel/sched/wait.c:125 [inline]
  __wake_up_sync_key+0xe2/0x150 kernel/sched/wait.c:190
  pipe_release+0x17b/0x330 fs/pipe.c:709
  __fput+0x2e4/0x740 fs/file_table.c:280
  ____fput+0x15/0x20 fs/file_table.c:313
  task_work_run+0x17e/0x1b0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x5f2/0x2000 kernel/exit.c:801
  do_group_exit+0x15c/0x2b0 kernel/exit.c:899
  __do_sys_exit_group+0x17/0x20 kernel/exit.c:910
  __se_sys_exit_group+0x14/0x20 kernel/exit.c:908
  __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:908
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f3a61a3a1e8
Code: Bad RIP value.
RSP: 002b:00007ffe3c81a5e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f3a61a3a1e8
RDX: 0000000000000002 RSI: 000000000000003c RDI: 0000000000000002
RBP: 00007f3a61d0f840 R08: 00000000000000e7 R09: ffffffffffffffa8
R10: 00007f3a61d15740 R11: 0000000000000246 R12: 00007f3a61d0f840
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
rcu: rcu_preempt kthread starved for 10537 jiffies! g7173 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29032    10      2 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x9a0/0xcc0 kernel/sched/core.c:4081
  schedule+0x181/0x210 kernel/sched/core.c:4155
  schedule_timeout+0x14f/0x240 kernel/time/timer.c:1895
  rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
  rcu_gp_kthread+0xed8/0x1770 kernel/rcu/tree.c:1821
  kthread+0x332/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
