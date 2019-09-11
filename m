Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A6BC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE7321928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfIKJvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:51:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:49703 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfIKJvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:51:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 02:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="xz'?yaml'?scan'208";a="336206421"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by orsmga004.jf.intel.com with ESMTP; 11 Sep 2019 02:51:27 -0700
Date:   Wed, 11 Sep 2019 17:51:21 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Ido Schimmel <idosch@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        David Ahern <dsahern@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: [ipv6] d5382fef70: kernel_selftests.net.fib_tests.sh.fail
Message-ID: <20190911095121.GU15734@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8KmZJhJMEENkOiL3"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8KmZJhJMEENkOiL3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: d5382fef70ce273608d6fc652c24f075de3737ef ("ipv6: Stop sending in-kernel notifications for each nexthop")
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master

in testcase: kernel_selftests
with following parameters:

	group: kselftests-02

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


# selftests: net: fib_tests.sh
# 
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [ OK ]
#     TEST: IPv6 fibmatch - no route                                      [ OK ]
# 
# Multipath route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     One nexthop device deleted
#     TEST: IPv4 - multipath route removed on delete                      [ OK ]
#     TEST: IPv6 - multipath down to single path                          [ OK ]
#     Second nexthop device deleted
#     TEST: IPv6 - no route                                               [ OK ]
# 
# Single path, admin down
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     Route deleted on down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
# 
# Admin down multipath
#     Verify start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     One device down, one up
#     TEST: IPv4 fibmatch on down device                                  [ OK ]
#     TEST: IPv6 fibmatch on down device                                  [ OK ]
#     TEST: IPv4 fibmatch on up device                                    [ OK ]
#     TEST: IPv6 fibmatch on up device                                    [ OK ]
#     TEST: IPv4 flags on down device                                     [ OK ]
#     TEST: IPv6 flags on down device                                     [ OK ]
#     TEST: IPv4 flags on up device                                       [ OK ]
#     TEST: IPv6 flags on up device                                       [ OK ]
#     Other device down and up
#     TEST: IPv4 fibmatch on down device                                  [ OK ]
#     TEST: IPv6 fibmatch on down device                                  [ OK ]
#     TEST: IPv4 fibmatch on up device                                    [ OK ]
#     TEST: IPv6 fibmatch on up device                                    [ OK ]
#     TEST: IPv4 flags on down device                                     [ OK ]
#     TEST: IPv6 flags on down device                                     [ OK ]
#     TEST: IPv4 flags on up device                                       [ OK ]
#     TEST: IPv6 flags on up device                                       [ OK ]
#     Both devices down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
# 
# Local carrier tests - single path
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 - no linkdown flag                                       [ OK ]
#     TEST: IPv6 - no linkdown flag                                       [ OK ]
#     Carrier off on nexthop
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 - linkdown flag set                                      [ OK ]
#     TEST: IPv6 - linkdown flag set                                      [ OK ]
#     Route to local address with carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
# 
# Single path route carrier test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 no linkdown flag                                         [ OK ]
#     TEST: IPv6 no linkdown flag                                         [ OK ]
#     Carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
#     Second address added with carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
# 
# IPv4 nexthop tests
# <<< write me >>>
# 
# IPv6 nexthop tests
#     TEST: Directly connected nexthop, unicast address                   [ OK ]
#     TEST: Directly connected nexthop, unicast address with device       [ OK ]
#     TEST: Gateway is linklocal address                                  [ OK ]
#     TEST: Gateway is linklocal address, no device                       [ OK ]
#     TEST: Gateway can not be local unicast address                      [ OK ]
#     TEST: Gateway can not be local unicast address, with device         [ OK ]
#     TEST: Gateway can not be a local linklocal address                  [ OK ]
#     TEST: Gateway can be local address in a VRF                         [ OK ]
#     TEST: Gateway can be local address in a VRF, with device            [ OK ]
#     TEST: Gateway can be local linklocal address in a VRF               [ OK ]
#     TEST: Redirect to VRF lookup                                        [ OK ]
#     TEST: VRF route, gateway can be local address in default VRF        [ OK ]
#     TEST: VRF route, gateway can not be a local address                 [ OK ]
#     TEST: VRF route, gateway can not be a local addr with device        [ OK ]
# 
# IPv6 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [ OK ]
#     TEST: Attempt to add duplicate route - dev only                     [ OK ]
#     TEST: Attempt to add duplicate route - reject route                 [ OK ]
#     TEST: Append nexthop to existing route - gw                         [ OK ]
#     TEST: Add multipath route                                           [ OK ]
#     TEST: Attempt to add duplicate multipath route                      [ OK ]
#     TEST: Route add with different metrics                              [ OK ]
#     TEST: Route delete with metric                                      [ OK ]
# 
# IPv6 route replace tests
#     TEST: Single path with single path                                  [ OK ]
#     TEST: Single path with multipath                                    [ OK ]
#     TEST: Single path with single path via multipath attribute          [ OK ]
#     TEST: Invalid nexthop                                               [ OK ]
#     TEST: Single path - replace of non-existent route                   [ OK ]
#     TEST: Multipath with multipath                                      [ OK ]
#     TEST: Multipath with single path                                    [ OK ]
#     TEST: Multipath with single path via multipath attribute            [ OK ]
#     TEST: Multipath - invalid first nexthop                             [ OK ]
#     TEST: Multipath - invalid second nexthop                            [ OK ]
#     TEST: Multipath - replace of non-existent route                     [ OK ]
# 
# IPv4 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [ OK ]
#     TEST: Attempt to add duplicate route - dev only                     [ OK ]
#     TEST: Attempt to add duplicate route - reject route                 [ OK ]
#     TEST: Add new nexthop for existing prefix                           [ OK ]
#     TEST: Append nexthop to existing route - gw                         [ OK ]
#     TEST: Append nexthop to existing route - dev only                   [ OK ]
#     TEST: Append nexthop to existing route - reject route               [ OK ]
#     TEST: Append nexthop to existing reject route - gw                  [ OK ]
#     TEST: Append nexthop to existing reject route - dev only            [ OK ]
#     TEST: add multipath route                                           [ OK ]
#     TEST: Attempt to add duplicate multipath route                      [ OK ]
#     TEST: Route add with different metrics                              [ OK ]
#     TEST: Route delete with metric                                      [ OK ]
# 
# IPv4 route replace tests
#     TEST: Single path with single path                                  [ OK ]
#     TEST: Single path with multipath                                    [ OK ]
#     TEST: Single path with reject route                                 [ OK ]
#     TEST: Single path with single path via multipath attribute          [ OK ]
#     TEST: Invalid nexthop                                               [ OK ]
#     TEST: Single path - replace of non-existent route                   [ OK ]
#     TEST: Multipath with multipath                                      [ OK ]
#     TEST: Multipath with single path                                    [ OK ]
#     TEST: Multipath with single path via multipath attribute            [ OK ]
#     TEST: Multipath with reject route                                   [ OK ]
#     TEST: Multipath - invalid first nexthop                             [ OK ]
#     TEST: Multipath - invalid second nexthop                            [ OK ]
#     TEST: Multipath - replace of non-existent route                     [ OK ]
# 
# IPv6 prefix route tests
#     TEST: Default metric                                                [ OK ]
#     TEST: User specified metric on first device                         [ OK ]
#     TEST: User specified metric on second device                        [ OK ]
#     TEST: Delete of address on first device                             [ OK ]
#     TEST: Modify metric of address                                      [ OK ]
#     TEST: Prefix route removed on link down                             [ OK ]
#     TEST: Prefix route with metric on link up                           [ OK ]
# 
# IPv4 prefix route tests
#     TEST: Default metric                                                [ OK ]
#     TEST: User specified metric on first device                         [ OK ]
#     TEST: User specified metric on second device                        [ OK ]
#     TEST: Delete of address on first device                             [ OK ]
#     TEST: Modify metric of address                                      [ OK ]
#     TEST: Prefix route removed on link down                             [ OK ]
#     TEST: Prefix route with metric on link up                           [ OK ]
# 
# IPv6 routes with metrics
#     TEST: Single path route with mtu metric                             [FAIL]
#     TEST: Multipath route via 2 single routes with mtu metric on first  [FAIL]
#     TEST: Multipath route via 2 single routes with mtu metric on 2nd    [FAIL]
#     TEST: Multipath route with mtu metric                               [FAIL]
# RTNETLINK answers: No route to host
#     TEST: Using route with mtu metric                                   [FAIL]
#     TEST: Invalid metric (fails metric_convert)                         [ OK ]
# 
# IPv4 route add / append tests
#     TEST: Single path route with mtu metric                             [ OK ]
#     TEST: Multipath route with mtu metric                               [ OK ]
#     TEST: Using route with mtu metric                                   [ OK ]
#     TEST: Invalid metric (fails metric_convert)                         [ OK ]
# 
# IPv4 route with IPv6 gateway tests
#     TEST: Single path route with IPv6 gateway                           [FAIL]
#     TEST: Single path route with IPv6 gateway - ping                    [FAIL]
#     TEST: Single path route delete                                      [FAIL]
#     TEST: Multipath route add - v6 nexthop then v4                      [FAIL]
#     TEST:     Multipath route delete - nexthops in wrong order          [ OK ]
#     TEST:     Multipath route delete exact match                        [FAIL]
#     TEST: Multipath route add - v4 nexthop then v6                      [FAIL]
#     TEST:     Multipath route delete - nexthops in wrong order          [ OK ]
#     TEST:     Multipath route delete exact match                        [FAIL]
# 
# Tests passed: 137
# Tests failed:  12
not ok 13 selftests: net: fib_tests.sh


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml



