Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A228BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B26206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfCFJvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:51:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:51871 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfCFJva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:51:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 01:47:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,447,1544515200"; 
   d="gz'50?scan'50,208,50";a="131668605"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by orsmga003.jf.intel.com with ESMTP; 06 Mar 2019 01:47:22 -0800
Date:   Wed, 6 Mar 2019 17:47:36 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     David Windsor <dave@nullcore.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [LKP] ab9ee8e38b [ 1.978635] WARNING: CPU: 1 PID: 1 at
 arch/x86/mm/dump_pagetables.c:237 note_page
Message-ID: <20190306094736.GN25100@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4OpS+d6oOtUQaRm1"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4OpS+d6oOtUQaRm1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit ab9ee8e38b292f9a6698a4fedbb6ff8d08ce2012
Author:     David Windsor <dave@nullcore.net>
AuthorDate: Thu Aug 24 16:57:57 2017 -0700
Commit:     Kees Cook <keescook@chromium.org>
CommitDate: Mon Jan 15 12:08:00 2018 -0800

    sctp: Define usercopy region in SCTP proto slab cache
    
    The SCTP socket event notification subscription information need to be
    copied to/from userspace. In support of usercopy hardening, this patch
    defines a region in the struct proto slab cache in which userspace copy
    operations are allowed. Additionally moves the usercopy fields to be
    adjacent for the region to cover both.
    
    example usage trace:
    
        net/sctp/socket.c:
            sctp_getsockopt_events(...):
                ...
                copy_to_user(..., &sctp_sk(sk)->subscribe, len)
    
            sctp_setsockopt_events(...):
                ...
                copy_from_user(&sctp_sk(sk)->subscribe, ..., optlen)
    
            sctp_getsockopt_initmsg(...):
                ...
                copy_to_user(..., &sctp_sk(sk)->initmsg, len)
    
    This region is known as the slab cache's usercopy region. Slab caches
    can now check that each dynamically sized copy operation involving
    cache-managed memory falls entirely within the slab's usercopy region.
    
    This patch is modified from Brad Spengler/PaX Team's PAX_USERCOPY
    whitelisting code in the last public patch of grsecurity/PaX based on my
    understanding of the code. Changes or omissions from the original code are
    mine and don't reflect the original grsecurity/PaX code.
    
    Signed-off-by: David Windsor <dave@nullcore.net>
    [kees: split from network patch, move struct members adjacent]
    [kees: add SCTPv6 struct whitelist, provide usage trace]
    Cc: Vlad Yasevich <vyasevich@gmail.com>
    Cc: Neil Horman <nhorman@tuxdriver.com>
    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: linux-sctp@vger.kernel.org
    Cc: netdev@vger.kernel.org
    Signed-off-by: Kees Cook <keescook@chromium.org>

93070d339d  caif: Define usercopy region in caif proto slab cache
ab9ee8e38b  sctp: Define usercopy region in SCTP proto slab cache
3717f613f4  Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
baf5a9d1f9  Add linux-next specific files for 20190305
+------------------------------------------------------------------+------------+------------+------------+---------------+
|                                                                  | 93070d339d | ab9ee8e38b | 3717f613f4 | next-20190305 |
+------------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                                   | 0          | 0          | 15         | 12            |
| boot_failures                                                    | 113        | 28         | 13         | 17            |
| WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page/0x           | 113        | 28         |            |               |
| EIP:note_page                                                    | 113        | 28         |            |               |
| Mem-Info                                                         | 8          | 1          |            |               |
| EIP:__put_user_4                                                 | 2          |            |            |               |
| invoked_oom-killer:gfp_mask=0x                                   | 3          |            |            |               |
| Out_of_memory:Kill_process                                       | 1          |            |            |               |
| Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 1          |            |            |               |
| WARNING:at_drivers/pci/pci-sysfs.c:#pci_mmap_resource/0x         | 1          |            |            |               |
| EIP:pci_mmap_resource                                            | 1          |            |            |               |
| kernel_BUG_at_mm/usercopy.c                                      | 0          | 12         | 8          | 8             |
| invalid_opcode:#[##]                                             | 0          | 11         | 7          | 8             |
| EIP:usercopy_abort                                               | 0          | 11         | 9          | 11            |
| Kernel_panic-not_syncing:Fatal_exception                         | 0          | 9          | 7          | 10            |
| INFO:task_blocked_for_more_than#seconds                          | 0          | 0          | 3          | 6             |
| EIP:kvm_guest_apic_eoi_write                                     | 0          | 0          | 1          |               |
| EIP:default_idle                                                 | 0          | 0          | 1          |               |
| Kernel_panic-not_syncing:hung_task:blocked_tasks                 | 0          | 0          | 3          | 6             |
| EIP:entry_INT80_32                                               | 0          | 0          | 1          |               |
| Kernel_panic-not_syncing:F00atal_exception                       | 0          | 0          | 0          | 1             |
| EIP:ftrace_likely_update                                         | 0          | 0          | 0          | 1             |
+------------------------------------------------------------------+------------+------------+------------+---------------+

