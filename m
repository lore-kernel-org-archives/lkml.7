Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9CFC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9922A20848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEPHNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 03:13:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:65127 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfEPHNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:13:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 00:13:46 -0700
X-ExtLoop1: 1
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga006.fm.intel.com with ESMTP; 16 May 2019 00:13:43 -0700
Date:   Thu, 16 May 2019 15:14:05 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: eb9d1bf079 [   88.881528] EIP: _random_read
Message-ID: <20190516071405.GO31424@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit eb9d1bf079bb438d1a066d72337092935fc770f6
Author:     Theodore Ts'o <tytso@mit.edu>
AuthorDate: Wed Feb 20 16:06:38 2019 -0500
Commit:     Theodore Ts'o <tytso@mit.edu>
CommitDate: Wed Apr 17 10:30:21 2019 -0400

    random: only read from /dev/random after its pool has received 128 bits
    
    Immediately after boot, we allow reads from /dev/random before its
    entropy pool has been fully initialized.  Fix this so that we don't
    allow this until the blocking pool has received 128 bits.
    
    We do this by repurposing the initialized flag in the entropy pool
    struct, and use the initialized flag in the blocking pool to indicate
    whether it is safe to pull from the blocking pool.
    
    To do this, we needed to rework when we decide to push entropy from the
    input pool to the blocking pool, since the initialized flag for the
    input pool was used for this purpose.  To simplify things, we no
    longer use the initialized flag for that purpose, nor do we use the
    entropy_total field any more.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

764ed189c8  drivers/char/random.c: make primary_crng static
eb9d1bf079  random: only read from /dev/random after its pool has received 128 bits
814137768b  Add gitignore file for samples/vfs/ generated files
+---------------------------------------------------------+------------+------------+------------+
|                                                         | 764ed189c8 | eb9d1bf079 | 814137768b |
+---------------------------------------------------------+------------+------------+------------+
| boot_successes                                          | 3035       | 2712       | 2036       |
| boot_failures                                           | 915        | 887        | 656        |
| BUG:kernel_hang_in_boot-around-mounting-root_stage      | 818        | 720        | 457        |
| BUG:kernel_timeout_in_boot-around-mounting-root_stage   | 55         | 51         | 63         |
| BUG:soft_lockup-CPU##stuck_for#s                        | 26         | 23         | 24         |
| EIP:separate_adjacent_colors                            | 14         | 15         | 5          |
| Kernel_panic-not_syncing:softlockup:hung_tasks          | 25         | 101        | 119        |
| EIP:rb_next                                             | 7          | 3          | 5          |
| EIP:igt_color                                           | 1          |            |            |
| EIP:rb_prev                                             | 2          | 3          | 2          |
| Mem-Info                                                | 17         | 15         | 15         |
| EIP:drm_mm_insert_node_in_range                         | 2          | 1          | 4          |
| invoked_oom-killer:gfp_mask=0x                          | 1          |            |            |
| Out_of_memory_and_no_killable_processes                 | 1          |            |            |
| Kernel_panic-not_syncing:System_is_deadlocked_on_memory | 1          |            |            |
| EIP:__slab_alloc                                        | 0          | 1          |            |
| EIP:debug_lockdep_rcu_enabled                           | 0          | 8          | 16         |
| EIP:lock_is_held_type                                   | 0          | 41         | 63         |
| EIP:_random_read                                        | 0          | 14         | 12         |
| EIP:___might_sleep                                      | 0          | 11         | 7          |
| EIP:xfer_secondary_pool                                 | 0          | 1          |            |
| EIP:rcu_read_lock_sched_held                            | 0          | 3          | 3          |
| BUG:kernel_reboot-without-warning_in_test_stage         | 0          | 0          | 2          |
| EIP:__might_sleep                                       | 0          | 0          | 2          |
+---------------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

