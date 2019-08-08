Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A78C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9790B2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbfHHH0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:26:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:34052 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbfHHHZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:25:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 00:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="gz'50?scan'50,208,50";a="258632316"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2019 00:25:47 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvcnz-000FbO-4R; Thu, 08 Aug 2019 15:25:47 +0800
Date:   Thu, 08 Aug 2019 15:25:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        philip.li@intel.com
Subject: 21871a99b3 ("of/platform: Pause/resume sync state during init
 .."):  WARNING: CPU: 0 PID: 1 at drivers/base/core.c:691
 device_links_supplier_sync_state_resume
Message-ID: <5d4bce76.Bu8zZv8tcbDqokLR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5d4bce76.bNkfcGyJKBduxV+JAqHuUzlJqtDSlARRLcXlVda/gqXkEOIU"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5d4bce76.bNkfcGyJKBduxV+JAqHuUzlJqtDSlARRLcXlVda/gqXkEOIU
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing

commit 21871a99b34c65c56a24193c277a4981529c306f
Author:     Saravana Kannan <saravanak@google.com>
AuthorDate: Wed Jul 31 15:17:18 2019 -0700
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Thu Aug 1 16:04:14 2019 +0200

    of/platform: Pause/resume sync state during init and of_platform_populate()
    
    When all the top level devices are populated from DT during kernel
    init, the supplier devices could be added and probed before the
    consumer devices are added and linked to the suppliers. To avoid the
    sync_state() callback from being called prematurely, pause the
    sync_state() callbacks before populating the devices and resume them
    at late_initcall_sync().
    
    Similarly, when children devices are populated after kernel init using
    of_platform_populate(), there could be supplier-consumer dependencies
    between the children devices that are populated. To avoid the same
    problem with sync_state() being called prematurely, pause and resume
    sync_state() callbacks across of_platform_populate().
    
    Signed-off-by: Saravana Kannan <saravanak@google.com>
    Link: https://lore.kernel.org/r/20190731221721.187713-6-saravanak@google.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

8f8184d6bf  driver core: Add sync_state driver/bus callback
21871a99b3  of/platform: Pause/resume sync state during init and of_platform_populate()
5adf578101  of/platform: Fix device_links_supplier_sync_state_resume() warning
3880be629e  Add linux-next specific files for 20190807
+-------------------------------------------------------------------------+------------+------------+------------+---------------+
|                                                                         | 8f8184d6bf | 21871a99b3 | 5adf578101 | next-20190807 |
+-------------------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                                          | 27         | 0          | 0          | 0             |
| boot_failures                                                           | 2          | 11         | 11         | 11            |
| WARNING:at_mm/usercopy.c:#usercopy_warn                                 | 1          |            |            |               |
| RIP:usercopy_warn                                                       | 1          |            |            |               |
| invoked_oom-killer:gfp_mask=0x                                          | 1          |            |            |               |
| Mem-Info                                                                | 1          |            |            |               |
| WARNING:at_drivers/base/core.c:#device_links_supplier_sync_state_resume | 0          | 11         | 11         | 11            |
| RIP:device_links_supplier_sync_state_resume                             | 0          | 11         | 11         | 11            |
+-------------------------------------------------------------------------+------------+------------+------------+---------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[   26.905004] i2c i2c-1: Added multiplexed i2c bus 3
[   26.917068] ### dt-test ### FAIL of_unittest_overlay_high_level():2380 overlay_base_root not initialized
[   26.920311] ### dt-test ### end of unittest - 219 passed, 1 failed
[   26.922504] ------------[ cut here ]------------
[   26.924102] Unmatched sync_state pause/resume!
[   26.924192] WARNING: CPU: 0 PID: 1 at drivers/base/core.c:691 device_links_supplier_sync_state_resume+0x140/0x160
[   26.929493] Modules linked in:
[   26.930681] CPU: 0 PID: 1 Comm: swapper Tainted: G                T 5.3.0-rc1-00025-g21871a99b34c6 #1
[   26.933665] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   26.936451] RIP: 0010:device_links_supplier_sync_state_resume+0x140/0x160
[   26.938611] Code: 84 c0 49 8d 84 24 c8 00 00 00 0f 85 48 ff ff ff 49 8d 94 24 d0 00 00 00 48 89 55 d0 eb 86 48 c7 c7 c0 30 be 83 e8 10 c0 e5 fe <0f> 0b 48 c7 c7 80 33 c4 84 e8 12 19 d0 00 48 83 c4 10 5b 41 5c 41
[   26.944420] RSP: 0018:ffff88801a397da8 EFLAGS: 00010286
[   26.946213] RAX: 0000000000000022 RBX: b05332a62e1f2e76 RCX: 0000000000000000
[   26.948487] RDX: 0000000000000022 RSI: ffffffff81276c83 RDI: 0000000000000246
[   26.950858] RBP: ffff88801a397de0 R08: fffffbfff0aa192d R09: fffffbfff0aa192d
[   26.953192] R10: ffff88801a397df0 R11: 0000000000000001 R12: 0000000000000000
[   26.955411] R13: 00000000ffffffff R14: 1ffff11003472fc3 R15: ffff88801a397eb8
[   26.957678] FS:  0000000000000000(0000) GS:ffffffff846b3000(0000) knlGS:0000000000000000
[   26.960398] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.962374] CR2: 00007fb42acb9480 CR3: 000000000462a006 CR4: 00000000001606f0
[   26.964683] Call Trace:
[   26.965713]  of_platform_sync_state_init+0x17/0x3a
[   26.967381]  ? of_core_init+0x16a/0x16a
[   26.968769]  do_one_initcall+0x103/0x295
[   26.970179]  ? trace_event_raw_event_initcall_finish+0x150/0x150
[   26.972130]  ? down_write+0xbe/0x100
[   26.973467]  ? __down_killable+0x260/0x260
[   26.974933]  ? __kasan_check_write+0x1f/0x30
[   26.976433]  kernel_init_freeable+0x232/0x349
[   26.978003]  ? rest_init+0xd0/0xd0
[   26.979274]  kernel_init+0xe/0x120
[   26.980580]  ? rest_init+0xd0/0xd0
[   26.981870]  ret_from_fork+0x24/0x30
[   26.983168] ---[ end trace fa753e8363323d3d ]---
[   26.991111] Freeing unused decrypted memory: 2040K

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start b1645c0cbd486ccebf76e0c3d4d2439f846316b0 609488bc979f99f805f34e9a32c1e3b71179d10b --
git bisect good 41f15b7fcd6a55ce02d7e4a353031a96f1df61b2  # 06:37  G     10     0    1   1  Merge remote-tracking branch 'mips/mips-next'
git bisect good 10cf4ad21d712fe3f90b187503661a5fa7163280  # 07:04  G     10     0    1   1  Merge remote-tracking branch 'input/next'
git bisect  bad d6c8a0a14a98ea15fe01c46a04d458d86655f489  # 07:52  B      0     2   18   0  Merge remote-tracking branch 'soundwire/next'
git bisect good ddcfc1ce636ad25269b027f2df88d171e96b4d91  # 09:07  G     11     0    1   1  Merge remote-tracking branch 'tip/auto-latest'
git bisect good 625cf0c4b86f06bd96e270862251fb2f3bd7a8bd  # 10:24  G     10     0    1   1  Merge remote-tracking branch 'leds/for-next'
git bisect  bad 093afe985f8ffd11b7b63289a70281c9fa66ce58  # 01:15  B      0     1   17   0  Merge remote-tracking branch 'usb/usb-next'
git bisect good dd0937eff2a7dc19716b1829cfac132049c51e46  # 19:38  G     10     0    2   2  Merge remote-tracking branch 'ipmi/for-next'
git bisect  bad 90bb1c44123da5b5d43335bc2f7c26407042c14a  # 20:22  B      0     3   19   0  Merge remote-tracking branch 'driver-core/driver-core-next'
git bisect good 134b23eec9e3a3c795a6ceb0efe2fa63e87983b2  # 22:50  G     11     0    3   3  driver core: Add edit_links() callback for drivers
git bisect  bad 97e2551de3f91add297c1dc4c9dc95297eaadf12  # 12:54  B      0     1   17   0  Merge tag 'dev_groups_all_drivers' into driver-core-next
git bisect  bad 21871a99b34c65c56a24193c277a4981529c306f  # 13:41  B      0     1   17   0  of/platform: Pause/resume sync state during init and of_platform_populate()
git bisect good 8f8184d6bf676a8680d6f441e40317d166b46f73  # 14:10  G     10     0    4   4  driver core: Add sync_state driver/bus callback
# first bad commit: [21871a99b34c65c56a24193c277a4981529c306f] of/platform: Pause/resume sync state during init and of_platform_populate()
git bisect good 8f8184d6bf676a8680d6f441e40317d166b46f73  # 14:22  G     30     0    5   9  driver core: Add sync_state driver/bus callback
# extra tests on HEAD of linux-next/master
git bisect  bad b1645c0cbd486ccebf76e0c3d4d2439f846316b0  # 14:22  B      1   368    0   0  Add linux-next specific files for 20190805
# extra tests on tree/branch driver-core/driver-core-testing
git bisect  bad 5adf5781019dd21233d6d13ab0d78bf03a13d4f1  # 14:48  B      0     3   19   0  of/platform: Fix device_links_supplier_sync_state_resume() warning
# extra tests on tree/branch linux-next/master
git bisect  bad 3880be629e26f6c407593602398c6651860d5fae  # 15:20  B      0     2   18   0  Add linux-next specific files for 20190807

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5d4bce76.bNkfcGyJKBduxV+JAqHuUzlJqtDSlARRLcXlVda/gqXkEOIU
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-vm-yocto-727f575ace46:20190808134247:x86_64-randconfig-s2-201931:5.3.0-rc1-00025-g21871a99b34c6:1.gz"

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
8/wjTk8CAA==