Thanks,
Rong Chen


--8KmZJhJMEENkOiL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.2.0-rc5-01201-gd5382fef70ce2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.2.0-rc5 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70400
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
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
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
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

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
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
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
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
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
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
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
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
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
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
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_VERIFY_SIG=y
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

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
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
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
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
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

CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
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
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
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
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

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
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
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
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
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
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
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
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM_MIRROR=y
CONFIG_ARCH_HAS_HMM_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_MIGRATE_VMA_HELPER=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_FAILOVER=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
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
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

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
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

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
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set
# CONFIG_IWLWIFI_PCIE_RTPM is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
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
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
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
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

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
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
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
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# end of Serial drivers

# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
# CONFIG_IR_IMON_DECODER is not set
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
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
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
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
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
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
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
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
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
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
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
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
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CARVEOUT_HEAP is not set
# CONFIG_ION_CHUNK_HEAP is not set
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_EROFS_FS is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set

#
# ISDN CAPI drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
# end of ISDN CAPI drivers

CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
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
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
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
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

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
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
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
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

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
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
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
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
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
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
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
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
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
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
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
CONFIG_BOOT_PRINTK_DELAY=y
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
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
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
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

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
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
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
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
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
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
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
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
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
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--8KmZJhJMEENkOiL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel_selftests'
	export testcase='kernel_selftests'
	export category='functional'
	export need_memory='3G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='/cephfs/jenkins/jobs/lkp-fsgsbase/workspace/lkp-customers/lkp-fsgsbase/test/lkp-csl-2ap3/kernel_selftests.yaml'
	export queue='validate'
	export testbox='lkp-skl-d01'
	export commit='d5382fef70ce273608d6fc652c24f075de3737ef'
	export branch='linus/master'
	export name='/cephfs/jenkins/jobs/lkp-fsgsbase/workspace/lkp-customers/lkp-fsgsbase/test/lkp-csl-2ap3/kernel_selftests.yaml'
	export tbox_group='lkp-skl-d01'
	export submit_id='5d77c0875af90edc90231069'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d01/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-d5382-20190910-56464-1nufxkn-8.yaml'
	export id='2db6f841d8f2ff4a5b90aa561bc7047679e93b2e'
	export queuer_version='/lkp-src'
	export arch='x86_64'
	export need_kernel_headers=true
	export need_kernel_selftests=true
	export need_kconfig='CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_FIRMWARE
CONFIG_TEST_USER_COPY
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_NOTIFIER_ERROR_INJECTION
CONFIG_FTRACE=y
CONFIG_TEST_BITMAP
CONFIG_TEST_PRINTF
CONFIG_TEST_STATIC_KEYS
CONFIG_BPF_SYSCALL=y
CONFIG_NET_CLS_BPF=m
CONFIG_BPF_EVENTS=y
CONFIG_TEST_BPF=m
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HIST_TRIGGERS=y
CONFIG_EMBEDDED=y
CONFIG_GPIO_MOCKUP=y
CONFIG_USERFAULTFD=y
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_PSTORE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_RAM=m
CONFIG_EXPERT=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_EFIVAR_FS
CONFIG_TEST_KMOD=m
CONFIG_TEST_LKM=m
CONFIG_XFS_FS=m
CONFIG_TUN=m
CONFIG_BTRFS_FS=m
CONFIG_TEST_SYSCTL=m
CONFIG_BPF_STREAM_PARSER=y
CONFIG_CGROUP_BPF=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_VRF=y
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_MACSEC=y
CONFIG_X86_INTEL_MPX=y
CONFIG_RC_LOOPBACK
CONFIG_IPV6_SEG6_LWTUNNEL=y ~ v(4\.1[0-9]|4\.20|5\.)
CONFIG_LWTUNNEL=y
CONFIG_WW_MUTEX_SELFTEST=m ~ v(4\.1[1-9]|4\.20|5\.)
CONFIG_DRM_DEBUG_SELFTEST=m ~ v(4\.1[8-9]|4\.20|5\.)
CONFIG_TEST_LIVEPATCH=m ~ v(5\.[1-9])
CONFIG_LIRC=y
CONFIG_IR_SHARP_DECODER=m
CONFIG_ANDROID=y ~ v(3\.[3-9]|3\.1[0-9]|4\.|5\.)
CONFIG_ION=y ~ v(3\.1[4-9]|4\.|5\.)
CONFIG_ION_SYSTEM_HEAP=y ~ v(4\.1[2-9]|4\.20|5\.)
CONFIG_MPLS_ROUTING=m ~ v(4\.[1-9]|4\.1[0-9]|4\.20|5\.)
CONFIG_MPLS_IPTUNNEL=m ~ v(4\.[3-9]|4\.1[0-9]|4\.20|5\.)'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export enqueue_time='2019-09-10 23:26:02 +0800'
	export _id='5d77c0875af90edc90231069'
	export _rt='/result/kernel_selftests/kselftests-02/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef'
	export user='liuyd'
	export result_root='/result/kernel_selftests/kselftests-02/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/8'
	export scheduler_version='/lkp/lkp/.src-20190910-222124'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=liuyd
job=/lkp/jobs/scheduled/lkp-skl-d01/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-d5382-20190910-56464-1nufxkn-8.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linus/master
commit=d5382fef70ce273608d6fc652c24f075de3737ef
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/vmlinuz-5.2.0-rc5-01201-gd5382fef70ce2
erst_disable
max_uptime=3600
RESULT_ROOT=/result/kernel_selftests/kselftests-02/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/8
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2019-09-10.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-d3464ccd105b_2019-09-08.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-08-21.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/linux-selftests.cgz'
	export lkp_initrd='/osimage/user/liuyd/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export model='Skylake'
	export nr_cpu=8
	export memory='16G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part1'
	export swap_partitions='/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part3'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part2'
	export brand='Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz'
	export cpu_info='skylake i7-6700'
	export bios_version='1.2.8'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export repeat_to=12
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/vmlinuz-5.2.0-rc5-01201-gd5382fef70ce2'
	export dequeue_time='2019-09-10 23:33:49 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d01/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-d5382-20190910-56464-1nufxkn-8.cgz'

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

	run_test group='kselftests-02' $LKP_SRC/tests/wrapper kernel_selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kernel_selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel_selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--8KmZJhJMEENkOiL3
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AgAAAAAEWVo=

