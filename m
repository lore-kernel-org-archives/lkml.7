Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86D9C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DF820844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfGJUNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:13:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49227 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfGJUNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:13:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D3203805EE; Wed, 10 Jul 2019 22:13:00 +0200 (CEST)
Date:   Wed, 10 Jul 2019 22:13:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
        Andrew Morton <akpm@osdl.org>
Subject: next-20190708: kernel BUG at lib/lockref.c:189, softlockups in
 shrink_dcache...?
Message-ID: <20190710201311.GA8519@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm getting some nastyness from lockref / memory management.

Any ideas? Any ideas who to talk to?

									Pavel



[    0.000000] Linux version 5.2.0-next-20190708+ (pavel@pollux.denx.de) (g=
cc version 9.1.1 20190503 (Red Hat 9.1.1-1) (GCC)) #55 SMP Wed Jul 10 09:30=
:51 CEST 2019
[    0.000000] Disabled fast string operations
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
=2E..
[ 5347.093378] wlan0: authenticate with 5c:f4:ab:10:d2:bb
[ 5347.093511] wlan0: send auth to 5c:f4:ab:10:d2:bb (try 1/3)
[ 5347.096461] wlan0: authenticated
[ 5347.100328] wlan0: associate with 5c:f4:ab:10:d2:bb (try 1/3)
[ 5347.103232] wlan0: RX AssocResp from 5c:f4:ab:10:d2:bb (capab=3D0x411 st=
atus=3D0 aid=3D2)
[ 5347.105009] wlan0: associated
[ 6552.596393] ------------[ cut here ]------------
[ 6552.596412] kernel BUG at lib/lockref.c:189!
[ 6552.596433] invalid opcode: 0000 [#1] SMP PTI
[ 6552.596442] CPU: 0 PID: 8494 Comm: Chrome_ProcessL Not tainted 5.2.0-nex=
t-20190708+ #55
[ 6552.596447] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 )=
 03/31/2011
[ 6552.596463] EIP: lockref_mark_dead+0x10/0x20
[ 6552.596471] Code: c0 01 be 01 00 00 00 89 43 20 89 d8 e8 f9 5d 93 00 89 =
f0 5b 5e 5d c3 8d 76 00 8b 10 85 d2 74 0a c7 40 20 80 ff ff ff c3 66 90 <0f=
> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 89 c2 83 e0 0f c0
[ 6552.596478] EAX: ef4b7830 EBX: ef4b77d8 ECX: 00000001 EDX: 00000000
[ 6552.596484] ESI: e647a3f0 EDI: ef4b7830 EBP: d9bfde0c ESP: d9bfddfc
[ 6552.596491] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[ 6552.596497] CR0: 80050033 CR2: 071e03d0 CR3: 203e2000 CR4: 000006b0
[ 6552.596502] Call Trace:
[ 6552.596515]  ? __dentry_kill+0x1f/0x160
[ 6552.596524]  shrink_dcache_parent+0xb0/0x110
[ 6552.596532]  d_invalidate+0x48/0xc0
[ 6552.596541]  proc_flush_task+0x78/0x150
[ 6552.596552]  release_task+0x4f/0x450
[ 6552.596560]  wait_consider_task+0x7c9/0x850
[ 6552.596568]  do_wait+0x11b/0x230
[ 6552.596575]  kernel_wait4+0x8b/0x130
[ 6552.596583]  ? task_stopped_code+0x40/0x40
[ 6552.596590]  sys_waitpid+0x13/0x15
[ 6552.596597]  do_int80_syscall_32+0x4b/0xf0
[ 6552.596608]  entry_INT80_32+0x110/0x110
[ 6552.596614] EIP: 0xb7f8cc42
[ 6552.596621] Code: 65 8b 15 04 00 00 00 8b 0e 8b 0c ca 83 f9 ff 75 0c 89 =
04 24 89 f0 e8 b3 fe ff ff eb 05 8b 46 04 01 c8 83 c4 14 5b 5e c3 cd 80 <c3=
> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
[ 6552.596628] EAX: ffffffda EBX: 0000212d ECX: 00000000 EDX: 00000000
[ 6552.596635] ESI: 8aec3b40 EDI: 09004d20 EBP: 8aec3158 ESP: 8aec3110
[ 6552.596641] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000293
[ 6552.596647] Modules linked in:
[ 6552.596658] ---[ end trace 8058c26986d91112 ]---
[ 6552.596667] EIP: lockref_mark_dead+0x10/0x20
[ 6552.596674] Code: c0 01 be 01 00 00 00 89 43 20 89 d8 e8 f9 5d 93 00 89 =
f0 5b 5e 5d c3 8d 76 00 8b 10 85 d2 74 0a c7 40 20 80 ff ff ff c3 66 90 <0f=
> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 89 c2 83 e0 0f c0
[ 6552.596681] EAX: ef4b7830 EBX: ef4b77d8 ECX: 00000001 EDX: 00000000
[ 6552.596687] ESI: e647a3f0 EDI: ef4b7830 EBP: d9bfde0c ESP: d9bfddfc
[ 6552.596693] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[ 6552.596700] CR0: 80050033 CR2: 071e03d0 CR3: 203e2000 CR4: 000006b0
[ 6580.173598] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [WorkerPoo=
l/7703:7703]
[ 6580.173608] Modules linked in:
[ 6580.173620] CPU: 1 PID: 7703 Comm: WorkerPool/7703 Tainted: G      D    =
       5.2.0-next-20190708+ #55