[    1.973317] Write protecting the kernel text: 13604k
[    1.974554] Write protecting the kernel read-only data: 6456k
[    1.975309] NX-protecting the kernel data: 13020k
[    1.977070] ------------[ cut here ]------------
[    1.977686] x86/mm: Found insecure W+X mapping at address e6a471ee/0xc00a0000
[    1.978635] WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:237 note_page+0xc72/0xf30
[    1.979966] Modules linked in:
[    1.980379] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2-00026-gab9ee8e #1
[    1.981347] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    1.982415] task: 86b07168 task.stack: 2d7a3635
[    1.983008] EIP: note_page+0xc72/0xf30
[    1.983498] EFLAGS: 00210286 CPU: 1
[    1.983959] EAX: 00000041 EBX: 00000000 ECX: 00000000 EDX: 00000000
[    1.984872] ESI: c012df38 EDI: 80000000 EBP: c012defc ESP: c012debc
[    1.985683]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[    1.986386] CR0: 80050033 CR2: ffffffff CR3: 02a05000 CR4: 003406b0
[    1.987195] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    1.988003] DR6: fffe0ff0 DR7: 00000400
[    1.988505] Call Trace:
[    1.988837]  ptdump_walk_pgd_level_core+0x3be/0x470
[    1.989474]  ptdump_walk_pgd_level_checkwx+0x16/0x20
[    1.990125]  mark_rodata_ro+0x109/0x140
[    1.990630]  ? rest_init+0x230/0x230
[    1.991103]  kernel_init+0x40/0x1a0
[    1.991562]  ? schedule_tail_wrapper+0x9/0xc
[    1.992213]  ? rest_init+0x230/0x230
[    1.992696]  ret_from_fork+0x19/0x24
[    1.993185] Code: c2 01 c7 04 24 01 00 00 00 e8 bb d0 16 00 8b 46 0c ff 05 8c 7d 50 c2 89 44 24 08 89 44 24 04 c7 04 24 88 fd 25 c2 e8 6e 11 01 00 <0f> ff 31 c9 ba 01 00 00 00 b8 38 df 48 c2 c7 04 24 01 00 00 00
[    1.995747] ---[ end trace 303490e4e1917754 ]---
[    1.998068] x86/mm: Checked W+X mappings: FAILED, 96 W+X pages found.

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.16 v4.15 --
git bisect  bad 1388c80438e69fc01d83fbe98da3cac24c3c8731  # 10:59  B      1     1    1   1  Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 4bf772b14675411a69b3c807f73006de0fe4b649  # 11:23  G     28     0   28  28  Merge tag 'drm-for-v4.16' of git://people.freedesktop.org/~airlied/linux
git bisect  bad 7e6127c1240ed569cdda2a67c8f03836f9f28c05  # 11:44  B      3    11    3   3  Merge tag 'linux-watchdog-4.16-rc1' of git://www.linux-watchdog.org/linux-watchdog
git bisect  bad 567af7fc9d87df3228ef59864f77fe100ec0cee3  # 12:01  B      0     2   17   0  pinctrl: files should directly include apis they use
git bisect good 1726aa70e7e2f8967d60b4f836723b61f97db73e  # 12:17  G     27     0   27  27  Merge branch 'fixes-v4.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect  bad 4141cf676b9e345d3ddeb1710dd3156a09c50244  # 12:39  B      2     6    2   2  Merge branch 'i2c/for-4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good 0771ad44a20bc512d1123bac728d3a89ea6febe6  # 12:53  G     28     0   28  28  Merge tag 'pstore-v4.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect  bad 617aebe6a97efa539cc4b8a52adccd89596e6be0  # 13:10  B      4     7    4   4  Merge tag 'usercopy-v4.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good df5f3cfc52fec828af92444bf02ad8fd4e4c59e3  # 13:36  G     28     0   28  28  ufs: Define usercopy region in ufs_inode_cache slab cache
git bisect  bad 07dcd7fe89938934ddad65f738bc5aac89b8e54d  # 13:59  B      0     5   20   0  fork: Define usercopy region in mm_struct slab caches
git bisect good 8c2bc895a9347846b33c47124a75db624aa83677  # 14:10  G     28     0   28  28  ip: Define usercopy region in IP proto slab cache
git bisect  bad ab9ee8e38b292f9a6698a4fedbb6ff8d08ce2012  # 14:22  B      1     3    1   1  sctp: Define usercopy region in SCTP proto slab cache
git bisect good 93070d339d7bc6f6b07b64faf5134fd144e8ec48  # 14:38  G     28     0   28  28  caif: Define usercopy region in caif proto slab cache
# first bad commit: [ab9ee8e38b292f9a6698a4fedbb6ff8d08ce2012] sctp: Define usercopy region in SCTP proto slab cache
git bisect good 93070d339d7bc6f6b07b64faf5134fd144e8ec48  # 14:42  G     81     0   81 109  caif: Define usercopy region in caif proto slab cache
# extra tests with debug options
git bisect  bad ab9ee8e38b292f9a6698a4fedbb6ff8d08ce2012  # 14:50  B      0     1   16   0  sctp: Define usercopy region in SCTP proto slab cache
# extra tests on HEAD of linux-devel/devel-hourly-2019030523
git bisect  bad ceb3e480165118da2ede5eb7dfaf922ce034dec0  # 14:50  B      9     3    0   3  0day head guard for 'devel-hourly-2019030523'
# extra tests on tree/branch linus/master
git bisect  bad 3717f613f48df0222311f974cf8a06c8a6c97bae  # 15:05  B      0     1   16   0  Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# extra tests on tree/branch linux-next/master
git bisect  bad baf5a9d1f9b95eb97e9eb54932e20dbbf814771c  # 15:50  B     17    11    7   7  Add linux-next specific files for 20190305

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--4OpS+d6oOtUQaRm1
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-107:20190306142158:i386-randconfig-b0-03060220:4.15.0-rc2-00026-gab9ee8e:1.gz"
Content-Transfer-Encoding: base64

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
/tXtzaBfNSJckJc4Ts+PB1dLqYQLtFMootol1M42lhvwMg0U1QaPshHoVGBraNYbzGhZgIIh
jNqy0iuWYAHOGBEIyKUg/Z868/VZ/+Tzp66wlmQs0a7meXM2yZzHKYYdaGJwLyDjhX6qpdha
Y0wkLZNJluPhpXT0ctxHPNpsgjKKFmgGf5Rhhr0VMR6umGabWxmEu5QXv5o2wHnDVFPRddPa
yhjIZghZtiVN/PIs5rZAmvZdpJW6MH4MMcIjI5gv5mSmMLQbHF2LvVHG2Bt8pu18l4cuVyUr
osP58DFyCwyIZT6KCQR6vCGeoTnGyhxA/6mgjBbqvebtWjgM2MbV8cnl4OoTDK7bMv1188cG
FjoXTB5mQoLJLgL0OXEqUQBNtT7cYzEUTgqyTrE4N7ZB6tjaVulqjArEKF+YbhkztBQMkNv/
JE8toG/K0aFbRT1X4FgcpMMfZzjfuhunHHBTYcbLyKpE1pQlsvIyMkYS7GVkrS6z9jKyqtQK
eTuR9Tqy/l7IRh3ZkMjsbyObdWTzvWS26sjWeyHbdWT7vZCdOrLzXnpmSmOpKO+G3VyG7N2w
1Qa2+l7aZo2lyN5tLbLGYmTvthpZYzky47XYm8aXmXus7y5a6w209htondfTqvt2i1207A20
6htotedpO53bwbB/04UHfJxgaEpbCPGzngBgPVVcqpTdxWv6rmMUudfF8ZNHqVE6R++YCtqY
85/rWLrOc4qe9zSTkazPI5fcuySFVn4fUlnnQB4JL8hDLzG6Bt2wnQ4q6SSZJcPBaAytKP2r
5zDL1jW1MWvS0J+gt9NdnoHpCrcX5rjXz8t5FzRlsxOqotOpqzIunsnEiUNCy0QcBuwCsJaG
Y+hRKhWUeKfm7+Lp6FaI2KsLo+ULI6NVemJw1t0oVDBTIW/lks7cyxR4eHt5sm5QvzihdtSh
+NLpa4PXYs4Wr/8S7yGwT1sQlqnqqzcSypjKcyI4J/eqqrgtU0Jt+umKty/W57iYY2movNvx
KYK4vjgPXogjSvXgT5U5kVXhEPWjdKksinILb3ytota5mz/yCCPUVuDOw2ghzjkdCn8zot+a
d4hRPReyinODB/VmRjwTVc/Y49AnZzin7uXyDSZ6k8cUwbFABJOWPIyGn6tDWIciMn50USjh
SOfoq0aLTr2NreTL+Lnsi6qhnkTfu3BC73yQjssUfWxc4j4d5xQZDoy21iy6RSNDQrJGBG87
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
AAA=