--8KmZJhJMEENkOiL3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel_selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E6-d5382fef70ce273608d6fc652c24f075de3737ef
media_tests test: not in Makefile
2019-09-10 23:34:55 make TARGETS=3Dmedia_tests
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382f=
ef70ce273608d6fc652c24f075de3737ef'
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (36 files)
  INSTALL usr/include/drm/ (28 files)
  INSTALL usr/include/linux/ (503 files)
  INSTALL usr/include/linux/android/ (2 files)
  INSTALL usr/include/linux/byteorder/ (2 files)
  INSTALL usr/include/linux/caif/ (2 files)
  INSTALL usr/include/linux/can/ (6 files)
  INSTALL usr/include/linux/cifs/ (1 file)
  INSTALL usr/include/linux/dvb/ (8 files)
  INSTALL usr/include/linux/genwqe/ (1 file)
  INSTALL usr/include/linux/hdlc/ (1 file)
  INSTALL usr/include/linux/hsi/ (2 files)
  INSTALL usr/include/linux/iio/ (2 files)
  INSTALL usr/include/linux/isdn/ (1 file)
  INSTALL usr/include/linux/mmc/ (1 file)
  INSTALL usr/include/linux/netfilter/ (88 files)
  INSTALL usr/include/linux/netfilter/ipset/ (4 files)
  INSTALL usr/include/linux/netfilter_arp/ (2 files)
  INSTALL usr/include/linux/netfilter_bridge/ (17 files)
  INSTALL usr/include/linux/netfilter_ipv4/ (9 files)
  INSTALL usr/include/linux/netfilter_ipv6/ (13 files)
  INSTALL usr/include/linux/nfsd/ (5 files)
  INSTALL usr/include/linux/raid/ (2 files)
  INSTALL usr/include/linux/sched/ (1 file)
  INSTALL usr/include/linux/spi/ (1 file)
  INSTALL usr/include/linux/sunrpc/ (1 file)
  INSTALL usr/include/linux/tc_act/ (16 files)
  INSTALL usr/include/linux/tc_ematch/ (5 files)
  INSTALL usr/include/linux/usb/ (13 files)
  INSTALL usr/include/linux/wimax/ (1 file)
  INSTALL usr/include/misc/ (4 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (26 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (5 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/sound/sof/ (8 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fe=
f70ce273608d6fc652c24f075de3737ef'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382f=
ef70ce273608d6fc652c24f075de3737ef/tools/testing/selftests/media_tests'
gcc -I../ -I../../../../usr/include/    media_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de3737ef/tools=
/testing/selftests/media_tests/media_device_test
gcc -I../ -I../../../../usr/include/    media_device_open.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de3737ef/tools=
/testing/selftests/media_tests/media_device_open
gcc -I../ -I../../../../usr/include/    video_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de3737ef/tools=
/testing/selftests/media_tests/video_device_test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fe=
f70ce273608d6fc652c24f075de3737ef/tools/testing/selftests/media_tests'
ignored_by_lkp media_tests test
2019-09-10 23:34:59 make run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef7=
0ce273608d6fc652c24f075de3737ef/tools/testing/selftests/membarrier'
gcc -g -I../../../../usr/include/    membarrier_test.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de3737ef/tools/test=
ing/selftests/membarrier/membarrier_test
TAP version 13
1..1
# selftests: membarrier: membarrier_test
# TAP version 13
# 1..13
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, er=
rno =3D 22. Failed as expected
# ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1,=
 errno =3D 22. Failed as expected
# ok 4 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
# ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failu=
re test: flags =3D 0, errno =3D 1
# ok 6 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags=
 =3D 0
# ok 7 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
# ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not regist=
ered failure test: flags =3D 0, errno =3D 1
# ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE t=
est: flags =3D 0
# ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: fla=
gs =3D 0
# ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags=
 =3D 0
# ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# # Pass 13 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
ok 1 selftests: membarrier: membarrier_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70=
ce273608d6fc652c24f075de3737ef/tools/testing/selftests/membarrier'
2019-09-10 23:35:00 make run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef7=
0ce273608d6fc652c24f075de3737ef/tools/testing/selftests/memfd'
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/   -c -o common.o common.c
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    memfd_test.c common.o  -o /usr/src/perf_=
selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de3737ef/tools/te=
sting/selftests/memfd/memfd_test
memfd_test.c: In function =E2=80=98mfd_assert_reopen_fd=E2=80=99:
memfd_test.c:64:7: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  fd =3D open(path, O_RDWR);
       ^~~~
memfd_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
memfd_test.c:90:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
memfd_test.c: In function =E2=80=98mfd_assert_write=E2=80=99:
memfd_test.c:363:6: warning: implicit declaration of function =E2=80=98fall=
ocate=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fallocate(fd,
      ^~~~~~~~~
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_mnt.c -lfuse -pthread -o /usr/src/p=
erf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de3737ef/tool=
s/testing/selftests/memfd/fuse_mnt
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_test.c common.o  -o /usr/src/perf_s=
elftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de3737ef/tools/tes=
ting/selftests/memfd/fuse_test
fuse_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
fuse_test.c:67:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
fuse_test.c: In function =E2=80=98main=E2=80=99:
fuse_test.c:261:7: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  fd =3D open(argv[1], O_RDONLY | O_CLOEXEC);
       ^~~~
TAP version 13
1..3
# selftests: memfd: memfd_test
# memfd: CREATE
# memfd: BASIC
# memfd: SEAL-WRITE
# memfd: SEAL-FUTURE-WRITE
# memfd: SEAL-SHRINK
# memfd: SEAL-GROW
# memfd: SEAL-RESIZE
# memfd: SHARE-DUP=20
# memfd: SHARE-MMAP=20
# memfd: SHARE-OPEN=20
# memfd: SHARE-FORK=20
# memfd: SHARE-DUP (shared file-table)
# memfd: SHARE-MMAP (shared file-table)
# memfd: SHARE-OPEN (shared file-table)
# memfd: SHARE-FORK (shared file-table)
# memfd: DONE
ok 1 selftests: memfd: memfd_test
# selftests: memfd: run_fuse_test.sh
# opening: ./mnt/memfd
# fuse: DONE
ok 2 selftests: memfd: run_fuse_test.sh
# selftests: memfd: run_hugetlbfs_test.sh
# ./run_hugetlbfs_test.sh: line 60:  7024 Aborted                 ./memfd_t=
est hugetlbfs
# opening: ./mnt/memfd
# fuse: DONE
ok 3 selftests: memfd: run_hugetlbfs_test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70=
ce273608d6fc652c24f075de3737ef/tools/testing/selftests/memfd'
2019-09-10 23:35:03 make run_tests -C memory-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef7=
0ce273608d6fc652c24f075de3737ef/tools/testing/selftests/memory-hotplug'
TAP version 13
1..1
# selftests: memory-hotplug: mem-on-off-test.sh
# Test scope: 2% hotplug memory
# 	 online all hot-pluggable memory in offline state:
# 		 SKIPPED - no hot-pluggable memory in offline state
# 	 offline 2% hot-pluggable memory in online state
# 	 trying to offline 2 out of 88 memory block(s):
# online->offline memory1
# online->offline memory10
# 	 online all hot-pluggable memory in offline state:
# offline->online memory1
# offline->online memory10
# 	 Test with memory notifier error injection
ok 1 selftests: memory-hotplug: mem-on-off-test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70=
ce273608d6fc652c24f075de3737ef/tools/testing/selftests/memory-hotplug'
2019-09-10 23:35:05 make run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef7=
0ce273608d6fc652c24f075de3737ef/tools/testing/selftests/mount'
gcc -Wall -O2    unprivileged-remount-test.c  -o /usr/src/perf_selftests-x8=
6_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de3737ef/tools/testing/selfte=
sts/mount/unprivileged-remount-test
TAP version 13
1..1
# selftests: mount: run_tests.sh
ok 1 selftests: mount: run_tests.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70=
ce273608d6fc652c24f075de3737ef/tools/testing/selftests/mount'
2019-09-10 23:35:05 make run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef7=
0ce273608d6fc652c24f075de3737ef/tools/testing/selftests/mqueue'
gcc -O2    mq_open_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de3737ef/tools/testing/sel=
ftests/mqueue/mq_open_tests
gcc -O2    mq_perf_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de3737ef/tools/testing/sel=
ftests/mqueue/mq_perf_tests
TAP version 13
1..2
# selftests: mqueue: mq_open_tests
# Using Default queue path - /test1
#=20
# Initial system state:
# 	Using queue path:		/test1
# 	RLIMIT_MSGQUEUE(soft):		819200
# 	RLIMIT_MSGQUEUE(hard):		819200
# 	Maximum Message Size:		8192
# 	Maximum Queue Size:		10
# 	Default Message Size:		8192
# 	Default Queue Size:		10
#=20
# Adjusted system state for testing:
# 	RLIMIT_MSGQUEUE(soft):		819200
# 	RLIMIT_MSGQUEUE(hard):		819200
# 	Maximum Message Size:		8192
# 	Maximum Queue Size:		10
# 	Default Message Size:		8192
# 	Default Queue Size:		10
#=20
#=20
# Test series 1, behavior when no attr struct passed to mq_open:
# Kernel supports setting defaults separately from maximums:		PASS
# Given sane values, mq_open without an attr struct succeeds:		PASS
# Kernel properly honors default setting knobs:				PASS
# Kernel properly limits default values to lesser of default/max:		PASS
# Kernel properly fails to create queue when defaults would
# exceed rlimit:								PASS
#=20
#=20
# Test series 2, behavior when attr struct is passed to mq_open:
# Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
# Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
# Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
# Queue open with total size > 2GB when euid =3D 0 failed:			PASS
# Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
# Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
# Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
# Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1 selftests: mqueue: mq_open_tests
# selftests: mqueue: mq_perf_tests
#=20
# Initial system state:
# 	Using queue path:			/mq_perf_tests
# 	RLIMIT_MSGQUEUE(soft):			819200
# 	RLIMIT_MSGQUEUE(hard):			819200
# 	Maximum Message Size:			8192
# 	Maximum Queue Size:			10
# 	Nice value:				0
#=20
# Adjusted system state for testing:
# 	RLIMIT_MSGQUEUE(soft):			(unlimited)
# 	RLIMIT_MSGQUEUE(hard):			(unlimited)
# 	Maximum Message Size:			16777216
# 	Maximum Queue Size:			65530
# 	Nice value:				-20
# 	Continuous mode:			(disabled)
# 	CPUs to pin:				7
#=20
# 	Queue /mq_perf_tests created:
# 		mq_flags:			O_NONBLOCK
# 		mq_maxmsg:			65530
# 		mq_msgsize:			16
# 		mq_curmsgs:			0
#=20
# 	Started mqueue performance test thread on CPU 7
# 		Max priorities:			32768
# 		Clock resolution:		1 nsec
#=20
# 	Test #1: Time send/recv message, queue empty
# 		(10000000 iterations)
# 		Send msg:			7.6841827s total time
# 						700 nsec/msg
# 		Recv msg:			7.175084150s total time
# 						717 nsec/msg
#=20
# 	Test #2a: Time send/recv message, queue full, constant prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.26436552s
# 		Testing...done.
# 		Send msg:			0.74710944s total time
# 						747 nsec/msg
# 		Recv msg:			0.74675017s total time
# 						746 nsec/msg
# 		Draining queue...done.		0.27243533s
#=20
# 	Test #2b: Time send/recv message, queue full, increasing prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.34346807s
# 		Testing...done.
# 		Send msg:			0.81464819s total time
# 						814 nsec/msg
# 		Recv msg:			0.74396660s total time
# 						743 nsec/msg
# 		Draining queue...done.		0.27893035s
#=20
# 	Test #2c: Time send/recv message, queue full, decreasing prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.34620377s
# 		Testing...done.
# 		Send msg:			0.81398517s total time
# 						813 nsec/msg
# 		Recv msg:			0.73615099s total time
# 						736 nsec/msg
# 		Draining queue...done.		0.28148790s
#=20
# 	Test #2d: Time send/recv message, queue full, random prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.39888315s
# 		Testing...done.
# 		Send msg:			0.86596648s total time
# 						865 nsec/msg
# 		Recv msg:			0.78033244s total time
# 						780 nsec/msg
# 		Draining queue...done.		0.30103302s
ok 2 selftests: mqueue: mq_perf_tests
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70=
ce273608d6fc652c24f075de3737ef/tools/testing/selftests/mqueue'
2019-09-10 23:35:24 make run_tests -C net
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef7=
0ce273608d6fc652c24f075de3737ef/tools/testing/selftests/net'
make --no-builtin-rules ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382f=
ef70ce273608d6fc652c24f075de3737ef'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-d5382fe=
f70ce273608d6fc652c24f075de3737ef'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc65=
2c24f075de3737ef/tools/testing/selftests/net/reuseport_bpf
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf_cpu.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6=
fc652c24f075de3737ef/tools/testing/selftests/net/reuseport_bpf_cpu
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf_numa.c -lnuma -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce2=
73608d6fc652c24f075de3737ef/tools/testing/selftests/net/reuseport_bpf_numa
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_dualstack.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608=
d6fc652c24f075de3737ef/tools/testing/selftests/net/reuseport_dualstack
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseaddr=
_conflict.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d=
6fc652c24f075de3737ef/tools/testing/selftests/net/reuseaddr_conflict
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tls.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f075de=
3737ef/tools/testing/selftests/net/tls
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    socket.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f07=
5de3737ef/tools/testing/selftests/net/socket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_fan=
out.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652=
c24f075de3737ef/tools/testing/selftests/net/psock_fanout
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_tpa=
cket.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc65=
2c24f075de3737ef/tools/testing/selftests/net/psock_tpacket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    msg_zeroc=
opy.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652=
c24f075de3737ef/tools/testing/selftests/net/msg_zerocopy
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_addr_any.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d=
6fc652c24f075de3737ef/tools/testing/selftests/net/reuseport_addr_any
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_mmap.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6=
fc652c24f075de3737ef/tools/testing/selftests/net/tcp_mmap
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_inq.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6f=
c652c24f075de3737ef/tools/testing/selftests/net/tcp_inq
tcp_inq.c: In function =E2=80=98main=E2=80=99:
tcp_inq.c:168:4: warning: dereferencing type-punned pointer will break stri=
ct-aliasing rules [-Wstrict-aliasing]
    inq =3D *((int *) CMSG_DATA(cm));
    ^~~
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_snd=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c=
24f075de3737ef/tools/testing/selftests/net/psock_snd
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    txring_ov=
erwrite.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6f=
c652c24f075de3737ef/tools/testing/selftests/net/txring_overwrite
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c24f07=
5de3737ef/tools/testing/selftests/net/udpgso
udpgso.c: In function =E2=80=98send_one=E2=80=99:
udpgso.c:483:3: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules [-Wstrict-aliasing]
   *((uint16_t *) CMSG_DATA(cm)) =3D gso_len;
   ^
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_tx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc=
652c24f075de3737ef/tools/testing/selftests/net/udpgso_bench_tx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_rx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc=
652c24f075de3737ef/tools/testing/selftests/net/udpgso_bench_rx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    ip_defrag=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c=
24f075de3737ef/tools/testing/selftests/net/ip_defrag
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    so_txtime=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc652c=
24f075de3737ef/tools/testing/selftests/net/so_txtime
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    ipv6_flow=
label.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d6fc6=
52c24f075de3737ef/tools/testing/selftests/net/ipv6_flowlabel
ipv6_flowlabel.c: In function =E2=80=98do_send=E2=80=99:
ipv6_flowlabel.c:58:3: warning: dereferencing type-punned pointer will brea=
k strict-aliasing rules [-Wstrict-aliasing]
   *(uint32_t *)CMSG_DATA(cm) =3D htonl(flowlabel);
   ^
ipv6_flowlabel.c: In function =E2=80=98do_recv=E2=80=99:
ipv6_flowlabel.c:114:3: warning: dereferencing type-punned pointer will bre=
ak strict-aliasing rules [-Wstrict-aliasing]
   flowlabel =3D ntohl(*(uint32_t *)CMSG_DATA(cm));
   ^~~~~~~~~
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    ipv6_flow=
label_mgr.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce273608d=
6fc652c24f075de3737ef/tools/testing/selftests/net/ipv6_flowlabel_mgr
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tcp_fasto=
pen_backup_key.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-d5382fef70ce27=
3608d6fc652c24f075de3737ef/tools/testing/selftests/net/tcp_fastopen_backup_=
key
TAP version 13
1..29
# selftests: net: reuseport_bpf
# ---- IPv4 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP w/ mapped IPv4 ----
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# ---- IPv4 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP w/ mapped IPv4 ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing filter add without bind...
# SUCCESS
ok 1 selftests: net: reuseport_bpf
# selftests: net: reuseport_bpf_cpu
# ---- IPv4 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv6 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv4 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv6 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# SUCCESS
ok 2 selftests: net: reuseport_bpf_cpu
# selftests: net: reuseport_bpf_numa
# ---- IPv4 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv4 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# SUCCESS
ok 3 selftests: net: reuseport_bpf_numa
# selftests: net: reuseport_dualstack
# ---- UDP IPv4 created before IPv6 ----
# ---- UDP IPv6 created before IPv4 ----
# ---- UDP IPv4 created before IPv6 (large) ----
# ---- UDP IPv6 created before IPv4 (large) ----
# ---- TCP IPv4 created before IPv6 ----
# ---- TCP IPv6 created before IPv4 ----
# SUCCESS
ok 4 selftests: net: reuseport_dualstack
# selftests: net: reuseaddr_conflict
# Opening 127.0.0.1:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening in6addr_any:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening INADDR_ANY:9999 after closing ipv6 socket
# bind: Address already in use
# Successok 5 selftests: net: reuseaddr_conflict
# selftests: net: tls
# [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 33 tests from 2 test cases.
# [ RUN      ] tls.sendfile
# [       OK ] tls.sendfile
# [ RUN      ] tls.send_then_sendfile
# [       OK ] tls.send_then_sendfile
# [ RUN      ] tls.recv_max
# [       OK ] tls.recv_max
# [ RUN      ] tls.recv_small
# [       OK ] tls.recv_small
# [ RUN      ] tls.msg_more
# [       OK ] tls.msg_more
# [ RUN      ] tls.sendmsg_single
# [       OK ] tls.sendmsg_single
# [ RUN      ] tls.sendmsg_large
# [       OK ] tls.sendmsg_large
# [ RUN      ] tls.sendmsg_multiple
# [       OK ] tls.sendmsg_multiple
# [ RUN      ] tls.sendmsg_multiple_stress
# [       OK ] tls.sendmsg_multiple_stress
# [ RUN      ] tls.splice_from_pipe
# [       OK ] tls.splice_from_pipe
# [ RUN      ] tls.splice_from_pipe2
# [       OK ] tls.splice_from_pipe2
# [ RUN      ] tls.send_and_splice
# [       OK ] tls.send_and_splice
# [ RUN      ] tls.splice_to_pipe
# [       OK ] tls.splice_to_pipe
# [ RUN      ] tls.recvmsg_single
# [       OK ] tls.recvmsg_single
# [ RUN      ] tls.recvmsg_single_max
# [       OK ] tls.recvmsg_single_max
# [ RUN      ] tls.recvmsg_multiple
# [       OK ] tls.recvmsg_multiple
# [ RUN      ] tls.single_send_multiple_recv
# [       OK ] tls.single_send_multiple_recv
# [ RUN      ] tls.multiple_send_single_recv
# [       OK ] tls.multiple_send_single_recv
# [ RUN      ] tls.single_send_multiple_recv_non_align
# [       OK ] tls.single_send_multiple_recv_non_align
# [ RUN      ] tls.recv_partial
# [       OK ] tls.recv_partial
# [ RUN      ] tls.recv_nonblock
# [       OK ] tls.recv_nonblock
# [ RUN      ] tls.recv_peek
# [       OK ] tls.recv_peek
# [ RUN      ] tls.recv_peek_multiple
# [       OK ] tls.recv_peek_multiple
# [ RUN      ] tls.recv_peek_multiple_records
# [       OK ] tls.recv_peek_multiple_records
# [ RUN      ] tls.recv_peek_large_buf_mult_recs
# [       OK ] tls.recv_peek_large_buf_mult_recs
# [ RUN      ] tls.recv_lowat
# [       OK ] tls.recv_lowat
# [ RUN      ] tls.pollin
# [       OK ] tls.pollin
# [ RUN      ] tls.poll_wait
# [       OK ] tls.poll_wait
# [ RUN      ] tls.blocking
# [       OK ] tls.blocking
# [ RUN      ] tls.nonblocking
# [       OK ] tls.nonblocking
# [ RUN      ] tls.control_msg
# [       OK ] tls.control_msg
# [ RUN      ] global.keysizes
# [       OK ] global.keysizes
# [ RUN      ] global.tls12
# [       OK ] global.tls12
# [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 33 / 33 tests passed.
# [  PASSED  ]
ok 6 selftests: net: tls
# selftests: net: run_netsocktests
# --------------------
# running socket test
# --------------------
# [PASS]
ok 7 selftests: net: run_netsocktests
# selftests: net: run_afpackettests
# --------------------
# running psock_fanout test
# --------------------
# test: control single socket
# test: control multiple sockets
# test: unique ids
#=20
# test: datapath 0x0 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D5,20, expect=3D20,5
#=20
# test: datapath 0x1000 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D15,20, expect=3D20,15
#=20
# test: datapath 0x1 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D10,10, expect=3D10,10
# info: count=3D17,18, expect=3D18,17
#=20
# test: datapath 0x3 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,15, expect=3D20,15
#=20
# test: datapath 0x6 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x7 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x2 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,0, expect=3D20,0
# info: count=3D20,0, expect=3D20,0
#=20
# test: datapath 0x2 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D0,20, expect=3D0,20
# info: count=3D0,20, expect=3D0,20
#=20
# test: datapath 0x2000 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,20, expect=3D20,20
# info: count=3D20,20, expect=3D20,20
# OK. All tests passed
# [PASS]
# --------------------
# running psock_tpacket test
# --------------------
# test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# OK. All tests passed
# [PASS]
# --------------------
# running txring_overwrite test
# --------------------
# read: a (0x61)
# read: b (0x62)
# [PASS]
ok 8 selftests: net: run_afpackettests
# selftests: net: test_bpf.sh
# test_bpf: ok
ok 9 selftests: net: test_bpf.sh
# selftests: net: netdevice.sh
# SKIP: eth0: interface already up
# Cannot get device udp-fragmentation-offload settings: Operation not suppo=
rted
# PASS: eth0: ethtool list features
# PASS: eth0: ethtool dump
# PASS: eth0: ethtool stats
# SKIP: eth0: interface kept up
ok 10 selftests: net: netdevice.sh
# selftests: net: rtnetlink.sh
# PASS: policy routing
# PASS: route get
# PASS: preferred_lft addresses have expired
# PASS: tc htb hierarchy
# PASS: gre tunnel endpoint
# PASS: gretap
# PASS: ip6gretap
# PASS: erspan
# PASS: ip6erspan
# PASS: bridge setup
# PASS: ipv6 addrlabel
# PASS: set ifalias d87c8371-5f4e-492c-94ff-589cea9234e2 for test-dummy0
# PASS: vrf
# PASS: vxlan
# PASS: fou
# PASS: macsec
# PASS: ipsec
# FAIL: ipsec_offload netdevsim doesn't support IPsec offload
# SKIP: fdb get tests: iproute2 too old
# SKIP: fdb get tests: iproute2 too old
ok 11 selftests: net: rtnetlink.sh
# selftests: net: xfrm_policy.sh
# PASS: policy before exception matches
# PASS: ping to .254 bypassed ipsec tunnel (exceptions)
# PASS: direct policy matches (exceptions)
# PASS: policy matches (exceptions)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies)
# PASS: direct policy matches (exceptions and block policies)
# PASS: policy matches (exceptions and block policies)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hresh changes)
# PASS: direct policy matches (exceptions and block policies after hresh ch=
anges)
# PASS: policy matches (exceptions and block policies after hresh changes)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hthresh change in ns3)
# PASS: direct policy matches (exceptions and block policies after hthresh =
change in ns3)
# PASS: policy matches (exceptions and block policies after hthresh change =
in ns3)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hresh change to normal)
# PASS: direct policy matches (exceptions and block policies after hresh ch=
ange to normal)
# PASS: policy matches (exceptions and block policies after hresh change to=
 normal)
