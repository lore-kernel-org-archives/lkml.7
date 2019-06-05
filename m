Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDF1C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43587206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfFEQX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:23:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:64005 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfFEQX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:23:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 09:23:20 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Jun 2019 09:23:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hYYh2-000IIS-Da; Thu, 06 Jun 2019 00:23:16 +0800
Date:   Thu, 6 Jun 2019 00:22:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: [drivers/cpuidle]  be4d068f71: WARNING:suspicious_RCU_usage
Message-ID: <20190605162239.omjxn5fhrqwod6bz@inn2.lkp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bbsc4onnfrc2chh7"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bbsc4onnfrc2chh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


FYI, we noticed the following commit (built with gcc-7):

commit: be4d068f71e6509913afa59d1174ee59108569e7 ("drivers/cpuidle: add cpuidle-haltpoll driver")
https://github.com/0day-ci/linux UPDATE-20190605-044611/Marcelo-Tosatti/cpuidle-haltpoll-driver-v2/20190604-085852

in testcase: trinity
with following parameters:

	runtime: 300s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+-----------------------------------------------------------------------------------+------------+------------+
|                                                                                   | 94830f188a | be4d068f71 |
+-----------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                    | 4          | 0          |
| boot_failures                                                                     | 0          | 4          |
| WARNING:suspicious_RCU_usage                                                      | 0          | 4          |
| drivers/cpuidle/cpuidle-haltpoll-trace.h:#suspicious_rcu_dereference_check()usage | 0          | 4          |
+-----------------------------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>


[   23.942552] WARNING: suspicious RCU usage
[   23.943158] 5.2.0-rc1-00004-gbe4d068 #1 Not tainted
[   23.943886] -----------------------------
[   23.944519] drivers/cpuidle/cpuidle-haltpoll-trace.h:54 suspicious rcu_dereference_check() usage!
[   23.946173] 
[   23.946173] other info that might help us debug this:
[   23.946173] 
[   23.947451] 
[   23.947451] RCU used illegally from idle CPU!
[   23.947451] rcu_scheduler_active = 2, debug_locks = 1
[   23.949050] RCU used illegally from extended quiescent state!
[   23.949971] no locks held by swapper/0/0.
[   23.950614] 
[   23.950614] stack backtrace:
[   23.951309] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc1-00004-gbe4d068 #1
[   23.952406] Call Trace:
[   23.952826]  dump_stack+0x9a/0xde
[   23.953342]  haltpoll_enter_idle+0x479/0x498
[   23.954000]  cpuidle_enter_state+0xd0/0x31a
[   23.954661]  ? ftrace_likely_update+0x51/0x5c
[   23.955419]  ? ftrace_likely_update+0x51/0x5c
[   23.956103]  cpuidle_enter+0x2f/0x3b
[   23.956674]  do_idle+0x223/0x2e7
[   23.957171]  ? trace_event_define_fields_vector_alloc_managed+0xff/0xff
[   23.958143]  cpu_startup_entry+0x1d/0x1f
[   23.958765]  start_kernel+0x7a9/0x7e1
[   23.959343]  secondary_startup_64+0xb6/0xc0
[   23.989616] 
[   23.989932] =============================
[   23.990591] WARNING: suspicious RCU usage
[   23.991240] 5.2.0-rc1-00004-gbe4d068 #1 Not tainted
[   23.992013] -----------------------------
[   23.992672] drivers/cpuidle/cpuidle-haltpoll-trace.h:29 suspicious rcu_dereference_check() usage!
[   23.994357] 
[   23.994357] other info that might help us debug this:
[   23.994357] 
[   23.995647] 
[   23.995647] RCU used illegally from idle CPU!
[   23.995647] rcu_scheduler_active = 2, debug_locks = 1
[   23.997355] RCU used illegally from extended quiescent state!
[   23.998280] no locks held by swapper/0/0.
[   23.998918] 
[   23.998918] stack backtrace:
[   23.999613] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc1-00004-gbe4d068 #1
[   24.000810] Call Trace:
[   24.001228]  dump_stack+0x9a/0xde
[   24.001792]  haltpoll_enter_idle+0x260/0x498
[   24.002484]  cpuidle_enter_state+0xd0/0x31a
[   24.003172]  ? ftrace_likely_update+0x51/0x5c
[   24.003868]  ? ftrace_likely_update+0x51/0x5c
[   24.004581]  cpuidle_enter+0x2f/0x3b
[   24.005141]  do_idle+0x223/0x2e7
[   24.005670]  ? trace_event_define_fields_vector_alloc_managed+0xff/0xff
[   24.006736]  cpu_startup_entry+0x1d/0x1f
[   24.007378]  start_kernel+0x7a9/0x7e1
[   24.007977]  secondary_startup_64+0xb6/0xc0
[   24.135159] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
[   24.136408] IP-Config: Complete:
[   24.137974]      device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
[   24.140083]      host=vm-snb-quantal-x86_64-710, domain=, nis-domain=(none)
[   24.141179]      bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
[   24.141183]      nameserver0=10.0.2.3
[   24.147041] Unregister pv shared memory for cpu 0
[   24.170916] DEBUG_HOTPLUG_CPU0: CPU 0 is now offline
[   24.193063] Freeing unused kernel image memory: 4016K
[   24.193972] Write protecting the kernel read-only data: 30720k
[   24.200275] Freeing unused kernel image memory: 2036K
[   24.201246] Freeing unused kernel image memory: 80K
[   24.202715] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   24.203697] rodata_test: all tests were successful
[   24.204390] Run /init as init process
[   24.238969] random: init: uninitialized urandom read (12 bytes read)
[   24.347624] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[   24.873797] random: mountall: uninitialized urandom read (12 bytes read)
LKP: HOSTNAME vm-snb-quantal-x86_64-710, MAC 52:54:00:12:34:56, kernel 5.2.0-rc1-00004-gbe4d068 1, serial console /dev/ttyS0
[   25.187823] Kernel tests: Boot OK!
[   25.187833] 
[   25.200608] hostname: the specified hostname is invalid
[   25.200616] 
[   25.474810] /lkp/lkp/src/bin/run-lkp
[   25.474819] 
[   25.770881] udevd[363]: starting version 175
[   25.984983] RESULT_ROOT=/result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2019-04-26.cgz/x86_64-randconfig-a0-06050844/gcc-7/be4d068f71e6509913afa59d1174ee59108569e7/3
[   25.984993] 
[   26.007136] job=/lkp/jobs/scheduled/vm-snb-quantal-x86_64-710/trinity-300s-quantal-core-x86_64-2019-04-26.cgz-be4d068-20190605-40165-1n2sy7-3.yaml
[   26.007146] 
[   26.268751] result_service=raw_upload, RESULT_MNT=/inn/result, RESULT_ROOT=/inn/result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2019-04-26.cgz/x86_64-randconfig-a0-06050844/gcc-7/be4d068f71e6509913afa59d1174ee59108569e7/3
[   26.268761] 
[   26.454639] run-job /lkp/jobs/scheduled/vm-snb-quantal-x86_64-710/trinity-300s-quantal-core-x86_64-2019-04-26.cgz-be4d068-20190605-40165-1n2sy7-3.yaml
[   26.454649] 
[   27.255453] /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-snb-quantal-x86_64-710/trinity-300s-quantal-core-x86_64-2019-04-26.cgz-be4d068-20190605-40165-1n2sy7-3.yaml&job_state=running -O /dev/null
[   27.255463] 
[   27.362475] init: udev-fallback-graphics main process (492) terminated with status 1
[   27.419356] target ucode: 
[   27.419365] 
[   27.778437] init: networking main process (509) terminated with status 1
[   28.096245] init: failsafe main process (505) killed by TERM signal
[   28.415332] random: fast init done
[   29.325378] random: dd: uninitialized urandom read (4096 bytes read)
[   29.491877] Seeding trinity based on x86_64-randconfig-a0-06050844
[   29.491887] 
[   29.584973] groupadd: group 'nogroup' already exists
[   29.584982] 
[   29.644203] 2019-06-05 15:07:59 chroot --userspec nobody:nogroup / trinity -q -q -l off -s 2862873013 -x get_robust_list -x remap_file_pages -N 999999999
[   29.644213] 
[   29.888839] Trinity 1.8  Dave Jones <davej@codemonkey.org.uk>
[   29.888849] 
[   29.891751] shm:0x7f2616b28000-0x7f2623724d00 (4 pages)
[   29.891760] 
[   29.903899] [main] Marking syscall get_robust_list (64bit:274 32bit:312) as to be disabled.
[   29.903908] 
[   29.916703] [main] Marking syscall remap_file_pages (64bit:216 32bit:257) as to be disabled.
[   29.916713] 
[   29.931041] [main] Couldn't chmod tmp/ to 0777.
[   29.931051] 
[   29.946597] [main] Using user passed random seed: 2862873013.
[   29.946606] 
[   29.948906] Marking all syscalls as enabled.
[   29.948914] 
[   29.962311] [main] Disabling syscalls marked as disabled by command line options
[   29.962320] 
[   29.970484] [main] Marked 64-bit syscall remap_file_pages (216) as deactivated.
[   29.970504] 
[   29.978376] [main] Marked 64-bit syscall get_robust_list (274) as deactivated.
[   29.978384] 
[   29.994251] [main] Marked 32-bit syscall remap_file_pages (257) as deactivated.
[   29.994260] 
[   30.002082] [main] Marked 32-bit syscall get_robust_list (312) as deactivated.
[   30.002091] 
[   30.010917] [main] 32-bit syscalls: 382 enabled, 2 disabled.  64-bit syscalls: 331 enabled, 2 disabled.