--=_5d4bce76.bNkfcGyJKBduxV+JAqHuUzlJqtDSlARRLcXlVda/gqXkEOIU
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-vm-yocto-0de3be9b49a0:20190808140903:x86_64-randconfig-s2-201931:5.3.0-rc1-00024-g8f8184d6bf676:1.gz"

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
OwIA

--=_5d4bce76.bNkfcGyJKBduxV+JAqHuUzlJqtDSlARRLcXlVda/gqXkEOIU
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-yocto-vm-yocto-727f575ace46:20190808134247:x86_64-randconfig-s2-201931:5.3.0-rc1-00025-g21871a99b34c6:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-x86_64.cgz

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
	-netdev user,id=net0,hostfwd=tcp::32032-:22
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

--=_5d4bce76.bNkfcGyJKBduxV+JAqHuUzlJqtDSlARRLcXlVda/gqXkEOIU
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.3.0-rc1-00025-g21871a99b34c6"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.3.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=50500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
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
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT_LL is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
# CONFIG_TASK_XACCT is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
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
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_DOM0=y
# CONFIG_XEN_PVHVM is not set
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_CALGARY_IOMMU=y
# CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_COMPAT_VDSO=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
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
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_XEN=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT=y
# CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
CONFIG_GOOGLE_VPD=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_MMU_AUDIT is not set
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_SCSI=y
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
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
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_4_7=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE=y
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_PTE_DEVMAP=y
# CONFIG_HMM_MIRROR is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=y
# CONFIG_TLS_DEVICE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=y
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
# CONFIG_IP_MULTIPLE_TABLES is not set
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
CONFIG_INET_DIAG_DESTROY=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=y