ok 12 selftests: net: xfrm_policy.sh
# selftests: net: fib_tests.sh
#=20
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [=
 OK ]
#     TEST: IPv6 fibmatch - no route                                      [=
 OK ]
#=20
# Multipath route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One nexthop device deleted
#     TEST: IPv4 - multipath route removed on delete                      [=
 OK ]
#     TEST: IPv6 - multipath down to single path                          [=
 OK ]
#     Second nexthop device deleted
#     TEST: IPv6 - no route                                               [=
 OK ]
#=20
# Single path, admin down
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Route deleted on down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Admin down multipath
#     Verify start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One device down, one up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Other device down and up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Both devices down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Local carrier tests - single path
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - no linkdown flag                                       [=
 OK ]
#     TEST: IPv6 - no linkdown flag                                       [=
 OK ]
#     Carrier off on nexthop
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - linkdown flag set                                      [=
 OK ]
#     TEST: IPv6 - linkdown flag set                                      [=
 OK ]
#     Route to local address with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# Single path route carrier test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 no linkdown flag                                         [=
 OK ]
#     TEST: IPv6 no linkdown flag                                         [=
 OK ]
#     Carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#     Second address added with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# IPv4 nexthop tests
# <<< write me >>>
#=20
# IPv6 nexthop tests
#     TEST: Directly connected nexthop, unicast address                   [=
 OK ]
