Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4959FC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 08:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D3A2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfGTIlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 04:41:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727078AbfGTIlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 04:41:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53CE9ADFE;
        Sat, 20 Jul 2019 08:41:07 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Waiman Long" <longman@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Will Deacon" <will.deacon@arm.com>,
        "huang ying" <huang.ying.caritas@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Linux List Kernel Mailing" <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an atomic_long_t
References: <20190520205918.22251-1-longman@redhat.com>
        <20190520205918.22251-14-longman@redhat.com>
        <20190719184538.GA20324@hermes.olymp>
        <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com>
        <CAHk-=wioLqXBWWQywZGfxumsY_H6dFE3R=+WJ3mAL_WYV1fm9Q@mail.gmail.com>
Date:   Sat, 20 Jul 2019 09:41:05 +0100
In-Reply-To: <CAHk-=wioLqXBWWQywZGfxumsY_H6dFE3R=+WJ3mAL_WYV1fm9Q@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 19 Jul 2019 12:51:44 -0700")
Message-ID: <87h87hksim.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Linus Torvalds" <torvalds@linux-foundation.org> writes:

> On Fri, Jul 19, 2019 at 12:32 PM Waiman Long <longman@redhat.com> wrote:
>>
>> This patch shouldn't change the behavior of the rwsem code. The code
>> only access data within the rw_semaphore structures. I don't know why it
>> will cause a KASAN error. I will have to reproduce it and figure out
>> exactly which statement is doing the invalid access.
>
> The stack traces should show line numbers if you run them through
> scripts/decode_stacktrace.sh.
>
> You need to have debug info enabled for that, though.
>
> Luis?
>
>              Linus

Yep, sure.  And I should have done this in the initial report.  It's a
different trace, I had to recompile the kernel.