#
# DCCP CCIDs Configuration
#
CONFIG_IP_DCCP_CCID2_DEBUG=y
# CONFIG_IP_DCCP_CCID3 is not set
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=y
# CONFIG_SCTP_DBG_OBJCNT is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
CONFIG_L2TP=y
# CONFIG_L2TP_DEBUGFS is not set
# CONFIG_L2TP_V3 is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
# CONFIG_BRIDGE_IGMP_SNOOPING is not set
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_PHONET=y
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
# CONFIG_BATMAN_ADV_DAT is not set
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_MCAST is not set
CONFIG_BATMAN_ADV_DEBUGFS=y
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_SYSFS is not set
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=y
CONFIG_OPENVSWITCH_GRE=y
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VMWARE_VMCI_VSOCKETS=y
# CONFIG_VIRTIO_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=y
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_NET_NCSI=y
CONFIG_NCSI_OEM_CMD_GET_MAC=y
CONFIG_CGROUP_NET_PRIO=y
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
# CONFIG_CAN_BCM is not set
# CONFIG_CAN_GW is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=y
CONFIG_CAN_DEV=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_FLEXCAN=y
CONFIG_CAN_GRCAN=y
# CONFIG_CAN_C_CAN is not set
CONFIG_CAN_CC770=y
# CONFIG_CAN_CC770_ISA is not set
# CONFIG_CAN_CC770_PLATFORM is not set
# CONFIG_CAN_IFI_CANFD is not set
CONFIG_CAN_M_CAN=y
CONFIG_CAN_PEAK_PCIEFD=y
CONFIG_CAN_SJA1000=y
CONFIG_CAN_SJA1000_ISA=y
CONFIG_CAN_SJA1000_PLATFORM=y
CONFIG_CAN_EMS_PCI=y
# CONFIG_CAN_PEAK_PCI is not set
CONFIG_CAN_KVASER_PCI=y
CONFIG_CAN_PLX_PCI=y
CONFIG_CAN_SOFTING=y

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=y
CONFIG_CAN_MCP251X=y
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=y
CONFIG_CAN_EMS_USB=y
# CONFIG_CAN_ESD_USB2 is not set
CONFIG_CAN_GS_USB=y
CONFIG_CAN_KVASER_USB=y
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
CONFIG_CAN_UCAN=y
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
# CONFIG_BT_RFCOMM_TTY is not set
# CONFIG_BT_BNEP is not set
CONFIG_BT_HIDP=y
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_BCM=y
CONFIG_BT_HCIBTUSB=y
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
# CONFIG_BT_HCIBTUSB_RTL is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=y
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=y
# CONFIG_BT_HCIUART_BCSP is not set
# CONFIG_BT_HCIUART_ATH3K is not set
# CONFIG_BT_HCIUART_LL is not set
CONFIG_BT_HCIUART_3WIRE=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_RTL is not set
# CONFIG_BT_HCIUART_QCA is not set
CONFIG_BT_HCIUART_AG6XX=y
CONFIG_BT_HCIUART_MRVL=y
CONFIG_BT_HCIBCM203X=y
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
CONFIG_BT_MRVL_SDIO=y
# CONFIG_BT_ATH3K is not set
CONFIG_BT_WILINK=y
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_MTKUART is not set
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
CONFIG_AF_RXRPC_DEBUG=y
# CONFIG_RXKAD is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_XEN=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
CONFIG_NFC_NCI=y
CONFIG_NFC_NCI_SPI=y
CONFIG_NFC_NCI_UART=y
CONFIG_NFC_HCI=y
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_TRF7970A is not set
# CONFIG_NFC_MEI_PHY is not set
# CONFIG_NFC_SIM is not set
# CONFIG_NFC_PORT100 is not set
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_MRVL=y
CONFIG_NFC_MRVL_USB=y
CONFIG_NFC_MRVL_UART=y
CONFIG_NFC_MRVL_I2C=y
# CONFIG_NFC_MRVL_SPI is not set
CONFIG_NFC_ST_NCI=y
CONFIG_NFC_ST_NCI_I2C=y
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# CONFIG_NFC_ST95HF is not set
# end of Near Field Communication (NFC) devices

