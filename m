Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FE1C43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 15:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDCE2071F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 15:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfLAPAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 10:00:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:19040 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfLAPAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 10:00:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2019 07:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,265,1571727600"; 
   d="xz'?gz'50?scan'50,208,50";a="207871262"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga007.fm.intel.com with ESMTP; 01 Dec 2019 07:00:41 -0800
Date:   Sun, 1 Dec 2019 23:00:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@lists.01.org>
Subject: 5e6669387e ("of/platform: Pause/resume sync state during init .."):
 [    3.192726] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:688
 device_links_supplier_sync_state_resume
Message-ID: <20191201150015.GC18573@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 5e6669387e2287f25f09fd0abd279dae104cfa7e
Author:     Saravana Kannan <saravanak@google.com>
AuthorDate: Wed Sep 4 14:11:24 2019 -0700
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Fri Oct 4 17:30:19 2019 +0200

    of/platform: Pause/resume sync state during init and of_platform_populate()
    
    When all the top level devices are populated from DT during kernel
    init, the supplier devices could be added and probed before the
    consumer devices are added and linked to the suppliers. To avoid the
    sync_state() callback from being called prematurely, pause the
    sync_state() callbacks before populating the devices and resume them
    at late_initcall_sync().
    
    Similarly, when children devices are populated from a module using
    of_platform_populate(), there could be supplier-consumer dependencies
    between the children devices that are populated. To avoid the same
    problem with sync_state() being called prematurely, pause and resume
    sync_state() callbacks across of_platform_populate().
    
    Signed-off-by: Saravana Kannan <saravanak@google.com>
    Link: https://lore.kernel.org/r/20190904211126.47518-6-saravanak@google.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