--4OpS+d6oOtUQaRm1
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-101:20190306143947:i386-randconfig-b0-03060220:4.15.0-rc2-00025-g93070d3:2.gz"
Content-Transfer-Encoding: base64

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

--4OpS+d6oOtUQaRm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vm-yocto-107:20190306142158:i386-randconfig-b0-03060220:4.15.0-rc2-00026-gab9ee8e:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

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

--4OpS+d6oOtUQaRm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.15.0-rc2-00026-gab9ee8e"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.15.0-rc2 Kernel Configuration
#
# CONFIG_64BIT is not set
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
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
CONFIG_KERNEL_LZMA=y
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
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
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

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FAST_NO_HZ=y
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_DEBUG_BLK_CGROUP=y
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
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
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
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
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_SLUB_DEBUG is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_THIN_ARCHIVES=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
# CONFIG_HAVE_ARCH_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_AUTODETECT=y
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_LBDAF is not set
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
# CONFIG_BLK_WBT_MQ is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
CONFIG_ACORN_PARTITION_POWERTEC=y
CONFIG_ACORN_PARTITION_RISCIX=y
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_CMDLINE_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CFQ_GROUP_IOSCHED is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=m
CONFIG_BFQ_GROUP_IOSCHED=y
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
CONFIG_FREEZER=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
# CONFIG_X86_MPPARSE is not set
CONFIG_X86_BIGSMP=y
CONFIG_GOLDFISH=y
# CONFIG_INTEL_RDT is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
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
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_MVIAC7=y
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=m
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_X86_16BIT is not set
CONFIG_TOSHIBA=m
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_NUMA is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_ARCH_WANTS_THP_SWAP is not set
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
CONFIG_ZPOOL=m
CONFIG_ZBUD=m
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=m
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=m
# CONFIG_DPTF_POWER is not set
CONFIG_PMIC_OPREGION=y
# CONFIG_XPOWER_PMIC_OPREGION is not set
CONFIG_CHT_DC_TI_PMIC_OPREGION=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_SFI is not set
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
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
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
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=y
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
# CONFIG_INET_ESP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=y
# CONFIG_NF_CONNTRACK is not set
CONFIG_NF_LOG_COMMON=y
# CONFIG_NF_LOG_NETDEV is not set
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=m

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
CONFIG_NETFILTER_XT_TARGET_HL=m
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
# CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
CONFIG_NETFILTER_XT_MATCH_ESP=m
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
CONFIG_NETFILTER_XT_MATCH_REALM=m
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_DEBUG=y
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
# CONFIG_IP_VS_PROTO_UDP is not set
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
# CONFIG_IP_VS_PROTO_SCTP is not set