To reproduce:

        # build kernel
	cd linux
	cp config-5.2.0-rc1-00004-gbe4d068 .config
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
lkp


--bbsc4onnfrc2chh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.2.0-rc1-00004-gbe4d068"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.2.0-rc1 Kernel Configuration
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
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
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
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
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
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS_PROC is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
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

# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
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
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
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
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_UMIP is not set
# CONFIG_X86_INTEL_MPX is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
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
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
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
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
# CONFIG_CPU_IDLE_GOV_MENU is not set
CONFIG_CPU_IDLE_GOV_TEO=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
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
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
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
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

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
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
CONFIG_ACORN_PARTITION_EESOX=y
# CONFIG_ACORN_PARTITION_ICS is not set
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=y
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
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
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
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
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM_MIRROR=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
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
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
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
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
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
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# end of Bus devices

# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
# CONFIG_OF_OVERLAY is not set
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
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_AD525X_DPOT_SPI is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
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
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

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
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
CONFIG_IDE_GD_ATAPI=y
# CONFIG_BLK_DEV_DELKIN is not set
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
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
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
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
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_CEVA=y
CONFIG_AHCI_QORIQ=y
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=y
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
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
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
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
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
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
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
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_NULL_TTY=y
# CONFIG_LDISC_AUTOLOAD is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
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
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
CONFIG_SERIAL_IFX6X60=y
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=y
# end of Serial drivers

CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=y
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=y
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_DEMUX_PINCTRL is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

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
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_FSI=y
# end of I2C Hardware Bus support

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
CONFIG_SPI_ALTERA=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_DLN2=y
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=y
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
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AS3722=y
CONFIG_PINCTRL_AXP209=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_PALMAS is not set
CONFIG_PINCTRL_RK805=y
# CONFIG_PINCTRL_OCELOT is not set
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
CONFIG_PINCTRL_CS47L85=y
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
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
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
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_GW_PLD is not set
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
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TQMX86=y
# CONFIG_GPIO_TWL4030 is not set
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_WM831X=y
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
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
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_CPCAP=y
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_CHARGER_AXP20X is not set
# CONFIG_BATTERY_AXP20X is not set
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_BATTERY_TWL4030_MADC is not set
# CONFIG_BATTERY_RX51 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77650 is not set
# CONFIG_CHARGER_MAX8998 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65217 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_QORIQ_THERMAL is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
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
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
# CONFIG_DA9063_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG_ARCH_INITCALL is not set
CONFIG_MENF21BMC_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=y
CONFIG_WM8350_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_RAVE_SP_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_RETU_WATCHDOG=y
CONFIG_STPMIC1_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

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
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_MADERA_SPI=y
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_HI6421_PMIC is not set
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
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_RAVE_SP_CORE=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_AB3100 is not set
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD718XX=y
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_CPCAP=y
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP87565 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PCAP is not set
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_STPMIC1 is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65217 is not set
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS80031=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8350=y
# CONFIG_REGULATOR_WM8994 is not set
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_VMALLOC=y

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=y
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=y
CONFIG_USB_M5602=y
CONFIG_USB_STV06XX=y
CONFIG_USB_GL860=y
# CONFIG_USB_GSPCA_BENQ is not set
# CONFIG_USB_GSPCA_CONEX is not set
# CONFIG_USB_GSPCA_CPIA1 is not set
CONFIG_USB_GSPCA_DTCS033=y
CONFIG_USB_GSPCA_ETOMS=y
CONFIG_USB_GSPCA_FINEPIX=y
# CONFIG_USB_GSPCA_JEILINJ is not set
CONFIG_USB_GSPCA_JL2005BCD=y
# CONFIG_USB_GSPCA_KINECT is not set
# CONFIG_USB_GSPCA_KONICA is not set
CONFIG_USB_GSPCA_MARS=y
CONFIG_USB_GSPCA_MR97310A=y
CONFIG_USB_GSPCA_NW80X=y
# CONFIG_USB_GSPCA_OV519 is not set
CONFIG_USB_GSPCA_OV534=y
CONFIG_USB_GSPCA_OV534_9=y
# CONFIG_USB_GSPCA_PAC207 is not set
CONFIG_USB_GSPCA_PAC7302=y
CONFIG_USB_GSPCA_PAC7311=y
CONFIG_USB_GSPCA_SE401=y
# CONFIG_USB_GSPCA_SN9C2028 is not set
CONFIG_USB_GSPCA_SN9C20X=y
CONFIG_USB_GSPCA_SONIXB=y
# CONFIG_USB_GSPCA_SONIXJ is not set
CONFIG_USB_GSPCA_SPCA500=y
CONFIG_USB_GSPCA_SPCA501=y
CONFIG_USB_GSPCA_SPCA505=y
CONFIG_USB_GSPCA_SPCA506=y
CONFIG_USB_GSPCA_SPCA508=y
CONFIG_USB_GSPCA_SPCA561=y
CONFIG_USB_GSPCA_SPCA1528=y
CONFIG_USB_GSPCA_SQ905=y
CONFIG_USB_GSPCA_SQ905C=y
CONFIG_USB_GSPCA_SQ930X=y
CONFIG_USB_GSPCA_STK014=y
CONFIG_USB_GSPCA_STK1135=y
# CONFIG_USB_GSPCA_STV0680 is not set
CONFIG_USB_GSPCA_SUNPLUS=y
CONFIG_USB_GSPCA_T613=y
# CONFIG_USB_GSPCA_TOPRO is not set
# CONFIG_USB_GSPCA_TOUPTEK is not set
# CONFIG_USB_GSPCA_TV8532 is not set
CONFIG_USB_GSPCA_VC032X=y
CONFIG_USB_GSPCA_VICAM=y
# CONFIG_USB_GSPCA_XIRLINK_CIT is not set
CONFIG_USB_GSPCA_ZC3XX=y
CONFIG_USB_PWC=y
CONFIG_USB_PWC_DEBUG=y
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=y
CONFIG_USB_STKWEBCAM=y
# CONFIG_USB_S2255 is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=y
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DEBUGIFC=y
CONFIG_VIDEO_HDPVR=y
CONFIG_VIDEO_USBVISION=y
CONFIG_VIDEO_STK1160_COMMON=y
CONFIG_VIDEO_STK1160=y

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_CX231XX=y

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
CONFIG_VIDEO_EM28XX_V4L2=y

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
CONFIG_USB_HACKRF=y
CONFIG_USB_MSI2500=y