fc5a251d0f  driver core: Add sync_state driver/bus callback
5e6669387e  of/platform: Pause/resume sync state during init and of_platform_populate()
81b6b96475  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
+-------------------------------------------------------------------------+------------+------------+------------+
|                                                                         | fc5a251d0f | 5e6669387e | 81b6b96475 |
+-------------------------------------------------------------------------+------------+------------+------------+
| boot_successes                                                          | 30         | 0          | 0          |
| boot_failures                                                           | 1          | 11         | 22         |
| Oops:#[##]                                                              | 1          |            |            |
| EIP:unmap_vmas                                                          | 1          |            |            |
| PANIC:double_fault                                                      | 1          |            |            |
| Kernel_panic-not_syncing:Fatal_exception                                | 1          |            |            |
| WARNING:at_drivers/base/core.c:#device_links_supplier_sync_state_resume | 0          | 11         | 22         |
| EIP:device_links_supplier_sync_state_resume                             | 0          | 11         | 22         |
+-------------------------------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[    3.186107] OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
[    3.188595] platform testcase-data:testcase-device2: IRQ index 0 not found
[    3.191047] ### dt-test ### end of unittest - 199 passed, 0 failed
[    3.191932] ------------[ cut here ]------------
[    3.192571] Unmatched sync_state pause/resume!
[    3.192726] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:688 device_links_supplier_sync_state_resume+0x27/0xc0
[    3.195084] Modules linked in:
[    3.195494] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 5.4.0-rc1-00005-g5e6669387e228 #1
[    3.196674] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    3.197693] EIP: device_links_supplier_sync_state_resume+0x27/0xc0
[    3.198680] Code: 00 00 00 3e 8d 74 26 00 57 56 31 d2 53 b8 a0 d0 d9 c1 e8 6c b6 38 00 a1 e4 d0 d9 c1 85 c0 75 13 68 84 ba c4 c1 e8 29 30 b1 ff <0f> 0b 58 eb 7f 8d 74 26 00 83 e8 01 85 c0 a3 e4 d0 d9 c1 75 6f 8b
[    3.201560] EAX: 00000022 EBX: 00000000 ECX: 00000000 EDX: 00000000
[    3.202466] ESI: 000001ab EDI: c02c7f80 EBP: c1e87d27 ESP: c02c7f20
[    3.203301] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010282
[    3.204258] CR0: 80050033 CR2: bfa1bf98 CR3: 01f28000 CR4: 00140690
[    3.205022] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    3.205919] DR6: fffe0ff0 DR7: 00000400
[    3.206529] Call Trace:
[    3.207011]  ? of_platform_sync_state_init+0x13/0x16
[    3.207719]  ? do_one_initcall+0xda/0x260
[    3.208247]  ? kernel_init_freeable+0x110/0x197
[    3.208906]  ? rest_init+0x120/0x120
[    3.209369]  ? kernel_init+0xa/0x100
[    3.209775]  ? ret_from_fork+0x19/0x24
[    3.210283] ---[ end trace 81d0f2d2ee65199b ]---
[    3.210955] ALSA device list:

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 1251b72273bfd2d17832055d93713797f027bd7e 219d54332a09e8d8741c1e1982f5eae56099de85 --
git bisect  bad 5850da4ca99731a66a1b54fcd4e937f2ce09d422  # 07:14  B      0     3   19   0  Merge 'frank-w-bpi-r2-4.14/5.4-r64-pcie' into devel-catchup-201911300217
git bisect  bad a9ff9d736bfbcad09085e7b370eff28200691aae  # 07:38  B      0     3   19   0  Merge 'linux-review/Jaroslav-Kysela/ALSA-hda-fixup-for-the-bass-speaker-on-Lenovo-Carbon-X1-7th-gen/20191130-013305' into devel-catchup-201911300217
git bisect good ff7d78108fd9afb5e90dcdbf84c1857702452473  # 08:37  G     10     0    0   0  0day base guard for 'devel-catchup-201911300217'
git bisect  bad 95a324fbf220358a41e082098d16489e7efabb05  # 08:59  B      0     2   18   0  Merge 'linux-review/Vincenzo-Frascino/mips-Fix-gettimeofday-in-the-vdso-library/20191130-011805' into devel-catchup-201911300217
git bisect good 361b0d286afea0d867537536977a695b5557d133  # 09:55  G     11     0    0   0  Merge tag 'devprop-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 0dd09bc02c1bad55e92306ca83b38b3cf48b9f40  # 11:06  G     11     0    1   1  Merge tag 'staging-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good 3275a71e76fac5bc276f0d60e027b18c2e8d7a5b  # 12:07  G     11     0    0   0  Merge tag 'drm-next-5.5-2019-10-09' of git://people.freedesktop.org/~agd5f/linux into drm-next
git bisect good 2ef4144d1ea8b181d377d0783c43032cb44889f7  # 15:08  G     11     0    0   0  Merge tag 'drm-intel-next-2019-11-01-1' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
git bisect good acc61b8929365e63a3e8c8c8913177795aa45594  # 15:34  G     11     0    0   1  Merge tag 'drm-next-5.5-2019-11-22' of git://people.freedesktop.org/~agd5f/linux into drm-next
git bisect  bad 95f1fa9e3418d50ce099e67280b5497b9c93843b  # 16:06  B      0     2   19   1  Merge tag 'trace-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect  bad 80eb5fea3c14fb171facb5242a1555b3aafea4d0  # 16:31  B      0     1   17   0  Merge tag 'powerpc-spectre-rsb' of powerpc-CVE-2019-18660.bundle
git bisect  bad 0c40c1be2512abc99ea27df83f882dd61b5437bc  # 17:30  B      0    11   27   0  mmc: dw_mmc: Fix debugfs on 64-bit platforms
git bisect  bad f5cb0a7e64f41b6f1c5cacc64a476962f5e97f91  # 18:00  B      0     2   18   0  debugfs: remove return value of debugfs_create_x32()
git bisect  bad c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1  # 18:35  B      0     1   17   0  base: soc: Handle custom soc information sysfs entries
git bisect good fc5a251d0fd7ca9038bab78a8c97932c8c6ca23b  # 19:07  G     11     0    0   0  driver core: Add sync_state driver/bus callback
git bisect  bad d4387cd117414ba80230f27a514be5ca4a09cfcc  # 19:34  B      0     9   25   0  of: property: Create device links for all child-supplier depencencies
git bisect  bad 5e6669387e2287f25f09fd0abd279dae104cfa7e  # 19:53  B      0    11   27   0  of/platform: Pause/resume sync state during init and of_platform_populate()
# first bad commit: [5e6669387e2287f25f09fd0abd279dae104cfa7e] of/platform: Pause/resume sync state during init and of_platform_populate()
git bisect good fc5a251d0fd7ca9038bab78a8c97932c8c6ca23b  # 20:17  G     31     0    1   1  driver core: Add sync_state driver/bus callback
# extra tests with debug options
git bisect good 5e6669387e2287f25f09fd0abd279dae104cfa7e  # 20:29  G     10     0    0   0  of/platform: Pause/resume sync state during init and of_platform_populate()
# extra tests on head commit of linus/master
git bisect  bad 81b6b96475ac7a4ebfceae9f16fb3758327adbfe  # 20:47  B      0    22   61   0  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
# bad: [81b6b96475ac7a4ebfceae9f16fb3758327adbfe] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
# extra tests on revert first bad commit
git bisect good c1a48460693b4421be494a524e06e57bdb9fc9bf  # 21:19  G     10     0    0   0  Revert "of/platform: Pause/resume sync state during init and of_platform_populate()"
# good: [c1a48460693b4421be494a524e06e57bdb9fc9bf] Revert "of/platform: Pause/resume sync state during init and of_platform_populate()"
# extra tests on linus/master
# duplicated: [81b6b96475ac7a4ebfceae9f16fb3758327adbfe] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
# extra tests on linux-next/master
# 119: [419593dad8439007452bb6f267861863b572c520] Add linux-next specific files for 20191129

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