[ 6580.173626] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 )=
 03/31/2011
[ 6580.173642] EIP: queued_spin_lock_slowpath+0x40/0x1d0
[ 6580.173651] Code: f0 0f ba 29 08 0f 92 c2 8b 01 0f b6 d2 c1 e2 08 30 e4 =
09 d0 a9 00 01 ff ff 75 27 85 c0 74 13 8b 01 84 c0 74 0d 8d 74 26 00 90 <f3=
> 90 8b 01 84 c0 75 f8 b8 01 00 00 00 66 89 01 c3 8d b4 26 00 00
[ 6580.173658] EAX: 00000101 EBX: e647a448 ECX: e647a448 EDX: 00000000
[ 6580.173664] ESI: ddd18358 EDI: e647a448 EBP: eefe1b44 ESP: eefe1b3c
[ 6580.173671] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000202
[ 6580.173678] CR0: 80050033 CR2: 0a0e4748 CR3: 203e2000 CR4: 000006b0
[ 6580.173684] Call Trace:
[ 6580.173694]  ? do_raw_spin_lock+0xb9/0xc0
[ 6580.173705]  _raw_spin_lock+0x22/0x30
[ 6580.173715]  ? shrink_lock_dentry.part.0+0x9f/0xf0
[ 6580.173723]  shrink_lock_dentry.part.0+0x9f/0xf0
[ 6580.173731]  shrink_dentry_list+0x27/0x100
[ 6580.173739]  prune_dcache_sb+0x42/0x60
[ 6580.173747]  ? d_lru_shrink_move+0x50/0x50
[ 6580.173755]  super_cache_scan+0xc9/0x160
[ 6580.173763]  shrink_slab.constprop.0+0x1ae/0x390
[ 6580.173772]  shrink_node+0x7b1/0x9d0
[ 6580.173781]  do_try_to_free_pages+0xa1/0x250
[ 6580.173788]  ? do_try_to_free_pages+0xa1/0x250
[ 6580.173795]  try_to_free_pages+0x15e/0x430
[ 6580.173805]  __alloc_pages_nodemask+0x44d/0xd00
[ 6580.173816]  wp_page_copy+0x67/0x680
[ 6580.173825]  do_wp_page+0x75/0x450
[ 6580.173833]  ? _raw_spin_lock+0x22/0x30
[ 6580.173840]  handle_mm_fault+0x598/0xbd3
[ 6580.173848]  ? __lock_acquire.isra.0+0x2b8/0x4f0
[ 6580.173858]  __do_page_fault+0x15e/0x410
[ 6580.173865]  ? vmalloc_sync_all+0x220/0x220
[ 6580.173872]  do_page_fault+0x24/0x137
[ 6580.173879]  ? vmalloc_sync_all+0x220/0x220
[ 6580.173886]  common_exception+0x166/0x16e
[ 6580.173892] EIP: 0x8cad20
[ 6580.173899] Code: a8 73 5b fe 89 4c 24 04 c7 44 24 08 76 00 00 00 c7 04 =
24 01 00 00 00 89 44 24 4c e8 4a 98 ff ff 8b 44 24 4c 8b 4c 24 48 89 31 <89=
> 7e 04 e9 84 02 00 00 89 7c 24 08 89 44 24 04 89 34 24 e8 a8 ea
[ 6580.173907] EAX: 0f6c1230 EBX: 08d83524 ECX: 08fbc8c0 EDX: fffffb9b
[ 6580.173913] ESI: 0f85a000 EDI: fffffb9b EBP: b2af35d8 ESP: b2af30b0
[ 6580.173920] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010246
[ 6608.173599] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [WorkerPoo=
l/7703:7703]
[ 6608.173607] Modules linked in:
[ 6608.173619] CPU: 1 PID: 7703 Comm: WorkerPool/7703 Tainted: G      D    =
  L    5.2.0-next-20190708+ #55