#
# IPVS scheduler
#
# CONFIG_IP_VS_RR is not set
# CONFIG_IP_VS_WRR is not set
# CONFIG_IP_VS_LC is not set
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
# CONFIG_IP_VS_LBLC is not set
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
# CONFIG_IP_VS_NQ is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS application helper
#

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=m
# CONFIG_NF_REJECT_IPV4 is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_AH is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_RPFILTER is not set
CONFIG_IP_NF_MATCH_TTL=m
# CONFIG_IP_NF_FILTER is not set
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_ARPTABLES is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=y
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
# CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
# CONFIG_L2TP_DEBUGFS is not set
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=m
CONFIG_NET_DSA_TAG_BRCM=y
CONFIG_NET_DSA_TAG_BRCM_PREPEND=y
CONFIG_NET_DSA_TAG_DSA=y
CONFIG_NET_DSA_TAG_EDSA=y
CONFIG_NET_DSA_TAG_LAN9303=y
CONFIG_NET_DSA_TAG_MTK=y
CONFIG_NET_DSA_TAG_QCA=y
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
# CONFIG_VLAN_8021Q_MVRP is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
CONFIG_IPDDP=m
# CONFIG_IPDDP_ENCAP is not set
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_PHONET=y
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
# CONFIG_MAC802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
CONFIG_BATMAN_ADV=m
# CONFIG_BATMAN_ADV_BATMAN_V is not set
# CONFIG_BATMAN_ADV_BLA is not set
# CONFIG_BATMAN_ADV_DAT is not set
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_MCAST is not set
# CONFIG_BATMAN_ADV_DEBUGFS is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
# CONFIG_NET_MPLS_GSO is not set
CONFIG_MPLS_ROUTING=y
# CONFIG_MPLS_IPTUNNEL is not set
CONFIG_NET_NSH=m
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=m
# CONFIG_CAN_GW is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
# CONFIG_CAN_CALC_BITTIMING is not set
# CONFIG_CAN_LEDS is not set
CONFIG_CAN_GRCAN=m
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
CONFIG_CAN_IFI_CANFD=m
CONFIG_CAN_M_CAN=m
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_SJA1000_ISA=m
CONFIG_CAN_SJA1000_PLATFORM=m
# CONFIG_CAN_EMS_PCI is not set
# CONFIG_CAN_PEAK_PCI is not set
# CONFIG_CAN_KVASER_PCI is not set
# CONFIG_CAN_PLX_PCI is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=m
CONFIG_CAN_MCP251X=m