01 00 00 00 60 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 ff ef ff ff 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 47 31 f7 0f 00 00 00 00 1b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00 ac 88 ea 0d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
02 00 00 00 70 00 00 00 37 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 33 c5 01 00 00 00 00 00 00 00 20 00 00 00 00 00 ff ff 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 ff ff 00 00 
00 00 00 00 00 00 00 00 00 00 
[   88.862983] irq event stamp: 294320
[   88.864335] hardirqs last  enabled at (294319): [<c2801237>] trace_hardirqs_on_thunk+0xc/0x10
[   88.867241] hardirqs last disabled at (294320): [<c2801247>] trace_hardirqs_off_thunk+0xc/0x10
[   88.870159] softirqs last  enabled at (290628): [<c2f59cc7>] __do_softirq+0x287/0x2b5
[   88.872933] softirqs last disabled at (290617): [<c2813e32>] do_softirq_own_stack+0x1c/0x22
[   88.875826] CPU: 0 PID: 904 Comm: trinity-c0 Not tainted 5.1.0-rc5-00004-geb9d1bf #196
[   88.878665] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   88.881528] EIP: _random_read+0xa7/0x31f
[   88.882986] Code: 75 e9 ff 0d 4c 32 30 c3 ff 05 4c 32 30 c3 a1 dc 8c 51 c3 e8 99 30 c2 ff 85 c0 74 2d 80 3d 01 30 51 c3 00 75 24 e8 94 3e c2 ff <85> c0 75 1b b9 7c b8 1c c3 ba 05 01 00 00 b8 90 6c 24 c3 c6 05 01
[   88.888325] EAX: 00000001 EBX: 00000000 ECX: 00000000 EDX: dc525140
[   88.890136] ESI: ffc02100 EDI: c2c591aa EBP: dc365f68 ESP: dc365f1c
[   88.892016] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00000202
[   88.893927] CR0: 80050033 CR2: 08c99024 CR3: 1c355000 CR4: 003406d0
[   88.895775] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   88.897651] DR6: fffe0ff0 DR7: 00000400
[   88.899080] Call Trace:
[   88.900279]  ? __wake_up_locked_key+0x17/0x17
[   88.901827]  sys_getrandom+0x35/0x70
[   88.903244]  ? lockdep_hardirqs_on+0x148/0x163
[   88.904810]  do_int80_syscall_32+0x4f/0x116
[   88.906344]  entry_INT80_32+0xe1/0xe1
[   88.907738] EIP: 0x809af42
[   88.908995] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 ec bd a7 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 14 be a7 08 85
[   88.914344] EAX: ffffffda EBX: b6f59000 ECX: 001d2000 EDX: 00000002
[   88.916234] ESI: 484b29b7 EDI: ffffff5c EBP: 00200000 ESP: bf88ed58
[   88.918112] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   88.920091] Kernel panic - not syncing: softlockup: hung tasks
[   88.921900] CPU: 0 PID: 904 Comm: trinity-c0 Tainted: G             L    5.1.0-rc5-00004-geb9d1bf #196
[   88.925004] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   88.927916] Call Trace:
[   88.929120]  <IRQ>
[   88.930261]  dump_stack+0x16/0x18
[   88.931622]  panic+0x9f/0x20e
[   88.932931]  watchdog_timer_fn+0x1db/0x200
[   88.934461]  __hrtimer_run_queues+0x1a0/0x297
[   88.936198]  ? __touch_watchdog+0x15/0x15
[   88.937690]  hrtimer_run_queues+0xd1/0xe6
[   88.939177]  run_local_timers+0x8/0x2e
[   88.940582]  update_process_times+0x1b/0x43
[   88.942084]  tick_nohz_handler+0xb2/0xfe
[   88.943558]  timer_interrupt+0xd/0x14
[   88.944965]  __handle_irq_event_percpu+0x9f/0x1ad
[   88.946577]  ? trace_hardirqs_off+0xa3/0xa9
[   88.948079]  handle_irq_event_percpu+0x17/0x3d
[   88.949584]  handle_irq_event+0x29/0x42
[   88.951018]  ? irq_set_chip_and_handler_name+0x24/0x24
[   88.952706]  handle_level_irq+0x82/0xae
[   88.954156]  handle_irq+0x73/0x95
[   88.955492]  </IRQ>
[   88.956648]  do_IRQ+0x36/0x92
[   88.957913]  ? sys_getrandom+0x35/0x70
[   88.959343]  common_interrupt+0xeb/0xf0
[   88.960769] EIP: _random_read+0xa7/0x31f
[   88.962202] Code: 75 e9 ff 0d 4c 32 30 c3 ff 05 4c 32 30 c3 a1 dc 8c 51 c3 e8 99 30 c2 ff 85 c0 74 2d 80 3d 01 30 51 c3 00 75 24 e8 94 3e c2 ff <85> c0 75 1b b9 7c b8 1c c3 ba 05 01 00 00 b8 90 6c 24 c3 c6 05 01
[   88.967549] EAX: 00000001 EBX: 00000000 ECX: 00000000 EDX: dc525140
[   88.969410] ESI: ffc02100 EDI: c2c591aa EBP: dc365f68 ESP: dc365f1c
[   88.971305] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00000202
[   88.973236]  ? sys_getrandom+0x35/0x70
[   88.974648]  ? autoconfig_16550a+0x241/0x4bd
[   88.976201]  ? __wake_up_locked_key+0x17/0x17
[   88.977724]  sys_getrandom+0x35/0x70
[   88.979094]  ? lockdep_hardirqs_on+0x148/0x163
[   88.980534]  do_int80_syscall_32+0x4f/0x116
[   88.981918]  entry_INT80_32+0xe1/0xe1
[   88.983196] EIP: 0x809af42
[   88.984358] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 ec bd a7 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 14 be a7 08 85
[   88.989303] EAX: ffffffda EBX: b6f59000 ECX: 001d2000 EDX: 00000002
[   88.990988] ESI: 484b29b7 EDI: ffffff5c EBP: 00200000 ESP: bf88ed58
[   88.992737] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   88.994519] Kernel Offset: 0x1800000 from 0xc1000000 (relocation range: 0xc0000000-0xe07dffff)


                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 724086ae5682c612e822727bae3efe01ae13cc41 e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd --
git bisect  bad 87b53080376c675a80ea63b58b9f22670dbb970d  # 01:07  B    200     3    0  88  Merge 'drm-drm-misc/drm-misc-next-fixes' into devel-hourly-2019051401
git bisect  bad 35d593de37a3dc1bb758fa091b5f318cb9fb22e3  # 01:07  B    178     5    0 131  Merge 'jpirko-mlxsw/shalomt_ptp' into devel-hourly-2019051401
git bisect  bad a9fe71b64b806000437b97ead2b436cd194e7449  # 01:07  B    195     5    0 234  Merge 'linux-review/Dan-Carpenter/drm-i915-gvt-Fix-an-error-code-in-ppgtt_populate_spt_by_guest_entry/20190514-001803' into devel-hourly-2019051401
git bisect good 9381a094625c169860695287c827468a18031b43  # 01:38  G    903     0  206 306  Merge 'ljones-mfd/ib-mfd-pinctrl-5.2-2' into devel-hourly-2019051401
git bisect  bad 947a45eff9cae803662bb9e7126e94689ff742eb  # 01:38  B    169     4    0 268  Merge 'block/io_uring-next' into devel-hourly-2019051401
git bisect  bad 80f232121b69cc69a31ccb2b38c1665d770b0710  # 01:39  B    167     5    0 293  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good e0dccbdf5ac7ccb9da5612100dedba302f3ebcfe  # 02:08  G    903     0  174 255  Merge tag 'staging-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good 5f0d736e7f7db586141f974821b6ca6c1d906d5b  # 02:42  G    900     0  176 247  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect good 5abe37954e9a315c35c9490f78d55f307c3c636b  # 03:17  G    901     0  190 313  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect good 6ffe0acc935f344eb0b35da07c034d5122222e77  # 03:50  G    901     0  195 299  Merge tag 'wireless-drivers-next-for-davem-2019-05-03' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next
git bisect good 54516da1ea859dd4f56ebba2e483d2df9d7c8a32  # 04:18  G    905     0  166 255  Merge branch 'r8169-replace-some-magic-with-more-speaking-functions'
git bisect good 23bfaa594002f4bba085e0a1ae3c9847b988d816  # 04:54  G    904     0  196 297  net: phy: improve pause mode reporting in phy_print_status
git bisect  bad 82efe439599439a5e1e225ce5740e6cfb777a7dd  # 04:54  B    167     7    0 136  Merge tag 'devicetree-for-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect good 6f7dc9a37f2b325fc870d1e1ada6169185f8852c  # 05:27  G    906     0  199 299  of: irq: Remove WARN_ON() for kzalloc() failure
git bisect good a9fbcd6728837268784439ad0b02ede2c024c516  # 05:40  G    900     0   50 353  Merge tag 'fscrypt_for_linus' of git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt
git bisect  bad d55535232c3dbde9a523a9d10d68670f5fe5dec3  # 05:44  B    223     1    8 145  random: move rand_initialize() earlier
git bisect good 3bd0b5bf7dc3ea02070fcbcd682ecf628269e8ef  # 07:13  G    910     0  311 726  drivers/char/random.c: remove unused stuct poolinfo::poolbits
git bisect  bad eb9d1bf079bb438d1a066d72337092935fc770f6  # 07:35  B     14     1    5   5  random: only read from /dev/random after its pool has received 128 bits
git bisect good 764ed189c82090c1d85f0e30636156736d8f09a8  # 08:59  G    902     0  276 630  drivers/char/random.c: make primary_crng static
# first bad commit: [eb9d1bf079bb438d1a066d72337092935fc770f6] random: only read from /dev/random after its pool has received 128 bits
git bisect good 764ed189c82090c1d85f0e30636156736d8f09a8  # 09:17  G   1001     0   85 754  drivers/char/random.c: make primary_crng static
# extra tests with debug options
git bisect  bad eb9d1bf079bb438d1a066d72337092935fc770f6  # 09:33  B      1     1    0   0  random: only read from /dev/random after its pool has received 128 bits
# extra tests on HEAD of linux-devel/devel-hourly-2019051401
git bisect  bad 724086ae5682c612e822727bae3efe01ae13cc41  # 09:33  B     77     2    0  35  0day head guard for 'devel-hourly-2019051401'
# extra tests on tree/branch linus/master
git bisect  bad 814137768b5a9504f758aa760e7b1ac355539783  # 11:55  B    115     1   43 345  Add gitignore file for samples/vfs/ generated files
# extra tests with first bad commit reverted
git bisect good 63fc3aff16bb767e89202696f7be3f56252fc091  # 18:34  G    901     0  233 586  Revert "random: only read from /dev/random after its pool has received 128 bits"
# extra tests on tree/branch linux-next/master

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--F4+N/OgRSdC8YnqX
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-122:20190515074044:i386-randconfig-n0-201919:5.1.0-rc5-00004-geb9d1bf:196.gz"
Content-Transfer-Encoding: base64

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
/wP45R+n2DYBAA==

