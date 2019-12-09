Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C6CC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBD22077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLISYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:24:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:35680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfLISYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:24:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F969AD17;
        Mon,  9 Dec 2019 18:24:19 +0000 (UTC)
Date:   Mon, 9 Dec 2019 19:24:18 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: lockdep warns: cpu_hotplug_lock.rw_sem --> slab_mutex -->
 kn->count#39
Message-ID: <20191209182418.7vxer6vmre67ewvt@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I observed following warning from lockdep triggerd by 'slabinfo -d'
right after boot. There is nothing funky running in background, it's a
minimal rootfs created with buildroot.

Kernel version: v5.5.0-rc1
Kernel config for x86_64: defconfig + kvmconfig + lockdep + debug locks

# slabinfo -d
Acpi-Namespace not empty cannot disable sanity checks
Acpi-Namespace not empty cannot disable redzoning
Acpi-Operand not empty cannot disable sanity checks
Acpi-Operand not empty cannot disable redzoning
[    5.033027] 
[    5.033173] ======================================================
[    5.033712] WARNING: possible circular locking dependency detected
[    5.034250] 5.5.0-rc1 #11 Not tainted
[    5.034572] ------------------------------------------------------
[    5.035108] slabinfo/136 is trying to acquire lock:
[    5.035541] ffffffff8265eff0 (cpu_hotplug_lock.rw_sem){++++}, at: kmem_cache_shrink_all+0x9/0x20
[    5.036313] 
[    5.036313] but task is already holding lock:
[    5.036833] ffff88803cec63f8 (kn->count#39){++++}, at: kernfs_fop_write+0x9b/0x1b0
[    5.037500] 
[    5.037500] which lock already depends on the new lock.
[    5.037500] 
[    5.038208] 
[    5.038208] the existing dependency chain (in reverse order) is:
[    5.038862] 
[    5.038862] -> #2 (kn->count#39){++++}:
[    5.039329]        __kernfs_remove+0x240/0x2e0
[    5.039717]        kernfs_remove_by_name_ns+0x3c/0x80
[    5.040159]        sysfs_slab_add+0x184/0x250
[    5.040551]        __kmem_cache_create+0x37c/0x410
[    5.040969]        kmem_cache_create_usercopy+0x150/0x270
[    5.041442]        kmem_cache_create+0xd/0x10
[    5.041831]        i915_global_scheduler_init+0x1e/0x7c
[    5.042289]        i915_globals_init+0xf/0x95
[    5.042668]        i915_init+0x8/0x5d
[    5.042988]        do_one_initcall+0x58/0x29f
[    5.043375]        kernel_init_freeable+0x1ae/0x238
[    5.043804]        kernel_init+0x5/0xf7
[    5.044139]        ret_from_fork+0x27/0x50
[    5.044499] 
[    5.044499] -> #1 (slab_mutex){+.+.}:
[    5.044950]        __mutex_lock+0x86/0x900
[    5.045310]        kmem_cache_create_usercopy+0x32/0x270
[    5.045768]        kmem_cache_create+0xd/0x10
[    5.046146]        ptlock_cache_init+0x1b/0x23
[    5.046534]        start_kernel+0x21f/0x4f4
[    5.046898]        secondary_startup_64+0xb6/0xc0
[    5.047309] 
[    5.047309] -> #0 (cpu_hotplug_lock.rw_sem){++++}:
[    5.047849]        __lock_acquire+0xe2f/0x19f0
[    5.048233]        lock_acquire+0x95/0x180
[    5.048604]        cpus_read_lock+0x26/0x90
[    5.048970]        kmem_cache_shrink_all+0x9/0x20
[    5.049386]        shrink_store+0xe/0x20
[    5.049730]        slab_attr_store+0x1b/0x30
[    5.050103]        kernfs_fop_write+0xca/0x1b0
[    5.050494]        vfs_write+0xb4/0x1a0
[    5.050830]        ksys_write+0x63/0xe0
[    5.051165]        do_syscall_64+0x4b/0x1e0
[    5.051533]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    5.052012] 
[    5.052012] other info that might help us debug this:
[    5.052012] 
[    5.052707] Chain exists of:
[    5.052707]   cpu_hotplug_lock.rw_sem --> slab_mutex --> kn->count#39
[    5.052707] 
[    5.053629]  Possible unsafe locking scenario:
[    5.053629] 
[    5.054137]        CPU0                    CPU1
[    5.054529]        ----                    ----
[    5.054922]   lock(kn->count#39);
[    5.055211]                                lock(slab_mutex);
[    5.055695]                                lock(kn->count#39);
[    5.056195]   lock(cpu_hotplug_lock.rw_sem);
[    5.056580] 
[    5.056580]  *** DEADLOCK ***
[    5.056580] 
[    5.057087] 3 locks held by slabinfo/136:
[    5.057439]  #0: ffff88803c151480 (sb_writers#7){.+.+}, at: vfs_write+0x13b/0x1a0
[    5.058078]  #1: ffff88803c1a7890 (&of->mutex){+.+.}, at: kernfs_fop_write+0x93/0x1b0
[    5.058745]  #2: ffff88803cec63f8 (kn->count#39){++++}, at: kernfs_fop_write+0x9b/0x1b0
[    5.059426] 
[    5.059426] stack backtrace:
[    5.059803] CPU: 0 PID: 136 Comm: slabinfo Not tainted 5.5.0-rc1 #11
[    5.060349] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[    5.061320] Call Trace:
[    5.061538]  dump_stack+0x71/0xa0
[    5.061829]  check_noncircular+0x176/0x190
[    5.062193]  __lock_acquire+0xe2f/0x19f0
[    5.062542]  lock_acquire+0x95/0x180
[    5.062856]  ? kmem_cache_shrink_all+0x9/0x20
[    5.063236]  cpus_read_lock+0x26/0x90
[    5.063555]  ? kmem_cache_shrink_all+0x9/0x20
[    5.063931]  kmem_cache_shrink_all+0x9/0x20
[    5.064296]  shrink_store+0xe/0x20
[    5.064604]  slab_attr_store+0x1b/0x30
[    5.064931]  kernfs_fop_write+0xca/0x1b0
[    5.065273]  vfs_write+0xb4/0x1a0
[    5.065564]  ksys_write+0x63/0xe0
[    5.065855]  do_syscall_64+0x4b/0x1e0
[    5.066175]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    5.066610] RIP: 0033:0x45c283
[    5.066877] Code: ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[    5.068456] RSP: 002b:00007ffd3d486908 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[    5.069106] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 000000000045c283
[    5.069728] RDX: 0000000000000002 RSI: 0000000002342360 RDI: 0000000000000003
[    5.070347] RBP: 0000000002342360 R08: 0000000000000000 R09: 0000000000000002
[    5.070964] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[    5.071574] R13: 000000000234a3a0 R14: 0000000000000002 R15: 00000000004c6ec0
Cannot write to Acpi-Parse/sanity

Thanks,
Daniel