#
# CAN USB interfaces
#
CONFIG_CAN_EMS_USB=m
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_PEAK_USB=m
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_MCBA_USB=m
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=m
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
# CONFIG_CAIF_NETDEV is not set
CONFIG_CAIF_USB=y
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_SPI=m
# CONFIG_NFC_NCI_UART is not set
CONFIG_NFC_HCI=m
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=m
CONFIG_NFC_SIM=m
CONFIG_NFC_PORT100=m
# CONFIG_NFC_FDP is not set
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
CONFIG_NFC_ST_NCI_SPI=m
# CONFIG_NFC_NXP_NCI is not set
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
CONFIG_NFC_ST95HF=m
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=m
CONFIG_MAY_USE_DEVLINK=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
CONFIG_CONNECTOR=m
CONFIG_MTD=m
CONFIG_MTD_TESTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_OF_PARTS=m
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=m
CONFIG_RFD_FTL=m
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=m
CONFIG_MTD_SWAP=m
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
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_SBC_GXX=m
CONFIG_MTD_SCx200_DOCFLASH=m
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_GPIO_ADDR is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=m
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
CONFIG_MTD_DATAFLASH_OTP=y
# CONFIG_MTD_M25P80 is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_NAND_ECC=m
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_BCH=m
CONFIG_MTD_NAND_ECC_BCH=y
# CONFIG_MTD_SM_COMMON is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=m
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
# CONFIG_MTD_NAND_DOCG4 is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=m
CONFIG_MTD_NAND_NANDSIM=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_ONENAND=m
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=m
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_MT81xx_NOR=m
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
# CONFIG_SPI_INTEL_SPI_PCI is not set
# CONFIG_SPI_INTEL_SPI_PLATFORM is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_MTD_UBI_BLOCK=y
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_ADDRESS_PCI=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_PCI=y
CONFIG_OF_PCI_IRQ=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_BLK_SCSI=y
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
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_FCLOOP is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=m
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_C2PORT=m
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
# CONFIG_ALTERA_STAPL is not set
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
CONFIG_VHOST_RING=y
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
# CONFIG_IDE_GD is not set
# CONFIG_BLK_DEV_DELKIN is not set
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=m
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=m
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPNP=m

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
# CONFIG_BLK_DEV_IDEDMA is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
CONFIG_SCSI_FC_ATTRS=m
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=y
CONFIG_SCSI_OSD_ULD=y
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_CEVA=m
CONFIG_AHCI_QORIQ=m
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
CONFIG_PATA_PLATFORM=m
CONFIG_PATA_OF_PLATFORM=m
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
CONFIG_BCACHE_CLOSURES_DEBUG=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_MQ_DEFAULT is not set
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
CONFIG_DM_THIN_PROVISIONING=m
# CONFIG_DM_CACHE is not set
CONFIG_DM_ERA=m
CONFIG_DM_MIRROR=m
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=m
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
# CONFIG_DM_VERITY is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
CONFIG_ATM_TCP=m
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# CAIF transport drivers
#
# CONFIG_CAIF_TTY is not set
CONFIG_CAIF_SPI_SLAVE=y
CONFIG_CAIF_SPI_SYNC=y
# CONFIG_CAIF_HSI is not set
CONFIG_CAIF_VIRTIO=y

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
CONFIG_B53_SPI_DRIVER=m
CONFIG_B53_MDIO_DRIVER=m
CONFIG_B53_MMAP_DRIVER=m
# CONFIG_B53_SRAB_DRIVER is not set
CONFIG_NET_DSA_BCM_SF2=m
# CONFIG_NET_DSA_LOOP is not set
CONFIG_NET_DSA_MT7530=m
# CONFIG_NET_DSA_MV88E6060 is not set
# CONFIG_MICROCHIP_KSZ is not set
CONFIG_NET_DSA_MV88E6XXX=m
CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=y
CONFIG_NET_DSA_QCA8K=m
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
CONFIG_ETHERNET=y
CONFIG_MDIO=m
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
# CONFIG_AMD_XGBE_HAVE_ECC is not set
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
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
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
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
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
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_MVNETA_BM is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
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
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
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
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
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
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
CONFIG_MDIO_GPIO=m
CONFIG_MDIO_HISI_FEMAC=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AT803X_PHY=y
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
CONFIG_DP83822_PHY=m
CONFIG_DP83848_PHY=m
CONFIG_DP83867_PHY=m
CONFIG_FIXED_PHY=y
# CONFIG_ICPLUS_PHY is not set
CONFIG_INTEL_XWAY_PHY=m
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=m
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=y
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=m
CONFIG_RENESAS_PHY=m
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=m
# CONFIG_VITESSE_PHY is not set
CONFIG_XILINX_GMII2RGMII=y
CONFIG_MICREL_KS8995MA=y
CONFIG_PLIP=m
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_MPPE is not set
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPPOATM=m
# CONFIG_PPPOE is not set
CONFIG_PPPOL2TP=m
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=y
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=y
CONFIG_USB_LAN78XX=y
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=y
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
CONFIG_USB_NET_SR9700=m
CONFIG_USB_NET_SR9800=m
# CONFIG_USB_NET_SMSC75XX is not set
CONFIG_USB_NET_SMSC95XX=m
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
CONFIG_USB_NET_PLUSB=m
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
# CONFIG_USB_ALI_M5632 is not set
# CONFIG_USB_AN2720 is not set
# CONFIG_USB_BELKIN is not set
CONFIG_USB_ARMLINUX=y
# CONFIG_USB_EPSON2888 is not set
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=y
# CONFIG_USB_HSO is not set
CONFIG_USB_NET_INT51X1=m
CONFIG_USB_CDC_PHONET=m
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=m
# CONFIG_USB_VL600 is not set
CONFIG_USB_NET_CH9200=y
CONFIG_WLAN=y
CONFIG_WIRELESS_WDS=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_WLAN_VENDOR_ATH is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_WLAN_VENDOR_CISCO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_WLAN_VENDOR_INTERSIL is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_WLAN_VENDOR_ST is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y

