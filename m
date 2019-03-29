Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEACFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2BE218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfC2QsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:48:04 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:56764 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728956AbfC2QsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:48:04 -0400
X-Greylist: delayed 2256 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Mar 2019 12:48:03 EDT
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1h9u5E-0003cP-6V; Fri, 29 Mar 2019 12:10:20 -0400
Date:   Fri, 29 Mar 2019 12:10:15 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Pedro Cuadra Chamorro <pcuadrac@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: fs/coda oops bisected to (925b9cd1b8) "locking/rwsem: Make owner
 store task pointer of last owning reader"
Message-ID: <20190329161014.ri4hzemg3ibvjw46@cs.cmu.edu>
Mail-Followup-To: Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Pedro Cuadra Chamorro <pcuadrac@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was testing Coda on the 5.1-rc2 kernel and noticed that when I run a
binary out of /coda, the binary would never exit and the system would
detect a soft lockup. I narrowed it down to a very simple reproducible
case of running a statically linked executable (busybox) from /coda with
the cwd outside of Coda, so the only Coda file reference is from the
executable itself.

I knew I definitely had never seen this problem with the stable kernel
on Ubuntu xenial (4.4) so I bisected between v4.4 and v5.1-rc2 and ended
up at

    # first bad commit: [925b9cd1b89a94b7124d128c80dfc48f78a63098]
    # locking/rwsem: Make owner store task pointer of last owning reader

When I revert this particular commit on 5.1-rc2, I am not able to
reproduce the problem anymore.

The puzzling thing to me is that a lot of that particular patch touches
codepaths that are not even enabled in the kernels that I run, because I
do not have CONFIG_RWSEM_DEBUG enabled.

    $ grep RWSEM .config
    CONFIG_RWSEM_XCHGADD_ALGORITHM=y
    CONFIG_RWSEM_SPIN_ON_OWNER=y
    # CONFIG_DEBUG_RWSEMS is not set

And this patch is for rwsem, while my soft lockup is on a spinlock.
So either I have a race in fs/coda that got somehow uncovered by this
patch, or something else is going on here but I have not been able to
figure it out.

Jan



Here is the Oops that reliably triggers on any kernel after 925b9cd1b8
when I execute a binary from /coda. It repeats a second time 28 seconds
later and another 5 seconds later is followed by "rcu_sched
self-detected stall on CPU" which I include as well.