#
# USB HDMI CEC adapters
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS3308=y
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=y
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_SONY_BTF_MPX=y

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_BT819=y
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TVP514X=y
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_TW9910=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=y
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
# CONFIG_VIDEO_OV2685 is not set
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7640=y
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV9640=y
CONFIG_VIDEO_VS6624=y
# CONFIG_VIDEO_MT9M111 is not set
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
CONFIG_VIDEO_RJ54N1=y

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
CONFIG_VIDEO_LM3560=y
CONFIG_VIDEO_LM3646=y

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=y
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

#
# Media SPI Adapters
#
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MSI001=y
# CONFIG_MEDIA_TUNER_MT20XX is not set
CONFIG_MEDIA_TUNER_MT2060=y
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
# CONFIG_MEDIA_TUNER_XC5000 is not set
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
# CONFIG_MEDIA_TUNER_MAX2165 is not set
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_MXL301RF=y
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Tools to develop new frontends
#
# end of Customise DVB Frontends

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
# ARM devices
#
# end of ARM devices

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
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
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
# CONFIG_LCD_PLATFORM is not set
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_AAT2870=y
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_AS3711=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_RAVE_SP is not set
# end of Backlight & LCD device support

CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

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
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
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
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
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
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_OF=y
CONFIG_USB_CHIPIDEA_PCI=y
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
CONFIG_USB_SERIAL_ARK3116=y
CONFIG_USB_SERIAL_BELKIN=y
CONFIG_USB_SERIAL_CH341=y
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
# CONFIG_USB_SERIAL_CP210X is not set
CONFIG_USB_SERIAL_CYPRESS_M8=y
# CONFIG_USB_SERIAL_EMPEG is not set
CONFIG_USB_SERIAL_FTDI_SIO=y
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
CONFIG_USB_SERIAL_IR=y
# CONFIG_USB_SERIAL_EDGEPORT is not set
CONFIG_USB_SERIAL_EDGEPORT_TI=y
CONFIG_USB_SERIAL_F81232=y
CONFIG_USB_SERIAL_F8153X=y
CONFIG_USB_SERIAL_GARMIN=y
CONFIG_USB_SERIAL_IPW=y
CONFIG_USB_SERIAL_IUU=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=y
CONFIG_USB_SERIAL_METRO=y
CONFIG_USB_SERIAL_MOS7720=y
CONFIG_USB_SERIAL_MOS7840=y
CONFIG_USB_SERIAL_MXUPORT=y
# CONFIG_USB_SERIAL_NAVMAN is not set
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_OTI6858=y
CONFIG_USB_SERIAL_QCAUX=y
CONFIG_USB_SERIAL_QUALCOMM=y
CONFIG_USB_SERIAL_SPCP8X5=y
CONFIG_USB_SERIAL_SAFE=y
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=y
CONFIG_USB_SERIAL_XIRCOM=y
CONFIG_USB_SERIAL_WWAN=y
# CONFIG_USB_SERIAL_OPTION is not set
CONFIG_USB_SERIAL_OMNINET=y
CONFIG_USB_SERIAL_OPTICON=y
# CONFIG_USB_SERIAL_XSENS_MT is not set
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
CONFIG_USB_SERIAL_QT2=y
CONFIG_USB_SERIAL_UPD78F0730=y
CONFIG_USB_SERIAL_DEBUG=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=y
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
CONFIG_UCSI_CCG=y
# CONFIG_UCSI_ACPI is not set
CONFIG_TYPEC_TPS6598X=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=y
# CONFIG_TYPEC_NVIDIA_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_UWB is not set
CONFIG_MMC=y
# CONFIG_PWRSEQ_EMMC is not set
# CONFIG_PWRSEQ_SIMPLE is not set
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=y
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
# CONFIG_MMC_SDHCI_PLTFM is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SPI=y
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=y
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_USB=y
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_CPCAP=y
CONFIG_LEDS_CR0014114=y
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77650 is not set
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_CHARLCD=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_STAGING=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
# CONFIG_COMEDI_PCL724 is not set
CONFIG_COMEDI_PCL726=y
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
# CONFIG_COMEDI_PCL816 is not set
# CONFIG_COMEDI_PCL818 is not set
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=y
CONFIG_COMEDI_AMPLC_PC263_ISA=y
CONFIG_COMEDI_RTI800=y
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
# CONFIG_COMEDI_DAS16 is not set
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=y
# CONFIG_COMEDI_DAS6402 is not set
# CONFIG_COMEDI_DT2801 is not set
# CONFIG_COMEDI_DT2811 is not set
# CONFIG_COMEDI_DT2814 is not set
# CONFIG_COMEDI_DT2815 is not set
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=y
CONFIG_COMEDI_DMM32AT=y
CONFIG_COMEDI_FL512=y
CONFIG_COMEDI_AIO_AIO12_8=y
CONFIG_COMEDI_AIO_IIRO_16=y
# CONFIG_COMEDI_II_PCI20KC is not set
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
# CONFIG_COMEDI_PCMDA12 is not set
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=y
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_USB_DRIVERS=y
# CONFIG_COMEDI_DT9812 is not set
CONFIG_COMEDI_NI_USB6501=y
# CONFIG_COMEDI_USBDUX is not set
CONFIG_COMEDI_USBDUXFAST=y
CONFIG_COMEDI_USBDUXSIGMA=y
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_R8712U is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=y
CONFIG_ADIS16240=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
CONFIG_AD7192=y
CONFIG_AD7280=y
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_SPI=y
# CONFIG_ADT7316_I2C is not set
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
CONFIG_AD9832=y
CONFIG_AD9834=y
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=y
# CONFIG_ADE7854_I2C is not set
CONFIG_ADE7854_SPI=y
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
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
# CONFIG_ION_SYSTEM_HEAP is not set
# CONFIG_ION_CARVEOUT_HEAP is not set
# CONFIG_ION_CHUNK_HEAP is not set
# end of Android