#     TEST: Directly connected nexthop, unicast address with device       [=
 OK ]
#     TEST: Gateway is linklocal address                                  [=
 OK ]
#     TEST: Gateway is linklocal address, no device                       [=
 OK ]
#     TEST: Gateway can not be local unicast address                      [=
 OK ]
#     TEST: Gateway can not be local unicast address, with device         [=
 OK ]
#     TEST: Gateway can not be a local linklocal address                  [=
 OK ]
#     TEST: Gateway can be local address in a VRF                         [=
 OK ]
#     TEST: Gateway can be local address in a VRF, with device            [=
 OK ]
#     TEST: Gateway can be local linklocal address in a VRF               [=
 OK ]
#     TEST: Redirect to VRF lookup                                        [=
 OK ]
#     TEST: VRF route, gateway can be local address in default VRF        [=
 OK ]
#     TEST: VRF route, gateway can not be a local address                 [=
 OK ]
#     TEST: VRF route, gateway can not be a local addr with device        [=
 OK ]
#=20
# IPv6 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv6 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Add new nexthop for existing prefix                           [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Append nexthop to existing route - dev only                   [=
 OK ]
#     TEST: Append nexthop to existing route - reject route               [=
 OK ]
#     TEST: Append nexthop to existing reject route - gw                  [=
 OK ]