#
# WiMAX Wireless Broadband devices
#
CONFIG_WIMAX_I2400M=m
CONFIG_WIMAX_I2400M_USB=m
CONFIG_WIMAX_I2400M_DEBUG_LEVEL=8
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=y
# CONFIG_HDLC_RAW is not set
# CONFIG_HDLC_RAW_ETH is not set
# CONFIG_HDLC_CISCO is not set
CONFIG_HDLC_FR=y
CONFIG_HDLC_PPP=y

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
# CONFIG_DLCI is not set
CONFIG_LAPBETHER=m
# CONFIG_X25_ASY is not set
CONFIG_SBNI=m
# CONFIG_SBNI_MULTILINE is not set
# CONFIG_IEEE802154_DRIVERS is not set
# CONFIG_VMXNET3 is not set
CONFIG_FUJITSU_ES=m
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_DEBUG is not set
# CONFIG_NVM_RRPC is not set
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
# CONFIG_KEYBOARD_ADP5520 is not set
CONFIG_KEYBOARD_ADP5588=m
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_STMPE=y
CONFIG_KEYBOARD_OMAP4=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_KEYBOARD_CAP11XX=m
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
# CONFIG_INPUT_AD714X_SPI is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_MAX77693_HAPTIC=m
CONFIG_INPUT_MAX8997_HAPTIC=y
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=m
# CONFIG_INPUT_GPIO_TILT_POLLED is not set
CONFIG_INPUT_GPIO_DECODER=y
# CONFIG_INPUT_CPCAP_PWRBUTTON is not set
CONFIG_INPUT_WISTRON_BTNS=y
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_TWL4030_PWRBUTTON=m
# CONFIG_INPUT_TWL4030_VIBRA is not set
# CONFIG_INPUT_TWL6040_VIBRA is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=m
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA9052_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=m
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_IMS_PCU=m
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_SOC_BUTTON_ARRAY=m
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
# CONFIG_GAMEPORT is not set

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
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_FSL is not set
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
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_TPM=m
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set

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
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=m
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=m
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
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=m
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=m
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=m
CONFIG_SPI_CADENCE=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_DLN2=y
CONFIG_SPI_GPIO=m
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_PXA2XX_PCI is not set
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
# CONFIG_PPS is not set

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
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_AXP209 is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=m

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_DA9052=m
# CONFIG_GPIO_DLN2 is not set
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_STMPE is not set
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65218=m
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=m
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=m
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=m

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
CONFIG_W1=m
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=m
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=m
# CONFIG_W1_SLAVE_DS2781 is not set
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_WM8350_POWER=m
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CPCAP=m
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=y
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_CHARGER is not set
CONFIG_AXP288_FUEL_GAUGE=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_BATTERY_TWL4030_MADC=m
CONFIG_CHARGER_PCF50633=y
CONFIG_BATTERY_RX51=y
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_TWL4030 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=m
CONFIG_CHARGER_RT9455=m
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_QORIQ_THERMAL=m
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=m
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=m
# CONFIG_MFD_CROS_EC_I2C is not set
# CONFIG_MFD_CROS_EC_SPI is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_HI6421_PMIC=m
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=m
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=m
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=m
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RTSX_USB is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=m
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# CONFIG_STMPE_SPI is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=m
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=m
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_REGULATOR is not set
CONFIG_CEC_CORE=m
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
# CONFIG_IR_HIX5HD2 is not set
CONFIG_IR_IMON=m
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_FINTEK is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_SERIAL is not set
CONFIG_IR_SIR=m
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CEC_RC is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FWNODE=m
# CONFIG_TTPCI_EEPROM is not set

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_CEC_PLATFORM_DRIVERS=y
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
CONFIG_USB_DSBR=m
# CONFIG_RADIO_MAXIRADIO is not set
CONFIG_RADIO_SHARK=m
CONFIG_RADIO_SHARK2=m
CONFIG_USB_KEENE=m
CONFIG_USB_RAREMONO=y
CONFIG_USB_MA901=m
CONFIG_RADIO_TEA5764=y
CONFIG_RADIO_TEA5764_XTAL=y
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
CONFIG_RADIO_WL1273=y

#
# Texas Instruments WL128x FM driver (ST based)
#
# CONFIG_CYPRESS_FIRMWARE is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=y
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
CONFIG_VIDEO_CS3308=m
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=y
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_SONY_BTF_MPX=m

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=y
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=m
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=m
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=y
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=m

#
# Camera sensor devices
#
CONFIG_VIDEO_MT9M111=y

#
# Flash devices
#

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=y

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
# CONFIG_MEDIA_TUNER_MT20XX is not set
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
# CONFIG_MEDIA_TUNER_MT2131 is not set
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_XC2028=m
# CONFIG_MEDIA_TUNER_XC5000 is not set
# CONFIG_MEDIA_TUNER_XC4000 is not set
CONFIG_MEDIA_TUNER_MXL5005S=m
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=m
# CONFIG_MEDIA_TUNER_FC0011 is not set
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=y
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_MXL301RF=y
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set