--NKoe5XOeduwbEQHU
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-af60b987e7d2:20191130195207:i386-randconfig-b003-20191129:5.4.0-rc1-00005-g5e6669387e228:1.gz"
Content-Transfer-Encoding: base64

H4sICKFs4l0AA2RtZXNnLXlvY3RvLXZtLXlvY3RvLWFmNjBiOTg3ZTdkMjoyMDE5MTEzMDE5
NTIwNzppMzg2LXJhbmRjb25maWctYjAwMy0yMDE5MTEyOTo1LjQuMC1yYzEtMDAwMDUtZzVl
NjY2OTM4N2UyMjg6MQCsWltz2ziyft78Cmztwzi7lkyAIEiqSltry3KscmwrljOTnVRKRZGg
zDVFanhx7Pn1pxsgReoW2TmjSiwRbHxoNBp9A6SXxS/ET5M8jSWJEpLLolxCQyDfyc138rnI
PL+YPsoskfG7KFmWxTTwCq9HjGeD+jY3hFs1xzJRrYaQoWMa79KygGZNaKhP1dRQhswWrvFO
o0+LtPDiaR79KXUn0/ax07tz6aeLZSbzPErm5GOUlM/dbpeMvUw1DD9e4GOQJrL77ixNC2ws
HiTRsN13Xwl8jK7m4ZsGIE8SeqcJsbq8a3Qyn3bwrdWZW1II4ZqOLRlzyNHjrIzi4D9UMjMI
LAHNzntyNPf9FYLdtboGOTqXs8irnjr0/XvyD0om12MyvhsOr8f3ZOIV5CZ9IqZBqNvjZs+y
yWByT5hB3U0Wnx1xEi7LHpmUy2WaqRl9mZz+OiSh9Ioyk0p6tEd+eXZsEsapp0iWaZQUJJPz
KC+AuV9+DpYB7GQy/H/jcMA5/fXLa3Ce88Ir5DQNQ1DGr+xbjxDLFsd1O6pErpuZJfaiDBNv
Fsug6lXzkgMz9jEqdQHaTBCLRDlxTEZmL4XMj0mp1OgX6JUEXhb8QsI0W3jFluKcjW4nnWWW
PkUBjLJ8eMkj34vJ3ek1WXjL3k5y6TCjR74u5ELJZP3TWWtyw1kYfgNucBZvAnNDfxssRDCY
vsyeZPAmuHCbt/Dn4ejmVGGWgYZ761Shp9wG+2neQhmi4Npw2PTTcBptDe7nuaM1RgPHzBXc
bsktM9j/jz0SyFk575FonqQZqnaczmP5JGM09bhZtzS77jgD61lb/6/KGQDX8F7qnbXZ7QZs
rQ/G+uYLORo+S7+EXXceKdbeA2ZaSL9AC+l7SZIWZCZroB5J0qQzPh1WNvrvm8iTaxQMYV2H
oOGXyfZuPL8e9cin4fVnMqk2LhkPyFHEuXHxhfyLjEejL8dgal3x/liJmdAuNbqsQ4nBTwx6
AoaXb4JevixhmaI8zUCIyD7yevXr9Sbd49Oi48epDzL7rKzHIs9ywmeW4IFBCfBTPxhrXela
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
Yid2BNK6u5tfIFn4F8cUnS6GMAEA