[ 6608.173624] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 )=
 03/31/2011
[ 6608.173640] EIP: queued_spin_lock_slowpath+0x44/0x1d0
[ 6608.173648] Code: 08 0f 92 c2 8b 01 0f b6 d2 c1 e2 08 30 e4 09 d0 a9 00 =
01 ff ff 75 27 85 c0 74 13 8b 01 84 c0 74 0d 8d 74 26 00 90 f3 90 8b 01 <84=
> c0 75 f8 b8 01 00 00 00 66 89 01 c3 8d b4 26 00 00 00 00 f6 c4
[ 6608.173655] EAX: 00000101 EBX: e647a448 ECX: e647a448 EDX: 00000000
[ 6608.173661] ESI: ddd18358 EDI: e647a448 EBP: eefe1b44 ESP: eefe1b3c
[ 6608.173668] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000202
[ 6608.173675] CR0: 80050033 CR2: 0a0e4748 CR3: 203e2000 CR4: 000006b0
[ 6608.173680] Call Trace:
[ 6608.173690]  ? do_raw_spin_lock+0xb9/0xc0
[ 6608.173701]  _raw_spin_lock+0x22/0x30
[ 6608.173712]  ? shrink_lock_dentry.part.0+0x9f/0xf0
[ 6608.173719]  shrink_lock_dentry.part.0+0x9f/0xf0
[ 6608.173727]  shrink_dentry_list+0x27/0x100
[ 6608.173735]  prune_dcache_sb+0x42/0x60
[ 6608.173743]  ? d_lru_shrink_move+0x50/0x50
[ 6608.173751]  super_cache_scan+0xc9/0x160
[ 6608.173760]  shrink_slab.constprop.0+0x1ae/0x390
[ 6608.173768]  shrink_node+0x7b1/0x9d0
[ 6608.173777]  do_try_to_free_pages+0xa1/0x250
[ 6608.173784]  ? do_try_to_free_pages+0xa1/0x250
[ 6608.173791]  try_to_free_pages+0x15e/0x430
[ 6608.173801]  __alloc_pages_nodemask+0x44d/0xd00
[ 6608.173813]  wp_page_copy+0x67/0x680
[ 6608.173822]  do_wp_page+0x75/0x450
[ 6608.173829]  ? _raw_spin_lock+0x22/0x30
[ 6608.173836]  handle_mm_fault+0x598/0xbd3
[ 6608.173844]  ? __lock_acquire.isra.0+0x2b8/0x4f0
[ 6608.173854]  __do_page_fault+0x15e/0x410
[ 6608.173862]  ? vmalloc_sync_all+0x220/0x220
[ 6608.173869]  do_page_fault+0x24/0x137
[ 6608.173876]  ? vmalloc_sync_all+0x220/0x220
[ 6608.173883]  common_exception+0x166/0x16e
[ 6608.173889] EIP: 0x8cad20
[ 6608.173896] Code: a8 73 5b fe 89 4c 24 04 c7 44 24 08 76 00 00 00 c7 04 =
24 01 00 00 00 89 44 24 4c e8 4a 98 ff ff 8b 44 24 4c 8b 4c 24 48 89 31 <89=
> 7e 04 e9 84 02 00 00 89 7c 24 08 89 44 24 04 89 34 24 e8 a8 ea
[ 6608.173903] EAX: 0f6c1230 EBX: 08d83524 ECX: 08fbc8c0 EDX: fffffb9b
[ 6608.173909] ESI: 0f85a000 EDI: fffffb9b EBP: b2af35d8 ESP: b2af30b0
[ 6608.173916] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010246
[ 6612.628114] rcu: INFO: rcu_sched self-detected stall on CPU
[ 6612.628114] rcu: 	1-....: (14999 ticks this GP) idle=3D07a/1/0x40000002 =
softirq=3D778997/778997 fqs=3D7465=20
[ 6612.628114] 	(t=3D15000 jiffies g=3D940129 q=3D41142)
[ 6612.628146] NMI backtrace for cpu 1
[ 6612.628146] CPU: 1 PID: 7703 Comm: WorkerPool/7703 Tainted: G      D    =
  L    5.2.0-next-20190708+ #55
[ 6612.628146] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 )=
 03/31/2011