# CONFIG_PSAMPLE is not set
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=y
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEBUG=y
# CONFIG_PCIEASPM_DEFAULT is not set
CONFIG_PCIEASPM_POWERSAVE=y
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
CONFIG_PCIE_PTM=y
CONFIG_PCIE_BW=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_XEN_PCIDEV_FRONTEND=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
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
CONFIG_PCIE_CADENCE=y
# CONFIG_PCIE_CADENCE_HOST is not set
CONFIG_PCIE_CADENCE_EP=y
# end of Cadence PCIe controllers support

CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_HOST_GENERIC is not set
CONFIG_PCIE_XILINX=y

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
# CONFIG_RAPIDIO_CHMAN is not set
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
# CONFIG_RAPIDIO_CPS_XX is not set
# CONFIG_RAPIDIO_TSI568 is not set
# CONFIG_RAPIDIO_CPS_GEN2 is not set
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
CONFIG_GNSS_SIRF_SERIAL=y
# CONFIG_GNSS_UBX_SERIAL is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y
CONFIG_FTL=y
# CONFIG_NFTL is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_INTELEXT is not set
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_OF=y
CONFIG_MTD_PHYSMAP_VERSATILE=y
CONFIG_MTD_PHYSMAP_GEMINI=y
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
CONFIG_MTD_PCI=y
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_MCHP23K256=y
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_RAW_NAND=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y