--NKoe5XOeduwbEQHU
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-2102271fd292:20191130201615:i386-randconfig-b003-20191129:5.4.0-rc1-00004-gfc5a251d0fd7c:1.gz"
Content-Transfer-Encoding: base64

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
fkvBjf8CVXAcGRS/AAA=

--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vm-yocto-af60b987e7d2:20191130195207:i386-randconfig-b003-20191129:5.4.0-rc1-00005-g5e6669387e228:1"

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

--NKoe5XOeduwbEQHU
Content-Type: application/x-xz
Content-Disposition: attachment; filename="1251b72273bfd2d17832055d93713797f027bd7e:gcc-7:i386-randconfig-b003-20191129:EIP:device_links_supplier_sync_state_resume.xz"
Content-Transfer-Encoding: base64

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

--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.4.0-rc1-00005-g5e6669387e228"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.4.0-rc1 Kernel Configuration
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
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_HEADER_TEST=y
CONFIG_KERNEL_HEADER_TEST=y
# CONFIG_UAPI_HEADER_TEST is not set
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
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
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
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
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
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

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
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
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
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
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
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_PROFILING=y
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
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_KVM_DEBUG_FS=y
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
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
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

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_TOSHIBA=m
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_KEXEC is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ENERGY_MODEL=y
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
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
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
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=m
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

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
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
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
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=y
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
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
CONFIG_GCC_PLUGIN_CYC_COMPLEXITY=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
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
CONFIG_MQ_IOSCHED_KYBER=m
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

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
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=m
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
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
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
# CONFIG_EISA_NAMES is not set
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

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_FW_LOADER_COMPRESS=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=m
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=m
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=y
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
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
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=m
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=m
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=m
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=y
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=m
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

CONFIG_SENSORS_LIS3_I2C=m
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

