Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEC6208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfFXJ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:58:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:27637 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbfFXJ6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:58:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 02:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; 
   d="scan'208";a="244659346"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2019 02:57:38 -0700
Subject: Re: [srcu] 2ce62cbf3e:
 kobject(#):tried_to_init_an_initialized_object,something_is_seriously_wrong
To:     paulmck@linux.ibm.com, kernel test robot <lkp@intel.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
References: <20190505063856.GJ29809@shao2-debian>
 <20190620200123.GU26519@linux.ibm.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <b70f4f76-fbd9-84ff-2c63-b5efb62cd131@intel.com>
Date:   Mon, 24 Jun 2019 17:57:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620200123.GU26519@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/19 4:01 AM, Paul E. McKenney wrote:
> On Sun, May 05, 2019 at 02:38:56PM +0800, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 2ce62cbf3ebf647d3ef3640969b81e8b0b9466ad ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
>> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2019.04.28a
>>
>> in testcase: locktorture
>> with following parameters:
>>
>> 	runtime: 300s
>> 	test: cpuhotplug
>>
>> test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region behaviors.
>> test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt
>>
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> +-----------------------------------------------------------------------------+------------+------------+
>> |                                                                             | dccea1a8c4 | 2ce62cbf3e |
>> +-----------------------------------------------------------------------------+------------+------------+
>> | boot_successes                                                              | 6          | 0          |
>> | boot_failures                                                               | 4          | 10         |
>> | BUG:kernel_reboot-without-warning_in_test_stage                             | 4          |            |
>> | kobject(#):tried_to_init_an_initialized_object,something_is_seriously_wrong | 0          | 10         |
>> | general_protection_fault:#[##]                                              | 0          | 1          |
>> | RIP:string                                                                  | 0          | 1          |
>> | Kernel_panic-not_syncing:Fatal_exception                                    | 0          | 1          |
>> | BUG:kernel_hang_in_test_stage                                               | 0          | 1          |
>> +-----------------------------------------------------------------------------+------------+------------+
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> [   23.381931] [TTM] Finalizing DMA pool allocator
>> LKP: HOSTNAME vm-snb-2G-162, MAC 52:54:00:12:34:56, kernel 5.1.0-rc1-00102-g2ce62cb 1, serial console /dev/ttyS0
>> [   23.407428] [TTM] Zone  kernel: Used memory at exit: 0 kiB
>> [   23.441178] [drm] Found bochs VGA, ID 0xb0c0.
>> [   23.442080] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
>> [   23.482582] kobject ((____ptrval____)): tried to init an initialized object, something is seriously wrong.
>> [   23.484087] CPU: 0 PID: 348 Comm: systemd-udevd Not tainted 5.1.0-rc1-00102-g2ce62cb #1
>> [   23.485247] Call Trace:
>> [   23.485633]  dump_stack+0x6c/0x8f
>> [   23.486173]  kobject_init+0x45/0xa5
>> [   23.486748]  kobject_init_and_add+0x3d/0xa6
>> [   23.487541]  ? __module_address+0x8b/0xac
>> [   23.488122]  ? is_module_address+0x10/0x1f
>> [   23.488729]  ? static_obj+0x32/0x4a
>> [   23.489236]  ? 0xffffffffa00ef000
>> [   23.489781]  ttm_mem_global_init+0xb6/0x319 [ttm]
>> [   23.490525]  ? vprintk_func+0xd1/0xda
>> [   23.491139]  ? drm_dbg+0x7e/0x8b [drm]
>> [   23.491714]  ? printk+0x53/0x5b
>> [   23.492176]  ttm_bo_device_init+0x68/0x2c3 [ttm]
>> [   23.492913]  bochs_mm_init+0x40/0xa8 [bochs_drm]
>> [   23.493761]  bochs_pci_probe+0x117/0x17f [bochs_drm]
>> [   23.494837]  local_pci_probe+0x47/0x9d
>> [   23.495594]  pci_device_probe+0x17f/0x1cd
>> [   23.496443]  ? pci_device_remove+0xcf/0xcf
>> [   23.497255]  really_probe+0x255/0x584
>> [   23.498033]  ? pm_runtime_put_noidle+0x1c/0x1f
>> [   23.498958]  driver_probe_device+0x128/0x176
>> [   23.499834]  device_driver_attach+0x4e/0x6a
>> [   23.500737]  __driver_attach+0x170/0x182
>> [   23.501538]  ? device_driver_attach+0x6a/0x6a
>> [   23.502398]  bus_for_each_dev+0x9d/0xc5
>> [   23.503143]  driver_attach+0x22/0x25
>> [   23.503848]  bus_add_driver+0x157/0x240
>> [   23.504622]  driver_register+0xe4/0x131
>> [   23.505361]  __pci_register_driver+0x78/0x7f
>> [   23.506189]  bochs_init+0x62/0x1000 [bochs_drm]
>> [   23.507075]  ? 0xffffffffa012e000
>> [   23.507921]  do_one_initcall+0x7f/0x17f
>> [   23.508785]  ? cache_alloc_debugcheck_after+0x4b/0x148
>> [   23.509793]  ? do_init_module+0x21/0x3b1
>> [   23.510569]  ? kmem_cache_alloc+0x9b/0xbb
>> [   23.511393]  do_init_module+0x5a/0x3b1
>> [   23.512133]  load_module+0x11c6/0x1786
>> [   23.512878]  ? vfs_read+0xf3/0x102
>> [   23.519413]  ? allow_write_access+0x27/0x2a
>> [   23.520276]  ? kernel_read_file+0x17f/0x191
>> [   23.521214]  __do_sys_finit_module+0xb5/0xc5
>> [   23.522138]  ? __do_sys_finit_module+0xb5/0xc5
>> [   23.523121]  __x64_sys_finit_module+0x15/0x17
>> [   23.524236]  do_syscall_64+0x1a0/0x1bd
>> [   23.525042]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   23.526078] RIP: 0033:0x7f1b0a25a229
>> [   23.526845] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 4c 2b 00 f7 d8 64 89 01 48
>> [   23.530673] RSP: 002b:00007ffd8ca3e9f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>> [   23.532210] RAX: ffffffffffffffda RBX: 0000559388c5d5a0 RCX: 00007f1b0a25a229
>> [   23.533655] RDX: 0000000000000000 RSI: 00007f1b0ab73265 RDI: 0000000000000014
>> [   23.535344] RBP: 00007f1b0ab73265 R08: 0000000000000000 R09: 00007ffd8ca3ef70
>> [   23.536799] R10: 0000000000000014 R11: 0000000000000246 R12: 0000000000000000
>> [   23.538252] R13: 0000559388c5cb30 R14: 0000000000020000 R15: 000055938884ecbc
>> [   23.539976] [TTM] Zone  kernel: Available graphics memory: 1007378 kiB
>> [   23.541308] [TTM] Zone  kernel: Available graphics memory: 1007378 kiB
>> [   23.542643] [TTM] Initializing pool allocator
>> [   23.543570] [TTM] Initializing DMA pool allocator
>> [   23.544623] kobject ((____ptrval____)): tried to init an initialized object, something is seriously wrong.
>> [   23.546549] CPU: 0 PID: 348 Comm: systemd-udevd Not tainted 5.1.0-rc1-00102-g2ce62cb #1
>> [   23.548159] Call Trace:
>> [   23.548694]  dump_stack+0x6c/0x8f
>> [   23.549389]  kobject_init+0x45/0xa5
>> [   23.550098]  kobject_init_and_add+0x3d/0xa6
>> [   23.550961]  ? alloc_pages_current+0xcb/0xdb
>> [   23.551860]  ttm_bo_device_init+0x156/0x2c3 [ttm]
>> [   23.552850]  bochs_mm_init+0x40/0xa8 [bochs_drm]
>> [   23.553817]  bochs_pci_probe+0x117/0x17f [bochs_drm]
>> [   23.554945]  local_pci_probe+0x47/0x9d
>> [   23.555560] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
>> [   23.566712]  pci_device_probe+0x17f/0x1cd
>> [   23.566721]  ? pci_device_remove+0xcf/0xcf
>> [   23.566732]  really_probe+0x255/0x584
>> [   23.576323]  ? pm_runtime_put_noidle+0x1c/0x1f
>> [   23.577326]  driver_probe_device+0x128/0x176
>> [   23.578213]  device_driver_attach+0x4e/0x6a
>> [   23.581556]  __driver_attach+0x170/0x182
>> [   23.582294]  ? device_driver_attach+0x6a/0x6a
>> [   23.583115]  bus_for_each_dev+0x9d/0xc5
>> [   23.583852]  driver_attach+0x22/0x25
>> [   23.584553]  bus_add_driver+0x157/0x240
>> [   23.585292]  driver_register+0xe4/0x131
>> [   23.586166]  __pci_register_driver+0x78/0x7f
>> [   23.586987]  bochs_init+0x62/0x1000 [bochs_drm]
>> [   23.587839]  ? 0xffffffffa012e000
>> [   23.588481]  do_one_initcall+0x7f/0x17f
>> [   23.589209]  ? cache_alloc_debugcheck_after+0x4b/0x148
>> [   23.590167]  ? do_init_module+0x21/0x3b1
>> [   23.590913]  ? kmem_cache_alloc+0x9b/0xbb
>> [   23.591676]  do_init_module+0x5a/0x3b1
>> [   23.592395]  load_module+0x11c6/0x1786
>> [   23.593109]  ? vfs_read+0xf3/0x102
>> [   23.593740]  ? allow_write_access+0x27/0x2a
>> [   23.594511]  ? kernel_read_file+0x17f/0x191
>> [   23.595269]  __do_sys_finit_module+0xb5/0xc5
>> [   23.596054]  ? __do_sys_finit_module+0xb5/0xc5
>> [   23.596865]  __x64_sys_finit_module+0x15/0x17
>> [   23.597656]  do_syscall_64+0x1a0/0x1bd
>> [   23.598345]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   23.599297] RIP: 0033:0x7f1b0a25a229
>> [   23.599976] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 4c 2b 00 f7 d8 64 89 01 48
>> [   23.603530] RSP: 002b:00007ffd8ca3e9f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>> [   23.604925] RAX: ffffffffffffffda RBX: 0000559388c5d5a0 RCX: 00007f1b0a25a229
>> [   23.606369] RDX: 0000000000000000 RSI: 00007f1b0ab73265 RDI: 0000000000000014
>> [   23.607728] RBP: 00007f1b0ab73265 R08: 0000000000000000 R09: 00007ffd8ca3ef70
>> [   23.609066] R10: 0000000000000014 R11: 0000000000000246 R12: 0000000000000000
>> [   23.612060] R13: 0000559388c5cb30 R14: 0000000000020000 R15: 000055938884ecbc
>> [   23.625106] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 0
>> [   23.830835] Probing IDE interface ide1...
>> [   23.949174] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input6
>>
>>
>> To reproduce:
>>
>>          # build kernel
>> 	cd linux
>> 	cp config-5.1.0-rc1-00102-g2ce62cb .config
>> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
>> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
>> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
>> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
>> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
>>
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>> 	bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> I couldn't see how that commit could result in this problem, so
> I eventually tried out your reproducer above.
>
> This doesn't reproduce for me, but it does complain about not being able
> to mount a 9P filesystem.  So I modified the .config to include
> CONFIG_9P_FS=y.  This resulted in complaints about 9p/virtfs_mount,
> so I enabled the other three CONFIG_9P_FS-related Kconfig options.
> Which did not help.  And it turns out that numerous additional Kconfig
> options are required, courtesy of the usual web search, culminating
> in CONFIG_VIRTIO_PCI=y.
>
> And then it won't reproduce.
>
> OK, so I am running the -rcu tree's current "dev" branch, so why not
> try the current version of the commit called out above?  Which is:
> fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
>
> And it won't reproduce there, either.
>
> So, is this still happening at your end?

Hi Paul,

I rebuilt the kernel and the problem is gone. I think it's a false positive.

My sincere apologies for the inconvenience.

Best Regards,
Rong Chen