#
# Misc
#
CONFIG_MTD_SM_COMMON=y
CONFIG_MTD_NAND_NANDSIM=y
CONFIG_MTD_NAND_RICOH=y
CONFIG_MTD_NAND_DISKONCHIP=y
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
CONFIG_MTD_SPI_NAND=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
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
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
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
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=y
# CONFIG_XEN_BLKDEV_BACKEND is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TCP=y
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=y
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_INTEL_MEI_HDCP=y
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
CONFIG_INTEL_MIC_BUS=y

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=y

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
CONFIG_VOP=y
CONFIG_VHOST_RING=y
# end of Intel MIC & related support

CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_HABANA_AI=y
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.rst for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
CONFIG_IDE_GD_ATAPI=y
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEACPI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=y
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=y
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_JMICRON=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IT8172=y
CONFIG_BLK_DEV_IT8213=y
# CONFIG_BLK_DEV_IT821X is not set
CONFIG_BLK_DEV_NS87415=y
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_BLK_DEV_TC86C001 is not set
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
# CONFIG_SCSI is not set
# end of SCSI device support

# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_MD_CLUSTER=y
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_UNSTRIPED=y
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
CONFIG_DM_THIN_PROVISIONING=y
CONFIG_DM_CACHE=y
CONFIG_DM_CACHE_SMQ=y
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=y
CONFIG_DM_MIRROR=y
CONFIG_DM_LOG_USERSPACE=y
CONFIG_DM_RAID=y
CONFIG_DM_ZERO=y
# CONFIG_DM_MULTIPATH is not set
CONFIG_DM_DELAY=y
CONFIG_DM_DUST=y
# CONFIG_DM_INIT is not set
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=y
CONFIG_DM_VERITY=y
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=y
CONFIG_DM_LOG_WRITES=y
CONFIG_DM_INTEGRITY=y
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=y
CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_NET=y
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#
# CONFIG_CAIF_TTY is not set
# CONFIG_CAIF_SPI_SLAVE is not set
# CONFIG_CAIF_HSI is not set
# CONFIG_CAIF_VIRTIO is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
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
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
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
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
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
CONFIG_NET_VENDOR_GOOGLE=y
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
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
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
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
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
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
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
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
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
# WiMAX Wireless Broadband devices
#
# CONFIG_WIMAX_I2400M_USB is not set
# end of WiMAX Wireless Broadband devices