CONFIG_ECHO=m
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
CONFIG_SCSI_MOD=m
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=m
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

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
CONFIG_SCSI_AHA1740=m
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
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
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
CONFIG_SCSI_IMM=m
CONFIG_SCSI_IZIP_EPP16=y
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_SIM710=m
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
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
# CONFIG_PATA_OF_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BLK_DEV_DM is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
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
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HP=y
CONFIG_HP100=m
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
# CONFIG_NE2K_PCI is not set
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
CONFIG_NVM_PBLK=y
# CONFIG_NVM_PBLK_DEBUG is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5520=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=m
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_OMAP4=y
CONFIG_KEYBOARD_TC3589X=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CROS_EC=m
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
CONFIG_TABLET_USB_AIPTEK=y
# CONFIG_TABLET_USB_GTCO is not set
CONFIG_TABLET_USB_HANWANG=m
CONFIG_TABLET_USB_KBTAB=y
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=m
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=m
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_MSM_VIBRATOR=m
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MAX8925_ONKEY is not set
# CONFIG_INPUT_MAX8997_HAPTIC is not set
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=y
# CONFIG_INPUT_APANEL is not set
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_GPIO_VIBRA=m
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=m
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
CONFIG_INPUT_YEALINK=y
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_RETU_PWRBUTTON=m
CONFIG_INPUT_TPS65218_PWRBUTTON=m
CONFIG_INPUT_AXP20X_PEK=y
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=y
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_RK805_PWRKEY is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA9055_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_WM831X_ON=m
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_IMS_PCU=y
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=m
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
# CONFIG_INPUT_STPMIC1_ONKEY is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
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
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=y
# CONFIG_NULL_TTY is not set
# CONFIG_LDISC_AUTOLOAD is not set
# CONFIG_DEVMEM is not set
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
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
CONFIG_SERIAL_SIFIVE=m
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
CONFIG_TTY_PRINTK=m
CONFIG_TTY_PRINTK_LEVEL=6
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=m
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=m
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_DEMUX_PINCTRL=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
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
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_DLN2=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_FSI is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=m
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AS3722 is not set
# CONFIG_PINCTRL_AXP209 is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SINGLE=m
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_STMFX=m
CONFIG_PINCTRL_MAX77620=m
CONFIG_PINCTRL_RK805=y
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
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L85=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=m
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=m
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
# CONFIG_GPIO_BD70528 is not set
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_DA9055 is not set
# CONFIG_GPIO_DLN2 is not set
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_LP87565=m
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77620=m
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TC3589X=y
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_UCB1400=m
CONFIG_GPIO_WM831X=y
# CONFIG_GPIO_WM8350 is not set
# CONFIG_GPIO_WM8994 is not set
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
CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_NVMEM_REBOOT_MODE=m
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_MAX8925_POWER=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=m
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_OLPC is not set
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_MAX8997 is not set
CONFIG_CHARGER_MAX8998=m
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=m
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=y
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=m
# CONFIG_CHARGER_CROS_USBPD is not set
CONFIG_CHARGER_UCS1002=y
# CONFIG_CHARGER_BD70528 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7414=m
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AS370=m
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=m
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CPU_THERMAL is not set
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=m
CONFIG_MAX77620_THERMAL=m
# CONFIG_QORIQ_THERMAL is not set
CONFIG_DA9062_THERMAL=m

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
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
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_BD70528_WATCHDOG=m
CONFIG_DA9055_WATCHDOG=m
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
CONFIG_GPIO_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG_ARCH_INITCALL is not set
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_RAVE_SP_WATCHDOG=m
# CONFIG_MLX_WDT is not set
CONFIG_CADENCE_WATCHDOG=m
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_MAX77620_WATCHDOG=m
CONFIG_RETU_WATCHDOG=m
# CONFIG_STPMIC1_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=m
# CONFIG_SCx200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=m
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=m
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=m

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
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=m
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC_DEV is not set
CONFIG_MFD_MADERA=m
# CONFIG_MFD_MADERA_I2C is not set
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=m
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
CONFIG_UCB1400_CORE=m
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=m
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=m
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD70528=m
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=m
CONFIG_RAVE_SP_CORE=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_ARIZONA_LDO1=m
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
CONFIG_REGULATOR_AS3722=m
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_BD70528 is not set
# CONFIG_REGULATOR_BD718XX is not set
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9063=m
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP87565 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX77620 is not set
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8997=m
CONFIG_REGULATOR_MAX8998=m
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_QCOM_SPMI=m
# CONFIG_REGULATOR_RC5T583 is not set
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SLG51000=m
# CONFIG_REGULATOR_STPMIC1 is not set
# CONFIG_REGULATOR_SY8106A is not set
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS6586X=m
CONFIG_REGULATOR_TPS65910=m
CONFIG_REGULATOR_TPS80031=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8400=m
CONFIG_REGULATOR_WM8994=m
CONFIG_CEC_CORE=y
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
# CONFIG_DRM is not set
CONFIG_DRM_DP_CEC=y

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
CONFIG_FB_SMSCUFX=m
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_MAX8925=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP5520=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_LM3630A=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_RAVE_SP=m
# end of Backlight & LCD device support

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
# CONFIG_SND_ALOOP is not set
CONFIG_SND_VIRMIDI=y
CONFIG_SND_MTPAV=y
# CONFIG_SND_MTS64 is not set
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y
# CONFIG_SND_PORTMAN2X4 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
CONFIG_SND_USB_UA101=m
# CONFIG_SND_USB_USX2Y is not set
CONFIG_SND_USB_CAIAQ=y
# CONFIG_SND_USB_CAIAQ_INPUT is not set
# CONFIG_SND_USB_US122L is not set
CONFIG_SND_USB_6FIRE=y
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=y
CONFIG_SND_USB_LINE6=y
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=y
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_AMD_ACP=m
# CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
# CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_SOC_MIKROE_PROTO=m
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_AUDMIX=m
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
# CONFIG_SND_SOC_FSL_ESAI is not set
CONFIG_SND_SOC_FSL_MICFIL=m
CONFIG_SND_SOC_IMX_AUDMUX=y
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
# CONFIG_SND_SOC_IMG_I2S_OUT is not set
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=y
CONFIG_SND_SST_IPC_ACPI=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
# CONFIG_SND_SOC_INTEL_SKL is not set
# CONFIG_SND_SOC_INTEL_APL is not set
# CONFIG_SND_SOC_INTEL_KBL is not set
# CONFIG_SND_SOC_INTEL_GLK is not set
# CONFIG_SND_SOC_INTEL_CNL is not set
# CONFIG_SND_SOC_INTEL_CFL is not set
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_MTK_BTCVSD=y
CONFIG_SND_SOC_SOF_TOPLEVEL=y
# CONFIG_SND_SOC_SOF_PCI is not set
# CONFIG_SND_SOC_SOF_ACPI is not set
# CONFIG_SND_SOC_SOF_OF is not set
# CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=y
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU1701=m
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU7002 is not set
CONFIG_SND_SOC_AK4118=m
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4642=m
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=y
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CROS_EC_CODEC=m
# CONFIG_SND_SOC_CS35L32 is not set
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS4265=m
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=y
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_GTM601=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98088=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98504=m
# CONFIG_SND_SOC_MAX9867 is not set
# CONFIG_SND_SOC_MAX98927 is not set
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
CONFIG_SND_SOC_PCM3060=m
CONFIG_SND_SOC_PCM3060_I2C=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
# CONFIG_SND_SOC_RK3328 is not set
# CONFIG_SND_SOC_RT5616 is not set
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
# CONFIG_SND_SOC_SPDIF is not set
CONFIG_SND_SOC_SSM2305=y
# CONFIG_SND_SOC_SSM2602_I2C is not set
# CONFIG_SND_SOC_SSM4567 is not set
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS5086=y
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=y
# CONFIG_SND_SOC_TAS6424 is not set
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
CONFIG_SND_SOC_TLV320AIC31XX=y
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
CONFIG_SND_SOC_TLV320AIC3X=m
# CONFIG_SND_SOC_TS3A227E is not set
CONFIG_SND_SOC_TSCS42XX=m
CONFIG_SND_SOC_TSCS454=y
CONFIG_SND_SOC_UDA1334=m
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=y
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
# CONFIG_SND_SOC_WM8737 is not set
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
# CONFIG_SND_SOC_WM8960 is not set
CONFIG_SND_SOC_WM8962=y
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_ZX_AUD96P22=m
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
CONFIG_SND_SOC_MT6358=m
# CONFIG_SND_SOC_NAU8540 is not set
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8822=m
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_TPA6130A2=y
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
CONFIG_SND_AUDIO_GRAPH_CARD=m
CONFIG_SND_X86=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
CONFIG_HID_BETOP_FF=m
CONFIG_HID_BIGBEN_FF=m
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=m
CONFIG_HID_PRODIKEYS=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CP2112=m
CONFIG_HID_CREATIVE_SB0540=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELAN=m
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=m
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_GOOGLE_HAMMER=m
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=m
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LEDS is not set
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

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
CONFIG_I2C_HID=m
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=m
CONFIG_USB_CONN_GPIO=m
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
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=m
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_BCMA=m
# CONFIG_USB_HCD_SSB is not set
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
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
# CONFIG_USB_STORAGE_USBAT is not set
CONFIG_USB_STORAGE_SDDR09=m
# CONFIG_USB_STORAGE_SDDR55 is not set
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_HAPS=m
CONFIG_USB_DWC3_OF_SIMPLE=m
CONFIG_USB_DWC2=m
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=y
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_TAHVO_USB=m
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
CONFIG_USB_ISP1301=m
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AAT1290=m
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=m
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_BCM6328=m
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=m
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_NET48XX=m
# CONFIG_LEDS_WRAP is not set
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=m
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=m
CONFIG_LEDS_KTD2692=m
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=y
# CONFIG_LEDS_LM36274 is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
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
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
CONFIG_DMABUF_SELFTESTS=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_HT16K33 is not set
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=m
CONFIG_CHARLCD=m
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
# CONFIG_GREYBUS_ES2 is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_FB_OLPC_DCON is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set
# CONFIG_RTS5208 is not set
# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# end of Speakup console speech

