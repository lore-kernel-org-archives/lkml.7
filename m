Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F6C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 15:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6D92071F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 15:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLAPCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 10:02:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:8000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfLAPCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 10:02:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2019 07:02:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,265,1571727600"; 
   d="xz'?gz'50?scan'50,208,50";a="241624638"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga002.fm.intel.com with ESMTP; 01 Dec 2019 07:02:37 -0800
Date:   Sun, 1 Dec 2019 23:02:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>
Subject: bf8e602186 ("tracing: Do not create tracefs files if tracefs .."): [
    2.789121] WARNING: CPU: 1 PID: 1 at kernel/trace/ftrace.c:989
 ftrace_init_tracefs_toplevel
Message-ID: <20191201150211.GD18573@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit bf8e602186ec402ed937b2cbd6c39a34c0029757
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Fri Oct 11 20:41:41 2019 -0400
Commit:     Steven Rostedt (VMware) <rostedt@goodmis.org>
CommitDate: Sat Oct 12 20:49:07 2019 -0400

    tracing: Do not create tracefs files if tracefs lockdown is in effect
    
    If on boot up, lockdown is activated for tracefs, don't even bother creating
    the files. This can also prevent instances from being created if lockdown is
    in effect.
    
    Link: http://lkml.kernel.org/r/CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com
    
    Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