(I'm also adding Jeff to the CC list.)

Cheers,
-- 
Luis

[   39.801179] ==================================================================
[   39.801973] BUG: KASAN: use-after-free in rwsem_down_write_slowpath (/home/miguel/kernel/linux/kernel/locking/rwsem.c:669 /home/miguel/kernel/linux/kernel/locking/rwsem.c:1125) 
[   39.802733] Read of size 4 at addr ffff8881f1f65138 by task xfs_io/2145

[   39.803598] CPU: 0 PID: 2145 Comm: xfs_io Not tainted 5.2.0+ #460
[   39.803600] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[   39.803602] Call Trace:
[   39.803609] dump_stack (/home/miguel/kernel/linux/lib/dump_stack.c:115) 
[   39.803615] print_address_description (/home/miguel/kernel/linux/mm/kasan/report.c:352) 
[   39.803618] ? rwsem_down_write_slowpath (/home/miguel/kernel/linux/kernel/locking/rwsem.c:669 /home/miguel/kernel/linux/kernel/locking/rwsem.c:1125) 
[   39.803621] ? rwsem_down_write_slowpath (/home/miguel/kernel/linux/kernel/locking/rwsem.c:669 /home/miguel/kernel/linux/kernel/locking/rwsem.c:1125) 
[   39.803624] __kasan_report.cold (/home/miguel/kernel/linux/mm/kasan/report.c:483) 
[   39.803629] ? rwsem_down_write_slowpath (/home/miguel/kernel/linux/kernel/locking/rwsem.c:669 /home/miguel/kernel/linux/kernel/locking/rwsem.c:1125) 
[   39.803633] kasan_report (/home/miguel/kernel/linux/./arch/x86/include/asm/smap.h:69 /home/miguel/kernel/linux/mm/kasan/common.c:613) 
[   39.803636] rwsem_down_write_slowpath (/home/miguel/kernel/linux/kernel/locking/rwsem.c:669 /home/miguel/kernel/linux/kernel/locking/rwsem.c:1125) 
[   39.803641] ? __ceph_caps_issued_mask (/home/miguel/kernel/linux/fs/ceph/caps.c:914) 
[   39.803644] ? find_held_lock (/home/miguel/kernel/linux/kernel/locking/lockdep.c:4004) 
[   39.803649] ? __ceph_do_getattr (/home/miguel/kernel/linux/fs/ceph/inode.c:2246) 
[   39.803653] ? down_read_non_owner (/home/miguel/kernel/linux/kernel/locking/rwsem.c:1116) 
[   39.803658] ? do_raw_spin_unlock (/home/miguel/kernel/linux/./include/linux/compiler.h:218 /home/miguel/kernel/linux/./include/asm-generic/qspinlock.h:94 /home/miguel/kernel/linux/kernel/locking/spinlock_debug.c:139) 
[   39.803663] ? _raw_spin_unlock (/home/miguel/kernel/linux/kernel/locking/spinlock.c:184) 
[   39.803667] ? __lock_acquire.isra.0 (/home/miguel/kernel/linux/kernel/locking/lockdep.c:3884) 
[   39.803674] ? path_openat (/home/miguel/kernel/linux/fs/namei.c:3322 /home/miguel/kernel/linux/fs/namei.c:3533) 
[   39.803680] ? down_write (/home/miguel/kernel/linux/kernel/locking/rwsem.c:1486) 
[   39.803683] down_write (/home/miguel/kernel/linux/kernel/locking/rwsem.c:1486) 
[   39.803687] ? down_read_killable (/home/miguel/kernel/linux/kernel/locking/rwsem.c:1482) 
[   39.803690] ? __sb_start_write (/home/miguel/kernel/linux/./include/linux/compiler.h:194 /home/miguel/kernel/linux/./include/linux/rcu_sync.h:38 /home/miguel/kernel/linux/./include/linux/percpu-rwsem.h:52 /home/miguel/kernel/linux/fs/super.c:1608) 
[   39.803694] ? __mnt_want_write (/home/miguel/kernel/linux/fs/namespace.c:253 /home/miguel/kernel/linux/fs/namespace.c:297 /home/miguel/kernel/linux/fs/namespace.c:337) 
[   39.803699] path_openat (/home/miguel/kernel/linux/fs/namei.c:3322 /home/miguel/kernel/linux/fs/namei.c:3533) 
[   39.803706] ? path_mountpoint (/home/miguel/kernel/linux/fs/namei.c:3518) 
[   39.803711] ? __is_insn_slot_addr (/home/miguel/kernel/linux/kernel/kprobes.c:291) 
[   39.803716] ? kernel_text_address (/home/miguel/kernel/linux/kernel/extable.c:113) 
[   39.803719] ? __kernel_text_address (/home/miguel/kernel/linux/kernel/extable.c:95) 
[   39.803724] ? unwind_get_return_address (/home/miguel/kernel/linux/arch/x86/kernel/unwind_orc.c:311 /home/miguel/kernel/linux/arch/x86/kernel/unwind_orc.c:306) 
[   39.803727] ? swiotlb_map.cold (/home/miguel/kernel/linux/kernel/stacktrace.c:83) 
[   39.803730] ? arch_stack_walk (/home/miguel/kernel/linux/arch/x86/kernel/stacktrace.c:26) 
[   39.803735] do_filp_open (/home/miguel/kernel/linux/fs/namei.c:3563) 
[   39.803739] ? may_open_dev (/home/miguel/kernel/linux/fs/namei.c:3557) 
[   39.803746] ? __alloc_fd (/home/miguel/kernel/linux/fs/file.c:536) 
[   39.803749] ? lock_downgrade (/home/miguel/kernel/linux/kernel/locking/lockdep.c:4422) 
[   39.803753] ? do_raw_spin_lock (/home/miguel/kernel/linux/kernel/locking/spinlock_debug.c:92 /home/miguel/kernel/linux/kernel/locking/spinlock_debug.c:115) 
[   39.803757] ? rwlock_bug.part.0 (/home/miguel/kernel/linux/kernel/locking/spinlock_debug.c:111) 
[   39.803762] ? do_raw_spin_unlock (/home/miguel/kernel/linux/./include/linux/compiler.h:218 /home/miguel/kernel/linux/./include/asm-generic/qspinlock.h:94 /home/miguel/kernel/linux/kernel/locking/spinlock_debug.c:139) 
[   39.803766] ? _raw_spin_unlock (/home/miguel/kernel/linux/kernel/locking/spinlock.c:184) 
[   39.803769] ? __alloc_fd (/home/miguel/kernel/linux/fs/file.c:536) 
[   39.803774] do_sys_open (/home/miguel/kernel/linux/fs/open.c:1070) 
[   39.803778] ? filp_open (/home/miguel/kernel/linux/fs/open.c:1056) 
[   39.803781] ? switch_fpu_return (/home/miguel/kernel/linux/./arch/x86/include/asm/bitops.h:76 /home/miguel/kernel/linux/./include/asm-generic/bitops-instrumented.h:57 /home/miguel/kernel/linux/./include/linux/thread_info.h:60 /home/miguel/kernel/linux/./arch/x86/include/asm/fpu/internal.h:547 /home/miguel/kernel/linux/arch/x86/kernel/fpu/core.c:343) 
[   39.803786] ? __do_page_fault (/home/miguel/kernel/linux/./include/linux/compiler.h:194 /home/miguel/kernel/linux/./arch/x86/include/asm/atomic.h:31 /home/miguel/kernel/linux/./include/asm-generic/atomic-instrumented.h:27 /home/miguel/kernel/linux/./include/linux/jump_label.h:254 /home/miguel/kernel/linux/./include/linux/jump_label.h:264 /home/miguel/kernel/linux/./include/linux/perf_event.h:1094 /home/miguel/kernel/linux/arch/x86/mm/fault.c:1485 /home/miguel/kernel/linux/arch/x86/mm/fault.c:1510) 
[   39.803792] do_syscall_64 (/home/miguel/kernel/linux/arch/x86/entry/common.c:296) 
[   39.803796] entry_SYSCALL_64_after_hwframe (/home/miguel/kernel/linux/arch/x86/entry/entry_64.S:184) 
[   39.803799] RIP: 0033:0x7f62b41a2528
[ 39.803803] Code: 00 00 41 00 3d 00 00 41 00 74 47 48 8d 05 20 4d 0d 00 8b 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 94 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	41 00 3d 00 00 41 00 	add    %dil,0x410000(%rip)        # 0x410009
   9:	74 47                	je     0x52
   b:	48 8d 05 20 4d 0d 00 	lea    0xd4d20(%rip),%rax        # 0xd4d32
  12:	8b 00                	mov    (%rax),%eax
  14:	85 c0                	test   %eax,%eax
  16:	75 6b                	jne    0x83
  18:	44 89 e2             	mov    %r12d,%edx
  1b:	48 89 ee             	mov    %rbp,%rsi
  1e:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
  23:	b8 01 01 00 00       	mov    $0x101,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	0f 87 94 00 00 00    	ja     0xca
  36:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  3b:	64                   	fs
  3c:	48                   	rex.W
  3d:	33                   	.byte 0x33
  3e:	0c 25                	or     $0x25,%al

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	0f 87 94 00 00 00    	ja     0xa0
   c:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  11:	64                   	fs
  12:	48                   	rex.W
  13:	33                   	.byte 0x33
  14:	0c 25                	or     $0x25,%al
[   39.803805] RSP: 002b:00007ffe6c3359e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[   39.803808] RAX: ffffffffffffffda RBX: 0000000000000242 RCX: 00007f62b41a2528
[   39.803810] RDX: 0000000000000242 RSI: 00007ffe6c3382a5 RDI: 00000000ffffff9c
[   39.803812] RBP: 00007ffe6c3382a5 R08: 0000000000000001 R09: 0000000000000000
[   39.803814] R10: 0000000000000180 R11: 0000000000000246 R12: 0000000000000242
[   39.803816] R13: 00007ffe6c335cc0 R14: 0000000000000180 R15: 0000000000000060

[   39.803996] Allocated by task 2093:
[   39.804373] __kasan_kmalloc.part.0 (/home/miguel/kernel/linux/mm/kasan/common.c:69 /home/miguel/kernel/linux/mm/kasan/common.c:77 /home/miguel/kernel/linux/mm/kasan/common.c:487) 
[   39.804376] kmem_cache_alloc (/home/miguel/kernel/linux/mm/slab.h:522 /home/miguel/kernel/linux/mm/slub.c:2766 /home/miguel/kernel/linux/mm/slub.c:2774 /home/miguel/kernel/linux/mm/slub.c:2779) 
[   39.804380] copy_process (/home/miguel/kernel/linux/kernel/fork.c:852 /home/miguel/kernel/linux/kernel/fork.c:1856) 
[   39.804382] _do_fork (/home/miguel/kernel/linux/kernel/fork.c:2369) 
[   39.804385] __se_sys_clone (/home/miguel/kernel/linux/kernel/fork.c:2505) 
[   39.804387] do_syscall_64 (/home/miguel/kernel/linux/arch/x86/entry/common.c:296) 
[   39.804390] entry_SYSCALL_64_after_hwframe (/home/miguel/kernel/linux/arch/x86/entry/entry_64.S:184) 

[   39.804558] Freed by task 16:
[   39.804871] __kasan_slab_free (/home/miguel/kernel/linux/mm/kasan/common.c:69 /home/miguel/kernel/linux/mm/kasan/common.c:77 /home/miguel/kernel/linux/mm/kasan/common.c:449) 
[   39.804874] kmem_cache_free (/home/miguel/kernel/linux/mm/slub.c:1470 /home/miguel/kernel/linux/mm/slub.c:3012 /home/miguel/kernel/linux/mm/slub.c:3028) 
[   39.804877] rcu_core (/home/miguel/kernel/linux/./include/linux/rcupdate.h:213 /home/miguel/kernel/linux/kernel/rcu/rcu.h:223 /home/miguel/kernel/linux/kernel/rcu/tree.c:2114 /home/miguel/kernel/linux/kernel/rcu/tree.c:2314) 
[   39.804880] __do_softirq (/home/miguel/kernel/linux/./include/asm-generic/atomic-instrumented.h:26 /home/miguel/kernel/linux/./include/linux/jump_label.h:254 /home/miguel/kernel/linux/./include/linux/jump_label.h:264 /home/miguel/kernel/linux/./include/trace/events/irq.h:142 /home/miguel/kernel/linux/kernel/softirq.c:293) 

[   39.805048] The buggy address belongs to the object at ffff8881f1f65100
which belongs to the cache task_struct of size 4928
[   39.806345] The buggy address is located 56 bytes inside of
4928-byte region [ffff8881f1f65100, ffff8881f1f66440)
[   39.807543] The buggy address belongs to the page:
[   39.808045] page:ffffea0007c7d800 refcount:1 mapcount:0 mapping:ffff8881f6811800 index:0x0 compound_mapcount: 0
[   39.808049] flags: 0x8000000000010200(slab|head)
[   39.808053] raw: 8000000000010200 dead000000000100 dead000000000122 ffff8881f6811800
[   39.808056] raw: 0000000000000000 0000000000060006 00000001ffffffff 0000000000000000
[   39.808058] page dumped because: kasan: bad access detected

[   39.808224] Memory state around the buggy address:
[   39.808723]  ffff8881f1f65000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   39.809476]  ffff8881f1f65080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   39.810220] >ffff8881f1f65100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   39.810968]                                         ^
[   39.811504]  ffff8881f1f65180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   39.812237]  ffff8881f1f65200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   39.812972] ==================================================================
[   39.813710] Disabling lock debugging due to kernel taint