CONFIG_STAGING_MEDIA=y

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# end of Android

# CONFIG_STAGING_BOARD is not set
# CONFIG_LTE_GDM724X is not set
CONFIG_GS_FPGABOOT=m
CONFIG_UNISYSSPAR=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_MOST=m
CONFIG_MOST_CDEV=m
# CONFIG_MOST_NET is not set
CONFIG_MOST_SOUND=m
CONFIG_MOST_DIM2=m
# CONFIG_MOST_I2C is not set
# CONFIG_MOST_USB is not set
CONFIG_GREYBUS_AUDIO=m
# CONFIG_GREYBUS_BOOTROM is not set
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_POWER=m
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
# CONFIG_GREYBUS_BRIDGED_PHY is not set

#
# Gasket devices
#
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
CONFIG_FIELDBUS_DEV=y
CONFIG_HMS_ANYBUSS_BUS=y
CONFIG_ARCX_ANYBUS_CONTROLLER=m
CONFIG_HMS_PROFINET=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=m
# CONFIG_EXFAT_FS is not set
# CONFIG_QLGE is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_MFD_CROS_EC=m
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=y
CONFIG_CROS_EC_RPMSG=m
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=y
CONFIG_OLPC_EC=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# end of Common Clock Framework

CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_MAILBOX_TEST=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set

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
CONFIG_RPMSG_QCOM_GLINK_NATIVE=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set

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

