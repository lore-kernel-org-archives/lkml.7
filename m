Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6948BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DEA2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8qLkXgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfD2OLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:11:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45918 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfD2OLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:11:08 -0400
Received: by mail-oi1-f195.google.com with SMTP id t189so5351256oih.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVJUEmBZH9dIQRp5ZrIjIl+KydIc6UqttgRSK3bunyk=;
        b=Y8qLkXgHLm7dnKXCxqLo3oU4DOvJ3MeBO33F0tEkUshrqC7mgH/5Pbd1qFPlUHi9Fj
         Ufne1jHJww/x3oKfsbvhTf47Iz/ToWi8BA4KymtOf7nBykEb0DLRlkPDZzE37cXk3Ldv
         I4ZYSTMZ4Jt7eF4uisD3fXJD6+2WZ0/64Y2LqWO4Uma6xhpPk8OwQDw0b/xGvK9KecLw
         CbrIco5C9hrDebpoKi1gtM+zLK3hm6Tl3ssmUgL1somfc/04Jn6jM1uTTOZuKKSvLO2l
         0hg2v6URskA9TKLD5aixlihcTB09IyGn3Gm2SkgHu5t4jmVMpsiz2rVAY1ehWreaNYVf
         LUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVJUEmBZH9dIQRp5ZrIjIl+KydIc6UqttgRSK3bunyk=;
        b=SQXgy0VjAhgH/A9+RxLWSwVpyTn1PeNUSkRl2rZIQEwC5HeKPKzyTtLNzOFamoTcSM
         NWo8/1jK8nPjCo3YBE56eYWa2PtoBx5D2RPNdNj+r9K3Wss8wXJxRp3OzcZj0MJoWzdv
         VbjlCKPE0vrVKQMZEorVENHp7FXpAncVt1ZCSHaA2OKAg/EQBK+EE56IlbErelUrDqyA
         C4Vd5xJFFOI6zic864VMLa5FvyYSa+Ed6+j+ryqc5+JT5BRbA154h4otEcndRP+pNeX3
         82bupOIEtq1x15p58iRJApIvfM3IKLWBVlT3wGQ4h4PnOn9JqtVzIzIWnohLSsqBVQ9Z
         DOsQ==
X-Gm-Message-State: APjAAAWJgdRp1uSvyK+spiBizjtCqx8ODb7ciKjtREhS9+vJ3ZOMcywb
        XH1ipiz8+2WqrDUTe45H1g8UC8lPCe4HhtBfjw0+Eg==
X-Google-Smtp-Source: APXvYqzcUcvO9BdbElLNRKLoZRQzG/O6l3eifNPIo96kpkuqij8X4/PK7ao2CMXPWuqPAzpxfB7mZhMqTKMLQIT4sDI=
X-Received: by 2002:aca:e4cc:: with SMTP id b195mr16038461oih.39.1556547067505;
 Mon, 29 Apr 2019 07:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190429023104.GC29809@shao2-debian>
In-Reply-To: <20190429023104.GC29809@shao2-debian>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 29 Apr 2019 10:10:41 -0400
Message-ID: <CAG48ez35=C-X9Nv+gXa_EtaJ_rmv4UoyUynO5DdqFep8nGfD5w@mail.gmail.com>
Subject: Re: [x86/unwind] 0830cf62f5: BUG:KASAN:stack-out-of-bounds_in_u
To:     kernel test robot <rong.a.chen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lkp@01.org
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 10:30 PM kernel test robot
<rong.a.chen@intel.com> wrote:
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 0830cf62f5290b2f878faacc2b6f32e77bc2ea12 ("x86/unwind: Add hardcoded ORC entry for NULL")
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
>
> in testcase: trinity
> with following parameters:
>
>         runtime: 300s
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +------------------------------------+------------+------------+
> |                                    | 0312f3032e | 0830cf62f5 |
> +------------------------------------+------------+------------+
> | boot_successes                     | 66         | 52         |
> | boot_failures                      | 0          | 14         |
> | BUG:KASAN:stack-out-of-bounds_in_u | 0          | 14         |
> | RIP:__x86_indirect_thunk_rdx       | 0          | 14         |
> +------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> [  176.470970] BUG: KASAN: stack-out-of-bounds in unwind_next_frame+0x1361/0x1b20

I don't think this is a new bug I've introduced. It would be nice if
the test robot could also provide an "objdump -d -r -S -Mintel", or
something like that, of the offending method; but even without that, I
think a pretty big hint is visible in this case:

> [  176.473005] Read of size 8 at addr ffff88805723f878 by task trinity-main/605
> [  176.474776]
> [  176.475424] CPU: 1 PID: 605 Comm: trinity-main Not tainted 5.0.4-00048-g0830cf6 #1
> [  176.477513] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [  176.479754] Call Trace:
> [  176.480590]  <IRQ>
> [  176.481344]  dump_stack+0x5b/0x8b
> [  176.482358]  ? unwind_next_frame+0x1361/0x1b20
> [  176.483598]  print_address_description+0x6a/0x290
> [  176.484893]  ? unwind_next_frame+0x1361/0x1b20
> [  176.486126]  ? unwind_next_frame+0x1361/0x1b20
> [  176.487370]  kasan_report+0x139/0x199
> [  176.488450]  ? unwind_next_frame+0x1361/0x1b20
> [  176.489690]  unwind_next_frame+0x1361/0x1b20
> [  176.490893]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  176.492288]  ? unwind_get_return_address_ptr+0xb0/0xb0
> [  176.493662]  ? rcu_dynticks_curr_cpu_in_eqs+0x54/0xb0
> [  176.495016]  ? rcu_is_watching+0xc/0x20
> [  176.496131]  ? rcu_is_watching+0xc/0x20
> [  176.497251]  ? kernel_text_address+0x68/0x90
> [  176.498454]  __save_stack_trace+0x73/0xd0
> [  176.499607]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  176.500995]  save_stack+0x32/0xb0
> [  176.502003]  ? __kasan_slab_free+0x130/0x180
> [  176.503204]  ? kfree+0xaa/0x1e0
> [  176.504176]  ? rcu_process_callbacks+0x4b5/0xd00
> [  176.505467]  ? __do_softirq+0x1bc/0x6d9
> [  176.506590]  ? irq_exit+0x10f/0x130
> [  176.507644]  ? smp_apic_timer_interrupt+0x176/0x400
> [  176.508994]  ? apic_timer_interrupt+0xf/0x20
> [  176.510220]  ? __x86_indirect_thunk_rcx+0x20/0x20
> [  176.511515]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  176.512935]  ? check_preempt_wakeup+0x2b4/0x690
> [  176.514233]  ? probe_sched_switch+0x30/0x30
> [  176.515442]  ? tracing_record_taskinfo_skip+0x56/0x70
> [  176.516824]  ? tracing_record_taskinfo+0x14/0x1a0
> [  176.518156]  ? ttwu_do_wakeup+0x3a1/0x530
> [  176.519304]  ? _raw_spin_unlock_irqrestore+0x18/0x30
> [  176.520561]  ? try_to_wake_up+0xc5/0x11e0
> [  176.521635]  ? __migrate_task+0x140/0x140
> [  176.522705]  ? _raw_spin_lock_irqsave+0x84/0xd0
> [  176.523957]  ? _raw_spin_lock_irq+0xd0/0xd0
> [  176.525146]  __kasan_slab_free+0x130/0x180
> [  176.526311]  ? rcu_process_callbacks+0x4b5/0xd00
> [  176.527578]  kfree+0xaa/0x1e0
> [  176.528515]  rcu_process_callbacks+0x4b5/0xd00
> [  176.529708]  ? rcu_read_unlock_special+0xf0/0xf0
> [  176.530908]  ? sched_clock_cpu+0x31/0x1e0
> [  176.531934]  __do_softirq+0x1bc/0x6d9
> [  176.532851]  irq_exit+0x10f/0x130
> [  176.533709]  smp_apic_timer_interrupt+0x176/0x400
> [  176.534800]  apic_timer_interrupt+0xf/0x20
> [  176.535789]  </IRQ>
> [  176.536434] RIP: 0010:__x86_indirect_thunk_rdx+0x0/0x20
> [  176.537618] Code: 84 00 00 00 00 00 0f 1f 40 00 e8 07 00 00 00 f3 90 0f ae e8 eb f9 48 89 0c 24 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 <e8> 07 00 00 00 f3 90 0f ae e8 eb f9 48 89 14 24 c3 66 66 2e 0f 1f
> [  176.541507] RSP: 0018:ffff88805723f7f0 EFLAGS: 00000297 ORIG_RAX: ffffffffffffff13
> [  176.543287] RAX: 0000000000000005 RBX: ffff88805723f8c8 RCX: 0000000000000000
> [  176.545047] RDX: ffffffff968efe39 RSI: 0000000000000001 RDI: 0000000000000001
> [  176.546782] RBP: 1ffff1100ae47f06 R08: ffffffff9d146598 R09: ffffffff9d14659c
> [  176.548526] R10: 00000000000ebfb5 R11: ffff88805723f8fd R12: 0000000000000001
> [  176.550261] R13: ffff88805723f910 R14: ffff88805723f900 R15: ffff88805723f918
> [  176.554447]  ? unwind_next_frame+0x8b9/0x1b20
> [  176.555638]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  176.556907] RIP: 5bd3e400:0x2
> [  176.557788] Code: Bad RIP value.
> [  176.558712] RSP: 5723f940:ffff88805723f950 EFLAGS: 1010000000000 ORIG_RAX: 0000000000000000