[   64.145934] watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [busybox:1814]
[   64.145938] Modules linked in: snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_pcm kvm_intel kvm irqbypass crct10dif_pclmul snd_hwdep crc32_pclmul ghash_clmulni_intel snd_seq snd_timer aesni_intel joydev snd_seq_device aes_x86_64 crypto_simd cryptd glue_helper snd input_leds soundcore serio_raw i2c_piix4 mac_hid parport_pc ppdev lp parport coda hid_generic usbhid hid qxl drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm psmouse pata_acpi floppy
[   64.145958] CPU: 4 PID: 1814 Comm: busybox Not tainted 4.19.0-rc3+ #18
[   64.145959] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   64.145964] RIP: 0010:native_queued_spin_lock_slowpath+0x21/0x1c0
[   64.145965] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 0f 1f 44 00 00 ba 01 00 00 00 8b 07 85 c0 75 0a f0 0f b1 17 85 c0 75 f2 f3 c3 f3 90 <eb> ec 81 fe 00 01 00 00 0f 84 25 01 00 00 81 e6 00 ff ff ff 75 44
[   64.145966] RSP: 0018:ffffbab781dabdf0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
[   64.145967] RAX: 00000000ffff9491 RBX: ffff949179f30c00 RCX: 0000000000000000
[   64.145967] RDX: 0000000000000001 RSI: 00000000ffff9491 RDI: ffff9490777dca04
[   64.145968] RBP: ffff9490777dca08 R08: 0000000000025f80 R09: ffffffffc01db0ed
[   64.145968] R10: ffffbab781dabe30 R11: 0000000000000001 R12: ffff949176c2a220
[   64.145969] R13: ffff9490777dca04 R14: ffff94917950edc8 R15: ffff9490777dca08
[   64.145970] FS:  0000000001957880(0000) GS:ffff94917bb00000(0000) knlGS:0000000000000000
[   64.145970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   64.145971] CR2: 0000000000415c20 CR3: 000000007720a001 CR4: 0000000000160ee0
[   64.145974] Call Trace:
[   64.145979]  _raw_spin_lock+0x1d/0x20
[   64.145982]  coda_release+0x66/0xd0 [coda]
[   64.145986]  __fput+0xe2/0x210
[   64.145989]  task_work_run+0x86/0xa0
[   64.145990]  do_exit+0x2d7/0xb30
[   64.145994]  ? handle_mm_fault+0xfa/0x200
[   64.145995]  do_group_exit+0x3a/0xa0
[   64.145996]  __x64_sys_exit_group+0x14/0x20
[   64.145998]  do_syscall_64+0x55/0x100
[   64.145999]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   64.146001] RIP: 0033:0x453988
[   64.146005] Code: Bad RIP value.
[   64.146005] RSP: 002b:00007ffcd39246a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   64.146006] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000453988
[   64.146007] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   64.146007] RBP: 00000000005a79b0 R08: 00000000000000e7 R09: ffffffffffffffe0
[   64.146008] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000001
[   64.146008] R13: 00000000007c1640 R14: 00000000005a0fc1 R15: 0000000000000000
...
[   97.001204] rcu: INFO: rcu_sched self-detected stall on CPU
[   97.001211] rcu: 	4-....: (14997 ticks this GP) idle=916/1/0x4000000000000002 softirq=2901/2901 fqs=6623 
[   97.001211] rcu: 	 (t=15000 jiffies g=3281 q=10605)
[   97.001213] NMI backtrace for cpu 4
[   97.001215] CPU: 4 PID: 1814 Comm: busybox Tainted: G             L    4.19.0-rc3+ #18
[   97.001216] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   97.001216] Call Trace:
[   97.001219]  <IRQ>
[   97.001223]  dump_stack+0x5c/0x7b
[   97.001236]  nmi_cpu_backtrace+0x8a/0x90
[   97.001239]  ? lapic_can_unplug_cpu+0xa0/0xa0
[   97.001240]  nmi_trigger_cpumask_backtrace+0xfb/0x130
[   97.001242]  rcu_dump_cpu_stacks+0x89/0xb9
[   97.001244]  rcu_check_callbacks+0x60f/0x770
[   97.001255]  ? tick_sched_do_timer+0x60/0x60
[   97.001257]  update_process_times+0x28/0x50
[   97.001258]  tick_sched_handle+0x22/0x60
[   97.001259]  tick_sched_timer+0x37/0x70
[   97.001261]  __hrtimer_run_queues+0xfc/0x270
[   97.001262]  hrtimer_interrupt+0x122/0x270
[   97.001264]  smp_apic_timer_interrupt+0x6a/0x140
[   97.001265]  apic_timer_interrupt+0xf/0x20
[   97.001266]  </IRQ>
[   97.001269] RIP: 0010:native_queued_spin_lock_slowpath+0x21/0x1c0
[   97.001270] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 0f 1f 44 00 00 ba 01 00 00 00 8b 07 85 c0 75 0a f0 0f b1 17 85 c0 75 f2 f3 c3 f3 90 <eb> ec 81 fe 00 01 00 00 0f 84 25 01 00 00 81 e6 00 ff ff ff 75 44
[   97.001270] RSP: 0018:ffffbab781dabdf0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
[   97.001271] RAX: 00000000ffff9491 RBX: ffff949179f30c00 RCX: 0000000000000000
[   97.001272] RDX: 0000000000000001 RSI: 00000000ffff9491 RDI: ffff9490777dca04
[   97.001272] RBP: ffff9490777dca08 R08: 0000000000025f80 R09: ffffffffc01db0ed
[   97.001273] R10: ffffbab781dabe30 R11: 0000000000000001 R12: ffff949176c2a220
[   97.001273] R13: ffff9490777dca04 R14: ffff94917950edc8 R15: ffff9490777dca08
[   97.001277]  ? venus_close+0x9d/0xd0 [coda]
[   97.001280]  _raw_spin_lock+0x1d/0x20
[   97.001281]  coda_release+0x66/0xd0 [coda]
[   97.001285]  __fput+0xe2/0x210
[   97.001287]  task_work_run+0x86/0xa0
[   97.001289]  do_exit+0x2d7/0xb30
[   97.001292]  ? handle_mm_fault+0xfa/0x200
[   97.001293]  do_group_exit+0x3a/0xa0
[   97.001294]  __x64_sys_exit_group+0x14/0x20
[   97.001296]  do_syscall_64+0x55/0x100
[   97.001298]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   97.001299] RIP: 0033:0x453988
[   97.001302] Code: Bad RIP value.
[   97.001302] RSP: 002b:00007ffcd39246a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   97.001303] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000453988
[   97.001304] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   97.001304] RBP: 00000000005a79b0 R08: 00000000000000e7 R09: ffffffffffffffe0
[   97.001305] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000001
[   97.001305] R13: 00000000007c1640 R14: 00000000005a0fc1 R15: 0000000000000000