# CONFIG_WAN is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_XEN_NETDEV_BACKEND is not set
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
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_OMAP4=y
CONFIG_KEYBOARD_TC3589X=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
CONFIG_KEYBOARD_BCM=y
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
CONFIG_MOUSE_SYNAPTICS_USB=y
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM860X_ONKEY is not set
# CONFIG_INPUT_88PM80X_ONKEY is not set
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_MSM_VIBRATOR=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MAX8997_HAPTIC is not set
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=y
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=y
CONFIG_INPUT_KEYSPAN_REMOTE=y
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_TPS65218_PWRBUTTON=y
CONFIG_INPUT_AXP20X_PEK=y
# CONFIG_INPUT_TWL6040_VIBRA is not set
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PALMAS_PWRBUTTON=y
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=y
CONFIG_INPUT_PWM_VIBRA=y
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
CONFIG_INPUT_DA9055_ONKEY=y
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_WM831X_ON=y
CONFIG_INPUT_ADXL34X=y
# CONFIG_INPUT_ADXL34X_I2C is not set
CONFIG_INPUT_ADXL34X_SPI=y
CONFIG_INPUT_IMS_PCU=y
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
# CONFIG_INPUT_XEN_KBDDEV_FRONTEND is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_SOC_BUTTON_ARRAY=y
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
CONFIG_INPUT_STPMIC1_ONKEY=y
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

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
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=y
CONFIG_CYCLADES=y
CONFIG_CYZ_INTR=y
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
# CONFIG_SYNCLINK is not set
CONFIG_SYNCLINKMP=y
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=y
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_NULL_TTY=y
CONFIG_LDISC_AUTOLOAD=y
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_ASPEED_VUART=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
CONFIG_SERIAL_MAX310X=y
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
CONFIG_SERIAL_IFX6X60=y
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
# CONFIG_HVC_XEN is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
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
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_FSI=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

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
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_NXP_FLEXSPI=y
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SIFIVE=y
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_GPIO=y

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
CONFIG_PTP_1588_CLOCK_KVM=y
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AS3722=y
CONFIG_PINCTRL_AXP209=y
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_PALMAS=y
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
CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_MADERA=y
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
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP87565=y
# CONFIG_GPIO_MADERA is not set
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