[ 6612.628165] Call Trace:
[ 6612.628165]  dump_stack+0x47/0x5e
[ 6612.628165]  nmi_cpu_backtrace.cold+0x10/0x48
[ 6612.628165]  ? lapic_can_unplug_cpu.cold+0x3d/0x3d
[ 6612.628165]  nmi_trigger_cpumask_backtrace+0x8f/0x91
[ 6612.628165]  arch_trigger_cpumask_backtrace+0x10/0x20
[ 6612.628165]  rcu_dump_cpu_stacks+0x6a/0x90
[ 6612.628165]  rcu_sched_clock_irq.cold+0x18f/0x352
[ 6612.628165]  update_process_times+0x23/0x60
[ 6612.628165]  tick_sched_handle.isra.0+0x2e/0x60
[ 6612.628165]  tick_sched_timer+0x3c/0x90
[ 6612.628165]  ? tick_sched_handle.isra.0+0x60/0x60
[ 6612.628165]  __hrtimer_run_queues+0x105/0x2e0
[ 6612.628165]  ? tick_sched_handle.isra.0+0x60/0x60
[ 6612.628165]  hrtimer_interrupt+0x10e/0x260
[ 6612.628165]  smp_apic_timer_interrupt+0x68/0x160
[ 6612.628165]  apic_timer_interrupt+0x11b/0x120
[ 6612.628165] EIP: queued_spin_lock_slowpath+0x42/0x1d0
[ 6612.628165] Code: ba 29 08 0f 92 c2 8b 01 0f b6 d2 c1 e2 08 30 e4 09 d0 =
a9 00 01 ff ff 75 27 85 c0 74 13 8b 01 84 c0 74 0d 8d 74 26 00 90 f3 90 <8b=
> 01 84 c0 75 f8 b8 01 00 00 00 66 89 01 c3 8d b4 26 00 00 00 00
[ 6612.628165] EAX: 00000101 EBX: e647a448 ECX: e647a448 EDX: 00000000
[ 6612.628165] ESI: ddd18358 EDI: e647a448 EBP: eefe1b44 ESP: eefe1b3c
[ 6612.628165] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000202
[ 6612.628165]  ? queued_spin_lock_slowpath+0x42/0x1d0
[ 6612.628165]  ? do_raw_spin_lock+0xb9/0xc0
[ 6612.628165]  _raw_spin_lock+0x22/0x30
[ 6612.628165]  ? shrink_lock_dentry.part.0+0x9f/0xf0
[ 6612.628165]  shrink_lock_dentry.part.0+0x9f/0xf0
[ 6612.628165]  shrink_dentry_list+0x27/0x100
[ 6612.628165]  prune_dcache_sb+0x42/0x60
[ 6612.628165]  ? d_lru_shrink_move+0x50/0x50
[ 6612.628165]  super_cache_scan+0xc9/0x160
[ 6612.628165]  shrink_slab.constprop.0+0x1ae/0x390
[ 6612.628165]  shrink_node+0x7b1/0x9d0
[ 6612.628165]  do_try_to_free_pages+0xa1/0x250
[ 6612.628165]  ? do_try_to_free_pages+0xa1/0x250
[ 6612.628165]  try_to_free_pages+0x15e/0x430
[ 6612.628165]  __alloc_pages_nodemask+0x44d/0xd00
[ 6612.628165]  wp_page_copy+0x67/0x680
[ 6612.628165]  do_wp_page+0x75/0x450
[ 6612.628165]  ? _raw_spin_lock+0x22/0x30
[ 6612.628165]  handle_mm_fault+0x598/0xbd3
[ 6612.628165]  ? __lock_acquire.isra.0+0x2b8/0x4f0
[ 6612.628165]  __do_page_fault+0x15e/0x410
[ 6612.628165]  ? vmalloc_sync_all+0x220/0x220
[ 6612.628165]  do_page_fault+0x24/0x137
[ 6612.628165]  ? vmalloc_sync_all+0x220/0x220
[ 6612.628165]  common_exception+0x166/0x16e
[ 6612.628165] EIP: 0x8cad20
[ 6612.628165] Code: a8 73 5b fe 89 4c 24 04 c7 44 24 08 76 00 00 00 c7 04 =
24 01 00 00 00 89 44 24 4c e8 4a 98 ff ff 8b 44 24 4c 8b 4c 24 48 89 31 <89=
> 7e 04 e9 84 02 00 00 89 7c 24 08 89 44 24 04 89 34 24 e8 a8 ea
[ 6612.628165] EAX: 0f6c1230 EBX: 08d83524 ECX: 08fbc8c0 EDX: fffffb9b
[ 6612.628165] ESI: 0f85a000 EDI: fffffb9b EBP: b2af35d8 ESP: b2af30b0
[ 6612.628165] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010246




--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0mRtcACgkQMOfwapXb+vKeegCgl0FATEDnjbLvn8/vaQxNadcj
2KYAnRAZzh/D06fLj5m6EGTz0jo6egZv
=U67j
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