--F4+N/OgRSdC8YnqX
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-vm-openwrt-201:20190515081710:i386-randconfig-n0-201919:5.1.0-rc5-00003-g764ed18:202.gz"
Content-Transfer-Encoding: base64

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
/Un05EgTdE3+9eUtXe78HyZhepVWkAAA

--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vm-yocto-122:20190515074044:i386-randconfig-n0-201919:5.1.0-rc5-00004-geb9d1bf:196"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.1.0-rc5-00004-geb9d1bf"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.1.0-rc5 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
CONFIG_PVH=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
CONFIG_MGEODEGX1=y
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=4
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_ANCIENT_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=m
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ACPI_IPMI=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
# CONFIG_CPU_IDLE_GOV_MENU is not set
CONFIG_CPU_IDLE_GOV_TEO=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
CONFIG_OLPC_XO15_SCI=y
# CONFIG_ALIX is not set
CONFIG_NET5501=y
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_ASN1=m
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
# CONFIG_CONNECTOR is not set
CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
# CONFIG_GNSS_MTK_SERIAL is not set
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
CONFIG_MTD_CMDLINE_PARTS=m
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_AR7_PARTS=m

#
# Partition parsers
#
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
CONFIG_FTL=m
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=m
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
CONFIG_MTD_MAP_BANK_WIDTH_32=y
CONFIG_MTD_CFI_I1=y
# CONFIG_MTD_CFI_I2 is not set
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=m
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
# CONFIG_MTD_ONENAND_GENERIC is not set
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_NAND_ECC=m
CONFIG_MTD_NAND_ECC_SMC=y
# CONFIG_MTD_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_SPI_MTK_QUADSPI is not set
CONFIG_SPI_INTEL_SPI=m
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_UBI_BLOCK=y
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=m
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=m
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=m
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=y

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_VOP=m
CONFIG_VHOST_RING=m
CONFIG_ECHO=m
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_IDE_LEGACY=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
# CONFIG_IDE_GD_ATA is not set
CONFIG_IDE_GD_ATAPI=y
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEACPI=y
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=m
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_IDEPNP is not set

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_CS5536 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set