#
# Customise DVB Frontends
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
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_CHASH is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=m
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
# CONFIG_DRM_PANEL_LG_LG4573 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
CONFIG_DRM_PANEL_SITRONIX_ST7789V=m
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_DUMB_VGA_DAC=m
CONFIG_DRM_LVDS_ENCODER=m
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NXP_PTN3460=m
CONFIG_DRM_PARADE_PS8622=m
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
CONFIG_DRM_TOSHIBA_TC358767=m
# CONFIG_DRM_TI_TFP410 is not set
CONFIG_DRM_I2C_ADV7511=m
# CONFIG_DRM_I2C_ADV7533 is not set
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_DW_HDMI=m
# CONFIG_DRM_DW_HDMI_CEC is not set
CONFIG_DRM_ARCPGU=m
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_TINYDRM=m
CONFIG_TINYDRM_MIPI_DBI=m
CONFIG_TINYDRM_MI0283QT=m
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=m
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
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
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=m
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
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
CONFIG_FB_SM501=m
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_BACKLIGHT_CLASS_DEVICE=m
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_ADP5520=m
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_AAT2870=m
CONFIG_BACKLIGHT_LM3630A=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=m
# CONFIG_BACKLIGHT_PANDORA is not set
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
# CONFIG_VGASTATE is not set
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CP2112=m
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_DJ is not set
# CONFIG_HID_LOGITECH_HIDPP is not set
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
# CONFIG_LOGIWHEELS_FF is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PENMOUNT=m
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=y
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=m
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=y

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
CONFIG_USB_MOUSE=m

#
# I2C HID support
#
CONFIG_I2C_HID=m
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
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_OTG_FSM is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_MON=m
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_MAX3421_HCD=y
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_USB_HCD_BCMA=m
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=y
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
CONFIG_USB_STORAGE_SDDR55=y
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_STORAGE_ALAUDA=y
# CONFIG_USB_STORAGE_ONETOUCH is not set
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
CONFIG_USBIP_VUDC=m
# CONFIG_USBIP_DEBUG is not set
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
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_OF=m
# CONFIG_USB_CHIPIDEA_UDC is not set
# CONFIG_USB_CHIPIDEA_ULPI is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=y
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=m
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=m
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
# CONFIG_USB_CXACRU is not set
CONFIG_USB_UEAGLEATM=m
# CONFIG_USB_XUSBATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=m
CONFIG_USB_ISP1301=m
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=m
CONFIG_USB_SNP_CORE=m
CONFIG_USB_SNP_UDC_PLAT=m
CONFIG_USB_M66592=m
CONFIG_USB_BDC_UDC=m

#
# Platform Support
#
CONFIG_USB_BDC_PCI=m
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_GADGET_XILINX is not set
CONFIG_USB_DUMMY_HCD=m
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_U_ETHER=m
CONFIG_USB_F_EEM=m
CONFIG_USB_F_RNDIS=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
CONFIG_USB_CONFIGFS_RNDIS=y
CONFIG_USB_CONFIGFS_EEM=y
# CONFIG_USB_CONFIGFS_PHONET is not set
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
CONFIG_USB_CONFIGFS_F_FS=y
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_UVC is not set
CONFIG_USB_CONFIGFS_F_PRINTER=y

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_TYPEC_TCPM is not set
# CONFIG_TYPEC_UCSI is not set
# CONFIG_TYPEC_TPS6598X is not set
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
# CONFIG_UWB_WHCI is not set
# CONFIG_UWB_I1480U is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_APU=m
CONFIG_LEDS_BCM6328=m
CONFIG_LEDS_BCM6358=m
# CONFIG_LEDS_CPCAP is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8788=m
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_CLEVO_MAIL=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=m
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=y
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=m
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
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
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_HD44780=m
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
# CONFIG_CFAG12864B is not set
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_HT16K33=m
CONFIG_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_BUS is not set
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CROS_EC_CHARDEV is not set
CONFIG_CROS_EC_LPC=m
# CONFIG_CROS_EC_LPC_MEC is not set
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set

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
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_AXP288=m
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=m
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=m
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
# CONFIG_ADXL345_SPI is not set
CONFIG_BMA180=m
CONFIG_BMA220=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
CONFIG_DA280=m
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=m
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=m
# CONFIG_KXSD9_I2C is not set
CONFIG_KXCJK1013=y
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=m
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
CONFIG_AD7266=y
CONFIG_AD7291=m
CONFIG_AD7298=y
# CONFIG_AD7476 is not set
CONFIG_AD7766=m
CONFIG_AD7791=m
# CONFIG_AD7793 is not set
CONFIG_AD7887=y
# CONFIG_AD7923 is not set
# CONFIG_AD799X is not set
CONFIG_AXP20X_ADC=y
# CONFIG_AXP288_ADC is not set
CONFIG_CPCAP_ADC=m
CONFIG_DLN2_ADC=m
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HI8435 is not set
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
CONFIG_LTC2485=y
CONFIG_LTC2497=y
CONFIG_MAX1027=y
CONFIG_MAX11100=m
# CONFIG_MAX1118 is not set
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=m
# CONFIG_MCP3422 is not set
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_TI_ADC081C=m
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC108S102=m
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=y
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7950=m
# CONFIG_TI_ADS8688 is not set
CONFIG_TI_TLC4541=m
CONFIG_TWL4030_MADC=y
CONFIG_TWL6030_GPADC=m
CONFIG_VF610_ADC=y
CONFIG_VIPERBOARD_ADC=m