17911ff38a  tracing: Add locked_down checks to the open calls of files created for tracefs
bf8e602186  tracing: Do not create tracefs files if tracefs lockdown is in effect
81b6b96475  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
419593dad8  Add linux-next specific files for 20191129
+----------------------------------------------------------------+------------+------------+------------+---------------+
|                                                                | 17911ff38a | bf8e602186 | 81b6b96475 | next-20191129 |
+----------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                                 | 31         | 0          | 0          | 0             |
| boot_failures                                                  | 0          | 11         | 11         | 11            |
| WARNING:at_kernel/trace/ftrace.c:#ftrace_init_tracefs_toplevel | 0          | 11         | 11         | 11            |
| EIP:ftrace_init_tracefs_toplevel                               | 0          | 11         | 11         | 11            |
| WARNING:at_kernel/trace/trace.c:#create_trace_option_files     | 0          | 11         | 11         | 11            |
| EIP:create_trace_option_files                                  | 0          | 11         | 11         | 11            |
| Mem-Info                                                       | 0          | 1          |            |               |
+----------------------------------------------------------------+------------+------------+------------+---------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[    2.780405] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    2.782605] Could not create tracefs 'set_graph_notrace' entry
[    2.784297] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    2.786368] ------------[ cut here ]------------
[    2.787647] Could not register function stat for cpu 0
[    2.789121] WARNING: CPU: 1 PID: 1 at kernel/trace/ftrace.c:989 ftrace_init_tracefs_toplevel+0x184/0x1d8
[    2.792367] Modules linked in:
[    2.793074] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 5.4.0-rc2-00007-gbf8e602186ec4 #1
[    2.793074] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    2.793074] EIP: ftrace_init_tracefs_toplevel+0x184/0x1d8
[    2.793074] Code: fe 85 c0 0f 84 58 ff ff ff 31 c9 ba 01 00 00 00 8b 5d f0 b8 e0 8a c7 42 6a 01 e8 b8 23 42 fe 53 68 94 67 8f 42 e8 7d f5 2f fe <0f> 0b 31 c9 ba 01 00 00 00 6a 01 b8 c8 8a c7 42 e8 98 23 42 fe 8b
[    2.793074] EAX: 0000002a EBX: 00000000 ECX: 00000000 EDX: 00000000
[    2.793074] ESI: 42dde7fc EDI: f55eab2c EBP: 402cbf00 ESP: 402cbedc
[    2.793074] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
[    2.793074] CR0: 80050033 CR2: ffffffff CR3: 02fd9000 CR4: 00040690
[    2.793074] Call Trace:
[    2.793074]  ? register_tracer+0x170/0x170
[    2.793074]  ? tracer_init_tracefs+0x91/0x1e7
[    2.793074]  ? do_one_initcall+0x75/0x3b8
[    2.793074]  ? trace_initcall_level+0xe1/0x101
[    2.793074]  ? kernel_init_freeable+0xf5/0x192
[    2.793074]  ? kernel_init_freeable+0x114/0x192
[    2.793074]  ? rest_init+0x140/0x140
[    2.793074]  ? kernel_init+0x10/0x110
[    2.793074]  ? schedule_tail_wrapper+0x9/0xc
[    2.793074]  ? ret_from_fork+0x33/0x40
[    2.793074] _warn_unseeded_randomness: 123 callbacks suppressed
[    2.793074] random: get_random_bytes called from print_oops_end_marker+0x57/0x70 with crng_init=0
[    2.793074] ---[ end trace f0d030514b1a50e3 ]---
[    2.827821] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start d196292990fce11fd7bb7585a782b3f4b34429e1 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c --
git bisect  bad 5d682fa3d8943c19a632ebeaf70e8b9e41c78a5b  # 13:43  B      0     3   19   0  gpio: xgs-iproc: Fix section mismatch on device tree match table
git bisect good 698b8eeaed7287970fc2b6d322618850fd1b1e6c  # 14:31  G     11     0    0   0  gpio/mpc8xxx: change irq handler from chained to normal
git bisect good 921d6c32b6f86c48e06667ce2f8c50ca45bfa212  # 15:03  G     10     0    0   0  MAINTAINERS: Add entry for RDA Micro GPIO driver and binding
git bisect good 6a41b6c5fc20abced88fa0eed42ae5e5cb70b280  # 15:31  G     10     0    0   0  gpio: Add xgs-iproc driver
git bisect  bad c196924277ea82200d4c4fd9537c71390b96f247  # 16:04  B      0     1   18   1  Merge tag 'v5.4-rc6' into devel
git bisect  bad 998d75510e373aab5644d777d3b058312d550159  # 16:49  B      0     3   19   0  Merge branch 'akpm' (patches from Andrew)
git bisect good c6ad7c3ce9800e91d6cc6d2f6f566339ebac5656  # 17:28  G     10     0    0   0  Merge tag '5.4-rc2-smb3' of git://git.samba.org/sfrench/cifs-2.6
git bisect good 71b1b5532b9c58f260911ee59c7b3007d6d673a5  # 17:48  G     11     0    0   0  Merge tag 'fixes-for-5.4-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
git bisect  bad ad32fd7426e192cdf5368eda23a6482ff83c2022  # 18:16  B      0     8   24   0  Merge tag 'xtensa-20191017' of git://github.com/jcmvbkbc/linux-xtensa
git bisect  bad 8625732e7712882bd14e1fce962bdc3c315acd41  # 18:36  B      0     5   21   0  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect  bad 3c52b0af059e11a063970aed1ad143b9284a79c7  # 19:00  B      0     1   17   0  lib/generic-radix-tree.c: add kmemleak annotations
git bisect  bad d303de1fcf344ff7c15ed64c3f48a991c9958775  # 19:23  B      0     1   17   0  tracing: Initialize iter->seq after zeroing in tracing_read_pipe()
git bisect good 8530dec63e7b486e3761cc3d74a22de301845ff5  # 20:15  G     11     0    0   0  tracing: Add tracing_check_open_get_tr()
git bisect  bad 7f8557b88d6aa5bf31f25f6013d81355a1b1d48d  # 21:01  B      0    11   27   0  recordmcount: Fix nop_mcount() function
git bisect  bad bf8e602186ec402ed937b2cbd6c39a34c0029757  # 22:05  B      0     4   20   0  tracing: Do not create tracefs files if tracefs lockdown is in effect
git bisect good 17911ff38aa58d3c95c07589dbf5d3564c4cf3c5  # 22:36  G     11     0    0   0  tracing: Add locked_down checks to the open calls of files created for tracefs
# first bad commit: [bf8e602186ec402ed937b2cbd6c39a34c0029757] tracing: Do not create tracefs files if tracefs lockdown is in effect
git bisect good 17911ff38aa58d3c95c07589dbf5d3564c4cf3c5  # 22:41  G     31     0    0   0  tracing: Add locked_down checks to the open calls of files created for tracefs
# extra tests with debug options
git bisect good bf8e602186ec402ed937b2cbd6c39a34c0029757  # 23:07  G     11     0    0   0  tracing: Do not create tracefs files if tracefs lockdown is in effect
# extra tests on head commit of linus/master
git bisect  bad 81b6b96475ac7a4ebfceae9f16fb3758327adbfe  # 23:57  B      0     2   18   0  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
# bad: [81b6b96475ac7a4ebfceae9f16fb3758327adbfe] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
# extra tests on revert first bad commit
git bisect good 38cce32718f755a5a296c21f7ee4e20a981a8a82  # 00:41  G     10     0    0   0  Revert "tracing: Do not create tracefs files if tracefs lockdown is in effect"
# good: [38cce32718f755a5a296c21f7ee4e20a981a8a82] Revert "tracing: Do not create tracefs files if tracefs lockdown is in effect"
# extra tests on linus/master
# duplicated: [81b6b96475ac7a4ebfceae9f16fb3758327adbfe] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
# extra tests on linux-next/master
git bisect  bad 419593dad8439007452bb6f267861863b572c520  # 00:46  B      0    11   27   0  Add linux-next specific files for 20191129
# bad: [419593dad8439007452bb6f267861863b572c520] Add linux-next specific files for 20191129

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