#
# Other IDE chipsets support
#

#
# Note: most of these also require special kernel boot parameters
#
CONFIG_BLK_DEV_4DRIVES=y
# CONFIG_BLK_DEV_ALI14XX is not set
CONFIG_BLK_DEV_DTC2278=y
# CONFIG_BLK_DEV_HT6560B is not set
CONFIG_BLK_DEV_QD65XX=y
CONFIG_BLK_DEV_UMC8672=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=m
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_FLASHPOINT is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
CONFIG_SCSI_GENERIC_NCR5380=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
CONFIG_SCSI_QLOGIC_FAS=m
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
# CONFIG_ATA_ACPI is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=m
CONFIG_AHCI_CEVA=m
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=m
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_NI65 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SMB is not set
# CONFIG_RMI4_F03 is not set
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_OLPC_APSP=y
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=m
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_LDISC_AUTOLOAD is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DW=m
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=m
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_TIMBERDALE=m
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=m
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=m
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=y
CONFIG_DTLK=m
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
CONFIG_MWAVE=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=m
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=m
CONFIG_RANDOM_TRUST_CPU=y

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=m
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_DEMUX_PINCTRL is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_FSI is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
# CONFIG_DW_I3C_MASTER is not set
# CONFIG_SPI is not set
CONFIG_SPMI=m
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AXP209=m
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_PALMAS is not set
# CONFIG_PINCTRL_RK805 is not set
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=y
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=y
# CONFIG_PINCTRL_LEWISBURG is not set
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=m
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_SAMA5D2_PIOBU=m
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_ADNP=m
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_LP873X=m
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_STMPE=y
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TQMX86=m
# CONFIG_GPIO_TWL4030 is not set
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_WM831X=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=m
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=m
# CONFIG_BATTERY_OLPC is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9030=m
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=m
# CONFIG_CHARGER_AXP20X is not set
CONFIG_BATTERY_AXP20X=m
# CONFIG_AXP20X_POWER is not set
CONFIG_AXP288_FUEL_GAUGE=m
CONFIG_BATTERY_MAX17040=m
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
# CONFIG_BATTERY_TWL4030_MADC is not set
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_BATTERY_RX51 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_TWL4030=m
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_LP8788=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=m
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_OCC_P8_I2C=m
CONFIG_SENSORS_OCC=y
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=m
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
CONFIG_GPIO_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG_ARCH_INITCALL is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
# CONFIG_MENZ069_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_MLX_WDT=m
CONFIG_CADENCE_WATCHDOG=m
# CONFIG_DW_WATCHDOG is not set
CONFIG_RN5T618_WATCHDOG=y
# CONFIG_TWL4030_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=m
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=m
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=m
CONFIG_SBC7240_WDT=m
CONFIG_CPU5_WDT=m
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=m
CONFIG_TQMX86_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_NI903X_WDT=m
CONFIG_NIC7018_WDT=m
CONFIG_MEN_A21_WDT=y

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=m
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=m
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
# CONFIG_PCF50633_GPIO is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=m
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=m
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=m
# CONFIG_MFD_STPMIC1 is not set
CONFIG_RAVE_SP_CORE=m
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=m
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD718XX=m
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9063=m
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_HI6421=y
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LOCHNAGAR=m
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LP8788=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=m
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=m
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_RK808=y
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65132=m
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_TPS80031 is not set
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=m
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=y
# CONFIG_RC_MAP is not set
CONFIG_LIRC=y
# CONFIG_BPF_LIRC_MODE2 is not set
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_HIX5HD2 is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
CONFIG_IR_FINTEK=y
CONFIG_IR_NUVOTON=y
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=y
CONFIG_IR_GPIO_CIR=m
# CONFIG_IR_GPIO_TX is not set
CONFIG_IR_PWM_TX=y
CONFIG_IR_SERIAL=y
# CONFIG_IR_SERIAL_TRANSMITTER is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CEC_RC=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_FWNODE=y
CONFIG_DVB_CORE=y
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y
# CONFIG_VIDEO_IR_I2C is not set

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=m
# CONFIG_VIDEO_MSP3400 is not set
CONFIG_VIDEO_CS3308=y
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=y
CONFIG_VIDEO_BT819=y
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=m
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=y
# CONFIG_VIDEO_AD5820 is not set
CONFIG_VIDEO_SAA7110=m
# CONFIG_VIDEO_SAA711X is not set
CONFIG_VIDEO_TVP514X=m
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_TW9910=m
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=y

