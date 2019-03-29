Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C84B206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfC2KeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:34:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47667 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2KeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:34:06 -0400
Received: by mail-io1-f71.google.com with SMTP id b199so1371670iof.14
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Z6oC/WxrFtbB6YFtTIJoLt2C+ADeq4twD1hSY5ZZz48=;
        b=OmVovt2jRVTbnjnOneGYdxGeFBrhvRwYfwUXeBHq1fyZCK4luFt1BeC8h70u8GaVgj
         GmaVzMIEaZZ+P/MIkpKV12IULkIWR4XVVh2VLD+nvAG03hvJ3my+vs6y4L0SnQ73QiqE
         c9xCuNpLEchT36XodjI+fH/xwiAPxtwLSiXT8cDTRObRCAP1IDrOBx3mcB3lCsY2wAV8
         oed7cIy13oU4luYpXGF4Swmg1uV/ZdxzhrROw+pa5sFLPqTCzhDLj5S0i5brMY1G3TfU
         JFEyLDEE43NwgLP1EwLKE77IBcafPaIUxZmzV5XrsvVO3ROL5FlwNeo4IGuM/4UCVTK7
         sLFA==
X-Gm-Message-State: APjAAAU8I8lx1qmtQLRk3YXimOv/aO+U11mkJzG4pX0BnMWwxz+Cyayn
        knyXWhOe2so6jvMnjk777CmSo3iUYuVONGqtzXGnDB3FmzY0
X-Google-Smtp-Source: APXvYqzK6fg9OmoJunipB710FDpIkWs4sAs9//wXvsSG1Lifg265aQ6JOZWefFReOBaANgKw0ZkclwCaiT4/tBfOnwE/lJifadMx
MIME-Version: 1.0
X-Received: by 2002:a24:e4a:: with SMTP id 71mr1527198ite.0.1553855645449;
 Fri, 29 Mar 2019 03:34:05 -0700 (PDT)
