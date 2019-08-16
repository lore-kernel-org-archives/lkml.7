Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F18C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF11206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfHPHHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:07:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38788 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPHHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:07:07 -0400
Received: by mail-io1-f70.google.com with SMTP id h4so2337434iol.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 00:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RLsaNDaib080CB7hNEcWG2I5On6yaq4yQNf4RUUNEUA=;
        b=D8tnru+ggyJLE6MEobPVpl6G89tYpLYXr24JtdP63QXiu/tcyqNS3xx0J+60J/Wu9E
         VElMWU+AZ7ecapcoEPkvMzMqVqaQnFn7UBiWKLq5vbq2sVE4KKsEZXwuxajinZ9zZex9
         Hae0ybPXrcn8aYtuzSaRLxok9MvLgP6Hj0nAk8B42h39zYCXrGNqd8ZuwVqaJ1I4RbIL
         ojaZYx1ZL+bIJyhu1uL+6cVsvLOQ8EYi0JInXjDtjsguhsxpHtfCkvB89/V0c2cM6KjD
         0r1BWPUpbSRI38a6Nw0cBJAWdWCO3oF9z8gbx6+zOhF4C8lbWPyXuzb2HwaVX3OnM7By
         KE+Q==
X-Gm-Message-State: APjAAAW6jsDnfG3uew7GOAmUR6TTimkqzt93RpmStE5QB2dSxwvvb8Qy
        jplqFHr8wM33rEJ0MEtWKc6t6FRZiHpKDd8CbKvQGsIKcI9N
X-Google-Smtp-Source: APXvYqzTUkGvvKTMsqae1p9S8lU13W8XO24w1UltLccg47cVLelhIMGXQlLhv1k+SaLGn2YTAbNd75wwlzjsQPgu4v7Ke/LWqW33
MIME-Version: 1.0
X-Received: by 2002:a5d:8b8a:: with SMTP id p10mr671036iol.218.1565939226240;
 Fri, 16 Aug 2019 00:07:06 -0700 (PDT)
Date:   Fri, 16 Aug 2019 00:07:06 -0700
In-Reply-To: <0000000000006a2474057a092bf7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051f150059036a328@google.com>
Subject: Re: possible deadlock in static_key_slow_dec
From:   syzbot <syzbot+b011e55d1b4c015100d2@syzkaller.appspotmail.com>
To:     ard.biesheuvel@linaro.org, bp@suse.de, bristot@redhat.com,
        jakub.kicinski@netronome.com, jbaron@akamai.com,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, simon.horman@netronome.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    17da61ae Add linux-next specific files for 20190814
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=158810ac600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4733704ca85aaa66
dashboard link: https://syzkaller.appspot.com/bug?extid=b011e55d1b4c015100d2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b5b496600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147935ee600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b011e55d1b4c015100d2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.3.0-rc4-next-20190814 #66 Not tainted
------------------------------------------------------
syz-executor590/9351 is trying to acquire lock:
ffffffff88f5eef0 (cpu_hotplug_lock.rw_sem){++++}, at: __static_key_slow_dec  
kernel/jump_label.c:254 [inline]
ffffffff88f5eef0 (cpu_hotplug_lock.rw_sem){++++}, at:  
static_key_slow_dec+0x54/0xa0 kernel/jump_label.c:270

but task is already holding lock:
ffff8880a96354d0 (&mm->mmap_sem#2){++++}, at: vm_mmap_pgoff+0x173/0x230  
mm/util.c:494

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&mm->mmap_sem#2){++++}:
        down_write+0x93/0x150 kernel/locking/rwsem.c:1534
        mpol_rebind_mm+0x25/0xd0 mm/mempolicy.c:382
        cpuset_attach+0x226/0x420 kernel/cgroup/cpuset.c:2204
        cgroup_migrate_execute+0xc56/0x1350 kernel/cgroup/cgroup.c:2524
        cgroup_migrate+0x14f/0x1f0 kernel/cgroup/cgroup.c:2780
        cgroup_attach_task+0x57f/0x860 kernel/cgroup/cgroup.c:2817
        __cgroup1_procs_write.constprop.0+0x321/0x400  
kernel/cgroup/cgroup-v1.c:522
        cgroup1_procs_write+0x2b/0x40 kernel/cgroup/cgroup-v1.c:535
        cgroup_file_write+0x241/0x790 kernel/cgroup/cgroup.c:3754
        kernfs_fop_write+0x2b8/0x480 fs/kernfs/file.c:315
        __vfs_write+0x8a/0x110 fs/read_write.c:494
        vfs_write+0x268/0x5d0 fs/read_write.c:558
        ksys_write+0x14f/0x290 fs/read_write.c:611
        __do_sys_write fs/read_write.c:623 [inline]
        __se_sys_write fs/read_write.c:620 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:620
        do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&cpuset_rwsem){++++}:
        percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
        cpuset_read_lock+0x3e/0x150 kernel/cgroup/cpuset.c:340
        __sched_setscheduler+0xca2/0x2110 kernel/sched/core.c:4718
        _sched_setscheduler+0x10a/0x1b0 kernel/sched/core.c:4890
        sched_setscheduler_nocheck+0xb/0x10 kernel/sched/core.c:4936
        __kthread_create_on_node+0x32a/0x460 kernel/kthread.c:349
        kthread_create_on_node+0xbb/0xf0 kernel/kthread.c:388
        create_worker+0x25c/0x570 kernel/workqueue.c:1929
        workqueue_prepare_cpu+0xa1/0x100 kernel/workqueue.c:4982
        cpuhp_invoke_callback+0x21a/0x1c60 kernel/cpu.c:172
        cpuhp_up_callbacks kernel/cpu.c:593 [inline]
        _cpu_up+0x289/0x550 kernel/cpu.c:1153
        do_cpu_up+0x171/0x190 kernel/cpu.c:1188
        cpu_up+0x1b/0x20 kernel/cpu.c:1196
        smp_init+0x248/0x261 kernel/smp.c:593
        kernel_init_freeable+0x339/0x5be init/main.c:1185
        kernel_init+0x12/0x1c5 init/main.c:1110
        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