#     TEST: Append nexthop to existing reject route - dev only            [=
 OK ]
#     TEST: add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv4 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with reject route                                 [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath with reject route                                   [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv6 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#=20
# IPv4 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#=20
# IPv6 routes with metrics
#     TEST: Single path route with mtu metric                             [=
FAIL]
#     TEST: Multipath route via 2 single routes with mtu metric on first  [=
FAIL]
#     TEST: Multipath route via 2 single routes with mtu metric on 2nd    [=
FAIL]
#     TEST: Multipath route with mtu metric                               [=
FAIL]
# RTNETLINK answers: No route to host
#     TEST: Using route with mtu metric                                   [=
FAIL]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route with IPv6 gateway tests
#     TEST: Single path route with IPv6 gateway                           [=
FAIL]
#     TEST: Single path route with IPv6 gateway - ping                    [=
FAIL]
#     TEST: Single path route delete                                      [=
FAIL]
#     TEST: Multipath route add - v6 nexthop then v4                      [=
FAIL]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
FAIL]
#     TEST: Multipath route add - v4 nexthop then v6                      [=
FAIL]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
FAIL]
#=20
# Tests passed: 137
# Tests failed:  12
not ok 13 selftests: net: fib_tests.sh
# selftests: net: fib-onlink-tests.sh
# Error: ipv4: FIB table does not exist.
# Flush terminated
# Error: ipv6: FIB table does not exist.
# Flush terminated
#=20
# ########################################
# Configuring interfaces
# Error: netdevsim: Exceeded number of supported fib entries.
not ok 14 selftests: net: fib-onlink-tests.sh
# selftests: net: pmtu.sh
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: ipv4: PMTU exceptions                                         [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: Network is unreachable
# TEST: ipv6: PMTU exceptions                                         [FAIL]
#   PMTU exception wasn't created after exceeding MTU
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# RTNETLINK answers: Network is unreachable
# TEST: ipv6: PMTU exceptions - nexthop objects                       [FAIL]
#   PMTU exception wasn't created after exceeding MTU
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: IPv4 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over vxlan4: PMTU exceptions                             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on vxlan i=
nterface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over vxlan4: PMTU exceptions - nexthop objects           [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on vxlan i=
nterface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: IPv4 over vxlan6: PMTU exceptions                             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on vxlan i=
nterface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: IPv4 over vxlan6: PMTU exceptions - nexthop objects           [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on vxlan i=
nterface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over vxlan6: PMTU exceptions                             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on vxlan i=
nterface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over vxlan6: PMTU exceptions - nexthop objects           [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on vxlan i=
nterface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: IPv4 over geneve4: PMTU exceptions                            [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: IPv4 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over geneve4: PMTU exceptions                            [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve =
interface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over geneve4: PMTU exceptions - nexthop objects          [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve =
interface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: IPv4 over geneve6: PMTU exceptions                            [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve =
interface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: IPv4 over geneve6: PMTU exceptions - nexthop objects          [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve =
interface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over geneve6: PMTU exceptions                            [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve =
interface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over geneve6: PMTU exceptions - nexthop objects          [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve =
interface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: IPv4 over fou4: PMTU exceptions                               [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: IPv4 over fou4: PMTU exceptions - nexthop objects             [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over fou4: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on fou int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over fou4: PMTU exceptions - nexthop objects             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on fou int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: IPv4 over fou6: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on fou int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: IPv4 over fou6: PMTU exceptions - nexthop objects             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on fou int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over fou6: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on fou int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over fou6: PMTU exceptions - nexthop objects             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on fou int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: IPv4 over gue4: PMTU exceptions                               [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: IPv4 over gue4: PMTU exceptions - nexthop objects             [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over gue4: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on gue int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over gue4: PMTU exceptions - nexthop objects             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on gue int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: IPv4 over gue6: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on gue int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: IPv4 over gue6: PMTU exceptions - nexthop objects             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on gue int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over gue6: PMTU exceptions                               [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on gue int=
erface
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# RTNETLINK answers: Network is unreachable
# TEST: IPv6 over gue6: PMTU exceptions - nexthop objects             [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on gue int=
erface
# RTNETLINK answers: Network is unreachable
# TEST: vti6: PMTU exceptions                                         [FAIL]
#   PMTU exception wasn't created after creating tunnel exceeding link laye=
r MTU
# TEST: vti4: PMTU exceptions                                         [ OK ]
# TEST: vti4: default MTU assignment                                  [ OK ]
# TEST: vti6: default MTU assignment                                  [FAIL]
#   vti MTU 1332 is not veth MTU 1500 minus IPv6 header length
# TEST: vti4: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU changes on link changes                             [FAIL]
#   vti MTU 1332 is not dummy MTU 3000 minus IPv6 header length
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: ipv4: cleanup of cached exceptions                            [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: ipv4: cleanup of cached exceptions - nexthop objects          [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# TEST: ipv6: cleanup of cached exceptions                            [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# TEST: ipv6: cleanup of cached exceptions - nexthop objects          [ OK ]
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: Network is unreachable
# RTNETLINK answers: Network is unreachable
# TEST: ipv6: list and flush cached exceptions                        [FAIL]
#   can't list cached exceptions
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# RTNETLINK answers: No route to host
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# Error: Nexthop id does not exist.
# RTNETLINK answers: Network is unreachable
# RTNETLINK answers: Network is unreachable
# TEST: ipv6: list and flush cached exceptions - nexthop objects      [FAIL]
#   can't list cached exceptions
not ok 15 selftests: net: pmtu.sh
# selftests: net: udpgso.sh
# ipv4 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 (fail)
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 (fail)
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 (fail)
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 (fail)
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ./udpgso: sendmsg: Network is unreachable
# ipv6 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ./udpgso: sendmsg: Network is unreachable
# ipv4 connected
# device mtu (orig): 65536
# device mtu (test): 1600
# route mtu (test): 1500
# path mtu (read):  1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 (fail)
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 (fail)
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 (fail)
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 (fail)
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ./udpgso: sendmsg: Network is unreachable
not ok 16 selftests: net: udpgso.sh
# selftests: net: ip_defrag.sh
# ipv4 defrag
# PASS
# seed =3D 1568129911
# ipv4 defrag with overlaps
# PASS
# seed =3D 1568129911
# ipv6 defrag
# seed =3D 1568129916
# ./ip_defrag: send_fragment: Network is unreachable
not ok 17 selftests: net: ip_defrag.sh
# selftests: net: udpgso_bench.sh
# ipv4
# tcp
# tcp tx:  11638 MB/s   197396 calls/s 197396 msg/s
# tcp rx:  11648 MB/s   197512 calls/s
# tcp tx:  11957 MB/s   202811 calls/s 202811 msg/s
# tcp rx:  11969 MB/s   202992 calls/s
# tcp tx:  11568 MB/s   196214 calls/s 196214 msg/s
# tcp zerocopy
# tcp tx:   7845 MB/s   133066 calls/s 133066 msg/s
# tcp rx:   7852 MB/s   133041 calls/s
# tcp tx:   8022 MB/s   136069 calls/s 136069 msg/s
# tcp rx:   8029 MB/s   136162 calls/s
# tcp tx:   8019 MB/s   136013 calls/s 136013 msg/s
# udp
# udp rx:    834 MB/s   594397 calls/s
# udp tx:    834 MB/s   594426 calls/s  14153 msg/s
# udp tx:    840 MB/s   598962 calls/s  14261 msg/s
# udp rx:    841 MB/s   599378 calls/s
# udp tx:    832 MB/s   593166 calls/s  14123 msg/s
# udp gso
# udp rx:   2431 MB/s  1732122 calls/s
# udp tx:   2431 MB/s    41242 calls/s  41242 msg/s
# udp tx:   2443 MB/s    41437 calls/s  41437 msg/s
# udp rx:   2444 MB/s  1741530 calls/s
# udp tx:   2435 MB/s    41301 calls/s  41301 msg/s
# udp gso zerocopy
# udp tx:   1850 MB/s    31382 calls/s  31382 msg/s
# udp rx:   1850 MB/s  1318044 calls/s
# udp tx:   1847 MB/s    31343 calls/s  31343 msg/s
# udp rx:   1849 MB/s  1317582 calls/s
# udp tx:   1869 MB/s    31702 calls/s  31702 msg/s
# udp gso timestamp
# udp tx:   2338 MB/s    39658 calls/s  39658 msg/s
# udp rx:   2338 MB/s  1665636 calls/s
# udp tx:   2397 MB/s    40669 calls/s  40669 msg/s
# udp rx:   2400 MB/s  1709760 calls/s
# udp tx:   2380 MB/s    40369 calls/s  40369 msg/s
# udp gso zerocopy audit
# udp tx:   1842 MB/s    31253 calls/s  31253 msg/s
# udp rx:   1844 MB/s  1313802 calls/s
# udp tx:   1844 MB/s    31286 calls/s  31286 msg/s
# udp rx:   1846 MB/s  1315398 calls/s
# udp tx:   1857 MB/s    31507 calls/s  31507 msg/s
# Summary over 3.000 seconds...
# sum udp tx:   1892 MB/s      94046 calls (31348/s)      94046 msgs (31348=
/s)
# Zerocopy acks:               94046
# udp gso timestamp audit
# udp rx:   2284 MB/s  1627332 calls/s
# udp tx:   2286 MB/s    38783 calls/s  38783 msg/s
# udp tx:   2342 MB/s    39738 calls/s  39738 msg/s
# udp rx:   2345 MB/s  1670550 calls/s
# udp tx:   2356 MB/s    39970 calls/s  39970 msg/s
# Summary over 3.000 seconds...
# sum udp tx:   2384 MB/s     118491 calls (39497/s)     118491 msgs (39497=
/s)
# ./udpgso_bench_tx: Unexpected number of TX Timestamps:    118491 expected=
         0 received
# udp gso zerocopy timestamp audit
# udp tx:   1749 MB/s    29665 calls/s  29665 msg/s
# udp rx:   1749 MB/s  1245930 calls/s
# udp tx:   1816 MB/s    30801 calls/s  30801 msg/s
# udp rx:   1817 MB/s  1294776 calls/s
# udp tx:   1810 MB/s    30703 calls/s  30703 msg/s
# Summary over 3.000 seconds...
# sum udp tx:   1834 MB/s      91169 calls (30389/s)      91169 msgs (30389=
/s)
# ./udpgso_bench_tx: Unexpected number of TX Timestamps:     91169 expected=
         0 received
# ipv6
# tcp
# tcp tx:  11736 MB/s   199066 calls/s 199066 msg/s
# tcp rx:  11747 MB/s   199218 calls/s
# tcp tx:  11747 MB/s   199241 calls/s 199241 msg/s
# tcp rx:  11758 MB/s   199431 calls/s
# tcp tx:  11805 MB/s   200223 calls/s 200223 msg/s
# tcp zerocopy
# tcp tx:   7747 MB/s   131399 calls/s 131399 msg/s
# tcp rx:   7754 MB/s   131452 calls/s
# tcp tx:   7969 MB/s   135170 calls/s 135170 msg/s
# tcp rx:   7977 MB/s   135203 calls/s
# tcp tx:   7961 MB/s   135040 calls/s 135040 msg/s
# udp
# ./udpgso_bench_tx: connect: Network is unreachable
# udp gso
# ./udpgso_bench_tx: connect: Network is unreachable
# udp gso zerocopy
# ./udpgso_bench_tx: connect: Network is unreachable
# udp gso timestamp
# ./udpgso_bench_tx: connect: Network is unreachable
# udp gso zerocopy audit
# ./udpgso_bench_tx: connect: Network is unreachable
# udp gso timestamp audit
# ./udpgso_bench_tx: connect: Network is unreachable
# udp gso zerocopy timestamp audit
# ./udpgso_bench_tx: connect: Network is unreachable
# udpgso_bench.sh: =1B[0;31mFAIL=1B[0m
not ok 18 selftests: net: udpgso_bench.sh
# selftests: net: fib_rule_tests.sh
#=20
# ######################################################################
# TEST SECTION: IPv4 fib rule
# ######################################################################
#=20
#     TEST: rule4 check: oif dummy0                             [ OK ]
#=20
#     TEST: rule4 del by pref: oif dummy0                       [ OK ]
# net.ipv4.ip_forward =3D 1
# net.ipv4.conf.dummy0.rp_filter =3D 0
#=20
#     TEST: rule4 check: from 192.51.100.3 iif dummy0           [ OK ]
#=20
#     TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]
# net.ipv4.ip_forward =3D 0
#=20
#     TEST: rule4 check: tos 0x10                               [ OK ]
#=20
#     TEST: rule4 del by pref: tos 0x10                         [ OK ]
#=20
#     TEST: rule4 check: fwmark 0x64                            [ OK ]
#=20
#     TEST: rule4 del by pref: fwmark 0x64                      [ OK ]
#=20
#     TEST: rule4 check: uidrange 100-100                       [ OK ]
#=20
#     TEST: rule4 del by pref: uidrange 100-100                 [ OK ]
#=20
#     TEST: rule4 check: sport 666 dport 777                    [ OK ]
#=20
#     TEST: rule4 del by pref: sport 666 dport 777              [ OK ]
#=20
#     TEST: rule4 check: ipproto tcp                            [ OK ]
#=20
#     TEST: rule4 del by pref: ipproto tcp                      [ OK ]
#=20
#     TEST: rule4 check: ipproto icmp                           [ OK ]
#=20
#     TEST: rule4 del by pref: ipproto icmp                     [ OK ]
#=20
# ######################################################################
# TEST SECTION: IPv6 fib rule
# ######################################################################
# Error: netdevsim: Exceeded number of supported fib entries.
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule6 check: oif dummy0                             [FAIL]
#=20
#     TEST: rule6 del by pref: oif dummy0                       [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [FAIL]
#=20
#     TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule6 check: tos 0x10                               [FAIL]
#=20
#     TEST: rule6 del by pref: tos 0x10                         [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule6 check: fwmark 0x64                            [FAIL]
#=20
#     TEST: rule6 del by pref: fwmark 0x64                      [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule6 check: uidrange 100-100                       [FAIL]
#=20
#     TEST: rule6 del by pref: uidrange 100-100                 [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule6 check: sport 666 dport 777                    [FAIL]
#=20
#     TEST: rule6 del by pref: sport 666 dport 777              [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule6 check: ipproto tcp                            [FAIL]
#=20
#     TEST: rule6 del by pref: ipproto tcp                      [ OK ]
# RTNETLINK answers: Network is unreachable
#=20
#     TEST: rule6 check: ipproto ipv6-icmp                      [FAIL]
#=20
#     TEST: rule6 del by pref: ipproto ipv6-icmp                [ OK ]
#=20
# Tests passed:  24
# Tests failed:   8
not ok 19 selftests: net: fib_rule_tests.sh
# selftests: net: msg_zerocopy.sh
# ipv4 tcp -t 1
# tx=3D228966 (14288 MB) txc=3D0 zc=3Dn
# rx=3D114484 (14288 MB)
# ipv4 tcp -z -t 1
# tx=3D174209 (10871 MB) txc=3D174209 zc=3Dn
# rx=3D87105 (10871 MB)
# ok
# ipv6 tcp -t 1
# ./msg_zerocopy: connect: Network is unreachable

--8KmZJhJMEENkOiL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! /cephfs/jenkins/jobs/lkp-fsgsbase/workspace/lkp-customers/lkp-fsgsbase/test/lkp-csl-2ap3/kernel_selftests.yaml
suite: kernel_selftests
testcase: kernel_selftests
category: functional
need_memory: 3G
need_cpu: 2
kernel_selftests:
  group: kselftests-02
kernel_cmdline: erst_disable
job_origin: "/cephfs/jenkins/jobs/lkp-fsgsbase/workspace/lkp-customers/lkp-fsgsbase/test/lkp-csl-2ap3/kernel_selftests.yaml"
queue: bisect
testbox: lkp-skl-d01
commit: d5382fef70ce273608d6fc652c24f075de3737ef
branch: linus/master
name: "/cephfs/jenkins/jobs/lkp-fsgsbase/workspace/lkp-customers/lkp-fsgsbase/test/lkp-csl-2ap3/kernel_selftests.yaml"
tbox_group: lkp-skl-d01
submit_id: 5d769e7f3fa6cc9e56fddd96
job_file: "/lkp/jobs/scheduled/lkp-skl-d01/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-d5382fe-20190910-40534-ow6tx3-0.yaml"
id: 79a76acb07647e27fa47def0dc75f410f4281faa
queuer_version: "/lkp-src"
arch: x86_64

#! hosts/lkp-csl-2ap3

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/kernel_selftests
need_kernel_headers: true
need_kernel_selftests: true
need_kconfig:
- CONFIG_RUNTIME_TESTING_MENU=y
- CONFIG_TEST_FIRMWARE
- CONFIG_TEST_USER_COPY
- CONFIG_MEMORY_NOTIFIER_ERROR_INJECT
- CONFIG_MEMORY_HOTPLUG_SPARSE=y
- CONFIG_NOTIFIER_ERROR_INJECTION
- CONFIG_FTRACE=y
- CONFIG_TEST_BITMAP
- CONFIG_TEST_PRINTF
- CONFIG_TEST_STATIC_KEYS
- CONFIG_BPF_SYSCALL=y
- CONFIG_NET_CLS_BPF=m
- CONFIG_BPF_EVENTS=y
- CONFIG_TEST_BPF=m
- CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
- CONFIG_HIST_TRIGGERS=y
- CONFIG_EMBEDDED=y
- CONFIG_GPIO_MOCKUP=y
- CONFIG_USERFAULTFD=y
- CONFIG_SYNC_FILE=y
- CONFIG_SW_SYNC=y
- CONFIG_MISC_FILESYSTEMS=y
- CONFIG_PSTORE=y
- CONFIG_PSTORE_PMSG=y
- CONFIG_PSTORE_CONSOLE=y
- CONFIG_PSTORE_RAM=m
- CONFIG_EXPERT=y
- CONFIG_CHECKPOINT_RESTORE=y
- CONFIG_EFIVAR_FS
- CONFIG_TEST_KMOD=m
- CONFIG_TEST_LKM=m
- CONFIG_XFS_FS=m
- CONFIG_TUN=m
- CONFIG_BTRFS_FS=m
- CONFIG_TEST_SYSCTL=m
- CONFIG_BPF_STREAM_PARSER=y
- CONFIG_CGROUP_BPF=y
- CONFIG_IPV6_MULTIPLE_TABLES=y
- CONFIG_NET_L3_MASTER_DEV=y
- CONFIG_NET_VRF=y
- CONFIG_NET_FOU=m
- CONFIG_NET_FOU_IP_TUNNELS=y
- CONFIG_MACSEC=y
- CONFIG_X86_INTEL_MPX=y
- CONFIG_RC_LOOPBACK
- CONFIG_IPV6_SEG6_LWTUNNEL=y ~ v(4\.1[0-9]|4\.20|5\.)
- CONFIG_LWTUNNEL=y
- CONFIG_WW_MUTEX_SELFTEST=m ~ v(4\.1[1-9]|4\.20|5\.)
- CONFIG_DRM_DEBUG_SELFTEST=m ~ v(4\.1[8-9]|4\.20|5\.)
- CONFIG_TEST_LIVEPATCH=m ~ v(5\.[1-9])
- CONFIG_LIRC=y
- CONFIG_IR_SHARP_DECODER=m
- CONFIG_ANDROID=y ~ v(3\.[3-9]|3\.1[0-9]|4\.|5\.)
- CONFIG_ION=y ~ v(3\.1[4-9]|4\.|5\.)
- CONFIG_ION_SYSTEM_HEAP=y ~ v(4\.1[2-9]|4\.20|5\.)
- CONFIG_MPLS_ROUTING=m ~ v(4\.[1-9]|4\.1[0-9]|4\.20|5\.)
- CONFIG_MPLS_IPTUNNEL=m ~ v(4\.[3-9]|4\.1[0-9]|4\.20|5\.)

#! include/testbox/lkp-csl-2ap3

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
enqueue_time: 2019-09-10 02:48:34.506304110 +08:00
_id: 5d769e7f3fa6cc9e56fddd96
_rt: "/result/kernel_selftests/kselftests-02/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef"

#! schedule options
user: liuyd
result_root: "/result/kernel_selftests/kselftests-02/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/0"
scheduler_version: "/lkp/lkp/.src-20190909-141330"
LKP_SERVER: inn
max_uptime: 3600
initrd: "/osimage/debian/debian-x86_64-2018-04-03.cgz"
bootloader_append:
- root=/dev/ram0
- user=liuyd
- job=/lkp/jobs/scheduled/lkp-skl-d01/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-d5382fe-20190910-40534-ow6tx3-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linus/master
- commit=d5382fef70ce273608d6fc652c24f075de3737ef
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/vmlinuz-5.2.0-rc5-01201-gd5382fef70ce2
- erst_disable
- max_uptime=3600
- RESULT_ROOT=/result/kernel_selftests/kselftests-02/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/0
- LKP_SERVER=inn
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2019-09-08.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-d3464ccd105b_2019-09-08.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-08-21.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/linux-selftests.cgz"
lkp_initrd: "/osimage/user/liuyd/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20190808-112917/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status

#! queue options
queue_cmdline_keys:
- branch
- commit

#! /lkp/lkp/.src-20190819-105132/include/site/inn

#! /lkp/lkp/.src-20190822-123518/include/site/inn

#! /lkp/lkp/.src-20190828-153305/include/site/inn

#! /lkp/lkp/.src-20190830-090613/include/site/inn

#! hosts/lkp-skl-d01
model: Skylake
nr_cpu: 8
memory: 16G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part1"
swap_partitions: "/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part3"
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part2"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
cpu_info: skylake i7-6700
bios_version: 1.2.8
rootfs: debian-x86_64-2018-04-03.cgz

#! /lkp/lkp/.src-20190830-120315/include/site/inn
schedule_notify_address: 

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/d5382fef70ce273608d6fc652c24f075de3737ef/vmlinuz-5.2.0-rc5-01201-gd5382fef70ce2"
dequeue_time: 2019-09-10 03:16:04.254652798 +08:00

#! /lkp/lkp/.src-20190909-141330/include/site/inn
job_state: soft_timeout
loadavg: 0.34 0.09 0.03 1/171 32306
start_time: '1568056609'
end_time: '1568060277'
version: "/lkp/liuyd/.src-20190909-171238"

--8KmZJhJMEENkOiL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "make" "TARGETS=media_tests"
 "make" "run_tests" "-C" "membarrier"
 "make" "run_tests" "-C" "memfd"
 "make" "run_tests" "-C" "memory-hotplug"
 "make" "run_tests" "-C" "mount"
 "make" "run_tests" "-C" "mqueue"
 "make" "run_tests" "-C" "net"

--8KmZJhJMEENkOiL3--