--tNQTSEo8WG/FKZ8E
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-2bb92e22a1a6:20191130220713:i386-randconfig-b001-20191130:5.4.0-rc2-00007-gbf8e602186ec4:1.gz"
Content-Transfer-Encoding: base64

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
gU2LiHACAA==

--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vm-yocto-2bb92e22a1a6:20191130220713:i386-randconfig-b001-20191130:5.4.0-rc2-00007-gbf8e602186ec4:1"

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
	-m 8192
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
	rcuperf.shutdown=0
	watchdog_thresh=60
)

"${kvm[@]}" -append "${append[*]}"

--tNQTSEo8WG/FKZ8E
Content-Type: application/x-xz
Content-Disposition: attachment; filename="d196292990fce11fd7bb7585a782b3f4b34429e1:gcc-7:i386-randconfig-b001-20191130:EIP:ftrace_init_tracefs_toplevel.xz"
Content-Transfer-Encoding: base64

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

--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.4.0-rc2-00007-gbf8e602186ec4"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.4.0-rc2 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
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
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
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
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
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
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_MEMCG_SYSFS_ON=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
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
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
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
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_SCHED_MC_PRIO is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
# CONFIG_X86_PAE is not set
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=120
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
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
CONFIG_ACPI_APEI_EINJ=y
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
CONFIG_DPTF_POWER=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

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
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_SMI=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
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
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
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
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
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
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
CONFIG_MODULE_SIG_SHA1=y
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha1"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

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
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

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
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
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
CONFIG_INET6_TUNNEL=y
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_NETLABEL is not set
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
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
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
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
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
# end of Cadence PCIe controllers support

# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
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
CONFIG_FW_LOADER_COMPRESS=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
CONFIG_GNSS_SIRF_SERIAL=y
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
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
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
CONFIG_MTD_SCx200_DOCFLASH=y
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=y
CONFIG_MTD_PCMCIA_ANONYMOUS=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
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
CONFIG_MTD_NAND_CS553X=y
CONFIG_MTD_NAND_MXIC=y
# CONFIG_MTD_NAND_GPIO is not set
CONFIG_MTD_NAND_PLATFORM=y

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_MTD_UBI_BLOCK=y
# CONFIG_MTD_HYPERBUS is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_BLK_DEV_FD=y
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

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

# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

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
# CONFIG_MD_AUTODETECT is not set
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_UNSTRIPED=y
CONFIG_DM_CRYPT=y
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_THIN_PROVISIONING is not set
CONFIG_DM_CACHE=y
# CONFIG_DM_CACHE_SMQ is not set
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=y
CONFIG_DM_CLONE=y
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=y
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=y
CONFIG_DM_MULTIPATH_QL=y
CONFIG_DM_MULTIPATH_ST=y
CONFIG_DM_DELAY=y
CONFIG_DM_DUST=y
CONFIG_DM_INIT=y
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=y
CONFIG_DM_VERITY=y
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=y
CONFIG_DM_LOG_WRITES=y
# CONFIG_DM_INTEGRITY is not set
CONFIG_DM_ZONED=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
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
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
CONFIG_TUN=m
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
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
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
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
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
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
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
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PLIP is not set
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
# CONFIG_HYPERV_NET is not set
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
# CONFIG_KEYBOARD_QT1050 is not set
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
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
CONFIG_JOYSTICK_GAMECON=y
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
# CONFIG_JOYSTICK_XPAD_FF is not set
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_WALKERA0701=y
CONFIG_JOYSTICK_PXRC=y
CONFIG_JOYSTICK_FSIA6B=y
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
# CONFIG_HYPERV_KEYBOARD is not set
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
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

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
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
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
# CONFIG_I2C_AMD_MP2 is not set
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
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
CONFIG_I2C_RK3X=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_PARPORT=y
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_FSI is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

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
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=y
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_SAMA5D2_PIOBU=y
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=y
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD70528=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

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
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9030=y
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_BATTERY_TWL4030_MADC is not set
CONFIG_CHARGER_PCF50633=y
CONFIG_BATTERY_RX51=y
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77650=y
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD70528=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LOCHNAGAR=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_INSPUR_IPSPS=y
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR38064=y
CONFIG_SENSORS_IRPS5401=y
# CONFIG_SENSORS_ISL68137 is not set
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CLOCK_THERMAL=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=y
CONFIG_DA9062_THERMAL=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_BD70528_WATCHDOG is not set
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9063_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_RAVE_SP_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=y
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=y
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_NI903X_WDT is not set
CONFIG_NIC7018_WDT=y
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
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
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD70528=y
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
CONFIG_RAVE_SP_CORE=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD70528=y
CONFIG_REGULATOR_BD718XX=y
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA903X is not set
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LOCHNAGAR=y
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8998 is not set
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=m
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
# CONFIG_IR_HIX5HD2 is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
# CONFIG_IR_PWM_TX is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
CONFIG_DRM_RCAR_LVDS=y
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_ROCKTECH_JH057N00900=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
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
CONFIG_DRM_LVDS_ENCODER=y
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
# CONFIG_DRM_NXP_PTN3460 is not set
CONFIG_DRM_PARADE_PS8622=y
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
# CONFIG_DRM_THINE_THC63LVD1024 is not set
CONFIG_DRM_TOSHIBA_TC358764=y
CONFIG_DRM_TOSHIBA_TC358767=y
# CONFIG_DRM_TI_TFP410 is not set
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7533 is not set
CONFIG_DRM_I2C_ADV7511_CEC=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_GM12U320=y
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
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
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_APPLE=y
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_LP8788=y
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_HIDPP is not set
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=y
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# USB HID support
#
# CONFIG_USB_HID is not set
CONFIG_HID_PID=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=y
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
# CONFIG_USB_SL811_CS is not set
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS3=y
# CONFIG_USB_CDNS3_GADGET is not set
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_PCI_WRAP=y
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
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
CONFIG_USB_DWC3_OF_SIMPLE=y
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_OF=y
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_HOST=y
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
CONFIG_USB_GADGET_DEBUG_FILES=y
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FUSB300 is not set
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
CONFIG_USB_BDC_PCI=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=y
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_MASS_STORAGE=y
CONFIG_USB_F_FS=y
CONFIG_USB_CONFIGFS=y
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
CONFIG_USB_CONFIGFS_F_FS=y
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
CONFIG_UCSI_CCG=y
CONFIG_UCSI_ACPI=y
CONFIG_TYPEC_TPS6598X=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_MMC_SDHCI_OF_ASPEED=y
# CONFIG_MMC_SDHCI_OF_AT91 is not set
CONFIG_MMC_SDHCI_OF_DWCMSHC=y
CONFIG_MMC_SDHCI_CADENCE=y
CONFIG_MMC_SDHCI_F_SDH30=y
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MMC_SDHCI_OMAP=y
CONFIG_MMC_SDHCI_AM654=y
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=y
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8788=y
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX77650=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_DW_AXI_DMAC is not set
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
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
# CONFIG_DMABUF_SELFTESTS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=y
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_BALLOON=y
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
# CONFIG_GREYBUS_ES2 is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_STAGING_BOARD is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS_AUDIO is not set
# CONFIG_GREYBUS_BOOTROM is not set
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
# CONFIG_GREYBUS_LOG is not set
# CONFIG_GREYBUS_LOOPBACK is not set
# CONFIG_GREYBUS_POWER is not set
# CONFIG_GREYBUS_RAW is not set
# CONFIG_GREYBUS_VIBRATOR is not set
# CONFIG_GREYBUS_BRIDGED_PHY is not set

#
# Gasket devices
#
# end of Gasket devices

# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_USB_WUSB_CBAF is not set
# CONFIG_UWB is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_QLGE is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WIRELESS=y
# CONFIG_ACERHDF is not set
CONFIG_ASUS_LAPTOP=y
# CONFIG_DCDBAS is not set
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_LAPTOP is not set
CONFIG_DELL_SMO8800=y
CONFIG_DELL_RBU=y
CONFIG_FUJITSU_LAPTOP=y
CONFIG_FUJITSU_TABLET=y
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
CONFIG_PANASONIC_LAPTOP=y
CONFIG_THINKPAD_ACPI=y
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
CONFIG_THINKPAD_ACPI_DEBUG=y
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
# CONFIG_THINKPAD_ACPI_VIDEO is not set
# CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set
# CONFIG_SENSORS_HDAPS is not set
CONFIG_INTEL_MENLOW=y
CONFIG_ASUS_WIRELESS=y
# CONFIG_ACPI_WMI is not set
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
CONFIG_ACPI_CMPC=y
CONFIG_INTEL_INT0002_VGPIO=y
# CONFIG_INTEL_HID_EVENT is not set
CONFIG_INTEL_VBTN=y
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=y
# CONFIG_INTEL_PMC_IPC is not set
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_CHTDC_TI_PWRBTN is not set
CONFIG_I2C_MULTI_INSTANTIATE=y
# CONFIG_PCENGINES_APU2 is not set
CONFIG_PMC_ATOM=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_COMMON_CLK_LOCHNAGAR=y
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_VC5=y
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# end of Common Clock Framework

CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_HYPERV_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
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
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_PALMAS=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
CONFIG_DA311=y
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=y
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7291 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD799X is not set
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=y
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
CONFIG_LTC2485=y
CONFIG_LTC2497=y
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=y
CONFIG_MCP3422=y
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
# CONFIG_QCOM_SPMI_VADC is not set
CONFIG_QCOM_SPMI_ADC5=y
CONFIG_SD_ADC_MODULATOR=y
CONFIG_STMPE_ADC=y
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_AM335X_ADC is not set
CONFIG_TWL4030_MADC=y
CONFIG_TWL6030_GPADC=y
CONFIG_VF610_ADC=y
# CONFIG_VIPERBOARD_ADC is not set
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
# CONFIG_PMS7003 is not set
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SPS30=y
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
# CONFIG_AD5380 is not set
CONFIG_AD5446=y
# CONFIG_AD5593R is not set
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
# CONFIG_CIO_DAC is not set
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=y
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=y
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=y
CONFIG_IIO_SIMPLE_DUMMY=y
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ACPI_ALS=y
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
CONFIG_CM3605=y
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
CONFIG_MCP4018=y
CONFIG_MCP4531=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
# CONFIG_DPS310 is not set
CONFIG_HP03=y
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
CONFIG_SX9500=y
# CONFIG_SRF08 is not set
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_MLX90614=y
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_LPSS=y
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_STMPE is not set
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_CADENCE_DP=y
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_FSL_IMX8MQ_USB=y
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_CPCAP_USB=y
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_TUSB1210=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_RAVE_SP_EEPROM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
# CONFIG_STM_SOURCE_FTRACE is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=y
CONFIG_FSI_OCC=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_GPIO is not set
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
CONFIG_CACHEFILES_HISTOGRAM=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=y
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
# CONFIG_JFFS2_FS_POSIX_ACL is not set
# CONFIG_JFFS2_FS_SECURITY is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
CONFIG_JFFS2_CMODE_SIZE=y
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
# CONFIG_UBIFS_FS_ZLIB is not set
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_XATTR=y
# CONFIG_UBIFS_FS_SECURITY is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_ZSTD is not set
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
# CONFIG_ROMFS_BACKED_BY_MTD is not set
CONFIG_ROMFS_BACKED_BY_BOTH=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=y
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=y
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_LZ4HC_COMPRESS=y
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lzo"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_FTRACE=y
CONFIG_PSTORE_RAM=m
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
# CONFIG_UFS_DEBUG is not set
CONFIG_EROFS_FS=y
CONFIG_EROFS_FS_DEBUG=y
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
# CONFIG_EROFS_FS_SECURITY is not set
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
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
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_SECURITY_LOCKDOWN_LSM=y
# CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
# CONFIG_IMA_TEMPLATE is not set
# CONFIG_IMA_NG_TEMPLATE is not set
CONFIG_IMA_SIG_TEMPLATE=y
CONFIG_IMA_DEFAULT_TEMPLATE="ima-sig"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
CONFIG_IMA_APPRAISE_BUILD_POLICY=y
# CONFIG_IMA_APPRAISE_REQUIRE_FIRMWARE_SIGS is not set
CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y
CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS=y
CONFIG_IMA_APPRAISE_REQUIRE_POLICY_SIGS=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
# CONFIG_IMA_TRUSTED_KEYRING is not set
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
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
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

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
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_LIB_DES=m
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
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
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
# CONFIG_TPM_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
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
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
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
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
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
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

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
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
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
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_PREEMPTIRQ_EVENTS=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_NO_ALIGNMENT is not set
CONFIG_UBSAN_ALIGNMENT=y
# CONFIG_TEST_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of Kernel hacking

--tNQTSEo8WG/FKZ8E--