-> #0 (cpu_hotplug_lock.rw_sem){++++}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain kernel/locking/lockdep.c:2971 [inline]
        __lock_acquire+0x25b6/0x4e70 kernel/locking/lockdep.c:3955
        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
        percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
        cpus_read_lock+0x3e/0x150 kernel/cpu.c:292
        __static_key_slow_dec kernel/jump_label.c:254 [inline]
        static_key_slow_dec+0x54/0xa0 kernel/jump_label.c:270
        sw_perf_event_destroy+0x8b/0x130 kernel/events/core.c:8482
        _free_event+0x354/0x13a0 kernel/events/core.c:4470
        put_event+0x47/0x60 kernel/events/core.c:4564
        perf_mmap_close+0x585/0xe00 kernel/events/core.c:5567
        remove_vma+0xb2/0x180 mm/mmap.c:183
        remove_vma_list mm/mmap.c:2615 [inline]
        __do_munmap+0x7b0/0x10f0 mm/mmap.c:2859
        do_munmap mm/mmap.c:2867 [inline]
        mmap_region+0x227/0x1760 mm/mmap.c:1745
        do_mmap+0x853/0x1180 mm/mmap.c:1575
        do_mmap_pgoff include/linux/mm.h:2395 [inline]
        vm_mmap_pgoff+0x1c5/0x230 mm/util.c:496
        ksys_mmap_pgoff+0x4aa/0x630 mm/mmap.c:1625
        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
        do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   cpu_hotplug_lock.rw_sem --> &cpuset_rwsem --> &mm->mmap_sem#2

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&mm->mmap_sem#2);
                                lock(&cpuset_rwsem);
                                lock(&mm->mmap_sem#2);
   lock(cpu_hotplug_lock.rw_sem);

  *** DEADLOCK ***

1 lock held by syz-executor590/9351:
  #0: ffff8880a96354d0 (&mm->mmap_sem#2){++++}, at:  
vm_mmap_pgoff+0x173/0x230 mm/util.c:494

stack backtrace:
CPU: 0 PID: 9351 Comm: syz-executor590 Not tainted 5.3.0-rc4-next-20190814  
#66
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1685
  check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1809
  check_prev_add kernel/locking/lockdep.c:2476 [inline]
  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
  validate_chain kernel/locking/lockdep.c:2971 [inline]
  __lock_acquire+0x25b6/0x4e70 kernel/locking/lockdep.c:3955
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
  cpus_read_lock+0x3e/0x150 kernel/cpu.c:292
  __static_key_slow_dec kernel/jump_label.c:254 [inline]
  static_key_slow_dec+0x54/0xa0 kernel/jump_label.c:270
  sw_perf_event_destroy+0x8b/0x130 kernel/events/core.c:8482
  _free_event+0x354/0x13a0 kernel/events/core.c:4470
  put_event+0x47/0x60 kernel/events/core.c:4564
  perf_mmap_close+0x585/0xe00 kernel/events/core.c:5567
  remove_vma+0xb2/0x180 mm/mmap.c:183
  remove_vma_list mm/mmap.c:2615 [inline]
  __do_munmap+0x7b0/0x10f0 mm/mmap.c:2859
  do_munmap mm/mmap.c:2867 [inline]
  mmap_region+0x227/0x1760 mm/mmap.c:1745
  do_mmap+0x853/0x1180 mm/mmap.c:1575
  do_mmap_pgoff include/linux/mm.h:2395 [inline]
  vm_mmap_pgoff+0x1c5/0x230 mm/util.c:496
  ksys_mmap_pgoff+0x4aa/0x630 mm/mmap.c:1625
  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
  __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4473b9
Code: e8 4c bb 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f148465bda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00000000006dcc38 RCX: 00000000004473b9
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffd000
RBP: 00000000006dcc30 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 00000000006dcc3c
R13: 00007ffd3f4be3ef R14: 00007f148465c9c0 R15: 0000000000000000