The last three lines look suspicious. Those CS and SS selectors make
no sense, and the EFLAGS (0001'0100'0000'0000) are missing the
reserved-always-1 bit, and instead they have bits set in the high
half. And while deref_stack_reg() uses READ_ONCE_NOCHECK() to suppress
ASAN complaints caused by bogus stack contents, deref_stack_regs() and
deref_stack_iret_regs() don't have such protections. So I'm thinking
that the unwinder probably went off the rails somehow, and ended up
looking at stack redzones, and then ASAN noticed that.

What I don't understand is what made the unwinder go off the rails in
the first place. Is there a missing annotation somewhere in
entry_SYSCALL_64_after_hwframe, or something like that?

(quoting rest of the mail below for context)


> [  176.560829] RAX: ffff88805723f8d0 RBX: ffff88805723f8d8 RCX: ffff88805723ff58
> [  176.562513] RDX: 0000000000000001 RSI: ffff888057238000 RDI: ffff888057240000
> [  176.564191] RBP: ffffffff9cbbef86 R08: ffffffff968ef580 R09: ffffffff9b9d951c
> [  176.565852] R10: 0000000041b58ab3 R11: ffffffff96a0e86e R12: ffff88805723f8fd
> [  176.567548] R13: ffffffff9cbbef82 R14: ffff88805723f8fd R15: ffff88805723ff58
> [  176.569293]  ? __kernel_text_address+0xe/0x30
> [  176.570492]  ? unwind_get_return_address_ptr+0xb0/0xb0
> [  176.571848]  ? __save_stack_trace+0x73/0xd0
> [  176.573048]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  176.574368]  ? save_stack+0x32/0xb0
> [  176.575362]  ? __kasan_kmalloc+0xa0/0xd0
> [  176.576631]  ? kmem_cache_alloc+0xb7/0x1b0
> [  176.577739]  ? anon_vma_fork+0xcf/0x5b0
> [  176.578800]  ? copy_process+0x4f25/0x5a90
> [  176.580208]  ? _do_fork+0x13f/0x840
> [  176.581224]  ? do_syscall_64+0x96/0x8fb
> [  176.582300]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  176.583654]  ? kmem_cache_alloc+0xb7/0x1b0
> [  176.584804]  ? vm_area_dup+0x1e/0x180
> [  176.585884]  ? copy_process+0x4b1b/0x5a90
> [  176.587146]  ? _do_fork+0x13f/0x840
> [  176.588159]  ? do_syscall_64+0x96/0x8fb
> [  176.589221]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  176.590549]  ? copy_page_range+0xe56/0x1ad0
> [  176.591711]  ? kasan_unpoison_shadow+0x30/0x40
> [  176.592933]  ? __kasan_kmalloc+0xa0/0xd0
> [  176.594114]  ? kasan_unpoison_shadow+0x30/0x40
> [  176.595168]  ? __kasan_kmalloc+0xa0/0xd0
> [  176.596302]  ? anon_vma_fork+0xcf/0x5b0
> [  176.597241]  ? kmem_cache_alloc+0xb7/0x1b0
> [  176.598225]  ? anon_vma_fork+0xcf/0x5b0
> [  176.599168]  ? copy_process+0x4f25/0x5a90
> [  176.600255]  ? __cleanup_sighand+0x40/0x40
> [  176.601240]  ? __might_fault+0x87/0xb0
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.0.4-00048-g0830cf6 .config
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
>
>
> Thanks,
> Rong Chen
>