#
# Camera sensor devices
#
CONFIG_VIDEO_OV9640=m
CONFIG_VIDEO_MT9M111=y

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=y
# CONFIG_VIDEO_I2C is not set

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_SIMPLE is not set
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
# CONFIG_MEDIA_TUNER_TDA9887 is not set
CONFIG_MEDIA_TUNER_TEA5761=y
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=m
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
# CONFIG_MEDIA_TUNER_MXL5005S is not set
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_MC44S803=y
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
# CONFIG_MEDIA_TUNER_FC0012 is not set
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=m
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=y
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_STB0899 is not set
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=m
# CONFIG_DVB_STV6111 is not set
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24123=y
# CONFIG_DVB_MT312 is not set
CONFIG_DVB_ZL10036=y
# CONFIG_DVB_ZL10039 is not set
CONFIG_DVB_S5H1420=y
# CONFIG_DVB_STV0288 is not set
# CONFIG_DVB_STB6000 is not set
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV6110=y
# CONFIG_DVB_STV0900 is not set
# CONFIG_DVB_TDA8083 is not set
CONFIG_DVB_TDA10086=y
# CONFIG_DVB_TDA8261 is not set
CONFIG_DVB_VES1X93=y
# CONFIG_DVB_TUNER_ITD1000 is not set
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=m
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=y
# CONFIG_DVB_TS2020 is not set
CONFIG_DVB_DS3000=m
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
CONFIG_DVB_SP887X=y
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=y
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=y
# CONFIG_DVB_MT352 is not set
# CONFIG_DVB_ZL10353 is not set
# CONFIG_DVB_DIB3000MB is not set
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=y
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
# CONFIG_DVB_EC100 is not set
# CONFIG_DVB_STV0367 is not set
# CONFIG_DVB_CXD2820R is not set
# CONFIG_DVB_CXD2841ER is not set
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=y
# CONFIG_DVB_OR51132 is not set
# CONFIG_DVB_BCM3510 is not set
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=y
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_S921 is not set
# CONFIG_DVB_DIB8000 is not set
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=y
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
# CONFIG_DVB_A8293 is not set
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=y
# CONFIG_DVB_TDA665x is not set
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_M88RS2000=y
# CONFIG_DVB_AF9033 is not set
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ASCOT2E=y
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=y

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=m
CONFIG_DRM_PANEL_LVDS=y
CONFIG_DRM_PANEL_SIMPLE=m
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_DUMB_VGA_DAC is not set
# CONFIG_DRM_LVDS_ENCODER is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=m
# CONFIG_DRM_SII9234 is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
CONFIG_DRM_TOSHIBA_TC358764=m
# CONFIG_DRM_TOSHIBA_TC358767 is not set
# CONFIG_DRM_TI_TFP410 is not set
CONFIG_DRM_TI_SN65DSI86=m
CONFIG_DRM_I2C_ADV7511=m
CONFIG_DRM_I2C_ADV7533=y
CONFIG_DRM_I2C_ADV7511_CEC=y
# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
CONFIG_FB_N411=m
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=m
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_APPLE=y
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_LP8788=m
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_RAVE_SP is not set
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
CONFIG_HID_COUGAR=m
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=m
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=m
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MALTRON=m
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=m
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m