#
# Amplifiers
#
CONFIG_AD8366=y

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
CONFIG_VZ89X=m
CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
CONFIG_AD5064=m
CONFIG_AD5360=m
CONFIG_AD5380=m
CONFIG_AD5421=m
# CONFIG_AD5446 is not set
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=m
# CONFIG_AD5592R is not set
CONFIG_AD5593R=m
CONFIG_AD5504=m
CONFIG_AD5624R_SPI=y
CONFIG_LTC2632=m
CONFIG_AD5686=y
CONFIG_AD5755=m
# CONFIG_AD5761 is not set
CONFIG_AD5764=y
CONFIG_AD5791=m
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
CONFIG_DPOT_DAC=m
# CONFIG_DS4424 is not set
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MAX5821=m
CONFIG_MCP4725=y
# CONFIG_MCP4922 is not set
CONFIG_TI_DAC082S085=m
CONFIG_VF610_DAC=m

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
CONFIG_ADXRS450=m
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
CONFIG_AFE4404=y
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=m

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=m
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
CONFIG_ADIS16480=m
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BMI160_SPI=y
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=y
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=m
CONFIG_BH1750=m
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM3605=m
CONFIG_CM36651=y
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=m
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=m
# CONFIG_LTR501 is not set
CONFIG_MAX44000=m
CONFIG_OPT3001=m
CONFIG_PA12203001=y
# CONFIG_SI1145 is not set
CONFIG_STK3310=y
CONFIG_TCS3414=m
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=m
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=y

#
# Magnetometer sensors
#
CONFIG_AK8974=y
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=y
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
CONFIG_DS1803=y
CONFIG_MAX5481=m
# CONFIG_MAX5487 is not set
CONFIG_MCP4131=m
# CONFIG_MCP4531 is not set
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
CONFIG_ABP060MG=y
# CONFIG_BMP280 is not set
CONFIG_IIO_CROS_EC_BARO=m
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
CONFIG_MPL115=m
# CONFIG_MPL115_I2C is not set
CONFIG_MPL115_SPI=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
# CONFIG_MS5611_SPI is not set
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
CONFIG_T5403=m
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y

#
# Lightning sensors
#
CONFIG_AS3935=y

#
# Proximity and distance sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_RFD77402=y
CONFIG_SRF04=m
CONFIG_SX9500=m
CONFIG_SRF08=m

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=y
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LP3943=m
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m
# CONFIG_PWM_STMPE is not set
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SUNXI is not set
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=m
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_TUSB1210=m
# CONFIG_POWERCAP is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_DAX=m
CONFIG_NVMEM=y
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
CONFIG_FPGA_REGION=y
CONFIG_FPGA_MGR_ICE40_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
# CONFIG_XILINX_PR_DECOUPLER is not set

#
# FSI support
#
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=m
CONFIG_MUX_MMIO=m
CONFIG_PM_OPP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
# CONFIG_EFI_RUNTIME_MAP is not set
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH is not set
CONFIG_EFI_TEST=m
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
CONFIG_EFI_DEV_PATH_PARSER=y

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
# CONFIG_OCFS2_FS_STATS is not set
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
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
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_INDEX=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
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
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_HFSPLUS_FS_POSIX_ACL is not set
CONFIG_BEFS_FS=m
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
CONFIG_EFS_FS=m
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=m
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
# CONFIG_UBIFS_FS_ZLIB is not set
CONFIG_UBIFS_ATIME_SUPPORT=y
# CONFIG_UBIFS_FS_ENCRYPTION is not set
CONFIG_UBIFS_FS_SECURITY=y
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_ZSTD is not set
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=m
CONFIG_HPFS_FS=m
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=m
# CONFIG_QNX6FS_DEBUG is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
# CONFIG_PSTORE_ZLIB_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=y
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_EXOFS_FS=m
CONFIG_EXOFS_DEBUG=y
CONFIG_ORE=m
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
CONFIG_LOCKDEP_CROSSRELEASE=y
CONFIG_LOCKDEP_COMPLETIONS=y
# CONFIG_BOOTPARAM_LOCKDEP_CROSSRELEASE_FULLSTACK is not set
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
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
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_PROFILE_ALL_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_UPROBE_EVENTS is not set
# CONFIG_PROBE_EVENTS is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_TRACING_EVENTS_GPIO is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIND_BIT is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
CONFIG_EARLY_PRINTK_EFI=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
CONFIG_EFI_PGT_DUMP=y
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
# CONFIG_IOMMU_STRESS is not set
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
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=m
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
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
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=m
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=y
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
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
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
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
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=m

--4OpS+d6oOtUQaRm1--