# CONFIG_STAGING_BOARD is not set
CONFIG_FIREWIRE_SERIAL=y
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
CONFIG_GS_FPGABOOT=y
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_FB_TFT=y
CONFIG_FB_TFT_AGM1264K_FL=y
CONFIG_FB_TFT_BD663474=y
CONFIG_FB_TFT_HX8340BN=y
CONFIG_FB_TFT_HX8347D=y
CONFIG_FB_TFT_HX8353D=y
CONFIG_FB_TFT_HX8357D=y
CONFIG_FB_TFT_ILI9163=y
CONFIG_FB_TFT_ILI9320=y
CONFIG_FB_TFT_ILI9325=y
CONFIG_FB_TFT_ILI9340=y
# CONFIG_FB_TFT_ILI9341 is not set
CONFIG_FB_TFT_ILI9481=y
CONFIG_FB_TFT_ILI9486=y
CONFIG_FB_TFT_PCD8544=y
CONFIG_FB_TFT_RA8875=y
CONFIG_FB_TFT_S6D02A1=y
# CONFIG_FB_TFT_S6D1121 is not set
CONFIG_FB_TFT_SH1106=y
# CONFIG_FB_TFT_SSD1289 is not set
CONFIG_FB_TFT_SSD1305=y
# CONFIG_FB_TFT_SSD1306 is not set
# CONFIG_FB_TFT_SSD1331 is not set
# CONFIG_FB_TFT_SSD1351 is not set
CONFIG_FB_TFT_ST7735R=y
CONFIG_FB_TFT_ST7789V=y
CONFIG_FB_TFT_TINYLCD=y
# CONFIG_FB_TFT_TLS8204 is not set
# CONFIG_FB_TFT_UC1611 is not set
# CONFIG_FB_TFT_UC1701 is not set
CONFIG_FB_TFT_UPD161704=y
CONFIG_FB_TFT_WATTEROTT=y
# CONFIG_FB_FLEX is not set
# CONFIG_FB_TFT_FBTFT_DEVICE is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=y
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=y
# CONFIG_GREYBUS_LOOPBACK is not set
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
CONFIG_GREYBUS_BRIDGED_PHY=y
# CONFIG_GREYBUS_GPIO is not set
# CONFIG_GREYBUS_I2C is not set
# CONFIG_GREYBUS_PWM is not set
CONFIG_GREYBUS_SDIO=y
CONFIG_GREYBUS_SPI=y
# CONFIG_GREYBUS_UART is not set
CONFIG_GREYBUS_USB=y
CONFIG_PI433=y

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
# CONFIG_EROFS_FS_SECURITY is not set
CONFIG_EROFS_FS_USE_VM_MAP_RAM=y
# CONFIG_EROFS_FAULT_INJECTION is not set
CONFIG_EROFS_FS_IO_MAX_RETRIES=5
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
# CONFIG_EROFS_FS_ZIP_NO_CACHE is not set
# CONFIG_EROFS_FS_ZIP_CACHE_UNIPOLAR is not set
CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR=y
CONFIG_FIELDBUS_DEV=y
CONFIG_HMS_ANYBUSS_BUS=y
CONFIG_ARCX_ANYBUS_CONTROLLER=y
# CONFIG_HMS_PROFINET is not set
# CONFIG_KPC2000 is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DCDBAS=y
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_SMM=y
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBU is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_MLX_PLATFORM is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
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
# CONFIG_CLK_SIFIVE is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_AMD_IOMMU is not set

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
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

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
CONFIG_IXP4XX_QMGR=y
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
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
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

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
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=y
# CONFIG_BMA220 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_DA280=y
# CONFIG_DA311 is not set
# CONFIG_DMARD06 is not set
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=y
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=y
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=y
# CONFIG_KXSD9_I2C is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
CONFIG_AD7291=y
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
CONFIG_AD7606=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD7606_IFACE_SPI=y
# CONFIG_AD7766 is not set
CONFIG_AD7768_1=y
# CONFIG_AD7780 is not set
CONFIG_AD7791=y
CONFIG_AD7793=y
CONFIG_AD7887=y
CONFIG_AD7923=y
CONFIG_AD7949=y
CONFIG_AD799X=y
CONFIG_AXP20X_ADC=y
CONFIG_AXP288_ADC=y
# CONFIG_CC10001_ADC is not set
CONFIG_CPCAP_ADC=y
CONFIG_DLN2_ADC=y
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HI8435=y
# CONFIG_HX711 is not set
CONFIG_INA2XX_ADC=y
CONFIG_LTC2471=y
CONFIG_LTC2485=y
CONFIG_LTC2497=y
CONFIG_MAX1027=y
CONFIG_MAX11100=y
CONFIG_MAX1118=y
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP320X=y
# CONFIG_MCP3422 is not set
CONFIG_MCP3911=y
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_TI_ADC081C=y
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=y
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=y
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
CONFIG_TI_ADS124S08=y
CONFIG_TI_AM335X_ADC=y
CONFIG_TI_TLC4541=y
CONFIG_TWL4030_MADC=y
# CONFIG_TWL6030_GPADC is not set
# CONFIG_VF610_ADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_BME680 is not set
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_PMS7003 is not set
CONFIG_SENSIRION_SGP30=y
# CONFIG_SPS30 is not set
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
# CONFIG_IIO_SSP_SENSORS_COMMONS is not set
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5421=y
CONFIG_AD5446=y
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=y
# CONFIG_LTC1660 is not set
CONFIG_LTC2632=y
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
CONFIG_AD5696_I2C=y
CONFIG_AD5755=y
CONFIG_AD5758=y
CONFIG_AD5761=y
CONFIG_AD5764=y
# CONFIG_AD5791 is not set
CONFIG_AD7303=y
CONFIG_CIO_DAC=y
CONFIG_AD8801=y
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
CONFIG_M62332=y
CONFIG_MAX517=y
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_MCP4922=y
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=y
# CONFIG_TI_DAC7311 is not set
CONFIG_TI_DAC7612=y
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=y
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
# CONFIG_HDC100X is not set
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16480=y
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BMI160_SPI=y
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=y
CONFIG_APDS9300=y
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM3605=y
CONFIG_CM36651=y
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=y
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
CONFIG_VL6180=y
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
# CONFIG_SENSORS_HMC5843_SPI is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# CONFIG_SENSORS_RM3100_SPI is not set
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
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5481=y
CONFIG_MAX5487=y
CONFIG_MCP4018=y
CONFIG_MCP4131=y
# CONFIG_MCP4531 is not set
CONFIG_MCP41010=y
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
# CONFIG_BMP280 is not set
# CONFIG_HP03 is not set
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5611_SPI=y
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
CONFIG_SRF08=y
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_MLX90614=y
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
CONFIG_MAX31856=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
# CONFIG_FMC_TRIVIAL is not set
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_CADENCE_DP is not set
# CONFIG_PHY_CADENCE_DPHY is not set
CONFIG_PHY_CADENCE_SIERRA=y
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_SAMSUNG_USB2=y
CONFIG_PHY_TUSB1210=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_IDLE_INJECT=y
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
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# end of Android

# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
CONFIG_NVMEM=y
# CONFIG_NVMEM_SYSFS is not set
CONFIG_RAVE_SP_EEPROM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_ICE40_SPI=y
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=y
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
# CONFIG_FPGA_DFL_FME_MGR is not set
CONFIG_FPGA_DFL_FME_BRIDGE=y
# CONFIG_FPGA_DFL_FME_REGION is not set
# CONFIG_FPGA_DFL_AFU is not set
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=y
# CONFIG_FSI_SBEFIFO is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_IO_TRACE=y
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

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
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
CONFIG_VXFS_FS=y
# CONFIG_MINIX_FS is not set
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=y
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_FTRACE=y
CONFIG_PSTORE_RAM=y
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
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
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
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
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
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
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
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
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128L=y
CONFIG_CRYPTO_AEGIS256=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2=y
CONFIG_CRYPTO_AEGIS256_AESNI_SSE2=y
CONFIG_CRYPTO_MORUS640=y
CONFIG_CRYPTO_MORUS640_GLUE=y
CONFIG_CRYPTO_MORUS640_SSE2=y
CONFIG_CRYPTO_MORUS1280=y
CONFIG_CRYPTO_MORUS1280_GLUE=y
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
CONFIG_CRYPTO_MORUS1280_AVX2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_ADIANTUM=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# CONFIG_CRYPTO_GHASH is not set
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
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
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_CRYPTO_DEV_CCREE=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
# CONFIG_TPM_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
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
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
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
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_STACKWALK=y
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
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
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
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_INSTRUMENT_ALL=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Lockups and Hangs

# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set

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
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
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
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_BRANCH_TRACER is not set
CONFIG_STACK_TRACER=y
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=y
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=y
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_NO_ALIGNMENT is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--bbsc4onnfrc2chh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='/lkp/lkp/src/allot/rand/vm-snb-quantal-x86_64/trinity.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-quantal-x86_64-710'
	export tbox_group='vm-snb-quantal-x86_64'
	export branch='linux-devel/devel-hourly-2019060506'
	export commit='be4d068f71e6509913afa59d1174ee59108569e7'
	export kconfig='x86_64-randconfig-a0-06050844'
	export repeat_to=4
	export submit_id='5cf7da6e0b9a939ce54db014'
	export job_file='/lkp/jobs/scheduled/vm-snb-quantal-x86_64-710/trinity-300s-quantal-core-x86_64-2019-04-26.cgz-be4d068-20190605-40165-1n2sy7-3.yaml'
	export id='12645e65a20b81d46dc82ab4e6eeb1d888ab82fd'
	export queuer_version='/lkp/lkp/.src-20190605-171526'
	export arch='x86_64'
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export compiler='gcc-7'
	export enqueue_time='2019-06-05 23:06:24 +0800'
	export _id='5cf7da700b9a939ce54db015'
	export _rt='/result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2019-04-26.cgz/x86_64-randconfig-a0-06050844/gcc-7/be4d068f71e6509913afa59d1174ee59108569e7'
	export user='lkp'
	export result_root='/result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2019-04-26.cgz/x86_64-randconfig-a0-06050844/gcc-7/be4d068f71e6509913afa59d1174ee59108569e7/3'
	export scheduler_version='/lkp/lkp/.src-20190605-171526'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/quantal/quantal-core-x86_64-2019-04-26.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-quantal-x86_64-710/trinity-300s-quantal-core-x86_64-2019-04-26.cgz-be4d068-20190605-40165-1n2sy7-3.yaml
ARCH=x86_64
kconfig=x86_64-randconfig-a0-06050844
branch=linux-devel/devel-hourly-2019060506
commit=be4d068f71e6509913afa59d1174ee59108569e7
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a0-06050844/gcc-7/be4d068f71e6509913afa59d1174ee59108569e7/vmlinuz-5.2.0-rc1-00004-gbe4d068
max_uptime=1500
RESULT_ROOT=/result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2019-04-26.cgz/x86_64-randconfig-a0-06050844/gcc-7/be4d068f71e6509913afa59d1174ee59108569e7/3
LKP_SERVER=inn
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
rw'
	export bm_initrd='/osimage/pkg/quantal-core-x86_64.cgz/trinity-static-x86_64-x86_64-6ddabfd2_2017-11-10.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='2G'
	export rootfs='quantal-core-x86_64-2019-04-26.cgz'
	export hdd_partitions='/dev/vda'
	export swap_partitions='/dev/vdb'
	export queue_at_least_once=1
	export vm_tbox_group='vm-snb-quantal-x86_64'
	export nr_vm=112
	export vm_base_id=501
	export kernel='/pkg/linux/x86_64-randconfig-a0-06050844/gcc-7/be4d068f71e6509913afa59d1174ee59108569e7/vmlinuz-5.2.0-rc1-00004-gbe4d068'
	export dequeue_time='2019-06-05 23:07:24 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-quantal-x86_64-710/trinity-300s-quantal-core-x86_64-2019-04-26.cgz-be4d068-20190605-40165-1n2sy7-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--bbsc4onnfrc2chh7
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--bbsc4onnfrc2chh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=trinity