Date:   Fri, 29 Mar 2019 03:34:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c791f30585393527@google.com>
Subject: possible deadlock in userfaultfd_read (2)
From:   syzbot <syzbot+fab6de82892b6b9c6191@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1a9df9e2 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ded663200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
dashboard link: https://syzkaller.appspot.com/bug?extid=fab6de82892b6b9c6191
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fab6de82892b6b9c6191@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.1.0-rc2+ #40 Not tainted
-----------------------------------------------------
syz-executor.3/1446 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
000000004c6b904f (&ctx->fault_pending_wqh){+.+.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
000000004c6b904f (&ctx->fault_pending_wqh){+.+.}, at: userfaultfd_ctx_read  
fs/userfaultfd.c:1040 [inline]
000000004c6b904f (&ctx->fault_pending_wqh){+.+.}, at:  
userfaultfd_read+0x540/0x1940 fs/userfaultfd.c:1198

and this task is already holding:
00000000b0b711bd (&ctx->fd_wqh){....}, at: spin_lock_irq  
include/linux/spinlock.h:354 [inline]
00000000b0b711bd (&ctx->fd_wqh){....}, at: userfaultfd_ctx_read  
fs/userfaultfd.c:1036 [inline]
00000000b0b711bd (&ctx->fd_wqh){....}, at: userfaultfd_read+0x27a/0x1940  
fs/userfaultfd.c:1198
which would create a new lock dependency:
  (&ctx->fd_wqh){....} -> (&ctx->fault_pending_wqh){+.+.}

but this new dependency connects a SOFTIRQ-irq-safe lock:
  (&(&ctx->ctx_lock)->rlock){..-.}

... which became SOFTIRQ-irq-safe at:
   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
   _raw_spin_lock_irq+0x60/0x80 kernel/locking/spinlock.c:160
   spin_lock_irq include/linux/spinlock.h:354 [inline]
   free_ioctx_users+0x2d/0x4a0 fs/aio.c:621
   percpu_ref_put_many include/linux/percpu-refcount.h:285 [inline]
   percpu_ref_put include/linux/percpu-refcount.h:301 [inline]
   percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123 [inline]
   percpu_ref_switch_to_atomic_rcu+0x3e7/0x520 lib/percpu-refcount.c:158
   __rcu_reclaim kernel/rcu/rcu.h:227 [inline]
   rcu_do_batch kernel/rcu/tree.c:2475 [inline]
   invoke_rcu_callbacks kernel/rcu/tree.c:2788 [inline]
   rcu_core+0x928/0x1390 kernel/rcu/tree.c:2769
   __do_softirq+0x266/0x95a kernel/softirq.c:293
   invoke_softirq kernel/softirq.c:374 [inline]
   irq_exit+0x180/0x1d0 kernel/softirq.c:414
   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
   smp_apic_timer_interrupt+0x14a/0x570 arch/x86/kernel/apic/apic.c:1062
   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
   __sanitizer_cov_trace_const_cmp1+0x5/0x20 kernel/kcov.c:175
   tlb_flush_mmu_free+0x4e/0x120 mm/mmu_gather.c:74
   zap_pte_range mm/memory.c:1158 [inline]
   zap_pmd_range mm/memory.c:1193 [inline]
   zap_pud_range mm/memory.c:1222 [inline]
   zap_p4d_range mm/memory.c:1243 [inline]
   unmap_page_range+0x180e/0x2330 mm/memory.c:1264
   unmap_single_vma+0x19d/0x300 mm/memory.c:1309
   unmap_vmas+0x115/0x250 mm/memory.c:1340
   exit_mmap+0x2c2/0x530 mm/mmap.c:3138
   __mmput kernel/fork.c:1046 [inline]
   mmput+0x15f/0x4c0 kernel/fork.c:1067
   exit_mm kernel/exit.c:546 [inline]
   do_exit+0x816/0x2fa0 kernel/exit.c:863
   do_group_exit+0x135/0x370 kernel/exit.c:980
   get_signal+0x399/0x1d50 kernel/signal.c:2577
   do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
   exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
   prepare_exit_to_usermode+0x279/0x2e0 arch/x86/entry/common.c:197
   retint_user+0x8/0x18

to a SOFTIRQ-irq-unsafe lock:
  (&ctx->fault_pending_wqh){+.+.}

... which became SOFTIRQ-irq-unsafe at:
...
   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
   spin_lock include/linux/spinlock.h:329 [inline]
   handle_userfault+0x58e/0x18c0 fs/userfaultfd.c:461
   do_anonymous_page mm/memory.c:2941 [inline]
   handle_pte_fault mm/memory.c:3807 [inline]
   __handle_mm_fault+0x361d/0x3ec0 mm/memory.c:3933
   handle_mm_fault+0x43f/0xb30 mm/memory.c:3970
   do_user_addr_fault arch/x86/mm/fault.c:1475 [inline]
   __do_page_fault+0x5ef/0xda0 arch/x86/mm/fault.c:1541
   do_page_fault+0x71/0x581 arch/x86/mm/fault.c:1572
   page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
   __get_user_4+0x21/0x30 arch/x86/lib/getuser.S:76
   sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
   __sys_setsockopt+0x180/0x280 net/socket.c:2046
   __do_sys_setsockopt net/socket.c:2057 [inline]
   __se_sys_setsockopt net/socket.c:2054 [inline]
   __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2054
   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &(&ctx->ctx_lock)->rlock --> &ctx->fd_wqh --> &ctx->fault_pending_wqh

  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&ctx->fault_pending_wqh);
                                local_irq_disable();
                                lock(&(&ctx->ctx_lock)->rlock);
                                lock(&ctx->fd_wqh);
   <Interrupt>
     lock(&(&ctx->ctx_lock)->rlock);

  *** DEADLOCK ***

1 lock held by syz-executor.3/1446:
  #0: 00000000b0b711bd (&ctx->fd_wqh){....}, at: spin_lock_irq  