#
# I2C HID support
#
CONFIG_I2C_HID=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
CONFIG_MMC=m
# CONFIG_PWRSEQ_EMMC is not set
# CONFIG_PWRSEQ_SIMPLE is not set
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=m
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_GOLDFISH is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AN30259A=m
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_BCM6328=m
CONFIG_LEDS_BCM6358=m
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=m
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_PWM=m
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77693=m
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=m
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_IS31FL319X=m
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
# CONFIG_LEDS_TRIGGER_AUDIO is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_A11Y_BRAILLE_CONSOLE is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=m
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=m
# CONFIG_RTC_DRV_LP8788 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_RK808=m
CONFIG_RTC_DRV_RS5C372=m
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=m
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=y
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_TWL4030=m
# CONFIG_RTC_DRV_PALMAS is not set
# CONFIG_RTC_DRV_TPS80031 is not set
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV3028=y
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_S5M=m
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9063=m
# CONFIG_RTC_DRV_STK17TA8 is not set
CONFIG_RTC_DRV_M48T86=m
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m
CONFIG_RTC_DRV_WM831X=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=m
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=m
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_MT6397 is not set
CONFIG_RTC_DRV_R7301=m

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_STAGING=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
CONFIG_COMEDI_TEST=y
# CONFIG_COMEDI_PARPORT is not set
# CONFIG_COMEDI_SSV_DNP is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
# CONFIG_FB_OLPC_DCON is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#

#
# Analog to digital converters
#

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_I2C=m

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
CONFIG_AD7746=m

#
# Direct Digital Synthesis
#

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set

#
# Resolver to digital converters
#
# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
CONFIG_SPEAKUP=y
# CONFIG_SPEAKUP_SYNTH_ACNTSA is not set
CONFIG_SPEAKUP_SYNTH_ACNTPC=m
CONFIG_SPEAKUP_SYNTH_APOLLO=y
CONFIG_SPEAKUP_SYNTH_AUDPTR=y
# CONFIG_SPEAKUP_SYNTH_BNS is not set
CONFIG_SPEAKUP_SYNTH_DECTLK=m
CONFIG_SPEAKUP_SYNTH_DECEXT=m
# CONFIG_SPEAKUP_SYNTH_DECPC is not set
CONFIG_SPEAKUP_SYNTH_DTLK=y
# CONFIG_SPEAKUP_SYNTH_KEYPC is not set
CONFIG_SPEAKUP_SYNTH_LTLK=y
CONFIG_SPEAKUP_SYNTH_SOFT=m
CONFIG_SPEAKUP_SYNTH_SPKOUT=y
CONFIG_SPEAKUP_SYNTH_TXPRT=m
CONFIG_SPEAKUP_SYNTH_DUMMY=m
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_STAGING_BOARD is not set
# CONFIG_GOLDFISH_AUDIO is not set
CONFIG_GS_FPGABOOT=m
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
# CONFIG_MOST_NET is not set
CONFIG_MOST_VIDEO=y
CONFIG_MOST_DIM2=y
CONFIG_MOST_I2C=m
# CONFIG_KS7010 is not set
CONFIG_GREYBUS=m
# CONFIG_GREYBUS_BOOTROM is not set
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_PWM=m
CONFIG_GREYBUS_SDIO=m
CONFIG_GREYBUS_UART=m
# CONFIG_DRM_VBOXVIDEO is not set

#
# Gasket devices
#
CONFIG_XIL_AXIS_FIFO=y
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
# CONFIG_EROFS_FS_POSIX_ACL is not set
# CONFIG_EROFS_FS_SECURITY is not set
CONFIG_EROFS_FS_USE_VM_MAP_RAM=y
CONFIG_EROFS_FAULT_INJECTION=y
CONFIG_EROFS_FS_IO_MAX_RETRIES=5
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
# CONFIG_EROFS_FS_ZIP_NO_CACHE is not set
CONFIG_EROFS_FS_ZIP_CACHE_UNIPOLAR=y
# CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
# CONFIG_MLXREG_IO is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=m
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
CONFIG_MAILBOX_TEST=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=y
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_PALMAS=y
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=m
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=m
# CONFIG_DA311 is not set
CONFIG_DMARD06=m
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD7291=m
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=m
CONFIG_AXP20X_ADC=m
# CONFIG_AXP288_ADC is not set
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=m
CONFIG_ENVELOPE_DETECTOR=m
CONFIG_HX711=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
# CONFIG_LTC2497 is not set
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=m
CONFIG_MCP3422=m
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
# CONFIG_PALMAS_GPADC is not set
CONFIG_QCOM_VADC_COMMON=m
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_QCOM_SPMI_ADC5 is not set
CONFIG_SD_ADC_MODULATOR=m
CONFIG_STMPE_ADC=m
CONFIG_TI_ADC081C=m
CONFIG_TI_ADS1015=m
CONFIG_TI_AM335X_ADC=m
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
CONFIG_VF610_ADC=m

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set