Seeding trinity based on x86_64-randconfig-a0-06050844
groupadd: group 'nogroup' already exists
2019-06-05 15:07:59 chroot --userspec nobody:nogroup / trinity -q -q -l off -s 2862873013 -x get_robust_list -x remap_file_pages -N 999999999
Trinity 1.8  Dave Jones <davej@codemonkey.org.uk>
shm:0x7f2616b28000-0x7f2623724d00 (4 pages)
[main] Marking syscall get_robust_list (64bit:274 32bit:312) as to be disabled.
[main] Marking syscall remap_file_pages (64bit:216 32bit:257) as to be disabled.
[main] Couldn't chmod tmp/ to 0777.
[main] Using user passed random seed: 2862873013.
Marking all syscalls as enabled.
[main] Disabling syscalls marked as disabled by command line options
[main] Marked 64-bit syscall remap_file_pages (216) as deactivated.
[main] Marked 64-bit syscall get_robust_list (274) as deactivated.
[main] Marked 32-bit syscall remap_file_pages (257) as deactivated.
[main] Marked 32-bit syscall get_robust_list (312) as deactivated.
[main] 32-bit syscalls: 382 enabled, 2 disabled.  64-bit syscalls: 331 enabled, 2 disabled.
[main] Using pid_max = 32768
[main] futex: 0 owner:0
[main] futex: 0 owner:0
[main] futex: 0 owner:0
[main] futex: 0 owner:0
[main] futex: 0 owner:0
[main] Reserved/initialized 5 futexes.
[main] Added 16 filenames from /dev
[main] Added 19438 filenames from /proc
[main] Added 5258 filenames from /sys
01 00 00 00 70 00 00 00 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0f 00 00 00 00 00 00 00 22 d2 c7 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 21 2b 81 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01 00 00 00 48 00 00 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 fb 11 b2 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01 00 00 00 68 00 00 00 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 7a c4 a6 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01 00 00 00 60 00 00 00 04 00 00 00 00 00 00 00 6d 86 00 00 00 00 00 00 ae c3 00 00 00 00 00 00 0f 00 00 00 00 00 00 00 70 50 65 09 00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8d 7b 01 00 00 00 00 00 fd fd fd fd 00 00 00 00 74 74 74 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 20 1f e8 00 00 
01 00 00 00 48 00 00 00 09 00 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00 00 00 00 00 00 00 f8 48 da 00 00 00 00 00 00 e0 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 65 db 94 50 b2 6a c8 35 fe ff ff ff ff ff ff ff ff 1f 00 00 ff ff ff ff 00 70 b0 7d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01 00 00 00 68 00 00 00 0a 00 00 00 00 00 00 00 f7 ff 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a6 4e ff 09 00 00 00 00 0d 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe ff ff ff ff ff ff ff 25 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 73 c1 2c 5f fa ff 00 00 
01 00 00 00 40 00 00 00 08 00 00 00 00 00 00 00 f1 ff ff ff 00 00 00 00 61 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ee e2 7d 00 00 00 00 00 12 74 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 77 df fd 1f 00 00 00 00 fe ff ff ff ff ff ff ff 21 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01 00 00 00 48 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 63 b7 88 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01 00 00 00 60 00 00 00 03 00 00 00 00 00 00 00 6c 00 00 00 00 00 00 00 bd 00 00 00 00 00 00 00 09 00 00 00 00 00 00 00 e1 2d a7 08 00 00 00 00 00 60 dd 7b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 33 33 33 33 00 00 00 00 31 00 00 00 00 00 00 00 37 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa 75 f7 53 05 05 00 00 
[main] Couldn't open socket (11:1:3). Address family not supported by protocol
[main] Couldn't open socket (11:1:10). Address family not supported by protocol
[main] Couldn't open socket (11:1:4). Address family not supported by protocol
[main] Couldn't open socket (11:1:2). Address family not supported by protocol
[main] Couldn't open socket (11:1:4). Address family not supported by protocol
[main] Couldn't open socket (11:1:3). Address family not supported by protocol
[main] Couldn't open socket (11:1:6). Address family not supported by protocol
[main] Couldn't open socket (11:1:2). Address family not supported by protocol
[main] Couldn't open socket (11:1:3). Address family not supported by protocol
[main] Couldn't open socket (11:1:5). Address family not supported by protocol
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
[main] Couldn't open socket (37:5:5). Address family not supported by protocol
[main] Couldn't open socket (37:5:2). Address family not supported by protocol
[main] Couldn't open socket (37:5:4). Address family not supported by protocol
[main] Couldn't open socket (37:5:3). Address family not supported by protocol
[main] Couldn't open socket (37:1:3). Address family not supported by protocol
[main] Couldn't open socket (37:1:3). Address family not supported by protocol
[main] Couldn't open socket (37:5:4). Address family not supported by protocol
[main] Couldn't open socket (37:5:4). Address family not supported by protocol
[main] Couldn't open socket (37:1:0). Address family not supported by protocol
[main] Couldn't open socket (37:1:2). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (23:2:0). Address family not supported by protocol
[main] Couldn't open socket (23:2:0). Address family not supported by protocol
[main] Couldn't open socket (23:1:0). Address family not supported by protocol
[main] Couldn't open socket (23:1:0). Address family not supported by protocol
[main] Couldn't open socket (23:1:0). Address family not supported by protocol
[main] Couldn't open socket (23:5:0). Address family not supported by protocol
[main] Couldn't open socket (23:2:0). Address family not supported by protocol
[main] Couldn't open socket (23:2:1). Address family not supported by protocol
[main] Couldn't open socket (23:2:0). Address family not supported by protocol
[main] Couldn't open socket (23:2:1). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (10:5:0). Socket type not supported
[main] Couldn't open socket (10:6:33). Socket type not supported
[main] Couldn't open socket (10:5:0). Socket type not supported
[main] Couldn't open socket (10:5:0). Socket type not supported
[main] Couldn't open socket (41:10:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (41:10:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (41:10:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (41:10:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (32:2:6). Address family not supported by protocol
[main] Couldn't open socket (32:2:3). Address family not supported by protocol
[main] Couldn't open socket (32:2:10). Address family not supported by protocol
[main] Couldn't open socket (32:2:5). Address family not supported by protocol
[main] Couldn't open socket (32:2:5). Address family not supported by protocol
[main] Couldn't open socket (32:2:10). Address family not supported by protocol
[main] Couldn't open socket (32:2:5). Address family not supported by protocol
[main] Couldn't open socket (32:2:3). Address family not supported by protocol
[main] Couldn't open socket (32:2:5). Address family not supported by protocol
[main] Couldn't open socket (32:2:2). Address family not supported by protocol
Can't do protocol BRIDGE
Can't do protocol BRIDGE
Can't do protocol BRIDGE
Can't do protocol BRIDGE
Can't do protocol BRIDGE
Can't do protocol BRIDGE
Can't do protocol BRIDGE
Can't do protocol BRIDGE
Can't do protocol BRIDGE
Can't do protocol BRIDGE
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (31:3:3). Address family not supported by protocol
[main] Couldn't open socket (31:3:1). Address family not supported by protocol
[main] Couldn't open socket (31:3:5). Address family not supported by protocol
[main] Couldn't open socket (31:1:0). Address family not supported by protocol
[main] Couldn't open socket (31:3:6). Address family not supported by protocol
[main] Couldn't open socket (31:3:5). Address family not supported by protocol
[main] Couldn't open socket (31:3:5). Address family not supported by protocol
[main] Couldn't open socket (31:3:3). Address family not supported by protocol
[main] Couldn't open socket (31:3:3). Address family not supported by protocol
[main] Couldn't open socket (31:3:5). Address family not supported by protocol
[main] Couldn't open socket (29:2:2). Address family not supported by protocol
[main] Couldn't open socket (29:3:1). Address family not supported by protocol
[main] Couldn't open socket (29:2:2). Address family not supported by protocol
[main] Couldn't open socket (29:3:1). Address family not supported by protocol
[main] Couldn't open socket (29:2:2). Address family not supported by protocol
[main] Couldn't open socket (29:2:2). Address family not supported by protocol
[main] Couldn't open socket (29:3:1). Address family not supported by protocol
[main] Couldn't open socket (29:2:2). Address family not supported by protocol
[main] Couldn't open socket (29:2:2). Address family not supported by protocol
[main] Couldn't open socket (29:2:2). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (16:2:6). Protocol not supported
[main] Couldn't open socket (16:3:14). Protocol not supported
[main] Couldn't open socket (16:2:22). Protocol not supported
[main] Couldn't open socket (16:3:12). Protocol not supported
[main] Couldn't open socket (16:3:12). Protocol not supported
[main] Couldn't open socket (16:3:9). Protocol not supported
[main] Couldn't open socket (16:2:8). Protocol not supported
[main] Couldn't open socket (40:2:2). Address family not supported by protocol
[main] Couldn't open socket (40:2:5). Address family not supported by protocol
[main] Couldn't open socket (40:2:1). Address family not supported by protocol
[main] Couldn't open socket (40:2:4). Address family not supported by protocol
[main] Couldn't open socket (40:2:3). Address family not supported by protocol
[main] Couldn't open socket (40:2:1). Address family not supported by protocol
[main] Couldn't open socket (40:2:4). Address family not supported by protocol
[main] Couldn't open socket (40:2:4). Address family not supported by protocol
[main] Couldn't open socket (40:2:2). Address family not supported by protocol
[main] Couldn't open socket (40:2:4). Address family not supported by protocol
Can't do protocol SNA
Can't do protocol SNA
Can't do protocol SNA
Can't do protocol SNA
Can't do protocol SNA
Can't do protocol SNA
Can't do protocol SNA
Can't do protocol SNA
Can't do protocol SNA
Can't do protocol SNA
[main] Couldn't open socket (28:2:4). Address family not supported by protocol
[main] Couldn't open socket (28:2:10). Address family not supported by protocol
[main] Couldn't open socket (28:2:2). Address family not supported by protocol
[main] Couldn't open socket (28:2:2). Address family not supported by protocol
[main] Couldn't open socket (28:2:5). Address family not supported by protocol
[main] Couldn't open socket (28:2:3). Address family not supported by protocol
[main] Couldn't open socket (28:2:10). Address family not supported by protocol
[main] Couldn't open socket (28:2:10). Address family not supported by protocol
[main] Couldn't open socket (28:2:2). Address family not supported by protocol
[main] Couldn't open socket (28:2:1). Address family not supported by protocol
[main] Couldn't open socket (12:5:2). Address family not supported by protocol
[main] Couldn't open socket (12:1:2). Address family not supported by protocol
[main] Couldn't open socket (12:5:2). Address family not supported by protocol
[main] Couldn't open socket (12:1:2). Address family not supported by protocol
[main] Couldn't open socket (12:5:2). Address family not supported by protocol
[main] Couldn't open socket (12:1:2). Address family not supported by protocol
[main] Couldn't open socket (12:5:2). Address family not supported by protocol
[main] Couldn't open socket (12:1:2). Address family not supported by protocol
[main] Couldn't open socket (12:1:2). Address family not supported by protocol
[main] Couldn't open socket (12:5:2). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (42:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:1:0). Address family not supported by protocol
[main] Couldn't open socket (30:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:5:0). Address family not supported by protocol
[main] Couldn't open socket (30:1:0). Address family not supported by protocol
[main] Couldn't open socket (30:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:5:0). Address family not supported by protocol
[main] Couldn't open socket (30:5:0). Address family not supported by protocol
[main] Couldn't open socket (16:3:18). Protocol not supported
[main] Couldn't open socket (16:3:14). Protocol not supported
[main] Couldn't open socket (16:2:6). Protocol not supported
[main] Couldn't open socket (16:3:20). Protocol not supported
[main] Couldn't open socket (16:2:20). Protocol not supported
[main] Couldn't open socket (16:2:6). Protocol not supported
[main] Couldn't open socket (16:3:6). Protocol not supported
[main] Couldn't open socket (16:2:6). Protocol not supported
[main] Couldn't open socket (36:2:4). Address family not supported by protocol
[main] Couldn't open socket (36:2:6). Address family not supported by protocol
[main] Couldn't open socket (36:2:3). Address family not supported by protocol
[main] Couldn't open socket (36:2:2). Address family not supported by protocol
[main] Couldn't open socket (36:2:2). Address family not supported by protocol
[main] Couldn't open socket (36:2:1). Address family not supported by protocol
[main] Couldn't open socket (36:2:3). Address family not supported by protocol
[main] Couldn't open socket (36:2:3). Address family not supported by protocol
[main] Couldn't open socket (36:2:10). Address family not supported by protocol
[main] Couldn't open socket (36:2:3). Address family not supported by protocol
[main] Couldn't open socket (39:5:0). Address family not supported by protocol
[main] Couldn't open socket (39:1:1). Address family not supported by protocol
[main] Couldn't open socket (39:1:1). Address family not supported by protocol
[main] Couldn't open socket (39:3:1). Address family not supported by protocol
[main] Couldn't open socket (39:3:1). Address family not supported by protocol
[main] Couldn't open socket (39:3:0). Address family not supported by protocol
[main] Couldn't open socket (39:3:1). Address family not supported by protocol
[main] Couldn't open socket (39:1:1). Address family not supported by protocol
[main] Couldn't open socket (39:1:1). Address family not supported by protocol
[main] Couldn't open socket (39:5:0). Address family not supported by protocol
[main] Couldn't open socket (24:5:2). Address family not supported by protocol
[main] Couldn't open socket (24:2:1). Address family not supported by protocol
[main] Couldn't open socket (24:5:1). Address family not supported by protocol
[main] Couldn't open socket (24:1:0). Address family not supported by protocol
[main] Couldn't open socket (24:3:0). Address family not supported by protocol
[main] Couldn't open socket (24:5:2). Address family not supported by protocol
[main] Couldn't open socket (24:1:0). Address family not supported by protocol
[main] Couldn't open socket (24:3:1). Address family not supported by protocol
[main] Couldn't open socket (24:2:2). Address family not supported by protocol
[main] Couldn't open socket (24:2:2). Address family not supported by protocol
[main] Couldn't open socket (41:10:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (41:10:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (41:10:0). Address family not supported by protocol
[main] Couldn't open socket (41:10:0). Address family not supported by protocol
[main] Couldn't open socket (41:10:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:1:0). Address family not supported by protocol
[main] Couldn't open socket (30:1:0). Address family not supported by protocol
[main] Couldn't open socket (30:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:1:0). Address family not supported by protocol
[main] Couldn't open socket (30:5:0). Address family not supported by protocol
[main] Couldn't open socket (30:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:1:0). Address family not supported by protocol
[main] Couldn't open socket (30:2:0). Address family not supported by protocol
[main] Couldn't open socket (30:2:0). Address family not supported by protocol
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol LLC
Can't do protocol LLC
Can't do protocol LLC
Can't do protocol LLC
Can't do protocol LLC
Can't do protocol LLC
Can't do protocol LLC
Can't do protocol LLC
Can't do protocol LLC
Can't do protocol LLC
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (2:1:132). Protocol not supported
[main] Couldn't open socket (2:6:33). Socket type not supported
[main] Couldn't open socket (2:6:33). Socket type not supported
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
Can't do protocol SECURITY
[main] Couldn't open socket (2:5:132). Socket type not supported
[main] Couldn't open socket (2:5:0). Socket type not supported
[main] Couldn't open socket (2:1:132). Protocol not supported
[main] Couldn't open socket (2:5:0). Socket type not supported
[main] Couldn't open socket (2:1:132). Protocol not supported
Can't do protocol KEY
Can't do protocol KEY
Can't do protocol KEY
Can't do protocol KEY
Can't do protocol KEY
Can't do protocol KEY
Can't do protocol KEY
Can't do protocol KEY
Can't do protocol KEY
Can't do protocol KEY
Can't do protocol NETBEUI
Can't do protocol NETBEUI
Can't do protocol NETBEUI
Can't do protocol NETBEUI
Can't do protocol NETBEUI
Can't do protocol NETBEUI
Can't do protocol NETBEUI
Can't do protocol NETBEUI
Can't do protocol NETBEUI
Can't do protocol NETBEUI
[main] Couldn't open socket (27:1:4). Address family not supported by protocol
[main] Couldn't open socket (27:1:1). Address family not supported by protocol
[main] Couldn't open socket (27:1:4). Address family not supported by protocol
[main] Couldn't open socket (27:1:3). Address family not supported by protocol
[main] Couldn't open socket (27:1:4). Address family not supported by protocol
[main] Couldn't open socket (27:1:2). Address family not supported by protocol
[main] Couldn't open socket (27:1:3). Address family not supported by protocol
[main] Couldn't open socket (27:1:1). Address family not supported by protocol
[main] Couldn't open socket (27:1:5). Address family not supported by protocol
[main] Couldn't open socket (27:1:2). Address family not supported by protocol
[main] Couldn't open socket (5:2:0). Address family not supported by protocol
[main] Couldn't open socket (5:3:0). Address family not supported by protocol
[main] Couldn't open socket (5:2:0). Address family not supported by protocol
[main] Couldn't open socket (5:2:0). Address family not supported by protocol
[main] Couldn't open socket (5:2:0). Address family not supported by protocol
[main] Couldn't open socket (5:2:0). Address family not supported by protocol
[main] Couldn't open socket (5:3:0). Address family not supported by protocol
[main] Couldn't open socket (5:3:0). Address family not supported by protocol
[main] Couldn't open socket (5:3:0). Address family not supported by protocol
[main] Couldn't open socket (5:2:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
Can't do protocol ECONET
Can't do protocol ECONET
Can't do protocol ECONET
Can't do protocol ECONET
Can't do protocol ECONET
Can't do protocol ECONET
Can't do protocol ECONET
Can't do protocol ECONET
Can't do protocol ECONET
Can't do protocol ECONET
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
Can't do protocol UNSPEC
[main] Couldn't open socket (27:5:4). Address family not supported by protocol
[main] Couldn't open socket (27:5:3). Address family not supported by protocol
[main] Couldn't open socket (27:5:3). Address family not supported by protocol
[main] Couldn't open socket (27:5:10). Address family not supported by protocol
[main] Couldn't open socket (27:5:10). Address family not supported by protocol
[main] Couldn't open socket (27:5:2). Address family not supported by protocol
[main] Couldn't open socket (27:5:2). Address family not supported by protocol
[main] Couldn't open socket (27:5:3). Address family not supported by protocol
[main] Couldn't open socket (27:5:1). Address family not supported by protocol
[main] Couldn't open socket (27:5:5). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (9:5:0). Address family not supported by protocol
[main] Couldn't open socket (36:5:5). Address family not supported by protocol
[main] Couldn't open socket (36:5:10). Address family not supported by protocol
[main] Couldn't open socket (36:5:10). Address family not supported by protocol
[main] Couldn't open socket (36:5:6). Address family not supported by protocol
[main] Couldn't open socket (36:5:1). Address family not supported by protocol
[main] Couldn't open socket (36:5:6). Address family not supported by protocol
[main] Couldn't open socket (36:5:4). Address family not supported by protocol
[main] Couldn't open socket (36:5:4). Address family not supported by protocol
[main] Couldn't open socket (36:5:5). Address family not supported by protocol
[main] Couldn't open socket (36:5:10). Address family not supported by protocol
Can't do protocol PACKET
Can't do protocol PACKET
Can't do protocol PACKET
Can't do protocol PACKET
Can't do protocol PACKET
Can't do protocol PACKET
Can't do protocol PACKET
Can't do protocol PACKET
Can't do protocol PACKET
Can't do protocol PACKET
[main] Couldn't open socket (43:1:0). Address family not supported by protocol
[main] Couldn't open socket (43:1:6). Address family not supported by protocol
[main] Couldn't open socket (43:1:0). Address family not supported by protocol
[main] Couldn't open socket (43:1:0). Address family not supported by protocol
[main] Couldn't open socket (43:1:0). Address family not supported by protocol
[main] Couldn't open socket (43:1:6). Address family not supported by protocol
[main] Couldn't open socket (43:1:6). Address family not supported by protocol
[main] Couldn't open socket (43:1:6). Address family not supported by protocol
[main] Couldn't open socket (43:1:0). Address family not supported by protocol
[main] Couldn't open socket (43:1:6). Address family not supported by protocol
[main] Couldn't open socket (2:5:0). Socket type not supported
[main] Couldn't open socket (2:5:132). Socket type not supported
[main] Couldn't open socket (2:6:33). Socket type not supported
[main] Couldn't open socket (2:5:0). Socket type not supported
[main] Couldn't open socket (2:5:0). Socket type not supported
[main] Couldn't open socket (2:5:132). Socket type not supported
[main] Couldn't open socket (2:5:0). Socket type not supported
[main] Enabled 14/14 fd providers. initialized:14.
[main] Error opening tracing_on : Permission denied

--bbsc4onnfrc2chh7--