include/linux/spinlock.h:354 [inline]
  #0: 00000000b0b711bd (&ctx->fd_wqh){....}, at: userfaultfd_ctx_read  
fs/userfaultfd.c:1036 [inline]
  #0: 00000000b0b711bd (&ctx->fd_wqh){....}, at:  
userfaultfd_read+0x27a/0x1940 fs/userfaultfd.c:1198

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
  -> (&(&ctx->ctx_lock)->rlock){..-.} {
     IN-SOFTIRQ-W at:
                       lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
                       __raw_spin_lock_irq  
include/linux/spinlock_api_smp.h:128 [inline]
                       _raw_spin_lock_irq+0x60/0x80  
kernel/locking/spinlock.c:160
                       spin_lock_irq include/linux/spinlock.h:354 [inline]
                       free_ioctx_users+0x2d/0x4a0 fs/aio.c:621
                       percpu_ref_put_many  
include/linux/percpu-refcount.h:285 [inline]
                       percpu_ref_put include/linux/percpu-refcount.h:301  
[inline]
                       percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123  
[inline]
                       percpu_ref_switch_to_atomic_rcu+0x3e7/0x520  
lib/percpu-refcount.c:158
                       __rcu_reclaim kernel/rcu/rcu.h:227 [inline]
                       rcu_do_batch kernel/rcu/tree.c:2475 [inline]
                       invoke_rcu_callbacks kernel/rcu/tree.c:2788 [inline]
                       rcu_core+0x928/0x1390 kernel/rcu/tree.c:2769
                       __do_softirq+0x266/0x95a kernel/softirq.c:293
                       invoke_softirq kernel/softirq.c:374 [inline]
                       irq_exit+0x180/0x1d0 kernel/softirq.c:414
                       exiting_irq arch/x86/include/asm/apic.h:536 [inline]
                       smp_apic_timer_interrupt+0x14a/0x570  
arch/x86/kernel/apic/apic.c:1062
                       apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:807
                       __sanitizer_cov_trace_const_cmp1+0x5/0x20  
kernel/kcov.c:175
                       tlb_flush_mmu_free+0x4e/0x120 mm/mmu_gather.c:74
                       zap_pte_range mm/memory.c:1158 [inline]
                       zap_pmd_range mm/memory.c:1193 [inline]
                       zap_pud_range mm/memory.c:1222 [inline]
                       zap_p4d_range mm/memory.c:1243 [inline]
                       unmap_page_range+0x180e/0x2330 mm/memory.c:1264
                       unmap_single_vma+0x19d/0x300 mm/memory.c:1309
                       unmap_vmas+0x115/0x250 mm/memory.c:1340
                       exit_mmap+0x2c2/0x530 mm/mmap.c:3138
                       __mmput kernel/fork.c:1046 [inline]
                       mmput+0x15f/0x4c0 kernel/fork.c:1067
                       exit_mm kernel/exit.c:546 [inline]
                       do_exit+0x816/0x2fa0 kernel/exit.c:863
                       do_group_exit+0x135/0x370 kernel/exit.c:980
                       get_signal+0x399/0x1d50 kernel/signal.c:2577
                       do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
                       exit_to_usermode_loop+0x244/0x2c0  
arch/x86/entry/common.c:162
                       prepare_exit_to_usermode+0x279/0x2e0  
arch/x86/entry/common.c:197
                       retint_user+0x8/0x18
     INITIAL USE at:
                      lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
                      __raw_spin_lock_irq  
include/linux/spinlock_api_smp.h:128 [inline]
                      _raw_spin_lock_irq+0x60/0x80  
kernel/locking/spinlock.c:160
                      spin_lock_irq include/linux/spinlock.h:354 [inline]
                      free_ioctx_users+0x2d/0x4a0 fs/aio.c:621
                      percpu_ref_put_many  
include/linux/percpu-refcount.h:285 [inline]
                      percpu_ref_put include/linux/percpu-refcount.h:301  
[inline]
                      percpu_ref_call_confirm_rcu lib/percpu-refcount.c:123  
[inline]
                      percpu_ref_switch_to_atomic_rcu+0x3e7/0x520  
lib/percpu-refcount.c:158
                      __rcu_reclaim kernel/rcu/rcu.h:227 [inline]
                      rcu_do_batch kernel/rcu/tree.c:2475 [inline]
                      invoke_rcu_callbacks kernel/rcu/tree.c:2788 [inline]
                      rcu_core+0x928/0x1390 kernel/rcu/tree.c:2769
                      __do_softirq+0x266/0x95a kernel/softirq.c:293
                      invoke_softirq kernel/softirq.c:374 [inline]
                      irq_exit+0x180/0x1d0 kernel/softirq.c:414
                      exiting_irq arch/x86/include/asm/apic.h:536 [inline]
                      smp_apic_timer_interrupt+0x14a/0x570  
arch/x86/kernel/apic/apic.c:1062
                      apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:807
                      __sanitizer_cov_trace_const_cmp1+0x5/0x20  
kernel/kcov.c:175
                      tlb_flush_mmu_free+0x4e/0x120 mm/mmu_gather.c:74
                      zap_pte_range mm/memory.c:1158 [inline]
                      zap_pmd_range mm/memory.c:1193 [inline]
                      zap_pud_range mm/memory.c:1222 [inline]
                      zap_p4d_range mm/memory.c:1243 [inline]
                      unmap_page_range+0x180e/0x2330 mm/memory.c:1264
                      unmap_single_vma+0x19d/0x300 mm/memory.c:1309
                      unmap_vmas+0x115/0x250 mm/memory.c:1340
                      exit_mmap+0x2c2/0x530 mm/mmap.c:3138
                      __mmput kernel/fork.c:1046 [inline]
                      mmput+0x15f/0x4c0 kernel/fork.c:1067
                      exit_mm kernel/exit.c:546 [inline]
                      do_exit+0x816/0x2fa0 kernel/exit.c:863
                      do_group_exit+0x135/0x370 kernel/exit.c:980
                      get_signal+0x399/0x1d50 kernel/signal.c:2577
                      do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
                      exit_to_usermode_loop+0x244/0x2c0  
arch/x86/entry/common.c:162
                      prepare_exit_to_usermode+0x279/0x2e0  
arch/x86/entry/common.c:197
                      retint_user+0x8/0x18
   }
   ... key      at: [<ffffffff8a5e8ea0>] __key.52644+0x0/0x40
   ... acquired at:
    lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
    spin_lock include/linux/spinlock.h:329 [inline]
    aio_poll fs/aio.c:1762 [inline]
    __io_submit_one fs/aio.c:1868 [inline]
    io_submit_one+0xe35/0x1cf0 fs/aio.c:1901
    __do_sys_io_submit fs/aio.c:1946 [inline]
    __se_sys_io_submit fs/aio.c:1916 [inline]
    __x64_sys_io_submit+0x1bd/0x580 fs/aio.c:1916
    do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> (&ctx->fd_wqh){....} {
    INITIAL USE at:
                    lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
                    __raw_spin_lock_irqsave  
include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x95/0xcd  
kernel/locking/spinlock.c:152
                    __wake_up_common_lock+0xc7/0x190 kernel/sched/wait.c:120
                    __wake_up+0xe/0x10 kernel/sched/wait.c:145
                    handle_userfault+0x925/0x18c0 fs/userfaultfd.c:487
                    do_anonymous_page mm/memory.c:2941 [inline]
                    handle_pte_fault mm/memory.c:3807 [inline]
                    __handle_mm_fault+0x361d/0x3ec0 mm/memory.c:3933
                    handle_mm_fault+0x43f/0xb30 mm/memory.c:3970
                    do_user_addr_fault arch/x86/mm/fault.c:1475 [inline]
                    __do_page_fault+0x5ef/0xda0 arch/x86/mm/fault.c:1541
                    do_page_fault+0x71/0x581 arch/x86/mm/fault.c:1572
                    page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
                    __get_user_4+0x21/0x30 arch/x86/lib/getuser.S:76
                    sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
                    __sys_setsockopt+0x180/0x280 net/socket.c:2046
                    __do_sys_setsockopt net/socket.c:2057 [inline]
                    __se_sys_setsockopt net/socket.c:2054 [inline]
                    __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2054
                    do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
  }
  ... key      at: [<ffffffff8a5e8c20>] __key.45453+0x0/0x40
  ... acquired at:
    check_prevs_add kernel/locking/lockdep.c:2333 [inline]
    validate_chain kernel/locking/lockdep.c:2714 [inline]
    __lock_acquire+0x239c/0x3fb0 kernel/locking/lockdep.c:3701
    lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
    spin_lock include/linux/spinlock.h:329 [inline]
    userfaultfd_ctx_read fs/userfaultfd.c:1040 [inline]
    userfaultfd_read+0x540/0x1940 fs/userfaultfd.c:1198
    do_loop_readv_writev fs/read_write.c:700 [inline]
    do_loop_readv_writev fs/read_write.c:687 [inline]
    do_iter_read+0x4a9/0x660 fs/read_write.c:921
    vfs_readv+0xf0/0x160 fs/read_write.c:983
    do_readv+0xf6/0x290 fs/read_write.c:1016
    __do_sys_readv fs/read_write.c:1103 [inline]
    __se_sys_readv fs/read_write.c:1100 [inline]
    __x64_sys_readv+0x75/0xb0 fs/read_write.c:1100
    do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe


the dependencies between the lock to be acquired
  and SOFTIRQ-irq-unsafe lock:
-> (&ctx->fault_pending_wqh){+.+.} {
    HARDIRQ-ON-W at:
                     lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                     _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
                     spin_lock include/linux/spinlock.h:329 [inline]
                     handle_userfault+0x58e/0x18c0 fs/userfaultfd.c:461
                     do_anonymous_page mm/memory.c:2941 [inline]
                     handle_pte_fault mm/memory.c:3807 [inline]
                     __handle_mm_fault+0x361d/0x3ec0 mm/memory.c:3933
                     handle_mm_fault+0x43f/0xb30 mm/memory.c:3970
                     do_user_addr_fault arch/x86/mm/fault.c:1475 [inline]
                     __do_page_fault+0x5ef/0xda0 arch/x86/mm/fault.c:1541
                     do_page_fault+0x71/0x581 arch/x86/mm/fault.c:1572
                     page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
                     __get_user_4+0x21/0x30 arch/x86/lib/getuser.S:76
                     sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
                     __sys_setsockopt+0x180/0x280 net/socket.c:2046
                     __do_sys_setsockopt net/socket.c:2057 [inline]
                     __se_sys_setsockopt net/socket.c:2054 [inline]
                     __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2054
                     do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    SOFTIRQ-ON-W at:
                     lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                     _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
                     spin_lock include/linux/spinlock.h:329 [inline]
                     handle_userfault+0x58e/0x18c0 fs/userfaultfd.c:461
                     do_anonymous_page mm/memory.c:2941 [inline]
                     handle_pte_fault mm/memory.c:3807 [inline]
                     __handle_mm_fault+0x361d/0x3ec0 mm/memory.c:3933
                     handle_mm_fault+0x43f/0xb30 mm/memory.c:3970
                     do_user_addr_fault arch/x86/mm/fault.c:1475 [inline]
                     __do_page_fault+0x5ef/0xda0 arch/x86/mm/fault.c:1541
                     do_page_fault+0x71/0x581 arch/x86/mm/fault.c:1572
                     page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
                     __get_user_4+0x21/0x30 arch/x86/lib/getuser.S:76
                     sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
                     __sys_setsockopt+0x180/0x280 net/socket.c:2046
                     __do_sys_setsockopt net/socket.c:2057 [inline]
                     __se_sys_setsockopt net/socket.c:2054 [inline]
                     __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2054
                     do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    INITIAL USE at:
                    lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
                    spin_lock include/linux/spinlock.h:329 [inline]
                    handle_userfault+0x58e/0x18c0 fs/userfaultfd.c:461
                    do_anonymous_page mm/memory.c:2941 [inline]
                    handle_pte_fault mm/memory.c:3807 [inline]
                    __handle_mm_fault+0x361d/0x3ec0 mm/memory.c:3933
                    handle_mm_fault+0x43f/0xb30 mm/memory.c:3970
                    do_user_addr_fault arch/x86/mm/fault.c:1475 [inline]
                    __do_page_fault+0x5ef/0xda0 arch/x86/mm/fault.c:1541
                    do_page_fault+0x71/0x581 arch/x86/mm/fault.c:1572
                    page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
                    __get_user_4+0x21/0x30 arch/x86/lib/getuser.S:76
                    sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
                    __sys_setsockopt+0x180/0x280 net/socket.c:2046
                    __do_sys_setsockopt net/socket.c:2057 [inline]
                    __se_sys_setsockopt net/socket.c:2054 [inline]
                    __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2054
                    do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
  }
  ... key      at: [<ffffffff8a5e8ce0>] __key.45450+0x0/0x40
  ... acquired at:
    check_prevs_add kernel/locking/lockdep.c:2333 [inline]
    validate_chain kernel/locking/lockdep.c:2714 [inline]
    __lock_acquire+0x239c/0x3fb0 kernel/locking/lockdep.c:3701
    lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
    spin_lock include/linux/spinlock.h:329 [inline]
    userfaultfd_ctx_read fs/userfaultfd.c:1040 [inline]
    userfaultfd_read+0x540/0x1940 fs/userfaultfd.c:1198
    do_loop_readv_writev fs/read_write.c:700 [inline]
    do_loop_readv_writev fs/read_write.c:687 [inline]
    do_iter_read+0x4a9/0x660 fs/read_write.c:921
    vfs_readv+0xf0/0x160 fs/read_write.c:983
    do_readv+0xf6/0x290 fs/read_write.c:1016
    __do_sys_readv fs/read_write.c:1103 [inline]
    __se_sys_readv fs/read_write.c:1100 [inline]
    __x64_sys_readv+0x75/0xb0 fs/read_write.c:1100
    do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe


stack backtrace:
CPU: 0 PID: 1446 Comm: syz-executor.3 Not tainted 5.1.0-rc2+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_bad_irq_dependency kernel/locking/lockdep.c:1920 [inline]
  check_usage.cold+0x60f/0x940 kernel/locking/lockdep.c:1952
  check_irq_usage kernel/locking/lockdep.c:1997 [inline]
  check_prev_add_irq kernel/locking/lockdep_states.h:8 [inline]
  check_prev_add.constprop.0+0x2e3/0x23c0 kernel/locking/lockdep.c:2225
  check_prevs_add kernel/locking/lockdep.c:2333 [inline]
  validate_chain kernel/locking/lockdep.c:2714 [inline]
  __lock_acquire+0x239c/0x3fb0 kernel/locking/lockdep.c:3701
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  userfaultfd_ctx_read fs/userfaultfd.c:1040 [inline]
  userfaultfd_read+0x540/0x1940 fs/userfaultfd.c:1198
  do_loop_readv_writev fs/read_write.c:700 [inline]
  do_loop_readv_writev fs/read_write.c:687 [inline]
  do_iter_read+0x4a9/0x660 fs/read_write.c:921
  vfs_readv+0xf0/0x160 fs/read_write.c:983
  do_readv+0xf6/0x290 fs/read_write.c:1016
  __do_sys_readv fs/read_write.c:1103 [inline]
  __se_sys_readv fs/read_write.c:1100 [inline]
  __x64_sys_readv+0x75/0xb0 fs/read_write.c:1100
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458209
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f08b0ce8c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458209
RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f08b0ce96d4
R13: 00000000004c4cfc R14: 00000000004d8ce0 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