CONFIG_SOC_TI=y

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
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX77843=m
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PTN5150=m
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
# CONFIG_PWM_CROS_EC is not set
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_LP3943=m
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=m
# end of IRQ chip support

CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_CADENCE_DP=y
CONFIG_PHY_CADENCE_DPHY=m
CONFIG_PHY_CADENCE_SIERRA=m
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_MIXEL_MIPI_DPHY=m
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=m
CONFIG_PHY_MAPPHONE_MDM6600=m
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=m
CONFIG_PHY_SAMSUNG_USB2=m
CONFIG_PHY_TUSB1210=m
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

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
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_RAVE_SP_EEPROM=m

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_PROTO_BASIC=m
CONFIG_STM_PROTO_SYS_T=m
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=m
CONFIG_FSI_NEW_DEV_NODE=y
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=m
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=m
# CONFIG_FSI_OCC is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_IO_TRACE=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=m
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
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
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
# CONFIG_EROFS_FS is not set
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
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
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
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
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
CONFIG_TRUSTED_KEYS=m
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"

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
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECRDSA=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_AEGIS128=y
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
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=m
CONFIG_CRYPTO_ADIANTUM=m
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_TEA=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
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
# CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
# CONFIG_TPM_KEY_PARSER is not set

#
# Certificates for signature checking
#
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
CONFIG_RAID6_PQ=m
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
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
CONFIG_CRC4=m
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
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
# CONFIG_DYNAMIC_DEBUG is not set
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
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_INSTALL=y
CONFIG_HEADERS_CHECK=y
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
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
CONFIG_DEBUG_TIMEKEEPING=y
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
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
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_TRACE_PREEMPT_TOGGLE=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_GCOV_PROFILE_FTRACE=y
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
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_MEMTEST=y
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
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y
# end of Kernel hacking

--NKoe5XOeduwbEQHU--