# CONFIG_GPIO_MOCKUP is not set
CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_CROS_USBPD is not set
CONFIG_CHARGER_UCS1002=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9055=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LOCHNAGAR=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS1015 is not set
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
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
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_CLOCK_THERMAL=y
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
# CONFIG_THERMAL_MMIO is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_DA9063_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=y
CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
CONFIG_WM8350_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_RAVE_SP_WATCHDOG=y
CONFIG_MLX_WDT=y
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_RN5T618_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_STPMIC1_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=y
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=y
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=y
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_INTEL_MEI_WDT=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y
# CONFIG_XEN_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_CHARDEV=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_MADERA_SPI=y
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
CONFIG_MFD_LOCHNAGAR=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_MFD_ROHM_BD70528 is not set
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_RAVE_SP_CORE=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3722=y
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LOCHNAGAR=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LP8788 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_STPMIC1 is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
# CONFIG_RC_CORE is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
# CONFIG_DRM_I915_COMPRESS_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set
# CONFIG_DRM_I915_GVT is not set
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_ATI_PCIGART=y
CONFIG_DRM_VMWGFX=y
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=y
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=y
CONFIG_DRM_CIRRUS_QEMU=y
CONFIG_DRM_RCAR_DW_HDMI=y
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
CONFIG_DRM_PANEL_LVDS=y
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
CONFIG_DRM_PANEL_LG_LG4573=y
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_ROCKTECH_JH057N00900=y
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
CONFIG_DRM_PANEL_TPO_TPG110=y
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_CDNS_DSI=y
CONFIG_DRM_DUMB_VGA_DAC=y
# CONFIG_DRM_LVDS_ENCODER is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=y
# CONFIG_DRM_SII9234 is not set
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358764=y
CONFIG_DRM_TOSHIBA_TC358767=y
# CONFIG_DRM_TI_TFP410 is not set
# CONFIG_DRM_TI_SN65DSI86 is not set
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7533 is not set
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_DW_HDMI=y
CONFIG_DRM_DW_HDMI_CEC=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_HISI_HIBMC is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
CONFIG_DRM_TINYDRM=y
CONFIG_TINYDRM_MIPI_DBI=y
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9225=y
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_MI0283QT is not set
CONFIG_TINYDRM_REPAPER=y
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
CONFIG_DRM_XEN=y
CONFIG_DRM_XEN_FRONTEND=y
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=y
CONFIG_DRM_MGA=y
# CONFIG_DRM_SIS is not set
CONFIG_DRM_VIA=y
CONFIG_DRM_SAVAGE=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=y
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
# CONFIG_FB_MATROX_I2C is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SMSCUFX=y
# CONFIG_FB_UDL is not set
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
CONFIG_XEN_FBDEV_FRONTEND=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP5520 is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=y
CONFIG_HOLTEK_FF=y
CONFIG_HID_GOOGLE_HAMMER=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=y
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_WHITELIST=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y
CONFIG_USB_WUSB_CBAF=y
CONFIG_USB_WUSB_CBAF_DEBUG=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USBIP_CORE=y
# CONFIG_USBIP_VHCI_HCD is not set
CONFIG_USBIP_HOST=y
CONFIG_USBIP_VUDC=y
CONFIG_USBIP_DEBUG=y
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PERIPHERAL=y
# CONFIG_USB_DWC2_DUAL_ROLE is not set
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=y
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_USB_SISUSBVGA=y
# CONFIG_USB_SISUSBVGA_CON is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=y
CONFIG_USB_GR_UDC=y
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
CONFIG_USB_NET2272=y
CONFIG_USB_NET2272_DMA=y
CONFIG_USB_GADGET_XILINX=y
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

# CONFIG_USB_CONFIGFS is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SD8787=y
CONFIG_PWRSEQ_SIMPLE=y
# CONFIG_MMC_BLOCK is not set
CONFIG_SDIO_UART=y
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_MMC_SDHCI_OF_AT91=y
CONFIG_MMC_SDHCI_OF_DWCMSHC=y
CONFIG_MMC_SDHCI_CADENCE=y
CONFIG_MMC_SDHCI_F_SDH30=y
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=y
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
CONFIG_MMC_TOSHIBA_PCI=y
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
# CONFIG_MMC_SDHCI_OMAP is not set
CONFIG_MMC_SDHCI_AM654=y
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_SPI_BYTE is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_AS3722 is not set
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
# CONFIG_RTC_DRV_LP8788 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=y
CONFIG_RTC_DRV_MAX8997=y
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_ISL12026 is not set
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BD70528 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_PALMAS is not set
# CONFIG_RTC_DRV_TPS6586X is not set
CONFIG_RTC_DRV_RC5T583=y
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=y
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=y
CONFIG_RTC_DRV_DS1305=y
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=y
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_DS3232_HWMON is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9055 is not set
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_WM831X is not set
# CONFIG_RTC_DRV_WM8350 is not set
CONFIG_RTC_DRV_ZYNQMP=y
CONFIG_RTC_DRV_CROS_EC=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=y
CONFIG_RTC_DRV_SNVS=y
CONFIG_RTC_DRV_R7301=y

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
CONFIG_INTEL_IOATDMA=y
CONFIG_INTEL_MIC_X100_DMA=y
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_DCA=y
CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_CHARLCD=y
# CONFIG_UIO is not set
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=y
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=y
CONFIG_XEN_COMPAT_XENFS=y
# CONFIG_XEN_SYS_HYPERVISOR is not set
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
CONFIG_XEN_GRANT_DEV_ALLOC=y
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PCIDEV_BACKEND=y
CONFIG_XEN_PVCALLS_FRONTEND=y
CONFIG_XEN_PVCALLS_BACKEND=y
CONFIG_XEN_SCSI_BACKEND=y
CONFIG_XEN_PRIVCMD=y
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=y
# end of Xen driver support

# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC_I2C=y
CONFIG_CROS_EC_SPI=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=y
CONFIG_CROS_EC_DEBUGFS=y
# CONFIG_CROS_EC_SYSFS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
# CONFIG_MLXREG_IO is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_BD718XX=y
CONFIG_COMMON_CLK_FIXED_MMIO=y
# end of Common Clock Framework

CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

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
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

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
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
CONFIG_IXP4XX_NPE=y
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_CROS_EC is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=y
# CONFIG_NTB_AMD is not set
CONFIG_NTB_IDT=y
# CONFIG_NTB_INTEL is not set
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
CONFIG_VME_TSI148=y
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
# CONFIG_VMIVME_7805 is not set

#
# VME Device Drivers
#
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
# CONFIG_PWM_CROS_EC is not set
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_LP3943=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_CADENCE_DP=y
# CONFIG_PHY_CADENCE_DPHY is not set
CONFIG_PHY_CADENCE_SIERRA=y
CONFIG_PHY_FSL_IMX8MQ_USB=y
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_MAPPHONE_MDM6600=y
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_SAMSUNG_USB2=y
CONFIG_PHY_TUSB1210=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
# CONFIG_NVMEM_SYSFS is not set
# CONFIG_RAVE_SP_EEPROM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
# CONFIG_FSI_MASTER_GPIO is not set
# CONFIG_FSI_MASTER_HUB is not set
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=y
CONFIG_FSI_OCC=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_FTM_QUADDEC=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_FSCACHE_OBJECT_LIST=y
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
CONFIG_CACHEFILES_HISTOGRAM=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=y
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_LZO is not set
# CONFIG_UBIFS_FS_ZLIB is not set
CONFIG_UBIFS_FS_ZSTD=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
# CONFIG_UBIFS_FS_XATTR is not set
CONFIG_UBIFS_FS_AUTHENTICATION=y
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
CONFIG_UFS_DEBUG=y
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
CONFIG_DLM=y
CONFIG_DLM_DEBUG=y
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#
CONFIG_GCC_PLUGIN_STRUCTLEAK=y

#
# Memory initialization
#
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
CONFIG_STACKLEAK_METRICS=y
CONFIG_STACKLEAK_RUNTIME_DISABLE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
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
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128L=y
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2=y
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
CONFIG_CRYPTO_MORUS640=y
CONFIG_CRYPTO_MORUS640_GLUE=y
CONFIG_CRYPTO_MORUS640_SSE2=y
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_MORUS1280_GLUE=y
CONFIG_CRYPTO_MORUS1280_SSE2=y
CONFIG_CRYPTO_MORUS1280_AVX2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
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
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
CONFIG_FONT_7x14=y
CONFIG_FONT_PEARL_8x8=y
# CONFIG_FONT_ACORN_8x8 is not set
CONFIG_FONT_MINI_4x6=y
CONFIG_FONT_6x10=y
CONFIG_FONT_10x18=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
CONFIG_FONT_TER16x32=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y
# end of Library routines

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
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
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
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_KASAN_STACK=1
# CONFIG_TEST_KASAN is not set
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
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
CONFIG_HAVE_FENTRY=y
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
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_PREEMPTIRQ_EVENTS is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_GCOV_PROFILE_FTRACE=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
CONFIG_UBSAN_NO_ALIGNMENT=y
# CONFIG_TEST_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of Kernel hacking

--=_5d4bce76.bNkfcGyJKBduxV+JAqHuUzlJqtDSlARRLcXlVda/gqXkEOIU--
