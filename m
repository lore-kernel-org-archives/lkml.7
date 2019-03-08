Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57187C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34A42081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfCHEtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:49:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:2837 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfCHEtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:49:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 20:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,454,1544515200"; 
   d="gz'50?scan'50,208,50";a="325316058"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Mar 2019 20:49:01 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h27RM-0007KE-Vg; Fri, 08 Mar 2019 12:49:00 +0800
Date:   Fri, 08 Mar 2019 12:48:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: 669de8bda8 ("kernel/workqueue: Use dynamic lockdep keys for .."):  WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:995 lockdep_register_key
Message-ID: <5c81f407.dqtEdGUmHMiobjjO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5c81f407.Xoc3zNPUo9Efi5DmWHsjHEi7u5SwXPl4WqViNhJN3Q4OvOuP"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5c81f407.Xoc3zNPUo9Efi5DmWHsjHEi7u5SwXPl4WqViNhJN3Q4OvOuP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 669de8bda87b92ab9a2fc663b3f5743c2ad1ae9f
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu Feb 14 15:00:54 2019 -0800
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Thu Feb 28 07:55:47 2019 +0100

    kernel/workqueue: Use dynamic lockdep keys for workqueues
    
    The following commit:
    
      87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing")
    
    improved deadlock checking in the workqueue implementation. Unfortunately
    that patch also introduced a few false positive lockdep complaints.
    
    This patch suppresses these false positives by allocating the workqueue mutex
    lockdep key dynamically.
    
    An example of a false positive lockdep complaint suppressed by this patch
    can be found below. The root cause of the lockdep complaint shown below
    is that the direct I/O code can call alloc_workqueue() from inside a work
    item created by another alloc_workqueue() call and that both workqueues
    share the same lockdep key. This patch avoids that that lockdep complaint
    is triggered by allocating the work queue lockdep keys dynamically.
    
    In other words, this patch guarantees that a unique lockdep key is
    associated with each work queue mutex.
    
      ======================================================
      WARNING: possible circular locking dependency detected
      4.19.0-dbg+ #1 Not tainted
      fio/4129 is trying to acquire lock:
      00000000a01cfe1a ((wq_completion)"dio/%s"sb->s_id){+.+.}, at: flush_workqueue+0xd0/0x970
    
      but task is already holding lock:
      00000000a0acecf9 (&sb->s_type->i_mutex_key#14){+.+.}, at: ext4_file_write_iter+0x154/0x710
    
      which lock already depends on the new lock.
    
      the existing dependency chain (in reverse order) is:
    
      -> #2 (&sb->s_type->i_mutex_key#14){+.+.}:
             down_write+0x3d/0x80
             __generic_file_fsync+0x77/0xf0
             ext4_sync_file+0x3c9/0x780
             vfs_fsync_range+0x66/0x100
             dio_complete+0x2f5/0x360
             dio_aio_complete_work+0x1c/0x20
             process_one_work+0x481/0x9f0
             worker_thread+0x63/0x5a0
             kthread+0x1cf/0x1f0
             ret_from_fork+0x24/0x30
    
      -> #1 ((work_completion)(&dio->complete_work)){+.+.}:
             process_one_work+0x447/0x9f0
             worker_thread+0x63/0x5a0
             kthread+0x1cf/0x1f0
             ret_from_fork+0x24/0x30
    
      -> #0 ((wq_completion)"dio/%s"sb->s_id){+.+.}:
             lock_acquire+0xc5/0x200
             flush_workqueue+0xf3/0x970
             drain_workqueue+0xec/0x220
             destroy_workqueue+0x23/0x350
             sb_init_dio_done_wq+0x6a/0x80
             do_blockdev_direct_IO+0x1f33/0x4be0
             __blockdev_direct_IO+0x79/0x86
             ext4_direct_IO+0x5df/0xbb0
             generic_file_direct_write+0x119/0x220
             __generic_file_write_iter+0x131/0x2d0
             ext4_file_write_iter+0x3fa/0x710
             aio_write+0x235/0x330
             io_submit_one+0x510/0xeb0
             __x64_sys_io_submit+0x122/0x340
             do_syscall_64+0x71/0x220
             entry_SYSCALL_64_after_hwframe+0x49/0xbe
    
      other info that might help us debug this:
    
      Chain exists of:
        (wq_completion)"dio/%s"sb->s_id --> (work_completion)(&dio->complete_work) --> &sb->s_type->i_mutex_key#14
    
       Possible unsafe locking scenario:
    
             CPU0                    CPU1
             ----                    ----
        lock(&sb->s_type->i_mutex_key#14);
                                     lock((work_completion)(&dio->complete_work));
                                     lock(&sb->s_type->i_mutex_key#14);
        lock((wq_completion)"dio/%s"sb->s_id);
    
       *** DEADLOCK ***
    
      1 lock held by fio/4129:
       #0: 00000000a0acecf9 (&sb->s_type->i_mutex_key#14){+.+.}, at: ext4_file_write_iter+0x154/0x710
    
      stack backtrace:
      CPU: 3 PID: 4129 Comm: fio Not tainted 4.19.0-dbg+ #1
      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
      Call Trace:
       dump_stack+0x86/0xc5
       print_circular_bug.isra.32+0x20a/0x218
       __lock_acquire+0x1c68/0x1cf0
       lock_acquire+0xc5/0x200
       flush_workqueue+0xf3/0x970
       drain_workqueue+0xec/0x220
       destroy_workqueue+0x23/0x350
       sb_init_dio_done_wq+0x6a/0x80
       do_blockdev_direct_IO+0x1f33/0x4be0
       __blockdev_direct_IO+0x79/0x86
       ext4_direct_IO+0x5df/0xbb0
       generic_file_direct_write+0x119/0x220
       __generic_file_write_iter+0x131/0x2d0
       ext4_file_write_iter+0x3fa/0x710
       aio_write+0x235/0x330
       io_submit_one+0x510/0xeb0
       __x64_sys_io_submit+0x122/0x340
       do_syscall_64+0x71/0x220
       entry_SYSCALL_64_after_hwframe+0x49/0xbe
    
    Signed-off-by: Bart Van Assche <bvanassche@acm.org>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Johannes Berg <johannes.berg@intel.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Tejun Heo <tj@kernel.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Waiman Long <longman@redhat.com>
    Cc: Will Deacon <will.deacon@arm.com>
    Link: https://lkml.kernel.org/r/20190214230058.196511-20-bvanassche@acm.org
    [ Reworked the changelog a bit. ]
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

108c14858b  locking/lockdep: Add support for dynamic keys
669de8bda8  kernel/workqueue: Use dynamic lockdep keys for workqueues
f90d64483e  Merge tag 'usb-5.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
cf08baa296  Add linux-next specific files for 20190306
+--------------------------------------------------------------+------------+------------+------------+---------------+
|                                                              | 108c14858b | 669de8bda8 | f90d64483e | next-20190306 |
+--------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                               | 2811       | 2636       | 865        | 73            |
| boot_failures                                                | 15         | 31         | 8          | 1             |
| INFO:task_blocked_for_more_than#seconds                      | 10         |            |            |               |
| Kernel_panic-not_syncing:hung_task:blocked_tasks             | 10         |            |            |               |
| invoked_oom-killer:gfp_mask=0x                               | 5          | 1          | 3          |               |
| Mem-Info                                                     | 5          | 1          | 3          |               |
| WARNING:at_kernel/locking/lockdep.c:#lockdep_register_key/0x | 0          | 30         | 5          | 1             |
| EIP:lockdep_register_key                                     | 0          | 30         | 5          | 1             |
| EIP:__get_user_4                                             | 0          | 1          |            |               |
| Out_of_memory:Kill_process                                   | 0          | 1          |            |               |
+--------------------------------------------------------------+------------+------------+------------+---------------+

[    1.855169] spin_lock-torture: lock_torture_stats task started
[    2.565387] workingset: timestamp_bits=14 max_order=17 bucket_order=3
[    2.567522] NFS: Registering the id_resolver key type
[    2.568478] Key type id_resolver registered
[    2.569072] Key type id_legacy registered
[    2.570808] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:995 lockdep_register_key+0x37/0x386
[    2.571658] CPU: 0 PID: 1 Comm: swapper Not tainted 5.0.0-rc8-00054-g669de8b #496
[    2.571658] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    2.571658] EIP: lockdep_register_key+0x37/0x386
[    2.571658] Code: 20 45 65 94 01 83 15 24 45 65 94 00 81 fe 00 00 80 92 72 2e 81 fe 00 d0 88 95 73 26 83 05 40 45 65 94 01 83 15 44 45 65 94 00 <0f> 0b 83 05 48 45 65 94 01 83 15 4c 45 65 94 00 83 c4 1c 5b 5e 5f
[    2.571658] EAX: 9586d254 EBX: 9586d1c0 ECX: 944f9cd8 EDX: 00000000
[    2.571658] ESI: 9586d254 EDI: 9586d274 EBP: 975a9ee4 ESP: 975a9ebc
[    2.571658] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210246
[    2.571658] CR0: 80050033 CR2: 00000000 CR3: 1c4a5000 CR4: 00340690
[    2.571658] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    2.571658] DR6: fffe0ff0 DR7: 00000400
[    2.571658] Call Trace:
[    2.571658]  ? debug_mutex_init+0x4b/0x63
[    2.571658]  ? __mutex_init+0x59/0x6c
[    2.571658]  alloc_workqueue+0x227/0x84e
[    2.571658]  ? proc_create+0x3e/0x52
[    2.571658]  ? trace_event_define_fields_smb3_rw_err_class+0x1b9/0x1b9
[    2.571658]  init_cifs+0x159/0x72f
[    2.571658]  do_one_initcall+0x2c4/0x6bf
[    2.571658]  kernel_init_freeable+0x6ef/0x841
[    2.571658]  ? rest_init+0x473/0x473
[    2.571658]  kernel_init+0x1e/0x26b
[    2.571658]  ? schedule_tail_wrapper+0x9/0xc
[    2.571658]  ret_from_fork+0x1e/0x28
[    2.571658] irq event stamp: 410062
[    2.571658] hardirqs last  enabled at (410061): [<93a2ac73>] _raw_spin_unlock_irqrestore+0x133/0x17e
[    2.571658] hardirqs last disabled at (410062): [<92801bca>] trace_hardirqs_off_thunk+0xc/0x10
[    2.571658] softirqs last  enabled at (409970): [<93a2da14>] __do_softirq+0x904/0xa1d
[    2.571658] softirqs last disabled at (409965): [<92813eb9>] do_softirq_own_stack+0x3d/0x51
[    2.571658] ---[ end trace c4eabde80fbbdbf0 ]---
[    3.753943] String selftests succeeded

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start f32e0bde8ff712363cbfb98e9d2f90cfe98b208e 1c163f4c7b3f621efff9b28a47abb36f7378d783 --
git bisect  bad 086da5d945417d7f23267ba57285baf5f28db938  # 11:42  B    869     9    0  34  Merge 'linux-review/David-Ahern/selftests-rtnetlink-use-internal-netns-switch-for-ip-commands/20190301-033905' into devel-hourly-2019030702
git bisect good 41d8a6d69a8b740e03d7bf2bb8335da4da5fdba5  # 12:30  G    900     0   35  51  Merge 'linux-review/UPDATE-20190303-105904/Jan-Stancek/mm-memory-c-do_fault-avoid-usage-of-stale-vm_area_struct/20190303-093100' into devel-hourly-2019030702
git bisect  bad b9a411fadefdb5d73d8eea17ce986179ad71840d  # 12:50  B    148     1   10  10  Merge 'linux-review/Felix-Fietkau/mt76-rewrite-dma-descriptor-base-and-ring-size-on-queue-reset/20190302-050418' into devel-hourly-2019030702
git bisect  bad 0a6be0079c3c20149485bc92250e45d84d075541  # 13:06  B     57     1    7   7  Merge 'linux-review/Heiner-Kallweit/net-dsa-mv8e6xxx-fix-number-of-internal-PHYs-for-88E6x90-family/20190302-202650' into devel-hourly-2019030702
git bisect good 821ec529ff50b8937708f47f094287f6e2b49e16  # 13:52  G    909     0   50  50  Merge 'linux-review/Chao-Yu/f2fs-fix-to-do-sanity-check-with-inode-i_inline_xattr_size/20190304-203228' into devel-hourly-2019030702
git bisect good 67af7dacace3a333b1d881b95dc689a2dd9e2589  # 14:30  G    905     0   52  52  Merge 'linux-review/Kimberly-Brown/Drivers-hv-vmbus-Expose-monitor-data-only-when-monitor-pages-are-used/20190302-231508' into devel-hourly-2019030702
git bisect good 46f2ee728daf6a85ca1e353d4fafd9be2ce7ddfd  # 15:28  G    901     0   49  53  Merge 'linux-review/Yue-Haibing/net-sysfs-Fix-mem-leak-in-netdev_register_kobject/20190302-220141' into devel-hourly-2019030702
git bisect good 3f1a8f0976fe16a388c23feeb38a860caf826fa0  # 16:26  G    901     0   52  58  Merge 'linux-review/Yufen-Yu/hugetlbfs-fix-memory-leak-for-resv_map/20190302-214353' into devel-hourly-2019030702
git bisect good 8d8ae51f4bf9515ed07cb438037a129a0851bc60  # 17:22  G    901     0   49  58  Merge 'linux-review/Govind-Singh/ath10k-Modify-CE4-src-buffer-entries-to-2048-for-WCN3990/20190302-210221' into devel-hourly-2019030702
git bisect  bad 36d329873d82094062917361129c8ef95addbb65  # 17:45  B     73     1    6   6  Merge 'peterz-queue/locking/core' into devel-hourly-2019030702
git bisect good 0614621d89c43ea5b28456c2baf6b0c0e00ca81e  # 18:36  G    905     0   46  60  Merge branch 'linus' into locking/core, to pick up fixes
git bisect good a0b0fd53e1e67639b303b15939b9c653dbe7a8c4  # 19:32  G    900     0   50  63  locking/lockdep: Free lock classes that are no longer in use
git bisect good 108c14858b9ea224686e476c8f5ec345a0df9e27  # 20:31  G    908     0   43  53  locking/lockdep: Add support for dynamic keys
git bisect  bad f214737b75b0ee79763b5c058b9d5e83d711348d  # 21:06  B    101     1   11  19  lockdep/lib/tests: Test dynamic key registration
git bisect  bad d93ac78bf7b37db36fa00225f8e9a14c7ed1b2ba  # 21:53  B     44     1    3   3  lockdep/lib/tests: Fix run_tests.sh
git bisect  bad 669de8bda87b92ab9a2fc663b3f5743c2ad1ae9f  # 22:31  B    155     3   12  28  kernel/workqueue: Use dynamic lockdep keys for workqueues
# first bad commit: [669de8bda87b92ab9a2fc663b3f5743c2ad1ae9f] kernel/workqueue: Use dynamic lockdep keys for workqueues
git bisect good 108c14858b9ea224686e476c8f5ec345a0df9e27  # 23:11  G   1002     0    9  62  locking/lockdep: Add support for dynamic keys
# extra tests on HEAD of linux-devel/devel-hourly-2019030702
git bisect  bad f32e0bde8ff712363cbfb98e9d2f90cfe98b208e  # 23:11  B     10     2    0   1  0day head guard for 'devel-hourly-2019030702'
# extra tests on tree/branch linus/master
git bisect  bad f90d64483ebd394958841f67f8794ab203b319a7  # 23:53  B    468     1   22  22  Merge tag 'usb-5.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
# extra tests with first bad commit reverted
git bisect good f2abe7f085951f49dc69a634d74a4d027d77c9f7  # 12:42  G    907     0   55  55  Revert "kernel/workqueue: Use dynamic lockdep keys for workqueues"
# extra tests on tree/branch linux-next/master
git bisect  bad cf08baa29613dd899954089e7cc7dba1d478b365  # 12:46  B     11     1    0   0  Add linux-next specific files for 20190306

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5c81f407.Xoc3zNPUo9Efi5DmWHsjHEi7u5SwXPl4WqViNhJN3Q4OvOuP
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-openwrt-vm-openwrt-111:20190307222808:i386-randconfig-s1-201909:5.0.0-rc8-00054-g669de8b:496.gz"

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
KFn7HUwJzUSppQAA

--=_5c81f407.Xoc3zNPUo9Efi5DmWHsjHEi7u5SwXPl4WqViNhJN3Q4OvOuP
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-openwrt-vm-openwrt-216:20190307195050:i386-randconfig-s1-201909:5.0.0-rc8-00053-g108c148:480.gz"

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

--=_5c81f407.Xoc3zNPUo9Efi5DmWHsjHEi7u5SwXPl4WqViNhJN3Q4OvOuP
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-openwrt-vm-openwrt-111:20190307222808:i386-randconfig-s1-201909:5.0.0-rc8-00054-g669de8b:496"

#!/bin/bash

kernel=$1
initrd=openwrt-trinity-i386.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/openwrt/$initrd

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

--=_5c81f407.Xoc3zNPUo9Efi5DmWHsjHEi7u5SwXPl4WqViNhJN3Q4OvOuP
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.0.0-rc8-00054-g669de8b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.0.0-rc8 Kernel Configuration
#

#
# Compiler: gcc-6 (Debian 6.5.0-2) 6.5.0 20181026
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=60500
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CONSTRUCTORS=y
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
# CONFIG_SYSVIPC is not set
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
CONFIG_GENERIC_IRQ_DEBUGFS=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_PROFILING is not set
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
CONFIG_X86_32_LAZY_GS=y
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
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
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
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=7
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_16BIT is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
CONFIG_VMSPLIT_2G_OPT=y
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0x78000000
# CONFIG_X86_PAE is not set
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
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
# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
# CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
# CONFIG_GOOGLE_VPD is not set

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
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
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
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
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_4_7=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_CYC_COMPLEXITY=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
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
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
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
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
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
CONFIG_NET_PTP_CLASSIFY=y
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
CONFIG_DNS_RESOLVER=y
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
CONFIG_MAY_USE_DEVLINK=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
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
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_SIRF_SERIAL=y
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_MTD=y
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y

#
# User Modules And Translation Layers
#
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_SCx200_DOCFLASH=y
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_MCHP23K256=y
# CONFIG_MTD_SST25L is not set
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
# CONFIG_MTD_NAND is not set
CONFIG_MTD_SPI_NAND=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
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
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
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
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
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
# CONFIG_PCMCIA_NMCLAN is not set
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
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
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
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
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
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
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
# CONFIG_QCA7000_SPI is not set
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
# CONFIG_PCMCIA_SMC91C92 is not set
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
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
# CONFIG_MDIO_HISI_FEMAC is not set
# CONFIG_MDIO_MSCC_MIIM is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ASIX_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_ICPLUS_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
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
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

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
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_GOLDFISH_TTY is not set
CONFIG_DEVMEM=y
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
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
CONFIG_RANDOM_TRUST_CPU=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

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
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_PCA_ISA=y
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_FSI is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_GPIO=y
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AS3722 is not set
# CONFIG_PINCTRL_AXP209 is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_RK805 is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_SAMA5D2_PIOBU=y
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_LP87565 is not set
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_STMPE is not set
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_WM831X is not set
# CONFIG_GPIO_WM8350 is not set

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

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_ACT8945A is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_CHARGER_AXP20X is not set
# CONFIG_BATTERY_AXP20X is not set
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_MAX8997 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_MLXREG_FAN=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_OCC_P8_I2C=y
CONFIG_SENSORS_OCC=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
CONFIG_MFD_CS47L90=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
# CONFIG_AB3100_OTP is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
CONFIG_STMPE_SPI=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RK808=y
# CONFIG_REGULATOR_RN5T618 is not set
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_DVB_CORE=y
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Common Interface (EN50221) controller drivers
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
# CONFIG_DRM_DP_CEC is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
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
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
# CONFIG_PWRSEQ_SIMPLE is not set
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_AT91=y
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
CONFIG_MMC_SDHCI_CADENCE=y
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_GOLDFISH is not set
CONFIG_MMC_SPI=y
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MMC_SDHCI_OMAP=y
CONFIG_MMC_SDHCI_AM654=y
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
# CONFIG_LEDS_CLASS is not set

#
# LED drivers
#

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#

#
# LED Triggers
#
CONFIG_ACCESSIBILITY=y
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
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_AS3722 is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=y
CONFIG_RTC_DRV_MAX8997=y
CONFIG_RTC_DRV_RK808=y
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_ISL12026=y
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TPS6586X=y
# CONFIG_RTC_DRV_TPS65910 is not set
CONFIG_RTC_DRV_RC5T583=y
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
CONFIG_RTC_DRV_DS1305=y
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=y
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
# CONFIG_RTC_DRV_M48T59 is not set
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_PCF50633=y
# CONFIG_RTC_DRV_AB3100 is not set
CONFIG_RTC_DRV_ZYNQMP=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=y
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_MT6397 is not set
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_CHARLCD=y
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
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
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_VIRTIO=y
# CONFIG_SOUNDWIRE is not set

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
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
# CONFIG_ADIS16209 is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
CONFIG_BMA220=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=y
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7124=y
CONFIG_AD7266=y
# CONFIG_AD7291 is not set
CONFIG_AD7298=y
CONFIG_AD7476=y
# CONFIG_AD7766 is not set
CONFIG_AD7791=y
CONFIG_AD7793=y
CONFIG_AD7887=y
CONFIG_AD7923=y
CONFIG_AD7949=y
CONFIG_AD799X=y
CONFIG_AXP20X_ADC=y
CONFIG_AXP288_ADC=y
# CONFIG_CC10001_ADC is not set
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
CONFIG_LTC2471=y
CONFIG_LTC2485=y
CONFIG_LTC2497=y
CONFIG_MAX1027=y
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=y
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP320X=y
CONFIG_MCP3422=y
CONFIG_MCP3911=y
CONFIG_NAU7802=y
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
CONFIG_QCOM_SPMI_ADC5=y
CONFIG_SD_ADC_MODULATOR=y
CONFIG_STX104=y
CONFIG_TI_ADC081C=y
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
CONFIG_TI_ADC108S102=y
CONFIG_TI_ADC128S052=y
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8688 is not set
CONFIG_TI_TLC4541=y
# CONFIG_VF610_ADC is not set

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y

#
# Amplifiers
#
CONFIG_AD8366=y

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
CONFIG_VZ89X=y

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#
# CONFIG_104_QUAD_8 is not set

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5360=y
CONFIG_AD5380=y
CONFIG_AD5421=y
CONFIG_AD5446=y
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
# CONFIG_AD5592R is not set
CONFIG_AD5593R=y
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
CONFIG_LTC1660=y
CONFIG_LTC2632=y
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=y
CONFIG_AD5758=y
CONFIG_AD5761=y
CONFIG_AD5764=y
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_CIO_DAC is not set
# CONFIG_AD8801 is not set
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=y
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
CONFIG_MCP4922=y
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
CONFIG_TI_DAC7311=y
CONFIG_VF610_DAC=y

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=y
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
CONFIG_ADXRS450=y
# CONFIG_BMG160 is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=y
CONFIG_MAX30102=y

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16480=y
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=y
# CONFIG_IIO_ST_LSM6DSX is not set
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
# CONFIG_CM3323 is not set
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=y
# CONFIG_VEML6070 is not set
CONFIG_VL6180=y
# CONFIG_ZOPT2201 is not set

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set

#
# Multiplexers
#
CONFIG_IIO_MUX=y

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
CONFIG_MAX5481=y
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=y
CONFIG_MCP4531=y
# CONFIG_MCP41010 is not set
CONFIG_TPL0102=y

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
# CONFIG_MS5611_SPI is not set
CONFIG_MS5637=y
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
CONFIG_SX9500=y
CONFIG_SRF08=y
CONFIG_VL53L0X_I2C=y

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
# CONFIG_AD2S1200 is not set

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LP3943=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_STMPE is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_MADERA_IRQ=y
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_CADENCE_DP=y
CONFIG_PHY_CADENCE_SIERRA=y
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_ICE40_SPI=y
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=y
# CONFIG_FSI_SBEFIFO is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
# CONFIG_MUX_MMIO is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
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
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
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
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
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
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
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
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_AEGIS128L is not set
CONFIG_CRYPTO_AEGIS256=y
# CONFIG_CRYPTO_MORUS640 is not set
CONFIG_CRYPTO_MORUS1280=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
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
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
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
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_STACKDEPOT=y
CONFIG_STRING_SELFTEST=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
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
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_PREEMPTIRQ_EVENTS=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
# CONFIG_STACK_TRACER is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_DYNAMIC_FTRACE is not set
CONFIG_FUNCTION_PROFILER=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_TRACING_EVENTS_GPIO is not set
CONFIG_GCOV_PROFILE_FTRACE=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
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
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

--=_5c81f407.Xoc3zNPUo9Efi5DmWHsjHEi7u5SwXPl4WqViNhJN3Q4OvOuP--