>
> 							Thanx, Paul
>
>> Thanks,
>> lkp
>>
>> #
>> # Automatically generated file; DO NOT EDIT.
>> # Linux/x86_64 5.1.0-rc1 Kernel Configuration
>> #
>>
>> #
>> # Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> #
>> CONFIG_CC_IS_GCC=y
>> CONFIG_GCC_VERSION=70300
>> CONFIG_CLANG_VERSION=0
>> CONFIG_CC_HAS_ASM_GOTO=y
>> CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
>> CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED=y
>> CONFIG_IRQ_WORK=y
>> CONFIG_BUILDTIME_EXTABLE_SORT=y
>> CONFIG_THREAD_INFO_IN_TASK=y
>>
>> #
>> # General setup
>> #
>> CONFIG_INIT_ENV_ARG_LIMIT=32
>> # CONFIG_COMPILE_TEST is not set
>> CONFIG_LOCALVERSION=""
>> CONFIG_LOCALVERSION_AUTO=y
>> CONFIG_BUILD_SALT=""
>> CONFIG_HAVE_KERNEL_GZIP=y
>> CONFIG_HAVE_KERNEL_BZIP2=y
>> CONFIG_HAVE_KERNEL_LZMA=y
>> CONFIG_HAVE_KERNEL_XZ=y
>> CONFIG_HAVE_KERNEL_LZO=y
>> CONFIG_HAVE_KERNEL_LZ4=y
>> # CONFIG_KERNEL_GZIP is not set
>> # CONFIG_KERNEL_BZIP2 is not set
>> # CONFIG_KERNEL_LZMA is not set
>> CONFIG_KERNEL_XZ=y
>> # CONFIG_KERNEL_LZO is not set
>> # CONFIG_KERNEL_LZ4 is not set
>> CONFIG_DEFAULT_HOSTNAME="(none)"
>> CONFIG_SWAP=y
>> # CONFIG_SYSVIPC is not set
>> CONFIG_POSIX_MQUEUE=y
>> CONFIG_POSIX_MQUEUE_SYSCTL=y
>> CONFIG_CROSS_MEMORY_ATTACH=y
>> CONFIG_USELIB=y
>> CONFIG_AUDIT=y
>> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
>> CONFIG_AUDITSYSCALL=y
>>
>> #
>> # IRQ subsystem
>> #
>> CONFIG_GENERIC_IRQ_PROBE=y
>> CONFIG_GENERIC_IRQ_SHOW=y
>> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
>> CONFIG_GENERIC_PENDING_IRQ=y
>> CONFIG_GENERIC_IRQ_MIGRATION=y
>> CONFIG_GENERIC_IRQ_CHIP=y
>> CONFIG_IRQ_DOMAIN=y
>> CONFIG_IRQ_DOMAIN_HIERARCHY=y
>> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
>> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
>> CONFIG_IRQ_FORCED_THREADING=y
>> CONFIG_SPARSE_IRQ=y
>> CONFIG_GENERIC_IRQ_DEBUGFS=y
>> CONFIG_CLOCKSOURCE_WATCHDOG=y
>> CONFIG_ARCH_CLOCKSOURCE_DATA=y
>> CONFIG_ARCH_CLOCKSOURCE_INIT=y
>> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
>> CONFIG_GENERIC_TIME_VSYSCALL=y
>> CONFIG_GENERIC_CLOCKEVENTS=y
>> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
>> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
>> CONFIG_GENERIC_CMOS_UPDATE=y
>>
>> #
>> # Timers subsystem
>> #
>> CONFIG_TICK_ONESHOT=y
>> CONFIG_NO_HZ_COMMON=y
>> # CONFIG_HZ_PERIODIC is not set
>> # CONFIG_NO_HZ_IDLE is not set
>> CONFIG_NO_HZ_FULL=y
>> CONFIG_CONTEXT_TRACKING=y
>> CONFIG_CONTEXT_TRACKING_FORCE=y
>> CONFIG_NO_HZ=y
>> # CONFIG_HIGH_RES_TIMERS is not set
>> CONFIG_PREEMPT_NONE=y
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> # CONFIG_PREEMPT is not set
>> CONFIG_PREEMPT_COUNT=y
>>
>> #
>> # CPU/Task time and stats accounting
>> #
>> CONFIG_VIRT_CPU_ACCOUNTING=y
>> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
>> CONFIG_IRQ_TIME_ACCOUNTING=y
>> CONFIG_HAVE_SCHED_AVG_IRQ=y
>> # CONFIG_BSD_PROCESS_ACCT is not set
>> # CONFIG_TASKSTATS is not set
>> # CONFIG_PSI is not set
>> CONFIG_CPU_ISOLATION=y
>>
>> #
>> # RCU Subsystem
>> #
>> CONFIG_TREE_RCU=y
>> # CONFIG_RCU_EXPERT is not set
>> CONFIG_SRCU=y
>> CONFIG_TREE_SRCU=y
>> CONFIG_TASKS_RCU=y
>> CONFIG_RCU_STALL_COMMON=y
>> CONFIG_RCU_NEED_SEGCBLIST=y
>> CONFIG_RCU_NOCB_CPU=y
>> CONFIG_BUILD_BIN2C=y
>> CONFIG_IKCONFIG=y
>> CONFIG_IKCONFIG_PROC=y
>> CONFIG_LOG_BUF_SHIFT=20
>> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
>> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
>> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
>> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
>> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
>> CONFIG_ARCH_SUPPORTS_INT128=y
>> # CONFIG_NUMA_BALANCING is not set
>> CONFIG_CGROUPS=y
>> # CONFIG_MEMCG is not set
>> # CONFIG_BLK_CGROUP is not set
>> CONFIG_CGROUP_SCHED=y
>> CONFIG_FAIR_GROUP_SCHED=y
>> CONFIG_CFS_BANDWIDTH=y
>> CONFIG_RT_GROUP_SCHED=y
>> # CONFIG_CGROUP_PIDS is not set
>> # CONFIG_CGROUP_RDMA is not set
>> CONFIG_CGROUP_FREEZER=y
>> # CONFIG_CPUSETS is not set
>> CONFIG_CGROUP_DEVICE=y
>> # CONFIG_CGROUP_CPUACCT is not set
>> # CONFIG_CGROUP_PERF is not set
>> CONFIG_CGROUP_DEBUG=y
>> # CONFIG_NAMESPACES is not set
>> CONFIG_CHECKPOINT_RESTORE=y
>> CONFIG_SCHED_AUTOGROUP=y
>> # CONFIG_SYSFS_DEPRECATED is not set
>> CONFIG_RELAY=y
>> CONFIG_BLK_DEV_INITRD=y
>> CONFIG_INITRAMFS_SOURCE=""
>> CONFIG_RD_GZIP=y
>> CONFIG_RD_BZIP2=y
>> # CONFIG_RD_LZMA is not set
>> CONFIG_RD_XZ=y
>> CONFIG_RD_LZO=y
>> # CONFIG_RD_LZ4 is not set
>> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
>> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>> CONFIG_SYSCTL=y
>> CONFIG_ANON_INODES=y
>> CONFIG_SYSCTL_EXCEPTION_TRACE=y
>> CONFIG_HAVE_PCSPKR_PLATFORM=y
>> CONFIG_BPF=y
>> CONFIG_EXPERT=y
>> CONFIG_MULTIUSER=y
>> CONFIG_SGETMASK_SYSCALL=y
>> CONFIG_SYSFS_SYSCALL=y
>> # CONFIG_SYSCTL_SYSCALL is not set
>> CONFIG_FHANDLE=y
>> CONFIG_POSIX_TIMERS=y
>> CONFIG_PRINTK=y
>> CONFIG_PRINTK_NMI=y
>> CONFIG_BUG=y
>> # CONFIG_ELF_CORE is not set
>> # CONFIG_PCSPKR_PLATFORM is not set
>> CONFIG_BASE_FULL=y
>> CONFIG_FUTEX=y
>> CONFIG_FUTEX_PI=y
>> CONFIG_EPOLL=y
>> CONFIG_SIGNALFD=y
>> CONFIG_TIMERFD=y
>> # CONFIG_EVENTFD is not set
>> CONFIG_SHMEM=y
>> # CONFIG_AIO is not set
>> CONFIG_IO_URING=y
>> # CONFIG_ADVISE_SYSCALLS is not set
>> CONFIG_MEMBARRIER=y
>> CONFIG_KALLSYMS=y
>> CONFIG_KALLSYMS_ALL=y
>> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
>> CONFIG_KALLSYMS_BASE_RELATIVE=y
>> # CONFIG_BPF_SYSCALL is not set
>> # CONFIG_USERFAULTFD is not set
>> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
>> # CONFIG_RSEQ is not set
>> CONFIG_EMBEDDED=y
>> CONFIG_HAVE_PERF_EVENTS=y
>> # CONFIG_PC104 is not set
>>
>> #
>> # Kernel Performance Events And Counters
>> #
>> CONFIG_PERF_EVENTS=y
>> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
>> # CONFIG_VM_EVENT_COUNTERS is not set
>> # CONFIG_COMPAT_BRK is not set
>> CONFIG_SLAB=y
>> # CONFIG_SLUB is not set
>> # CONFIG_SLOB is not set
>> CONFIG_SLAB_MERGE_DEFAULT=y
>> # CONFIG_SLAB_FREELIST_RANDOM is not set
>> # CONFIG_PROFILING is not set
>> CONFIG_64BIT=y
>> CONFIG_X86_64=y
>> CONFIG_X86=y
>> CONFIG_INSTRUCTION_DECODER=y
>> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
>> CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
>> CONFIG_LOCKDEP_SUPPORT=y
>> CONFIG_STACKTRACE_SUPPORT=y
>> CONFIG_MMU=y
>> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
>> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
>> CONFIG_GENERIC_BUG=y
>> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
>> CONFIG_GENERIC_HWEIGHT=y
>> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>> CONFIG_GENERIC_CALIBRATE_DELAY=y
>> CONFIG_ARCH_HAS_CPU_RELAX=y
>> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
>> CONFIG_ARCH_HAS_FILTER_PGPROT=y
>> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
>> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
>> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
>> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
>> CONFIG_ARCH_SUSPEND_POSSIBLE=y
>> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
>> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
>> CONFIG_ZONE_DMA32=y
>> CONFIG_AUDIT_ARCH=y
>> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
>> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
>> CONFIG_X86_64_SMP=y
>> CONFIG_ARCH_SUPPORTS_UPROBES=y
>> CONFIG_FIX_EARLYCON_MEM=y
>> CONFIG_PGTABLE_LEVELS=4
>> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
>>
>> #
>> # Processor type and features
>> #
>> CONFIG_ZONE_DMA=y
>> CONFIG_SMP=y
>> CONFIG_X86_FEATURE_NAMES=y
>> CONFIG_X86_X2APIC=y
>> # CONFIG_X86_MPPARSE is not set
>> # CONFIG_GOLDFISH is not set
>> CONFIG_RETPOLINE=y
>> # CONFIG_X86_CPU_RESCTRL is not set
>> CONFIG_X86_EXTENDED_PLATFORM=y
>> # CONFIG_X86_NUMACHIP is not set
>> CONFIG_X86_VSMP=y
>> # CONFIG_X86_GOLDFISH is not set
>> # CONFIG_X86_INTEL_MID is not set
>> # CONFIG_X86_INTEL_LPSS is not set
>> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
>> CONFIG_IOSF_MBI=y
>> # CONFIG_IOSF_MBI_DEBUG is not set
>> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
>> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
>> CONFIG_HYPERVISOR_GUEST=y
>> CONFIG_PARAVIRT=y
>> # CONFIG_PARAVIRT_DEBUG is not set
>> CONFIG_PARAVIRT_SPINLOCKS=y
>> # CONFIG_QUEUED_LOCK_STAT is not set
>> # CONFIG_XEN is not set
>> CONFIG_KVM_GUEST=y
>> # CONFIG_PVH is not set
>> # CONFIG_KVM_DEBUG_FS is not set
>> CONFIG_PARAVIRT_TIME_ACCOUNTING=y
>> CONFIG_PARAVIRT_CLOCK=y
>> CONFIG_JAILHOUSE_GUEST=y
>> # CONFIG_MK8 is not set
>> # CONFIG_MPSC is not set
>> # CONFIG_MCORE2 is not set
>> # CONFIG_MATOM is not set
>> CONFIG_GENERIC_CPU=y
>> CONFIG_X86_INTERNODE_CACHE_SHIFT=12
>> CONFIG_X86_L1_CACHE_SHIFT=6
>> CONFIG_X86_TSC=y
>> CONFIG_X86_CMPXCHG64=y
>> CONFIG_X86_CMOV=y
>> CONFIG_X86_MINIMUM_CPU_FAMILY=64
>> CONFIG_X86_DEBUGCTLMSR=y
>> # CONFIG_PROCESSOR_SELECT is not set
>> CONFIG_CPU_SUP_INTEL=y
>> CONFIG_CPU_SUP_AMD=y
>> CONFIG_CPU_SUP_HYGON=y
>> CONFIG_CPU_SUP_CENTAUR=y
>> CONFIG_HPET_TIMER=y
>> # CONFIG_DMI is not set
>> CONFIG_GART_IOMMU=y
>> # CONFIG_CALGARY_IOMMU is not set
>> CONFIG_MAXSMP=y
>> CONFIG_NR_CPUS_RANGE_BEGIN=8192
>> CONFIG_NR_CPUS_RANGE_END=8192
>> CONFIG_NR_CPUS_DEFAULT=8192
>> CONFIG_NR_CPUS=8192
>> CONFIG_SCHED_SMT=y
>> # CONFIG_SCHED_MC is not set
>> CONFIG_X86_LOCAL_APIC=y
>> CONFIG_X86_IO_APIC=y
>> # CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
>> CONFIG_X86_MCE=y
>> CONFIG_X86_MCELOG_LEGACY=y
>> # CONFIG_X86_MCE_INTEL is not set
>> CONFIG_X86_MCE_AMD=y
>> CONFIG_X86_MCE_THRESHOLD=y
>> CONFIG_X86_MCE_INJECT=m
>>
>> #
>> # Performance monitoring
>> #
>> # CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
>> CONFIG_PERF_EVENTS_INTEL_RAPL=m
>> # CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
>> CONFIG_PERF_EVENTS_AMD_POWER=y
>> CONFIG_X86_VSYSCALL_EMULATION=y
>> CONFIG_I8K=m
>> # CONFIG_MICROCODE is not set
>> CONFIG_X86_MSR=y
>> CONFIG_X86_CPUID=m
>> # CONFIG_X86_5LEVEL is not set
>> CONFIG_X86_DIRECT_GBPAGES=y
>> # CONFIG_X86_CPA_STATISTICS is not set
>> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
>> # CONFIG_AMD_MEM_ENCRYPT is not set
>> CONFIG_NUMA=y
>> CONFIG_AMD_NUMA=y
>> CONFIG_X86_64_ACPI_NUMA=y
>> CONFIG_NODES_SPAN_OTHER_NODES=y
>> CONFIG_NUMA_EMU=y
>> CONFIG_NODES_SHIFT=10
>> CONFIG_ARCH_SPARSEMEM_ENABLE=y
>> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
>> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
>> CONFIG_ARCH_MEMORY_PROBE=y
>> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
>> # CONFIG_X86_PMEM_LEGACY is not set
>> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
>> CONFIG_X86_RESERVE_LOW=64
>> CONFIG_MTRR=y
>> # CONFIG_MTRR_SANITIZER is not set
>> # CONFIG_X86_PAT is not set
>> # CONFIG_ARCH_RANDOM is not set
>> # CONFIG_X86_SMAP is not set
>> # CONFIG_X86_INTEL_UMIP is not set
>> CONFIG_X86_INTEL_MPX=y
>> # CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
>> # CONFIG_EFI is not set
>> CONFIG_SECCOMP=y
>> # CONFIG_HZ_100 is not set
>> # CONFIG_HZ_250 is not set
>> CONFIG_HZ_300=y
>> # CONFIG_HZ_1000 is not set
>> CONFIG_HZ=300
>> # CONFIG_KEXEC is not set
>> # CONFIG_KEXEC_FILE is not set
>> CONFIG_CRASH_DUMP=y
>> CONFIG_PHYSICAL_START=0x1000000
>> CONFIG_RELOCATABLE=y
>> # CONFIG_RANDOMIZE_BASE is not set
>> CONFIG_PHYSICAL_ALIGN=0x200000
>> CONFIG_HOTPLUG_CPU=y
>> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
>> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
>> CONFIG_LEGACY_VSYSCALL_EMULATE=y
>> # CONFIG_LEGACY_VSYSCALL_NONE is not set
>> # CONFIG_CMDLINE_BOOL is not set
>> # CONFIG_MODIFY_LDT_SYSCALL is not set
>> CONFIG_HAVE_LIVEPATCH=y
>> CONFIG_ARCH_HAS_ADD_PAGES=y
>> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
>> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
>> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
>> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
>>
>> #
>> # Power management and ACPI options
>> #
>> CONFIG_ARCH_HIBERNATION_HEADER=y
>> # CONFIG_SUSPEND is not set
>> CONFIG_HIBERNATE_CALLBACKS=y
>> CONFIG_HIBERNATION=y
>> CONFIG_PM_STD_PARTITION=""
>> CONFIG_PM_SLEEP=y
>> CONFIG_PM_SLEEP_SMP=y
>> # CONFIG_PM_AUTOSLEEP is not set
>> CONFIG_PM_WAKELOCKS=y
>> CONFIG_PM_WAKELOCKS_LIMIT=100
>> # CONFIG_PM_WAKELOCKS_GC is not set
>> CONFIG_PM=y
>> CONFIG_PM_DEBUG=y
>> CONFIG_PM_ADVANCED_DEBUG=y
>> CONFIG_PM_SLEEP_DEBUG=y
>> # CONFIG_PM_TRACE_RTC is not set
>> CONFIG_PM_CLK=y
>> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>> CONFIG_ARCH_SUPPORTS_ACPI=y
>> CONFIG_ACPI=y
>> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
>> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
>> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
>> # CONFIG_ACPI_DEBUGGER is not set
>> CONFIG_ACPI_SPCR_TABLE=y
>> CONFIG_ACPI_LPIT=y
>> CONFIG_ACPI_SLEEP=y
>> # CONFIG_ACPI_PROCFS_POWER is not set
>> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
>> # CONFIG_ACPI_EC_DEBUGFS is not set
>> CONFIG_ACPI_AC=y
>> CONFIG_ACPI_BATTERY=y
>> CONFIG_ACPI_BUTTON=y
>> CONFIG_ACPI_VIDEO=m
>> CONFIG_ACPI_FAN=y
>> # CONFIG_ACPI_TAD is not set
>> # CONFIG_ACPI_DOCK is not set
>> CONFIG_ACPI_CPU_FREQ_PSS=y
>> CONFIG_ACPI_PROCESSOR_CSTATE=y
>> CONFIG_ACPI_PROCESSOR_IDLE=y
>> CONFIG_ACPI_PROCESSOR=y
>> # CONFIG_ACPI_IPMI is not set
>> CONFIG_ACPI_HOTPLUG_CPU=y
>> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
>> CONFIG_ACPI_THERMAL=y
>> CONFIG_ACPI_NUMA=y
>> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
>> CONFIG_ACPI_TABLE_UPGRADE=y
>> # CONFIG_ACPI_DEBUG is not set
>> # CONFIG_ACPI_PCI_SLOT is not set
>> CONFIG_ACPI_CONTAINER=y
>> # CONFIG_ACPI_HOTPLUG_MEMORY is not set
>> CONFIG_ACPI_HOTPLUG_IOAPIC=y
>> # CONFIG_ACPI_SBS is not set
>> # CONFIG_ACPI_HED is not set
>> # CONFIG_ACPI_CUSTOM_METHOD is not set
>> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
>> # CONFIG_ACPI_NFIT is not set
>> CONFIG_HAVE_ACPI_APEI=y
>> CONFIG_HAVE_ACPI_APEI_NMI=y
>> # CONFIG_ACPI_APEI is not set
>> # CONFIG_DPTF_POWER is not set
>> # CONFIG_PMIC_OPREGION is not set
>> # CONFIG_ACPI_CONFIGFS is not set
>> CONFIG_X86_PM_TIMER=y
>> CONFIG_SFI=y
>>
>> #
>> # CPU Frequency scaling
>> #
>> # CONFIG_CPU_FREQ is not set
>>
>> #
>> # CPU Idle
>> #
>> CONFIG_CPU_IDLE=y
>> # CONFIG_CPU_IDLE_GOV_LADDER is not set
>> CONFIG_CPU_IDLE_GOV_MENU=y
>> # CONFIG_CPU_IDLE_GOV_TEO is not set
>> # CONFIG_INTEL_IDLE is not set
>>
>> #
>> # Bus options (PCI etc.)
>> #
>> CONFIG_PCI_DIRECT=y
>> CONFIG_PCI_MMCONFIG=y
>> CONFIG_MMCONF_FAM10H=y
>> # CONFIG_PCI_CNB20LE_QUIRK is not set
>> CONFIG_ISA_BUS=y
>> # CONFIG_ISA_DMA_API is not set
>> CONFIG_AMD_NB=y
>> CONFIG_X86_SYSFB=y
>>
>> #
>> # Binary Emulations
>> #
>> # CONFIG_IA32_EMULATION is not set
>> # CONFIG_X86_X32 is not set
>> CONFIG_X86_DEV_DMA_OPS=y
>> CONFIG_HAVE_GENERIC_GUP=y
>>
>> #
>> # Firmware Drivers
>> #
>> CONFIG_EDD=y
>> CONFIG_EDD_OFF=y
>> CONFIG_FIRMWARE_MEMMAP=y
>> # CONFIG_ISCSI_IBFT_FIND is not set
>> CONFIG_FW_CFG_SYSFS=m
>> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
>> CONFIG_GOOGLE_FIRMWARE=y
>> # CONFIG_GOOGLE_COREBOOT_TABLE is not set
>> CONFIG_EFI_EARLYCON=y
>>
>> #
>> # Tegra firmware driver
>> #
>> CONFIG_HAVE_KVM=y
>> CONFIG_VIRTUALIZATION=y
>> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
>>
>> #
>> # General architecture-dependent options
>> #
>> CONFIG_HOTPLUG_SMT=y
>> CONFIG_HAVE_OPROFILE=y
>> CONFIG_OPROFILE_NMI_TIMER=y
>> # CONFIG_KPROBES is not set
>> # CONFIG_JUMP_LABEL is not set
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
>> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
>> CONFIG_HAVE_IOREMAP_PROT=y
>> CONFIG_HAVE_KPROBES=y
>> CONFIG_HAVE_KRETPROBES=y
>> CONFIG_HAVE_OPTPROBES=y
>> CONFIG_HAVE_KPROBES_ON_FTRACE=y
>> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
>> CONFIG_HAVE_NMI=y
>> CONFIG_HAVE_ARCH_TRACEHOOK=y
>> CONFIG_HAVE_DMA_CONTIGUOUS=y
>> CONFIG_GENERIC_SMP_IDLE_THREAD=y
>> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
>> CONFIG_ARCH_HAS_SET_MEMORY=y
>> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
>> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
>> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
>> CONFIG_HAVE_RSEQ=y
>> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
>> CONFIG_HAVE_CLK=y
>> CONFIG_HAVE_HW_BREAKPOINT=y
>> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
>> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
>> CONFIG_HAVE_PERF_EVENTS_NMI=y
>> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
>> CONFIG_HAVE_PERF_REGS=y
>> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
>> CONFIG_HAVE_ARCH_JUMP_LABEL=y
>> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
>> CONFIG_HAVE_RCU_TABLE_FREE=y
>> CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
>> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
>> CONFIG_HAVE_CMPXCHG_LOCAL=y
>> CONFIG_HAVE_CMPXCHG_DOUBLE=y
>> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
>> CONFIG_SECCOMP_FILTER=y
>> CONFIG_HAVE_ARCH_STACKLEAK=y
>> CONFIG_HAVE_STACKPROTECTOR=y
>> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
>> # CONFIG_STACKPROTECTOR is not set
>> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
>> CONFIG_HAVE_CONTEXT_TRACKING=y
>> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
>> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
>> CONFIG_HAVE_MOVE_PMD=y
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
>> CONFIG_HAVE_ARCH_HUGE_VMAP=y
>> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
>> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
>> CONFIG_MODULES_USE_ELF_RELA=y
>> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
>> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
>> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
>> CONFIG_HAVE_EXIT_THREAD=y
>> CONFIG_ARCH_MMAP_RND_BITS=28
>> CONFIG_HAVE_COPY_THREAD_TLS=y
>> CONFIG_HAVE_STACK_VALIDATION=y
>> CONFIG_HAVE_RELIABLE_STACKTRACE=y
>> CONFIG_ISA_BUS_API=y
>> CONFIG_HAVE_ARCH_VMAP_STACK=y
>> # CONFIG_VMAP_STACK is not set
>> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
>> CONFIG_STRICT_KERNEL_RWX=y
>> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
>> CONFIG_STRICT_MODULE_RWX=y
>> CONFIG_ARCH_HAS_REFCOUNT=y
>> # CONFIG_REFCOUNT_FULL is not set
>> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
>> CONFIG_ARCH_USE_MEMREMAP_PROT=y
>>
>> #
>> # GCOV-based kernel profiling
>> #
>> # CONFIG_GCOV_KERNEL is not set
>> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
>> CONFIG_PLUGIN_HOSTCC="g++"
>> CONFIG_HAVE_GCC_PLUGINS=y
>> CONFIG_GCC_PLUGINS=y
>> # CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
>> CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
>> # CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
>> # CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
>> # CONFIG_GCC_PLUGIN_STACKLEAK is not set
>> CONFIG_RT_MUTEXES=y
>> CONFIG_BASE_SMALL=0
>> CONFIG_MODULES=y
>> # CONFIG_MODULE_FORCE_LOAD is not set
>> # CONFIG_MODULE_UNLOAD is not set
>> # CONFIG_MODVERSIONS is not set
>> # CONFIG_MODULE_SRCVERSION_ALL is not set
>> # CONFIG_MODULE_SIG is not set
>> # CONFIG_MODULE_COMPRESS is not set
>> # CONFIG_TRIM_UNUSED_KSYMS is not set
>> CONFIG_MODULES_TREE_LOOKUP=y
>> CONFIG_BLOCK=y
>> CONFIG_BLK_SCSI_REQUEST=y
>> CONFIG_BLK_DEV_BSG=y
>> CONFIG_BLK_DEV_BSGLIB=y
>> CONFIG_BLK_DEV_INTEGRITY=y
>> # CONFIG_BLK_DEV_ZONED is not set
>> # CONFIG_BLK_CMDLINE_PARSER is not set
>> CONFIG_BLK_WBT=y
>> CONFIG_BLK_WBT_MQ=y
>> CONFIG_BLK_DEBUG_FS=y
>> CONFIG_BLK_SED_OPAL=y
>>
>> #
>> # Partition Types
>> #
>> # CONFIG_PARTITION_ADVANCED is not set
>> CONFIG_MSDOS_PARTITION=y
>> CONFIG_EFI_PARTITION=y
>> CONFIG_BLK_MQ_PCI=y
>> CONFIG_BLK_MQ_VIRTIO=y
>> CONFIG_BLK_PM=y
>>
>> #
>> # IO Schedulers
>> #
>> CONFIG_MQ_IOSCHED_DEADLINE=y
>> # CONFIG_MQ_IOSCHED_KYBER is not set
>> CONFIG_IOSCHED_BFQ=m
>> CONFIG_PADATA=y
>> CONFIG_ASN1=y
>> CONFIG_UNINLINE_SPIN_UNLOCK=y
>> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
>> CONFIG_MUTEX_SPIN_ON_OWNER=y
>> CONFIG_RWSEM_SPIN_ON_OWNER=y
>> CONFIG_LOCK_SPIN_ON_OWNER=y
>> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
>> CONFIG_QUEUED_SPINLOCKS=y
>> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
>> CONFIG_QUEUED_RWLOCKS=y
>> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
>> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
>> CONFIG_FREEZER=y
>>
>> #
>> # Executable file formats
>> #
>> CONFIG_BINFMT_ELF=y
>> CONFIG_ELFCORE=y
>> CONFIG_BINFMT_SCRIPT=y
>> # CONFIG_BINFMT_MISC is not set
>> CONFIG_COREDUMP=y
>>
>> #
>> # Memory Management options
>> #
>> CONFIG_SELECT_MEMORY_MODEL=y
>> CONFIG_SPARSEMEM_MANUAL=y
>> CONFIG_SPARSEMEM=y
>> CONFIG_NEED_MULTIPLE_NODES=y
>> CONFIG_HAVE_MEMORY_PRESENT=y
>> CONFIG_SPARSEMEM_EXTREME=y
>> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
>> # CONFIG_SPARSEMEM_VMEMMAP is not set
>> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
>> CONFIG_ARCH_DISCARD_MEMBLOCK=y
>> CONFIG_MEMORY_ISOLATION=y
>> CONFIG_HAVE_BOOTMEM_INFO_NODE=y
>> CONFIG_MEMORY_HOTPLUG=y
>> CONFIG_MEMORY_HOTPLUG_SPARSE=y
>> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
>> CONFIG_MEMORY_HOTREMOVE=y
>> CONFIG_SPLIT_PTLOCK_CPUS=4
>> CONFIG_COMPACTION=y
>> CONFIG_MIGRATION=y
>> CONFIG_PHYS_ADDR_T_64BIT=y
>> CONFIG_BOUNCE=y
>> CONFIG_VIRT_TO_BUS=y
>> CONFIG_MMU_NOTIFIER=y
>> # CONFIG_KSM is not set
>> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
>> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
>> CONFIG_MEMORY_FAILURE=y
>> # CONFIG_HWPOISON_INJECT is not set
>> CONFIG_TRANSPARENT_HUGEPAGE=y
>> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
>> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
>> CONFIG_ARCH_WANTS_THP_SWAP=y
>> CONFIG_THP_SWAP=y
>> CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
>> # CONFIG_CLEANCACHE is not set
>> CONFIG_FRONTSWAP=y
>> # CONFIG_CMA is not set
>> # CONFIG_MEM_SOFT_DIRTY is not set
>> # CONFIG_ZSWAP is not set
>> # CONFIG_ZPOOL is not set
>> CONFIG_ZBUD=y
>> # CONFIG_ZSMALLOC is not set
>> CONFIG_GENERIC_EARLY_IOREMAP=y
>> CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
>> CONFIG_IDLE_PAGE_TRACKING=y
>> CONFIG_ARCH_HAS_ZONE_DEVICE=y
>> CONFIG_FRAME_VECTOR=y
>> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
>> # CONFIG_PERCPU_STATS is not set
>> CONFIG_GUP_BENCHMARK=y
>> CONFIG_ARCH_HAS_PTE_SPECIAL=y
>> CONFIG_NET=y
>> CONFIG_NET_INGRESS=y
>> CONFIG_SKB_EXTENSIONS=y
>>
>> #
>> # Networking options
>> #
>> CONFIG_PACKET=y
>> CONFIG_PACKET_DIAG=m
>> CONFIG_UNIX=y
>> CONFIG_UNIX_SCM=y
>> # CONFIG_UNIX_DIAG is not set
>> # CONFIG_TLS is not set
>> CONFIG_XFRM=y
>> CONFIG_XFRM_ALGO=y
>> # CONFIG_XFRM_USER is not set
>> # CONFIG_XFRM_INTERFACE is not set
>> # CONFIG_XFRM_SUB_POLICY is not set
>> CONFIG_XFRM_MIGRATE=y
>> # CONFIG_XFRM_STATISTICS is not set
>> CONFIG_NET_KEY=y
>> # CONFIG_NET_KEY_MIGRATE is not set
>> CONFIG_INET=y
>> # CONFIG_IP_MULTICAST is not set
>> # CONFIG_IP_ADVANCED_ROUTER is not set
>> CONFIG_IP_PNP=y
>> CONFIG_IP_PNP_DHCP=y
>> # CONFIG_IP_PNP_BOOTP is not set
>> # CONFIG_IP_PNP_RARP is not set
>> # CONFIG_NET_IPIP is not set
>> # CONFIG_NET_IPGRE_DEMUX is not set
>> CONFIG_NET_IP_TUNNEL=y
>> # CONFIG_SYN_COOKIES is not set
>> # CONFIG_NET_IPVTI is not set
>> # CONFIG_NET_FOU is not set
>> # CONFIG_NET_FOU_IP_TUNNELS is not set
>> # CONFIG_INET_AH is not set
>> # CONFIG_INET_ESP is not set
>> # CONFIG_INET_IPCOMP is not set
>> CONFIG_INET_TUNNEL=y
>> CONFIG_INET_XFRM_MODE_TRANSPORT=y
>> CONFIG_INET_XFRM_MODE_TUNNEL=y
>> CONFIG_INET_XFRM_MODE_BEET=y
>> CONFIG_INET_DIAG=y
>> CONFIG_INET_TCP_DIAG=y
>> # CONFIG_INET_UDP_DIAG is not set
>> # CONFIG_INET_RAW_DIAG is not set
>> # CONFIG_INET_DIAG_DESTROY is not set
>> # CONFIG_TCP_CONG_ADVANCED is not set
>> CONFIG_TCP_CONG_CUBIC=y
>> CONFIG_DEFAULT_TCP_CONG="cubic"
>> # CONFIG_TCP_MD5SIG is not set
>> CONFIG_IPV6=y
>> # CONFIG_IPV6_ROUTER_PREF is not set
>> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
>> # CONFIG_INET6_AH is not set
>> # CONFIG_INET6_ESP is not set
>> # CONFIG_INET6_IPCOMP is not set
>> # CONFIG_IPV6_MIP6 is not set
>> # CONFIG_IPV6_ILA is not set
>> CONFIG_INET6_XFRM_MODE_TRANSPORT=y
>> CONFIG_INET6_XFRM_MODE_TUNNEL=y
>> CONFIG_INET6_XFRM_MODE_BEET=y
>> # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
>> # CONFIG_IPV6_VTI is not set
>> CONFIG_IPV6_SIT=y
>> # CONFIG_IPV6_SIT_6RD is not set
>> CONFIG_IPV6_NDISC_NODETYPE=y
>> # CONFIG_IPV6_TUNNEL is not set
>> # CONFIG_IPV6_MULTIPLE_TABLES is not set
>> # CONFIG_IPV6_MROUTE is not set
>> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
>> # CONFIG_IPV6_SEG6_HMAC is not set
>> CONFIG_NETWORK_SECMARK=y
>> CONFIG_NET_PTP_CLASSIFY=y
>> CONFIG_NETWORK_PHY_TIMESTAMPING=y
>> CONFIG_NETFILTER=y
>> # CONFIG_NETFILTER_ADVANCED is not set
>>
>> #
>> # Core Netfilter Configuration
>> #
>> CONFIG_NETFILTER_INGRESS=y
>> CONFIG_NETFILTER_NETLINK=m
>> CONFIG_NETFILTER_NETLINK_LOG=m
>> CONFIG_NF_CONNTRACK=m
>> CONFIG_NF_LOG_COMMON=m
>> # CONFIG_NF_LOG_NETDEV is not set
>> CONFIG_NF_CONNTRACK_SECMARK=y
>> CONFIG_NF_CONNTRACK_PROCFS=y
>> # CONFIG_NF_CONNTRACK_LABELS is not set
>> CONFIG_NF_CONNTRACK_FTP=m
>> CONFIG_NF_CONNTRACK_IRC=m
>> # CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
>> CONFIG_NF_CONNTRACK_SIP=m
>> CONFIG_NF_CT_NETLINK=m
>> # CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
>> CONFIG_NF_NAT=m
>> CONFIG_NF_NAT_NEEDED=y
>> CONFIG_NF_NAT_FTP=m
>> CONFIG_NF_NAT_IRC=m
>> CONFIG_NF_NAT_SIP=m
>> CONFIG_NF_NAT_MASQUERADE=y
>> # CONFIG_NF_TABLES is not set
>> CONFIG_NETFILTER_XTABLES=m
>>
>> #
>> # Xtables combined modules
>> #
>> CONFIG_NETFILTER_XT_MARK=m
>>
>> #
>> # Xtables targets
>> #
>> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
>> CONFIG_NETFILTER_XT_TARGET_LOG=m
>> CONFIG_NETFILTER_XT_NAT=m
>> # CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
>> CONFIG_NETFILTER_XT_TARGET_NFLOG=m
>> # CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
>> CONFIG_NETFILTER_XT_TARGET_SECMARK=m
>> CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
>>
>> #
>> # Xtables matches
>> #
>> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
>> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
>> CONFIG_NETFILTER_XT_MATCH_POLICY=m
>> CONFIG_NETFILTER_XT_MATCH_STATE=m
>> # CONFIG_IP_SET is not set
>> # CONFIG_IP_VS is not set
>>
>> #
>> # IP: Netfilter Configuration
>> #
>> CONFIG_NF_DEFRAG_IPV4=m
>> # CONFIG_NF_SOCKET_IPV4 is not set
>> # CONFIG_NF_TPROXY_IPV4 is not set
>> # CONFIG_NF_DUP_IPV4 is not set
>> CONFIG_NF_LOG_ARP=m
>> CONFIG_NF_LOG_IPV4=m
>> CONFIG_NF_REJECT_IPV4=m
>> CONFIG_IP_NF_IPTABLES=m
>> CONFIG_IP_NF_FILTER=m
>> CONFIG_IP_NF_TARGET_REJECT=m
>> CONFIG_IP_NF_NAT=m
>> CONFIG_IP_NF_TARGET_MASQUERADE=m
>> CONFIG_IP_NF_MANGLE=m
>> # CONFIG_IP_NF_RAW is not set
>>
>> #
>> # IPv6: Netfilter Configuration
>> #
>> # CONFIG_NF_SOCKET_IPV6 is not set
>> # CONFIG_NF_TPROXY_IPV6 is not set
>> # CONFIG_NF_DUP_IPV6 is not set
>> CONFIG_NF_REJECT_IPV6=m
>> CONFIG_NF_LOG_IPV6=m
>> CONFIG_IP6_NF_IPTABLES=m
>> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
>> CONFIG_IP6_NF_FILTER=m
>> CONFIG_IP6_NF_TARGET_REJECT=m
>> CONFIG_IP6_NF_MANGLE=m
>> # CONFIG_IP6_NF_RAW is not set
>> CONFIG_NF_DEFRAG_IPV6=m
>> # CONFIG_BRIDGE_NF_EBTABLES is not set
>> # CONFIG_BPFILTER is not set
>> # CONFIG_IP_DCCP is not set
>> # CONFIG_IP_SCTP is not set
>> # CONFIG_RDS is not set
>> # CONFIG_TIPC is not set
>> # CONFIG_ATM is not set
>> # CONFIG_L2TP is not set
>> CONFIG_STP=y
>> CONFIG_BRIDGE=y
>> CONFIG_BRIDGE_IGMP_SNOOPING=y
>> CONFIG_HAVE_NET_DSA=y
>> # CONFIG_NET_DSA is not set
>> # CONFIG_VLAN_8021Q is not set
>> CONFIG_DECNET=m
>> CONFIG_DECNET_ROUTER=y
>> CONFIG_LLC=y
>> CONFIG_LLC2=y
>> CONFIG_ATALK=y
>> CONFIG_DEV_APPLETALK=m
>> CONFIG_IPDDP=m
>> # CONFIG_IPDDP_ENCAP is not set
>> CONFIG_X25=y
>> CONFIG_LAPB=y
>> CONFIG_PHONET=m
>> # CONFIG_6LOWPAN is not set
>> # CONFIG_IEEE802154 is not set
>> # CONFIG_NET_SCHED is not set
>> CONFIG_DCB=y
>> CONFIG_DNS_RESOLVER=m
>> # CONFIG_BATMAN_ADV is not set
>> # CONFIG_OPENVSWITCH is not set
>> # CONFIG_VSOCKETS is not set
>> # CONFIG_NETLINK_DIAG is not set
>> # CONFIG_MPLS is not set
>> # CONFIG_NET_NSH is not set
>> CONFIG_HSR=m
>> # CONFIG_NET_SWITCHDEV is not set
>> # CONFIG_NET_L3_MASTER_DEV is not set
>> # CONFIG_NET_NCSI is not set
>> CONFIG_RPS=y
>> CONFIG_RFS_ACCEL=y
>> CONFIG_XPS=y
>> # CONFIG_CGROUP_NET_PRIO is not set
>> # CONFIG_CGROUP_NET_CLASSID is not set
>> CONFIG_NET_RX_BUSY_POLL=y
>> CONFIG_BQL=y
>> # CONFIG_BPF_JIT is not set
>> CONFIG_NET_FLOW_LIMIT=y
>>
>> #
>> # Network testing
>> #
>> # CONFIG_NET_PKTGEN is not set
>> # CONFIG_HAMRADIO is not set
>> # CONFIG_CAN is not set
>> # CONFIG_BT is not set
>> # CONFIG_AF_RXRPC is not set
>> # CONFIG_AF_KCM is not set
>> CONFIG_FIB_RULES=y
>> # CONFIG_WIRELESS is not set
>> CONFIG_WIMAX=y
>> CONFIG_WIMAX_DEBUG_LEVEL=8
>> # CONFIG_RFKILL is not set
>> CONFIG_NET_9P=y
>> CONFIG_NET_9P_VIRTIO=y
>> # CONFIG_NET_9P_DEBUG is not set
>> # CONFIG_CAIF is not set
>> # CONFIG_CEPH_LIB is not set
>> CONFIG_NFC=m
>> # CONFIG_NFC_DIGITAL is not set
>> # CONFIG_NFC_NCI is not set
>> # CONFIG_NFC_HCI is not set
>>
>> #
>> # Near Field Communication (NFC) devices
>> #
>> CONFIG_NFC_PN533=m
>> CONFIG_NFC_PN533_I2C=m
>> CONFIG_PSAMPLE=y
>> # CONFIG_NET_IFE is not set
>> CONFIG_LWTUNNEL=y
>> # CONFIG_LWTUNNEL_BPF is not set
>> CONFIG_DST_CACHE=y
>> CONFIG_GRO_CELLS=y
>> CONFIG_NET_DEVLINK=y
>> CONFIG_FAILOVER=y
>> CONFIG_HAVE_EBPF_JIT=y
>>
>> #
>> # Device Drivers
>> #
>> CONFIG_HAVE_EISA=y
>> # CONFIG_EISA is not set
>> CONFIG_HAVE_PCI=y
>> CONFIG_PCI=y
>> CONFIG_PCI_DOMAINS=y
>> # CONFIG_PCIEPORTBUS is not set
>> # CONFIG_PCI_MSI is not set
>> CONFIG_PCI_QUIRKS=y
>> # CONFIG_PCI_DEBUG is not set
>> CONFIG_PCI_REALLOC_ENABLE_AUTO=y
>> CONFIG_PCI_STUB=m
>> CONFIG_PCI_PF_STUB=m
>> CONFIG_PCI_ATS=y
>> CONFIG_PCI_LOCKLESS_CONFIG=y
>> CONFIG_PCI_IOV=y
>> # CONFIG_PCI_PRI is not set
>> # CONFIG_PCI_PASID is not set
>> CONFIG_PCI_LABEL=y
>> CONFIG_HOTPLUG_PCI=y
>> # CONFIG_HOTPLUG_PCI_ACPI is not set
>> # CONFIG_HOTPLUG_PCI_CPCI is not set
>> CONFIG_HOTPLUG_PCI_SHPC=y
>>
>> #
>> # PCI controller drivers
>> #
>>
>> #
>> # Cadence PCIe controllers support
>> #
>>
>> #
>> # DesignWare PCI Core Support
>> #
>>
>> #
>> # PCI Endpoint
>> #
>> CONFIG_PCI_ENDPOINT=y
>> CONFIG_PCI_ENDPOINT_CONFIGFS=y
>> CONFIG_PCI_EPF_TEST=m
>>
>> #
>> # PCI switch controller drivers
>> #
>> CONFIG_PCI_SW_SWITCHTEC=y
>> # CONFIG_PCCARD is not set
>> CONFIG_RAPIDIO=m
>> CONFIG_RAPIDIO_DISC_TIMEOUT=30
>> # CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
>> CONFIG_RAPIDIO_DMA_ENGINE=y
>> # CONFIG_RAPIDIO_DEBUG is not set
>> CONFIG_RAPIDIO_ENUM_BASIC=m
>> CONFIG_RAPIDIO_CHMAN=m
>> # CONFIG_RAPIDIO_MPORT_CDEV is not set
>>
>> #
>> # RapidIO Switch drivers
>> #
>> CONFIG_RAPIDIO_TSI57X=m
>> # CONFIG_RAPIDIO_CPS_XX is not set
>> CONFIG_RAPIDIO_TSI568=m
>> CONFIG_RAPIDIO_CPS_GEN2=m
>> CONFIG_RAPIDIO_RXS_GEN3=m
>>
>> #
>> # Generic Driver Options
>> #
>> CONFIG_UEVENT_HELPER=y
>> CONFIG_UEVENT_HELPER_PATH=""
>> CONFIG_DEVTMPFS=y
>> # CONFIG_DEVTMPFS_MOUNT is not set
>> CONFIG_STANDALONE=y
>> CONFIG_PREVENT_FIRMWARE_BUILD=y
>>
>> #
>> # Firmware loader
>> #
>> CONFIG_FW_LOADER=y
>> CONFIG_EXTRA_FIRMWARE=""
>> CONFIG_FW_LOADER_USER_HELPER=y
>> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
>> CONFIG_WANT_DEV_COREDUMP=y
>> # CONFIG_ALLOW_DEV_COREDUMP is not set
>> # CONFIG_DEBUG_DRIVER is not set
>> # CONFIG_DEBUG_DEVRES is not set
>> CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
>> CONFIG_TEST_ASYNC_DRIVER_PROBE=m
>> CONFIG_GENERIC_CPU_AUTOPROBE=y
>> CONFIG_GENERIC_CPU_VULNERABILITIES=y
>> CONFIG_REGMAP=y
>> CONFIG_REGMAP_I2C=y
>> CONFIG_REGMAP_W1=m
>> CONFIG_REGMAP_MMIO=y
>> CONFIG_REGMAP_IRQ=y
>> CONFIG_DMA_SHARED_BUFFER=y
>> # CONFIG_DMA_FENCE_TRACE is not set
>>
>> #
>> # Bus devices
>> #
>> CONFIG_CONNECTOR=y
>> # CONFIG_PROC_EVENTS is not set
>> # CONFIG_GNSS is not set
>> CONFIG_MTD=m
>> # CONFIG_MTD_TESTS is not set
>> CONFIG_MTD_CMDLINE_PARTS=m
>> CONFIG_MTD_AR7_PARTS=m
>>
>> #
>> # Partition parsers
>> #
>> CONFIG_MTD_REDBOOT_PARTS=m
>> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
>> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
>> CONFIG_MTD_REDBOOT_PARTS_READONLY=y
>>
>> #
>> # User Modules And Translation Layers
>> #
>> CONFIG_MTD_BLKDEVS=m
>> # CONFIG_MTD_BLOCK is not set
>> CONFIG_MTD_BLOCK_RO=m
>> CONFIG_FTL=m
>> CONFIG_NFTL=m
>> CONFIG_NFTL_RW=y
>> # CONFIG_INFTL is not set
>> CONFIG_RFD_FTL=m
>> # CONFIG_SSFDC is not set
>> # CONFIG_SM_FTL is not set
>> CONFIG_MTD_OOPS=m
>> CONFIG_MTD_SWAP=m
>> # CONFIG_MTD_PARTITIONED_MASTER is not set
>>
>> #
>> # RAM/ROM/Flash chip drivers
>> #
>> CONFIG_MTD_CFI=m
>> CONFIG_MTD_JEDECPROBE=m
>> CONFIG_MTD_GEN_PROBE=m
>> CONFIG_MTD_CFI_ADV_OPTIONS=y
>> # CONFIG_MTD_CFI_NOSWAP is not set
>> CONFIG_MTD_CFI_BE_BYTE_SWAP=y
>> # CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
>> # CONFIG_MTD_CFI_GEOMETRY is not set
>> CONFIG_MTD_MAP_BANK_WIDTH_1=y
>> CONFIG_MTD_MAP_BANK_WIDTH_2=y
>> CONFIG_MTD_MAP_BANK_WIDTH_4=y
>> CONFIG_MTD_CFI_I1=y
>> CONFIG_MTD_CFI_I2=y
>> CONFIG_MTD_OTP=y
>> CONFIG_MTD_CFI_INTELEXT=m
>> CONFIG_MTD_CFI_AMDSTD=m
>> CONFIG_MTD_CFI_STAA=m
>> CONFIG_MTD_CFI_UTIL=m
>> CONFIG_MTD_RAM=m
>> CONFIG_MTD_ROM=m
>> CONFIG_MTD_ABSENT=m
>>
>> #
>> # Mapping drivers for chip access
>> #
>> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
>> CONFIG_MTD_PHYSMAP=m
>> # CONFIG_MTD_PHYSMAP_COMPAT is not set
>> # CONFIG_MTD_AMD76XROM is not set
>> CONFIG_MTD_ICHXROM=m
>> # CONFIG_MTD_ESB2ROM is not set
>> CONFIG_MTD_CK804XROM=m
>> # CONFIG_MTD_SCB2_FLASH is not set
>> CONFIG_MTD_NETtel=m
>> CONFIG_MTD_L440GX=m
>> CONFIG_MTD_INTEL_VR_NOR=m
>> CONFIG_MTD_PLATRAM=m
>>
>> #
>> # Self-contained MTD device drivers
>> #
>> # CONFIG_MTD_PMC551 is not set
>> # CONFIG_MTD_SLRAM is not set
>> # CONFIG_MTD_PHRAM is not set
>> # CONFIG_MTD_MTDRAM is not set
>> CONFIG_MTD_BLOCK2MTD=m
>>
>> #
>> # Disk-On-Chip Device Drivers
>> #
>> # CONFIG_MTD_DOCG3 is not set
>> CONFIG_MTD_ONENAND=m
>> CONFIG_MTD_ONENAND_VERIFY_WRITE=y
>> # CONFIG_MTD_ONENAND_GENERIC is not set
>> CONFIG_MTD_ONENAND_OTP=y
>> CONFIG_MTD_ONENAND_2X_PROGRAM=y
>> # CONFIG_MTD_NAND is not set
>>
>> #
>> # LPDDR & LPDDR2 PCM memory drivers
>> #
>> # CONFIG_MTD_LPDDR is not set
>> CONFIG_MTD_SPI_NOR=m
>> # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
>> # CONFIG_SPI_MTK_QUADSPI is not set
>> CONFIG_SPI_INTEL_SPI=m
>> CONFIG_SPI_INTEL_SPI_PCI=m
>> # CONFIG_SPI_INTEL_SPI_PLATFORM is not set
>> CONFIG_MTD_UBI=m
>> CONFIG_MTD_UBI_WL_THRESHOLD=4096
>> CONFIG_MTD_UBI_BEB_LIMIT=20
>> # CONFIG_MTD_UBI_FASTMAP is not set
>> CONFIG_MTD_UBI_GLUEBI=m
>> # CONFIG_MTD_UBI_BLOCK is not set
>> # CONFIG_OF is not set
>> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
>> CONFIG_PARPORT=y
>> CONFIG_PARPORT_PC=y
>> # CONFIG_PARPORT_SERIAL is not set
>> # CONFIG_PARPORT_PC_FIFO is not set
>> # CONFIG_PARPORT_PC_SUPERIO is not set
>> CONFIG_PARPORT_AX88796=y
>> CONFIG_PARPORT_1284=y
>> CONFIG_PARPORT_NOT_PC=y
>> CONFIG_PNP=y
>> CONFIG_PNP_DEBUG_MESSAGES=y
>>
>> #
>> # Protocols
>> #
>> CONFIG_PNPACPI=y
>> CONFIG_BLK_DEV=y
>> # CONFIG_BLK_DEV_NULL_BLK is not set
>> # CONFIG_PARIDE is not set
>> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
>> # CONFIG_BLK_DEV_UMEM is not set
>> # CONFIG_BLK_DEV_LOOP is not set
>> # CONFIG_BLK_DEV_DRBD is not set
>> # CONFIG_BLK_DEV_NBD is not set
>> # CONFIG_BLK_DEV_SKD is not set
>> # CONFIG_BLK_DEV_SX8 is not set
>> # CONFIG_BLK_DEV_RAM is not set
>> # CONFIG_CDROM_PKTCDVD is not set
>> # CONFIG_ATA_OVER_ETH is not set
>> # CONFIG_VIRTIO_BLK is not set
>> # CONFIG_BLK_DEV_RBD is not set
>> # CONFIG_BLK_DEV_RSXX is not set
>>
>> #
>> # NVME Support
>> #
>> CONFIG_NVME_CORE=y
>> CONFIG_BLK_DEV_NVME=y
>> CONFIG_NVME_MULTIPATH=y
>> CONFIG_NVME_FABRICS=y
>> CONFIG_NVME_FC=m
>> # CONFIG_NVME_TCP is not set
>> CONFIG_NVME_TARGET=y
>> CONFIG_NVME_TARGET_LOOP=y
>> CONFIG_NVME_TARGET_FC=y
>> # CONFIG_NVME_TARGET_FCLOOP is not set
>> # CONFIG_NVME_TARGET_TCP is not set
>>
>> #
>> # Misc devices
>> #
>> CONFIG_AD525X_DPOT=y
>> CONFIG_AD525X_DPOT_I2C=y
>> # CONFIG_DUMMY_IRQ is not set
>> CONFIG_IBM_ASM=m
>> CONFIG_PHANTOM=y
>> CONFIG_SGI_IOC4=y
>> CONFIG_TIFM_CORE=y
>> CONFIG_TIFM_7XX1=y
>> CONFIG_ICS932S401=y
>> CONFIG_ENCLOSURE_SERVICES=y
>> # CONFIG_HP_ILO is not set
>> CONFIG_APDS9802ALS=m
>> CONFIG_ISL29003=m
>> CONFIG_ISL29020=m
>> CONFIG_SENSORS_TSL2550=m
>> # CONFIG_SENSORS_BH1770 is not set
>> CONFIG_SENSORS_APDS990X=m
>> # CONFIG_HMC6352 is not set
>> # CONFIG_DS1682 is not set
>> CONFIG_VMWARE_BALLOON=y
>> CONFIG_USB_SWITCH_FSA9480=m
>> CONFIG_SRAM=y
>> # CONFIG_PCI_ENDPOINT_TEST is not set
>> CONFIG_MISC_RTSX=y
>> # CONFIG_PVPANIC is not set
>> # CONFIG_C2PORT is not set
>>
>> #
>> # EEPROM support
>> #
>> # CONFIG_EEPROM_AT24 is not set
>> CONFIG_EEPROM_LEGACY=y
>> CONFIG_EEPROM_MAX6875=y
>> CONFIG_EEPROM_93CX6=m
>> CONFIG_EEPROM_IDT_89HPESX=y
>> # CONFIG_EEPROM_EE1004 is not set
>> CONFIG_CB710_CORE=y
>> # CONFIG_CB710_DEBUG is not set
>> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
>>
>> #
>> # Texas Instruments shared transport line discipline
>> #
>> # CONFIG_TI_ST is not set
>> # CONFIG_SENSORS_LIS3_I2C is not set
>> CONFIG_ALTERA_STAPL=m
>> CONFIG_INTEL_MEI=y
>> CONFIG_INTEL_MEI_ME=y
>> CONFIG_INTEL_MEI_TXE=m
>> # CONFIG_INTEL_MEI_HDCP is not set
>> CONFIG_VMWARE_VMCI=y
>>
>> #
>> # Intel MIC & related support
>> #
>>
>> #
>> # Intel MIC Bus Driver
>> #
>> CONFIG_INTEL_MIC_BUS=y
>>
>> #
>> # SCIF Bus Driver
>> #
>> # CONFIG_SCIF_BUS is not set
>>
>> #
>> # VOP Bus Driver
>> #
>> # CONFIG_VOP_BUS is not set
>>
>> #
>> # Intel MIC Host Driver
>> #
>>
>> #
>> # Intel MIC Card Driver
>> #
>>
>> #
>> # SCIF Driver
>> #
>>
>> #
>> # Intel MIC Coprocessor State Management (COSM) Drivers
>> #
>>
>> #
>> # VOP Driver
>> #
>> CONFIG_GENWQE=y
>> CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
>> CONFIG_ECHO=m
>> # CONFIG_MISC_ALCOR_PCI is not set
>> CONFIG_MISC_RTSX_PCI=y
>> # CONFIG_HABANA_AI is not set
>> CONFIG_HAVE_IDE=y
>> CONFIG_IDE=m
>>
>> #
>> # Please see Documentation/ide/ide.txt for help/info on IDE drives
>> #
>> CONFIG_IDE_XFER_MODE=y
>> CONFIG_IDE_TIMINGS=y
>> CONFIG_IDE_ATAPI=y
>> CONFIG_BLK_DEV_IDE_SATA=y
>> # CONFIG_IDE_GD is not set
>> # CONFIG_BLK_DEV_IDECD is not set
>> CONFIG_BLK_DEV_IDETAPE=m
>> # CONFIG_BLK_DEV_IDEACPI is not set
>> CONFIG_IDE_TASK_IOCTL=y
>> CONFIG_IDE_PROC_FS=y
>>
>> #
>> # IDE chipset support/bugfixes
>> #
>> CONFIG_IDE_GENERIC=m
>> # CONFIG_BLK_DEV_PLATFORM is not set
>> CONFIG_BLK_DEV_CMD640=m
>> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
>> # CONFIG_BLK_DEV_IDEPNP is not set
>> CONFIG_BLK_DEV_IDEDMA_SFF=y
>>
>> #
>> # PCI IDE chipsets support
>> #
>> CONFIG_BLK_DEV_IDEPCI=y
>> # CONFIG_BLK_DEV_OFFBOARD is not set
>> CONFIG_BLK_DEV_GENERIC=m
>> CONFIG_BLK_DEV_OPTI621=m
>> CONFIG_BLK_DEV_RZ1000=m
>> CONFIG_BLK_DEV_IDEDMA_PCI=y
>> CONFIG_BLK_DEV_AEC62XX=m
>> # CONFIG_BLK_DEV_ALI15X3 is not set
>> CONFIG_BLK_DEV_AMD74XX=m
>> CONFIG_BLK_DEV_ATIIXP=m
>> CONFIG_BLK_DEV_CMD64X=m
>> # CONFIG_BLK_DEV_TRIFLEX is not set
>> # CONFIG_BLK_DEV_HPT366 is not set
>> CONFIG_BLK_DEV_JMICRON=m
>> CONFIG_BLK_DEV_PIIX=m
>> # CONFIG_BLK_DEV_IT8172 is not set
>> CONFIG_BLK_DEV_IT8213=m
>> CONFIG_BLK_DEV_IT821X=m
>> CONFIG_BLK_DEV_NS87415=m
>> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
>> CONFIG_BLK_DEV_PDC202XX_NEW=m
>> # CONFIG_BLK_DEV_SVWKS is not set
>> CONFIG_BLK_DEV_SIIMAGE=m
>> CONFIG_BLK_DEV_SIS5513=m
>> CONFIG_BLK_DEV_SLC90E66=m
>> # CONFIG_BLK_DEV_TRM290 is not set
>> CONFIG_BLK_DEV_VIA82CXXX=m
>> # CONFIG_BLK_DEV_TC86C001 is not set
>> CONFIG_BLK_DEV_IDEDMA=y
>>
>> #
>> # SCSI device support
>> #
>> CONFIG_SCSI_MOD=y
>> CONFIG_RAID_ATTRS=y
>> CONFIG_SCSI=y
>> CONFIG_SCSI_DMA=y
>> CONFIG_SCSI_PROC_FS=y
>>
>> #
>> # SCSI support type (disk, tape, CD-ROM)
>> #
>> # CONFIG_BLK_DEV_SD is not set
>> CONFIG_CHR_DEV_ST=m
>> CONFIG_CHR_DEV_OSST=y
>> # CONFIG_BLK_DEV_SR is not set
>> CONFIG_CHR_DEV_SG=m
>> CONFIG_CHR_DEV_SCH=m
>> # CONFIG_SCSI_ENCLOSURE is not set
>> CONFIG_SCSI_CONSTANTS=y
>> CONFIG_SCSI_LOGGING=y
>> CONFIG_SCSI_SCAN_ASYNC=y
>>
>> #
>> # SCSI Transports
>> #
>> CONFIG_SCSI_SPI_ATTRS=y
>> # CONFIG_SCSI_FC_ATTRS is not set
>> CONFIG_SCSI_ISCSI_ATTRS=y
>> CONFIG_SCSI_SAS_ATTRS=y
>> CONFIG_SCSI_SAS_LIBSAS=y
>> # CONFIG_SCSI_SAS_HOST_SMP is not set
>> # CONFIG_SCSI_SRP_ATTRS is not set
>> CONFIG_SCSI_LOWLEVEL=y
>> # CONFIG_ISCSI_TCP is not set
>> CONFIG_ISCSI_BOOT_SYSFS=y
>> # CONFIG_SCSI_CXGB3_ISCSI is not set
>> # CONFIG_SCSI_CXGB4_ISCSI is not set
>> # CONFIG_SCSI_BNX2_ISCSI is not set
>> CONFIG_BE2ISCSI=y
>> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
>> # CONFIG_SCSI_HPSA is not set
>> CONFIG_SCSI_3W_9XXX=y
>> CONFIG_SCSI_3W_SAS=y
>> CONFIG_SCSI_ACARD=y
>> # CONFIG_SCSI_AACRAID is not set
>> # CONFIG_SCSI_AIC7XXX is not set
>> CONFIG_SCSI_AIC79XX=y
>> CONFIG_AIC79XX_CMDS_PER_DEVICE=32
>> CONFIG_AIC79XX_RESET_DELAY_MS=5000
>> CONFIG_AIC79XX_DEBUG_ENABLE=y
>> CONFIG_AIC79XX_DEBUG_MASK=0
>> CONFIG_AIC79XX_REG_PRETTY_PRINT=y
>> CONFIG_SCSI_AIC94XX=y
>> # CONFIG_AIC94XX_DEBUG is not set
>> CONFIG_SCSI_MVSAS=m
>> CONFIG_SCSI_MVSAS_DEBUG=y
>> CONFIG_SCSI_MVSAS_TASKLET=y
>> CONFIG_SCSI_MVUMI=m
>> CONFIG_SCSI_DPT_I2O=m
>> CONFIG_SCSI_ADVANSYS=y
>> CONFIG_SCSI_ARCMSR=m
>> CONFIG_SCSI_ESAS2R=m
>> # CONFIG_MEGARAID_NEWGEN is not set
>> CONFIG_MEGARAID_LEGACY=y
>> # CONFIG_MEGARAID_SAS is not set
>> CONFIG_SCSI_MPT3SAS=y
>> CONFIG_SCSI_MPT2SAS_MAX_SGE=128
>> CONFIG_SCSI_MPT3SAS_MAX_SGE=128
>> # CONFIG_SCSI_MPT2SAS is not set
>> # CONFIG_SCSI_SMARTPQI is not set
>> CONFIG_SCSI_UFSHCD=y
>> CONFIG_SCSI_UFSHCD_PCI=m
>> CONFIG_SCSI_UFS_DWC_TC_PCI=m
>> CONFIG_SCSI_UFSHCD_PLATFORM=m
>> # CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
>> # CONFIG_SCSI_UFS_DWC_TC_PLATFORM is not set
>> # CONFIG_SCSI_UFS_BSG is not set
>> CONFIG_SCSI_HPTIOP=m
>> # CONFIG_SCSI_MYRB is not set
>> # CONFIG_SCSI_MYRS is not set
>> # CONFIG_VMWARE_PVSCSI is not set
>> CONFIG_SCSI_SNIC=y
>> CONFIG_SCSI_SNIC_DEBUG_FS=y
>> CONFIG_SCSI_DMX3191D=m
>> # CONFIG_SCSI_GDTH is not set
>> CONFIG_SCSI_ISCI=m
>> # CONFIG_SCSI_IPS is not set
>> # CONFIG_SCSI_INITIO is not set
>> CONFIG_SCSI_INIA100=m
>> CONFIG_SCSI_PPA=y
>> CONFIG_SCSI_IMM=m
>> # CONFIG_SCSI_IZIP_EPP16 is not set
>> CONFIG_SCSI_IZIP_SLOW_CTR=y
>> CONFIG_SCSI_STEX=y
>> # CONFIG_SCSI_SYM53C8XX_2 is not set
>> CONFIG_SCSI_QLOGIC_1280=y
>> CONFIG_SCSI_QLA_ISCSI=y
>> # CONFIG_SCSI_DC395x is not set
>> # CONFIG_SCSI_AM53C974 is not set
>> # CONFIG_SCSI_WD719X is not set
>> # CONFIG_SCSI_DEBUG is not set
>> CONFIG_SCSI_PMCRAID=y
>> CONFIG_SCSI_PM8001=m
>> CONFIG_SCSI_VIRTIO=m
>> CONFIG_SCSI_DH=y
>> CONFIG_SCSI_DH_RDAC=y
>> # CONFIG_SCSI_DH_HP_SW is not set
>> CONFIG_SCSI_DH_EMC=m
>> # CONFIG_SCSI_DH_ALUA is not set
>> # CONFIG_ATA is not set
>> CONFIG_MD=y
>> CONFIG_BLK_DEV_MD=y
>> CONFIG_MD_AUTODETECT=y
>> # CONFIG_MD_LINEAR is not set
>> # CONFIG_MD_RAID0 is not set
>> # CONFIG_MD_RAID1 is not set
>> CONFIG_MD_RAID10=y
>> # CONFIG_MD_RAID456 is not set
>> # CONFIG_MD_MULTIPATH is not set
>> # CONFIG_MD_FAULTY is not set
>> # CONFIG_BCACHE is not set
>> # CONFIG_BLK_DEV_DM is not set
>> CONFIG_TARGET_CORE=m
>> CONFIG_TCM_IBLOCK=m
>> CONFIG_TCM_FILEIO=m
>> CONFIG_TCM_PSCSI=m
>> CONFIG_TCM_USER2=m
>> CONFIG_LOOPBACK_TARGET=m
>> CONFIG_ISCSI_TARGET=m
>> CONFIG_SBP_TARGET=m
>> # CONFIG_FUSION is not set
>>
>> #
>> # IEEE 1394 (FireWire) support
>> #
>> CONFIG_FIREWIRE=m
>> # CONFIG_FIREWIRE_OHCI is not set
>> CONFIG_FIREWIRE_SBP2=m
>> # CONFIG_FIREWIRE_NET is not set
>> CONFIG_FIREWIRE_NOSY=m
>> # CONFIG_MACINTOSH_DRIVERS is not set
>> CONFIG_NETDEVICES=y
>> CONFIG_NET_CORE=y
>> # CONFIG_BONDING is not set
>> # CONFIG_DUMMY is not set
>> CONFIG_EQUALIZER=m
>> CONFIG_NET_FC=y
>> CONFIG_NET_TEAM=y
>> CONFIG_NET_TEAM_MODE_BROADCAST=m
>> # CONFIG_NET_TEAM_MODE_ROUNDROBIN is not set
>> # CONFIG_NET_TEAM_MODE_RANDOM is not set
>> # CONFIG_NET_TEAM_MODE_ACTIVEBACKUP is not set
>> CONFIG_NET_TEAM_MODE_LOADBALANCE=m
>> # CONFIG_MACVLAN is not set
>> # CONFIG_IPVLAN is not set
>> # CONFIG_VXLAN is not set
>> # CONFIG_GENEVE is not set
>> # CONFIG_MACSEC is not set
>> CONFIG_NETCONSOLE=m
>> # CONFIG_NETCONSOLE_DYNAMIC is not set
>> CONFIG_NETPOLL=y
>> CONFIG_NET_POLL_CONTROLLER=y
>> # CONFIG_NTB_NETDEV is not set
>> CONFIG_RIONET=m
>> CONFIG_RIONET_TX_SIZE=128
>> CONFIG_RIONET_RX_SIZE=128
>> # CONFIG_TUN is not set
>> # CONFIG_TUN_VNET_CROSS_LE is not set
>> # CONFIG_VETH is not set
>> CONFIG_VIRTIO_NET=m
>> # CONFIG_NLMON is not set
>> CONFIG_ARCNET=m
>> CONFIG_ARCNET_1201=m
>> CONFIG_ARCNET_1051=m
>> CONFIG_ARCNET_RAW=m
>> CONFIG_ARCNET_CAP=m
>> CONFIG_ARCNET_COM90xx=m
>> CONFIG_ARCNET_COM90xxIO=m
>> CONFIG_ARCNET_RIM_I=m
>> # CONFIG_ARCNET_COM20020 is not set
>>
>> #
>> # CAIF transport drivers
>> #
>>
>> #
>> # Distributed Switch Architecture drivers
>> #
>> CONFIG_ETHERNET=y
>> CONFIG_NET_VENDOR_3COM=y
>> # CONFIG_VORTEX is not set
>> # CONFIG_TYPHOON is not set
>> CONFIG_NET_VENDOR_ADAPTEC=y
>> # CONFIG_ADAPTEC_STARFIRE is not set
>> CONFIG_NET_VENDOR_AGERE=y
>> # CONFIG_ET131X is not set
>> CONFIG_NET_VENDOR_ALACRITECH=y
>> # CONFIG_SLICOSS is not set
>> CONFIG_NET_VENDOR_ALTEON=y
>> # CONFIG_ACENIC is not set
>> # CONFIG_ALTERA_TSE is not set
>> CONFIG_NET_VENDOR_AMAZON=y
>> CONFIG_NET_VENDOR_AMD=y
>> # CONFIG_AMD8111_ETH is not set
>> # CONFIG_PCNET32 is not set
>> # CONFIG_AMD_XGBE is not set
>> CONFIG_NET_VENDOR_AQUANTIA=y
>> # CONFIG_AQTION is not set
>> CONFIG_NET_VENDOR_ARC=y
>> CONFIG_NET_VENDOR_ATHEROS=y
>> # CONFIG_ATL2 is not set
>> # CONFIG_ATL1 is not set
>> # CONFIG_ATL1E is not set
>> # CONFIG_ATL1C is not set
>> # CONFIG_ALX is not set
>> CONFIG_NET_VENDOR_AURORA=y
>> # CONFIG_AURORA_NB8800 is not set
>> CONFIG_NET_VENDOR_BROADCOM=y
>> # CONFIG_B44 is not set
>> # CONFIG_BCMGENET is not set
>> # CONFIG_BNX2 is not set
>> # CONFIG_CNIC is not set
>> # CONFIG_TIGON3 is not set
>> # CONFIG_BNX2X is not set
>> # CONFIG_SYSTEMPORT is not set
>> # CONFIG_BNXT is not set
>> CONFIG_NET_VENDOR_BROCADE=y
>> # CONFIG_BNA is not set
>> CONFIG_NET_VENDOR_CADENCE=y
>> # CONFIG_MACB is not set
>> CONFIG_NET_VENDOR_CAVIUM=y
>> # CONFIG_THUNDER_NIC_PF is not set
>> # CONFIG_THUNDER_NIC_VF is not set
>> # CONFIG_THUNDER_NIC_BGX is not set
>> # CONFIG_THUNDER_NIC_RGX is not set
>> CONFIG_CAVIUM_PTP=y
>> # CONFIG_LIQUIDIO is not set
>> CONFIG_NET_VENDOR_CHELSIO=y
>> # CONFIG_CHELSIO_T1 is not set
>> # CONFIG_CHELSIO_T3 is not set
>> # CONFIG_CHELSIO_T4 is not set
>> # CONFIG_CHELSIO_T4VF is not set
>> CONFIG_NET_VENDOR_CISCO=y
>> # CONFIG_ENIC is not set
>> CONFIG_NET_VENDOR_CORTINA=y
>> # CONFIG_CX_ECAT is not set
>> # CONFIG_DNET is not set
>> CONFIG_NET_VENDOR_DEC=y
>> # CONFIG_NET_TULIP is not set
>> CONFIG_NET_VENDOR_DLINK=y
>> # CONFIG_DL2K is not set
>> # CONFIG_SUNDANCE is not set
>> CONFIG_NET_VENDOR_EMULEX=y
>> # CONFIG_BE2NET is not set
>> CONFIG_NET_VENDOR_EZCHIP=y
>> CONFIG_NET_VENDOR_HP=y
>> # CONFIG_HP100 is not set
>> CONFIG_NET_VENDOR_HUAWEI=y
>> CONFIG_NET_VENDOR_I825XX=y
>> CONFIG_NET_VENDOR_INTEL=y
>> # CONFIG_E100 is not set
>> CONFIG_E1000=y
>> # CONFIG_E1000E is not set
>> # CONFIG_IGB is not set
>> # CONFIG_IGBVF is not set
>> # CONFIG_IXGB is not set
>> # CONFIG_IXGBE is not set
>> # CONFIG_I40E is not set
>> # CONFIG_IGC is not set
>> # CONFIG_JME is not set
>> CONFIG_NET_VENDOR_MARVELL=y
>> # CONFIG_MVMDIO is not set
>> # CONFIG_SKGE is not set
>> # CONFIG_SKY2 is not set
>> CONFIG_NET_VENDOR_MELLANOX=y
>> # CONFIG_MLX4_EN is not set
>> # CONFIG_MLX5_CORE is not set
>> # CONFIG_MLXSW_CORE is not set
>> # CONFIG_MLXFW is not set
>> CONFIG_NET_VENDOR_MICREL=y
>> # CONFIG_KS8842 is not set
>> # CONFIG_KS8851_MLL is not set
>> # CONFIG_KSZ884X_PCI is not set
>> CONFIG_NET_VENDOR_MICROCHIP=y
>> # CONFIG_LAN743X is not set
>> CONFIG_NET_VENDOR_MICROSEMI=y
>> CONFIG_NET_VENDOR_MYRI=y
>> # CONFIG_MYRI10GE is not set
>> # CONFIG_FEALNX is not set
>> CONFIG_NET_VENDOR_NATSEMI=y
>> # CONFIG_NATSEMI is not set
>> # CONFIG_NS83820 is not set
>> CONFIG_NET_VENDOR_NETERION=y
>> # CONFIG_S2IO is not set
>> # CONFIG_VXGE is not set
>> CONFIG_NET_VENDOR_NETRONOME=y
>> CONFIG_NET_VENDOR_NI=y
>> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
>> CONFIG_NET_VENDOR_8390=y
>> # CONFIG_NE2K_PCI is not set
>> CONFIG_NET_VENDOR_NVIDIA=y
>> # CONFIG_FORCEDETH is not set
>> CONFIG_NET_VENDOR_OKI=y
>> # CONFIG_ETHOC is not set
>> CONFIG_NET_VENDOR_PACKET_ENGINES=y
>> # CONFIG_HAMACHI is not set
>> # CONFIG_YELLOWFIN is not set
>> CONFIG_NET_VENDOR_QLOGIC=y
>> # CONFIG_QLA3XXX is not set
>> # CONFIG_QLCNIC is not set
>> # CONFIG_QLGE is not set
>> # CONFIG_NETXEN_NIC is not set
>> # CONFIG_QED is not set
>> CONFIG_NET_VENDOR_QUALCOMM=y
>> # CONFIG_QCOM_EMAC is not set
>> # CONFIG_RMNET is not set
>> CONFIG_NET_VENDOR_RDC=y
>> # CONFIG_R6040 is not set
>> CONFIG_NET_VENDOR_REALTEK=y
>> # CONFIG_ATP is not set
>> # CONFIG_8139CP is not set
>> # CONFIG_8139TOO is not set
>> # CONFIG_R8169 is not set
>> CONFIG_NET_VENDOR_RENESAS=y
>> CONFIG_NET_VENDOR_ROCKER=y
>> CONFIG_NET_VENDOR_SAMSUNG=y
>> # CONFIG_SXGBE_ETH is not set
>> CONFIG_NET_VENDOR_SEEQ=y
>> CONFIG_NET_VENDOR_SOLARFLARE=y
>> # CONFIG_SFC is not set
>> # CONFIG_SFC_FALCON is not set
>> CONFIG_NET_VENDOR_SILAN=y
>> # CONFIG_SC92031 is not set
>> CONFIG_NET_VENDOR_SIS=y
>> # CONFIG_SIS900 is not set
>> # CONFIG_SIS190 is not set
>> CONFIG_NET_VENDOR_SMSC=y
>> # CONFIG_EPIC100 is not set
>> # CONFIG_SMSC911X is not set
>> # CONFIG_SMSC9420 is not set
>> CONFIG_NET_VENDOR_SOCIONEXT=y
>> CONFIG_NET_VENDOR_STMICRO=y
>> # CONFIG_STMMAC_ETH is not set
>> CONFIG_NET_VENDOR_SUN=y
>> # CONFIG_HAPPYMEAL is not set
>> # CONFIG_SUNGEM is not set
>> # CONFIG_CASSINI is not set
>> # CONFIG_NIU is not set
>> CONFIG_NET_VENDOR_SYNOPSYS=y
>> # CONFIG_DWC_XLGMAC is not set
>> CONFIG_NET_VENDOR_TEHUTI=y
>> # CONFIG_TEHUTI is not set
>> CONFIG_NET_VENDOR_TI=y
>> # CONFIG_TI_CPSW_PHY_SEL is not set
>> # CONFIG_TI_CPSW_ALE is not set
>> # CONFIG_TLAN is not set
>> CONFIG_NET_VENDOR_VIA=y
>> # CONFIG_VIA_RHINE is not set
>> # CONFIG_VIA_VELOCITY is not set
>> CONFIG_NET_VENDOR_WIZNET=y
>> # CONFIG_WIZNET_W5100 is not set
>> # CONFIG_WIZNET_W5300 is not set
>> CONFIG_FDDI=m
>> CONFIG_DEFXX=m
>> CONFIG_DEFXX_MMIO=y
>> CONFIG_SKFP=m
>> # CONFIG_HIPPI is not set
>> # CONFIG_NET_SB1000 is not set
>> CONFIG_MDIO_DEVICE=y
>> CONFIG_MDIO_BUS=y
>> # CONFIG_MDIO_BCM_UNIMAC is not set
>> # CONFIG_MDIO_BITBANG is not set
>> CONFIG_MDIO_CAVIUM=m
>> CONFIG_MDIO_MSCC_MIIM=m
>> CONFIG_MDIO_THUNDER=m
>> CONFIG_PHYLIB=y
>> CONFIG_SWPHY=y
>> # CONFIG_LED_TRIGGER_PHY is not set
>>
>> #
>> # MII PHY device drivers
>> #
>> CONFIG_AMD_PHY=m
>> # CONFIG_AQUANTIA_PHY is not set
>> CONFIG_ASIX_PHY=m
>> CONFIG_AT803X_PHY=y
>> CONFIG_BCM7XXX_PHY=m
>> # CONFIG_BCM87XX_PHY is not set
>> CONFIG_BCM_NET_PHYLIB=m
>> CONFIG_BROADCOM_PHY=m
>> CONFIG_CICADA_PHY=y
>> CONFIG_CORTINA_PHY=m
>> CONFIG_DAVICOM_PHY=m
>> # CONFIG_DP83822_PHY is not set
>> CONFIG_DP83TC811_PHY=y
>> # CONFIG_DP83848_PHY is not set
>> # CONFIG_DP83867_PHY is not set
>> CONFIG_FIXED_PHY=m
>> # CONFIG_ICPLUS_PHY is not set
>> CONFIG_INTEL_XWAY_PHY=m
>> CONFIG_LSI_ET1011C_PHY=m
>> CONFIG_LXT_PHY=m
>> CONFIG_MARVELL_PHY=y
>> CONFIG_MARVELL_10G_PHY=y
>> # CONFIG_MICREL_PHY is not set
>> CONFIG_MICROCHIP_PHY=m
>> # CONFIG_MICROCHIP_T1_PHY is not set
>> # CONFIG_MICROSEMI_PHY is not set
>> CONFIG_NATIONAL_PHY=m
>> CONFIG_QSEMI_PHY=y
>> CONFIG_REALTEK_PHY=y
>> CONFIG_RENESAS_PHY=m
>> CONFIG_ROCKCHIP_PHY=y
>> # CONFIG_SMSC_PHY is not set
>> # CONFIG_STE10XP is not set
>> CONFIG_TERANETICS_PHY=m
>> CONFIG_VITESSE_PHY=m
>> CONFIG_XILINX_GMII2RGMII=m
>> CONFIG_PLIP=m
>> CONFIG_PPP=m
>> CONFIG_PPP_BSDCOMP=m
>> CONFIG_PPP_DEFLATE=m
>> CONFIG_PPP_FILTER=y
>> CONFIG_PPP_MPPE=m
>> CONFIG_PPP_MULTILINK=y
>> # CONFIG_PPPOE is not set
>> # CONFIG_PPP_ASYNC is not set
>> # CONFIG_PPP_SYNC_TTY is not set
>> # CONFIG_SLIP is not set
>> CONFIG_SLHC=m
>>
>> #
>> # Host-side USB support is needed for USB Network Adapter support
>> #
>> # CONFIG_WLAN is not set
>>
>> #
>> # WiMAX Wireless Broadband devices
>> #
>>
>> #
>> # Enable USB support to see WiMAX USB drivers
>> #
>> # CONFIG_WAN is not set
>> # CONFIG_VMXNET3 is not set
>> # CONFIG_FUJITSU_ES is not set
>> # CONFIG_THUNDERBOLT_NET is not set
>> # CONFIG_NETDEVSIM is not set
>> CONFIG_NET_FAILOVER=y
>> # CONFIG_ISDN is not set
>> CONFIG_NVM=y
>> # CONFIG_NVM_PBLK is not set
>>
>> #
>> # Input device support
>> #
>> CONFIG_INPUT=y
>> CONFIG_INPUT_LEDS=m
>> CONFIG_INPUT_FF_MEMLESS=m
>> CONFIG_INPUT_POLLDEV=y
>> # CONFIG_INPUT_SPARSEKMAP is not set
>> CONFIG_INPUT_MATRIXKMAP=y
>>
>> #
>> # Userland interfaces
>> #
>> CONFIG_INPUT_MOUSEDEV=m
>> CONFIG_INPUT_MOUSEDEV_PSAUX=y
>> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
>> CONFIG_INPUT_JOYDEV=m
>> # CONFIG_INPUT_EVDEV is not set
>> CONFIG_INPUT_EVBUG=y
>>
>> #
>> # Input Device Drivers
>> #
>> CONFIG_INPUT_KEYBOARD=y
>> # CONFIG_KEYBOARD_ADC is not set
>> # CONFIG_KEYBOARD_ADP5588 is not set
>> # CONFIG_KEYBOARD_ADP5589 is not set
>> CONFIG_KEYBOARD_ATKBD=y
>> # CONFIG_KEYBOARD_QT1070 is not set
>> # CONFIG_KEYBOARD_QT2160 is not set
>> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
>> # CONFIG_KEYBOARD_LKKBD is not set
>> # CONFIG_KEYBOARD_GPIO is not set
>> # CONFIG_KEYBOARD_GPIO_POLLED is not set
>> # CONFIG_KEYBOARD_TCA6416 is not set
>> # CONFIG_KEYBOARD_TCA8418 is not set
>> # CONFIG_KEYBOARD_MATRIX is not set
>> # CONFIG_KEYBOARD_LM8323 is not set
>> # CONFIG_KEYBOARD_LM8333 is not set
>> # CONFIG_KEYBOARD_MAX7359 is not set
>> # CONFIG_KEYBOARD_MCS is not set
>> # CONFIG_KEYBOARD_MPR121 is not set
>> # CONFIG_KEYBOARD_NEWTON is not set
>> # CONFIG_KEYBOARD_OPENCORES is not set
>> # CONFIG_KEYBOARD_SAMSUNG is not set
>> # CONFIG_KEYBOARD_STOWAWAY is not set
>> # CONFIG_KEYBOARD_SUNKBD is not set
>> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
>> # CONFIG_KEYBOARD_XTKBD is not set
>> # CONFIG_KEYBOARD_MTK_PMIC is not set
>> CONFIG_INPUT_MOUSE=y
>> CONFIG_MOUSE_PS2=m
>> CONFIG_MOUSE_PS2_ALPS=y
>> CONFIG_MOUSE_PS2_BYD=y
>> # CONFIG_MOUSE_PS2_LOGIPS2PP is not set
>> # CONFIG_MOUSE_PS2_SYNAPTICS is not set
>> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
>> # CONFIG_MOUSE_PS2_CYPRESS is not set
>> # CONFIG_MOUSE_PS2_TRACKPOINT is not set
>> # CONFIG_MOUSE_PS2_ELANTECH is not set
>> CONFIG_MOUSE_PS2_SENTELIC=y
>> CONFIG_MOUSE_PS2_TOUCHKIT=y
>> CONFIG_MOUSE_PS2_FOCALTECH=y
>> # CONFIG_MOUSE_PS2_VMMOUSE is not set
>> CONFIG_MOUSE_PS2_SMBUS=y
>> # CONFIG_MOUSE_SERIAL is not set
>> # CONFIG_MOUSE_APPLETOUCH is not set
>> # CONFIG_MOUSE_BCM5974 is not set
>> CONFIG_MOUSE_CYAPA=y
>> CONFIG_MOUSE_ELAN_I2C=y
>> # CONFIG_MOUSE_ELAN_I2C_I2C is not set
>> CONFIG_MOUSE_ELAN_I2C_SMBUS=y
>> CONFIG_MOUSE_VSXXXAA=m
>> CONFIG_MOUSE_GPIO=y
>> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
>> # CONFIG_MOUSE_SYNAPTICS_USB is not set
>> CONFIG_INPUT_JOYSTICK=y
>> # CONFIG_JOYSTICK_ANALOG is not set
>> # CONFIG_JOYSTICK_A3D is not set
>> # CONFIG_JOYSTICK_ADI is not set
>> CONFIG_JOYSTICK_COBRA=m
>> CONFIG_JOYSTICK_GF2K=m
>> # CONFIG_JOYSTICK_GRIP is not set
>> CONFIG_JOYSTICK_GRIP_MP=m
>> CONFIG_JOYSTICK_GUILLEMOT=m
>> # CONFIG_JOYSTICK_INTERACT is not set
>> CONFIG_JOYSTICK_SIDEWINDER=y
>> CONFIG_JOYSTICK_TMDC=m
>> CONFIG_JOYSTICK_IFORCE=m
>> # CONFIG_JOYSTICK_IFORCE_232 is not set
>> CONFIG_JOYSTICK_WARRIOR=y
>> # CONFIG_JOYSTICK_MAGELLAN is not set
>> # CONFIG_JOYSTICK_SPACEORB is not set
>> CONFIG_JOYSTICK_SPACEBALL=y
>> CONFIG_JOYSTICK_STINGER=m
>> CONFIG_JOYSTICK_TWIDJOY=m
>> # CONFIG_JOYSTICK_ZHENHUA is not set
>> # CONFIG_JOYSTICK_DB9 is not set
>> # CONFIG_JOYSTICK_GAMECON is not set
>> CONFIG_JOYSTICK_TURBOGRAFX=m
>> CONFIG_JOYSTICK_AS5011=y
>> CONFIG_JOYSTICK_JOYDUMP=m
>> # CONFIG_JOYSTICK_XPAD is not set
>> # CONFIG_JOYSTICK_PXRC is not set
>> CONFIG_INPUT_TABLET=y
>> # CONFIG_TABLET_USB_ACECAD is not set
>> # CONFIG_TABLET_USB_AIPTEK is not set
>> # CONFIG_TABLET_USB_HANWANG is not set
>> # CONFIG_TABLET_USB_KBTAB is not set
>> # CONFIG_TABLET_USB_PEGASUS is not set
>> CONFIG_TABLET_SERIAL_WACOM4=y
>> CONFIG_INPUT_TOUCHSCREEN=y
>> CONFIG_TOUCHSCREEN_PROPERTIES=y
>> CONFIG_TOUCHSCREEN_88PM860X=m
>> CONFIG_TOUCHSCREEN_AD7879=m
>> CONFIG_TOUCHSCREEN_AD7879_I2C=m
>> CONFIG_TOUCHSCREEN_ADC=m
>> CONFIG_TOUCHSCREEN_ATMEL_MXT=y
>> CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
>> CONFIG_TOUCHSCREEN_BU21013=y
>> # CONFIG_TOUCHSCREEN_BU21029 is not set
>> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
>> CONFIG_TOUCHSCREEN_CY8CTMG110=m
>> CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
>> CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
>> CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
>> # CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
>> CONFIG_TOUCHSCREEN_DA9034=m
>> CONFIG_TOUCHSCREEN_DYNAPRO=m
>> CONFIG_TOUCHSCREEN_HAMPSHIRE=y
>> CONFIG_TOUCHSCREEN_EETI=m
>> CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
>> CONFIG_TOUCHSCREEN_EXC3000=m
>> CONFIG_TOUCHSCREEN_FUJITSU=m
>> # CONFIG_TOUCHSCREEN_GOODIX is not set
>> CONFIG_TOUCHSCREEN_HIDEEP=m
>> CONFIG_TOUCHSCREEN_ILI210X=y
>> CONFIG_TOUCHSCREEN_S6SY761=y
>> CONFIG_TOUCHSCREEN_GUNZE=y
>> # CONFIG_TOUCHSCREEN_EKTF2127 is not set
>> CONFIG_TOUCHSCREEN_ELAN=m
>> CONFIG_TOUCHSCREEN_ELO=m
>> # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
>> CONFIG_TOUCHSCREEN_WACOM_I2C=y
>> CONFIG_TOUCHSCREEN_MAX11801=y
>> # CONFIG_TOUCHSCREEN_MCS5000 is not set
>> CONFIG_TOUCHSCREEN_MMS114=m
>> CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
>> CONFIG_TOUCHSCREEN_MTOUCH=y
>> CONFIG_TOUCHSCREEN_INEXIO=y
>> CONFIG_TOUCHSCREEN_MK712=m
>> CONFIG_TOUCHSCREEN_PENMOUNT=y
>> CONFIG_TOUCHSCREEN_EDT_FT5X06=m
>> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
>> CONFIG_TOUCHSCREEN_TOUCHWIN=m
>> CONFIG_TOUCHSCREEN_PIXCIR=m
>> # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
>> CONFIG_TOUCHSCREEN_WM831X=y
>> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
>> CONFIG_TOUCHSCREEN_MC13783=y
>> CONFIG_TOUCHSCREEN_TOUCHIT213=y
>> CONFIG_TOUCHSCREEN_TSC_SERIO=m
>> CONFIG_TOUCHSCREEN_TSC200X_CORE=m
>> CONFIG_TOUCHSCREEN_TSC2004=m
>> CONFIG_TOUCHSCREEN_TSC2007=m
>> CONFIG_TOUCHSCREEN_TSC2007_IIO=y
>> # CONFIG_TOUCHSCREEN_RM_TS is not set
>> CONFIG_TOUCHSCREEN_SILEAD=m
>> CONFIG_TOUCHSCREEN_SIS_I2C=y
>> CONFIG_TOUCHSCREEN_ST1232=m
>> CONFIG_TOUCHSCREEN_STMFTS=m
>> # CONFIG_TOUCHSCREEN_SX8654 is not set
>> # CONFIG_TOUCHSCREEN_TPS6507X is not set
>> CONFIG_TOUCHSCREEN_ZET6223=y
>> CONFIG_TOUCHSCREEN_ZFORCE=y
>> CONFIG_TOUCHSCREEN_ROHM_BU21023=m
>> CONFIG_INPUT_MISC=y
>> # CONFIG_INPUT_88PM860X_ONKEY is not set
>> CONFIG_INPUT_AD714X=m
>> # CONFIG_INPUT_AD714X_I2C is not set
>> # CONFIG_INPUT_BMA150 is not set
>> # CONFIG_INPUT_E3X0_BUTTON is not set
>> # CONFIG_INPUT_MSM_VIBRATOR is not set
>> CONFIG_INPUT_MC13783_PWRBUTTON=y
>> CONFIG_INPUT_MMA8450=m
>> CONFIG_INPUT_APANEL=m
>> CONFIG_INPUT_GP2A=y
>> CONFIG_INPUT_GPIO_BEEPER=m
>> # CONFIG_INPUT_GPIO_DECODER is not set
>> # CONFIG_INPUT_ATLAS_BTNS is not set
>> # CONFIG_INPUT_ATI_REMOTE2 is not set
>> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
>> CONFIG_INPUT_KXTJ9=m
>> # CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
>> # CONFIG_INPUT_POWERMATE is not set
>> # CONFIG_INPUT_YEALINK is not set
>> # CONFIG_INPUT_CM109 is not set
>> CONFIG_INPUT_UINPUT=y
>> CONFIG_INPUT_PALMAS_PWRBUTTON=y
>> CONFIG_INPUT_PCF50633_PMU=m
>> CONFIG_INPUT_PCF8574=m
>> CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
>> # CONFIG_INPUT_DA9055_ONKEY is not set
>> CONFIG_INPUT_DA9063_ONKEY=m
>> CONFIG_INPUT_WM831X_ON=y
>> CONFIG_INPUT_ADXL34X=m
>> CONFIG_INPUT_ADXL34X_I2C=m
>> CONFIG_INPUT_CMA3000=y
>> CONFIG_INPUT_CMA3000_I2C=y
>> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
>> CONFIG_INPUT_DRV260X_HAPTICS=m
>> # CONFIG_INPUT_DRV2665_HAPTICS is not set
>> CONFIG_INPUT_DRV2667_HAPTICS=m
>> CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
>> # CONFIG_RMI4_CORE is not set
>>
>> #
>> # Hardware I/O ports
>> #
>> CONFIG_SERIO=y
>> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
>> CONFIG_SERIO_I8042=y
>> CONFIG_SERIO_SERPORT=y
>> # CONFIG_SERIO_CT82C710 is not set
>> # CONFIG_SERIO_PARKBD is not set
>> CONFIG_SERIO_PCIPS2=m
>> CONFIG_SERIO_LIBPS2=y
>> CONFIG_SERIO_RAW=m
>> CONFIG_SERIO_ALTERA_PS2=m
>> CONFIG_SERIO_PS2MULT=y
>> # CONFIG_SERIO_ARC_PS2 is not set
>> # CONFIG_SERIO_OLPC_APSP is not set
>> # CONFIG_SERIO_GPIO_PS2 is not set
>> CONFIG_USERIO=m
>> CONFIG_GAMEPORT=y
>> CONFIG_GAMEPORT_NS558=m
>> CONFIG_GAMEPORT_L4=y
>> # CONFIG_GAMEPORT_EMU10K1 is not set
>> # CONFIG_GAMEPORT_FM801 is not set
>>
>> #
>> # Character devices
>> #
>> CONFIG_TTY=y
>> # CONFIG_VT is not set
>> CONFIG_UNIX98_PTYS=y
>> CONFIG_LEGACY_PTYS=y
>> CONFIG_LEGACY_PTY_COUNT=256
>> # CONFIG_SERIAL_NONSTANDARD is not set
>> # CONFIG_NOZOMI is not set
>> # CONFIG_N_GSM is not set
>> # CONFIG_TRACE_SINK is not set
>> CONFIG_LDISC_AUTOLOAD=y
>> # CONFIG_DEVMEM is not set
>> CONFIG_DEVKMEM=y
>>
>> #
>> # Serial drivers
>> #
>> CONFIG_SERIAL_EARLYCON=y
>> CONFIG_SERIAL_8250=y
>> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
>> CONFIG_SERIAL_8250_PNP=y
>> # CONFIG_SERIAL_8250_FINTEK is not set
>> CONFIG_SERIAL_8250_CONSOLE=y
>> CONFIG_SERIAL_8250_DMA=y
>> CONFIG_SERIAL_8250_PCI=y
>> CONFIG_SERIAL_8250_EXAR=y
>> # CONFIG_SERIAL_8250_MEN_MCB is not set
>> CONFIG_SERIAL_8250_NR_UARTS=4
>> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
>> # CONFIG_SERIAL_8250_EXTENDED is not set
>> # CONFIG_SERIAL_8250_DW is not set
>> # CONFIG_SERIAL_8250_RT288X is not set
>> CONFIG_SERIAL_8250_LPSS=y
>> CONFIG_SERIAL_8250_MID=y
>> # CONFIG_SERIAL_8250_MOXA is not set
>>
>> #
>> # Non-8250 serial port support
>> #
>> # CONFIG_SERIAL_UARTLITE is not set
>> CONFIG_SERIAL_CORE=y
>> CONFIG_SERIAL_CORE_CONSOLE=y
>> # CONFIG_SERIAL_JSM is not set
>> # CONFIG_SERIAL_SCCNXP is not set
>> # CONFIG_SERIAL_SC16IS7XX is not set
>> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
>> # CONFIG_SERIAL_ALTERA_UART is not set
>> # CONFIG_SERIAL_ARC is not set
>> # CONFIG_SERIAL_RP2 is not set
>> # CONFIG_SERIAL_FSL_LPUART is not set
>> # CONFIG_SERIAL_MEN_Z135 is not set
>> CONFIG_SERIAL_DEV_BUS=y
>> CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
>> # CONFIG_TTY_PRINTK is not set
>> CONFIG_PRINTER=m
>> CONFIG_LP_CONSOLE=y
>> # CONFIG_PPDEV is not set
>> # CONFIG_VIRTIO_CONSOLE is not set
>> CONFIG_IPMI_HANDLER=m
>> CONFIG_IPMI_PLAT_DATA=y
>> # CONFIG_IPMI_PANIC_EVENT is not set
>> # CONFIG_IPMI_DEVICE_INTERFACE is not set
>> CONFIG_IPMI_SI=m
>> # CONFIG_IPMI_SSIF is not set
>> # CONFIG_IPMI_WATCHDOG is not set
>> # CONFIG_IPMI_POWEROFF is not set
>> CONFIG_HW_RANDOM=m
>> CONFIG_HW_RANDOM_TIMERIOMEM=m
>> # CONFIG_HW_RANDOM_INTEL is not set
>> # CONFIG_HW_RANDOM_AMD is not set
>> CONFIG_HW_RANDOM_VIA=m
>> # CONFIG_HW_RANDOM_VIRTIO is not set
>> CONFIG_NVRAM=m
>> # CONFIG_R3964 is not set
>> CONFIG_APPLICOM=m
>> # CONFIG_MWAVE is not set
>> CONFIG_RAW_DRIVER=y
>> CONFIG_MAX_RAW_DEVS=256
>> # CONFIG_HPET is not set
>> CONFIG_HANGCHECK_TIMER=m
>> CONFIG_TCG_TPM=m
>> # CONFIG_HW_RANDOM_TPM is not set
>> CONFIG_TCG_TIS_CORE=m
>> CONFIG_TCG_TIS=m
>> CONFIG_TCG_TIS_I2C_ATMEL=m
>> # CONFIG_TCG_TIS_I2C_INFINEON is not set
>> CONFIG_TCG_TIS_I2C_NUVOTON=m
>> CONFIG_TCG_NSC=m
>> # CONFIG_TCG_ATMEL is not set
>> # CONFIG_TCG_INFINEON is not set
>> # CONFIG_TCG_CRB is not set
>> # CONFIG_TCG_VTPM_PROXY is not set
>> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
>> # CONFIG_TELCLOCK is not set
>> # CONFIG_DEVPORT is not set
>> CONFIG_XILLYBUS=m
>> # CONFIG_RANDOM_TRUST_CPU is not set
>>
>> #
>> # I2C support
>> #
>> CONFIG_I2C=y
>> CONFIG_ACPI_I2C_OPREGION=y
>> CONFIG_I2C_BOARDINFO=y
>> # CONFIG_I2C_COMPAT is not set
>> # CONFIG_I2C_CHARDEV is not set
>> CONFIG_I2C_MUX=m
>>
>> #
>> # Multiplexer I2C Chip support
>> #
>> CONFIG_I2C_MUX_GPIO=m
>> # CONFIG_I2C_MUX_LTC4306 is not set
>> CONFIG_I2C_MUX_PCA9541=m
>> # CONFIG_I2C_MUX_PCA954x is not set
>> # CONFIG_I2C_MUX_REG is not set
>> CONFIG_I2C_MUX_MLXCPLD=m
>> # CONFIG_I2C_HELPER_AUTO is not set
>> CONFIG_I2C_SMBUS=y
>>
>> #
>> # I2C Algorithms
>> #
>> CONFIG_I2C_ALGOBIT=y
>> CONFIG_I2C_ALGOPCF=y
>> CONFIG_I2C_ALGOPCA=y
>>
>> #
>> # I2C Hardware Bus support
>> #
>>
>> #
>> # PC SMBus host controller drivers
>> #
>> # CONFIG_I2C_ALI1535 is not set
>> CONFIG_I2C_ALI1563=y
>> CONFIG_I2C_ALI15X3=y
>> CONFIG_I2C_AMD756=y
>> CONFIG_I2C_AMD756_S4882=y
>> CONFIG_I2C_AMD8111=m
>> CONFIG_I2C_I801=y
>> # CONFIG_I2C_ISCH is not set
>> CONFIG_I2C_ISMT=m
>> CONFIG_I2C_PIIX4=m
>> # CONFIG_I2C_NFORCE2 is not set
>> # CONFIG_I2C_NVIDIA_GPU is not set
>> # CONFIG_I2C_SIS5595 is not set
>> # CONFIG_I2C_SIS630 is not set
>> # CONFIG_I2C_SIS96X is not set
>> CONFIG_I2C_VIA=m
>> # CONFIG_I2C_VIAPRO is not set
>>
>> #
>> # ACPI drivers
>> #
>> # CONFIG_I2C_SCMI is not set
>>
>> #
>> # I2C system bus drivers (mostly embedded / system-on-chip)
>> #
>> CONFIG_I2C_CBUS_GPIO=y
>> # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
>> # CONFIG_I2C_DESIGNWARE_PCI is not set
>> CONFIG_I2C_EMEV2=m
>> CONFIG_I2C_GPIO=y
>> CONFIG_I2C_GPIO_FAULT_INJECTOR=y
>> # CONFIG_I2C_KEMPLD is not set
>> CONFIG_I2C_OCORES=m
>> CONFIG_I2C_PCA_PLATFORM=m
>> # CONFIG_I2C_SIMTEC is not set
>> CONFIG_I2C_XILINX=m
>>
>> #
>> # External I2C/SMBus adapter drivers
>> #
>> CONFIG_I2C_PARPORT=y
>> CONFIG_I2C_PARPORT_LIGHT=m
>> # CONFIG_I2C_TAOS_EVM is not set
>>
>> #
>> # Other I2C/SMBus bus drivers
>> #
>> CONFIG_I2C_MLXCPLD=m
>> CONFIG_I2C_STUB=m
>> CONFIG_I2C_SLAVE=y
>> CONFIG_I2C_SLAVE_EEPROM=m
>> # CONFIG_I2C_DEBUG_CORE is not set
>> # CONFIG_I2C_DEBUG_ALGO is not set
>> # CONFIG_I2C_DEBUG_BUS is not set
>> # CONFIG_I3C is not set
>> # CONFIG_SPI is not set
>> CONFIG_SPMI=m
>> CONFIG_HSI=m
>> CONFIG_HSI_BOARDINFO=y
>>
>> #
>> # HSI controllers
>> #
>>
>> #
>> # HSI clients
>> #
>> CONFIG_HSI_CHAR=m
>> CONFIG_PPS=y
>> # CONFIG_PPS_DEBUG is not set
>>
>> #
>> # PPS clients support
>> #
>> # CONFIG_PPS_CLIENT_KTIMER is not set
>> # CONFIG_PPS_CLIENT_LDISC is not set
>> # CONFIG_PPS_CLIENT_PARPORT is not set
>> # CONFIG_PPS_CLIENT_GPIO is not set
>>
>> #
>> # PPS generators support
>> #
>>
>> #
>> # PTP clock support
>> #
>> CONFIG_PTP_1588_CLOCK=y
>> CONFIG_DP83640_PHY=m
>> CONFIG_PTP_1588_CLOCK_KVM=m
>> CONFIG_PINCTRL=y
>> CONFIG_PINMUX=y
>> CONFIG_PINCONF=y
>> CONFIG_GENERIC_PINCONF=y
>> # CONFIG_DEBUG_PINCTRL is not set
>> CONFIG_PINCTRL_AMD=y
>> CONFIG_PINCTRL_MCP23S08=y
>> CONFIG_PINCTRL_SX150X=y
>> # CONFIG_PINCTRL_BAYTRAIL is not set
>> # CONFIG_PINCTRL_CHERRYVIEW is not set
>> # CONFIG_PINCTRL_BROXTON is not set
>> # CONFIG_PINCTRL_CANNONLAKE is not set
>> # CONFIG_PINCTRL_CEDARFORK is not set
>> # CONFIG_PINCTRL_DENVERTON is not set
>> # CONFIG_PINCTRL_GEMINILAKE is not set
>> # CONFIG_PINCTRL_ICELAKE is not set
>> # CONFIG_PINCTRL_LEWISBURG is not set
>> # CONFIG_PINCTRL_SUNRISEPOINT is not set
>> CONFIG_PINCTRL_MADERA=m
>> CONFIG_PINCTRL_CS47L35=y
>> CONFIG_PINCTRL_CS47L90=y
>> CONFIG_GPIOLIB=y
>> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
>> CONFIG_GPIO_ACPI=y
>> CONFIG_GPIOLIB_IRQCHIP=y
>> CONFIG_DEBUG_GPIO=y
>> CONFIG_GPIO_SYSFS=y
>> CONFIG_GPIO_GENERIC=y
>>
>> #
>> # Memory mapped GPIO drivers
>> #
>> # CONFIG_GPIO_AMDPT is not set
>> # CONFIG_GPIO_DWAPB is not set
>> # CONFIG_GPIO_EXAR is not set
>> # CONFIG_GPIO_GENERIC_PLATFORM is not set
>> # CONFIG_GPIO_ICH is not set
>> # CONFIG_GPIO_LYNXPOINT is not set
>> # CONFIG_GPIO_MB86S7X is not set
>> CONFIG_GPIO_MENZ127=y
>> # CONFIG_GPIO_MOCKUP is not set
>> # CONFIG_GPIO_SIOX is not set
>> # CONFIG_GPIO_VX855 is not set
>> # CONFIG_GPIO_AMD_FCH is not set
>>
>> #
>> # Port-mapped I/O GPIO drivers
>> #
>> CONFIG_GPIO_F7188X=y
>> # CONFIG_GPIO_IT87 is not set
>> CONFIG_GPIO_SCH=y
>> CONFIG_GPIO_SCH311X=m
>> CONFIG_GPIO_WINBOND=m
>> # CONFIG_GPIO_WS16C48 is not set
>>
>> #
>> # I2C GPIO expanders
>> #
>> # CONFIG_GPIO_ADP5588 is not set
>> # CONFIG_GPIO_MAX7300 is not set
>> CONFIG_GPIO_MAX732X=m
>> CONFIG_GPIO_PCA953X=m
>> CONFIG_GPIO_PCF857X=y
>> # CONFIG_GPIO_TPIC2810 is not set
>>
>> #
>> # MFD GPIO expanders
>> #
>> CONFIG_GPIO_ARIZONA=y
>> # CONFIG_GPIO_DA9055 is not set
>> CONFIG_GPIO_KEMPLD=m
>> CONFIG_GPIO_LP3943=y
>> CONFIG_GPIO_LP873X=y
>> CONFIG_GPIO_MADERA=m
>> CONFIG_GPIO_PALMAS=y
>> CONFIG_GPIO_TPS65086=m
>> CONFIG_GPIO_WM831X=m
>> # CONFIG_GPIO_WM8994 is not set
>>
>> #
>> # PCI GPIO expanders
>> #
>> CONFIG_GPIO_AMD8111=y
>> CONFIG_GPIO_BT8XX=m
>> CONFIG_GPIO_ML_IOH=y
>> CONFIG_GPIO_PCI_IDIO_16=m
>> CONFIG_GPIO_PCIE_IDIO_24=y
>> CONFIG_GPIO_RDC321X=m
>> CONFIG_W1=m
>> # CONFIG_W1_CON is not set
>>
>> #
>> # 1-wire Bus Masters
>> #
>> # CONFIG_W1_MASTER_MATROX is not set
>> CONFIG_W1_MASTER_DS2482=m
>> CONFIG_W1_MASTER_DS1WM=m
>> CONFIG_W1_MASTER_GPIO=m
>>
>> #
>> # 1-wire Slaves
>> #
>> CONFIG_W1_SLAVE_THERM=m
>> # CONFIG_W1_SLAVE_SMEM is not set
>> CONFIG_W1_SLAVE_DS2405=m
>> CONFIG_W1_SLAVE_DS2408=m
>> CONFIG_W1_SLAVE_DS2408_READBACK=y
>> CONFIG_W1_SLAVE_DS2413=m
>> CONFIG_W1_SLAVE_DS2406=m
>> CONFIG_W1_SLAVE_DS2423=m
>> # CONFIG_W1_SLAVE_DS2805 is not set
>> CONFIG_W1_SLAVE_DS2431=m
>> # CONFIG_W1_SLAVE_DS2433 is not set
>> CONFIG_W1_SLAVE_DS2438=m
>> CONFIG_W1_SLAVE_DS2780=m
>> # CONFIG_W1_SLAVE_DS2781 is not set
>> CONFIG_W1_SLAVE_DS28E04=m
>> CONFIG_W1_SLAVE_DS28E17=m
>> # CONFIG_POWER_AVS is not set
>> # CONFIG_POWER_RESET is not set
>> CONFIG_POWER_SUPPLY=y
>> # CONFIG_POWER_SUPPLY_DEBUG is not set
>> # CONFIG_PDA_POWER is not set
>> # CONFIG_GENERIC_ADC_BATTERY is not set
>> CONFIG_WM831X_BACKUP=m
>> CONFIG_WM831X_POWER=y
>> # CONFIG_TEST_POWER is not set
>> CONFIG_BATTERY_88PM860X=y
>> CONFIG_CHARGER_ADP5061=m
>> # CONFIG_BATTERY_DS2760 is not set
>> CONFIG_BATTERY_DS2780=m
>> # CONFIG_BATTERY_DS2781 is not set
>> CONFIG_BATTERY_DS2782=y
>> CONFIG_BATTERY_SBS=m
>> # CONFIG_CHARGER_SBS is not set
>> CONFIG_MANAGER_SBS=m
>> # CONFIG_BATTERY_BQ27XXX is not set
>> CONFIG_BATTERY_DA9030=m
>> CONFIG_BATTERY_DA9150=m
>> # CONFIG_BATTERY_MAX17040 is not set
>> # CONFIG_BATTERY_MAX17042 is not set
>> CONFIG_BATTERY_MAX1721X=m
>> # CONFIG_CHARGER_88PM860X is not set
>> CONFIG_CHARGER_PCF50633=m
>> # CONFIG_CHARGER_MAX8903 is not set
>> CONFIG_CHARGER_LP8727=m
>> # CONFIG_CHARGER_LP8788 is not set
>> CONFIG_CHARGER_GPIO=y
>> CONFIG_CHARGER_LTC3651=y
>> # CONFIG_CHARGER_MAX77693 is not set
>> # CONFIG_CHARGER_BQ2415X is not set
>> CONFIG_CHARGER_BQ24190=m
>> CONFIG_CHARGER_BQ24257=m
>> CONFIG_CHARGER_BQ24735=y
>> # CONFIG_CHARGER_BQ25890 is not set
>> CONFIG_CHARGER_SMB347=m
>> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
>> # CONFIG_CHARGER_RT9455 is not set
>> CONFIG_HWMON=m
>> CONFIG_HWMON_VID=m
>> CONFIG_HWMON_DEBUG_CHIP=y
>>
>> #
>> # Native drivers
>> #
>> CONFIG_SENSORS_AD7414=m
>> CONFIG_SENSORS_AD7418=m
>> CONFIG_SENSORS_ADM1021=m
>> # CONFIG_SENSORS_ADM1025 is not set
>> CONFIG_SENSORS_ADM1026=m
>> CONFIG_SENSORS_ADM1029=m
>> CONFIG_SENSORS_ADM1031=m
>> # CONFIG_SENSORS_ADM9240 is not set
>> # CONFIG_SENSORS_ADT7410 is not set
>> # CONFIG_SENSORS_ADT7411 is not set
>> CONFIG_SENSORS_ADT7462=m
>> # CONFIG_SENSORS_ADT7470 is not set
>> # CONFIG_SENSORS_ADT7475 is not set
>> CONFIG_SENSORS_ASC7621=m
>> CONFIG_SENSORS_K8TEMP=m
>> # CONFIG_SENSORS_K10TEMP is not set
>> CONFIG_SENSORS_FAM15H_POWER=m
>> CONFIG_SENSORS_APPLESMC=m
>> CONFIG_SENSORS_ASB100=m
>> # CONFIG_SENSORS_ASPEED is not set
>> # CONFIG_SENSORS_ATXP1 is not set
>> CONFIG_SENSORS_DS620=m
>> CONFIG_SENSORS_DS1621=m
>> CONFIG_SENSORS_DELL_SMM=m
>> CONFIG_SENSORS_DA9055=m
>> CONFIG_SENSORS_I5K_AMB=m
>> CONFIG_SENSORS_F71805F=m
>> # CONFIG_SENSORS_F71882FG is not set
>> # CONFIG_SENSORS_F75375S is not set
>> # CONFIG_SENSORS_MC13783_ADC is not set
>> CONFIG_SENSORS_FSCHMD=m
>> CONFIG_SENSORS_GL518SM=m
>> CONFIG_SENSORS_GL520SM=m
>> CONFIG_SENSORS_G760A=m
>> # CONFIG_SENSORS_G762 is not set
>> # CONFIG_SENSORS_HIH6130 is not set
>> # CONFIG_SENSORS_IBMAEM is not set
>> CONFIG_SENSORS_IBMPEX=m
>> CONFIG_SENSORS_IIO_HWMON=m
>> # CONFIG_SENSORS_I5500 is not set
>> CONFIG_SENSORS_CORETEMP=m
>> CONFIG_SENSORS_IT87=m
>> # CONFIG_SENSORS_JC42 is not set
>> CONFIG_SENSORS_POWR1220=m
>> # CONFIG_SENSORS_LINEAGE is not set
>> CONFIG_SENSORS_LTC2945=m
>> # CONFIG_SENSORS_LTC2990 is not set
>> # CONFIG_SENSORS_LTC4151 is not set
>> CONFIG_SENSORS_LTC4215=m
>> # CONFIG_SENSORS_LTC4222 is not set
>> CONFIG_SENSORS_LTC4245=m
>> # CONFIG_SENSORS_LTC4260 is not set
>> CONFIG_SENSORS_LTC4261=m
>> CONFIG_SENSORS_MAX16065=m
>> # CONFIG_SENSORS_MAX1619 is not set
>> CONFIG_SENSORS_MAX1668=m
>> CONFIG_SENSORS_MAX197=m
>> # CONFIG_SENSORS_MAX6621 is not set
>> CONFIG_SENSORS_MAX6639=m
>> # CONFIG_SENSORS_MAX6642 is not set
>> CONFIG_SENSORS_MAX6650=m
>> # CONFIG_SENSORS_MAX6697 is not set
>> CONFIG_SENSORS_MAX31790=m
>> # CONFIG_SENSORS_MCP3021 is not set
>> # CONFIG_SENSORS_MLXREG_FAN is not set
>> CONFIG_SENSORS_TC654=m
>> CONFIG_SENSORS_MENF21BMC_HWMON=m
>> CONFIG_SENSORS_LM63=m
>> CONFIG_SENSORS_LM73=m
>> CONFIG_SENSORS_LM75=m
>> CONFIG_SENSORS_LM77=m
>> # CONFIG_SENSORS_LM78 is not set
>> CONFIG_SENSORS_LM80=m
>> CONFIG_SENSORS_LM83=m
>> CONFIG_SENSORS_LM85=m
>> CONFIG_SENSORS_LM87=m
>> CONFIG_SENSORS_LM90=m
>> CONFIG_SENSORS_LM92=m
>> CONFIG_SENSORS_LM93=m
>> # CONFIG_SENSORS_LM95234 is not set
>> CONFIG_SENSORS_LM95241=m
>> CONFIG_SENSORS_LM95245=m
>> # CONFIG_SENSORS_PC87360 is not set
>> CONFIG_SENSORS_PC87427=m
>> CONFIG_SENSORS_NTC_THERMISTOR=m
>> # CONFIG_SENSORS_NCT6683 is not set
>> # CONFIG_SENSORS_NCT6775 is not set
>> CONFIG_SENSORS_NCT7802=m
>> # CONFIG_SENSORS_NCT7904 is not set
>> CONFIG_SENSORS_NPCM7XX=m
>> # CONFIG_SENSORS_OCC_P8_I2C is not set
>> CONFIG_SENSORS_PCF8591=m
>> CONFIG_PMBUS=m
>> # CONFIG_SENSORS_PMBUS is not set
>> CONFIG_SENSORS_ADM1275=m
>> # CONFIG_SENSORS_IBM_CFFPS is not set
>> # CONFIG_SENSORS_IR35221 is not set
>> CONFIG_SENSORS_LM25066=m
>> CONFIG_SENSORS_LTC2978=m
>> # CONFIG_SENSORS_LTC3815 is not set
>> CONFIG_SENSORS_MAX16064=m
>> # CONFIG_SENSORS_MAX20751 is not set
>> # CONFIG_SENSORS_MAX31785 is not set
>> CONFIG_SENSORS_MAX34440=m
>> # CONFIG_SENSORS_MAX8688 is not set
>> CONFIG_SENSORS_TPS40422=m
>> CONFIG_SENSORS_TPS53679=m
>> CONFIG_SENSORS_UCD9000=m
>> CONFIG_SENSORS_UCD9200=m
>> CONFIG_SENSORS_ZL6100=m
>> CONFIG_SENSORS_SHT15=m
>> CONFIG_SENSORS_SHT21=m
>> # CONFIG_SENSORS_SHT3x is not set
>> # CONFIG_SENSORS_SHTC1 is not set
>> CONFIG_SENSORS_SIS5595=m
>> # CONFIG_SENSORS_DME1737 is not set
>> # CONFIG_SENSORS_EMC1403 is not set
>> # CONFIG_SENSORS_EMC2103 is not set
>> CONFIG_SENSORS_EMC6W201=m
>> # CONFIG_SENSORS_SMSC47M1 is not set
>> # CONFIG_SENSORS_SMSC47M192 is not set
>> CONFIG_SENSORS_SMSC47B397=m
>> CONFIG_SENSORS_STTS751=m
>> CONFIG_SENSORS_SMM665=m
>> CONFIG_SENSORS_ADC128D818=m
>> CONFIG_SENSORS_ADS1015=m
>> CONFIG_SENSORS_ADS7828=m
>> CONFIG_SENSORS_AMC6821=m
>> CONFIG_SENSORS_INA209=m
>> CONFIG_SENSORS_INA2XX=m
>> CONFIG_SENSORS_INA3221=m
>> # CONFIG_SENSORS_TC74 is not set
>> CONFIG_SENSORS_THMC50=m
>> CONFIG_SENSORS_TMP102=m
>> CONFIG_SENSORS_TMP103=m
>> CONFIG_SENSORS_TMP108=m
>> # CONFIG_SENSORS_TMP401 is not set
>> # CONFIG_SENSORS_TMP421 is not set
>> CONFIG_SENSORS_VIA_CPUTEMP=m
>> CONFIG_SENSORS_VIA686A=m
>> CONFIG_SENSORS_VT1211=m
>> # CONFIG_SENSORS_VT8231 is not set
>> CONFIG_SENSORS_W83773G=m
>> CONFIG_SENSORS_W83781D=m
>> # CONFIG_SENSORS_W83791D is not set
>> # CONFIG_SENSORS_W83792D is not set
>> # CONFIG_SENSORS_W83793 is not set
>> CONFIG_SENSORS_W83795=m
>> CONFIG_SENSORS_W83795_FANCTRL=y
>> CONFIG_SENSORS_W83L785TS=m
>> # CONFIG_SENSORS_W83L786NG is not set
>> CONFIG_SENSORS_W83627HF=m
>> # CONFIG_SENSORS_W83627EHF is not set
>> CONFIG_SENSORS_WM831X=m
>>
>> #
>> # ACPI drivers
>> #
>> # CONFIG_SENSORS_ACPI_POWER is not set
>> # CONFIG_SENSORS_ATK0110 is not set
>> CONFIG_THERMAL=y
>> # CONFIG_THERMAL_STATISTICS is not set
>> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
>> # CONFIG_THERMAL_WRITABLE_TRIPS is not set
>> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
>> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
>> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
>> # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
>> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
>> CONFIG_THERMAL_GOV_STEP_WISE=y
>> # CONFIG_THERMAL_GOV_BANG_BANG is not set
>> # CONFIG_THERMAL_GOV_USER_SPACE is not set
>> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
>> # CONFIG_CLOCK_THERMAL is not set
>> # CONFIG_DEVFREQ_THERMAL is not set
>> # CONFIG_THERMAL_EMULATION is not set
>>
>> #
>> # Intel thermal drivers
>> #
>> # CONFIG_INTEL_POWERCLAMP is not set
>> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
>>
>> #
>> # ACPI INT340X thermal drivers
>> #
>> # CONFIG_INT340X_THERMAL is not set
>> # CONFIG_INTEL_PCH_THERMAL is not set
>> # CONFIG_GENERIC_ADC_THERMAL is not set
>> # CONFIG_WATCHDOG is not set
>> CONFIG_SSB_POSSIBLE=y
>> CONFIG_SSB=m
>> CONFIG_SSB_PCIHOST_POSSIBLE=y
>> # CONFIG_SSB_PCIHOST is not set
>> CONFIG_SSB_SDIOHOST_POSSIBLE=y
>> CONFIG_SSB_SDIOHOST=y
>> CONFIG_SSB_DRIVER_GPIO=y
>> CONFIG_BCMA_POSSIBLE=y
>> # CONFIG_BCMA is not set
>>
>> #
>> # Multifunction device drivers
>> #
>> CONFIG_MFD_CORE=y
>> # CONFIG_MFD_AS3711 is not set
>> # CONFIG_PMIC_ADP5520 is not set
>> # CONFIG_MFD_AAT2870_CORE is not set
>> CONFIG_MFD_BCM590XX=y
>> # CONFIG_MFD_BD9571MWV is not set
>> # CONFIG_MFD_AXP20X_I2C is not set
>> # CONFIG_MFD_CROS_EC is not set
>> CONFIG_MFD_MADERA=m
>> CONFIG_MFD_MADERA_I2C=m
>> CONFIG_MFD_CS47L35=y
>> # CONFIG_MFD_CS47L85 is not set
>> CONFIG_MFD_CS47L90=y
>> CONFIG_PMIC_DA903X=y
>> # CONFIG_MFD_DA9052_I2C is not set
>> CONFIG_MFD_DA9055=y
>> CONFIG_MFD_DA9062=m
>> CONFIG_MFD_DA9063=m
>> CONFIG_MFD_DA9150=y
>> CONFIG_MFD_MC13XXX=y
>> CONFIG_MFD_MC13XXX_I2C=y
>> # CONFIG_HTC_PASIC3 is not set
>> # CONFIG_HTC_I2CPLD is not set
>> CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
>> # CONFIG_LPC_ICH is not set
>> CONFIG_LPC_SCH=y
>> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
>> CONFIG_MFD_INTEL_LPSS=m
>> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
>> CONFIG_MFD_INTEL_LPSS_PCI=m
>> # CONFIG_MFD_JANZ_CMODIO is not set
>> CONFIG_MFD_KEMPLD=y
>> # CONFIG_MFD_88PM800 is not set
>> # CONFIG_MFD_88PM805 is not set
>> CONFIG_MFD_88PM860X=y
>> # CONFIG_MFD_MAX14577 is not set
>> CONFIG_MFD_MAX77693=y
>> # CONFIG_MFD_MAX77843 is not set
>> CONFIG_MFD_MAX8907=m
>> # CONFIG_MFD_MAX8925 is not set
>> # CONFIG_MFD_MAX8997 is not set
>> CONFIG_MFD_MAX8998=y
>> CONFIG_MFD_MT6397=y
>> CONFIG_MFD_MENF21BMC=m
>> # CONFIG_MFD_RETU is not set
>> CONFIG_MFD_PCF50633=m
>> CONFIG_PCF50633_ADC=m
>> # CONFIG_PCF50633_GPIO is not set
>> CONFIG_MFD_RDC321X=y
>> # CONFIG_MFD_RT5033 is not set
>> # CONFIG_MFD_RC5T583 is not set
>> # CONFIG_MFD_SEC_CORE is not set
>> # CONFIG_MFD_SI476X_CORE is not set
>> # CONFIG_MFD_SM501 is not set
>> # CONFIG_MFD_SKY81452 is not set
>> # CONFIG_MFD_SMSC is not set
>> CONFIG_ABX500_CORE=y
>> CONFIG_AB3100_CORE=y
>> CONFIG_AB3100_OTP=m
>> CONFIG_MFD_SYSCON=y
>> # CONFIG_MFD_TI_AM335X_TSCADC is not set
>> CONFIG_MFD_LP3943=y
>> CONFIG_MFD_LP8788=y
>> # CONFIG_MFD_TI_LMU is not set
>> CONFIG_MFD_PALMAS=y
>> # CONFIG_TPS6105X is not set
>> # CONFIG_TPS65010 is not set
>> # CONFIG_TPS6507X is not set
>> CONFIG_MFD_TPS65086=m
>> # CONFIG_MFD_TPS65090 is not set
>> CONFIG_MFD_TI_LP873X=y
>> # CONFIG_MFD_TPS6586X is not set
>> # CONFIG_MFD_TPS65910 is not set
>> # CONFIG_MFD_TPS65912_I2C is not set
>> # CONFIG_MFD_TPS80031 is not set
>> # CONFIG_TWL4030_CORE is not set
>> # CONFIG_TWL6040_CORE is not set
>> # CONFIG_MFD_WL1273_CORE is not set
>> # CONFIG_MFD_LM3533 is not set
>> # CONFIG_MFD_TQMX86 is not set
>> CONFIG_MFD_VX855=m
>> CONFIG_MFD_ARIZONA=y
>> CONFIG_MFD_ARIZONA_I2C=m
>> CONFIG_MFD_CS47L24=y
>> CONFIG_MFD_WM5102=y
>> # CONFIG_MFD_WM5110 is not set
>> CONFIG_MFD_WM8997=y
>> CONFIG_MFD_WM8998=y
>> # CONFIG_MFD_WM8400 is not set
>> CONFIG_MFD_WM831X=y
>> CONFIG_MFD_WM831X_I2C=y
>> # CONFIG_MFD_WM8350_I2C is not set
>> CONFIG_MFD_WM8994=m
>> CONFIG_RAVE_SP_CORE=m
>> # CONFIG_REGULATOR is not set
>> CONFIG_RC_CORE=m
>> CONFIG_RC_MAP=m
>> CONFIG_LIRC=y
>> CONFIG_RC_DECODERS=y
>> CONFIG_IR_NEC_DECODER=m
>> CONFIG_IR_RC5_DECODER=m
>> CONFIG_IR_RC6_DECODER=m
>> CONFIG_IR_JVC_DECODER=m
>> # CONFIG_IR_SONY_DECODER is not set
>> CONFIG_IR_SANYO_DECODER=m
>> CONFIG_IR_SHARP_DECODER=m
>> # CONFIG_IR_MCE_KBD_DECODER is not set
>> CONFIG_IR_XMP_DECODER=m
>> # CONFIG_IR_IMON_DECODER is not set
>> # CONFIG_IR_RCMM_DECODER is not set
>> # CONFIG_RC_DEVICES is not set
>> CONFIG_MEDIA_SUPPORT=m
>>
>> #
>> # Multimedia core support
>> #
>> CONFIG_MEDIA_CAMERA_SUPPORT=y
>> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
>> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
>> CONFIG_MEDIA_RADIO_SUPPORT=y
>> # CONFIG_MEDIA_SDR_SUPPORT is not set
>> CONFIG_MEDIA_CEC_SUPPORT=y
>> # CONFIG_MEDIA_CONTROLLER is not set
>> CONFIG_VIDEO_DEV=m
>> CONFIG_VIDEO_V4L2=m
>> # CONFIG_VIDEO_ADV_DEBUG is not set
>> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
>> CONFIG_VIDEO_TUNER=m
>> CONFIG_V4L2_MEM2MEM_DEV=m
>> CONFIG_V4L2_FWNODE=m
>> CONFIG_VIDEOBUF_GEN=m
>> CONFIG_VIDEOBUF_DMA_SG=m
>> CONFIG_DVB_CORE=m
>> CONFIG_DVB_MMAP=y
>> CONFIG_DVB_NET=y
>> CONFIG_DVB_MAX_ADAPTERS=16
>> # CONFIG_DVB_DYNAMIC_MINORS is not set
>> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
>> CONFIG_DVB_ULE_DEBUG=y
>>
>> #
>> # Media drivers
>> #
>> CONFIG_MEDIA_PCI_SUPPORT=y
>>
>> #
>> # Media capture support
>> #
>> CONFIG_VIDEO_TW5864=m
>> # CONFIG_VIDEO_TW68 is not set
>>
>> #
>> # Media capture/analog/hybrid TV support
>> #
>> # CONFIG_VIDEO_CX18 is not set
>> CONFIG_VIDEO_CX25821=m
>> CONFIG_VIDEO_CX88=m
>> CONFIG_VIDEO_CX88_BLACKBIRD=m
>> CONFIG_VIDEO_CX88_DVB=m
>> CONFIG_VIDEO_CX88_ENABLE_VP3054=y
>> CONFIG_VIDEO_CX88_VP3054=m
>> CONFIG_VIDEO_CX88_MPEG=m
>> # CONFIG_VIDEO_BT848 is not set
>> CONFIG_VIDEO_SAA7134=m
>> CONFIG_VIDEO_SAA7134_RC=y
>> CONFIG_VIDEO_SAA7134_DVB=m
>> CONFIG_VIDEO_SAA7164=m
>>
>> #
>> # Media digital TV PCI Adapters
>> #
>> # CONFIG_DVB_AV7110 is not set
>> # CONFIG_DVB_BUDGET_CORE is not set
>> # CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
>> # CONFIG_DVB_PLUTO2 is not set
>> # CONFIG_DVB_DM1105 is not set
>> # CONFIG_DVB_PT1 is not set
>> CONFIG_DVB_PT3=m
>> CONFIG_MANTIS_CORE=m
>> # CONFIG_DVB_MANTIS is not set
>> CONFIG_DVB_HOPPER=m
>> # CONFIG_DVB_NGENE is not set
>> CONFIG_DVB_DDBRIDGE=m
>> CONFIG_DVB_SMIPCIE=m
>> CONFIG_V4L_PLATFORM_DRIVERS=y
>> CONFIG_VIDEO_CAFE_CCIC=m
>> CONFIG_VIDEO_VIA_CAMERA=m
>> CONFIG_VIDEO_CADENCE=y
>> # CONFIG_VIDEO_ASPEED is not set
>> CONFIG_V4L_MEM2MEM_DRIVERS=y
>> CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
>> CONFIG_VIDEO_SH_VEU=m
>> CONFIG_V4L_TEST_DRIVERS=y
>> # CONFIG_VIDEO_VIVID is not set
>> CONFIG_VIDEO_VIM2M=m
>> # CONFIG_VIDEO_VICODEC is not set
>> CONFIG_DVB_PLATFORM_DRIVERS=y
>> CONFIG_CEC_PLATFORM_DRIVERS=y
>>
>> #
>> # Supported MMC/SDIO adapters
>> #
>> CONFIG_SMS_SDIO_DRV=m
>> # CONFIG_RADIO_ADAPTERS is not set
>>
>> #
>> # Supported FireWire (IEEE 1394) Adapters
>> #
>> CONFIG_DVB_FIREDTV=m
>> CONFIG_DVB_FIREDTV_INPUT=y
>> CONFIG_MEDIA_COMMON_OPTIONS=y
>>
>> #
>> # common driver options
>> #
>> CONFIG_VIDEO_CX2341X=m
>> CONFIG_VIDEO_TVEEPROM=m
>> CONFIG_VIDEOBUF2_CORE=m
>> CONFIG_VIDEOBUF2_V4L2=m
>> CONFIG_VIDEOBUF2_MEMOPS=m
>> CONFIG_VIDEOBUF2_DMA_CONTIG=m
>> CONFIG_VIDEOBUF2_VMALLOC=m
>> CONFIG_VIDEOBUF2_DMA_SG=m
>> CONFIG_VIDEOBUF2_DVB=m
>> CONFIG_SMS_SIANO_MDTV=m
>> # CONFIG_SMS_SIANO_RC is not set
>>
>> #
>> # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
>> #
>> CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
>> CONFIG_MEDIA_ATTACH=y
>> CONFIG_VIDEO_IR_I2C=m
>>
>> #
>> # Audio decoders, processors and mixers
>> #
>> CONFIG_VIDEO_WM8775=m
>>
>> #
>> # RDS decoders
>> #
>> CONFIG_VIDEO_SAA6588=m
>>
>> #
>> # Video decoders
>> #
>>
>> #
>> # Video and audio decoders
>> #
>>
>> #
>> # Video encoders
>> #
>>
>> #
>> # Camera sensor devices
>> #
>> CONFIG_VIDEO_OV7670=m
>>
>> #
>> # Flash devices
>> #
>>
>> #
>> # Video improvement chips
>> #
>>
>> #
>> # Audio/Video compression chips
>> #
>> CONFIG_VIDEO_SAA6752HS=m
>>
>> #
>> # SDR tuner chips
>> #
>>
>> #
>> # Miscellaneous helper chips
>> #
>> CONFIG_MEDIA_TUNER=m
>> CONFIG_MEDIA_TUNER_SIMPLE=m
>> CONFIG_MEDIA_TUNER_TDA8290=m
>> CONFIG_MEDIA_TUNER_TDA827X=m
>> CONFIG_MEDIA_TUNER_TDA18271=m
>> CONFIG_MEDIA_TUNER_TDA9887=m
>> CONFIG_MEDIA_TUNER_TEA5761=m
>> CONFIG_MEDIA_TUNER_TEA5767=m
>> CONFIG_MEDIA_TUNER_MT20XX=m
>> CONFIG_MEDIA_TUNER_XC2028=m
>> CONFIG_MEDIA_TUNER_XC5000=m
>> CONFIG_MEDIA_TUNER_XC4000=m
>> CONFIG_MEDIA_TUNER_MC44S803=m
>> CONFIG_MEDIA_TUNER_TDA18212=m
>> CONFIG_MEDIA_TUNER_M88RS6000T=m
>> CONFIG_MEDIA_TUNER_SI2157=m
>> CONFIG_MEDIA_TUNER_MXL301RF=m
>> CONFIG_MEDIA_TUNER_QM1D1C0042=m
>>
>> #
>> # Multistandard (satellite) frontends
>> #
>> CONFIG_DVB_STB6100=m
>> CONFIG_DVB_STV090x=m
>> CONFIG_DVB_STV0910=m
>> CONFIG_DVB_STV6110x=m
>> CONFIG_DVB_STV6111=m
>> CONFIG_DVB_MXL5XX=m
>> CONFIG_DVB_M88DS3103=m
>>
>> #
>> # Multistandard (cable + terrestrial) frontends
>> #
>> CONFIG_DVB_DRXK=m
>> CONFIG_DVB_TDA18271C2DD=m
>>
>> #
>> # DVB-S (satellite) frontends
>> #
>> CONFIG_DVB_CX24123=m
>> CONFIG_DVB_MT312=m
>> CONFIG_DVB_ZL10036=m
>> CONFIG_DVB_ZL10039=m
>> CONFIG_DVB_STV0288=m
>> CONFIG_DVB_STB6000=m
>> CONFIG_DVB_STV0299=m
>> CONFIG_DVB_STV0900=m
>> CONFIG_DVB_TDA10086=m
>> CONFIG_DVB_TDA826X=m
>> CONFIG_DVB_CX24116=m
>> CONFIG_DVB_TS2020=m
>> CONFIG_DVB_DS3000=m
>>
>> #
>> # DVB-T (terrestrial) frontends
>> #
>> CONFIG_DVB_CX22702=m
>> CONFIG_DVB_TDA1004X=m
>> CONFIG_DVB_MT352=m
>> CONFIG_DVB_ZL10353=m
>> CONFIG_DVB_TDA10048=m
>> CONFIG_DVB_STV0367=m
>> CONFIG_DVB_CXD2841ER=m
>> CONFIG_DVB_SI2168=m
>>
>> #
>> # DVB-C (cable) frontends
>> #
>>
>> #
>> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
>> #
>> CONFIG_DVB_NXT200X=m
>> CONFIG_DVB_OR51132=m
>> CONFIG_DVB_LGDT330X=m
>> CONFIG_DVB_LGDT3305=m
>> CONFIG_DVB_S5H1411=m
>>
>> #
>> # ISDB-T (terrestrial) frontends
>> #
>>
>> #
>> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
>> #
>> CONFIG_DVB_TC90522=m
>>
>> #
>> # Digital terrestrial only tuners/PLL
>> #
>> CONFIG_DVB_PLL=m
>>
>> #
>> # SEC control devices for DVB-S
>> #
>> CONFIG_DVB_LNBH25=m
>> CONFIG_DVB_LNBP21=m
>> CONFIG_DVB_ISL6405=m
>> CONFIG_DVB_ISL6421=m
>>
>> #
>> # Common Interface (EN50221) controller drivers
>> #
>> CONFIG_DVB_CXD2099=m
>>
>> #
>> # Tools to develop new frontends
>> #
>> CONFIG_DVB_DUMMY_FE=m
>>
>> #
>> # Graphics support
>> #
>> # CONFIG_AGP is not set
>> CONFIG_INTEL_GTT=m
>> # CONFIG_VGA_ARB is not set
>> # CONFIG_VGA_SWITCHEROO is not set
>> CONFIG_DRM=m
>> CONFIG_DRM_MIPI_DSI=y
>> # CONFIG_DRM_DP_AUX_CHARDEV is not set
>> # CONFIG_DRM_DEBUG_SELFTEST is not set
>> CONFIG_DRM_KMS_HELPER=m
>> # CONFIG_DRM_FBDEV_EMULATION is not set
>> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
>> # CONFIG_DRM_DP_CEC is not set
>> CONFIG_DRM_TTM=m
>> CONFIG_DRM_GEM_CMA_HELPER=y
>> CONFIG_DRM_KMS_CMA_HELPER=y
>> CONFIG_DRM_VM=y
>>
>> #
>> # I2C encoder or helper chips
>> #
>> CONFIG_DRM_I2C_CH7006=m
>> CONFIG_DRM_I2C_SIL164=m
>> # CONFIG_DRM_I2C_NXP_TDA998X is not set
>> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
>>
>> #
>> # ARM devices
>> #
>> # CONFIG_DRM_RADEON is not set
>> # CONFIG_DRM_AMDGPU is not set
>>
>> #
>> # ACP (Audio CoProcessor) Configuration
>> #
>>
>> #
>> # AMD Library routines
>> #
>> # CONFIG_DRM_NOUVEAU is not set
>> CONFIG_DRM_I915=m
>> CONFIG_DRM_I915_ALPHA_SUPPORT=y
>> # CONFIG_DRM_I915_CAPTURE_ERROR is not set
>> CONFIG_DRM_I915_USERPTR=y
>> # CONFIG_DRM_I915_GVT is not set
>>
>> #
>> # drm/i915 Debugging
>> #
>> # CONFIG_DRM_I915_WERROR is not set
>> # CONFIG_DRM_I915_DEBUG is not set
>> CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
>> CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
>> CONFIG_DRM_I915_DEBUG_GUC=y
>> # CONFIG_DRM_I915_SELFTEST is not set
>> # CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
>> CONFIG_DRM_I915_DEBUG_VBLANK_EVADE=y
>> # CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
>> CONFIG_DRM_VGEM=m
>> CONFIG_DRM_VKMS=m
>> # CONFIG_DRM_VMWGFX is not set
>> # CONFIG_DRM_GMA500 is not set
>> # CONFIG_DRM_UDL is not set
>> CONFIG_DRM_AST=m
>> CONFIG_DRM_MGAG200=m
>> # CONFIG_DRM_CIRRUS_QEMU is not set
>> CONFIG_DRM_QXL=m
>> CONFIG_DRM_BOCHS=m
>> # CONFIG_DRM_VIRTIO_GPU is not set
>> CONFIG_DRM_PANEL=y
>>
>> #
>> # Display Panels
>> #
>> CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
>> CONFIG_DRM_BRIDGE=y
>> CONFIG_DRM_PANEL_BRIDGE=y
>>
>> #
>> # Display Interface Bridges
>> #
>> CONFIG_DRM_ANALOGIX_ANX78XX=m
>> # CONFIG_DRM_ETNAVIV is not set
>> # CONFIG_DRM_HISI_HIBMC is not set
>> CONFIG_DRM_TINYDRM=m
>> CONFIG_DRM_LEGACY=y
>> CONFIG_DRM_TDFX=m
>> # CONFIG_DRM_R128 is not set
>> CONFIG_DRM_MGA=m
>> CONFIG_DRM_VIA=m
>> CONFIG_DRM_SAVAGE=m
>> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
>>
>> #
>> # Frame buffer Devices
>> #
>> CONFIG_FB_CMDLINE=y
>> CONFIG_FB_NOTIFY=y
>> CONFIG_FB=m
>> # CONFIG_FIRMWARE_EDID is not set
>> CONFIG_FB_DDC=m
>> CONFIG_FB_CFB_FILLRECT=m
>> CONFIG_FB_CFB_COPYAREA=m
>> CONFIG_FB_CFB_IMAGEBLIT=m
>> CONFIG_FB_SYS_FILLRECT=m
>> CONFIG_FB_SYS_COPYAREA=m
>> CONFIG_FB_SYS_IMAGEBLIT=m
>> CONFIG_FB_FOREIGN_ENDIAN=y
>> # CONFIG_FB_BOTH_ENDIAN is not set
>> # CONFIG_FB_BIG_ENDIAN is not set
>> CONFIG_FB_LITTLE_ENDIAN=y
>> CONFIG_FB_SYS_FOPS=m
>> CONFIG_FB_DEFERRED_IO=y
>> CONFIG_FB_HECUBA=m
>> CONFIG_FB_SVGALIB=m
>> CONFIG_FB_BACKLIGHT=m
>> CONFIG_FB_MODE_HELPERS=y
>> CONFIG_FB_TILEBLITTING=y
>>
>> #
>> # Frame buffer hardware drivers
>> #
>> # CONFIG_FB_CIRRUS is not set
>> # CONFIG_FB_PM2 is not set
>> # CONFIG_FB_CYBER2000 is not set
>> # CONFIG_FB_ARC is not set
>> # CONFIG_FB_VGA16 is not set
>> CONFIG_FB_UVESA=m
>> CONFIG_FB_N411=m
>> # CONFIG_FB_HGA is not set
>> CONFIG_FB_OPENCORES=m
>> CONFIG_FB_S1D13XXX=m
>> CONFIG_FB_NVIDIA=m
>> CONFIG_FB_NVIDIA_I2C=y
>> CONFIG_FB_NVIDIA_DEBUG=y
>> CONFIG_FB_NVIDIA_BACKLIGHT=y
>> # CONFIG_FB_RIVA is not set
>> # CONFIG_FB_I740 is not set
>> CONFIG_FB_LE80578=m
>> # CONFIG_FB_CARILLO_RANCH is not set
>> CONFIG_FB_MATROX=m
>> # CONFIG_FB_MATROX_MILLENIUM is not set
>> # CONFIG_FB_MATROX_MYSTIQUE is not set
>> CONFIG_FB_MATROX_G=y
>> CONFIG_FB_MATROX_I2C=m
>> # CONFIG_FB_MATROX_MAVEN is not set
>> CONFIG_FB_RADEON=m
>> CONFIG_FB_RADEON_I2C=y
>> CONFIG_FB_RADEON_BACKLIGHT=y
>> # CONFIG_FB_RADEON_DEBUG is not set
>> CONFIG_FB_ATY128=m
>> # CONFIG_FB_ATY128_BACKLIGHT is not set
>> # CONFIG_FB_ATY is not set
>> CONFIG_FB_S3=m
>> # CONFIG_FB_S3_DDC is not set
>> # CONFIG_FB_SAVAGE is not set
>> CONFIG_FB_SIS=m
>> # CONFIG_FB_SIS_300 is not set
>> CONFIG_FB_SIS_315=y
>> CONFIG_FB_VIA=m
>> # CONFIG_FB_VIA_DIRECT_PROCFS is not set
>> CONFIG_FB_VIA_X_COMPATIBILITY=y
>> CONFIG_FB_NEOMAGIC=m
>> CONFIG_FB_KYRO=m
>> CONFIG_FB_3DFX=m
>> CONFIG_FB_3DFX_ACCEL=y
>> CONFIG_FB_3DFX_I2C=y
>> CONFIG_FB_VOODOO1=m
>> CONFIG_FB_VT8623=m
>> # CONFIG_FB_TRIDENT is not set
>> # CONFIG_FB_ARK is not set
>> # CONFIG_FB_PM3 is not set
>> CONFIG_FB_CARMINE=m
>> CONFIG_FB_CARMINE_DRAM_EVAL=y
>> # CONFIG_CARMINE_DRAM_CUSTOM is not set
>> CONFIG_FB_IBM_GXT4500=m
>> # CONFIG_FB_VIRTUAL is not set
>> CONFIG_FB_METRONOME=m
>> CONFIG_FB_MB862XX=m
>> CONFIG_FB_MB862XX_PCI_GDC=y
>> # CONFIG_FB_MB862XX_I2C is not set
>> CONFIG_FB_SM712=m
>> CONFIG_BACKLIGHT_LCD_SUPPORT=y
>> CONFIG_LCD_CLASS_DEVICE=m
>> CONFIG_LCD_PLATFORM=m
>> CONFIG_BACKLIGHT_CLASS_DEVICE=y
>> # CONFIG_BACKLIGHT_GENERIC is not set
>> CONFIG_BACKLIGHT_CARILLO_RANCH=m
>> # CONFIG_BACKLIGHT_DA903X is not set
>> # CONFIG_BACKLIGHT_APPLE is not set
>> # CONFIG_BACKLIGHT_PM8941_WLED is not set
>> CONFIG_BACKLIGHT_SAHARA=m
>> # CONFIG_BACKLIGHT_WM831X is not set
>> CONFIG_BACKLIGHT_ADP8860=m
>> CONFIG_BACKLIGHT_ADP8870=y
>> CONFIG_BACKLIGHT_88PM860X=m
>> CONFIG_BACKLIGHT_PCF50633=m
>> CONFIG_BACKLIGHT_LM3639=y
>> CONFIG_BACKLIGHT_GPIO=m
>> CONFIG_BACKLIGHT_LV5207LP=y
>> # CONFIG_BACKLIGHT_BD6107 is not set
>> CONFIG_BACKLIGHT_ARCXCNN=y
>> # CONFIG_BACKLIGHT_RAVE_SP is not set
>> CONFIG_VGASTATE=m
>> CONFIG_HDMI=y
>> CONFIG_LOGO=y
>> CONFIG_LOGO_LINUX_MONO=y
>> # CONFIG_LOGO_LINUX_VGA16 is not set
>> CONFIG_LOGO_LINUX_CLUT224=y
>> # CONFIG_SOUND is not set
>>
>> #
>> # HID support
>> #
>> CONFIG_HID=m
>> CONFIG_HID_BATTERY_STRENGTH=y
>> # CONFIG_HIDRAW is not set
>> # CONFIG_UHID is not set
>> # CONFIG_HID_GENERIC is not set
>>
>> #
>> # Special HID drivers
>> #
>> # CONFIG_HID_A4TECH is not set
>> CONFIG_HID_ACRUX=m
>> CONFIG_HID_ACRUX_FF=y
>> CONFIG_HID_APPLE=m
>> CONFIG_HID_ASUS=m
>> # CONFIG_HID_AUREAL is not set
>> CONFIG_HID_BELKIN=m
>> CONFIG_HID_CHERRY=m
>> CONFIG_HID_CHICONY=m
>> CONFIG_HID_COUGAR=m
>> CONFIG_HID_CMEDIA=m
>> CONFIG_HID_CYPRESS=m
>> CONFIG_HID_DRAGONRISE=m
>> CONFIG_DRAGONRISE_FF=y
>> CONFIG_HID_EMS_FF=m
>> CONFIG_HID_ELECOM=m
>> # CONFIG_HID_EZKEY is not set
>> CONFIG_HID_GEMBIRD=m
>> # CONFIG_HID_GFRM is not set
>> CONFIG_HID_KEYTOUCH=m
>> CONFIG_HID_KYE=m
>> CONFIG_HID_WALTOP=m
>> # CONFIG_HID_VIEWSONIC is not set
>> CONFIG_HID_GYRATION=m
>> CONFIG_HID_ICADE=m
>> CONFIG_HID_ITE=m
>> # CONFIG_HID_JABRA is not set
>> CONFIG_HID_TWINHAN=m
>> CONFIG_HID_KENSINGTON=m
>> CONFIG_HID_LCPOWER=m
>> CONFIG_HID_LED=m
>> # CONFIG_HID_LENOVO is not set
>> CONFIG_HID_LOGITECH=m
>> # CONFIG_HID_LOGITECH_HIDPP is not set
>> CONFIG_LOGITECH_FF=y
>> CONFIG_LOGIRUMBLEPAD2_FF=y
>> # CONFIG_LOGIG940_FF is not set
>> CONFIG_LOGIWHEELS_FF=y
>> # CONFIG_HID_MAGICMOUSE is not set
>> # CONFIG_HID_MALTRON is not set
>> # CONFIG_HID_MAYFLASH is not set
>> # CONFIG_HID_REDRAGON is not set
>> # CONFIG_HID_MICROSOFT is not set
>> CONFIG_HID_MONTEREY=m
>> CONFIG_HID_MULTITOUCH=m
>> # CONFIG_HID_NTI is not set
>> # CONFIG_HID_ORTEK is not set
>> CONFIG_HID_PANTHERLORD=m
>> CONFIG_PANTHERLORD_FF=y
>> # CONFIG_HID_PETALYNX is not set
>> CONFIG_HID_PICOLCD=m
>> # CONFIG_HID_PICOLCD_FB is not set
>> CONFIG_HID_PICOLCD_BACKLIGHT=y
>> CONFIG_HID_PICOLCD_LCD=y
>> CONFIG_HID_PICOLCD_LEDS=y
>> CONFIG_HID_PICOLCD_CIR=y
>> CONFIG_HID_PLANTRONICS=m
>> CONFIG_HID_PRIMAX=m
>> # CONFIG_HID_SAITEK is not set
>> CONFIG_HID_SAMSUNG=m
>> CONFIG_HID_SPEEDLINK=m
>> CONFIG_HID_STEAM=m
>> # CONFIG_HID_STEELSERIES is not set
>> CONFIG_HID_SUNPLUS=m
>> # CONFIG_HID_RMI is not set
>> CONFIG_HID_GREENASIA=m
>> # CONFIG_GREENASIA_FF is not set
>> CONFIG_HID_SMARTJOYPLUS=m
>> CONFIG_SMARTJOYPLUS_FF=y
>> # CONFIG_HID_TIVO is not set
>> CONFIG_HID_TOPSEED=m
>> # CONFIG_HID_THINGM is not set
>> CONFIG_HID_THRUSTMASTER=m
>> CONFIG_THRUSTMASTER_FF=y
>> # CONFIG_HID_UDRAW_PS3 is not set
>> CONFIG_HID_WIIMOTE=m
>> CONFIG_HID_XINMO=m
>> CONFIG_HID_ZEROPLUS=m
>> CONFIG_ZEROPLUS_FF=y
>> CONFIG_HID_ZYDACRON=m
>> CONFIG_HID_SENSOR_HUB=m
>> CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
>> CONFIG_HID_ALPS=m
>>
>> #
>> # I2C HID support
>> #
>> CONFIG_I2C_HID=m
>>
>> #
>> # Intel ISH HID support
>> #
>> # CONFIG_INTEL_ISH_HID is not set
>> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
>> CONFIG_USB_SUPPORT=y
>> CONFIG_USB_ARCH_HAS_HCD=y
>> # CONFIG_USB is not set
>> CONFIG_USB_PCI=y
>>
>> #
>> # USB port drivers
>> #
>>
>> #
>> # USB Physical Layer drivers
>> #
>> # CONFIG_NOP_USB_XCEIV is not set
>> # CONFIG_USB_GPIO_VBUS is not set
>> # CONFIG_USB_GADGET is not set
>> # CONFIG_TYPEC is not set
>> # CONFIG_USB_ROLE_SWITCH is not set
>> # CONFIG_USB_LED_TRIG is not set
>> # CONFIG_USB_ULPI_BUS is not set
>> CONFIG_UWB=y
>> CONFIG_UWB_WHCI=m
>> CONFIG_MMC=y
>> # CONFIG_MMC_BLOCK is not set
>> # CONFIG_SDIO_UART is not set
>> # CONFIG_MMC_TEST is not set
>>
>> #
>> # MMC/SD/SDIO Host Controller Drivers
>> #
>> CONFIG_MMC_DEBUG=y
>> CONFIG_MMC_SDHCI=m
>> CONFIG_MMC_SDHCI_PCI=m
>> CONFIG_MMC_RICOH_MMC=y
>> # CONFIG_MMC_SDHCI_ACPI is not set
>> # CONFIG_MMC_SDHCI_PLTFM is not set
>> CONFIG_MMC_TIFM_SD=y
>> # CONFIG_MMC_CB710 is not set
>> CONFIG_MMC_VIA_SDMMC=m
>> CONFIG_MMC_USDHI6ROL0=y
>> CONFIG_MMC_REALTEK_PCI=m
>> CONFIG_MMC_CQHCI=m
>> CONFIG_MMC_TOSHIBA_PCI=y
>> CONFIG_MMC_MTK=y
>> CONFIG_MEMSTICK=y
>> # CONFIG_MEMSTICK_DEBUG is not set
>>
>> #
>> # MemoryStick drivers
>> #
>> CONFIG_MEMSTICK_UNSAFE_RESUME=y
>> CONFIG_MSPRO_BLOCK=y
>> CONFIG_MS_BLOCK=y
>>
>> #
>> # MemoryStick Host Controller Drivers
>> #
>> CONFIG_MEMSTICK_TIFM_MS=m
>> CONFIG_MEMSTICK_JMICRON_38X=y
>> CONFIG_MEMSTICK_R592=m
>> CONFIG_MEMSTICK_REALTEK_PCI=m
>> CONFIG_NEW_LEDS=y
>> CONFIG_LEDS_CLASS=y
>> # CONFIG_LEDS_CLASS_FLASH is not set
>> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
>>
>> #
>> # LED drivers
>> #
>> # CONFIG_LEDS_88PM860X is not set
>> CONFIG_LEDS_LM3530=m
>> # CONFIG_LEDS_LM3642 is not set
>> CONFIG_LEDS_MT6323=y
>> CONFIG_LEDS_PCA9532=m
>> # CONFIG_LEDS_PCA9532_GPIO is not set
>> # CONFIG_LEDS_GPIO is not set
>> CONFIG_LEDS_LP3944=m
>> CONFIG_LEDS_LP3952=m
>> CONFIG_LEDS_LP55XX_COMMON=y
>> # CONFIG_LEDS_LP5521 is not set
>> CONFIG_LEDS_LP5523=m
>> # CONFIG_LEDS_LP5562 is not set
>> CONFIG_LEDS_LP8501=y
>> # CONFIG_LEDS_LP8788 is not set
>> # CONFIG_LEDS_PCA955X is not set
>> CONFIG_LEDS_PCA963X=y
>> # CONFIG_LEDS_WM831X_STATUS is not set
>> CONFIG_LEDS_DA903X=y
>> CONFIG_LEDS_BD2802=m
>> # CONFIG_LEDS_LT3593 is not set
>> CONFIG_LEDS_MC13783=m
>> # CONFIG_LEDS_TCA6507 is not set
>> # CONFIG_LEDS_TLC591XX is not set
>> # CONFIG_LEDS_LM355x is not set
>> CONFIG_LEDS_MENF21BMC=m
>>
>> #
>> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
>> #
>> # CONFIG_LEDS_BLINKM is not set
>> # CONFIG_LEDS_MLXREG is not set
>> # CONFIG_LEDS_USER is not set
>> # CONFIG_LEDS_NIC78BX is not set
>>
>> #
>> # LED Triggers
>> #
>> CONFIG_LEDS_TRIGGERS=y
>> # CONFIG_LEDS_TRIGGER_TIMER is not set
>> # CONFIG_LEDS_TRIGGER_ONESHOT is not set
>> CONFIG_LEDS_TRIGGER_MTD=y
>> # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
>> CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>> CONFIG_LEDS_TRIGGER_CPU=y
>> CONFIG_LEDS_TRIGGER_ACTIVITY=y
>> # CONFIG_LEDS_TRIGGER_GPIO is not set
>> CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
>>
>> #
>> # iptables trigger is under Netfilter config (LED target)
>> #
>> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
>> # CONFIG_LEDS_TRIGGER_CAMERA is not set
>> # CONFIG_LEDS_TRIGGER_PANIC is not set
>> CONFIG_LEDS_TRIGGER_NETDEV=m
>> # CONFIG_LEDS_TRIGGER_PATTERN is not set
>> # CONFIG_LEDS_TRIGGER_AUDIO is not set
>> # CONFIG_ACCESSIBILITY is not set
>> # CONFIG_INFINIBAND is not set
>> CONFIG_EDAC_ATOMIC_SCRUB=y
>> CONFIG_EDAC_SUPPORT=y
>> # CONFIG_EDAC is not set
>> CONFIG_RTC_LIB=y
>> CONFIG_RTC_MC146818_LIB=y
>> # CONFIG_RTC_CLASS is not set
>> CONFIG_DMADEVICES=y
>> CONFIG_DMADEVICES_DEBUG=y
>> # CONFIG_DMADEVICES_VDEBUG is not set
>>
>> #
>> # DMA Devices
>> #
>> CONFIG_DMA_ENGINE=y
>> CONFIG_DMA_VIRTUAL_CHANNELS=y
>> CONFIG_DMA_ACPI=y
>> # CONFIG_ALTERA_MSGDMA is not set
>> CONFIG_INTEL_IDMA64=y
>> # CONFIG_INTEL_IOATDMA is not set
>> CONFIG_INTEL_MIC_X100_DMA=y
>> # CONFIG_QCOM_HIDMA_MGMT is not set
>> CONFIG_QCOM_HIDMA=y
>> CONFIG_DW_DMAC_CORE=y
>> CONFIG_DW_DMAC=m
>> # CONFIG_DW_DMAC_PCI is not set
>> CONFIG_HSU_DMA=y
>>
>> #
>> # DMA Clients
>> #
>> CONFIG_ASYNC_TX_DMA=y
>> # CONFIG_DMATEST is not set
>>
>> #
>> # DMABUF options
>> #
>> CONFIG_SYNC_FILE=y
>> # CONFIG_SW_SYNC is not set
>> # CONFIG_UDMABUF is not set
>> # CONFIG_AUXDISPLAY is not set
>> # CONFIG_PANEL is not set
>> CONFIG_UIO=m
>> CONFIG_UIO_CIF=m
>> # CONFIG_UIO_PDRV_GENIRQ is not set
>> # CONFIG_UIO_DMEM_GENIRQ is not set
>> CONFIG_UIO_AEC=m
>> CONFIG_UIO_SERCOS3=m
>> CONFIG_UIO_PCI_GENERIC=m
>> CONFIG_UIO_NETX=m
>> CONFIG_UIO_PRUSS=m
>> # CONFIG_UIO_MF624 is not set
>> # CONFIG_VIRT_DRIVERS is not set
>> CONFIG_VIRTIO=y
>> # CONFIG_VIRTIO_MENU is not set
>>
>> #
>> # Microsoft Hyper-V guest support
>> #
>> # CONFIG_HYPERV is not set
>> CONFIG_STAGING=y
>> CONFIG_COMEDI=y
>> # CONFIG_COMEDI_DEBUG is not set
>> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
>> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
>> # CONFIG_COMEDI_MISC_DRIVERS is not set
>> CONFIG_COMEDI_ISA_DRIVERS=y
>> CONFIG_COMEDI_PCL711=m
>> # CONFIG_COMEDI_PCL724 is not set
>> # CONFIG_COMEDI_PCL726 is not set
>> CONFIG_COMEDI_PCL730=y
>> CONFIG_COMEDI_PCL812=m
>> CONFIG_COMEDI_PCL816=y
>> # CONFIG_COMEDI_PCL818 is not set
>> # CONFIG_COMEDI_PCM3724 is not set
>> CONFIG_COMEDI_AMPLC_DIO200_ISA=y
>> CONFIG_COMEDI_AMPLC_PC236_ISA=y
>> CONFIG_COMEDI_AMPLC_PC263_ISA=y
>> CONFIG_COMEDI_RTI800=y
>> CONFIG_COMEDI_RTI802=y
>> CONFIG_COMEDI_DAC02=m
>> CONFIG_COMEDI_DAS16M1=y
>> # CONFIG_COMEDI_DAS08_ISA is not set
>> # CONFIG_COMEDI_DAS16 is not set
>> CONFIG_COMEDI_DAS800=y
>> # CONFIG_COMEDI_DAS1800 is not set
>> CONFIG_COMEDI_DAS6402=m
>> # CONFIG_COMEDI_DT2801 is not set
>> # CONFIG_COMEDI_DT2811 is not set
>> # CONFIG_COMEDI_DT2814 is not set
>> # CONFIG_COMEDI_DT2815 is not set
>> # CONFIG_COMEDI_DT2817 is not set
>> CONFIG_COMEDI_DT282X=y
>> # CONFIG_COMEDI_DMM32AT is not set
>> CONFIG_COMEDI_FL512=y
>> CONFIG_COMEDI_AIO_AIO12_8=m
>> CONFIG_COMEDI_AIO_IIRO_16=y
>> CONFIG_COMEDI_II_PCI20KC=m
>> # CONFIG_COMEDI_C6XDIGIO is not set
>> CONFIG_COMEDI_MPC624=m
>> CONFIG_COMEDI_ADQ12B=m
>> CONFIG_COMEDI_NI_AT_A2150=y
>> CONFIG_COMEDI_NI_AT_AO=y
>> CONFIG_COMEDI_NI_ATMIO=m
>> CONFIG_COMEDI_NI_ATMIO16D=y
>> CONFIG_COMEDI_NI_LABPC_ISA=m
>> # CONFIG_COMEDI_PCMAD is not set
>> CONFIG_COMEDI_PCMDA12=m
>> CONFIG_COMEDI_PCMMIO=m
>> CONFIG_COMEDI_PCMUIO=y
>> CONFIG_COMEDI_MULTIQ3=m
>> # CONFIG_COMEDI_S526 is not set
>> CONFIG_COMEDI_PCI_DRIVERS=m
>> CONFIG_COMEDI_8255_PCI=m
>> CONFIG_COMEDI_ADDI_WATCHDOG=m
>> # CONFIG_COMEDI_ADDI_APCI_1032 is not set
>> CONFIG_COMEDI_ADDI_APCI_1500=m
>> # CONFIG_COMEDI_ADDI_APCI_1516 is not set
>> # CONFIG_COMEDI_ADDI_APCI_1564 is not set
>> CONFIG_COMEDI_ADDI_APCI_16XX=m
>> CONFIG_COMEDI_ADDI_APCI_2032=m
>> CONFIG_COMEDI_ADDI_APCI_2200=m
>> # CONFIG_COMEDI_ADDI_APCI_3120 is not set
>> # CONFIG_COMEDI_ADDI_APCI_3501 is not set
>> # CONFIG_COMEDI_ADDI_APCI_3XXX is not set
>> # CONFIG_COMEDI_ADL_PCI6208 is not set
>> # CONFIG_COMEDI_ADL_PCI7X3X is not set
>> CONFIG_COMEDI_ADL_PCI8164=m
>> # CONFIG_COMEDI_ADL_PCI9111 is not set
>> CONFIG_COMEDI_ADL_PCI9118=m
>> # CONFIG_COMEDI_ADV_PCI1710 is not set
>> CONFIG_COMEDI_ADV_PCI1720=m
>> CONFIG_COMEDI_ADV_PCI1723=m
>> CONFIG_COMEDI_ADV_PCI1724=m
>> CONFIG_COMEDI_ADV_PCI1760=m
>> CONFIG_COMEDI_ADV_PCI_DIO=m
>> # CONFIG_COMEDI_AMPLC_DIO200_PCI is not set
>> CONFIG_COMEDI_AMPLC_PC236_PCI=m
>> CONFIG_COMEDI_AMPLC_PC263_PCI=m
>> # CONFIG_COMEDI_AMPLC_PCI224 is not set
>> CONFIG_COMEDI_AMPLC_PCI230=m
>> # CONFIG_COMEDI_CONTEC_PCI_DIO is not set
>> CONFIG_COMEDI_DAS08_PCI=m
>> # CONFIG_COMEDI_DT3000 is not set
>> # CONFIG_COMEDI_DYNA_PCI10XX is not set
>> CONFIG_COMEDI_GSC_HPDI=m
>> CONFIG_COMEDI_MF6X4=m
>> CONFIG_COMEDI_ICP_MULTI=m
>> # CONFIG_COMEDI_DAQBOARD2000 is not set
>> # CONFIG_COMEDI_JR3_PCI is not set
>> CONFIG_COMEDI_KE_COUNTER=m
>> CONFIG_COMEDI_CB_PCIDAS64=m
>> # CONFIG_COMEDI_CB_PCIDAS is not set
>> CONFIG_COMEDI_CB_PCIDDA=m
>> CONFIG_COMEDI_CB_PCIMDAS=m
>> # CONFIG_COMEDI_CB_PCIMDDA is not set
>> # CONFIG_COMEDI_ME4000 is not set
>> # CONFIG_COMEDI_ME_DAQ is not set
>> CONFIG_COMEDI_NI_6527=m
>> CONFIG_COMEDI_NI_65XX=m
>> CONFIG_COMEDI_NI_660X=m
>> # CONFIG_COMEDI_NI_670X is not set
>> # CONFIG_COMEDI_NI_LABPC_PCI is not set
>> CONFIG_COMEDI_NI_PCIDIO=m
>> CONFIG_COMEDI_NI_PCIMIO=m
>> CONFIG_COMEDI_RTD520=m
>> # CONFIG_COMEDI_S626 is not set
>> CONFIG_COMEDI_MITE=m
>> CONFIG_COMEDI_NI_TIOCMD=m
>> CONFIG_COMEDI_8254=y
>> CONFIG_COMEDI_8255=y
>> # CONFIG_COMEDI_8255_SA is not set
>> CONFIG_COMEDI_KCOMEDILIB=m
>> CONFIG_COMEDI_AMPLC_DIO200=y
>> CONFIG_COMEDI_AMPLC_PC236=y
>> CONFIG_COMEDI_DAS08=m
>> CONFIG_COMEDI_NI_LABPC=m
>> CONFIG_COMEDI_NI_TIO=m
>> CONFIG_COMEDI_NI_ROUTING=m
>> # CONFIG_RTS5208 is not set
>>
>> #
>> # IIO staging drivers
>> #
>>
>> #
>> # Accelerometers
>> #
>>
>> #
>> # Analog to digital converters
>> #
>>
>> #
>> # Analog digital bi-direction converters
>> #
>> CONFIG_ADT7316=y
>> # CONFIG_ADT7316_I2C is not set
>>
>> #
>> # Capacitance to digital converters
>> #
>> CONFIG_AD7150=y
>> # CONFIG_AD7746 is not set
>>
>> #
>> # Direct Digital Synthesis
>> #
>>
>> #
>> # Network Analyzer, Impedance Converters
>> #
>> CONFIG_AD5933=y
>>
>> #
>> # Active energy metering IC
>> #
>> CONFIG_ADE7854=m
>> # CONFIG_ADE7854_I2C is not set
>>
>> #
>> # Resolver to digital converters
>> #
>> CONFIG_FB_SM750=m
>>
>> #
>> # Speakup console speech
>> #
>> # CONFIG_STAGING_MEDIA is not set
>>
>> #
>> # Android
>> #
>> # CONFIG_FIREWIRE_SERIAL is not set
>> CONFIG_GS_FPGABOOT=y
>> # CONFIG_UNISYSSPAR is not set
>> CONFIG_MOST=m
>> CONFIG_MOST_CDEV=m
>> # CONFIG_MOST_NET is not set
>> # CONFIG_MOST_VIDEO is not set
>> CONFIG_MOST_I2C=m
>> # CONFIG_GREYBUS is not set
>> CONFIG_DRM_VBOXVIDEO=m
>>
>> #
>> # Gasket devices
>> #
>> CONFIG_STAGING_GASKET_FRAMEWORK=y
>> CONFIG_STAGING_APEX_DRIVER=m
>> CONFIG_XIL_AXIS_FIFO=m
>> CONFIG_EROFS_FS=m
>> CONFIG_EROFS_FS_DEBUG=y
>> CONFIG_EROFS_FS_XATTR=y
>> CONFIG_EROFS_FS_POSIX_ACL=y
>> CONFIG_EROFS_FS_SECURITY=y
>> # CONFIG_EROFS_FS_USE_VM_MAP_RAM is not set
>> # CONFIG_EROFS_FAULT_INJECTION is not set
>> CONFIG_EROFS_FS_IO_MAX_RETRIES=5
>> CONFIG_EROFS_FS_ZIP=y
>> CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
>> CONFIG_EROFS_FS_ZIP_NO_CACHE=y
>> # CONFIG_EROFS_FS_ZIP_CACHE_UNIPOLAR is not set
>> # CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR is not set
>> CONFIG_X86_PLATFORM_DEVICES=y
>> # CONFIG_ACER_WIRELESS is not set
>> # CONFIG_ACERHDF is not set
>> # CONFIG_ASUS_LAPTOP is not set
>> CONFIG_DCDBAS=y
>> # CONFIG_DELL_SMBIOS is not set
>> # CONFIG_DELL_SMO8800 is not set
>> # CONFIG_DELL_RBU is not set
>> # CONFIG_FUJITSU_LAPTOP is not set
>> # CONFIG_FUJITSU_TABLET is not set
>> # CONFIG_GPD_POCKET_FAN is not set
>> # CONFIG_HP_ACCEL is not set
>> # CONFIG_HP_WIRELESS is not set
>> # CONFIG_PANASONIC_LAPTOP is not set
>> # CONFIG_THINKPAD_ACPI is not set
>> CONFIG_SENSORS_HDAPS=m
>> # CONFIG_INTEL_MENLOW is not set
>> # CONFIG_EEEPC_LAPTOP is not set
>> # CONFIG_ASUS_WIRELESS is not set
>> # CONFIG_ACPI_WMI is not set
>> # CONFIG_TOPSTAR_LAPTOP is not set
>> # CONFIG_TOSHIBA_BT_RFKILL is not set
>> # CONFIG_TOSHIBA_HAPS is not set
>> # CONFIG_ACPI_CMPC is not set
>> # CONFIG_INTEL_INT0002_VGPIO is not set
>> # CONFIG_INTEL_HID_EVENT is not set
>> # CONFIG_INTEL_VBTN is not set
>> # CONFIG_INTEL_IPS is not set
>> CONFIG_INTEL_PMC_CORE=y
>> # CONFIG_IBM_RTL is not set
>> CONFIG_SAMSUNG_LAPTOP=m
>> # CONFIG_SAMSUNG_Q10 is not set
>> # CONFIG_APPLE_GMUX is not set
>> # CONFIG_INTEL_RST is not set
>> # CONFIG_INTEL_SMARTCONNECT is not set
>> # CONFIG_INTEL_PMC_IPC is not set
>> # CONFIG_SURFACE_PRO3_BUTTON is not set
>> # CONFIG_INTEL_PUNIT_IPC is not set
>> CONFIG_MLX_PLATFORM=m
>> # CONFIG_I2C_MULTI_INSTANTIATE is not set
>> CONFIG_INTEL_ATOMISP2_PM=y
>> # CONFIG_PCENGINES_APU2 is not set
>> CONFIG_PMC_ATOM=y
>> CONFIG_CHROME_PLATFORMS=y
>> CONFIG_CHROMEOS_PSTORE=y
>> # CONFIG_CHROMEOS_TBMC is not set
>> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
>> CONFIG_MELLANOX_PLATFORM=y
>> CONFIG_MLXREG_HOTPLUG=m
>> CONFIG_MLXREG_IO=m
>> CONFIG_CLKDEV_LOOKUP=y
>> CONFIG_HAVE_CLK_PREPARE=y
>> CONFIG_COMMON_CLK=y
>>
>> #
>> # Common Clock Framework
>> #
>> # CONFIG_COMMON_CLK_WM831X is not set
>> CONFIG_COMMON_CLK_MAX9485=m
>> CONFIG_COMMON_CLK_SI5351=y
>> CONFIG_COMMON_CLK_SI544=m
>> CONFIG_COMMON_CLK_CDCE706=m
>> # CONFIG_COMMON_CLK_CS2000_CP is not set
>> CONFIG_COMMON_CLK_PALMAS=m
>> CONFIG_HWSPINLOCK=y
>>
>> #
>> # Clock Source drivers
>> #
>> CONFIG_CLKEVT_I8253=y
>> CONFIG_CLKBLD_I8253=y
>> CONFIG_MAILBOX=y
>> # CONFIG_PCC is not set
>> # CONFIG_ALTERA_MBOX is not set
>> CONFIG_IOMMU_SUPPORT=y
>>
>> #
>> # Generic IOMMU Pagetable Support
>> #
>> # CONFIG_IOMMU_DEBUGFS is not set
>> # CONFIG_AMD_IOMMU is not set
>>
>> #
>> # Remoteproc drivers
>> #
>> CONFIG_REMOTEPROC=y
>>
>> #
>> # Rpmsg drivers
>> #
>> CONFIG_RPMSG=y
>> # CONFIG_RPMSG_CHAR is not set
>> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
>> CONFIG_RPMSG_VIRTIO=y
>> CONFIG_SOUNDWIRE=y
>>
>> #
>> # SoundWire Devices
>> #
>>
>> #
>> # SOC (System On Chip) specific Drivers
>> #
>>
>> #
>> # Amlogic SoC drivers
>> #
>>
>> #
>> # Broadcom SoC drivers
>> #
>>
>> #
>> # NXP/Freescale QorIQ SoC drivers
>> #
>>
>> #
>> # i.MX SoC drivers
>> #
>>
>> #
>> # Qualcomm SoC drivers
>> #
>> CONFIG_SOC_TI=y
>>
>> #
>> # Xilinx SoC drivers
>> #
>> CONFIG_XILINX_VCU=m
>> CONFIG_PM_DEVFREQ=y
>>
>> #
>> # DEVFREQ Governors
>> #
>> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
>> # CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
>> CONFIG_DEVFREQ_GOV_POWERSAVE=m
>> CONFIG_DEVFREQ_GOV_USERSPACE=y
>> CONFIG_DEVFREQ_GOV_PASSIVE=y
>>
>> #
>> # DEVFREQ Drivers
>> #
>> CONFIG_PM_DEVFREQ_EVENT=y
>> CONFIG_EXTCON=y
>>
>> #
>> # Extcon Device Drivers
>> #
>> CONFIG_EXTCON_ADC_JACK=m
>> CONFIG_EXTCON_GPIO=y
>> # CONFIG_EXTCON_INTEL_INT3496 is not set
>> # CONFIG_EXTCON_MAX3355 is not set
>> # CONFIG_EXTCON_MAX77693 is not set
>> CONFIG_EXTCON_PALMAS=m
>> # CONFIG_EXTCON_PTN5150 is not set
>> # CONFIG_EXTCON_RT8973A is not set
>> # CONFIG_EXTCON_SM5502 is not set
>> CONFIG_EXTCON_USB_GPIO=y
>> # CONFIG_MEMORY is not set
>> CONFIG_IIO=y
>> CONFIG_IIO_BUFFER=y
>> CONFIG_IIO_BUFFER_CB=m
>> # CONFIG_IIO_BUFFER_HW_CONSUMER is not set
>> CONFIG_IIO_KFIFO_BUF=y
>> CONFIG_IIO_TRIGGERED_BUFFER=y
>> CONFIG_IIO_CONFIGFS=y
>> CONFIG_IIO_TRIGGER=y
>> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
>> # CONFIG_IIO_SW_DEVICE is not set
>> # CONFIG_IIO_SW_TRIGGER is not set
>>
>> #
>> # Accelerometers
>> #
>> # CONFIG_ADXL372_I2C is not set
>> CONFIG_BMA180=y
>> CONFIG_BMC150_ACCEL=m
>> CONFIG_BMC150_ACCEL_I2C=m
>> # CONFIG_DA280 is not set
>> # CONFIG_DA311 is not set
>> CONFIG_DMARD09=m
>> # CONFIG_DMARD10 is not set
>> CONFIG_HID_SENSOR_ACCEL_3D=m
>> # CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
>> CONFIG_IIO_ST_ACCEL_3AXIS=y
>> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
>> # CONFIG_KXSD9 is not set
>> # CONFIG_KXCJK1013 is not set
>> CONFIG_MC3230=y
>> CONFIG_MMA7455=m
>> CONFIG_MMA7455_I2C=m
>> # CONFIG_MMA7660 is not set
>> CONFIG_MMA8452=y
>> CONFIG_MMA9551_CORE=y
>> CONFIG_MMA9551=m
>> CONFIG_MMA9553=y
>> CONFIG_MXC4005=m
>> # CONFIG_MXC6255 is not set
>> # CONFIG_STK8312 is not set
>> CONFIG_STK8BA50=m
>>
>> #
>> # Analog to digital converters
>> #
>> CONFIG_AD7291=y
>> CONFIG_AD7606=m
>> CONFIG_AD7606_IFACE_PARALLEL=m
>> CONFIG_AD799X=m
>> # CONFIG_DA9150_GPADC is not set
>> # CONFIG_HX711 is not set
>> CONFIG_INA2XX_ADC=m
>> CONFIG_LP8788_ADC=y
>> CONFIG_LTC2471=y
>> CONFIG_LTC2485=y
>> # CONFIG_LTC2497 is not set
>> CONFIG_MAX1363=y
>> CONFIG_MAX9611=m
>> CONFIG_MCP3422=m
>> CONFIG_MEN_Z188_ADC=m
>> CONFIG_NAU7802=y
>> # CONFIG_PALMAS_GPADC is not set
>> # CONFIG_QCOM_SPMI_IADC is not set
>> # CONFIG_QCOM_SPMI_VADC is not set
>> # CONFIG_QCOM_SPMI_ADC5 is not set
>> CONFIG_TI_ADC081C=y
>> CONFIG_TI_ADS1015=m
>>
>> #
>> # Analog Front Ends
>> #
>>
>> #
>> # Amplifiers
>> #
>>
>> #
>> # Chemical Sensors
>> #
>> CONFIG_ATLAS_PH_SENSOR=y
>> CONFIG_BME680=y
>> CONFIG_BME680_I2C=y
>> CONFIG_CCS811=m
>> CONFIG_IAQCORE=m
>> # CONFIG_PMS7003 is not set
>> # CONFIG_SPS30 is not set
>> CONFIG_VZ89X=m
>>
>> #
>> # Hid Sensor IIO Common
>> #
>> CONFIG_HID_SENSOR_IIO_COMMON=m
>> CONFIG_HID_SENSOR_IIO_TRIGGER=m
>> CONFIG_IIO_MS_SENSORS_I2C=y
>>
>> #
>> # SSP Sensor Common
>> #
>> CONFIG_IIO_ST_SENSORS_I2C=y
>> CONFIG_IIO_ST_SENSORS_CORE=y
>>
>> #
>> # Counters
>> #
>>
>> #
>> # Digital to analog converters
>> #
>> CONFIG_AD5064=m
>> CONFIG_AD5380=m
>> CONFIG_AD5446=m
>> CONFIG_AD5592R_BASE=y
>> CONFIG_AD5593R=y
>> CONFIG_AD5686=m
>> CONFIG_AD5696_I2C=m
>> CONFIG_CIO_DAC=m
>> CONFIG_DS4424=y
>> CONFIG_M62332=m
>> CONFIG_MAX517=m
>> CONFIG_MCP4725=m
>> # CONFIG_TI_DAC5571 is not set
>>
>> #
>> # IIO dummy driver
>> #
>>
>> #
>> # Frequency Synthesizers DDS/PLL
>> #
>>
>> #
>> # Clock Generator/Distribution
>> #
>>
>> #
>> # Phase-Locked Loop (PLL) frequency synthesizers
>> #
>>
>> #
>> # Digital gyroscope sensors
>> #
>> CONFIG_BMG160=m
>> CONFIG_BMG160_I2C=m
>> # CONFIG_HID_SENSOR_GYRO_3D is not set
>> # CONFIG_MPU3050_I2C is not set
>> # CONFIG_IIO_ST_GYRO_3AXIS is not set
>> CONFIG_ITG3200=y
>>
>> #
>> # Health Sensors
>> #
>>
>> #
>> # Heart Rate Monitors
>> #
>> # CONFIG_AFE4404 is not set
>> CONFIG_MAX30100=m
>> CONFIG_MAX30102=m
>>
>> #
>> # Humidity sensors
>> #
>> CONFIG_AM2315=m
>> CONFIG_DHT11=m
>> # CONFIG_HDC100X is not set
>> # CONFIG_HID_SENSOR_HUMIDITY is not set
>> # CONFIG_HTS221 is not set
>> CONFIG_HTU21=y
>> CONFIG_SI7005=y
>> CONFIG_SI7020=y
>>
>> #
>> # Inertial measurement units
>> #
>> CONFIG_BMI160=y
>> CONFIG_BMI160_I2C=y
>> CONFIG_KMX61=m
>> CONFIG_INV_MPU6050_IIO=m
>> CONFIG_INV_MPU6050_I2C=m
>> # CONFIG_IIO_ST_LSM6DSX is not set
>>
>> #
>> # Light sensors
>> #
>> # CONFIG_ACPI_ALS is not set
>> CONFIG_ADJD_S311=y
>> CONFIG_AL3320A=m
>> CONFIG_APDS9300=m
>> CONFIG_APDS9960=m
>> # CONFIG_BH1750 is not set
>> CONFIG_BH1780=y
>> CONFIG_CM32181=m
>> CONFIG_CM3232=y
>> CONFIG_CM3323=m
>> # CONFIG_CM36651 is not set
>> CONFIG_GP2AP020A00F=m
>> # CONFIG_SENSORS_ISL29018 is not set
>> CONFIG_SENSORS_ISL29028=m
>> # CONFIG_ISL29125 is not set
>> CONFIG_HID_SENSOR_ALS=m
>> # CONFIG_HID_SENSOR_PROX is not set
>> # CONFIG_JSA1212 is not set
>> CONFIG_RPR0521=y
>> CONFIG_LTR501=y
>> CONFIG_LV0104CS=y
>> CONFIG_MAX44000=m
>> # CONFIG_MAX44009 is not set
>> CONFIG_OPT3001=m
>> # CONFIG_PA12203001 is not set
>> CONFIG_SI1133=y
>> CONFIG_SI1145=y
>> CONFIG_STK3310=m
>> CONFIG_ST_UVIS25=m
>> CONFIG_ST_UVIS25_I2C=m
>> CONFIG_TCS3414=y
>> CONFIG_TCS3472=y
>> # CONFIG_SENSORS_TSL2563 is not set
>> CONFIG_TSL2583=y
>> CONFIG_TSL2772=m
>> CONFIG_TSL4531=m
>> # CONFIG_US5182D is not set
>> CONFIG_VCNL4000=m
>> # CONFIG_VCNL4035 is not set
>> CONFIG_VEML6070=m
>> CONFIG_VL6180=m
>> # CONFIG_ZOPT2201 is not set
>>
>> #
>> # Magnetometer sensors
>> #
>> CONFIG_AK8975=m
>> # CONFIG_AK09911 is not set
>> CONFIG_BMC150_MAGN=m
>> CONFIG_BMC150_MAGN_I2C=m
>> # CONFIG_MAG3110 is not set
>> # CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
>> CONFIG_MMC35240=m
>> # CONFIG_IIO_ST_MAGN_3AXIS is not set
>> CONFIG_SENSORS_HMC5843=y
>> CONFIG_SENSORS_HMC5843_I2C=y
>> # CONFIG_SENSORS_RM3100_I2C is not set
>>
>> #
>> # Multiplexers
>> #
>>
>> #
>> # Inclinometer sensors
>> #
>> CONFIG_HID_SENSOR_INCLINOMETER_3D=m
>> CONFIG_HID_SENSOR_DEVICE_ROTATION=m
>>
>> #
>> # Triggers - standalone
>> #
>> CONFIG_IIO_INTERRUPT_TRIGGER=m
>> # CONFIG_IIO_SYSFS_TRIGGER is not set
>>
>> #
>> # Digital potentiometers
>> #
>> # CONFIG_AD5272 is not set
>> # CONFIG_DS1803 is not set
>> # CONFIG_MCP4018 is not set
>> # CONFIG_MCP4531 is not set
>> CONFIG_TPL0102=m
>>
>> #
>> # Digital potentiostats
>> #
>> # CONFIG_LMP91000 is not set
>>
>> #
>> # Pressure sensors
>> #
>> CONFIG_ABP060MG=m
>> CONFIG_BMP280=y
>> CONFIG_BMP280_I2C=y
>> CONFIG_HID_SENSOR_PRESS=m
>> CONFIG_HP03=y
>> # CONFIG_MPL115_I2C is not set
>> # CONFIG_MPL3115 is not set
>> # CONFIG_MS5611 is not set
>> # CONFIG_MS5637 is not set
>> CONFIG_IIO_ST_PRESS=m
>> CONFIG_IIO_ST_PRESS_I2C=m
>> CONFIG_T5403=m
>> # CONFIG_HP206C is not set
>> CONFIG_ZPA2326=m
>> CONFIG_ZPA2326_I2C=m
>>
>> #
>> # Lightning sensors
>> #
>>
>> #
>> # Proximity and distance sensors
>> #
>> CONFIG_ISL29501=m
>> CONFIG_LIDAR_LITE_V2=m
>> CONFIG_RFD77402=m
>> # CONFIG_SRF04 is not set
>> CONFIG_SX9500=y
>> CONFIG_SRF08=m
>> # CONFIG_VL53L0X_I2C is not set
>>
>> #
>> # Resolver to digital converters
>> #
>>
>> #
>> # Temperature sensors
>> #
>> CONFIG_HID_SENSOR_TEMP=m
>> CONFIG_MLX90614=y
>> CONFIG_MLX90632=y
>> CONFIG_TMP006=m
>> CONFIG_TMP007=y
>> CONFIG_TSYS01=y
>> CONFIG_TSYS02D=m
>> CONFIG_NTB=y
>> # CONFIG_NTB_AMD is not set
>> # CONFIG_NTB_IDT is not set
>> CONFIG_NTB_INTEL=y
>> CONFIG_NTB_SWITCHTEC=y
>> CONFIG_NTB_PINGPONG=m
>> CONFIG_NTB_TOOL=y
>> CONFIG_NTB_PERF=y
>> CONFIG_NTB_TRANSPORT=y
>> CONFIG_VME_BUS=y
>>
>> #
>> # VME Bridge Drivers
>> #
>> CONFIG_VME_CA91CX42=y
>> CONFIG_VME_TSI148=y
>> # CONFIG_VME_FAKE is not set
>>
>> #
>> # VME Board Drivers
>> #
>> CONFIG_VMIVME_7805=m
>>
>> #
>> # VME Device Drivers
>> #
>> CONFIG_VME_USER=y
>> # CONFIG_PWM is not set
>>
>> #
>> # IRQ chip support
>> #
>> CONFIG_ARM_GIC_MAX_NR=1
>> CONFIG_MADERA_IRQ=m
>> CONFIG_IPACK_BUS=y
>> CONFIG_BOARD_TPCI200=m
>> # CONFIG_SERIAL_IPOCTAL is not set
>> CONFIG_RESET_CONTROLLER=y
>> # CONFIG_RESET_TI_SYSCON is not set
>> CONFIG_FMC=m
>> # CONFIG_FMC_FAKEDEV is not set
>> CONFIG_FMC_TRIVIAL=m
>> CONFIG_FMC_WRITE_EEPROM=m
>> # CONFIG_FMC_CHARDEV is not set
>>
>> #
>> # PHY Subsystem
>> #
>> CONFIG_GENERIC_PHY=y
>> # CONFIG_BCM_KONA_USB2_PHY is not set
>> CONFIG_PHY_PXA_28NM_HSIC=m
>> # CONFIG_PHY_PXA_28NM_USB2 is not set
>> # CONFIG_PHY_CPCAP_USB is not set
>> CONFIG_POWERCAP=y
>> CONFIG_INTEL_RAPL=m
>> # CONFIG_IDLE_INJECT is not set
>> CONFIG_MCB=y
>> CONFIG_MCB_PCI=m
>> CONFIG_MCB_LPC=y
>>
>> #
>> # Performance monitor support
>> #
>> CONFIG_RAS=y
>> # CONFIG_RAS_CEC is not set
>> CONFIG_THUNDERBOLT=y
>>
>> #
>> # Android
>> #
>> # CONFIG_ANDROID is not set
>> # CONFIG_LIBNVDIMM is not set
>> CONFIG_DAX=m
>> CONFIG_DEV_DAX=m
>> CONFIG_DEV_DAX_KMEM=m
>> CONFIG_NVMEM=y
>> CONFIG_RAVE_SP_EEPROM=m
>>
>> #
>> # HW tracing support
>> #
>> CONFIG_STM=y
>> # CONFIG_STM_PROTO_BASIC is not set
>> # CONFIG_STM_PROTO_SYS_T is not set
>> CONFIG_STM_DUMMY=m
>> CONFIG_STM_SOURCE_CONSOLE=m
>> # CONFIG_STM_SOURCE_HEARTBEAT is not set
>> CONFIG_INTEL_TH=y
>> # CONFIG_INTEL_TH_PCI is not set
>> # CONFIG_INTEL_TH_ACPI is not set
>> CONFIG_INTEL_TH_GTH=y
>> CONFIG_INTEL_TH_STH=y
>> CONFIG_INTEL_TH_MSU=m
>> CONFIG_INTEL_TH_PTI=m
>> # CONFIG_INTEL_TH_DEBUG is not set
>> CONFIG_FPGA=y
>> CONFIG_ALTERA_PR_IP_CORE=m
>> # CONFIG_FPGA_MGR_ALTERA_CVP is not set
>> CONFIG_FPGA_BRIDGE=y
>> # CONFIG_ALTERA_FREEZE_BRIDGE is not set
>> CONFIG_XILINX_PR_DECOUPLER=y
>> CONFIG_FPGA_REGION=m
>> CONFIG_FPGA_DFL=m
>> CONFIG_FPGA_DFL_FME=m
>> # CONFIG_FPGA_DFL_FME_MGR is not set
>> CONFIG_FPGA_DFL_FME_BRIDGE=m
>> CONFIG_FPGA_DFL_FME_REGION=m
>> # CONFIG_FPGA_DFL_AFU is not set
>> CONFIG_FPGA_DFL_PCI=m
>> CONFIG_PM_OPP=y
>> # CONFIG_UNISYS_VISORBUS is not set
>> CONFIG_SIOX=y
>> CONFIG_SIOX_BUS_GPIO=m
>> # CONFIG_SLIMBUS is not set
>> # CONFIG_INTERCONNECT is not set
>>
>> #
>> # File systems
>> #
>> CONFIG_DCACHE_WORD_ACCESS=y
>> CONFIG_VALIDATE_FS_PARSER=y
>> CONFIG_FS_IOMAP=y
>> # CONFIG_EXT2_FS is not set
>> CONFIG_EXT3_FS=y
>> # CONFIG_EXT3_FS_POSIX_ACL is not set
>> CONFIG_EXT3_FS_SECURITY=y
>> CONFIG_EXT4_FS=y
>> CONFIG_EXT4_USE_FOR_EXT2=y
>> # CONFIG_EXT4_FS_POSIX_ACL is not set
>> CONFIG_EXT4_FS_SECURITY=y
>> # CONFIG_EXT4_DEBUG is not set
>> CONFIG_JBD2=y
>> CONFIG_JBD2_DEBUG=y
>> CONFIG_FS_MBCACHE=y
>> # CONFIG_REISERFS_FS is not set
>> # CONFIG_JFS_FS is not set
>> CONFIG_XFS_FS=m
>> CONFIG_XFS_QUOTA=y
>> CONFIG_XFS_POSIX_ACL=y
>> CONFIG_XFS_RT=y
>> # CONFIG_XFS_ONLINE_SCRUB is not set
>> CONFIG_XFS_WARN=y
>> # CONFIG_XFS_DEBUG is not set
>> CONFIG_GFS2_FS=m
>> # CONFIG_OCFS2_FS is not set
>> CONFIG_BTRFS_FS=y
>> # CONFIG_BTRFS_FS_POSIX_ACL is not set
>> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
>> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
>> # CONFIG_BTRFS_DEBUG is not set
>> # CONFIG_BTRFS_ASSERT is not set
>> CONFIG_BTRFS_FS_REF_VERIFY=y
>> CONFIG_NILFS2_FS=y
>> CONFIG_F2FS_FS=y
>> # CONFIG_F2FS_STAT_FS is not set
>> CONFIG_F2FS_FS_XATTR=y
>> # CONFIG_F2FS_FS_POSIX_ACL is not set
>> CONFIG_F2FS_FS_SECURITY=y
>> CONFIG_F2FS_CHECK_FS=y
>> # CONFIG_F2FS_FAULT_INJECTION is not set
>> # CONFIG_FS_DAX is not set
>> CONFIG_FS_POSIX_ACL=y
>> CONFIG_EXPORTFS=y
>> CONFIG_EXPORTFS_BLOCK_OPS=y
>> CONFIG_FILE_LOCKING=y
>> CONFIG_MANDATORY_FILE_LOCKING=y
>> CONFIG_FS_ENCRYPTION=y
>> CONFIG_FSNOTIFY=y
>> CONFIG_DNOTIFY=y
>> CONFIG_INOTIFY_USER=y
>> # CONFIG_FANOTIFY is not set
>> # CONFIG_QUOTA is not set
>> CONFIG_QUOTA_NETLINK_INTERFACE=y
>> CONFIG_QUOTACTL=y
>> CONFIG_AUTOFS4_FS=m
>> CONFIG_AUTOFS_FS=m
>> # CONFIG_FUSE_FS is not set
>> CONFIG_OVERLAY_FS=y
>> CONFIG_OVERLAY_FS_REDIRECT_DIR=y
>> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
>> # CONFIG_OVERLAY_FS_INDEX is not set
>> CONFIG_OVERLAY_FS_XINO_AUTO=y
>> # CONFIG_OVERLAY_FS_METACOPY is not set
>>
>> #
>> # Caches
>> #
>> CONFIG_FSCACHE=y
>> # CONFIG_FSCACHE_STATS is not set
>> # CONFIG_FSCACHE_HISTOGRAM is not set
>> # CONFIG_FSCACHE_DEBUG is not set
>> # CONFIG_FSCACHE_OBJECT_LIST is not set
>> CONFIG_CACHEFILES=y
>> # CONFIG_CACHEFILES_DEBUG is not set
>> # CONFIG_CACHEFILES_HISTOGRAM is not set
>>
>> #
>> # CD-ROM/DVD Filesystems
>> #
>> CONFIG_ISO9660_FS=m
>> CONFIG_JOLIET=y
>> # CONFIG_ZISOFS is not set
>> CONFIG_UDF_FS=m
>>
>> #
>> # DOS/FAT/NT Filesystems
>> #
>> CONFIG_FAT_FS=m
>> CONFIG_MSDOS_FS=m
>> # CONFIG_VFAT_FS is not set
>> CONFIG_FAT_DEFAULT_CODEPAGE=437
>> # CONFIG_NTFS_FS is not set
>>
>> #
>> # Pseudo filesystems
>> #
>> CONFIG_PROC_FS=y
>> # CONFIG_PROC_KCORE is not set
>> CONFIG_PROC_VMCORE=y
>> # CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
>> CONFIG_PROC_SYSCTL=y
>> CONFIG_PROC_PAGE_MONITOR=y
>> CONFIG_PROC_CHILDREN=y
>> CONFIG_KERNFS=y
>> CONFIG_SYSFS=y
>> CONFIG_TMPFS=y
>> CONFIG_TMPFS_POSIX_ACL=y
>> CONFIG_TMPFS_XATTR=y
>> # CONFIG_HUGETLBFS is not set
>> CONFIG_MEMFD_CREATE=y
>> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
>> CONFIG_CONFIGFS_FS=y
>> # CONFIG_MISC_FILESYSTEMS is not set
>> CONFIG_NETWORK_FILESYSTEMS=y
>> CONFIG_NFS_FS=y
>> CONFIG_NFS_V2=y
>> CONFIG_NFS_V3=y
>> # CONFIG_NFS_V3_ACL is not set
>> CONFIG_NFS_V4=m
>> # CONFIG_NFS_SWAP is not set
>> # CONFIG_NFS_V4_1 is not set
>> # CONFIG_ROOT_NFS is not set
>> # CONFIG_NFS_FSCACHE is not set
>> # CONFIG_NFS_USE_LEGACY_DNS is not set
>> CONFIG_NFS_USE_KERNEL_DNS=y
>> # CONFIG_NFSD is not set
>> CONFIG_GRACE_PERIOD=y
>> CONFIG_LOCKD=y
>> CONFIG_LOCKD_V4=y
>> CONFIG_NFS_COMMON=y
>> CONFIG_SUNRPC=y
>> CONFIG_SUNRPC_GSS=y
>> CONFIG_RPCSEC_GSS_KRB5=y
>> # CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
>> # CONFIG_SUNRPC_DEBUG is not set
>> # CONFIG_CEPH_FS is not set
>> CONFIG_CIFS=m
>> # CONFIG_CIFS_STATS2 is not set
>> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
>> # CONFIG_CIFS_WEAK_PW_HASH is not set
>> # CONFIG_CIFS_UPCALL is not set
>> # CONFIG_CIFS_XATTR is not set
>> CONFIG_CIFS_DEBUG=y
>> # CONFIG_CIFS_DEBUG2 is not set
>> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
>> # CONFIG_CIFS_DFS_UPCALL is not set
>> # CONFIG_CIFS_FSCACHE is not set
>> # CONFIG_CODA_FS is not set
>> # CONFIG_AFS_FS is not set
>> # CONFIG_9P_FS is not set
>> CONFIG_NLS=y
>> CONFIG_NLS_DEFAULT="iso8859-1"
>> # CONFIG_NLS_CODEPAGE_437 is not set
>> CONFIG_NLS_CODEPAGE_737=m
>> # CONFIG_NLS_CODEPAGE_775 is not set
>> CONFIG_NLS_CODEPAGE_850=m
>> # CONFIG_NLS_CODEPAGE_852 is not set
>> CONFIG_NLS_CODEPAGE_855=y
>> CONFIG_NLS_CODEPAGE_857=m
>> CONFIG_NLS_CODEPAGE_860=y
>> CONFIG_NLS_CODEPAGE_861=m
>> CONFIG_NLS_CODEPAGE_862=y
>> # CONFIG_NLS_CODEPAGE_863 is not set
>> # CONFIG_NLS_CODEPAGE_864 is not set
>> # CONFIG_NLS_CODEPAGE_865 is not set
>> # CONFIG_NLS_CODEPAGE_866 is not set
>> CONFIG_NLS_CODEPAGE_869=m
>> # CONFIG_NLS_CODEPAGE_936 is not set
>> CONFIG_NLS_CODEPAGE_950=y
>> CONFIG_NLS_CODEPAGE_932=m
>> CONFIG_NLS_CODEPAGE_949=y
>> CONFIG_NLS_CODEPAGE_874=m
>> CONFIG_NLS_ISO8859_8=m
>> # CONFIG_NLS_CODEPAGE_1250 is not set
>> CONFIG_NLS_CODEPAGE_1251=m
>> CONFIG_NLS_ASCII=y
>> CONFIG_NLS_ISO8859_1=y
>> CONFIG_NLS_ISO8859_2=m
>> CONFIG_NLS_ISO8859_3=y
>> # CONFIG_NLS_ISO8859_4 is not set
>> CONFIG_NLS_ISO8859_5=m
>> # CONFIG_NLS_ISO8859_6 is not set
>> # CONFIG_NLS_ISO8859_7 is not set
>> # CONFIG_NLS_ISO8859_9 is not set
>> CONFIG_NLS_ISO8859_13=m
>> # CONFIG_NLS_ISO8859_14 is not set
>> CONFIG_NLS_ISO8859_15=m
>> # CONFIG_NLS_KOI8_R is not set
>> CONFIG_NLS_KOI8_U=y
>> # CONFIG_NLS_MAC_ROMAN is not set
>> # CONFIG_NLS_MAC_CELTIC is not set
>> CONFIG_NLS_MAC_CENTEURO=m
>> CONFIG_NLS_MAC_CROATIAN=y
>> # CONFIG_NLS_MAC_CYRILLIC is not set
>> # CONFIG_NLS_MAC_GAELIC is not set
>> # CONFIG_NLS_MAC_GREEK is not set
>> CONFIG_NLS_MAC_ICELAND=y
>> CONFIG_NLS_MAC_INUIT=m
>> CONFIG_NLS_MAC_ROMANIAN=y
>> CONFIG_NLS_MAC_TURKISH=m
>> CONFIG_NLS_UTF8=m
>> # CONFIG_DLM is not set
>>
>> #
>> # Security options
>> #
>> CONFIG_KEYS=y
>> # CONFIG_PERSISTENT_KEYRINGS is not set
>> CONFIG_BIG_KEYS=y
>> CONFIG_TRUSTED_KEYS=m
>> CONFIG_ENCRYPTED_KEYS=y
>> # CONFIG_KEY_DH_OPERATIONS is not set
>> CONFIG_SECURITY_DMESG_RESTRICT=y
>> # CONFIG_SECURITY is not set
>> CONFIG_SECURITYFS=y
>> CONFIG_PAGE_TABLE_ISOLATION=y
>> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>> # CONFIG_HARDENED_USERCOPY is not set
>> # CONFIG_FORTIFY_SOURCE is not set
>> CONFIG_STATIC_USERMODEHELPER=y
>> CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
>> CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>> CONFIG_XOR_BLOCKS=y
>> CONFIG_CRYPTO=y
>>
>> #
>> # Crypto core or helper
>> #
>> CONFIG_CRYPTO_ALGAPI=y
>> CONFIG_CRYPTO_ALGAPI2=y
>> CONFIG_CRYPTO_AEAD=y
>> CONFIG_CRYPTO_AEAD2=y
>> CONFIG_CRYPTO_BLKCIPHER=y
>> CONFIG_CRYPTO_BLKCIPHER2=y
>> CONFIG_CRYPTO_HASH=y
>> CONFIG_CRYPTO_HASH2=y
>> CONFIG_CRYPTO_RNG=y
>> CONFIG_CRYPTO_RNG2=y
>> CONFIG_CRYPTO_RNG_DEFAULT=y
>> CONFIG_CRYPTO_AKCIPHER2=y
>> CONFIG_CRYPTO_AKCIPHER=y
>> CONFIG_CRYPTO_KPP2=y
>> CONFIG_CRYPTO_KPP=y
>> CONFIG_CRYPTO_ACOMP2=y
>> CONFIG_CRYPTO_RSA=y
>> CONFIG_CRYPTO_DH=y
>> CONFIG_CRYPTO_ECDH=m
>> CONFIG_CRYPTO_MANAGER=y
>> CONFIG_CRYPTO_MANAGER2=y
>> CONFIG_CRYPTO_USER=y
>> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
>> CONFIG_CRYPTO_GF128MUL=y
>> CONFIG_CRYPTO_NULL=y
>> CONFIG_CRYPTO_NULL2=y
>> CONFIG_CRYPTO_PCRYPT=m
>> CONFIG_CRYPTO_WORKQUEUE=y
>> CONFIG_CRYPTO_CRYPTD=y
>> CONFIG_CRYPTO_AUTHENC=y
>> # CONFIG_CRYPTO_TEST is not set
>> CONFIG_CRYPTO_SIMD=y
>> CONFIG_CRYPTO_GLUE_HELPER_X86=y
>> CONFIG_CRYPTO_ENGINE=m
>>
>> #
>> # Authenticated Encryption with Associated Data
>> #
>> CONFIG_CRYPTO_CCM=m
>> CONFIG_CRYPTO_GCM=y
>> CONFIG_CRYPTO_CHACHA20POLY1305=m
>> CONFIG_CRYPTO_AEGIS128=m
>> CONFIG_CRYPTO_AEGIS128L=y
>> CONFIG_CRYPTO_AEGIS256=y
>> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
>> CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2=y
>> CONFIG_CRYPTO_AEGIS256_AESNI_SSE2=m
>> # CONFIG_CRYPTO_MORUS640 is not set
>> CONFIG_CRYPTO_MORUS640_GLUE=y
>> CONFIG_CRYPTO_MORUS640_SSE2=y
>> # CONFIG_CRYPTO_MORUS1280 is not set
>> CONFIG_CRYPTO_MORUS1280_GLUE=y
>> CONFIG_CRYPTO_MORUS1280_SSE2=m
>> CONFIG_CRYPTO_MORUS1280_AVX2=y
>> CONFIG_CRYPTO_SEQIV=y
>> # CONFIG_CRYPTO_ECHAINIV is not set
>>
>> #
>> # Block modes
>> #
>> CONFIG_CRYPTO_CBC=y
>> CONFIG_CRYPTO_CFB=m
>> CONFIG_CRYPTO_CTR=y
>> CONFIG_CRYPTO_CTS=y
>> CONFIG_CRYPTO_ECB=y
>> CONFIG_CRYPTO_LRW=y
>> # CONFIG_CRYPTO_OFB is not set
>> CONFIG_CRYPTO_PCBC=m
>> CONFIG_CRYPTO_XTS=y
>> # CONFIG_CRYPTO_KEYWRAP is not set
>> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
>> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
>> # CONFIG_CRYPTO_ADIANTUM is not set
>>
>> #
>> # Hash modes
>> #
>> CONFIG_CRYPTO_CMAC=y
>> CONFIG_CRYPTO_HMAC=y
>> CONFIG_CRYPTO_XCBC=m
>> CONFIG_CRYPTO_VMAC=y
>>
>> #
>> # Digest
>> #
>> CONFIG_CRYPTO_CRC32C=y
>> CONFIG_CRYPTO_CRC32C_INTEL=y
>> CONFIG_CRYPTO_CRC32=y
>> # CONFIG_CRYPTO_CRC32_PCLMUL is not set
>> CONFIG_CRYPTO_CRCT10DIF=y
>> # CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
>> CONFIG_CRYPTO_GHASH=y
>> CONFIG_CRYPTO_POLY1305=m
>> # CONFIG_CRYPTO_POLY1305_X86_64 is not set
>> CONFIG_CRYPTO_MD4=m
>> CONFIG_CRYPTO_MD5=y
>> CONFIG_CRYPTO_MICHAEL_MIC=y
>> # CONFIG_CRYPTO_RMD128 is not set
>> CONFIG_CRYPTO_RMD160=y
>> CONFIG_CRYPTO_RMD256=m
>> CONFIG_CRYPTO_RMD320=y
>> CONFIG_CRYPTO_SHA1=y
>> # CONFIG_CRYPTO_SHA1_SSSE3 is not set
>> CONFIG_CRYPTO_SHA256_SSSE3=y
>> # CONFIG_CRYPTO_SHA512_SSSE3 is not set
>> CONFIG_CRYPTO_SHA256=y
>> CONFIG_CRYPTO_SHA512=y
>> CONFIG_CRYPTO_SHA3=m
>> CONFIG_CRYPTO_SM3=m
>> # CONFIG_CRYPTO_STREEBOG is not set
>> CONFIG_CRYPTO_TGR192=m
>> CONFIG_CRYPTO_WP512=m
>> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
>>
>> #
>> # Ciphers
>> #
>> CONFIG_CRYPTO_AES=y
>> # CONFIG_CRYPTO_AES_TI is not set
>> CONFIG_CRYPTO_AES_X86_64=y
>> CONFIG_CRYPTO_AES_NI_INTEL=y
>> CONFIG_CRYPTO_ANUBIS=m
>> CONFIG_CRYPTO_ARC4=y
>> # CONFIG_CRYPTO_BLOWFISH is not set
>> CONFIG_CRYPTO_BLOWFISH_COMMON=m
>> CONFIG_CRYPTO_BLOWFISH_X86_64=m
>> # CONFIG_CRYPTO_CAMELLIA is not set
>> CONFIG_CRYPTO_CAMELLIA_X86_64=y
>> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
>> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
>> CONFIG_CRYPTO_CAST_COMMON=y
>> CONFIG_CRYPTO_CAST5=y
>> CONFIG_CRYPTO_CAST5_AVX_X86_64=m
>> # CONFIG_CRYPTO_CAST6 is not set
>> # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
>> CONFIG_CRYPTO_DES=y
>> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
>> CONFIG_CRYPTO_FCRYPT=m
>> CONFIG_CRYPTO_KHAZAD=m
>> # CONFIG_CRYPTO_SALSA20 is not set
>> CONFIG_CRYPTO_CHACHA20=m
>> CONFIG_CRYPTO_CHACHA20_X86_64=m
>> CONFIG_CRYPTO_SEED=y
>> # CONFIG_CRYPTO_SERPENT is not set
>> # CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
>> # CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
>> # CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
>> # CONFIG_CRYPTO_SM4 is not set
>> # CONFIG_CRYPTO_TEA is not set
>> CONFIG_CRYPTO_TWOFISH=m
>> CONFIG_CRYPTO_TWOFISH_COMMON=y
>> CONFIG_CRYPTO_TWOFISH_X86_64=y
>> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
>> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
>>
>> #
>> # Compression
>> #
>> CONFIG_CRYPTO_DEFLATE=m
>> # CONFIG_CRYPTO_LZO is not set
>> CONFIG_CRYPTO_842=m
>> # CONFIG_CRYPTO_LZ4 is not set
>> # CONFIG_CRYPTO_LZ4HC is not set
>> CONFIG_CRYPTO_ZSTD=m
>>
>> #
>> # Random Number Generation
>> #
>> # CONFIG_CRYPTO_ANSI_CPRNG is not set
>> CONFIG_CRYPTO_DRBG_MENU=y
>> CONFIG_CRYPTO_DRBG_HMAC=y
>> # CONFIG_CRYPTO_DRBG_HASH is not set
>> # CONFIG_CRYPTO_DRBG_CTR is not set
>> CONFIG_CRYPTO_DRBG=y
>> CONFIG_CRYPTO_JITTERENTROPY=y
>> CONFIG_CRYPTO_USER_API=m
>> # CONFIG_CRYPTO_USER_API_HASH is not set
>> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
>> CONFIG_CRYPTO_USER_API_RNG=m
>> # CONFIG_CRYPTO_USER_API_AEAD is not set
>> # CONFIG_CRYPTO_STATS is not set
>> CONFIG_CRYPTO_HASH_INFO=y
>> CONFIG_CRYPTO_HW=y
>> CONFIG_CRYPTO_DEV_PADLOCK=y
>> CONFIG_CRYPTO_DEV_PADLOCK_AES=y
>> CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
>> # CONFIG_CRYPTO_DEV_CCP is not set
>> CONFIG_CRYPTO_DEV_QAT=y
>> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
>> CONFIG_CRYPTO_DEV_QAT_C3XXX=m
>> CONFIG_CRYPTO_DEV_QAT_C62X=y
>> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
>> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
>> CONFIG_CRYPTO_DEV_QAT_C62XVF=m
>> CONFIG_CRYPTO_DEV_VIRTIO=m
>> CONFIG_ASYMMETRIC_KEY_TYPE=y
>> # CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set
>> # CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
>>
>> #
>> # Certificates for signature checking
>> #
>> CONFIG_SYSTEM_TRUSTED_KEYRING=y
>> CONFIG_SYSTEM_TRUSTED_KEYS=""
>> CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
>> CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
>> CONFIG_SECONDARY_TRUSTED_KEYRING=y
>> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
>> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
>>
>> #
>> # Library routines
>> #
>> CONFIG_RAID6_PQ=y
>> CONFIG_RAID6_PQ_BENCHMARK=y
>> CONFIG_BITREVERSE=y
>> CONFIG_RATIONAL=y
>> CONFIG_GENERIC_STRNCPY_FROM_USER=y
>> CONFIG_GENERIC_STRNLEN_USER=y
>> CONFIG_GENERIC_NET_UTILS=y
>> CONFIG_GENERIC_FIND_FIRST_BIT=y
>> CONFIG_GENERIC_PCI_IOMAP=y
>> CONFIG_GENERIC_IOMAP=y
>> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
>> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
>> CONFIG_CRC_CCITT=m
>> CONFIG_CRC16=y
>> CONFIG_CRC_T10DIF=y
>> CONFIG_CRC_ITU_T=y
>> CONFIG_CRC32=y
>> CONFIG_CRC32_SELFTEST=m
>> CONFIG_CRC32_SLICEBY8=y
>> # CONFIG_CRC32_SLICEBY4 is not set
>> # CONFIG_CRC32_SARWATE is not set
>> # CONFIG_CRC32_BIT is not set
>> # CONFIG_CRC64 is not set
>> CONFIG_CRC4=y
>> CONFIG_CRC7=m
>> CONFIG_LIBCRC32C=y
>> # CONFIG_CRC8 is not set
>> CONFIG_XXHASH=y
>> # CONFIG_RANDOM32_SELFTEST is not set
>> CONFIG_842_COMPRESS=m
>> CONFIG_842_DECOMPRESS=m
>> CONFIG_ZLIB_INFLATE=y
>> CONFIG_ZLIB_DEFLATE=y
>> CONFIG_LZO_COMPRESS=y
>> CONFIG_LZO_DECOMPRESS=y
>> CONFIG_LZ4_DECOMPRESS=m
>> CONFIG_ZSTD_COMPRESS=y
>> CONFIG_ZSTD_DECOMPRESS=y
>> CONFIG_XZ_DEC=y
>> CONFIG_XZ_DEC_X86=y
>> CONFIG_XZ_DEC_POWERPC=y
>> CONFIG_XZ_DEC_IA64=y
>> CONFIG_XZ_DEC_ARM=y
>> CONFIG_XZ_DEC_ARMTHUMB=y
>> # CONFIG_XZ_DEC_SPARC is not set
>> CONFIG_XZ_DEC_BCJ=y
>> CONFIG_XZ_DEC_TEST=m
>> CONFIG_DECOMPRESS_GZIP=y
>> CONFIG_DECOMPRESS_BZIP2=y
>> CONFIG_DECOMPRESS_XZ=y
>> CONFIG_DECOMPRESS_LZO=y
>> CONFIG_GENERIC_ALLOCATOR=y
>> CONFIG_INTERVAL_TREE=y
>> CONFIG_XARRAY_MULTI=y
>> CONFIG_ASSOCIATIVE_ARRAY=y
>> CONFIG_HAS_IOMEM=y
>> CONFIG_HAS_IOPORT_MAP=y
>> CONFIG_HAS_DMA=y
>> CONFIG_NEED_SG_DMA_LENGTH=y
>> CONFIG_NEED_DMA_MAP_STATE=y
>> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
>> CONFIG_SWIOTLB=y
>> # CONFIG_DMA_API_DEBUG is not set
>> CONFIG_SGL_ALLOC=y
>> CONFIG_IOMMU_HELPER=y
>> CONFIG_CHECK_SIGNATURE=y
>> CONFIG_CPUMASK_OFFSTACK=y
>> CONFIG_CPU_RMAP=y
>> CONFIG_DQL=y
>> CONFIG_NLATTR=y
>> CONFIG_CLZ_TAB=y
>> # CONFIG_CORDIC is not set
>> # CONFIG_DDR is not set
>> CONFIG_IRQ_POLL=y
>> CONFIG_MPILIB=y
>> CONFIG_OID_REGISTRY=y
>> CONFIG_FONT_SUPPORT=y
>> CONFIG_FONT_8x16=y
>> CONFIG_FONT_AUTOSELECT=y
>> CONFIG_SG_POOL=y
>> CONFIG_ARCH_HAS_PMEM_API=y
>> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
>> CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
>> CONFIG_STACKDEPOT=y
>> CONFIG_SBITMAP=y
>> # CONFIG_STRING_SELFTEST is not set
>>
>> #
>> # Kernel hacking
>> #
>>
>> #
>> # printk and dmesg options
>> #
>> CONFIG_PRINTK_TIME=y
>> # CONFIG_PRINTK_CALLER is not set
>> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
>> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
>> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
>> # CONFIG_BOOT_PRINTK_DELAY is not set
>> CONFIG_DYNAMIC_DEBUG=y
>>
>> #
>> # Compile-time checks and compiler options
>> #
>> CONFIG_DEBUG_INFO=y
>> CONFIG_DEBUG_INFO_REDUCED=y
>> # CONFIG_DEBUG_INFO_SPLIT is not set
>> # CONFIG_DEBUG_INFO_DWARF4 is not set
>> # CONFIG_GDB_SCRIPTS is not set
>> CONFIG_ENABLE_MUST_CHECK=y
>> CONFIG_FRAME_WARN=2048
>> # CONFIG_STRIP_ASM_SYMS is not set
>> # CONFIG_READABLE_ASM is not set
>> # CONFIG_UNUSED_SYMBOLS is not set
>> CONFIG_DEBUG_FS=y
>> CONFIG_HEADERS_CHECK=y
>> CONFIG_DEBUG_SECTION_MISMATCH=y
>> # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>> CONFIG_FRAME_POINTER=y
>> CONFIG_STACK_VALIDATION=y
>> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>> CONFIG_MAGIC_SYSRQ=y
>> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
>> CONFIG_MAGIC_SYSRQ_SERIAL=y
>> CONFIG_DEBUG_KERNEL=y
>>
>> #
>> # Memory Debugging
>> #
>> CONFIG_PAGE_EXTENSION=y
>> # CONFIG_DEBUG_PAGEALLOC is not set
>> CONFIG_PAGE_OWNER=y
>> CONFIG_PAGE_POISONING=y
>> CONFIG_PAGE_POISONING_NO_SANITY=y
>> CONFIG_PAGE_POISONING_ZERO=y
>> # CONFIG_DEBUG_RODATA_TEST is not set
>> CONFIG_DEBUG_OBJECTS=y
>> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
>> # CONFIG_DEBUG_OBJECTS_FREE is not set
>> CONFIG_DEBUG_OBJECTS_TIMERS=y
>> CONFIG_DEBUG_OBJECTS_WORK=y
>> # CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
>> # CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
>> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
>> CONFIG_DEBUG_SLAB=y
>> # CONFIG_DEBUG_SLAB_LEAK is not set
>> CONFIG_HAVE_DEBUG_KMEMLEAK=y
>> # CONFIG_DEBUG_KMEMLEAK is not set
>> CONFIG_DEBUG_STACK_USAGE=y
>> # CONFIG_DEBUG_VM is not set
>> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
>> CONFIG_DEBUG_VIRTUAL=y
>> CONFIG_DEBUG_MEMORY_INIT=y
>> CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
>> CONFIG_DEBUG_PER_CPU_MAPS=y
>> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
>> CONFIG_DEBUG_STACKOVERFLOW=y
>> CONFIG_HAVE_ARCH_KASAN=y
>> CONFIG_CC_HAS_KASAN_GENERIC=y
>> CONFIG_KASAN_STACK=1
>> CONFIG_ARCH_HAS_KCOV=y
>> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
>> CONFIG_KCOV=y
>> CONFIG_KCOV_INSTRUMENT_ALL=y
>> # CONFIG_DEBUG_SHIRQ is not set
>>
>> #
>> # Debug Lockups and Hangs
>> #
>> CONFIG_LOCKUP_DETECTOR=y
>> CONFIG_SOFTLOCKUP_DETECTOR=y
>> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
>> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
>> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
>> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
>> CONFIG_HARDLOCKUP_DETECTOR=y
>> # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
>> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
>> # CONFIG_DETECT_HUNG_TASK is not set
>> # CONFIG_WQ_WATCHDOG is not set
>> CONFIG_PANIC_ON_OOPS=y
>> CONFIG_PANIC_ON_OOPS_VALUE=1
>> CONFIG_PANIC_TIMEOUT=0
>> CONFIG_SCHED_DEBUG=y
>> # CONFIG_SCHEDSTATS is not set
>> CONFIG_SCHED_STACK_END_CHECK=y
>> # CONFIG_DEBUG_TIMEKEEPING is not set
>>
>> #
>> # Lock Debugging (spinlocks, mutexes, etc...)
>> #
>> CONFIG_LOCK_DEBUGGING_SUPPORT=y
>> # CONFIG_PROVE_LOCKING is not set
>> # CONFIG_LOCK_STAT is not set
>> CONFIG_DEBUG_RT_MUTEXES=y
>> CONFIG_DEBUG_SPINLOCK=y
>> CONFIG_DEBUG_MUTEXES=y
>> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
>> # CONFIG_DEBUG_RWSEMS is not set
>> CONFIG_DEBUG_LOCK_ALLOC=y
>> CONFIG_LOCKDEP=y
>> # CONFIG_DEBUG_LOCKDEP is not set
>> CONFIG_DEBUG_ATOMIC_SLEEP=y
>> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
>> CONFIG_LOCK_TORTURE_TEST=m
>> CONFIG_WW_MUTEX_SELFTEST=y
>> CONFIG_STACKTRACE=y
>> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
>> # CONFIG_DEBUG_KOBJECT is not set
>> # CONFIG_DEBUG_KOBJECT_RELEASE is not set
>> CONFIG_DEBUG_BUGVERBOSE=y
>> CONFIG_DEBUG_LIST=y
>> # CONFIG_DEBUG_PI_LIST is not set
>> CONFIG_DEBUG_SG=y
>> CONFIG_DEBUG_NOTIFIERS=y
>> CONFIG_DEBUG_CREDENTIALS=y
>>
>> #
>> # RCU Debugging
>> #
>> CONFIG_TORTURE_TEST=m
>> CONFIG_RCU_PERF_TEST=m
>> CONFIG_RCU_TORTURE_TEST=m
>> CONFIG_RCU_CPU_STALL_TIMEOUT=21
>> # CONFIG_RCU_TRACE is not set
>> # CONFIG_RCU_EQS_DEBUG is not set
>> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
>> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
>> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
>> CONFIG_NOTIFIER_ERROR_INJECTION=y
>> CONFIG_PM_NOTIFIER_ERROR_INJECT=m
>> # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
>> # CONFIG_FAULT_INJECTION is not set
>> # CONFIG_LATENCYTOP is not set
>> CONFIG_USER_STACKTRACE_SUPPORT=y
>> CONFIG_HAVE_FUNCTION_TRACER=y
>> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
>> CONFIG_HAVE_DYNAMIC_FTRACE=y
>> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
>> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
>> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
>> CONFIG_HAVE_FENTRY=y
>> CONFIG_HAVE_C_RECORDMCOUNT=y
>> CONFIG_TRACING_SUPPORT=y
>> # CONFIG_FTRACE is not set
>> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
>> CONFIG_RUNTIME_TESTING_MENU=y
>> # CONFIG_LKDTM is not set
>> # CONFIG_TEST_LIST_SORT is not set
>> # CONFIG_TEST_SORT is not set
>> # CONFIG_BACKTRACE_SELF_TEST is not set
>> # CONFIG_RBTREE_TEST is not set
>> # CONFIG_INTERVAL_TREE_TEST is not set
>> # CONFIG_PERCPU_TEST is not set
>> CONFIG_ATOMIC64_SELFTEST=m
>> # CONFIG_TEST_HEXDUMP is not set
>> # CONFIG_TEST_STRING_HELPERS is not set
>> # CONFIG_TEST_KSTRTOX is not set
>> CONFIG_TEST_PRINTF=m
>> CONFIG_TEST_BITMAP=y
>> # CONFIG_TEST_BITFIELD is not set
>> # CONFIG_TEST_UUID is not set
>> # CONFIG_TEST_XARRAY is not set
>> # CONFIG_TEST_OVERFLOW is not set
>> # CONFIG_TEST_RHASHTABLE is not set
>> # CONFIG_TEST_HASH is not set
>> # CONFIG_TEST_IDA is not set
>> # CONFIG_TEST_LKM is not set
>> # CONFIG_TEST_VMALLOC is not set
>> CONFIG_TEST_USER_COPY=m
>> # CONFIG_TEST_BPF is not set
>> # CONFIG_FIND_BIT_BENCHMARK is not set
>> CONFIG_TEST_FIRMWARE=y
>> # CONFIG_TEST_SYSCTL is not set
>> # CONFIG_TEST_UDELAY is not set
>> CONFIG_TEST_STATIC_KEYS=m
>> # CONFIG_TEST_KMOD is not set
>> # CONFIG_TEST_DEBUG_VIRTUAL is not set
>> # CONFIG_TEST_MEMCAT_P is not set
>> # CONFIG_TEST_STACKINIT is not set
>> # CONFIG_MEMTEST is not set
>> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
>> # CONFIG_SAMPLES is not set
>> CONFIG_HAVE_ARCH_KGDB=y
>> # CONFIG_KGDB is not set
>> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
>> # CONFIG_UBSAN is not set
>> CONFIG_UBSAN_ALIGNMENT=y
>> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
>> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
>> CONFIG_X86_VERBOSE_BOOTUP=y
>> # CONFIG_EARLY_PRINTK is not set
>> CONFIG_X86_PTDUMP_CORE=y
>> # CONFIG_X86_PTDUMP is not set
>> CONFIG_DEBUG_WX=y
>> # CONFIG_DOUBLEFAULT is not set
>> CONFIG_DEBUG_TLBFLUSH=y
>> # CONFIG_IOMMU_DEBUG is not set
>> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
>> CONFIG_IO_DELAY_TYPE_0X80=0
>> CONFIG_IO_DELAY_TYPE_0XED=1
>> CONFIG_IO_DELAY_TYPE_UDELAY=2
>> CONFIG_IO_DELAY_TYPE_NONE=3
>> CONFIG_IO_DELAY_0X80=y
>> # CONFIG_IO_DELAY_0XED is not set
>> # CONFIG_IO_DELAY_UDELAY is not set
>> # CONFIG_IO_DELAY_NONE is not set
>> CONFIG_DEFAULT_IO_DELAY_TYPE=0
>> # CONFIG_DEBUG_BOOT_PARAMS is not set
>> # CONFIG_CPA_DEBUG is not set
>> CONFIG_OPTIMIZE_INLINING=y
>> CONFIG_DEBUG_ENTRY=y
>> CONFIG_DEBUG_NMI_SELFTEST=y
>> CONFIG_X86_DEBUG_FPU=y
>> CONFIG_PUNIT_ATOM_DEBUG=y
>> # CONFIG_UNWINDER_ORC is not set
>> CONFIG_UNWINDER_FRAME_POINTER=y
>> #!/bin/sh
>>
>> export_top_env()
>> {
>> 	export suite='locktorture'
>> 	export testcase='locktorture'
>> 	export category='functional'
>> 	export need_modules=true
>> 	export need_memory='300MB'
>> 	export runtime=300
>> 	export job_origin='/lkp/lkp/src/allot/rand/vm-snb-2G/locktorture.yaml'
>> 	export queue_cmdline_keys='branch
>> commit'
>> 	export queue='validate'
>> 	export testbox='vm-snb-2G-162'
>> 	export tbox_group='vm-snb-2G'
>> 	export branch='rcu/dev.2019.04.24b'
>> 	export commit='2ce62cbf3ebf647d3ef3640969b81e8b0b9466ad'
>> 	export kconfig='x86_64-randconfig-g2-201917'
>> 	export repeat_to=4
>> 	export submit_id='5ccc63700b9a93ab86cd6a57'
>> 	export job_file='/lkp/jobs/scheduled/vm-snb-2G-162/locktorture-300s-cpuhotplug-debian-x86_64-2018-04-03.cgz-2ce62cbf3e-20190503-43910-y0r3er-3.yaml'
>> 	export id='3b0ec78be026fe5e9064bcc7b5eb38d5dacdf042'
>> 	export queuer_version='/lkp/lkp/.src-20190430-194821'
>> 	export arch='x86_64'
>> 	export need_kconfig='CONFIG_LOCK_TORTURE_TEST=m
>> CONFIG_KVM_GUEST=y'
>> 	export ssh_base_port=23108
>> 	export compiler='gcc-7'
>> 	export rootfs='debian-x86_64-2018-04-03.cgz'
>> 	export enqueue_time='2019-05-03 23:51:17 +0800'
>> 	export _id='5ccc63750b9a93ab86cd6a58'
>> 	export _rt='/result/locktorture/300s-cpuhotplug/vm-snb-2G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-g2-201917/gcc-7/2ce62cbf3ebf647d3ef3640969b81e8b0b9466ad'
>> 	export user='lkp'
>> 	export result_root='/result/locktorture/300s-cpuhotplug/vm-snb-2G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-g2-201917/gcc-7/2ce62cbf3ebf647d3ef3640969b81e8b0b9466ad/3'
>> 	export scheduler_version='/lkp/lkp/.src-20190430-194821'
>> 	export LKP_SERVER='inn'
>> 	export max_uptime=1500
>> 	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
>> 	export bootloader_append='root=/dev/ram0
>> user=lkp
>> job=/lkp/jobs/scheduled/vm-snb-2G-162/locktorture-300s-cpuhotplug-debian-x86_64-2018-04-03.cgz-2ce62cbf3e-20190503-43910-y0r3er-3.yaml
>> ARCH=x86_64
>> kconfig=x86_64-randconfig-g2-201917
>> branch=rcu/dev.2019.04.24b
>> commit=2ce62cbf3ebf647d3ef3640969b81e8b0b9466ad
>> BOOT_IMAGE=/pkg/linux/x86_64-randconfig-g2-201917/gcc-7/2ce62cbf3ebf647d3ef3640969b81e8b0b9466ad/vmlinuz-5.1.0-rc1-00102-g2ce62cb
>> max_uptime=1500
>> RESULT_ROOT=/result/locktorture/300s-cpuhotplug/vm-snb-2G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-g2-201917/gcc-7/2ce62cbf3ebf647d3ef3640969b81e8b0b9466ad/3
>> LKP_SERVER=inn
>> debug
>> apic=debug
>> sysrq_always_enabled
>> rcupdate.rcu_cpu_stall_timeout=100
>> net.ifnames=0
>> printk.devkmsg=on
>> panic=-1
>> softlockup_panic=1
>> nmi_watchdog=panic
>> oops=panic
>> load_ramdisk=2
>> prompt_ramdisk=0
>> drbd.minor_count=8
>> systemd.log_level=err
>> ignore_loglevel
>> console=tty0
>> earlyprintk=ttyS0,115200
>> console=ttyS0,115200
>> vga=normal
>> rw'
>> 	export modules_initrd='/pkg/linux/x86_64-randconfig-g2-201917/gcc-7/2ce62cbf3ebf647d3ef3640969b81e8b0b9466ad/modules.cgz'
>> 	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-04-24.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz'
>> 	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
>> 	export site='inn'
>> 	export LKP_CGI_PORT=80
>> 	export LKP_CIFS_PORT=139
>> 	export schedule_notify_address=
>> 	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
>> 	export nr_cpu=2
>> 	export memory='2G'
>> 	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
>> 	export swap_partitions='/dev/vdg'
>> 	export vm_tbox_group='vm-snb-2G'
>> 	export nr_vm=220
>> 	export vm_base_id=1201
>> 	export kernel='/pkg/linux/x86_64-randconfig-g2-201917/gcc-7/2ce62cbf3ebf647d3ef3640969b81e8b0b9466ad/vmlinuz-5.1.0-rc1-00102-g2ce62cb'
>> 	export dequeue_time='2019-05-03 23:51:51 +0800'
>> 	export job_initrd='/lkp/jobs/scheduled/vm-snb-2G-162/locktorture-300s-cpuhotplug-debian-x86_64-2018-04-03.cgz-2ce62cbf3e-20190503-43910-y0r3er-3.cgz'
>>
>> 	[ -n "$LKP_SRC" ] ||
>> 	export LKP_SRC=/lkp/${user:-lkp}/src
>> }
>>
>> run_job()
>> {
>> 	echo $$ > $TMP/run-job.pid
>>
>> 	. $LKP_SRC/lib/http.sh
>> 	. $LKP_SRC/lib/job.sh
>> 	. $LKP_SRC/lib/env.sh
>>
>> 	export_top_env
>>
>> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
>> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
>> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
>> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
>> 	run_monitor $LKP_SRC/monitors/plain/watchdog
>>
>> 	run_test test='cpuhotplug' $LKP_SRC/tests/wrapper locktorture
>> }
>>
>> extract_stats()
>> {
>> 	export stats_part_begin=
>> 	export stats_part_end=
>>
>> 	$LKP_SRC/stats/wrapper locktorture
>> 	$LKP_SRC/stats/wrapper kmsg
>> 	$LKP_SRC/stats/wrapper meminfo
>>
>> 	$LKP_SRC/stats/wrapper time locktorture.time
>> 	$LKP_SRC/stats/wrapper dmesg
>> 	$LKP_SRC/stats/wrapper kmsg
>> 	$LKP_SRC/stats/wrapper last_state
>> 	$LKP_SRC/stats/wrapper stderr
>> 	$LKP_SRC/stats/wrapper time
>> }
>>
>> "$@"
>
>> 2019-05-03 15:52:48 modprobe locktorture onoff_interval=3 onoff_holdoff=30
>> 2019-05-03 15:52:48 sleep 300
>> 2019-05-03 15:57:48 rmmod locktorture
>> [   30.518614] spin_lock-torture:--- Start of test [debug]: nwriters_stress=4 nreaders_stress=0 stat_interval=60 verbose=1 shuffle_interval=3 stutter=5 shutdown_secs=0 onoff_interval=3 onoff_holdoff=30
>> [   30.522260] spin_lock-torture: Creating torture_onoff task
>> [   30.540748] spin_lock-torture: Creating torture_shuffle task
>> [   30.541983] spin_lock-torture: torture_onoff task started
>> [   30.543097] spin_lock-torture: torture_onoff begin holdoff
>> [   30.553921] spin_lock-torture: Creating torture_stutter task
>> [   30.553923] spin_lock-torture: torture_shuffle task started
>> [   30.567268] spin_lock-torture: torture_stutter task started
>> [   30.568650] spin_lock-torture: Creating lock_torture_writer task
>> [   30.573910] spin_lock-torture: Creating lock_torture_writer task
>> [   30.573917] spin_lock-torture: lock_torture_writer task started
>> [   30.583907] spin_lock-torture: Creating lock_torture_writer task
>> [   30.585367] spin_lock-torture: lock_torture_writer task started
>> [   30.593950] spin_lock-torture: Creating lock_torture_writer task
>> [   30.593961] spin_lock-torture: lock_torture_writer task started
>> [   30.603926] spin_lock-torture: Creating lock_torture_stats task
>> [   30.605317] spin_lock-torture: lock_torture_writer task started
>> [   30.613950] spin_lock-torture: lock_torture_stats task started
>> [   61.860597] spin_lock-torture: torture_onoff end holdoff