#
# Amplifiers
#

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_CCS811=m
# CONFIG_IAQCORE is not set
CONFIG_PMS7003=m
CONFIG_SPS30=m
CONFIG_VZ89X=m

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#

#
# Digital to analog converters
#
CONFIG_AD5064=m
# CONFIG_AD5380 is not set
# CONFIG_AD5446 is not set
CONFIG_AD5592R_BASE=m
CONFIG_AD5593R=m
CONFIG_AD5686=m
CONFIG_AD5696_I2C=m
CONFIG_DPOT_DAC=m
# CONFIG_DS4424 is not set
CONFIG_M62332=m
CONFIG_MAX517=m
CONFIG_MAX5821=m
CONFIG_MCP4725=m
CONFIG_TI_DAC5571=m
# CONFIG_VF610_DAC is not set

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
CONFIG_MAX30100=m
CONFIG_MAX30102=m

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
CONFIG_HDC100X=m
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
CONFIG_SI7005=m
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m

#
# Light sensors
#
CONFIG_ACPI_ALS=m
# CONFIG_ADJD_S311 is not set
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_JSA1212=m
# CONFIG_RPR0521 is not set
CONFIG_LTR501=m
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
CONFIG_MAX44009=m
CONFIG_OPT3001=m
CONFIG_PA12203001=m
CONFIG_SI1133=m
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=m
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
# CONFIG_VCNL4035 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_MAG3110=m
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m

#
# Multiplexers
#
CONFIG_IIO_MUX=m

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
CONFIG_AD5272=m
CONFIG_DS1803=m
# CONFIG_MCP4018 is not set
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=m

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_HP03=m
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=m
# CONFIG_MS5611 is not set
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
# CONFIG_SX9500 is not set
CONFIG_SRF08=m
CONFIG_VL53L0X_I2C=m

#
# Resolver to digital converters
#

#
# Temperature sensors
#
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
CONFIG_TMP006=m
CONFIG_TMP007=m
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LPSS=y
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_PCA9685=y
CONFIG_PWM_STMPE=y
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=m
# CONFIG_FMC_TRIVIAL is not set
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_CADENCE_DP=y
CONFIG_PHY_CADENCE_DPHY=m
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_POWERCAP is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
CONFIG_RAVE_SP_EEPROM=m

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=m
CONFIG_STM_PROTO_SYS_T=y
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=m
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# CONFIG_FPGA is not set
CONFIG_FSI=m
# CONFIG_FSI_NEW_DEV_NODE is not set
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=m
# CONFIG_FSI_SCOM is not set
# CONFIG_FSI_SBEFIFO is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_GPIO=m
# CONFIG_MUX_MMIO is not set
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=m

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
CONFIG_BEFS_FS=m
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=m
CONFIG_EFS_FS=y
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_SQUASHFS is not set
CONFIG_VXFS_FS=m
# CONFIG_MINIX_FS is not set
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=m
CONFIG_PSTORE_LZO_COMPRESS=m
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_RAM is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=m
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=m
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity"
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=m
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=m
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_AUTHENC is not set
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_AEGIS128L=m
CONFIG_CRYPTO_AEGIS256=m
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=m
# CONFIG_CRYPTO_SHA1 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
CONFIG_CRC4=m
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=m
CONFIG_BCH_CONST_PARAMS=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=m
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
# CONFIG_FONT_MINI_4x6 is not set
CONFIG_FONT_6x10=y
CONFIG_FONT_10x18=y
CONFIG_FONT_SUN8x16=y
# CONFIG_FONT_SUN12x22 is not set
CONFIG_FONT_TER16x32=y
CONFIG_SG_POOL=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=y
CONFIG_STRING_SELFTEST=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

--F4+N/OgRSdC8YnqX--
