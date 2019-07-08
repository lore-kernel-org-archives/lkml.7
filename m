Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169C5C606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960C920651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfGHJXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:23:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38841 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbfGHJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:23:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPr2-0004p8-Vs; Mon, 08 Jul 2019 11:22:38 +0200
Date:   Mon, 08 Jul 2019 09:05:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for 5.3-rc1
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
Message-ID: <156257673795.14831.1793413220192426712.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus

up to:  9176ab1b8480: time: Validate user input in compat_settimeofday()

The timer and timekeeping departement delivers:

  Core:

    - The consolidation of the VDSO code into a generic library including
      the conversion of x86 and ARM64. Conversion of ARM and MIPS are en
      route through the relevant maintainer trees and should end up in 5.4.

      This gets rid of the unnecessary different copies of the same code
      and brings all architectures on the same level of VDSO functionality.

    - Make the NTP user space interface more robust by restricting the
      TAI offset to prevent undefined behaviour. Includes a selftest.

    - Validate user input in the compat settimeofday() syscall to catch
      invalid values which would be turned into valid values by a
      multiplication overflow

    - Consolidate the time accessors

    - Small fixes, improvements and cleanups all over the place

  Drivers:

    - Support for the NXP system counter, TI davinci timer

    - Move the Microsoft HyperV clocksource/events code into the
      drivers/clocksource directory so it can be shared between x86 and
      ARM64.

    - Overhaul of the Tegra driver

    - Delay timer support for IXP4xx

    - Small fixes, improvements and cleanups as usual

Thanks,

	tglx

------------------>
Andrew Murray (1):
      clocksource/drivers/arm_arch_timer: Extract elf_hwcap use to arch-helper

Andy Lutomirski (1):
      x86/vdso: Give the [ph]vclock_page declarations real types

Bai Ping (1):
      clocksource/drivers/sysctr: Add nxp system counter timer driver support

Bartosz Golaszewski (2):
      clocksource/drivers/davinci: Add support for clockevents
      clocksource/drivers/davinci: Add support for clocksource

Catalin Marinas (3):
      vdso: Remove superfluous #ifdef __KERNEL__ in vdso/datapage.h
      arm64: vdso: Remove unnecessary asm-offsets.c definitions
      arm64: compat: No need for pre-ARMv7 barriers on an ARMv8 system

Dmitry Osipenko (17):
      clocksource/drivers/tegra: Support per-CPU timers on all Tegra's
      clocksource/drivers/tegra: Unify timer code
      clocksource/drivers/tegra: Reset hardware state on init
      clocksource/drivers/tegra: Replace readl/writel with relaxed versions
      clocksource/drivers/tegra: Release all IRQ's on request_irq() error
      clocksource/drivers/tegra: Minor code clean up
      clocksource/drivers/tegra: Support COMPILE_TEST universally
      clocksource/drivers/tegra: Lower clocksource rating for some Tegra's
      clocksource/drivers/tegra: Rename timer-tegra20.c to timer-tegra.c
      clocksource/drivers/tegra: Restore timer rate on Tegra210
      clocksource/drivers/tegra: Remove duplicated use of per_cpu_ptr
      clocksource/drivers/tegra: Set and use timer's period
      clocksource/drivers/tegra: Drop unneeded typecasting in one place
      clocksource/drivers/tegra: Add verbose definition for 1MHz constant
      clocksource/drivers/tegra: Restore base address before cleanup
      clocksource/drivers/tegra: Cycles can't be 0
      clocksource/drivers/tegra: Set up maximum-ticks limit properly

Jason A. Donenfeld (4):
      timekeeping: Use proper ktime_add when adding nsecs in coarse offset
      timekeeping: Use proper clock specifier names in functions
      timekeeping: Add missing _ns functions for coarse accessors
      timekeeping: Boot should be boottime for coarse ns accessor

Linus Walleij (1):
      clocksource/drivers/ixp4xx: Implement delay timer

Marek Szyprowski (1):
      clocksource/drivers/exynos_mct: Increase priority over ARM arch timer

Masahiro Yamada (1):
      clocksource/drivers/arc_timer: Use BIT() instead of _BITUL()

Mathieu Malaterre (1):
      clocksource: Move inline keyword to the beginning of function declarations

Mauro Carvalho Chehab (1):
      hrtimer: Use a bullet for the returns bullet list

Michael Kelley (2):
      clocksource/drivers: Make Hyper-V clocksource ISA agnostic
      clocksource/drivers: Continue making Hyper-V clocksource ISA agnostic

Miroslav Lichvar (2):
      ntp: Limit TAI-UTC offset
      kselftests: timers: freq-step: Update maximum acceptable precision and errors

Nathan Huckleberry (1):
      timer_list: Guard procfs specific code

Neil Armstrong (1):
      clocksource/drivers/timer-meson6: Update with SPDX Licence identifier

Peter Collingbourne (1):
      arm64: vdso: Build vDSO with -ffixed-x18

Peter Xu (1):
      timer: Document TIMER_PINNED

Sebastian Andrzej Siewior (2):
      posix-timers: Remove "it_signal = NULL" assignment in itimer_delete()
      posix-timers: Use spin_lock_irq() in itimer_delete()

Thomas Gleixner (3):
      MAINTAINERS: Add entry for the generic VDSO library
      lib/vdso: Make delta calculation work correctly
      MAINTAINERS: Fix Andy's surname and the directory entries of VDSO

Vincenzo Frascino (21):
      hrtimer: Split out hrtimer defines into separate header
      vdso: Define standardized vdso_datapage
      lib/vdso: Provide generic VDSO implementation
      lib/vdso: Add compat support
      timekeeping: Provide a generic update_vsyscall() implementation
      arm64: vdso: Substitute gettimeofday() with C implementation
      arm64: compat: Add missing syscall numbers
      arm64: compat: Expose signal related structures
      arm64: compat: Generate asm offsets for signals
      arm64: compat: Add vDSO
      arm64: vdso: Refactor vDSO code
      arm64: compat: VDSO setup for compat layer
      arm64: elf: VDSO code page discovery
      arm64: compat: Get sigreturn trampolines from vDSO
      arm64: vdso: Enable vDSO compat support
      x86/vdso: Switch to generic vDSO implementation
      x86/vdso: Add clock_getres() entry point
      x86/vdso: Add clock_gettime64() entry point
      arm64: Fix __arch_get_hw_counter() implementation
      arm64: compat: Fix __arch_get_hw_counter() implementation
      arm64: vdso: Fix compilation with clang older than 8

Yangtao Li (2):
      hrtimer: Remove unused header include
      alarmtimer: Fix kerneldoc comment for alarmtimer_suspend()

zhengbin (1):
      time: Validate user input in compat_settimeofday()


 Documentation/core-api/timekeeping.rst             |  12 +-
 .../devicetree/bindings/timer/nxp,sysctr-timer.txt |  25 ++
 MAINTAINERS                                        |  14 +
 arch/arm/include/asm/arch_timer.h                  |  10 +
 arch/arm64/Kconfig                                 |   3 +
 arch/arm64/Makefile                                |  23 +-
 arch/arm64/include/asm/arch_timer.h                |  13 +
 arch/arm64/include/asm/elf.h                       |  14 +
 arch/arm64/include/asm/signal32.h                  |  46 +++
 arch/arm64/include/asm/unistd.h                    |   5 +
 arch/arm64/include/asm/vdso.h                      |   3 +
 arch/arm64/include/asm/vdso/compat_barrier.h       |  44 +++
 arch/arm64/include/asm/vdso/compat_gettimeofday.h  | 126 +++++++
 arch/arm64/include/asm/vdso/gettimeofday.h         | 103 +++++
 arch/arm64/include/asm/vdso/vsyscall.h             |  53 +++
 arch/arm64/kernel/Makefile                         |   6 +-
 arch/arm64/kernel/asm-offsets.c                    |  34 +-
 arch/arm64/kernel/signal32.c                       |  72 ++--
 arch/arm64/kernel/vdso.c                           | 356 ++++++++++++------
 arch/arm64/kernel/vdso/Makefile                    |  41 +-
 arch/arm64/kernel/vdso/gettimeofday.S              | 323 ----------------
 arch/arm64/kernel/vdso/vgettimeofday.c             |  27 ++
 arch/arm64/kernel/vdso32/.gitignore                |   2 +
 arch/arm64/kernel/vdso32/Makefile                  | 186 +++++++++
 arch/arm64/kernel/vdso32/note.c                    |  15 +
 arch/arm64/kernel/vdso32/sigreturn.S               |  62 +++
 arch/arm64/kernel/vdso32/vdso.S                    |  19 +
 arch/arm64/kernel/vdso32/vdso.lds.S                |  82 ++++
 arch/arm64/kernel/vdso32/vgettimeofday.c           |  59 +++
 arch/x86/Kconfig                                   |   3 +
 arch/x86/entry/vdso/Makefile                       |   9 +
 arch/x86/entry/vdso/vclock_gettime.c               | 256 +++----------
 arch/x86/entry/vdso/vdso.lds.S                     |   2 +
 arch/x86/entry/vdso/vdso32/vdso32.lds.S            |   2 +
 arch/x86/entry/vdso/vdsox32.lds.S                  |   1 +
 arch/x86/entry/vdso/vma.c                          |   2 +-
 arch/x86/entry/vsyscall/Makefile                   |   2 -
 arch/x86/entry/vsyscall/vsyscall_gtod.c            |  83 ----
 arch/x86/hyperv/hv_init.c                          |  91 +----
 arch/x86/include/asm/hyperv-tlfs.h                 |   6 +
 arch/x86/include/asm/mshyperv.h                    |  81 +---
 arch/x86/include/asm/pvclock.h                     |   2 +-
 arch/x86/include/asm/vdso/gettimeofday.h           | 261 +++++++++++++
 arch/x86/include/asm/vdso/vsyscall.h               |  44 +++
 arch/x86/include/asm/vgtod.h                       |  75 +---
 arch/x86/include/asm/vvar.h                        |   7 +-
 arch/x86/kernel/cpu/mshyperv.c                     |   4 +-
 arch/x86/kernel/pvclock.c                          |   1 +
 arch/x86/kvm/pmu.c                                 |   4 +-
 arch/x86/kvm/x86.c                                 |  13 +-
 drivers/clocksource/Kconfig                        |  14 +-
 drivers/clocksource/Makefile                       |   5 +-
 drivers/clocksource/arc_timer.c                    |   3 +-
 drivers/clocksource/arm_arch_timer.c               |  15 +-
 drivers/clocksource/exynos_mct.c                   |   4 +-
 drivers/clocksource/hyperv_timer.c                 | 339 +++++++++++++++++
 drivers/clocksource/timer-davinci.c                | 369 ++++++++++++++++++
 drivers/clocksource/timer-imx-sysctr.c             | 145 +++++++
 drivers/clocksource/timer-ixp4xx.c                 |  16 +-
 drivers/clocksource/timer-meson6.c                 |   5 +-
 drivers/clocksource/timer-tegra.c                  | 416 +++++++++++++++++++++
 drivers/clocksource/timer-tegra20.c                | 379 -------------------
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   2 +-
 drivers/hv/Kconfig                                 |   3 +
 drivers/hv/hv.c                                    | 156 +-------
 drivers/hv/hv_util.c                               |   1 +
 drivers/hv/hyperv_vmbus.h                          |   3 -
 drivers/hv/vmbus_drv.c                             |  42 ++-
 drivers/iio/humidity/dht11.c                       |   8 +-
 drivers/iio/industrialio-core.c                    |   4 +-
 drivers/infiniband/hw/mlx4/alias_GUID.c            |   6 +-
 drivers/leds/trigger/ledtrig-activity.c            |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   2 +-
 drivers/net/wireless/mac80211_hwsim.c              |   2 +-
 drivers/net/wireless/ti/wlcore/main.c              |   2 +-
 drivers/net/wireless/ti/wlcore/rx.c                |   2 +-
 drivers/net/wireless/ti/wlcore/tx.c                |   2 +-
 drivers/net/wireless/virt_wifi.c                   |   2 +-
 include/asm-generic/vdso/vsyscall.h                |  50 +++
 include/clocksource/hyperv_timer.h                 | 107 ++++++
 include/clocksource/timer-davinci.h                |  44 +++
 include/linux/cpuhotplug.h                         |   2 +-
 include/linux/hrtimer.h                            |  16 +-
 include/linux/hrtimer_defs.h                       |  27 ++
 include/linux/timekeeping.h                        |  32 +-
 include/linux/timer.h                              |  27 +-
 include/net/cfg80211.h                             |   2 +-
 include/vdso/datapage.h                            |  89 +++++
 include/vdso/helpers.h                             |  56 +++
 include/vdso/vsyscall.h                            |  11 +
 kernel/bpf/syscall.c                               |   2 +-
 kernel/events/core.c                               |   4 +-
 kernel/fork.c                                      |   2 +-
 kernel/time/Makefile                               |   1 +
 kernel/time/alarmtimer.c                           |   1 -
 kernel/time/clocksource.c                          |   4 +-
 kernel/time/hrtimer.c                              |   8 +-
 kernel/time/ntp.c                                  |   4 +-
 kernel/time/posix-timers.c                         |  13 +-
 kernel/time/time.c                                 |   4 +
 kernel/time/timekeeping.c                          |   2 +-
 kernel/time/timer_list.c                           |  36 +-
 kernel/time/vsyscall.c                             | 133 +++++++
 lib/Kconfig                                        |   5 +
 lib/vdso/Kconfig                                   |  36 ++
 lib/vdso/Makefile                                  |  22 ++
 lib/vdso/gettimeofday.c                            | 239 ++++++++++++
 tools/testing/selftests/timers/freq-step.c         |   6 +-
 111 files changed, 3929 insertions(+), 1738 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
 create mode 100644 arch/arm64/include/asm/vdso/compat_barrier.h
 create mode 100644 arch/arm64/include/asm/vdso/compat_gettimeofday.h
 create mode 100644 arch/arm64/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/arm64/include/asm/vdso/vsyscall.h
 create mode 100644 arch/arm64/kernel/vdso/vgettimeofday.c
 create mode 100644 arch/arm64/kernel/vdso32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso32/Makefile
 create mode 100644 arch/arm64/kernel/vdso32/note.c
 create mode 100644 arch/arm64/kernel/vdso32/sigreturn.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.lds.S
 create mode 100644 arch/arm64/kernel/vdso32/vgettimeofday.c
 delete mode 100644 arch/x86/entry/vsyscall/vsyscall_gtod.c
 create mode 100644 arch/x86/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/x86/include/asm/vdso/vsyscall.h
 create mode 100644 drivers/clocksource/hyperv_timer.c
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 drivers/clocksource/timer-imx-sysctr.c
 create mode 100644 drivers/clocksource/timer-tegra.c
 delete mode 100644 drivers/clocksource/timer-tegra20.c
 create mode 100644 include/asm-generic/vdso/vsyscall.h
 create mode 100644 include/clocksource/hyperv_timer.h
 create mode 100644 include/clocksource/timer-davinci.h
 create mode 100644 include/linux/hrtimer_defs.h
 create mode 100644 include/vdso/datapage.h
 create mode 100644 include/vdso/helpers.h
 create mode 100644 include/vdso/vsyscall.h
 create mode 100644 kernel/time/vsyscall.c
 create mode 100644 lib/vdso/Kconfig
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/gettimeofday.c

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 93cbeb9daec0..20ee447a50f3 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -65,7 +65,7 @@ different format depending on what is required by the user:
 .. c:function:: u64 ktime_get_ns( void )
 		u64 ktime_get_boottime_ns( void )
 		u64 ktime_get_real_ns( void )
-		u64 ktime_get_tai_ns( void )
+		u64 ktime_get_clocktai_ns( void )
 		u64 ktime_get_raw_ns( void )
 
 	Same as the plain ktime_get functions, but returning a u64 number
@@ -99,16 +99,20 @@ Coarse and fast_ns access
 
 Some additional variants exist for more specialized cases:
 
-.. c:function:: ktime_t ktime_get_coarse_boottime( void )
+.. c:function:: ktime_t ktime_get_coarse( void )
+		ktime_t ktime_get_coarse_boottime( void )
 		ktime_t ktime_get_coarse_real( void )
 		ktime_t ktime_get_coarse_clocktai( void )
-		ktime_t ktime_get_coarse_raw( void )
+
+.. c:function:: u64 ktime_get_coarse_ns( void )
+		u64 ktime_get_coarse_boottime_ns( void )
+		u64 ktime_get_coarse_real_ns( void )
+		u64 ktime_get_coarse_clocktai_ns( void )
 
 .. c:function:: void ktime_get_coarse_ts64( struct timespec64 * )
 		void ktime_get_coarse_boottime_ts64( struct timespec64 * )
 		void ktime_get_coarse_real_ts64( struct timespec64 * )
 		void ktime_get_coarse_clocktai_ts64( struct timespec64 * )
-		void ktime_get_coarse_raw_ts64( struct timespec64 * )
 
 	These are quicker than the non-coarse versions, but less accurate,
 	corresponding to CLOCK_MONONOTNIC_COARSE and CLOCK_REALTIME_COARSE
diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
new file mode 100644
index 000000000000..d57659996d62
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
@@ -0,0 +1,25 @@
+NXP System Counter Module(sys_ctr)
+
+The system counter(sys_ctr) is a programmable system counter which provides
+a shared time base to Cortex A15, A7, A53, A73, etc. it is intended for use in
+applications where the counter is always powered and support multiple,
+unrelated clocks. The compare frame inside can be used for timer purpose.
+
+Required properties:
+
+- compatible :      should be "nxp,sysctr-timer"
+- reg :             Specifies the base physical address and size of the comapre
+                    frame and the counter control, read & compare.
+- interrupts :      should be the first compare frames' interrupt
+- clocks : 	    Specifies the counter clock.
+- clock-names: 	    Specifies the clock's name of this module
+
+Example:
+
+	system_counter: timer@306a0000 {
+		compatible = "nxp,sysctr-timer";
+		reg = <0x306a0000 0x20000>;/* system-counter-rd & compare */
+		clocks = <&clk_8m>;
+		clock-names = "per";
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index d0ed735994a5..bfde42a76a95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6664,6 +6664,18 @@ L:	kvm@vger.kernel.org
 S:	Supported
 F:	drivers/uio/uio_pci_generic.c
 
+GENERIC VDSO LIBRARY:
+M:	Andy Lutomirski <luto@kernel.org>
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Vincenzo Frascino <vincenzo.frascino@arm.com>
+L:	linux-kernel@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
+S:	Maintained
+F:	lib/vdso/
+F:	kernel/time/vsyscall.c
+F:	include/vdso/
+F:	include/asm-generic/vdso/vsyscall.h
+
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
 S:	Supported
@@ -7301,6 +7313,7 @@ F:	arch/x86/include/asm/trace/hyperv.h
 F:	arch/x86/include/asm/hyperv-tlfs.h
 F:	arch/x86/kernel/cpu/mshyperv.c
 F:	arch/x86/hyperv
+F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
@@ -7311,6 +7324,7 @@ F:	drivers/uio/uio_hv_generic.c
 F:	drivers/video/fbdev/hyperv_fb.c
 F:	drivers/iommu/hyperv_iommu.c
 F:	net/vmw_vsock/hyperv_transport.c
+F:	include/clocksource/hyperv_timer.h
 F:	include/linux/hyperv.h
 F:	include/uapi/linux/hyperv.h
 F:	tools/hv/
diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 4b66ecd6be99..99175812d903 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -4,6 +4,7 @@
 
 #include <asm/barrier.h>
 #include <asm/errno.h>
+#include <asm/hwcap.h>
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -124,6 +125,15 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 	isb();
 }
 
+static inline void arch_timer_set_evtstrm_feature(void)
+{
+	elf_hwcap |= HWCAP_EVTSTRM;
+}
+
+static inline bool arch_timer_have_evtstrm_feature(void)
+{
+	return elf_hwcap & HWCAP_EVTSTRM;
+}
 #endif
 
 #endif
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea0510729..f5eb592b8579 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -107,6 +107,8 @@ config ARM64
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_GETTIMEOFDAY
+	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
@@ -160,6 +162,7 @@ config ARM64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index e9d2e578cbe6..e3d3fd0a4268 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -49,10 +49,26 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
   endif
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
+ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
+  CROSS_COMPILE_COMPAT ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
+
+  ifeq ($(CONFIG_CC_IS_CLANG), y)
+    $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
+  else ifeq ($(CROSS_COMPILE_COMPAT),)
+    $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
+  else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
+    $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
+  else
+    export CROSS_COMPILE_COMPAT
+    export CONFIG_COMPAT_VDSO := y
+    compat_vdso := -DCONFIG_COMPAT_VDSO=1
+  endif
+endif
+
+KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(compat_vdso)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
-KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
+KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
@@ -164,6 +180,9 @@ ifeq ($(KBUILD_EXTMOD),)
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
+	$(if $(CONFIG_COMPAT_VDSO),$(Q)$(MAKE) \
+		$(build)=arch/arm64/kernel/vdso32  \
+		include/generated/vdso32-offsets.h)
 endif
 
 define archhelp
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 6756178c27db..7ae54d7d333a 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -9,6 +9,7 @@
 #define __ASM_ARCH_TIMER_H
 
 #include <asm/barrier.h>
+#include <asm/hwcap.h>
 #include <asm/sysreg.h>
 
 #include <linux/bug.h>
@@ -229,4 +230,16 @@ static inline int arch_timer_arch_init(void)
 	return 0;
 }
 
+static inline void arch_timer_set_evtstrm_feature(void)
+{
+	cpu_set_named_feature(EVTSTRM);
+#ifdef CONFIG_COMPAT
+	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
+#endif
+}
+
+static inline bool arch_timer_have_evtstrm_feature(void)
+{
+	return cpu_have_named_feature(EVTSTRM);
+}
 #endif
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 325d9515c0f8..3c7037c6ba9b 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -202,7 +202,21 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 ({									\
 	set_thread_flag(TIF_32BIT);					\
  })
+#ifdef CONFIG_GENERIC_COMPAT_VDSO
+#define COMPAT_ARCH_DLINFO						\
+do {									\
+	/*								\
+	 * Note that we use Elf64_Off instead of elf_addr_t because	\
+	 * elf_addr_t in compat is defined as Elf32_Addr and casting	\
+	 * current->mm->context.vdso to it triggers a cast warning of	\
+	 * cast from pointer to integer of different size.		\
+	 */								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+			(Elf64_Off)current->mm->context.vdso);		\
+} while (0)
+#else
 #define COMPAT_ARCH_DLINFO
+#endif
 extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
 					  int uses_interp);
 #define compat_arch_setup_additional_pages \
diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 0418c67f2b8b..bd43d1cf724b 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -9,6 +9,52 @@
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
+struct compat_sigcontext {
+	/* We always set these two fields to 0 */
+	compat_ulong_t			trap_no;
+	compat_ulong_t			error_code;
+
+	compat_ulong_t			oldmask;
+	compat_ulong_t			arm_r0;
+	compat_ulong_t			arm_r1;
+	compat_ulong_t			arm_r2;
+	compat_ulong_t			arm_r3;
+	compat_ulong_t			arm_r4;
+	compat_ulong_t			arm_r5;
+	compat_ulong_t			arm_r6;
+	compat_ulong_t			arm_r7;
+	compat_ulong_t			arm_r8;
+	compat_ulong_t			arm_r9;
+	compat_ulong_t			arm_r10;
+	compat_ulong_t			arm_fp;
+	compat_ulong_t			arm_ip;
+	compat_ulong_t			arm_sp;
+	compat_ulong_t			arm_lr;
+	compat_ulong_t			arm_pc;
+	compat_ulong_t			arm_cpsr;
+	compat_ulong_t			fault_address;
+};
+
+struct compat_ucontext {
+	compat_ulong_t			uc_flags;
+	compat_uptr_t			uc_link;
+	compat_stack_t			uc_stack;
+	struct compat_sigcontext	uc_mcontext;
+	compat_sigset_t			uc_sigmask;
+	int 				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
+	compat_ulong_t			uc_regspace[128] __attribute__((__aligned__(8)));
+};
+
+struct compat_sigframe {
+	struct compat_ucontext	uc;
+	compat_ulong_t		retcode[2];
+};
+
+struct compat_rt_sigframe {
+	struct compat_siginfo info;
+	struct compat_sigframe sig;
+};
+
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
 int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index c9f8dd421c5f..2a23614198f1 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -22,8 +22,13 @@
 #define __NR_compat_exit		1
 #define __NR_compat_read		3
 #define __NR_compat_write		4
+#define __NR_compat_gettimeofday	78
 #define __NR_compat_sigreturn		119
 #define __NR_compat_rt_sigreturn	173
+#define __NR_compat_clock_getres	247
+#define __NR_compat_clock_gettime	263
+#define __NR_compat_clock_gettime64	403
+#define __NR_compat_clock_getres_time64	406
 
 /*
  * The following SVCs are ARM private.
diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 1f94ec19903c..9c15e0a06301 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -17,6 +17,9 @@
 #ifndef __ASSEMBLY__
 
 #include <generated/vdso-offsets.h>
+#ifdef CONFIG_COMPAT_VDSO
+#include <generated/vdso32-offsets.h>
+#endif
 
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
new file mode 100644
index 000000000000..fb60a88b5ed4
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/compat_barrier.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 ARM Limited
+ */
+#ifndef __COMPAT_BARRIER_H
+#define __COMPAT_BARRIER_H
+
+#ifndef __ASSEMBLY__
+/*
+ * Warning: This code is meant to be used with
+ * ENABLE_COMPAT_VDSO only.
+ */
+#ifndef ENABLE_COMPAT_VDSO
+#error This header is meant to be used with ENABLE_COMPAT_VDSO only
+#endif
+
+#ifdef dmb
+#undef dmb
+#endif
+
+#define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
+
+#if __LINUX_ARM_ARCH__ >= 8
+#define aarch32_smp_mb()	dmb(ish)
+#define aarch32_smp_rmb()	dmb(ishld)
+#define aarch32_smp_wmb()	dmb(ishst)
+#else
+#define aarch32_smp_mb()	dmb(ish)
+#define aarch32_smp_rmb()	aarch32_smp_mb()
+#define aarch32_smp_wmb()	dmb(ishst)
+#endif
+
+
+#undef smp_mb
+#undef smp_rmb
+#undef smp_wmb
+
+#define smp_mb()	aarch32_smp_mb()
+#define smp_rmb()	aarch32_smp_rmb()
+#define smp_wmb()	aarch32_smp_wmb()
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __COMPAT_BARRIER_H */
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
new file mode 100644
index 000000000000..f4812777f5c5
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 ARM Limited
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/unistd.h>
+#include <uapi/linux/time.h>
+
+#include <asm/vdso/compat_barrier.h>
+
+#define __VDSO_USE_SYSCALL		ULLONG_MAX
+
+#define VDSO_HAS_CLOCK_GETRES		1
+
+static __always_inline
+int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
+			  struct timezone *_tz)
+{
+	register struct timezone *tz asm("r1") = _tz;
+	register struct __kernel_old_timeval *tv asm("r0") = _tv;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_compat_gettimeofday;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline
+long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_compat_clock_gettime64;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline
+int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_compat_clock_getres_time64;
+
+	/* The checks below are required for ABI consistency with arm */
+	if ((_clkid >= MAX_CLOCKS) && (_ts == NULL))
+		return -EINVAL;
+
+	asm volatile(
+	"       swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+{
+	u64 res;
+
+	/*
+	 * clock_mode == 0 implies that vDSO are enabled otherwise
+	 * fallback on syscall.
+	 */
+	if (clock_mode)
+		return __VDSO_USE_SYSCALL;
+
+	/*
+	 * This isb() is required to prevent that the counter value
+	 * is speculated.
+	 */
+	isb();
+	asm volatile("mrrc p15, 1, %Q0, %R0, c14" : "=r" (res));
+	/*
+	 * This isb() is required to prevent that the seq lock is
+	 * speculated.
+	 */
+	isb();
+
+	return res;
+}
+
+static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+{
+	const struct vdso_data *ret;
+
+	/*
+	 * This simply puts &_vdso_data into ret. The reason why we don't use
+	 * `ret = _vdso_data` is that the compiler tends to optimise this in a
+	 * very suboptimal way: instead of keeping &_vdso_data in a register,
+	 * it goes through a relocation almost every time _vdso_data must be
+	 * accessed (even in subfunctions). This is both time and space
+	 * consuming: each relocation uses a word in the code section, and it
+	 * has to be loaded at runtime.
+	 *
+	 * This trick hides the assignment from the compiler. Since it cannot
+	 * track where the pointer comes from, it will only use one relocation
+	 * where __arch_get_vdso_data() is called, and then keep the result in
+	 * a register.
+	 */
+	asm volatile("mov %0, %1" : "=r"(ret) : "r"(_vdso_data));
+
+	return ret;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..b08f476b72b4
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 ARM Limited
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/unistd.h>
+#include <uapi/linux/time.h>
+
+#define __VDSO_USE_SYSCALL		ULLONG_MAX
+
+#define VDSO_HAS_CLOCK_GETRES		1
+
+static __always_inline
+int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
+			  struct timezone *_tz)
+{
+	register struct timezone *tz asm("x1") = _tz;
+	register struct __kernel_old_timeval *tv asm("x0") = _tv;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_gettimeofday;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline
+long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("x1") = _ts;
+	register clockid_t clkid asm("x0") = _clkid;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_clock_gettime;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline
+int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("x1") = _ts;
+	register clockid_t clkid asm("x0") = _clkid;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_clock_getres;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+{
+	u64 res;
+
+	/*
+	 * clock_mode == 0 implies that vDSO are enabled otherwise
+	 * fallback on syscall.
+	 */
+	if (clock_mode)
+		return __VDSO_USE_SYSCALL;
+
+	/*
+	 * This isb() is required to prevent that the counter value
+	 * is speculated.
+	 */
+	isb();
+	asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
+	/*
+	 * This isb() is required to prevent that the seq lock is
+	 * speculated.#
+	 */
+	isb();
+
+	return res;
+}
+
+static __always_inline
+const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return _vdso_data;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
new file mode 100644
index 000000000000..0c731bfc7c8c
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_VSYSCALL_H
+#define __ASM_VDSO_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/timekeeper_internal.h>
+#include <vdso/datapage.h>
+
+#define VDSO_PRECISION_MASK	~(0xFF00ULL<<48)
+
+extern struct vdso_data *vdso_data;
+
+/*
+ * Update the vDSO data page to keep in sync with kernel timekeeping.
+ */
+static __always_inline
+struct vdso_data *__arm64_get_k_vdso_data(void)
+{
+	return vdso_data;
+}
+#define __arch_get_k_vdso_data __arm64_get_k_vdso_data
+
+static __always_inline
+int __arm64_get_clock_mode(struct timekeeper *tk)
+{
+	u32 use_syscall = !tk->tkr_mono.clock->archdata.vdso_direct;
+
+	return use_syscall;
+}
+#define __arch_get_clock_mode __arm64_get_clock_mode
+
+static __always_inline
+int __arm64_use_vsyscall(struct vdso_data *vdata)
+{
+	return !vdata[CS_HRES_COARSE].clock_mode;
+}
+#define __arch_use_vsyscall __arm64_use_vsyscall
+
+static __always_inline
+void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
+{
+	vdata[CS_HRES_COARSE].mask	= VDSO_PRECISION_MASK;
+	vdata[CS_RAW].mask		= VDSO_PRECISION_MASK;
+}
+#define __arch_update_vsyscall __arm64_update_vsyscall
+
+/* The asm-generic header needs to be included after the definitions above */
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 9e7dcb2c31c7..478491f07b4f 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,10 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
-					   sigreturn32.o sys_compat.o
+					   sys_compat.o
+ifneq ($(CONFIG_COMPAT_VDSO), y)
+obj-$(CONFIG_COMPAT)			+= sigreturn32.o
+endif
 obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
@@ -62,6 +65,7 @@ obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 
 obj-y					+= vdso/ probes/
+obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
 
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 02f08768c298..214685760e1c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -18,9 +18,9 @@
 #include <asm/fixmap.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
+#include <asm/signal32.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
-#include <asm/vdso_datapage.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
 
@@ -66,6 +66,11 @@ int main(void)
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
+#ifdef CONFIG_COMPAT
+  DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,		offsetof(struct compat_sigframe, uc.uc_mcontext.arm_r0));
+  DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	offsetof(struct compat_rt_sigframe, sig.uc.uc_mcontext.arm_r0));
+  BLANK();
+#endif
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
   BLANK();
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
@@ -80,33 +85,6 @@ int main(void)
   BLANK();
   DEFINE(PREEMPT_DISABLE_OFFSET, PREEMPT_DISABLE_OFFSET);
   BLANK();
-  DEFINE(CLOCK_REALTIME,	CLOCK_REALTIME);
-  DEFINE(CLOCK_MONOTONIC,	CLOCK_MONOTONIC);
-  DEFINE(CLOCK_MONOTONIC_RAW,	CLOCK_MONOTONIC_RAW);
-  DEFINE(CLOCK_REALTIME_RES,	offsetof(struct vdso_data, hrtimer_res));
-  DEFINE(CLOCK_REALTIME_COARSE,	CLOCK_REALTIME_COARSE);
-  DEFINE(CLOCK_MONOTONIC_COARSE,CLOCK_MONOTONIC_COARSE);
-  DEFINE(CLOCK_COARSE_RES,	LOW_RES_NSEC);
-  DEFINE(NSEC_PER_SEC,		NSEC_PER_SEC);
-  BLANK();
-  DEFINE(VDSO_CS_CYCLE_LAST,	offsetof(struct vdso_data, cs_cycle_last));
-  DEFINE(VDSO_RAW_TIME_SEC,	offsetof(struct vdso_data, raw_time_sec));
-  DEFINE(VDSO_XTIME_CLK_SEC,	offsetof(struct vdso_data, xtime_clock_sec));
-  DEFINE(VDSO_XTIME_CRS_SEC,	offsetof(struct vdso_data, xtime_coarse_sec));
-  DEFINE(VDSO_XTIME_CRS_NSEC,	offsetof(struct vdso_data, xtime_coarse_nsec));
-  DEFINE(VDSO_WTM_CLK_SEC,	offsetof(struct vdso_data, wtm_clock_sec));
-  DEFINE(VDSO_TB_SEQ_COUNT,	offsetof(struct vdso_data, tb_seq_count));
-  DEFINE(VDSO_CS_MONO_MULT,	offsetof(struct vdso_data, cs_mono_mult));
-  DEFINE(VDSO_CS_SHIFT,		offsetof(struct vdso_data, cs_shift));
-  DEFINE(VDSO_TZ_MINWEST,	offsetof(struct vdso_data, tz_minuteswest));
-  DEFINE(VDSO_USE_SYSCALL,	offsetof(struct vdso_data, use_syscall));
-  BLANK();
-  DEFINE(TVAL_TV_SEC,		offsetof(struct timeval, tv_sec));
-  DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
-  BLANK();
-  DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
-  DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
-  BLANK();
   DEFINE(CPU_BOOT_STACK,	offsetof(struct secondary_data, stack));
   DEFINE(CPU_BOOT_TASK,		offsetof(struct secondary_data, task));
   BLANK();
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 331d1e5acad4..12a585386c2f 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -18,42 +18,7 @@
 #include <asm/traps.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
-
-struct compat_sigcontext {
-	/* We always set these two fields to 0 */
-	compat_ulong_t			trap_no;
-	compat_ulong_t			error_code;
-
-	compat_ulong_t			oldmask;
-	compat_ulong_t			arm_r0;
-	compat_ulong_t			arm_r1;
-	compat_ulong_t			arm_r2;
-	compat_ulong_t			arm_r3;
-	compat_ulong_t			arm_r4;
-	compat_ulong_t			arm_r5;
-	compat_ulong_t			arm_r6;
-	compat_ulong_t			arm_r7;
-	compat_ulong_t			arm_r8;
-	compat_ulong_t			arm_r9;
-	compat_ulong_t			arm_r10;
-	compat_ulong_t			arm_fp;
-	compat_ulong_t			arm_ip;
-	compat_ulong_t			arm_sp;
-	compat_ulong_t			arm_lr;
-	compat_ulong_t			arm_pc;
-	compat_ulong_t			arm_cpsr;
-	compat_ulong_t			fault_address;
-};
-
-struct compat_ucontext {
-	compat_ulong_t			uc_flags;
-	compat_uptr_t			uc_link;
-	compat_stack_t			uc_stack;
-	struct compat_sigcontext	uc_mcontext;
-	compat_sigset_t			uc_sigmask;
-	int		__unused[32 - (sizeof (compat_sigset_t) / sizeof (int))];
-	compat_ulong_t	uc_regspace[128] __attribute__((__aligned__(8)));
-};
+#include <asm/vdso.h>
 
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
@@ -81,16 +46,6 @@ struct compat_aux_sigframe {
 	unsigned long			end_magic;
 } __attribute__((__aligned__(8)));
 
-struct compat_sigframe {
-	struct compat_ucontext	uc;
-	compat_ulong_t		retcode[2];
-};
-
-struct compat_rt_sigframe {
-	struct compat_siginfo info;
-	struct compat_sigframe sig;
-};
-
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
@@ -387,6 +342,30 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+#ifdef CONFIG_COMPAT_VDSO
+		void *vdso_base = current->mm->context.vdso;
+		void *vdso_trampoline;
+
+		if (ka->sa.sa_flags & SA_SIGINFO) {
+			if (thumb) {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_rt_sigreturn_thumb);
+			} else {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_rt_sigreturn_arm);
+			}
+		} else {
+			if (thumb) {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_sigreturn_thumb);
+			} else {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_sigreturn_arm);
+			}
+		}
+
+		retcode = ptr_to_compat(vdso_trampoline) + thumb;
+#else
 		unsigned int idx = thumb << 1;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
@@ -394,6 +373,7 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 
 		retcode = (unsigned long)current->mm->context.vdso +
 			  (idx << 2) + thumb;
+#endif
 	}
 
 	regs->regs[0]	= usig;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 663b166241d0..354b11e27c07 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -20,41 +20,212 @@
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
+#include <vdso/vsyscall.h>
 
 #include <asm/cacheflush.h>
 #include <asm/signal32.h>
 #include <asm/vdso.h>
-#include <asm/vdso_datapage.h>
 
 extern char vdso_start[], vdso_end[];
-static unsigned long vdso_pages __ro_after_init;
+#ifdef CONFIG_COMPAT_VDSO
+extern char vdso32_start[], vdso32_end[];
+#endif /* CONFIG_COMPAT_VDSO */
+
+/* vdso_lookup arch_index */
+enum arch_vdso_type {
+	ARM64_VDSO = 0,
+#ifdef CONFIG_COMPAT_VDSO
+	ARM64_VDSO32 = 1,
+#endif /* CONFIG_COMPAT_VDSO */
+};
+#ifdef CONFIG_COMPAT_VDSO
+#define VDSO_TYPES		(ARM64_VDSO32 + 1)
+#else
+#define VDSO_TYPES		(ARM64_VDSO + 1)
+#endif /* CONFIG_COMPAT_VDSO */
+
+struct __vdso_abi {
+	const char *name;
+	const char *vdso_code_start;
+	const char *vdso_code_end;
+	unsigned long vdso_pages;
+	/* Data Mapping */
+	struct vm_special_mapping *dm;
+	/* Code Mapping */
+	struct vm_special_mapping *cm;
+};
+
+static struct __vdso_abi vdso_lookup[VDSO_TYPES] __ro_after_init = {
+	{
+		.name = "vdso",
+		.vdso_code_start = vdso_start,
+		.vdso_code_end = vdso_end,
+	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "vdso32",
+		.vdso_code_start = vdso32_start,
+		.vdso_code_end = vdso32_end,
+	},
+#endif /* CONFIG_COMPAT_VDSO */
+};
 
 /*
  * The vDSO data page.
  */
 static union {
-	struct vdso_data	data;
+	struct vdso_data	data[CS_BASES];
 	u8			page[PAGE_SIZE];
 } vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = &vdso_data_store.data;
+struct vdso_data *vdso_data = vdso_data_store.data;
+
+static int __vdso_remap(enum arch_vdso_type arch_index,
+			const struct vm_special_mapping *sm,
+			struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+	unsigned long vdso_size = vdso_lookup[arch_index].vdso_code_end -
+				  vdso_lookup[arch_index].vdso_code_start;
+
+	if (vdso_size != new_size)
+		return -EINVAL;
+
+	current->mm->context.vdso = (void *)new_vma->vm_start;
+
+	return 0;
+}
+
+static int __vdso_init(enum arch_vdso_type arch_index)
+{
+	int i;
+	struct page **vdso_pagelist;
+	unsigned long pfn;
+
+	if (memcmp(vdso_lookup[arch_index].vdso_code_start, "\177ELF", 4)) {
+		pr_err("vDSO is not a valid ELF object!\n");
+		return -EINVAL;
+	}
+
+	vdso_lookup[arch_index].vdso_pages = (
+			vdso_lookup[arch_index].vdso_code_end -
+			vdso_lookup[arch_index].vdso_code_start) >>
+			PAGE_SHIFT;
+
+	/* Allocate the vDSO pagelist, plus a page for the data. */
+	vdso_pagelist = kcalloc(vdso_lookup[arch_index].vdso_pages + 1,
+				sizeof(struct page *),
+				GFP_KERNEL);
+	if (vdso_pagelist == NULL)
+		return -ENOMEM;
+
+	/* Grab the vDSO data page. */
+	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
+
+
+	/* Grab the vDSO code pages. */
+	pfn = sym_to_pfn(vdso_lookup[arch_index].vdso_code_start);
+
+	for (i = 0; i < vdso_lookup[arch_index].vdso_pages; i++)
+		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
+
+	vdso_lookup[arch_index].dm->pages = &vdso_pagelist[0];
+	vdso_lookup[arch_index].cm->pages = &vdso_pagelist[1];
+
+	return 0;
+}
+
+static int __setup_additional_pages(enum arch_vdso_type arch_index,
+				    struct mm_struct *mm,
+				    struct linux_binprm *bprm,
+				    int uses_interp)
+{
+	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
+	void *ret;
+
+	vdso_text_len = vdso_lookup[arch_index].vdso_pages << PAGE_SHIFT;
+	/* Be sure to map the data page */
+	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+
+	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		ret = ERR_PTR(vdso_base);
+		goto up_fail;
+	}
+
+	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
+				       VM_READ|VM_MAYREAD,
+				       vdso_lookup[arch_index].dm);
+	if (IS_ERR(ret))
+		goto up_fail;
+
+	vdso_base += PAGE_SIZE;
+	mm->context.vdso = (void *)vdso_base;
+	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
+				       VM_READ|VM_EXEC|
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       vdso_lookup[arch_index].cm);
+	if (IS_ERR(ret))
+		goto up_fail;
+
+	return 0;
+
+up_fail:
+	mm->context.vdso = NULL;
+	return PTR_ERR(ret);
+}
 
 #ifdef CONFIG_COMPAT
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
+#ifdef CONFIG_COMPAT_VDSO
+static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	return __vdso_remap(ARM64_VDSO32, sm, new_vma);
+}
+#endif /* CONFIG_COMPAT_VDSO */
+
+/*
+ * aarch32_vdso_pages:
+ * 0 - kuser helpers
+ * 1 - sigreturn code
+ * or (CONFIG_COMPAT_VDSO):
+ * 0 - kuser helpers
+ * 1 - vdso data
+ * 2 - vdso code
+ */
 #define C_VECTORS	0
+#ifdef CONFIG_COMPAT_VDSO
+#define C_VVAR		1
+#define C_VDSO		2
+#define C_PAGES		(C_VDSO + 1)
+#else
 #define C_SIGPAGE	1
 #define C_PAGES		(C_SIGPAGE + 1)
+#endif /* CONFIG_COMPAT_VDSO */
 static struct page *aarch32_vdso_pages[C_PAGES] __ro_after_init;
-static const struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
+static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
 	{
 		.name	= "[vectors]", /* ABI */
 		.pages	= &aarch32_vdso_pages[C_VECTORS],
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "[vvar]",
+	},
+	{
+		.name = "[vdso]",
+		.mremap = aarch32_vdso_mremap,
+	},
+#else
 	{
 		.name	= "[sigpage]", /* ABI */
 		.pages	= &aarch32_vdso_pages[C_SIGPAGE],
 	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 static int aarch32_alloc_kuser_vdso_page(void)
@@ -77,7 +248,33 @@ static int aarch32_alloc_kuser_vdso_page(void)
 	return 0;
 }
 
-static int __init aarch32_alloc_vdso_pages(void)
+#ifdef CONFIG_COMPAT_VDSO
+static int __aarch32_alloc_vdso_pages(void)
+{
+	int ret;
+
+	vdso_lookup[ARM64_VDSO32].dm = &aarch32_vdso_spec[C_VVAR];
+	vdso_lookup[ARM64_VDSO32].cm = &aarch32_vdso_spec[C_VDSO];
+
+	ret = __vdso_init(ARM64_VDSO32);
+	if (ret)
+		return ret;
+
+	ret = aarch32_alloc_kuser_vdso_page();
+	if (ret) {
+		unsigned long c_vvar =
+			(unsigned long)page_to_virt(aarch32_vdso_pages[C_VVAR]);
+		unsigned long c_vdso =
+			(unsigned long)page_to_virt(aarch32_vdso_pages[C_VDSO]);
+
+		free_page(c_vvar);
+		free_page(c_vdso);
+	}
+
+	return ret;
+}
+#else
+static int __aarch32_alloc_vdso_pages(void)
 {
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
 	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
@@ -98,6 +295,12 @@ static int __init aarch32_alloc_vdso_pages(void)
 
 	return ret;
 }
+#endif /* CONFIG_COMPAT_VDSO */
+
+static int __init aarch32_alloc_vdso_pages(void)
+{
+	return __aarch32_alloc_vdso_pages();
+}
 arch_initcall(aarch32_alloc_vdso_pages);
 
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
@@ -119,6 +322,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
+#ifndef CONFIG_COMPAT_VDSO
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
 	unsigned long addr;
@@ -146,6 +350,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 out:
 	return PTR_ERR_OR_ZERO(ret);
 }
+#endif /* !CONFIG_COMPAT_VDSO */
 
 int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
@@ -159,7 +364,14 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (ret)
 		goto out;
 
+#ifdef CONFIG_COMPAT_VDSO
+	ret = __setup_additional_pages(ARM64_VDSO32,
+				       mm,
+				       bprm,
+				       uses_interp);
+#else
 	ret = aarch32_sigreturn_setup(mm);
+#endif /* CONFIG_COMPAT_VDSO */
 
 out:
 	up_write(&mm->mmap_sem);
@@ -170,18 +382,18 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
-	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
-	unsigned long vdso_size = vdso_end - vdso_start;
-
-	if (vdso_size != new_size)
-		return -EINVAL;
-
-	current->mm->context.vdso = (void *)new_vma->vm_start;
-
-	return 0;
+	return __vdso_remap(ARM64_VDSO, sm, new_vma);
 }
 
-static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
+/*
+ * aarch64_vdso_pages:
+ * 0 - vvar
+ * 1 - vdso
+ */
+#define A_VVAR		0
+#define A_VDSO		1
+#define A_PAGES		(A_VDSO + 1)
+static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
 	{
 		.name	= "[vvar]",
 	},
@@ -193,37 +405,10 @@ static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
 
 static int __init vdso_init(void)
 {
-	int i;
-	struct page **vdso_pagelist;
-	unsigned long pfn;
-
-	if (memcmp(vdso_start, "\177ELF", 4)) {
-		pr_err("vDSO is not a valid ELF object!\n");
-		return -EINVAL;
-	}
-
-	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
-
-	/* Allocate the vDSO pagelist, plus a page for the data. */
-	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
-				GFP_KERNEL);
-	if (vdso_pagelist == NULL)
-		return -ENOMEM;
-
-	/* Grab the vDSO data page. */
-	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
-
-
-	/* Grab the vDSO code pages. */
-	pfn = sym_to_pfn(vdso_start);
-
-	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
+	vdso_lookup[ARM64_VDSO].dm = &vdso_spec[A_VVAR];
+	vdso_lookup[ARM64_VDSO].cm = &vdso_spec[A_VDSO];
 
-	vdso_spec[0].pages = &vdso_pagelist[0];
-	vdso_spec[1].pages = &vdso_pagelist[1];
-
-	return 0;
+	return __vdso_init(ARM64_VDSO);
 }
 arch_initcall(vdso_init);
 
@@ -231,84 +416,17 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 				int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
-	void *ret;
-
-	vdso_text_len = vdso_pages << PAGE_SHIFT;
-	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+	int ret;
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
-	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
-	if (IS_ERR_VALUE(vdso_base)) {
-		ret = ERR_PTR(vdso_base);
-		goto up_fail;
-	}
-	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
-				       VM_READ|VM_MAYREAD,
-				       &vdso_spec[0]);
-	if (IS_ERR(ret))
-		goto up_fail;
-
-	vdso_base += PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
-	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
-				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
-				       &vdso_spec[1]);
-	if (IS_ERR(ret))
-		goto up_fail;
 
+	ret = __setup_additional_pages(ARM64_VDSO,
+				       mm,
+				       bprm,
+				       uses_interp);
 
 	up_write(&mm->mmap_sem);
-	return 0;
-
-up_fail:
-	mm->context.vdso = NULL;
-	up_write(&mm->mmap_sem);
-	return PTR_ERR(ret);
-}
 
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-void update_vsyscall(struct timekeeper *tk)
-{
-	u32 use_syscall = !tk->tkr_mono.clock->archdata.vdso_direct;
-
-	++vdso_data->tb_seq_count;
-	smp_wmb();
-
-	vdso_data->use_syscall			= use_syscall;
-	vdso_data->xtime_coarse_sec		= tk->xtime_sec;
-	vdso_data->xtime_coarse_nsec		= tk->tkr_mono.xtime_nsec >>
-							tk->tkr_mono.shift;
-	vdso_data->wtm_clock_sec		= tk->wall_to_monotonic.tv_sec;
-	vdso_data->wtm_clock_nsec		= tk->wall_to_monotonic.tv_nsec;
-
-	/* Read without the seqlock held by clock_getres() */
-	WRITE_ONCE(vdso_data->hrtimer_res, hrtimer_resolution);
-
-	if (!use_syscall) {
-		/* tkr_mono.cycle_last == tkr_raw.cycle_last */
-		vdso_data->cs_cycle_last	= tk->tkr_mono.cycle_last;
-		vdso_data->raw_time_sec         = tk->raw_sec;
-		vdso_data->raw_time_nsec        = tk->tkr_raw.xtime_nsec;
-		vdso_data->xtime_clock_sec	= tk->xtime_sec;
-		vdso_data->xtime_clock_nsec	= tk->tkr_mono.xtime_nsec;
-		vdso_data->cs_mono_mult		= tk->tkr_mono.mult;
-		vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
-		/* tkr_mono.shift == tkr_raw.shift */
-		vdso_data->cs_shift		= tk->tkr_mono.shift;
-	}
-
-	smp_wmb();
-	++vdso_data->tb_seq_count;
-}
-
-void update_vsyscall_tz(void)
-{
-	vdso_data->tz_minuteswest	= sys_tz.tz_minuteswest;
-	vdso_data->tz_dsttime		= sys_tz.tz_dsttime;
+	return ret;
 }
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index fa230ff09aa1..4ab863045188 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -6,7 +6,12 @@
 # Heavily based on the vDSO Makefiles for other archs.
 #
 
-obj-vdso := gettimeofday.o note.o sigreturn.o
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_AARCH64_JUMP_SLOT|R_AARCH64_GLOB_DAT|R_AARCH64_ABS64
+include $(srctree)/lib/vdso/Makefile
+
+obj-vdso := vgettimeofday.o note.o sigreturn.o
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg
@@ -15,6 +20,31 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
 		--build-id -n -T
 
+ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
+ccflags-y += -DDISABLE_BRANCH_PROFILING
+
+VDSO_LDFLAGS := -Bsymbolic
+
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
+KBUILD_CFLAGS			+= $(DISABLE_LTO)
+KASAN_SANITIZE			:= n
+UBSAN_SANITIZE			:= n
+OBJECT_FILES_NON_STANDARD	:= y
+KCOV_INSTRUMENT			:= n
+
+ifeq ($(c-gettimeofday-y),)
+CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny
+else
+CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -include $(c-gettimeofday-y)
+endif
+
+# Clang versions less than 8 do not support -mcmodel=tiny
+ifeq ($(CONFIG_CC_IS_CLANG), y)
+  ifeq ($(shell test $(CONFIG_CLANG_VERSION) -lt 80000; echo $$?),0)
+    CFLAGS_REMOVE_vgettimeofday.o += -mcmodel=tiny
+  endif
+endif
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
@@ -28,6 +58,7 @@ $(obj)/vdso.o : $(obj)/vdso.so
 # Link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,ld)
+	$(call if_changed,vdso_check)
 
 # Strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
@@ -42,13 +73,9 @@ quiet_cmd_vdsosym = VDSOSYM $@
 include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
-# Assembly rules for the .S files
-$(obj-vdso): %.o: %.S FORCE
-	$(call if_changed_dep,vdsoas)
-
 # Actual build commands
-quiet_cmd_vdsoas = VDSOA   $@
-      cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
+quiet_cmd_vdsocc = VDSOCC   $@
+      cmd_vdsocc = $(CC) $(a_flags) $(c_flags) -c -o $@ $<
 
 # Install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index 80f780f56e0d..e69de29bb2d1 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -1,323 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Userspace implementations of gettimeofday() and friends.
- *
- * Copyright (C) 2012 ARM Limited
- *
- * Author: Will Deacon <will.deacon@arm.com>
- */
-
-#include <linux/linkage.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-
-#define NSEC_PER_SEC_LO16	0xca00
-#define NSEC_PER_SEC_HI16	0x3b9a
-
-vdso_data	.req	x6
-seqcnt		.req	w7
-w_tmp		.req	w8
-x_tmp		.req	x8
-
-/*
- * Conventions for macro arguments:
- * - An argument is write-only if its name starts with "res".
- * - All other arguments are read-only, unless otherwise specified.
- */
-
-	.macro	seqcnt_acquire
-9999:	ldr	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	tbnz	seqcnt, #0, 9999b
-	dmb	ishld
-	.endm
-
-	.macro	seqcnt_check fail
-	dmb	ishld
-	ldr	w_tmp, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	cmp	w_tmp, seqcnt
-	b.ne	\fail
-	.endm
-
-	.macro	syscall_check fail
-	ldr	w_tmp, [vdso_data, #VDSO_USE_SYSCALL]
-	cbnz	w_tmp, \fail
-	.endm
-
-	.macro get_nsec_per_sec res
-	mov	\res, #NSEC_PER_SEC_LO16
-	movk	\res, #NSEC_PER_SEC_HI16, lsl #16
-	.endm
-
-	/*
-	 * Returns the clock delta, in nanoseconds left-shifted by the clock
-	 * shift.
-	 */
-	.macro	get_clock_shifted_nsec res, cycle_last, mult
-	/* Read the virtual counter. */
-	isb
-	mrs	x_tmp, cntvct_el0
-	/* Calculate cycle delta and convert to ns. */
-	sub	\res, x_tmp, \cycle_last
-	/* We can only guarantee 56 bits of precision. */
-	movn	x_tmp, #0xff00, lsl #48
-	and	\res, x_tmp, \res
-	mul	\res, \res, \mult
-	/*
-	 * Fake address dependency from the value computed from the counter
-	 * register to subsequent data page accesses so that the sequence
-	 * locking also orders the read of the counter.
-	 */
-	and	x_tmp, \res, xzr
-	add	vdso_data, vdso_data, x_tmp
-	.endm
-
-	/*
-	 * Returns in res_{sec,nsec} the REALTIME timespec, based on the
-	 * "wall time" (xtime) and the clock_mono delta.
-	 */
-	.macro	get_ts_realtime res_sec, res_nsec, \
-			clock_nsec, xtime_sec, xtime_nsec, nsec_to_sec
-	add	\res_nsec, \clock_nsec, \xtime_nsec
-	udiv	x_tmp, \res_nsec, \nsec_to_sec
-	add	\res_sec, \xtime_sec, x_tmp
-	msub	\res_nsec, x_tmp, \nsec_to_sec, \res_nsec
-	.endm
-
-	/*
-	 * Returns in res_{sec,nsec} the timespec based on the clock_raw delta,
-	 * used for CLOCK_MONOTONIC_RAW.
-	 */
-	.macro	get_ts_clock_raw res_sec, res_nsec, clock_nsec, nsec_to_sec
-	udiv	\res_sec, \clock_nsec, \nsec_to_sec
-	msub	\res_nsec, \res_sec, \nsec_to_sec, \clock_nsec
-	.endm
-
-	/* sec and nsec are modified in place. */
-	.macro add_ts sec, nsec, ts_sec, ts_nsec, nsec_to_sec
-	/* Add timespec. */
-	add	\sec, \sec, \ts_sec
-	add	\nsec, \nsec, \ts_nsec
-
-	/* Normalise the new timespec. */
-	cmp	\nsec, \nsec_to_sec
-	b.lt	9999f
-	sub	\nsec, \nsec, \nsec_to_sec
-	add	\sec, \sec, #1
-9999:
-	cmp	\nsec, #0
-	b.ge	9998f
-	add	\nsec, \nsec, \nsec_to_sec
-	sub	\sec, \sec, #1
-9998:
-	.endm
-
-	.macro clock_gettime_return, shift=0
-	.if \shift == 1
-	lsr	x11, x11, x12
-	.endif
-	stp	x10, x11, [x1, #TSPEC_TV_SEC]
-	mov	x0, xzr
-	ret
-	.endm
-
-	.macro jump_slot jumptable, index, label
-	.if (. - \jumptable) != 4 * (\index)
-	.error "Jump slot index mismatch"
-	.endif
-	b	\label
-	.endm
-
-	.text
-
-/* int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz); */
-ENTRY(__kernel_gettimeofday)
-	.cfi_startproc
-	adr	vdso_data, _vdso_data
-	/* If tv is NULL, skip to the timezone code. */
-	cbz	x0, 2f
-
-	/* Compute the time of day. */
-1:	seqcnt_acquire
-	syscall_check fail=4f
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	seqcnt_check fail=1b
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-
-	/* Convert ns to us. */
-	mov	x13, #1000
-	lsl	x13, x13, x12
-	udiv	x11, x11, x13
-	stp	x10, x11, [x0, #TVAL_TV_SEC]
-2:
-	/* If tz is NULL, return 0. */
-	cbz	x1, 3f
-	ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST]
-	stp	w4, w5, [x1, #TZ_MINWEST]
-3:
-	mov	x0, xzr
-	ret
-4:
-	/* Syscall fallback. */
-	mov	x8, #__NR_gettimeofday
-	svc	#0
-	ret
-	.cfi_endproc
-ENDPROC(__kernel_gettimeofday)
-
-#define JUMPSLOT_MAX CLOCK_MONOTONIC_COARSE
-
-/* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
-ENTRY(__kernel_clock_gettime)
-	.cfi_startproc
-	cmp	w0, #JUMPSLOT_MAX
-	b.hi	syscall
-	adr	vdso_data, _vdso_data
-	adr	x_tmp, jumptable
-	add	x_tmp, x_tmp, w0, uxtw #2
-	br	x_tmp
-
-	ALIGN
-jumptable:
-	jump_slot jumptable, CLOCK_REALTIME, realtime
-	jump_slot jumptable, CLOCK_MONOTONIC, monotonic
-	b	syscall
-	b	syscall
-	jump_slot jumptable, CLOCK_MONOTONIC_RAW, monotonic_raw
-	jump_slot jumptable, CLOCK_REALTIME_COARSE, realtime_coarse
-	jump_slot jumptable, CLOCK_MONOTONIC_COARSE, monotonic_coarse
-
-	.if (. - jumptable) != 4 * (JUMPSLOT_MAX + 1)
-	.error	"Wrong jumptable size"
-	.endif
-
-	ALIGN
-realtime:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-
-	/* All computations are done with left-shifted nsecs. */
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	seqcnt_check fail=realtime
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-monotonic:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	ldp	x3, x4, [vdso_data, #VDSO_WTM_CLK_SEC]
-
-	/* All computations are done with left-shifted nsecs. */
-	lsl	x4, x4, x12
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	seqcnt_check fail=monotonic
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-
-	add_ts sec=x10, nsec=x11, ts_sec=x3, ts_nsec=x4, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-monotonic_raw:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_raw_mult, w12 = cs_shift */
-	ldp	w12, w11, [vdso_data, #VDSO_CS_SHIFT]
-	ldp	x13, x14, [vdso_data, #VDSO_RAW_TIME_SEC]
-
-	/* All computations are done with left-shifted nsecs. */
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	seqcnt_check fail=monotonic_raw
-	get_ts_clock_raw res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, nsec_to_sec=x9
-
-	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-realtime_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	seqcnt_check fail=realtime_coarse
-	clock_gettime_return
-
-	ALIGN
-monotonic_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	ldp	x13, x14, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic_coarse
-
-	/* Computations are done in (non-shifted) nsecs. */
-	get_nsec_per_sec res=x9
-	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return
-
-	ALIGN
-syscall: /* Syscall fallback. */
-	mov	x8, #__NR_clock_gettime
-	svc	#0
-	ret
-	.cfi_endproc
-ENDPROC(__kernel_clock_gettime)
-
-/* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
-ENTRY(__kernel_clock_getres)
-	.cfi_startproc
-	cmp	w0, #CLOCK_REALTIME
-	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
-	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
-	b.ne	1f
-
-	adr	vdso_data, _vdso_data
-	ldr	w2, [vdso_data, #CLOCK_REALTIME_RES]
-	b	2f
-1:
-	cmp	w0, #CLOCK_REALTIME_COARSE
-	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
-	b.ne	4f
-	ldr	x2, 5f
-2:
-	cbz	x1, 3f
-	stp	xzr, x2, [x1]
-
-3:	/* res == NULL. */
-	mov	w0, wzr
-	ret
-
-4:	/* Syscall fallback. */
-	mov	x8, #__NR_clock_getres
-	svc	#0
-	ret
-5:
-	.quad	CLOCK_COARSE_RES
-	.cfi_endproc
-ENDPROC(__kernel_clock_getres)
diff --git a/arch/arm64/kernel/vdso/vgettimeofday.c b/arch/arm64/kernel/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..747635501a14
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vgettimeofday.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM64 userspace implementations of gettimeofday() and similar.
+ *
+ * Copyright (C) 2018 ARM Limited
+ *
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+int __kernel_clock_gettime(clockid_t clock,
+			   struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
+			  struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+int __kernel_clock_getres(clockid_t clock_id,
+			  struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock_id, res);
+}
diff --git a/arch/arm64/kernel/vdso32/.gitignore b/arch/arm64/kernel/vdso32/.gitignore
new file mode 100644
index 000000000000..4fea950fa5ed
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/.gitignore
@@ -0,0 +1,2 @@
+vdso.lds
+vdso.so.raw
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
new file mode 100644
index 000000000000..288c14d30b45
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -0,0 +1,186 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for vdso32
+#
+
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_ARM_JUMP_SLOT|R_ARM_GLOB_DAT|R_ARM_ABS32
+include $(srctree)/lib/vdso/Makefile
+
+COMPATCC := $(CROSS_COMPILE_COMPAT)gcc
+
+# Same as cc-*option, but using COMPATCC instead of CC
+cc32-option = $(call try-run,\
+        $(COMPATCC) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
+cc32-disable-warning = $(call try-run,\
+	$(COMPATCC) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
+cc32-ldoption = $(call try-run,\
+        $(COMPATCC) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
+
+# We cannot use the global flags to compile the vDSO files, the main reason
+# being that the 32-bit compiler may be older than the main (64-bit) compiler
+# and therefore may not understand flags set using $(cc-option ...). Besides,
+# arch-specific options should be taken from the arm Makefile instead of the
+# arm64 one.
+# As a result we set our own flags here.
+
+# From top-level Makefile
+# NOSTDINC_FLAGS
+VDSO_CPPFLAGS := -nostdinc -isystem $(shell $(COMPATCC) -print-file-name=include)
+VDSO_CPPFLAGS += $(LINUXINCLUDE)
+VDSO_CPPFLAGS += $(KBUILD_CPPFLAGS)
+
+# Common C and assembly flags
+# From top-level Makefile
+VDSO_CAFLAGS := $(VDSO_CPPFLAGS)
+VDSO_CAFLAGS += $(call cc32-option,-fno-PIE)
+ifdef CONFIG_DEBUG_INFO
+VDSO_CAFLAGS += -g
+endif
+ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(COMPATCC)), y)
+VDSO_CAFLAGS += -DCC_HAVE_ASM_GOTO
+endif
+
+# From arm Makefile
+VDSO_CAFLAGS += $(call cc32-option,-fno-dwarf2-cfi-asm)
+VDSO_CAFLAGS += -mabi=aapcs-linux -mfloat-abi=soft
+ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
+VDSO_CAFLAGS += -mbig-endian
+else
+VDSO_CAFLAGS += -mlittle-endian
+endif
+
+# From arm vDSO Makefile
+VDSO_CAFLAGS += -fPIC -fno-builtin -fno-stack-protector
+VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
+
+# Try to compile for ARMv8. If the compiler is too old and doesn't support it,
+# fall back to v7. There is no easy way to check for what architecture the code
+# is being compiled, so define a macro specifying that (see arch/arm/Makefile).
+VDSO_CAFLAGS += $(call cc32-option,-march=armv8-a -D__LINUX_ARM_ARCH__=8,\
+                                   -march=armv7-a -D__LINUX_ARM_ARCH__=7)
+
+VDSO_CFLAGS := $(VDSO_CAFLAGS)
+VDSO_CFLAGS += -DENABLE_COMPAT_VDSO=1
+# KBUILD_CFLAGS from top-level Makefile
+VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
+               -fno-strict-aliasing -fno-common \
+               -Werror-implicit-function-declaration \
+               -Wno-format-security \
+               -std=gnu89
+VDSO_CFLAGS  += -O2
+# Some useful compiler-dependent flags from top-level Makefile
+VDSO_CFLAGS += $(call cc32-option,-Wdeclaration-after-statement,)
+VDSO_CFLAGS += $(call cc32-option,-Wno-pointer-sign)
+VDSO_CFLAGS += $(call cc32-option,-fno-strict-overflow)
+VDSO_CFLAGS += $(call cc32-option,-Werror=strict-prototypes)
+VDSO_CFLAGS += $(call cc32-option,-Werror=date-time)
+VDSO_CFLAGS += $(call cc32-option,-Werror=incompatible-pointer-types)
+
+# The 32-bit compiler does not provide 128-bit integers, which are used in
+# some headers that are indirectly included from the vDSO code.
+# This hack makes the compiler happy and should trigger a warning/error if
+# variables of such type are referenced.
+VDSO_CFLAGS += -D__uint128_t='void*'
+# Silence some warnings coming from headers that operate on long's
+# (on GCC 4.8 or older, there is unfortunately no way to silence this warning)
+VDSO_CFLAGS += $(call cc32-disable-warning,shift-count-overflow)
+VDSO_CFLAGS += -Wno-int-to-pointer-cast
+
+VDSO_AFLAGS := $(VDSO_CAFLAGS)
+VDSO_AFLAGS += -D__ASSEMBLY__
+
+VDSO_LDFLAGS := $(VDSO_CPPFLAGS)
+# From arm vDSO Makefile
+VDSO_LDFLAGS += -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
+VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
+VDSO_LDFLAGS += -nostdlib -shared -mfloat-abi=soft
+VDSO_LDFLAGS += $(call cc32-ldoption,-Wl$(comma)--hash-style=sysv)
+VDSO_LDFLAGS += $(call cc32-ldoption,-Wl$(comma)--build-id)
+VDSO_LDFLAGS += $(call cc32-ldoption,-fuse-ld=bfd)
+
+
+# Borrow vdsomunge.c from the arm vDSO
+# We have to use a relative path because scripts/Makefile.host prefixes
+# $(hostprogs-y) with $(obj)
+munge := ../../../arm/vdso/vdsomunge
+hostprogs-y := $(munge)
+
+c-obj-vdso := note.o
+c-obj-vdso-gettimeofday := vgettimeofday.o
+asm-obj-vdso := sigreturn.o
+
+ifneq ($(c-gettimeofday-y),)
+VDSO_CFLAGS_gettimeofday_o += -include $(c-gettimeofday-y)
+endif
+
+VDSO_CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
+
+# Build rules
+targets := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso) vdso.so vdso.so.dbg vdso.so.raw
+c-obj-vdso := $(addprefix $(obj)/, $(c-obj-vdso))
+c-obj-vdso-gettimeofday := $(addprefix $(obj)/, $(c-obj-vdso-gettimeofday))
+asm-obj-vdso := $(addprefix $(obj)/, $(asm-obj-vdso))
+obj-vdso := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso)
+
+obj-y += vdso.o
+extra-y += vdso.lds
+CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+
+# Force dependency (vdso.s includes vdso.so through incbin)
+$(obj)/vdso.o: $(obj)/vdso.so
+
+include/generated/vdso32-offsets.h: $(obj)/vdso.so.dbg FORCE
+	$(call if_changed,vdsosym)
+
+# Strip rule for vdso.so
+$(obj)/vdso.so: OBJCOPYFLAGS := -S
+$(obj)/vdso.so: $(obj)/vdso.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/vdso.so.dbg: $(obj)/vdso.so.raw $(obj)/$(munge) FORCE
+	$(call if_changed,vdsomunge)
+
+# Link rule for the .so file, .lds has to be first
+$(obj)/vdso.so.raw: $(src)/vdso.lds $(obj-vdso) FORCE
+	$(call if_changed,vdsold)
+	$(call if_changed,vdso_check)
+
+# Compilation rules for the vDSO sources
+$(c-obj-vdso): %.o: %.c FORCE
+	$(call if_changed_dep,vdsocc)
+$(c-obj-vdso-gettimeofday): %.o: %.c FORCE
+	$(call if_changed_dep,vdsocc_gettimeofday)
+$(asm-obj-vdso): %.o: %.S FORCE
+	$(call if_changed_dep,vdsoas)
+
+# Actual build commands
+quiet_cmd_vdsold = VDSOL   $@
+      cmd_vdsold = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_LDFLAGS) \
+                   -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
+quiet_cmd_vdsocc = VDSOC   $@
+      cmd_vdsocc = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) -c -o $@ $<
+quiet_cmd_vdsocc_gettimeofday = VDSOC_GTD   $@
+      cmd_vdsocc_gettimeofday = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) $(VDSO_CFLAGS_gettimeofday_o) -c -o $@ $<
+quiet_cmd_vdsoas = VDSOA   $@
+      cmd_vdsoas = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_AFLAGS) -c -o $@ $<
+
+quiet_cmd_vdsomunge = MUNGE   $@
+      cmd_vdsomunge = $(obj)/$(munge) $< $@
+
+# Generate vDSO offsets using helper script (borrowed from the 64-bit vDSO)
+gen-vdsosym := $(srctree)/$(src)/../vdso/gen_vdso_offsets.sh
+quiet_cmd_vdsosym = VDSOSYM $@
+# The AArch64 nm should be able to read an AArch32 binary
+      cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+
+# Install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/vdso32.so
+
+vdso.so: $(obj)/vdso.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso.so
diff --git a/arch/arm64/kernel/vdso32/note.c b/arch/arm64/kernel/vdso32/note.c
new file mode 100644
index 000000000000..eff5bf9efb8b
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/note.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012-2018 ARM Limited
+ *
+ * This supplies .note.* sections to go into the PT_NOTE inside the vDSO text.
+ * Here we can supply some information useful to userland.
+ */
+
+#include <linux/uts.h>
+#include <linux/version.h>
+#include <linux/elfnote.h>
+#include <linux/build-salt.h>
+
+ELFNOTE32("Linux", 0, LINUX_VERSION_CODE);
+BUILD_SALT;
diff --git a/arch/arm64/kernel/vdso32/sigreturn.S b/arch/arm64/kernel/vdso32/sigreturn.S
new file mode 100644
index 000000000000..1a81277c2d09
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/sigreturn.S
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file provides both A32 and T32 versions, in accordance with the
+ * arm sigreturn code.
+ *
+ * Copyright (C) 2018 ARM Limited
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+#define ARM_ENTRY(name)		\
+	ENTRY(name)
+
+#define ARM_ENDPROC(name)	\
+	.type name, %function;	\
+	END(name)
+
+	.text
+
+	.arm
+	.fnstart
+	.save {r0-r15}
+	.pad #COMPAT_SIGFRAME_REGS_OFFSET
+	nop
+ARM_ENTRY(__kernel_sigreturn_arm)
+	mov r7, #__NR_compat_sigreturn
+	svc #0
+	.fnend
+ARM_ENDPROC(__kernel_sigreturn_arm)
+
+	.fnstart
+	.save {r0-r15}
+	.pad #COMPAT_RT_SIGFRAME_REGS_OFFSET
+	nop
+ARM_ENTRY(__kernel_rt_sigreturn_arm)
+	mov r7, #__NR_compat_rt_sigreturn
+	svc #0
+	.fnend
+ARM_ENDPROC(__kernel_rt_sigreturn_arm)
+
+	.thumb
+	.fnstart
+	.save {r0-r15}
+	.pad #COMPAT_SIGFRAME_REGS_OFFSET
+	nop
+ARM_ENTRY(__kernel_sigreturn_thumb)
+	mov r7, #__NR_compat_sigreturn
+	svc #0
+	.fnend
+ARM_ENDPROC(__kernel_sigreturn_thumb)
+
+	.fnstart
+	.save {r0-r15}
+	.pad #COMPAT_RT_SIGFRAME_REGS_OFFSET
+	nop
+ARM_ENTRY(__kernel_rt_sigreturn_thumb)
+	mov r7, #__NR_compat_rt_sigreturn
+	svc #0
+	.fnend
+ARM_ENDPROC(__kernel_rt_sigreturn_thumb)
diff --git a/arch/arm64/kernel/vdso32/vdso.S b/arch/arm64/kernel/vdso32/vdso.S
new file mode 100644
index 000000000000..e72ac7bc4c04
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vdso.S
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/const.h>
+#include <asm/page.h>
+
+	.globl vdso32_start, vdso32_end
+	.section .rodata
+	.balign PAGE_SIZE
+vdso32_start:
+	.incbin "arch/arm64/kernel/vdso32/vdso.so"
+	.balign PAGE_SIZE
+vdso32_end:
+
+	.previous
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
new file mode 100644
index 000000000000..a3944927eaeb
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Adapted from arm64 version.
+ *
+ * GNU linker script for the VDSO library.
+ * Heavily based on the vDSO linker scripts for other archs.
+ *
+ * Copyright (C) 2012-2018 ARM Limited
+ */
+
+#include <linux/const.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+
+OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
+OUTPUT_ARCH(arm)
+
+SECTIONS
+{
+	PROVIDE_HIDDEN(_vdso_data = . - PAGE_SIZE);
+	. = VDSO_LBASE + SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text	:note
+
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.rodata		: { *(.rodata*) }		:text
+
+	.text		: { *(.text*) }			:text	=0xe7f001f2
+
+	.got		: { *(.got) }
+	.rel.plt	: { *(.rel.plt) }
+
+	/DISCARD/	: {
+		*(.note.GNU-stack)
+		*(.data .data.* .gnu.linkonce.d.* .sdata*)
+		*(.bss .sbss .dynbss .dynsbss)
+	}
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
+	note		PT_NOTE		FLAGS(4);		/* PF_R */
+}
+
+VERSION
+{
+	LINUX_2.6 {
+	global:
+		__vdso_clock_gettime;
+		__vdso_gettimeofday;
+		__vdso_clock_getres;
+		__kernel_sigreturn_arm;
+		__kernel_sigreturn_thumb;
+		__kernel_rt_sigreturn_arm;
+		__kernel_rt_sigreturn_thumb;
+		__vdso_clock_gettime64;
+	local: *;
+	};
+}
+
+/*
+ * Make the sigreturn code visible to the kernel.
+ */
+VDSO_compat_sigreturn_arm	= __kernel_sigreturn_arm;
+VDSO_compat_sigreturn_thumb	= __kernel_sigreturn_thumb;
+VDSO_compat_rt_sigreturn_arm	= __kernel_rt_sigreturn_arm;
+VDSO_compat_rt_sigreturn_thumb	= __kernel_rt_sigreturn_thumb;
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
new file mode 100644
index 000000000000..54fc1c2ce93f
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM64 compat userspace implementations of gettimeofday() and similar.
+ *
+ * Copyright (C) 2018 ARM Limited
+ *
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+int __vdso_clock_gettime(clockid_t clock,
+			 struct old_timespec32 *ts)
+{
+	/* The checks below are required for ABI consistency with arm */
+	if ((u32)ts >= TASK_SIZE_32)
+		return -EFAULT;
+
+	return __cvdso_clock_gettime32(clock, ts);
+}
+
+int __vdso_clock_gettime64(clockid_t clock,
+			   struct __kernel_timespec *ts)
+{
+	/* The checks below are required for ABI consistency with arm */
+	if ((u32)ts >= TASK_SIZE_32)
+		return -EFAULT;
+
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+			struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+int __vdso_clock_getres(clockid_t clock_id,
+			struct old_timespec32 *res)
+{
+	/* The checks below are required for ABI consistency with arm */
+	if ((u32)res >= TASK_SIZE_32)
+		return -EFAULT;
+
+	return __cvdso_clock_getres_time32(clock_id, res);
+}
+
+/* Avoid unresolved references emitted by GCC */
+
+void __aeabi_unwind_cpp_pr0(void)
+{
+}
+
+void __aeabi_unwind_cpp_pr1(void)
+{
+}
+
+void __aeabi_unwind_cpp_pr2(void)
+{
+}
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1ba31..51a98d6eae8e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -17,6 +17,7 @@ config X86_32
 	select HAVE_DEBUG_STACKOVERFLOW
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
+	select GENERIC_VDSO_32
 
 config X86_64
 	def_bool y
@@ -121,6 +122,7 @@ config X86
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_GETTIMEOFDAY
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
 	select HAVE_ACPI_APEI			if ACPI
 	select HAVE_ACPI_APEI_NMI		if ACPI
@@ -202,6 +204,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
+	select HAVE_GENERIC_VDSO
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
 	select NEED_SG_DMA_LENGTH
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 42fe42e82baf..39106111be86 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -3,6 +3,12 @@
 # Building vDSO images for x86.
 #
 
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_X86_64_JUMP_SLOT|R_X86_64_GLOB_DAT|R_X86_64_RELATIVE|
+ARCH_REL_TYPE_ABS += R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
+include $(srctree)/lib/vdso/Makefile
+
 KBUILD_CFLAGS += $(DISABLE_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
@@ -51,6 +57,7 @@ VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
+	$(call if_changed,vdso_check)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
 hostprogs-y			+= vdso2c
@@ -121,6 +128,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
+	$(call if_changed,vdso_check)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
@@ -160,6 +168,7 @@ $(obj)/vdso32.so.dbg: FORCE \
 		      $(obj)/vdso32/system_call.o \
 		      $(obj)/vdso32/sigreturn.o
 	$(call if_changed,vdso)
+	$(call if_changed,vdso_check)
 
 #
 # The DSO images are built using a special linker script.
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 4aed41f638bb..d9ff616bb0f6 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -1,251 +1,85 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright 2006 Andi Kleen, SUSE Labs.
- *
  * Fast user context implementation of clock_gettime, gettimeofday, and time.
  *
+ * Copyright 2006 Andi Kleen, SUSE Labs.
+ * Copyright 2019 ARM Limited
+ *
  * 32 Bit compat layer by Stefani Seibold <stefani@seibold.net>
  *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
- *
- * The code should have no internal unresolved relocations.
- * Check with readelf after changing.
  */
-
-#include <uapi/linux/time.h>
-#include <asm/vgtod.h>
-#include <asm/vvar.h>
-#include <asm/unistd.h>
-#include <asm/msr.h>
-#include <asm/pvclock.h>
-#include <asm/mshyperv.h>
-#include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <linux/types.h>
 
-#define gtod (&VVAR(vsyscall_gtod_data))
+#include "../../../../lib/vdso/gettimeofday.c"
 
-extern int __vdso_clock_gettime(clockid_t clock, struct timespec *ts);
-extern int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz);
+extern int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 extern time_t __vdso_time(time_t *t);
 
-#ifdef CONFIG_PARAVIRT_CLOCK
-extern u8 pvclock_page[PAGE_SIZE]
-	__attribute__((visibility("hidden")));
-#endif
-
-#ifdef CONFIG_HYPERV_TSCPAGE
-extern u8 hvclock_page[PAGE_SIZE]
-	__attribute__((visibility("hidden")));
-#endif
-
-#ifndef BUILD_VDSO32
-
-notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	long ret;
-	asm ("syscall" : "=a" (ret), "=m" (*ts) :
-	     "0" (__NR_clock_gettime), "D" (clock), "S" (ts) :
-	     "rcx", "r11");
-	return ret;
+	return __cvdso_gettimeofday(tv, tz);
 }
 
-#else
+int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
+	__attribute__((weak, alias("__vdso_gettimeofday")));
 
-notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
+time_t __vdso_time(time_t *t)
 {
-	long ret;
-
-	asm (
-		"mov %%ebx, %%edx \n"
-		"mov %[clock], %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=a" (ret), "=m" (*ts)
-		: "0" (__NR_clock_gettime), [clock] "g" (clock), "c" (ts)
-		: "edx");
-	return ret;
+	return __cvdso_time(t);
 }
 
-#endif
+time_t time(time_t *t)	__attribute__((weak, alias("__vdso_time")));
 
-#ifdef CONFIG_PARAVIRT_CLOCK
-static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
-{
-	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
-}
 
-static notrace u64 vread_pvclock(void)
-{
-	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
-	u32 version;
-	u64 ret;
-
-	/*
-	 * Note: The kernel and hypervisor must guarantee that cpu ID
-	 * number maps 1:1 to per-CPU pvclock time info.
-	 *
-	 * Because the hypervisor is entirely unaware of guest userspace
-	 * preemption, it cannot guarantee that per-CPU pvclock time
-	 * info is updated if the underlying CPU changes or that that
-	 * version is increased whenever underlying CPU changes.
-	 *
-	 * On KVM, we are guaranteed that pvti updates for any vCPU are
-	 * atomic as seen by *all* vCPUs.  This is an even stronger
-	 * guarantee than we get with a normal seqlock.
-	 *
-	 * On Xen, we don't appear to have that guarantee, but Xen still
-	 * supplies a valid seqlock using the version field.
-	 *
-	 * We only do pvclock vdso timing at all if
-	 * PVCLOCK_TSC_STABLE_BIT is set, and we interpret that bit to
-	 * mean that all vCPUs have matching pvti and that the TSC is
-	 * synced, so we can just look at vCPU 0's pvti.
-	 */
-
-	do {
-		version = pvclock_read_begin(pvti);
-
-		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT)))
-			return U64_MAX;
-
-		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
-	} while (pvclock_read_retry(pvti, version));
-
-	return ret;
-}
-#endif
-#ifdef CONFIG_HYPERV_TSCPAGE
-static notrace u64 vread_hvclock(void)
-{
-	const struct ms_hyperv_tsc_page *tsc_pg =
-		(const struct ms_hyperv_tsc_page *)&hvclock_page;
+#if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
+/* both 64-bit and x32 use these */
+extern int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
+extern int __vdso_clock_getres(clockid_t clock, struct __kernel_timespec *res);
 
-	return hv_read_tsc_page(tsc_pg);
-}
-#endif
-
-notrace static inline u64 vgetcyc(int mode)
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
-	if (mode == VCLOCK_TSC)
-		return (u64)rdtsc_ordered();
-
-	/*
-	 * For any memory-mapped vclock type, we need to make sure that gcc
-	 * doesn't cleverly hoist a load before the mode check.  Otherwise we
-	 * might end up touching the memory-mapped page even if the vclock in
-	 * question isn't enabled, which will segfault.  Hence the barriers.
-	 */
-#ifdef CONFIG_PARAVIRT_CLOCK
-	if (mode == VCLOCK_PVCLOCK) {
-		barrier();
-		return vread_pvclock();
-	}
-#endif
-#ifdef CONFIG_HYPERV_TSCPAGE
-	if (mode == VCLOCK_HVCLOCK) {
-		barrier();
-		return vread_hvclock();
-	}
-#endif
-	return U64_MAX;
+	return __cvdso_clock_gettime(clock, ts);
 }
 
-notrace static int do_hres(clockid_t clk, struct timespec *ts)
-{
-	struct vgtod_ts *base = &gtod->basetime[clk];
-	u64 cycles, last, sec, ns;
-	unsigned int seq;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		cycles = vgetcyc(gtod->vclock_mode);
-		ns = base->nsec;
-		last = gtod->cycle_last;
-		if (unlikely((s64)cycles < 0))
-			return vdso_fallback_gettime(clk, ts);
-		if (cycles > last)
-			ns += (cycles - last) * gtod->mult;
-		ns >>= gtod->shift;
-		sec = base->sec;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
+int clock_gettime(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-notrace static void do_coarse(clockid_t clk, struct timespec *ts)
+int __vdso_clock_getres(clockid_t clock,
+			struct __kernel_timespec *res)
 {
-	struct vgtod_ts *base = &gtod->basetime[clk];
-	unsigned int seq;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		ts->tv_sec = base->sec;
-		ts->tv_nsec = base->nsec;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
+	return __cvdso_clock_getres(clock, res);
 }
+int clock_getres(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
 
-notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
+#else
+/* i386 only */
+extern int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts);
+extern int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res);
+
+int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 {
-	unsigned int msk;
-
-	/* Sort out negative (CPU/FD) and invalid clocks */
-	if (unlikely((unsigned int) clock >= MAX_CLOCKS))
-		return vdso_fallback_gettime(clock, ts);
-
-	/*
-	 * Convert the clockid to a bitmask and use it to check which
-	 * clocks are handled in the VDSO directly.
-	 */
-	msk = 1U << clock;
-	if (likely(msk & VGTOD_HRES)) {
-		return do_hres(clock, ts);
-	} else if (msk & VGTOD_COARSE) {
-		do_coarse(clock, ts);
-		return 0;
-	}
-	return vdso_fallback_gettime(clock, ts);
+	return __cvdso_clock_gettime32(clock, ts);
 }
 
-int clock_gettime(clockid_t, struct timespec *)
+int clock_gettime(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
 {
-	if (likely(tv != NULL)) {
-		struct timespec *ts = (struct timespec *) tv;
-
-		do_hres(CLOCK_REALTIME, ts);
-		tv->tv_usec /= 1000;
-	}
-	if (unlikely(tz != NULL)) {
-		tz->tz_minuteswest = gtod->tz_minuteswest;
-		tz->tz_dsttime = gtod->tz_dsttime;
-	}
-
-	return 0;
+	return __cvdso_clock_gettime(clock, ts);
 }
-int gettimeofday(struct timeval *, struct timezone *)
-	__attribute__((weak, alias("__vdso_gettimeofday")));
 
-/*
- * This will break when the xtime seconds get inaccurate, but that is
- * unlikely
- */
-notrace time_t __vdso_time(time_t *t)
-{
-	/* This is atomic on x86 so we don't need any locks. */
-	time_t result = READ_ONCE(gtod->basetime[CLOCK_REALTIME].sec);
+int clock_gettime64(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime64")));
 
-	if (t)
-		*t = result;
-	return result;
+int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock, res);
 }
-time_t time(time_t *t)
-	__attribute__((weak, alias("__vdso_time")));
+
+int clock_getres(clockid_t, struct old_timespec32 *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
+#endif
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index d3a2dce4cfa9..36b644e16272 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -25,6 +25,8 @@ VERSION {
 		__vdso_getcpu;
 		time;
 		__vdso_time;
+		clock_getres;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index 422764a81d32..c7720995ab1a 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -26,6 +26,8 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_time;
+		__vdso_clock_getres;
+		__vdso_clock_gettime64;
 	};
 
 	LINUX_2.5 {
diff --git a/arch/x86/entry/vdso/vdsox32.lds.S b/arch/x86/entry/vdso/vdsox32.lds.S
index 05cd1c5c4a15..16a8050a4fb6 100644
--- a/arch/x86/entry/vdso/vdsox32.lds.S
+++ b/arch/x86/entry/vdso/vdsox32.lds.S
@@ -21,6 +21,7 @@ VERSION {
 		__vdso_gettimeofday;
 		__vdso_getcpu;
 		__vdso_time;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 8db1f594e8b1..349a61d8bf34 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -22,7 +22,7 @@
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
-#include <asm/mshyperv.h>
+#include <clocksource/hyperv_timer.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
diff --git a/arch/x86/entry/vsyscall/Makefile b/arch/x86/entry/vsyscall/Makefile
index 1ac4dd116c26..93c1b3e949a7 100644
--- a/arch/x86/entry/vsyscall/Makefile
+++ b/arch/x86/entry/vsyscall/Makefile
@@ -2,7 +2,5 @@
 #
 # Makefile for the x86 low level vsyscall code
 #
-obj-y					:= vsyscall_gtod.o
-
 obj-$(CONFIG_X86_VSYSCALL_EMULATION)	+= vsyscall_64.o vsyscall_emu_64.o
 
diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
deleted file mode 100644
index cfcdba082feb..000000000000
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ /dev/null
@@ -1,83 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
- *  Copyright 2003 Andi Kleen, SuSE Labs.
- *
- *  Modified for x86 32 bit architecture by
- *  Stefani Seibold <stefani@seibold.net>
- *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
- *
- *  Thanks to hpa@transmeta.com for some useful hint.
- *  Special thanks to Ingo Molnar for his early experience with
- *  a different vsyscall implementation for Linux/IA32 and for the name.
- *
- */
-
-#include <linux/timekeeper_internal.h>
-#include <asm/vgtod.h>
-#include <asm/vvar.h>
-
-int vclocks_used __read_mostly;
-
-DEFINE_VVAR(struct vsyscall_gtod_data, vsyscall_gtod_data);
-
-void update_vsyscall_tz(void)
-{
-	vsyscall_gtod_data.tz_minuteswest = sys_tz.tz_minuteswest;
-	vsyscall_gtod_data.tz_dsttime = sys_tz.tz_dsttime;
-}
-
-void update_vsyscall(struct timekeeper *tk)
-{
-	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
-	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
-	struct vgtod_ts *base;
-	u64 nsec;
-
-	/* Mark the new vclock used. */
-	BUILD_BUG_ON(VCLOCK_MAX >= 32);
-	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << vclock_mode));
-
-	gtod_write_begin(vdata);
-
-	/* copy vsyscall data */
-	vdata->vclock_mode	= vclock_mode;
-	vdata->cycle_last	= tk->tkr_mono.cycle_last;
-	vdata->mask		= tk->tkr_mono.mask;
-	vdata->mult		= tk->tkr_mono.mult;
-	vdata->shift		= tk->tkr_mono.shift;
-
-	base = &vdata->basetime[CLOCK_REALTIME];
-	base->sec = tk->xtime_sec;
-	base->nsec = tk->tkr_mono.xtime_nsec;
-
-	base = &vdata->basetime[CLOCK_TAI];
-	base->sec = tk->xtime_sec + (s64)tk->tai_offset;
-	base->nsec = tk->tkr_mono.xtime_nsec;
-
-	base = &vdata->basetime[CLOCK_MONOTONIC];
-	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	nsec = tk->tkr_mono.xtime_nsec;
-	nsec +=	((u64)tk->wall_to_monotonic.tv_nsec << tk->tkr_mono.shift);
-	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
-		nsec -= ((u64)NSEC_PER_SEC) << tk->tkr_mono.shift;
-		base->sec++;
-	}
-	base->nsec = nsec;
-
-	base = &vdata->basetime[CLOCK_REALTIME_COARSE];
-	base->sec = tk->xtime_sec;
-	base->nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
-
-	base = &vdata->basetime[CLOCK_MONOTONIC_COARSE];
-	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
-	nsec += tk->wall_to_monotonic.tv_nsec;
-	while (nsec >= NSEC_PER_SEC) {
-		nsec -= NSEC_PER_SEC;
-		base->sec++;
-	}
-	base->nsec = nsec;
-
-	gtod_write_end(vdata);
-}
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 1608050e9df9..0e033ef11a9f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -17,64 +17,13 @@
 #include <linux/version.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
-#include <linux/clockchips.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
-
-#ifdef CONFIG_HYPERV_TSCPAGE
-
-static struct ms_hyperv_tsc_page *tsc_pg;
-
-struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
-{
-	return tsc_pg;
-}
-EXPORT_SYMBOL_GPL(hv_get_tsc_page);
-
-static u64 read_hv_clock_tsc(struct clocksource *arg)
-{
-	u64 current_tick = hv_read_tsc_page(tsc_pg);
-
-	if (current_tick == U64_MAX)
-		rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
-
-	return current_tick;
-}
-
-static struct clocksource hyperv_cs_tsc = {
-		.name		= "hyperv_clocksource_tsc_page",
-		.rating		= 400,
-		.read		= read_hv_clock_tsc,
-		.mask		= CLOCKSOURCE_MASK(64),
-		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-#endif
-
-static u64 read_hv_clock_msr(struct clocksource *arg)
-{
-	u64 current_tick;
-	/*
-	 * Read the partition counter to get the current tick count. This count
-	 * is set to 0 when the partition is created and is incremented in
-	 * 100 nanosecond units.
-	 */
-	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
-	return current_tick;
-}
-
-static struct clocksource hyperv_cs_msr = {
-	.name		= "hyperv_clocksource_msr",
-	.rating		= 400,
-	.read		= read_hv_clock_msr,
-	.mask		= CLOCKSOURCE_MASK(64),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
+#include <clocksource/hyperv_timer.h>
 
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
-struct clocksource *hyperv_cs;
-EXPORT_SYMBOL_GPL(hyperv_cs);
 
 u32 *hv_vp_index;
 EXPORT_SYMBOL_GPL(hv_vp_index);
@@ -343,42 +292,8 @@ void __init hyperv_init(void)
 
 	x86_init.pci.arch_init = hv_pci_init;
 
-	/*
-	 * Register Hyper-V specific clocksource.
-	 */
-#ifdef CONFIG_HYPERV_TSCPAGE
-	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
-		union hv_x64_msr_hypercall_contents tsc_msr;
-
-		tsc_pg = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
-		if (!tsc_pg)
-			goto register_msr_cs;
-
-		hyperv_cs = &hyperv_cs_tsc;
-
-		rdmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
-
-		tsc_msr.enable = 1;
-		tsc_msr.guest_physical_address = vmalloc_to_pfn(tsc_pg);
-
-		wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
-
-		hyperv_cs_tsc.archdata.vclock_mode = VCLOCK_HVCLOCK;
-
-		clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
-		return;
-	}
-register_msr_cs:
-#endif
-	/*
-	 * For 32 bit guests just use the MSR based mechanism for reading
-	 * the partition counter.
-	 */
-
-	hyperv_cs = &hyperv_cs_msr;
-	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)
-		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
-
+	/* Register Hyper-V specific clocksource */
+	hv_init_clocksource();
 	return;
 
 remove_cpuhp_state:
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index cdf44aa9a501..af78cd72b8f3 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -401,6 +401,12 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_STATUS_INVALID_CONNECTION_ID		18
 #define HV_STATUS_INSUFFICIENT_BUFFERS		19
 
+/*
+ * The Hyper-V TimeRefCount register and the TSC
+ * page provide a guest VM clock with 100ns tick rate
+ */
+#define HV_CLOCK_HZ (NSEC_PER_SEC/100)
+
 typedef struct _HV_REFERENCE_TSC_PAGE {
 	__u32 tsc_sequence;
 	__u32 res1;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index cc60e617931c..f4fa8a9d5d0b 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -105,6 +105,17 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 #define hv_get_crash_ctl(val) \
 	rdmsrl(HV_X64_MSR_CRASH_CTL, val)
 
+#define hv_get_time_ref_count(val) \
+	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, val)
+
+#define hv_get_reference_tsc(val) \
+	rdmsrl(HV_X64_MSR_REFERENCE_TSC, val)
+#define hv_set_reference_tsc(val) \
+	wrmsrl(HV_X64_MSR_REFERENCE_TSC, val)
+#define hv_set_clocksource_vdso(val) \
+	((val).archdata.vclock_mode = VCLOCK_HVCLOCK)
+#define hv_get_raw_timer() rdtsc_ordered()
+
 void hyperv_callback_vector(void);
 void hyperv_reenlightenment_vector(void);
 #ifdef CONFIG_TRACING
@@ -133,7 +144,6 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
 
 
 #if IS_ENABLED(CONFIG_HYPERV)
-extern struct clocksource *hyperv_cs;
 extern void *hv_hypercall_pg;
 extern void  __percpu  **hyperv_pcpu_input_arg;
 
@@ -387,73 +397,4 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
 }
 #endif /* CONFIG_HYPERV */
 
-#ifdef CONFIG_HYPERV_TSCPAGE
-struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
-				       u64 *cur_tsc)
-{
-	u64 scale, offset;
-	u32 sequence;
-
-	/*
-	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
-	 * Top-Level Functional Specification ver. 3.0 and above. To get the
-	 * reference time we must do the following:
-	 * - READ ReferenceTscSequence
-	 *   A special '0' value indicates the time source is unreliable and we
-	 *   need to use something else. The currently published specification
-	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
-	 *   instead of '0' as the special value, see commit c35b82ef0294.
-	 * - ReferenceTime =
-	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
-	 * - READ ReferenceTscSequence again. In case its value has changed
-	 *   since our first reading we need to discard ReferenceTime and repeat
-	 *   the whole sequence as the hypervisor was updating the page in
-	 *   between.
-	 */
-	do {
-		sequence = READ_ONCE(tsc_pg->tsc_sequence);
-		if (!sequence)
-			return U64_MAX;
-		/*
-		 * Make sure we read sequence before we read other values from
-		 * TSC page.
-		 */
-		smp_rmb();
-
-		scale = READ_ONCE(tsc_pg->tsc_scale);
-		offset = READ_ONCE(tsc_pg->tsc_offset);
-		*cur_tsc = rdtsc_ordered();
-
-		/*
-		 * Make sure we read sequence after we read all other values
-		 * from TSC page.
-		 */
-		smp_rmb();
-
-	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
-
-	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
-}
-
-static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
-{
-	u64 cur_tsc;
-
-	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
-}
-
-#else
-static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
-{
-	return NULL;
-}
-
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
-				       u64 *cur_tsc)
-{
-	BUG();
-	return U64_MAX;
-}
-#endif
 #endif
diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
index b6033680d458..19b695ff2c68 100644
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PVCLOCK_H
 #define _ASM_X86_PVCLOCK_H
 
-#include <linux/clocksource.h>
+#include <asm/clocksource.h>
 #include <asm/pvclock-abi.h>
 
 /* some helper functions for xen and kvm pv clock sources */
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..ae91429129a6
--- /dev/null
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,261 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Fast user context implementation of clock_gettime, gettimeofday, and time.
+ *
+ * Copyright (C) 2019 ARM Limited.
+ * Copyright 2006 Andi Kleen, SUSE Labs.
+ * 32 Bit compat layer by Stefani Seibold <stefani@seibold.net>
+ *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <uapi/linux/time.h>
+#include <asm/vgtod.h>
+#include <asm/vvar.h>
+#include <asm/unistd.h>
+#include <asm/msr.h>
+#include <asm/pvclock.h>
+#include <clocksource/hyperv_timer.h>
+
+#define __vdso_data (VVAR(_vdso_data))
+
+#define VDSO_HAS_TIME 1
+
+#define VDSO_HAS_CLOCK_GETRES 1
+
+/*
+ * Declare the memory-mapped vclock data pages.  These come from hypervisors.
+ * If we ever reintroduce something like direct access to an MMIO clock like
+ * the HPET again, it will go here as well.
+ *
+ * A load from any of these pages will segfault if the clock in question is
+ * disabled, so appropriate compiler barriers and checks need to be used
+ * to prevent stray loads.
+ *
+ * These declarations MUST NOT be const.  The compiler will assume that
+ * an extern const variable has genuinely constant contents, and the
+ * resulting code won't work, since the whole point is that these pages
+ * change over time, possibly while we're accessing them.
+ */
+
+#ifdef CONFIG_PARAVIRT_CLOCK
+/*
+ * This is the vCPU 0 pvclock page.  We only use pvclock from the vDSO
+ * if the hypervisor tells us that all vCPUs can get valid data from the
+ * vCPU 0 page.
+ */
+extern struct pvclock_vsyscall_time_info pvclock_page
+	__attribute__((visibility("hidden")));
+#endif
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+extern struct ms_hyperv_tsc_page hvclock_page
+	__attribute__((visibility("hidden")));
+#endif
+
+#ifndef BUILD_VDSO32
+
+static __always_inline
+long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	long ret;
+
+	asm ("syscall" : "=a" (ret), "=m" (*_ts) :
+	     "0" (__NR_clock_gettime), "D" (_clkid), "S" (_ts) :
+	     "rcx", "r11");
+
+	return ret;
+}
+
+static __always_inline
+long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
+			   struct timezone *_tz)
+{
+	long ret;
+
+	asm("syscall" : "=a" (ret) :
+	    "0" (__NR_gettimeofday), "D" (_tv), "S" (_tz) : "memory");
+
+	return ret;
+}
+
+static __always_inline
+long clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	long ret;
+
+	asm ("syscall" : "=a" (ret), "=m" (*_ts) :
+	     "0" (__NR_clock_getres), "D" (_clkid), "S" (_ts) :
+	     "rcx", "r11");
+
+	return ret;
+}
+
+#else
+
+static __always_inline
+long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	long ret;
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (*_ts)
+		: "0" (__NR_clock_gettime64), [clock] "g" (_clkid), "c" (_ts)
+		: "edx");
+
+	return ret;
+}
+
+static __always_inline
+long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
+			   struct timezone *_tz)
+{
+	long ret;
+
+	asm(
+		"mov %%ebx, %%edx \n"
+		"mov %2, %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret)
+		: "0" (__NR_gettimeofday), "g" (_tv), "c" (_tz)
+		: "memory", "edx");
+
+	return ret;
+}
+
+static __always_inline long
+clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	long ret;
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (*_ts)
+		: "0" (__NR_clock_getres_time64), [clock] "g" (_clkid), "c" (_ts)
+		: "edx");
+
+	return ret;
+}
+
+#endif
+
+#ifdef CONFIG_PARAVIRT_CLOCK
+static u64 vread_pvclock(void)
+{
+	const struct pvclock_vcpu_time_info *pvti = &pvclock_page.pvti;
+	u32 version;
+	u64 ret;
+
+	/*
+	 * Note: The kernel and hypervisor must guarantee that cpu ID
+	 * number maps 1:1 to per-CPU pvclock time info.
+	 *
+	 * Because the hypervisor is entirely unaware of guest userspace
+	 * preemption, it cannot guarantee that per-CPU pvclock time
+	 * info is updated if the underlying CPU changes or that that
+	 * version is increased whenever underlying CPU changes.
+	 *
+	 * On KVM, we are guaranteed that pvti updates for any vCPU are
+	 * atomic as seen by *all* vCPUs.  This is an even stronger
+	 * guarantee than we get with a normal seqlock.
+	 *
+	 * On Xen, we don't appear to have that guarantee, but Xen still
+	 * supplies a valid seqlock using the version field.
+	 *
+	 * We only do pvclock vdso timing at all if
+	 * PVCLOCK_TSC_STABLE_BIT is set, and we interpret that bit to
+	 * mean that all vCPUs have matching pvti and that the TSC is
+	 * synced, so we can just look at vCPU 0's pvti.
+	 */
+
+	do {
+		version = pvclock_read_begin(pvti);
+
+		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT)))
+			return U64_MAX;
+
+		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
+	} while (pvclock_read_retry(pvti, version));
+
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+static u64 vread_hvclock(void)
+{
+	return hv_read_tsc_page(&hvclock_page);
+}
+#endif
+
+static inline u64 __arch_get_hw_counter(s32 clock_mode)
+{
+	if (clock_mode == VCLOCK_TSC)
+		return (u64)rdtsc_ordered();
+	/*
+	 * For any memory-mapped vclock type, we need to make sure that gcc
+	 * doesn't cleverly hoist a load before the mode check.  Otherwise we
+	 * might end up touching the memory-mapped page even if the vclock in
+	 * question isn't enabled, which will segfault.  Hence the barriers.
+	 */
+#ifdef CONFIG_PARAVIRT_CLOCK
+	if (clock_mode == VCLOCK_PVCLOCK) {
+		barrier();
+		return vread_pvclock();
+	}
+#endif
+#ifdef CONFIG_HYPERV_TSCPAGE
+	if (clock_mode == VCLOCK_HVCLOCK) {
+		barrier();
+		return vread_hvclock();
+	}
+#endif
+	return U64_MAX;
+}
+
+static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return __vdso_data;
+}
+
+/*
+ * x86 specific delta calculation.
+ *
+ * The regular implementation assumes that clocksource reads are globally
+ * monotonic. The TSC can be slightly off across sockets which can cause
+ * the regular delta calculation (@cycles - @last) to return a huge time
+ * jump.
+ *
+ * Therefore it needs to be verified that @cycles are greater than
+ * @last. If not then use @last, which is the base time of the current
+ * conversion period.
+ *
+ * This variant also removes the masking of the subtraction because the
+ * clocksource mask of all VDSO capable clocksources on x86 is U64_MAX
+ * which would result in a pointless operation. The compiler cannot
+ * optimize it away as the mask comes from the vdso data and is not compile
+ * time constant.
+ */
+static __always_inline
+u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+{
+	if (cycles > last)
+		return (cycles - last) * mult;
+	return 0;
+}
+#define vdso_calc_delta vdso_calc_delta
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
new file mode 100644
index 000000000000..0026ab2123ce
--- /dev/null
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_VSYSCALL_H
+#define __ASM_VDSO_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/hrtimer.h>
+#include <linux/timekeeper_internal.h>
+#include <vdso/datapage.h>
+#include <asm/vgtod.h>
+#include <asm/vvar.h>
+
+int vclocks_used __read_mostly;
+
+DEFINE_VVAR(struct vdso_data, _vdso_data);
+/*
+ * Update the vDSO data page to keep in sync with kernel timekeeping.
+ */
+static __always_inline
+struct vdso_data *__x86_get_k_vdso_data(void)
+{
+	return _vdso_data;
+}
+#define __arch_get_k_vdso_data __x86_get_k_vdso_data
+
+static __always_inline
+int __x86_get_clock_mode(struct timekeeper *tk)
+{
+	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
+
+	/* Mark the new vclock used. */
+	BUILD_BUG_ON(VCLOCK_MAX >= 32);
+	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << vclock_mode));
+
+	return vclock_mode;
+}
+#define __arch_get_clock_mode __x86_get_clock_mode
+
+/* The asm-generic header needs to be included after the definitions above */
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 913a133f8e6f..a2638c6124ed 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -3,7 +3,9 @@
 #define _ASM_X86_VGTOD_H
 
 #include <linux/compiler.h>
-#include <linux/clocksource.h>
+#include <asm/clocksource.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
 
 #include <uapi/linux/time.h>
 
@@ -13,81 +15,10 @@ typedef u64 gtod_long_t;
 typedef unsigned long gtod_long_t;
 #endif
 
-/*
- * There is one of these objects in the vvar page for each
- * vDSO-accelerated clockid.  For high-resolution clocks, this encodes
- * the time corresponding to vsyscall_gtod_data.cycle_last.  For coarse
- * clocks, this encodes the actual time.
- *
- * To confuse the reader, for high-resolution clocks, nsec is left-shifted
- * by vsyscall_gtod_data.shift.
- */
-struct vgtod_ts {
-	u64		sec;
-	u64		nsec;
-};
-
-#define VGTOD_BASES	(CLOCK_TAI + 1)
-#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
-#define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
-
-/*
- * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same time
- * so be carefull by modifying this structure.
- */
-struct vsyscall_gtod_data {
-	unsigned int	seq;
-
-	int		vclock_mode;
-	u64		cycle_last;
-	u64		mask;
-	u32		mult;
-	u32		shift;
-
-	struct vgtod_ts	basetime[VGTOD_BASES];
-
-	int		tz_minuteswest;
-	int		tz_dsttime;
-};
-extern struct vsyscall_gtod_data vsyscall_gtod_data;
-
 extern int vclocks_used;
 static inline bool vclock_was_used(int vclock)
 {
 	return READ_ONCE(vclocks_used) & (1 << vclock);
 }
 
-static inline unsigned int gtod_read_begin(const struct vsyscall_gtod_data *s)
-{
-	unsigned int ret;
-
-repeat:
-	ret = READ_ONCE(s->seq);
-	if (unlikely(ret & 1)) {
-		cpu_relax();
-		goto repeat;
-	}
-	smp_rmb();
-	return ret;
-}
-
-static inline int gtod_read_retry(const struct vsyscall_gtod_data *s,
-				  unsigned int start)
-{
-	smp_rmb();
-	return unlikely(s->seq != start);
-}
-
-static inline void gtod_write_begin(struct vsyscall_gtod_data *s)
-{
-	++s->seq;
-	smp_wmb();
-}
-
-static inline void gtod_write_end(struct vsyscall_gtod_data *s)
-{
-	smp_wmb();
-	++s->seq;
-}
-
 #endif /* _ASM_X86_VGTOD_H */
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index e474f5c6e387..32f5d9a0b90e 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -32,19 +32,20 @@
 extern char __vvar_page;
 
 #define DECLARE_VVAR(offset, type, name)				\
-	extern type vvar_ ## name __attribute__((visibility("hidden")));
+	extern type vvar_ ## name[CS_BASES]				\
+	__attribute__((visibility("hidden")));
 
 #define VVAR(name) (vvar_ ## name)
 
 #define DEFINE_VVAR(type, name)						\
-	type name							\
+	type name[CS_BASES]						\
 	__attribute__((section(".vvar_" #name), aligned(16))) __visible
 
 #endif
 
 /* DECLARE_VVAR(offset, type, name) */
 
-DECLARE_VVAR(128, struct vsyscall_gtod_data, vsyscall_gtod_data)
+DECLARE_VVAR(128, struct vdso_data, _vdso_data)
 
 #undef DECLARE_VVAR
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 7df29f08871b..1e5f7a03ddf5 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/i8253.h>
+#include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -80,6 +81,7 @@ __visible void __irq_entry hv_stimer0_vector_handler(struct pt_regs *regs)
 	inc_irq_stat(hyperv_stimer0_count);
 	if (hv_stimer0_handler)
 		hv_stimer0_handler();
+	add_interrupt_randomness(HYPERV_STIMER0_VECTOR, 0);
 	ack_APIC_irq();
 
 	exiting_irq();
@@ -89,7 +91,7 @@ __visible void __irq_entry hv_stimer0_vector_handler(struct pt_regs *regs)
 int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
 {
 	*vector = HYPERV_STIMER0_VECTOR;
-	*irq = 0;   /* Unused on x86/x64 */
+	*irq = -1;   /* Unused on x86/x64 */
 	hv_stimer0_handler = handler;
 	return 0;
 }
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index 0ff3e294d0e5..10125358b9c4 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -3,6 +3,7 @@
 
 */
 
+#include <linux/clocksource.h>
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 132d149494d6..ab73a9a639ae 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -261,10 +261,10 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 		ctr_val = rdtsc();
 		break;
 	case VMWARE_BACKDOOR_PMC_REAL_TIME:
-		ctr_val = ktime_get_boot_ns();
+		ctr_val = ktime_get_boottime_ns();
 		break;
 	case VMWARE_BACKDOOR_PMC_APPARENT_TIME:
-		ctr_val = ktime_get_boot_ns() +
+		ctr_val = ktime_get_boottime_ns() +
 			vcpu->kvm->arch.kvmclock_offset;
 		break;
 	default:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9857992d4e58..5e1db26b5e15 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -67,6 +67,7 @@
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
 #include <asm/intel_pt.h>
+#include <clocksource/hyperv_timer.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -1728,7 +1729,7 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr)
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
 	offset = kvm_compute_tsc_offset(vcpu, data);
-	ns = ktime_get_boot_ns();
+	ns = ktime_get_boottime_ns();
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
@@ -2070,7 +2071,7 @@ u64 get_kvmclock_ns(struct kvm *kvm)
 	spin_lock(&ka->pvclock_gtod_sync_lock);
 	if (!ka->use_master_clock) {
 		spin_unlock(&ka->pvclock_gtod_sync_lock);
-		return ktime_get_boot_ns() + ka->kvmclock_offset;
+		return ktime_get_boottime_ns() + ka->kvmclock_offset;
 	}
 
 	hv_clock.tsc_timestamp = ka->master_cycle_now;
@@ -2086,7 +2087,7 @@ u64 get_kvmclock_ns(struct kvm *kvm)
 				   &hv_clock.tsc_to_system_mul);
 		ret = __pvclock_read_cycles(&hv_clock, rdtsc());
 	} else
-		ret = ktime_get_boot_ns() + ka->kvmclock_offset;
+		ret = ktime_get_boottime_ns() + ka->kvmclock_offset;
 
 	put_cpu();
 
@@ -2185,7 +2186,7 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 	}
 	if (!use_master_clock) {
 		host_tsc = rdtsc();
-		kernel_ns = ktime_get_boot_ns();
+		kernel_ns = ktime_get_boottime_ns();
 	}
 
 	tsc_timestamp = kvm_read_l1_tsc(v, host_tsc);
@@ -9015,7 +9016,7 @@ int kvm_arch_hardware_enable(void)
 	 * before any KVM threads can be running.  Unfortunately, we can't
 	 * bring the TSCs fully up to date with real time, as we aren't yet far
 	 * enough into CPU bringup that we know how much real time has actually
-	 * elapsed; our helper function, ktime_get_boot_ns() will be using boot
+	 * elapsed; our helper function, ktime_get_boottime_ns() will be using boot
 	 * variables that haven't been updated yet.
 	 *
 	 * So we simply find the maximum observed TSC above, then record the
@@ -9243,7 +9244,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	mutex_init(&kvm->arch.apic_map_lock);
 	spin_lock_init(&kvm->arch.pvclock_gtod_sync_lock);
 
-	kvm->arch.kvmclock_offset = -ktime_get_boot_ns();
+	kvm->arch.kvmclock_offset = -ktime_get_boottime_ns();
 	pvclock_update_vm_gtod_copy(kvm);
 
 	kvm->arch.guest_can_read_msr_platform_info = true;
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3300739edce4..5e9317dc3d39 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -43,6 +43,11 @@ config BCM_KONA_TIMER
 	help
 	  Enables the support for the BCM Kona mobile timer driver.
 
+config DAVINCI_TIMER
+	bool "Texas Instruments DaVinci timer driver" if COMPILE_TEST
+	help
+	  Enables the support for the TI DaVinci timer driver.
+
 config DIGICOLOR_TIMER
 	bool "Digicolor timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
@@ -140,7 +145,7 @@ config TEGRA_TIMER
 	bool "Tegra timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	select TIMER_OF
-	depends on ARM || ARM64
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  Enables support for the Tegra driver.
 
@@ -617,6 +622,13 @@ config CLKSRC_IMX_TPM
 	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
 	  clocksource.
 
+config TIMER_IMX_SYS_CTR
+	bool "i.MX system counter timer" if COMPILE_TEST
+	select TIMER_OF
+	help
+	  Enable this option to use i.MX system counter timer as a
+	  clockevent.
+
 config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
 	select TIMER_OF if OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 236858fa7fbf..2e7936e7833f 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
 obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
+obj-$(CONFIG_DAVINCI_TIMER)	+= timer-davinci.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
 obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
@@ -36,7 +37,7 @@ obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
-obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra20.o
+obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra.o
 obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
@@ -74,6 +75,7 @@ obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= timer-tango-xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
 obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
+obj-$(CONFIG_TIMER_IMX_SYS_CTR)		+= timer-imx-sysctr.o
 obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
@@ -84,3 +86,4 @@ obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
+obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index ebfbccefc7b3..b29b5a75333e 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
@@ -139,7 +140,7 @@ static u64 arc_read_rtc(struct clocksource *cs)
 		l = read_aux_reg(AUX_RTC_LOW);
 		h = read_aux_reg(AUX_RTC_HIGH);
 		status = read_aux_reg(AUX_RTC_CTRL);
-	} while (!(status & _BITUL(31)));
+	} while (!(status & BIT(31)));
 
 	return (((u64)h) << 32) | l;
 }
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 07e57a49d1e8..9a5464c625b4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -801,14 +801,7 @@ static void arch_timer_evtstrm_enable(int divider)
 	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
 			| ARCH_TIMER_VIRT_EVT_EN;
 	arch_timer_set_cntkctl(cntkctl);
-#ifdef CONFIG_ARM64
-	cpu_set_named_feature(EVTSTRM);
-#else
-	elf_hwcap |= HWCAP_EVTSTRM;
-#endif
-#ifdef CONFIG_COMPAT
-	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
-#endif
+	arch_timer_set_evtstrm_feature();
 	cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
 }
 
@@ -1037,11 +1030,7 @@ static int arch_timer_cpu_pm_notify(struct notifier_block *self,
 	} else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT) {
 		arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
 
-#ifdef CONFIG_ARM64
-		if (cpu_have_named_feature(EVTSTRM))
-#else
-		if (elf_hwcap & HWCAP_EVTSTRM)
-#endif
+		if (arch_timer_have_evtstrm_feature())
 			cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
 	}
 	return NOTIFY_OK;
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index e8eab16b154b..74cb299f5089 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -206,7 +206,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
 
 static struct clocksource mct_frc = {
 	.name		= "mct-frc",
-	.rating		= 400,
+	.rating		= 450,	/* use value higher than ARM arch timer */
 	.read		= exynos4_frc_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -461,7 +461,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->set_state_oneshot_stopped = set_state_shutdown;
 	evt->tick_resume = set_state_shutdown;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->rating = 450;
+	evt->rating = 500;	/* use value higher than ARM arch timer */
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
new file mode 100644
index 000000000000..ba2c79e6a0ee
--- /dev/null
+++ b/drivers/clocksource/hyperv_timer.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Clocksource driver for the synthetic counter and timers
+ * provided by the Hyper-V hypervisor to guest VMs, as described
+ * in the Hyper-V Top Level Functional Spec (TLFS). This driver
+ * is instruction set architecture independent.
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author:  Michael Kelley <mikelley@microsoft.com>
+ */
+
+#include <linux/percpu.h>
+#include <linux/cpumask.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/sched_clock.h>
+#include <linux/mm.h>
+#include <clocksource/hyperv_timer.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+
+static struct clock_event_device __percpu *hv_clock_event;
+
+/*
+ * If false, we're using the old mechanism for stimer0 interrupts
+ * where it sends a VMbus message when it expires. The old
+ * mechanism is used when running on older versions of Hyper-V
+ * that don't support Direct Mode. While Hyper-V provides
+ * four stimer's per CPU, Linux uses only stimer0.
+ */
+static bool direct_mode_enabled;
+
+static int stimer0_irq;
+static int stimer0_vector;
+static int stimer0_message_sint;
+
+/*
+ * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
+ * does not use VMbus or any VMbus messages, so process here and not
+ * in the VMbus driver code.
+ */
+void hv_stimer0_isr(void)
+{
+	struct clock_event_device *ce;
+
+	ce = this_cpu_ptr(hv_clock_event);
+	ce->event_handler(ce);
+}
+EXPORT_SYMBOL_GPL(hv_stimer0_isr);
+
+static int hv_ce_set_next_event(unsigned long delta,
+				struct clock_event_device *evt)
+{
+	u64 current_tick;
+
+	current_tick = hyperv_cs->read(NULL);
+	current_tick += delta;
+	hv_init_timer(0, current_tick);
+	return 0;
+}
+
+static int hv_ce_shutdown(struct clock_event_device *evt)
+{
+	hv_init_timer(0, 0);
+	hv_init_timer_config(0, 0);
+	if (direct_mode_enabled)
+		hv_disable_stimer0_percpu_irq(stimer0_irq);
+
+	return 0;
+}
+
+static int hv_ce_set_oneshot(struct clock_event_device *evt)
+{
+	union hv_stimer_config timer_cfg;
+
+	timer_cfg.as_uint64 = 0;
+	timer_cfg.enable = 1;
+	timer_cfg.auto_enable = 1;
+	if (direct_mode_enabled) {
+		/*
+		 * When it expires, the timer will directly interrupt
+		 * on the specified hardware vector/IRQ.
+		 */
+		timer_cfg.direct_mode = 1;
+		timer_cfg.apic_vector = stimer0_vector;
+		hv_enable_stimer0_percpu_irq(stimer0_irq);
+	} else {
+		/*
+		 * When it expires, the timer will generate a VMbus message,
+		 * to be handled by the normal VMbus interrupt handler.
+		 */
+		timer_cfg.direct_mode = 0;
+		timer_cfg.sintx = stimer0_message_sint;
+	}
+	hv_init_timer_config(0, timer_cfg.as_uint64);
+	return 0;
+}
+
+/*
+ * hv_stimer_init - Per-cpu initialization of the clockevent
+ */
+void hv_stimer_init(unsigned int cpu)
+{
+	struct clock_event_device *ce;
+
+	/*
+	 * Synthetic timers are always available except on old versions of
+	 * Hyper-V on x86.  In that case, just return as Linux will use a
+	 * clocksource based on emulated PIT or LAPIC timer hardware.
+	 */
+	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
+		return;
+
+	ce = per_cpu_ptr(hv_clock_event, cpu);
+	ce->name = "Hyper-V clockevent";
+	ce->features = CLOCK_EVT_FEAT_ONESHOT;
+	ce->cpumask = cpumask_of(cpu);
+	ce->rating = 1000;
+	ce->set_state_shutdown = hv_ce_shutdown;
+	ce->set_state_oneshot = hv_ce_set_oneshot;
+	ce->set_next_event = hv_ce_set_next_event;
+
+	clockevents_config_and_register(ce,
+					HV_CLOCK_HZ,
+					HV_MIN_DELTA_TICKS,
+					HV_MAX_MAX_DELTA_TICKS);
+}
+EXPORT_SYMBOL_GPL(hv_stimer_init);
+
+/*
+ * hv_stimer_cleanup - Per-cpu cleanup of the clockevent
+ */
+void hv_stimer_cleanup(unsigned int cpu)
+{
+	struct clock_event_device *ce;
+
+	/* Turn off clockevent device */
+	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
+		ce = per_cpu_ptr(hv_clock_event, cpu);
+		hv_ce_shutdown(ce);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_stimer_cleanup);
+
+/* hv_stimer_alloc - Global initialization of the clockevent and stimer0 */
+int hv_stimer_alloc(int sint)
+{
+	int ret;
+
+	hv_clock_event = alloc_percpu(struct clock_event_device);
+	if (!hv_clock_event)
+		return -ENOMEM;
+
+	direct_mode_enabled = ms_hyperv.misc_features &
+			HV_STIMER_DIRECT_MODE_AVAILABLE;
+	if (direct_mode_enabled) {
+		ret = hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
+				hv_stimer0_isr);
+		if (ret) {
+			free_percpu(hv_clock_event);
+			hv_clock_event = NULL;
+			return ret;
+		}
+	}
+
+	stimer0_message_sint = sint;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_stimer_alloc);
+
+/* hv_stimer_free - Free global resources allocated by hv_stimer_alloc() */
+void hv_stimer_free(void)
+{
+	if (direct_mode_enabled && (stimer0_irq != 0)) {
+		hv_remove_stimer0_irq(stimer0_irq);
+		stimer0_irq = 0;
+	}
+	free_percpu(hv_clock_event);
+	hv_clock_event = NULL;
+}
+EXPORT_SYMBOL_GPL(hv_stimer_free);
+
+/*
+ * Do a global cleanup of clockevents for the cases of kexec and
+ * vmbus exit
+ */
+void hv_stimer_global_cleanup(void)
+{
+	int	cpu;
+	struct clock_event_device *ce;
+
+	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
+		for_each_present_cpu(cpu) {
+			ce = per_cpu_ptr(hv_clock_event, cpu);
+			clockevents_unbind_device(ce, cpu);
+		}
+	}
+	hv_stimer_free();
+}
+EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
+
+/*
+ * Code and definitions for the Hyper-V clocksources.  Two
+ * clocksources are defined: one that reads the Hyper-V defined MSR, and
+ * the other that uses the TSC reference page feature as defined in the
+ * TLFS.  The MSR version is for compatibility with old versions of
+ * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
+ */
+
+struct clocksource *hyperv_cs;
+EXPORT_SYMBOL_GPL(hyperv_cs);
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+
+static struct ms_hyperv_tsc_page *tsc_pg;
+
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return tsc_pg;
+}
+EXPORT_SYMBOL_GPL(hv_get_tsc_page);
+
+static u64 notrace read_hv_sched_clock_tsc(void)
+{
+	u64 current_tick = hv_read_tsc_page(tsc_pg);
+
+	if (current_tick == U64_MAX)
+		hv_get_time_ref_count(current_tick);
+
+	return current_tick;
+}
+
+static u64 read_hv_clock_tsc(struct clocksource *arg)
+{
+	return read_hv_sched_clock_tsc();
+}
+
+static struct clocksource hyperv_cs_tsc = {
+	.name	= "hyperv_clocksource_tsc_page",
+	.rating	= 400,
+	.read	= read_hv_clock_tsc,
+	.mask	= CLOCKSOURCE_MASK(64),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+#endif
+
+static u64 notrace read_hv_sched_clock_msr(void)
+{
+	u64 current_tick;
+	/*
+	 * Read the partition counter to get the current tick count. This count
+	 * is set to 0 when the partition is created and is incremented in
+	 * 100 nanosecond units.
+	 */
+	hv_get_time_ref_count(current_tick);
+	return current_tick;
+}
+
+static u64 read_hv_clock_msr(struct clocksource *arg)
+{
+	return read_hv_sched_clock_msr();
+}
+
+static struct clocksource hyperv_cs_msr = {
+	.name	= "hyperv_clocksource_msr",
+	.rating	= 400,
+	.read	= read_hv_clock_msr,
+	.mask	= CLOCKSOURCE_MASK(64),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+static bool __init hv_init_tsc_clocksource(void)
+{
+	u64		tsc_msr;
+	phys_addr_t	phys_addr;
+
+	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
+		return false;
+
+	tsc_pg = vmalloc(PAGE_SIZE);
+	if (!tsc_pg)
+		return false;
+
+	hyperv_cs = &hyperv_cs_tsc;
+	phys_addr = page_to_phys(vmalloc_to_page(tsc_pg));
+
+	/*
+	 * The Hyper-V TLFS specifies to preserve the value of reserved
+	 * bits in registers. So read the existing value, preserve the
+	 * low order 12 bits, and add in the guest physical address
+	 * (which already has at least the low 12 bits set to zero since
+	 * it is page aligned). Also set the "enable" bit, which is bit 0.
+	 */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= GENMASK_ULL(11, 0);
+	tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
+
+	hv_set_clocksource_vdso(hyperv_cs_tsc);
+	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
+
+	/* sched_clock_register is needed on ARM64 but is a no-op on x86 */
+	sched_clock_register(read_hv_sched_clock_tsc, 64, HV_CLOCK_HZ);
+	return true;
+}
+#else
+static bool __init hv_init_tsc_clocksource(void)
+{
+	return false;
+}
+#endif
+
+
+void __init hv_init_clocksource(void)
+{
+	/*
+	 * Try to set up the TSC page clocksource. If it succeeds, we're
+	 * done. Otherwise, set up the MSR clocksoruce.  At least one of
+	 * these will always be available except on very old versions of
+	 * Hyper-V on x86.  In that case we won't have a Hyper-V
+	 * clocksource, but Linux will still run with a clocksource based
+	 * on the emulated PIT or LAPIC timer.
+	 */
+	if (hv_init_tsc_clocksource())
+		return;
+
+	if (!(ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE))
+		return;
+
+	hyperv_cs = &hyperv_cs_msr;
+	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
+
+	/* sched_clock_register is needed on ARM64 but is a no-op on x86 */
+	sched_clock_register(read_hv_sched_clock_msr, 64, HV_CLOCK_HZ);
+}
+EXPORT_SYMBOL_GPL(hv_init_clocksource);
diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
new file mode 100644
index 000000000000..62745c962049
--- /dev/null
+++ b/drivers/clocksource/timer-davinci.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TI DaVinci clocksource driver
+ *
+ * Copyright (C) 2019 Texas Instruments
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ * (with tiny parts adopted from code by Kevin Hilman <khilman@baylibre.com>)
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#include <clocksource/timer-davinci.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt "\n", __func__
+
+#define DAVINCI_TIMER_REG_TIM12			0x10
+#define DAVINCI_TIMER_REG_TIM34			0x14
+#define DAVINCI_TIMER_REG_PRD12			0x18
+#define DAVINCI_TIMER_REG_PRD34			0x1c
+#define DAVINCI_TIMER_REG_TCR			0x20
+#define DAVINCI_TIMER_REG_TGCR			0x24
+
+#define DAVINCI_TIMER_TIMMODE_MASK		GENMASK(3, 2)
+#define DAVINCI_TIMER_RESET_MASK		GENMASK(1, 0)
+#define DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED	BIT(2)
+#define DAVINCI_TIMER_UNRESET			GENMASK(1, 0)
+
+#define DAVINCI_TIMER_ENAMODE_MASK		GENMASK(1, 0)
+#define DAVINCI_TIMER_ENAMODE_DISABLED		0x00
+#define DAVINCI_TIMER_ENAMODE_ONESHOT		BIT(0)
+#define DAVINCI_TIMER_ENAMODE_PERIODIC		BIT(1)
+
+#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM12	6
+#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM34	22
+
+#define DAVINCI_TIMER_MIN_DELTA			0x01
+#define DAVINCI_TIMER_MAX_DELTA			0xfffffffe
+
+#define DAVINCI_TIMER_CLKSRC_BITS		32
+
+#define DAVINCI_TIMER_TGCR_DEFAULT \
+		(DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED | DAVINCI_TIMER_UNRESET)
+
+struct davinci_clockevent {
+	struct clock_event_device dev;
+	void __iomem *base;
+	unsigned int cmp_off;
+};
+
+/*
+ * This must be globally accessible by davinci_timer_read_sched_clock(), so
+ * let's keep it here.
+ */
+static struct {
+	struct clocksource dev;
+	void __iomem *base;
+	unsigned int tim_off;
+} davinci_clocksource;
+
+static struct davinci_clockevent *
+to_davinci_clockevent(struct clock_event_device *clockevent)
+{
+	return container_of(clockevent, struct davinci_clockevent, dev);
+}
+
+static unsigned int
+davinci_clockevent_read(struct davinci_clockevent *clockevent,
+			unsigned int reg)
+{
+	return readl_relaxed(clockevent->base + reg);
+}
+
+static void davinci_clockevent_write(struct davinci_clockevent *clockevent,
+				     unsigned int reg, unsigned int val)
+{
+	writel_relaxed(val, clockevent->base + reg);
+}
+
+static void davinci_tim12_shutdown(void __iomem *base)
+{
+	unsigned int tcr;
+
+	tcr = DAVINCI_TIMER_ENAMODE_DISABLED <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
+	/*
+	 * This function is only ever called if we're using both timer
+	 * halves. In this case TIM34 runs in periodic mode and we must
+	 * not modify it.
+	 */
+	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
+
+	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
+}
+
+static void davinci_tim12_set_oneshot(void __iomem *base)
+{
+	unsigned int tcr;
+
+	tcr = DAVINCI_TIMER_ENAMODE_ONESHOT <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
+	/* Same as above. */
+	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
+
+	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
+}
+
+static int davinci_clockevent_shutdown(struct clock_event_device *dev)
+{
+	struct davinci_clockevent *clockevent;
+
+	clockevent = to_davinci_clockevent(dev);
+
+	davinci_tim12_shutdown(clockevent->base);
+
+	return 0;
+}
+
+static int davinci_clockevent_set_oneshot(struct clock_event_device *dev)
+{
+	struct davinci_clockevent *clockevent = to_davinci_clockevent(dev);
+
+	davinci_clockevent_write(clockevent, DAVINCI_TIMER_REG_TIM12, 0x0);
+
+	davinci_tim12_set_oneshot(clockevent->base);
+
+	return 0;
+}
+
+static int
+davinci_clockevent_set_next_event_std(unsigned long cycles,
+				      struct clock_event_device *dev)
+{
+	struct davinci_clockevent *clockevent = to_davinci_clockevent(dev);
+
+	davinci_clockevent_shutdown(dev);
+
+	davinci_clockevent_write(clockevent, DAVINCI_TIMER_REG_TIM12, 0x0);
+	davinci_clockevent_write(clockevent, DAVINCI_TIMER_REG_PRD12, cycles);
+
+	davinci_clockevent_set_oneshot(dev);
+
+	return 0;
+}
+
+static int
+davinci_clockevent_set_next_event_cmp(unsigned long cycles,
+				      struct clock_event_device *dev)
+{
+	struct davinci_clockevent *clockevent = to_davinci_clockevent(dev);
+	unsigned int curr_time;
+
+	curr_time = davinci_clockevent_read(clockevent,
+					    DAVINCI_TIMER_REG_TIM12);
+	davinci_clockevent_write(clockevent,
+				 clockevent->cmp_off, curr_time + cycles);
+
+	return 0;
+}
+
+static irqreturn_t davinci_timer_irq_timer(int irq, void *data)
+{
+	struct davinci_clockevent *clockevent = data;
+
+	if (!clockevent_state_oneshot(&clockevent->dev))
+		davinci_tim12_shutdown(clockevent->base);
+
+	clockevent->dev.event_handler(&clockevent->dev);
+
+	return IRQ_HANDLED;
+}
+
+static u64 notrace davinci_timer_read_sched_clock(void)
+{
+	return readl_relaxed(davinci_clocksource.base +
+			     davinci_clocksource.tim_off);
+}
+
+static u64 davinci_clocksource_read(struct clocksource *dev)
+{
+	return davinci_timer_read_sched_clock();
+}
+
+/*
+ * Standard use-case: we're using tim12 for clockevent and tim34 for
+ * clocksource. The default is making the former run in oneshot mode
+ * and the latter in periodic mode.
+ */
+static void davinci_clocksource_init_tim34(void __iomem *base)
+{
+	int tcr;
+
+	tcr = DAVINCI_TIMER_ENAMODE_PERIODIC <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
+	tcr |= DAVINCI_TIMER_ENAMODE_ONESHOT <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
+
+	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM34);
+	writel_relaxed(UINT_MAX, base + DAVINCI_TIMER_REG_PRD34);
+	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
+}
+
+/*
+ * Special use-case on da830: the DSP may use tim34. We're using tim12 for
+ * both clocksource and clockevent. We set tim12 to periodic and don't touch
+ * tim34.
+ */
+static void davinci_clocksource_init_tim12(void __iomem *base)
+{
+	unsigned int tcr;
+
+	tcr = DAVINCI_TIMER_ENAMODE_PERIODIC <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
+
+	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM12);
+	writel_relaxed(UINT_MAX, base + DAVINCI_TIMER_REG_PRD12);
+	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
+}
+
+static void davinci_timer_init(void __iomem *base)
+{
+	/* Set clock to internal mode and disable it. */
+	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TCR);
+	/*
+	 * Reset both 32-bit timers, set no prescaler for timer 34, set the
+	 * timer to dual 32-bit unchained mode, unreset both 32-bit timers.
+	 */
+	writel_relaxed(DAVINCI_TIMER_TGCR_DEFAULT,
+		       base + DAVINCI_TIMER_REG_TGCR);
+	/* Init both counters to zero. */
+	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM12);
+	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM34);
+}
+
+int __init davinci_timer_register(struct clk *clk,
+				  const struct davinci_timer_cfg *timer_cfg)
+{
+	struct davinci_clockevent *clockevent;
+	unsigned int tick_rate;
+	void __iomem *base;
+	int rv;
+
+	rv = clk_prepare_enable(clk);
+	if (rv) {
+		pr_err("Unable to prepare and enable the timer clock");
+		return rv;
+	}
+
+	if (!request_mem_region(timer_cfg->reg.start,
+				resource_size(&timer_cfg->reg),
+				"davinci-timer")) {
+		pr_err("Unable to request memory region");
+		return -EBUSY;
+	}
+
+	base = ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
+	if (!base) {
+		pr_err("Unable to map the register range");
+		return -ENOMEM;
+	}
+
+	davinci_timer_init(base);
+	tick_rate = clk_get_rate(clk);
+
+	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL | __GFP_NOFAIL);
+	if (!clockevent) {
+		pr_err("Error allocating memory for clockevent data");
+		return -ENOMEM;
+	}
+
+	clockevent->dev.name = "tim12";
+	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
+	clockevent->dev.cpumask = cpumask_of(0);
+	clockevent->base = base;
+
+	if (timer_cfg->cmp_off) {
+		clockevent->cmp_off = timer_cfg->cmp_off;
+		clockevent->dev.set_next_event =
+				davinci_clockevent_set_next_event_cmp;
+	} else {
+		clockevent->dev.set_next_event =
+				davinci_clockevent_set_next_event_std;
+		clockevent->dev.set_state_oneshot =
+				davinci_clockevent_set_oneshot;
+		clockevent->dev.set_state_shutdown =
+				davinci_clockevent_shutdown;
+	}
+
+	rv = request_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ].start,
+			 davinci_timer_irq_timer, IRQF_TIMER,
+			 "clockevent/tim12", clockevent);
+	if (rv) {
+		pr_err("Unable to request the clockevent interrupt");
+		return rv;
+	}
+
+	clockevents_config_and_register(&clockevent->dev, tick_rate,
+					DAVINCI_TIMER_MIN_DELTA,
+					DAVINCI_TIMER_MAX_DELTA);
+
+	davinci_clocksource.dev.rating = 300;
+	davinci_clocksource.dev.read = davinci_clocksource_read;
+	davinci_clocksource.dev.mask =
+			CLOCKSOURCE_MASK(DAVINCI_TIMER_CLKSRC_BITS);
+	davinci_clocksource.dev.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	davinci_clocksource.base = base;
+
+	if (timer_cfg->cmp_off) {
+		davinci_clocksource.dev.name = "tim12";
+		davinci_clocksource.tim_off = DAVINCI_TIMER_REG_TIM12;
+		davinci_clocksource_init_tim12(base);
+	} else {
+		davinci_clocksource.dev.name = "tim34";
+		davinci_clocksource.tim_off = DAVINCI_TIMER_REG_TIM34;
+		davinci_clocksource_init_tim34(base);
+	}
+
+	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
+	if (rv) {
+		pr_err("Unable to register clocksource");
+		return rv;
+	}
+
+	sched_clock_register(davinci_timer_read_sched_clock,
+			     DAVINCI_TIMER_CLKSRC_BITS, tick_rate);
+
+	return 0;
+}
+
+static int __init of_davinci_timer_register(struct device_node *np)
+{
+	struct davinci_timer_cfg timer_cfg = { };
+	struct clk *clk;
+	int rv;
+
+	rv = of_address_to_resource(np, 0, &timer_cfg.reg);
+	if (rv) {
+		pr_err("Unable to get the register range for timer");
+		return rv;
+	}
+
+	rv = of_irq_to_resource_table(np, timer_cfg.irq,
+				      DAVINCI_TIMER_NUM_IRQS);
+	if (rv != DAVINCI_TIMER_NUM_IRQS) {
+		pr_err("Unable to get the interrupts for timer");
+		return rv;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Unable to get the timer clock");
+		return PTR_ERR(clk);
+	}
+
+	rv = davinci_timer_register(clk, &timer_cfg);
+	if (rv)
+		clk_put(clk);
+
+	return rv;
+}
+TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_register);
diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
new file mode 100644
index 000000000000..fd7d68066efb
--- /dev/null
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2017-2019 NXP
+
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include "timer-of.h"
+
+#define CMP_OFFSET	0x10000
+
+#define CNTCV_LO	0x8
+#define CNTCV_HI	0xc
+#define CMPCV_LO	(CMP_OFFSET + 0x20)
+#define CMPCV_HI	(CMP_OFFSET + 0x24)
+#define CMPCR		(CMP_OFFSET + 0x2c)
+
+#define SYS_CTR_EN		0x1
+#define SYS_CTR_IRQ_MASK	0x2
+
+static void __iomem *sys_ctr_base;
+static u32 cmpcr;
+
+static void sysctr_timer_enable(bool enable)
+{
+	writel(enable ? cmpcr | SYS_CTR_EN : cmpcr, sys_ctr_base + CMPCR);
+}
+
+static void sysctr_irq_acknowledge(void)
+{
+	/*
+	 * clear the enable bit(EN =0) will clear
+	 * the status bit(ISTAT = 0), then the interrupt
+	 * signal will be negated(acknowledged).
+	 */
+	sysctr_timer_enable(false);
+}
+
+static inline u64 sysctr_read_counter(void)
+{
+	u32 cnt_hi, tmp_hi, cnt_lo;
+
+	do {
+		cnt_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
+		cnt_lo = readl_relaxed(sys_ctr_base + CNTCV_LO);
+		tmp_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
+	} while (tmp_hi != cnt_hi);
+
+	return  ((u64) cnt_hi << 32) | cnt_lo;
+}
+
+static int sysctr_set_next_event(unsigned long delta,
+				 struct clock_event_device *evt)
+{
+	u32 cmp_hi, cmp_lo;
+	u64 next;
+
+	sysctr_timer_enable(false);
+
+	next = sysctr_read_counter();
+
+	next += delta;
+
+	cmp_hi = (next >> 32) & 0x00fffff;
+	cmp_lo = next & 0xffffffff;
+
+	writel_relaxed(cmp_hi, sys_ctr_base + CMPCV_HI);
+	writel_relaxed(cmp_lo, sys_ctr_base + CMPCV_LO);
+
+	sysctr_timer_enable(true);
+
+	return 0;
+}
+
+static int sysctr_set_state_oneshot(struct clock_event_device *evt)
+{
+	return 0;
+}
+
+static int sysctr_set_state_shutdown(struct clock_event_device *evt)
+{
+	sysctr_timer_enable(false);
+
+	return 0;
+}
+
+static irqreturn_t sysctr_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	sysctr_irq_acknowledge();
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct timer_of to_sysctr = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
+	.clkevt = {
+		.name			= "i.MX system counter timer",
+		.features		= CLOCK_EVT_FEAT_ONESHOT |
+						CLOCK_EVT_FEAT_DYNIRQ,
+		.set_state_oneshot	= sysctr_set_state_oneshot,
+		.set_next_event		= sysctr_set_next_event,
+		.set_state_shutdown	= sysctr_set_state_shutdown,
+		.rating			= 200,
+	},
+	.of_irq = {
+		.handler		= sysctr_timer_interrupt,
+		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
+	},
+	.of_clk = {
+		.name = "per",
+	},
+};
+
+static void __init sysctr_clockevent_init(void)
+{
+	to_sysctr.clkevt.cpumask = cpumask_of(0);
+
+	clockevents_config_and_register(&to_sysctr.clkevt,
+					timer_of_rate(&to_sysctr),
+					0xff, 0x7fffffff);
+}
+
+static int __init sysctr_timer_init(struct device_node *np)
+{
+	int ret = 0;
+
+	ret = timer_of_init(np, &to_sysctr);
+	if (ret)
+		return ret;
+
+	sys_ctr_base = timer_of_base(&to_sysctr);
+	cmpcr = readl(sys_ctr_base + CMPCR);
+	cmpcr &= ~SYS_CTR_EN;
+
+	sysctr_clockevent_init();
+
+	return 0;
+}
+TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);
diff --git a/drivers/clocksource/timer-ixp4xx.c b/drivers/clocksource/timer-ixp4xx.c
index 5c2190b654cd..9396745e1c17 100644
--- a/drivers/clocksource/timer-ixp4xx.c
+++ b/drivers/clocksource/timer-ixp4xx.c
@@ -75,14 +75,19 @@ to_ixp4xx_timer(struct clock_event_device *evt)
 	return container_of(evt, struct ixp4xx_timer, clkevt);
 }
 
-static u64 notrace ixp4xx_read_sched_clock(void)
+static unsigned long ixp4xx_read_timer(void)
 {
 	return __raw_readl(local_ixp4xx_timer->base + IXP4XX_OSTS_OFFSET);
 }
 
+static u64 notrace ixp4xx_read_sched_clock(void)
+{
+	return ixp4xx_read_timer();
+}
+
 static u64 ixp4xx_clocksource_read(struct clocksource *c)
 {
-	return __raw_readl(local_ixp4xx_timer->base + IXP4XX_OSTS_OFFSET);
+	return ixp4xx_read_timer();
 }
 
 static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
@@ -224,6 +229,13 @@ static __init int ixp4xx_timer_register(void __iomem *base,
 
 	sched_clock_register(ixp4xx_read_sched_clock, 32, timer_freq);
 
+#ifdef CONFIG_ARM
+	/* Also use this timer for delays */
+	tmr->delay_timer.read_current_timer = ixp4xx_read_timer;
+	tmr->delay_timer.freq = timer_freq;
+	register_current_timer_delay(&tmr->delay_timer);
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/clocksource/timer-meson6.c b/drivers/clocksource/timer-meson6.c
index 84bd9479c3f8..9e8b467c71da 100644
--- a/drivers/clocksource/timer-meson6.c
+++ b/drivers/clocksource/timer-meson6.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson6 SoCs timer handling.
  *
  * Copyright (C) 2014 Carlo Caione <carlo@caione.org>
  *
  * Based on code from Amlogic, Inc
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/bitfield.h>
diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
new file mode 100644
index 000000000000..e9635c25eef4
--- /dev/null
+++ b/drivers/clocksource/timer-tegra.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ */
+
+#define pr_fmt(fmt)	"tegra-timer: " fmt
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/percpu.h>
+#include <linux/sched_clock.h>
+#include <linux/time.h>
+
+#include "timer-of.h"
+
+#define RTC_SECONDS		0x08
+#define RTC_SHADOW_SECONDS	0x0c
+#define RTC_MILLISECONDS	0x10
+
+#define TIMERUS_CNTR_1US	0x10
+#define TIMERUS_USEC_CFG	0x14
+#define TIMERUS_CNTR_FREEZE	0x4c
+
+#define TIMER_PTV		0x0
+#define TIMER_PTV_EN		BIT(31)
+#define TIMER_PTV_PER		BIT(30)
+#define TIMER_PCR		0x4
+#define TIMER_PCR_INTR_CLR	BIT(30)
+
+#define TIMER1_BASE		0x00
+#define TIMER2_BASE		0x08
+#define TIMER3_BASE		0x50
+#define TIMER4_BASE		0x58
+#define TIMER10_BASE		0x90
+
+#define TIMER1_IRQ_IDX		0
+#define TIMER10_IRQ_IDX		10
+
+#define TIMER_1MHz		1000000
+
+static u32 usec_config;
+static void __iomem *timer_reg_base;
+
+static int tegra_timer_set_next_event(unsigned long cycles,
+				      struct clock_event_device *evt)
+{
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	/*
+	 * Tegra's timer uses n+1 scheme for the counter, i.e. timer will
+	 * fire after one tick if 0 is loaded.
+	 *
+	 * The minimum and maximum numbers of oneshot ticks are defined
+	 * by clockevents_config_and_register(1, 0x1fffffff + 1) invocation
+	 * below in the code. Hence the cycles (ticks) can't be outside of
+	 * a range supportable by hardware.
+	 */
+	writel_relaxed(TIMER_PTV_EN | (cycles - 1), reg_base + TIMER_PTV);
+
+	return 0;
+}
+
+static int tegra_timer_shutdown(struct clock_event_device *evt)
+{
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel_relaxed(0, reg_base + TIMER_PTV);
+
+	return 0;
+}
+
+static int tegra_timer_set_periodic(struct clock_event_device *evt)
+{
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+	unsigned long period = timer_of_period(to_timer_of(evt));
+
+	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (period - 1),
+		       reg_base + TIMER_PTV);
+
+	return 0;
+}
+
+static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static void tegra_timer_suspend(struct clock_event_device *evt)
+{
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+}
+
+static void tegra_timer_resume(struct clock_event_device *evt)
+{
+	writel_relaxed(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
+}
+
+static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
+	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
+
+	.clkevt = {
+		.name = "tegra_timer",
+		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+		.set_next_event = tegra_timer_set_next_event,
+		.set_state_shutdown = tegra_timer_shutdown,
+		.set_state_periodic = tegra_timer_set_periodic,
+		.set_state_oneshot = tegra_timer_shutdown,
+		.tick_resume = tegra_timer_shutdown,
+		.suspend = tegra_timer_suspend,
+		.resume = tegra_timer_resume,
+	},
+};
+
+static int tegra_timer_setup(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
+
+	writel_relaxed(0, timer_of_base(to) + TIMER_PTV);
+	writel_relaxed(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
+
+	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
+	enable_irq(to->clkevt.irq);
+
+	/*
+	 * Tegra's timer uses n+1 scheme for the counter, i.e. timer will
+	 * fire after one tick if 0 is loaded and thus minimum number of
+	 * ticks is 1. In result both of the clocksource's tick limits are
+	 * higher than a minimum and maximum that hardware register can
+	 * take by 1, this is then taken into account by set_next_event
+	 * callback.
+	 */
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					1, /* min */
+					0x1fffffff + 1); /* max 29 bits + 1 */
+
+	return 0;
+}
+
+static int tegra_timer_stop(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
+
+	to->clkevt.set_state_shutdown(&to->clkevt);
+	disable_irq_nosync(to->clkevt.irq);
+
+	return 0;
+}
+
+static u64 notrace tegra_read_sched_clock(void)
+{
+	return readl_relaxed(timer_reg_base + TIMERUS_CNTR_1US);
+}
+
+#ifdef CONFIG_ARM
+static unsigned long tegra_delay_timer_read_counter_long(void)
+{
+	return readl_relaxed(timer_reg_base + TIMERUS_CNTR_1US);
+}
+
+static struct delay_timer tegra_delay_timer = {
+	.read_current_timer = tegra_delay_timer_read_counter_long,
+	.freq = TIMER_1MHz,
+};
+#endif
+
+static struct timer_of suspend_rtc_to = {
+	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK,
+};
+
+/*
+ * tegra_rtc_read - Reads the Tegra RTC registers
+ * Care must be taken that this function is not called while the
+ * tegra_rtc driver could be executing to avoid race conditions
+ * on the RTC shadow register
+ */
+static u64 tegra_rtc_read_ms(struct clocksource *cs)
+{
+	void __iomem *reg_base = timer_of_base(&suspend_rtc_to);
+
+	u32 ms = readl_relaxed(reg_base + RTC_MILLISECONDS);
+	u32 s = readl_relaxed(reg_base + RTC_SHADOW_SECONDS);
+
+	return (u64)s * MSEC_PER_SEC + ms;
+}
+
+static struct clocksource suspend_rtc_clocksource = {
+	.name	= "tegra_suspend_timer",
+	.rating	= 200,
+	.read	= tegra_rtc_read_ms,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
+};
+
+static inline unsigned int tegra_base_for_cpu(int cpu, bool tegra20)
+{
+	if (tegra20) {
+		switch (cpu) {
+		case 0:
+			return TIMER1_BASE;
+		case 1:
+			return TIMER2_BASE;
+		case 2:
+			return TIMER3_BASE;
+		default:
+			return TIMER4_BASE;
+		}
+	}
+
+	return TIMER10_BASE + cpu * 8;
+}
+
+static inline unsigned int tegra_irq_idx_for_cpu(int cpu, bool tegra20)
+{
+	if (tegra20)
+		return TIMER1_IRQ_IDX + cpu;
+
+	return TIMER10_IRQ_IDX + cpu;
+}
+
+static inline unsigned long tegra_rate_for_timer(struct timer_of *to,
+						 bool tegra20)
+{
+	/*
+	 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
+	 * parent clock.
+	 */
+	if (tegra20)
+		return TIMER_1MHz;
+
+	return timer_of_rate(to);
+}
+
+static int __init tegra_init_timer(struct device_node *np, bool tegra20,
+				   int rating)
+{
+	struct timer_of *to;
+	int cpu, ret;
+
+	to = this_cpu_ptr(&tegra_to);
+	ret = timer_of_init(np, to);
+	if (ret)
+		goto out;
+
+	timer_reg_base = timer_of_base(to);
+
+	/*
+	 * Configure microsecond timers to have 1MHz clock
+	 * Config register is 0xqqww, where qq is "dividend", ww is "divisor"
+	 * Uses n+1 scheme
+	 */
+	switch (timer_of_rate(to)) {
+	case 12000000:
+		usec_config = 0x000b; /* (11+1)/(0+1) */
+		break;
+	case 12800000:
+		usec_config = 0x043f; /* (63+1)/(4+1) */
+		break;
+	case 13000000:
+		usec_config = 0x000c; /* (12+1)/(0+1) */
+		break;
+	case 16800000:
+		usec_config = 0x0453; /* (83+1)/(4+1) */
+		break;
+	case 19200000:
+		usec_config = 0x045f; /* (95+1)/(4+1) */
+		break;
+	case 26000000:
+		usec_config = 0x0019; /* (25+1)/(0+1) */
+		break;
+	case 38400000:
+		usec_config = 0x04bf; /* (191+1)/(4+1) */
+		break;
+	case 48000000:
+		usec_config = 0x002f; /* (47+1)/(0+1) */
+		break;
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+
+	writel_relaxed(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
+
+	for_each_possible_cpu(cpu) {
+		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		unsigned long flags = IRQF_TIMER | IRQF_NOBALANCING;
+		unsigned long rate = tegra_rate_for_timer(to, tegra20);
+		unsigned int base = tegra_base_for_cpu(cpu, tegra20);
+		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20);
+		unsigned int irq = irq_of_parse_and_map(np, idx);
+
+		if (!irq) {
+			pr_err("failed to map irq for cpu%d\n", cpu);
+			ret = -EINVAL;
+			goto out_irq;
+		}
+
+		cpu_to->clkevt.irq = irq;
+		cpu_to->clkevt.rating = rating;
+		cpu_to->clkevt.cpumask = cpumask_of(cpu);
+		cpu_to->of_base.base = timer_reg_base + base;
+		cpu_to->of_clk.period = rate / HZ;
+		cpu_to->of_clk.rate = rate;
+
+		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
+
+		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr, flags,
+				  cpu_to->clkevt.name, &cpu_to->clkevt);
+		if (ret) {
+			pr_err("failed to set up irq for cpu%d: %d\n",
+			       cpu, ret);
+			irq_dispose_mapping(cpu_to->clkevt.irq);
+			cpu_to->clkevt.irq = 0;
+			goto out_irq;
+		}
+	}
+
+	sched_clock_register(tegra_read_sched_clock, 32, TIMER_1MHz);
+
+	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
+				    "timer_us", TIMER_1MHz, 300, 32,
+				    clocksource_mmio_readl_up);
+	if (ret)
+		pr_err("failed to register clocksource: %d\n", ret);
+
+#ifdef CONFIG_ARM
+	register_current_timer_delay(&tegra_delay_timer);
+#endif
+
+	ret = cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
+				"AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
+				tegra_timer_stop);
+	if (ret)
+		pr_err("failed to set up cpu hp state: %d\n", ret);
+
+	return ret;
+
+out_irq:
+	for_each_possible_cpu(cpu) {
+		struct timer_of *cpu_to;
+
+		cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		if (cpu_to->clkevt.irq) {
+			free_irq(cpu_to->clkevt.irq, &cpu_to->clkevt);
+			irq_dispose_mapping(cpu_to->clkevt.irq);
+		}
+	}
+
+	to->of_base.base = timer_reg_base;
+out:
+	timer_of_cleanup(to);
+
+	return ret;
+}
+
+static int __init tegra210_init_timer(struct device_node *np)
+{
+	/*
+	 * Arch-timer can't survive across power cycle of CPU core and
+	 * after CPUPORESET signal due to a system design shortcoming,
+	 * hence tegra-timer is more preferable on Tegra210.
+	 */
+	return tegra_init_timer(np, false, 460);
+}
+TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_init_timer);
+
+static int __init tegra20_init_timer(struct device_node *np)
+{
+	int rating;
+
+	/*
+	 * Tegra20 and Tegra30 have Cortex A9 CPU that has a TWD timer,
+	 * that timer runs off the CPU clock and hence is subjected to
+	 * a jitter caused by DVFS clock rate changes. Tegra-timer is
+	 * more preferable for older Tegra's, while later SoC generations
+	 * have arch-timer as a main per-CPU timer and it is not affected
+	 * by DVFS changes.
+	 */
+	if (of_machine_is_compatible("nvidia,tegra20") ||
+	    of_machine_is_compatible("nvidia,tegra30"))
+		rating = 460;
+	else
+		rating = 330;
+
+	return tegra_init_timer(np, true, rating);
+}
+TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
+
+static int __init tegra20_init_rtc(struct device_node *np)
+{
+	int ret;
+
+	ret = timer_of_init(np, &suspend_rtc_to);
+	if (ret)
+		return ret;
+
+	return clocksource_register_hz(&suspend_rtc_clocksource, 1000);
+}
+TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
deleted file mode 100644
index 1e7ece279730..000000000000
--- a/drivers/clocksource/timer-tegra20.c
+++ /dev/null
@@ -1,379 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- */
-
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/cpu.h>
-#include <linux/cpumask.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/percpu.h>
-#include <linux/sched_clock.h>
-#include <linux/time.h>
-
-#include "timer-of.h"
-
-#ifdef CONFIG_ARM
-#include <asm/mach/time.h>
-#endif
-
-#define RTC_SECONDS            0x08
-#define RTC_SHADOW_SECONDS     0x0c
-#define RTC_MILLISECONDS       0x10
-
-#define TIMERUS_CNTR_1US 0x10
-#define TIMERUS_USEC_CFG 0x14
-#define TIMERUS_CNTR_FREEZE 0x4c
-
-#define TIMER_PTV		0x0
-#define TIMER_PTV_EN		BIT(31)
-#define TIMER_PTV_PER		BIT(30)
-#define TIMER_PCR		0x4
-#define TIMER_PCR_INTR_CLR	BIT(30)
-
-#ifdef CONFIG_ARM
-#define TIMER_CPU0		0x50 /* TIMER3 */
-#else
-#define TIMER_CPU0		0x90 /* TIMER10 */
-#define TIMER10_IRQ_IDX		10
-#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
-#endif
-#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
-
-static u32 usec_config;
-static void __iomem *timer_reg_base;
-#ifdef CONFIG_ARM
-static struct delay_timer tegra_delay_timer;
-#endif
-
-static int tegra_timer_set_next_event(unsigned long cycles,
-					 struct clock_event_device *evt)
-{
-	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
-
-	writel(TIMER_PTV_EN |
-	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
-	       reg_base + TIMER_PTV);
-
-	return 0;
-}
-
-static int tegra_timer_shutdown(struct clock_event_device *evt)
-{
-	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
-
-	writel(0, reg_base + TIMER_PTV);
-
-	return 0;
-}
-
-static int tegra_timer_set_periodic(struct clock_event_device *evt)
-{
-	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
-
-	writel(TIMER_PTV_EN | TIMER_PTV_PER |
-	       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
-	       reg_base + TIMER_PTV);
-
-	return 0;
-}
-
-static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
-	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
-
-	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static void tegra_timer_suspend(struct clock_event_device *evt)
-{
-	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
-
-	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
-}
-
-static void tegra_timer_resume(struct clock_event_device *evt)
-{
-	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
-}
-
-#ifdef CONFIG_ARM64
-static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
-	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
-
-	.clkevt = {
-		.name = "tegra_timer",
-		.rating = 460,
-		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-		.set_next_event = tegra_timer_set_next_event,
-		.set_state_shutdown = tegra_timer_shutdown,
-		.set_state_periodic = tegra_timer_set_periodic,
-		.set_state_oneshot = tegra_timer_shutdown,
-		.tick_resume = tegra_timer_shutdown,
-		.suspend = tegra_timer_suspend,
-		.resume = tegra_timer_resume,
-	},
-};
-
-static int tegra_timer_setup(unsigned int cpu)
-{
-	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
-
-	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
-	enable_irq(to->clkevt.irq);
-
-	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
-					1, /* min */
-					0x1fffffff); /* 29 bits */
-
-	return 0;
-}
-
-static int tegra_timer_stop(unsigned int cpu)
-{
-	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
-
-	to->clkevt.set_state_shutdown(&to->clkevt);
-	disable_irq_nosync(to->clkevt.irq);
-
-	return 0;
-}
-#else /* CONFIG_ARM */
-static struct timer_of tegra_to = {
-	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE | TIMER_OF_IRQ,
-
-	.clkevt = {
-		.name = "tegra_timer",
-		.rating	= 300,
-		.features = CLOCK_EVT_FEAT_ONESHOT |
-			    CLOCK_EVT_FEAT_PERIODIC |
-			    CLOCK_EVT_FEAT_DYNIRQ,
-		.set_next_event	= tegra_timer_set_next_event,
-		.set_state_shutdown = tegra_timer_shutdown,
-		.set_state_periodic = tegra_timer_set_periodic,
-		.set_state_oneshot = tegra_timer_shutdown,
-		.tick_resume = tegra_timer_shutdown,
-		.suspend = tegra_timer_suspend,
-		.resume = tegra_timer_resume,
-		.cpumask = cpu_possible_mask,
-	},
-
-	.of_irq = {
-		.index = 2,
-		.flags = IRQF_TIMER | IRQF_TRIGGER_HIGH,
-		.handler = tegra_timer_isr,
-	},
-};
-
-static u64 notrace tegra_read_sched_clock(void)
-{
-	return readl(timer_reg_base + TIMERUS_CNTR_1US);
-}
-
-static unsigned long tegra_delay_timer_read_counter_long(void)
-{
-	return readl(timer_reg_base + TIMERUS_CNTR_1US);
-}
-
-static struct timer_of suspend_rtc_to = {
-	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK,
-};
-
-/*
- * tegra_rtc_read - Reads the Tegra RTC registers
- * Care must be taken that this funciton is not called while the
- * tegra_rtc driver could be executing to avoid race conditions
- * on the RTC shadow register
- */
-static u64 tegra_rtc_read_ms(struct clocksource *cs)
-{
-	u32 ms = readl(timer_of_base(&suspend_rtc_to) + RTC_MILLISECONDS);
-	u32 s = readl(timer_of_base(&suspend_rtc_to) + RTC_SHADOW_SECONDS);
-	return (u64)s * MSEC_PER_SEC + ms;
-}
-
-static struct clocksource suspend_rtc_clocksource = {
-	.name	= "tegra_suspend_timer",
-	.rating	= 200,
-	.read	= tegra_rtc_read_ms,
-	.mask	= CLOCKSOURCE_MASK(32),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
-};
-#endif
-
-static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
-{
-	int ret = 0;
-
-	ret = timer_of_init(np, to);
-	if (ret < 0)
-		goto out;
-
-	timer_reg_base = timer_of_base(to);
-
-	/*
-	 * Configure microsecond timers to have 1MHz clock
-	 * Config register is 0xqqww, where qq is "dividend", ww is "divisor"
-	 * Uses n+1 scheme
-	 */
-	switch (timer_of_rate(to)) {
-	case 12000000:
-		usec_config = 0x000b; /* (11+1)/(0+1) */
-		break;
-	case 12800000:
-		usec_config = 0x043f; /* (63+1)/(4+1) */
-		break;
-	case 13000000:
-		usec_config = 0x000c; /* (12+1)/(0+1) */
-		break;
-	case 16800000:
-		usec_config = 0x0453; /* (83+1)/(4+1) */
-		break;
-	case 19200000:
-		usec_config = 0x045f; /* (95+1)/(4+1) */
-		break;
-	case 26000000:
-		usec_config = 0x0019; /* (25+1)/(0+1) */
-		break;
-	case 38400000:
-		usec_config = 0x04bf; /* (191+1)/(4+1) */
-		break;
-	case 48000000:
-		usec_config = 0x002f; /* (47+1)/(0+1) */
-		break;
-	default:
-		ret = -EINVAL;
-		goto out;
-	}
-
-	writel(usec_config, timer_of_base(to) + TIMERUS_USEC_CFG);
-
-out:
-	return ret;
-}
-
-#ifdef CONFIG_ARM64
-static int __init tegra_init_timer(struct device_node *np)
-{
-	int cpu, ret = 0;
-	struct timer_of *to;
-
-	to = this_cpu_ptr(&tegra_to);
-	ret = tegra_timer_common_init(np, to);
-	if (ret < 0)
-		goto out;
-
-	for_each_possible_cpu(cpu) {
-		struct timer_of *cpu_to;
-
-		cpu_to = per_cpu_ptr(&tegra_to, cpu);
-		cpu_to->of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(cpu);
-		cpu_to->of_clk.rate = timer_of_rate(to);
-		cpu_to->clkevt.cpumask = cpumask_of(cpu);
-		cpu_to->clkevt.irq =
-			irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
-		if (!cpu_to->clkevt.irq) {
-			pr_err("%s: can't map IRQ for CPU%d\n",
-			       __func__, cpu);
-			ret = -EINVAL;
-			goto out;
-		}
-
-		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
-		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr,
-				  IRQF_TIMER | IRQF_NOBALANCING,
-				  cpu_to->clkevt.name, &cpu_to->clkevt);
-		if (ret) {
-			pr_err("%s: cannot setup irq %d for CPU%d\n",
-				__func__, cpu_to->clkevt.irq, cpu);
-			ret = -EINVAL;
-			goto out_irq;
-		}
-	}
-
-	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
-			  "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
-			  tegra_timer_stop);
-
-	return ret;
-out_irq:
-	for_each_possible_cpu(cpu) {
-		struct timer_of *cpu_to;
-
-		cpu_to = per_cpu_ptr(&tegra_to, cpu);
-		if (cpu_to->clkevt.irq) {
-			free_irq(cpu_to->clkevt.irq, &cpu_to->clkevt);
-			irq_dispose_mapping(cpu_to->clkevt.irq);
-		}
-	}
-out:
-	timer_of_cleanup(to);
-	return ret;
-}
-#else /* CONFIG_ARM */
-static int __init tegra_init_timer(struct device_node *np)
-{
-	int ret = 0;
-
-	ret = tegra_timer_common_init(np, &tegra_to);
-	if (ret < 0)
-		goto out;
-
-	tegra_to.of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(0);
-	tegra_to.of_clk.rate = 1000000; /* microsecond timer */
-
-	sched_clock_register(tegra_read_sched_clock, 32,
-			     timer_of_rate(&tegra_to));
-	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
-				    "timer_us", timer_of_rate(&tegra_to),
-				    300, 32, clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("Failed to register clocksource\n");
-		goto out;
-	}
-
-	tegra_delay_timer.read_current_timer =
-			tegra_delay_timer_read_counter_long;
-	tegra_delay_timer.freq = timer_of_rate(&tegra_to);
-	register_current_timer_delay(&tegra_delay_timer);
-
-	clockevents_config_and_register(&tegra_to.clkevt,
-					timer_of_rate(&tegra_to),
-					0x1,
-					0x1fffffff);
-
-	return ret;
-out:
-	timer_of_cleanup(&tegra_to);
-
-	return ret;
-}
-
-static int __init tegra20_init_rtc(struct device_node *np)
-{
-	int ret;
-
-	ret = timer_of_init(np, &suspend_rtc_to);
-	if (ret)
-		return ret;
-
-	clocksource_register_hz(&suspend_rtc_clocksource, 1000);
-
-	return 0;
-}
-TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-#endif
-TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra_init_timer);
-TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra_init_timer);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 083bd8114db1..dd6b4b0b5f30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -837,7 +837,7 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 
 	/* No access to rdtsc. Using raw monotonic time */
 	args->cpu_clock_counter = ktime_get_raw_ns();
-	args->system_clock_counter = ktime_get_boot_ns();
+	args->system_clock_counter = ktime_get_boottime_ns();
 
 	/* Since the counter is in nano-seconds we use 1GHz frequency */
 	args->system_clock_freq = 1000000000;
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 1c1a2514d6f3..c423e57ae888 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -10,6 +10,9 @@ config HYPERV
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
 
+config HYPERV_TIMER
+	def_bool HYPERV
+
 config HYPERV_TSCPAGE
        def_bool HYPERV && X86_64
 
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index a1ea482183e8..6188fb7dda42 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -16,27 +16,13 @@
 #include <linux/version.h>
 #include <linux/random.h>
 #include <linux/clockchips.h>
+#include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
 
 /* The one and only */
 struct hv_context hv_context;
 
-/*
- * If false, we're using the old mechanism for stimer0 interrupts
- * where it sends a VMbus message when it expires. The old
- * mechanism is used when running on older versions of Hyper-V
- * that don't support Direct Mode. While Hyper-V provides
- * four stimer's per CPU, Linux uses only stimer0.
- */
-static bool direct_mode_enabled;
-static int stimer0_irq;
-static int stimer0_vector;
-
-#define HV_TIMER_FREQUENCY (10 * 1000 * 1000) /* 100ns period */
-#define HV_MAX_MAX_DELTA_TICKS 0xffffffff
-#define HV_MIN_DELTA_TICKS 1
-
 /*
  * hv_init - Main initialization routine.
  *
@@ -47,9 +33,6 @@ int hv_init(void)
 	hv_context.cpu_context = alloc_percpu(struct hv_per_cpu_context);
 	if (!hv_context.cpu_context)
 		return -ENOMEM;
-
-	direct_mode_enabled = ms_hyperv.misc_features &
-			HV_STIMER_DIRECT_MODE_AVAILABLE;
 	return 0;
 }
 
@@ -88,89 +71,6 @@ int hv_post_message(union hv_connection_id connection_id,
 	return status & 0xFFFF;
 }
 
-/*
- * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
- * does not use VMbus or any VMbus messages, so process here and not
- * in the VMbus driver code.
- */
-
-static void hv_stimer0_isr(void)
-{
-	struct hv_per_cpu_context *hv_cpu;
-
-	hv_cpu = this_cpu_ptr(hv_context.cpu_context);
-	hv_cpu->clk_evt->event_handler(hv_cpu->clk_evt);
-	add_interrupt_randomness(stimer0_vector, 0);
-}
-
-static int hv_ce_set_next_event(unsigned long delta,
-				struct clock_event_device *evt)
-{
-	u64 current_tick;
-
-	WARN_ON(!clockevent_state_oneshot(evt));
-
-	current_tick = hyperv_cs->read(NULL);
-	current_tick += delta;
-	hv_init_timer(0, current_tick);
-	return 0;
-}
-
-static int hv_ce_shutdown(struct clock_event_device *evt)
-{
-	hv_init_timer(0, 0);
-	hv_init_timer_config(0, 0);
-	if (direct_mode_enabled)
-		hv_disable_stimer0_percpu_irq(stimer0_irq);
-
-	return 0;
-}
-
-static int hv_ce_set_oneshot(struct clock_event_device *evt)
-{
-	union hv_stimer_config timer_cfg;
-
-	timer_cfg.as_uint64 = 0;
-	timer_cfg.enable = 1;
-	timer_cfg.auto_enable = 1;
-	if (direct_mode_enabled) {
-		/*
-		 * When it expires, the timer will directly interrupt
-		 * on the specified hardware vector/IRQ.
-		 */
-		timer_cfg.direct_mode = 1;
-		timer_cfg.apic_vector = stimer0_vector;
-		hv_enable_stimer0_percpu_irq(stimer0_irq);
-	} else {
-		/*
-		 * When it expires, the timer will generate a VMbus message,
-		 * to be handled by the normal VMbus interrupt handler.
-		 */
-		timer_cfg.direct_mode = 0;
-		timer_cfg.sintx = VMBUS_MESSAGE_SINT;
-	}
-	hv_init_timer_config(0, timer_cfg.as_uint64);
-	return 0;
-}
-
-static void hv_init_clockevent_device(struct clock_event_device *dev, int cpu)
-{
-	dev->name = "Hyper-V clockevent";
-	dev->features = CLOCK_EVT_FEAT_ONESHOT;
-	dev->cpumask = cpumask_of(cpu);
-	dev->rating = 1000;
-	/*
-	 * Avoid settint dev->owner = THIS_MODULE deliberately as doing so will
-	 * result in clockevents_config_and_register() taking additional
-	 * references to the hv_vmbus module making it impossible to unload.
-	 */
-
-	dev->set_state_shutdown = hv_ce_shutdown;
-	dev->set_state_oneshot = hv_ce_set_oneshot;
-	dev->set_next_event = hv_ce_set_next_event;
-}
-
-
 int hv_synic_alloc(void)
 {
 	int cpu;
@@ -199,14 +99,6 @@ int hv_synic_alloc(void)
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
-		hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
-					  GFP_KERNEL);
-		if (hv_cpu->clk_evt == NULL) {
-			pr_err("Unable to allocate clock event device\n");
-			goto err;
-		}
-		hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
-
 		hv_cpu->synic_message_page =
 			(void *)get_zeroed_page(GFP_ATOMIC);
 		if (hv_cpu->synic_message_page == NULL) {
@@ -229,11 +121,6 @@ int hv_synic_alloc(void)
 		INIT_LIST_HEAD(&hv_cpu->chan_list);
 	}
 
-	if (direct_mode_enabled &&
-	    hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
-				hv_stimer0_isr))
-		goto err;
-
 	return 0;
 err:
 	/*
@@ -252,7 +139,6 @@ void hv_synic_free(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		kfree(hv_cpu->clk_evt);
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 		free_page((unsigned long)hv_cpu->post_msg_page);
@@ -311,36 +197,9 @@ int hv_synic_init(unsigned int cpu)
 
 	hv_set_synic_state(sctrl.as_uint64);
 
-	/*
-	 * Register the per-cpu clockevent source.
-	 */
-	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE)
-		clockevents_config_and_register(hv_cpu->clk_evt,
-						HV_TIMER_FREQUENCY,
-						HV_MIN_DELTA_TICKS,
-						HV_MAX_MAX_DELTA_TICKS);
-	return 0;
-}
-
-/*
- * hv_synic_clockevents_cleanup - Cleanup clockevent devices
- */
-void hv_synic_clockevents_cleanup(void)
-{
-	int cpu;
+	hv_stimer_init(cpu);
 
-	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
-		return;
-
-	if (direct_mode_enabled)
-		hv_remove_stimer0_irq(stimer0_irq);
-
-	for_each_present_cpu(cpu) {
-		struct hv_per_cpu_context *hv_cpu
-			= per_cpu_ptr(hv_context.cpu_context, cpu);
-
-		clockevents_unbind_device(hv_cpu->clk_evt, cpu);
-	}
+	return 0;
 }
 
 /*
@@ -388,14 +247,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	if (channel_found && vmbus_connection.conn_state == CONNECTED)
 		return -EBUSY;
 
-	/* Turn off clockevent device */
-	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
-		struct hv_per_cpu_context *hv_cpu
-			= this_cpu_ptr(hv_context.cpu_context);
-
-		clockevents_unbind_device(hv_cpu->clk_evt, cpu);
-		hv_ce_shutdown(hv_cpu->clk_evt);
-	}
+	hv_stimer_cleanup(cpu);
 
 	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 7d3d31f099ea..e32681ee7b9f 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -17,6 +17,7 @@
 #include <linux/hyperv.h>
 #include <linux/clockchips.h>
 #include <linux/ptp_clock_kernel.h>
+#include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index b8e1ff05f110..362e70e9d145 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -138,7 +138,6 @@ struct hv_per_cpu_context {
 	 * per-cpu list of the channels based on their CPU affinity.
 	 */
 	struct list_head chan_list;
-	struct clock_event_device *clk_evt;
 };
 
 struct hv_context {
@@ -176,8 +175,6 @@ extern int hv_synic_init(unsigned int cpu);
 
 extern int hv_synic_cleanup(unsigned int cpu);
 
-extern void hv_synic_clockevents_cleanup(void);
-
 /* Interface */
 
 void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 92b1874b3eb3..72d5a7cde7ea 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -30,6 +30,7 @@
 #include <linux/kdebug.h>
 #include <linux/efi.h>
 #include <linux/random.h>
+#include <clocksource/hyperv_timer.h>
 #include "hyperv_vmbus.h"
 
 struct vmbus_dynid {
@@ -955,17 +956,6 @@ static void vmbus_onmessage_work(struct work_struct *work)
 	kfree(ctx);
 }
 
-static void hv_process_timer_expiration(struct hv_message *msg,
-					struct hv_per_cpu_context *hv_cpu)
-{
-	struct clock_event_device *dev = hv_cpu->clk_evt;
-
-	if (dev->event_handler)
-		dev->event_handler(dev);
-
-	vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
-}
-
 void vmbus_on_msg_dpc(unsigned long data)
 {
 	struct hv_per_cpu_context *hv_cpu = (void *)data;
@@ -1159,9 +1149,10 @@ static void vmbus_isr(void)
 
 	/* Check if there are actual msgs to be processed */
 	if (msg->header.message_type != HVMSG_NONE) {
-		if (msg->header.message_type == HVMSG_TIMER_EXPIRED)
-			hv_process_timer_expiration(msg, hv_cpu);
-		else
+		if (msg->header.message_type == HVMSG_TIMER_EXPIRED) {
+			hv_stimer0_isr();
+			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
+		} else
 			tasklet_schedule(&hv_cpu->msg_dpc);
 	}
 
@@ -1263,14 +1254,19 @@ static int vmbus_bus_init(void)
 	ret = hv_synic_alloc();
 	if (ret)
 		goto err_alloc;
+
+	ret = hv_stimer_alloc(VMBUS_MESSAGE_SINT);
+	if (ret < 0)
+		goto err_alloc;
+
 	/*
-	 * Initialize the per-cpu interrupt state and
-	 * connect to the host.
+	 * Initialize the per-cpu interrupt state and stimer state.
+	 * Then connect to the host.
 	 */
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
 				hv_synic_init, hv_synic_cleanup);
 	if (ret < 0)
-		goto err_alloc;
+		goto err_cpuhp;
 	hyperv_cpuhp_online = ret;
 
 	ret = vmbus_connect();
@@ -1318,6 +1314,8 @@ static int vmbus_bus_init(void)
 
 err_connect:
 	cpuhp_remove_state(hyperv_cpuhp_online);
+err_cpuhp:
+	hv_stimer_free();
 err_alloc:
 	hv_synic_free();
 	hv_remove_vmbus_irq();
@@ -2064,7 +2062,7 @@ static struct acpi_driver vmbus_acpi_driver = {
 
 static void hv_kexec_handler(void)
 {
-	hv_synic_clockevents_cleanup();
+	hv_stimer_global_cleanup();
 	vmbus_initiate_unload(false);
 	vmbus_connection.conn_state = DISCONNECTED;
 	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
@@ -2075,6 +2073,8 @@ static void hv_kexec_handler(void)
 
 static void hv_crash_handler(struct pt_regs *regs)
 {
+	int cpu;
+
 	vmbus_initiate_unload(true);
 	/*
 	 * In crash handler we can't schedule synic cleanup for all CPUs,
@@ -2082,7 +2082,9 @@ static void hv_crash_handler(struct pt_regs *regs)
 	 * for kdump.
 	 */
 	vmbus_connection.conn_state = DISCONNECTED;
-	hv_synic_cleanup(smp_processor_id());
+	cpu = smp_processor_id();
+	hv_stimer_cleanup(cpu);
+	hv_synic_cleanup(cpu);
 	hyperv_cleanup();
 };
 
@@ -2131,7 +2133,7 @@ static void __exit vmbus_exit(void)
 	hv_remove_kexec_handler();
 	hv_remove_crash_handler();
 	vmbus_connection.conn_state = DISCONNECTED;
-	hv_synic_clockevents_cleanup();
+	hv_stimer_global_cleanup();
 	vmbus_disconnect();
 	hv_remove_vmbus_irq();
 	for_each_online_cpu(cpu) {
diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index c8159205c77d..4e22b3c3e488 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -149,7 +149,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
 		return -EIO;
 	}
 
-	dht11->timestamp = ktime_get_boot_ns();
+	dht11->timestamp = ktime_get_boottime_ns();
 	if (hum_int < 4) {  /* DHT22: 100000 = (3*256+232)*100 */
 		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
 					((temp_int & 0x80) ? -100 : 100);
@@ -177,7 +177,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
 
 	/* TODO: Consider making the handler safe for IRQ sharing */
 	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
-		dht11->edges[dht11->num_edges].ts = ktime_get_boot_ns();
+		dht11->edges[dht11->num_edges].ts = ktime_get_boottime_ns();
 		dht11->edges[dht11->num_edges++].value =
 						gpio_get_value(dht11->gpio);
 
@@ -196,7 +196,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 	int ret, timeres, offset;
 
 	mutex_lock(&dht11->lock);
-	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_boot_ns()) {
+	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_boottime_ns()) {
 		timeres = ktime_get_resolution_ns();
 		dev_dbg(dht11->dev, "current timeresolution: %dns\n", timeres);
 		if (timeres > DHT11_MIN_TIMERES) {
@@ -322,7 +322,7 @@ static int dht11_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	dht11->timestamp = ktime_get_boot_ns() - DHT11_DATA_VALID_TIME - 1;
+	dht11->timestamp = ktime_get_boottime_ns() - DHT11_DATA_VALID_TIME - 1;
 	dht11->num_edges = -1;
 
 	platform_set_drvdata(pdev, iio);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 245b5844028d..401d7ff99853 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -228,9 +228,9 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 		ktime_get_coarse_ts64(&tp);
 		return timespec64_to_ns(&tp);
 	case CLOCK_BOOTTIME:
-		return ktime_get_boot_ns();
+		return ktime_get_boottime_ns();
 	case CLOCK_TAI:
-		return ktime_get_tai_ns();
+		return ktime_get_clocktai_ns();
 	default:
 		BUG();
 	}
diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 2a0b59a4b6eb..cca414ecfcd5 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -310,7 +310,7 @@ static void aliasguid_query_handler(int status,
 	if (status) {
 		pr_debug("(port: %d) failed: status = %d\n",
 			 cb_ctx->port, status);
-		rec->time_to_run = ktime_get_boot_ns() + 1 * NSEC_PER_SEC;
+		rec->time_to_run = ktime_get_boottime_ns() + 1 * NSEC_PER_SEC;
 		goto out;
 	}
 
@@ -416,7 +416,7 @@ static void aliasguid_query_handler(int status,
 			 be64_to_cpu((__force __be64)rec->guid_indexes),
 			 be64_to_cpu((__force __be64)applied_guid_indexes),
 			 be64_to_cpu((__force __be64)declined_guid_indexes));
-		rec->time_to_run = ktime_get_boot_ns() +
+		rec->time_to_run = ktime_get_boottime_ns() +
 			resched_delay_sec * NSEC_PER_SEC;
 	} else {
 		rec->status = MLX4_GUID_INFO_STATUS_SET;
@@ -709,7 +709,7 @@ static int get_low_record_time_index(struct mlx4_ib_dev *dev, u8 port,
 		}
 	}
 	if (resched_delay_sec) {
-		u64 curr_time = ktime_get_boot_ns();
+		u64 curr_time = ktime_get_boottime_ns();
 
 		*resched_delay_sec = (low_record_time < curr_time) ? 0 :
 			div_u64((low_record_time - curr_time), NSEC_PER_SEC);
diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index 4c8b0c3cf284..6a72b7e13719 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -70,7 +70,7 @@ static void led_activity_function(struct timer_list *t)
 	 * down to 16us, ensuring we won't overflow 32-bit computations below
 	 * even up to 3k CPUs, while keeping divides cheap on smaller systems.
 	 */
-	curr_boot = ktime_get_boot_ns() * cpus;
+	curr_boot = ktime_get_boottime_ns() * cpus;
 	diff_boot = (curr_boot - activity_data->last_boot) >> 16;
 	diff_used = (curr_used - activity_data->last_used) >> 16;
 	activity_data->last_boot = curr_boot;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index fec38a47696e..9f4b117db9d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -93,7 +93,7 @@ void iwl_mvm_ftm_restart(struct iwl_mvm *mvm)
 	struct cfg80211_pmsr_result result = {
 		.status = NL80211_PMSR_STATUS_FAILURE,
 		.final = 1,
-		.host_time = ktime_get_boot_ns(),
+		.host_time = ktime_get_boottime_ns(),
 		.type = NL80211_PMSR_TYPE_FTM,
 	};
 	int i;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index fbd3014e8b82..160b0db27103 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -555,7 +555,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	if (unlikely(ieee80211_is_beacon(hdr->frame_control) ||
 		     ieee80211_is_probe_resp(hdr->frame_control)))
-		rx_status->boottime_ns = ktime_get_boot_ns();
+		rx_status->boottime_ns = ktime_get_boottime_ns();
 
 	/* Take a reference briefly to kick off a d0i3 entry delay so
 	 * we can handle bursts of RX packets without toggling the
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 1824566d08fc..64f950501287 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1684,7 +1684,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 		if (unlikely(ieee80211_is_beacon(hdr->frame_control) ||
 			     ieee80211_is_probe_resp(hdr->frame_control)))
-			rx_status->boottime_ns = ktime_get_boot_ns();
+			rx_status->boottime_ns = ktime_get_boottime_ns();
 	}
 
 	if (iwl_mvm_create_skb(mvm, skb, hdr, len, crypt_len, rxb)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index cc56ab88fb43..72cd5b3f2d8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1445,7 +1445,7 @@ void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, u32 *gp2, u64 *boottime)
 	}
 
 	*gp2 = iwl_mvm_get_systime(mvm);
-	*boottime = ktime_get_boot_ns();
+	*boottime = ktime_get_boottime_ns();
 
 	if (!ps_disabled) {
 		mvm->ps_disabled = ps_disabled;
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 1c699a9fa866..a7bf6519d7aa 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1271,7 +1271,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	 */
 	if (ieee80211_is_beacon(hdr->frame_control) ||
 	    ieee80211_is_probe_resp(hdr->frame_control)) {
-		rx_status.boottime_ns = ktime_get_boot_ns();
+		rx_status.boottime_ns = ktime_get_boottime_ns();
 		now = data->abs_bcn_ts;
 	} else {
 		now = mac80211_hwsim_get_tsf_raw();
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index c9a485ecee7b..b74dc8bc9755 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -483,7 +483,7 @@ static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
 	}
 
 	/* update the host-chipset time offset */
-	wl->time_offset = (ktime_get_boot_ns() >> 10) -
+	wl->time_offset = (ktime_get_boottime_ns() >> 10) -
 		(s64)(status->fw_localtime);
 
 	wl->fw_fast_lnk_map = status->link_fast_bitmap;
diff --git a/drivers/net/wireless/ti/wlcore/rx.c b/drivers/net/wireless/ti/wlcore/rx.c
index d96bb602fae6..307fab21050b 100644
--- a/drivers/net/wireless/ti/wlcore/rx.c
+++ b/drivers/net/wireless/ti/wlcore/rx.c
@@ -93,7 +93,7 @@ static void wl1271_rx_status(struct wl1271 *wl,
 	}
 
 	if (beacon || probe_rsp)
-		status->boottime_ns = ktime_get_boot_ns();
+		status->boottime_ns = ktime_get_boottime_ns();
 
 	if (beacon)
 		wlcore_set_pending_regdomain_ch(wl, (u16)desc->channel,
diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index 057c6be330e7..90e56d4c3df3 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -273,7 +273,7 @@ static void wl1271_tx_fill_hdr(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 	}
 
 	/* configure packet life time */
-	hosttime = (ktime_get_boot_ns() >> 10);
+	hosttime = (ktime_get_boottime_ns() >> 10);
 	desc->start_time = cpu_to_le32(hosttime - wl->time_offset);
 
 	is_dummy = wl12xx_is_dummy_packet(wl, skb);
diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index 606999f102eb..be92e1220284 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -172,7 +172,7 @@ static void virt_wifi_scan_result(struct work_struct *work)
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
 					   CFG80211_BSS_FTYPE_PRESP,
 					   fake_router_bssid,
-					   ktime_get_boot_ns(),
+					   ktime_get_boottime_ns(),
 					   WLAN_CAPABILITY_ESS, 0,
 					   (void *)&ssid, sizeof(ssid),
 					   DBM_TO_MBM(-50), GFP_KERNEL);
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
new file mode 100644
index 000000000000..e94b19782c92
--- /dev/null
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_VSYSCALL_H
+#define __ASM_GENERIC_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#ifndef __arch_get_k_vdso_data
+static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
+{
+	return NULL;
+}
+#endif /* __arch_get_k_vdso_data */
+
+#ifndef __arch_update_vdso_data
+static __always_inline int __arch_update_vdso_data(void)
+{
+	return 0;
+}
+#endif /* __arch_update_vdso_data */
+
+#ifndef __arch_get_clock_mode
+static __always_inline int __arch_get_clock_mode(struct timekeeper *tk)
+{
+	return 0;
+}
+#endif /* __arch_get_clock_mode */
+
+#ifndef __arch_use_vsyscall
+static __always_inline int __arch_use_vsyscall(struct vdso_data *vdata)
+{
+	return 1;
+}
+#endif /* __arch_use_vsyscall */
+
+#ifndef __arch_update_vsyscall
+static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata,
+						   struct timekeeper *tk)
+{
+}
+#endif /* __arch_update_vsyscall */
+
+#ifndef __arch_sync_vdso_data
+static __always_inline void __arch_sync_vdso_data(struct vdso_data *vdata)
+{
+}
+#endif /* __arch_sync_vdso_data */
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_GENERIC_VSYSCALL_H */
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
new file mode 100644
index 000000000000..a821deb8ecb2
--- /dev/null
+++ b/include/clocksource/hyperv_timer.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Definitions for the clocksource provided by the Hyper-V
+ * hypervisor to guest VMs, as described in the Hyper-V Top
+ * Level Functional Spec (TLFS).
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author:  Michael Kelley <mikelley@microsoft.com>
+ */
+
+#ifndef __CLKSOURCE_HYPERV_TIMER_H
+#define __CLKSOURCE_HYPERV_TIMER_H
+
+#include <linux/clocksource.h>
+#include <linux/math64.h>
+#include <asm/mshyperv.h>
+
+#define HV_MAX_MAX_DELTA_TICKS 0xffffffff
+#define HV_MIN_DELTA_TICKS 1
+
+/* Routines called by the VMbus driver */
+extern int hv_stimer_alloc(int sint);
+extern void hv_stimer_free(void);
+extern void hv_stimer_init(unsigned int cpu);
+extern void hv_stimer_cleanup(unsigned int cpu);
+extern void hv_stimer_global_cleanup(void);
+extern void hv_stimer0_isr(void);
+
+#if IS_ENABLED(CONFIG_HYPERV)
+extern struct clocksource *hyperv_cs;
+extern void hv_init_clocksource(void);
+#endif /* CONFIG_HYPERV */
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
+
+static inline notrace u64
+hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
+{
+	u64 scale, offset;
+	u32 sequence;
+
+	/*
+	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
+	 * Top-Level Functional Specification ver. 3.0 and above. To get the
+	 * reference time we must do the following:
+	 * - READ ReferenceTscSequence
+	 *   A special '0' value indicates the time source is unreliable and we
+	 *   need to use something else. The currently published specification
+	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
+	 *   instead of '0' as the special value, see commit c35b82ef0294.
+	 * - ReferenceTime =
+	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
+	 * - READ ReferenceTscSequence again. In case its value has changed
+	 *   since our first reading we need to discard ReferenceTime and repeat
+	 *   the whole sequence as the hypervisor was updating the page in
+	 *   between.
+	 */
+	do {
+		sequence = READ_ONCE(tsc_pg->tsc_sequence);
+		if (!sequence)
+			return U64_MAX;
+		/*
+		 * Make sure we read sequence before we read other values from
+		 * TSC page.
+		 */
+		smp_rmb();
+
+		scale = READ_ONCE(tsc_pg->tsc_scale);
+		offset = READ_ONCE(tsc_pg->tsc_offset);
+		*cur_tsc = hv_get_raw_timer();
+
+		/*
+		 * Make sure we read sequence after we read all other values
+		 * from TSC page.
+		 */
+		smp_rmb();
+
+	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
+
+	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
+}
+
+static inline notrace u64
+hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
+{
+	u64 cur_tsc;
+
+	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
+}
+
+#else /* CONFIG_HYPERV_TSC_PAGE */
+static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return NULL;
+}
+
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
+				       u64 *cur_tsc)
+{
+	return U64_MAX;
+}
+#endif /* CONFIG_HYPERV_TSCPAGE */
+
+#endif
diff --git a/include/clocksource/timer-davinci.h b/include/clocksource/timer-davinci.h
new file mode 100644
index 000000000000..1dcc1333fbc8
--- /dev/null
+++ b/include/clocksource/timer-davinci.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * TI DaVinci clocksource driver
+ *
+ * Copyright (C) 2019 Texas Instruments
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ */
+
+#ifndef __TIMER_DAVINCI_H__
+#define __TIMER_DAVINCI_H__
+
+#include <linux/clk.h>
+#include <linux/ioport.h>
+
+enum {
+	DAVINCI_TIMER_CLOCKEVENT_IRQ,
+	DAVINCI_TIMER_CLOCKSOURCE_IRQ,
+	DAVINCI_TIMER_NUM_IRQS,
+};
+
+/**
+ * struct davinci_timer_cfg - davinci clocksource driver configuration struct
+ * @reg:        register range resource
+ * @irq:        clockevent and clocksource interrupt resources
+ * @cmp_off:    if set - it specifies the compare register used for clockevent
+ *
+ * Note: if the compare register is specified, the driver will use the bottom
+ * clock half for both clocksource and clockevent and the compare register
+ * to generate event irqs. The user must supply the correct compare register
+ * interrupt number.
+ *
+ * This is only used by da830 the DSP of which uses the top half. The timer
+ * driver still configures the top half to run in free-run mode.
+ */
+struct davinci_timer_cfg {
+	struct resource reg;
+	struct resource irq[DAVINCI_TIMER_NUM_IRQS];
+	unsigned int cmp_off;
+};
+
+int __init davinci_timer_register(struct clk *clk,
+				  const struct davinci_timer_cfg *data);
+
+#endif /* __TIMER_DAVINCI_H__ */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 5c6062206760..87c211adf49e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -116,10 +116,10 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_ACPI_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
+	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_JCORE_TIMER_STARTING,
-	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_TEGRA_TIMER_STARTING,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2e8957eac4d4..4971100a8cab 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -12,8 +12,8 @@
 #ifndef _LINUX_HRTIMER_H
 #define _LINUX_HRTIMER_H
 
+#include <linux/hrtimer_defs.h>
 #include <linux/rbtree.h>
-#include <linux/ktime.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/percpu.h>
@@ -298,26 +298,12 @@ struct clock_event_device;
 
 extern void hrtimer_interrupt(struct clock_event_device *dev);
 
-/*
- * The resolution of the clocks. The resolution value is returned in
- * the clock_getres() system call to give application programmers an
- * idea of the (in)accuracy of timers. Timer values are rounded up to
- * this resolution values.
- */
-# define HIGH_RES_NSEC		1
-# define KTIME_HIGH_RES		(HIGH_RES_NSEC)
-# define MONOTONIC_RES_NSEC	HIGH_RES_NSEC
-# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
-
 extern void clock_was_set_delayed(void);
 
 extern unsigned int hrtimer_resolution;
 
 #else
 
-# define MONOTONIC_RES_NSEC	LOW_RES_NSEC
-# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
-
 #define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
 
 static inline void clock_was_set_delayed(void) { }
diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
new file mode 100644
index 000000000000..2d3e3c5fb946
--- /dev/null
+++ b/include/linux/hrtimer_defs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HRTIMER_DEFS_H
+#define _LINUX_HRTIMER_DEFS_H
+
+#include <linux/ktime.h>
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+
+/*
+ * The resolution of the clocks. The resolution value is returned in
+ * the clock_getres() system call to give application programmers an
+ * idea of the (in)accuracy of timers. Timer values are rounded up to
+ * this resolution values.
+ */
+# define HIGH_RES_NSEC		1
+# define KTIME_HIGH_RES		(HIGH_RES_NSEC)
+# define MONOTONIC_RES_NSEC	HIGH_RES_NSEC
+# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
+
+#else
+
+# define MONOTONIC_RES_NSEC	LOW_RES_NSEC
+# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
+
+#endif
+
+#endif
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index a8ab0f143ac4..b27e2ffa96c1 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -113,6 +113,34 @@ static inline ktime_t ktime_get_coarse_clocktai(void)
 	return ktime_get_coarse_with_offset(TK_OFFS_TAI);
 }
 
+static inline ktime_t ktime_get_coarse(void)
+{
+	struct timespec64 ts;
+
+	ktime_get_coarse_ts64(&ts);
+	return timespec64_to_ktime(ts);
+}
+
+static inline u64 ktime_get_coarse_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse());
+}
+
+static inline u64 ktime_get_coarse_real_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse_real());
+}
+
+static inline u64 ktime_get_coarse_boottime_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse_boottime());
+}
+
+static inline u64 ktime_get_coarse_clocktai_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse_clocktai());
+}
+
 /**
  * ktime_mono_to_real - Convert monotonic time to clock realtime
  */
@@ -131,12 +159,12 @@ static inline u64 ktime_get_real_ns(void)
 	return ktime_to_ns(ktime_get_real());
 }
 
-static inline u64 ktime_get_boot_ns(void)
+static inline u64 ktime_get_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_boottime());
 }
 
-static inline u64 ktime_get_tai_ns(void)
+static inline u64 ktime_get_clocktai_ns(void)
 {
 	return ktime_to_ns(ktime_get_clocktai());
 }
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 7b066fd38248..282e4f2a532a 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -36,19 +36,30 @@ struct timer_list {
 #define __TIMER_LOCKDEP_MAP_INITIALIZER(_kn)
 #endif
 
-/*
- * A deferrable timer will work normally when the system is busy, but
- * will not cause a CPU to come out of idle just to service it; instead,
- * the timer will be serviced when the CPU eventually wakes up with a
- * subsequent non-deferrable timer.
+/**
+ * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
+ * system is busy, but will not cause a CPU to come out of idle just
+ * to service it; instead, the timer will be serviced when the CPU
+ * eventually wakes up with a subsequent non-deferrable timer.
  *
- * An irqsafe timer is executed with IRQ disabled and it's safe to wait for
- * the completion of the running instance from IRQ handlers, for example,
- * by calling del_timer_sync().
+ * @TIMER_IRQSAFE: An irqsafe timer is executed with IRQ disabled and
+ * it's safe to wait for the completion of the running instance from
+ * IRQ handlers, for example, by calling del_timer_sync().
  *
  * Note: The irq disabled callback execution is a special case for
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
+ *
+ * @TIMER_PINNED: A pinned timer will not be affected by any timer
+ * placement heuristics (like, NOHZ) and will always expire on the CPU
+ * on which the timer was enqueued.
+ *
+ * Note: Because enqueuing of timers can migrate the timer from one
+ * CPU to another, pinned timers are not guaranteed to stay on the
+ * initialy selected CPU.  They move to the CPU on which the enqueue
+ * function is invoked via mod_timer() or add_timer().  If the timer
+ * should be placed on a particular CPU, then add_timer_on() has to be
+ * used.
  */
 #define TIMER_CPUMASK		0x0003FFFF
 #define TIMER_MIGRATING		0x00040000
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8fb5be3ca0ca..1fce25b1d87f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2007,7 +2007,7 @@ enum cfg80211_signal_type {
  *	received by the device (not just by the host, in case it was
  *	buffered on the device) and be accurate to about 10ms.
  *	If the frame isn't buffered, just passing the return value of
- *	ktime_get_boot_ns() is likely appropriate.
+ *	ktime_get_boottime_ns() is likely appropriate.
  * @parent_tsf: the time at the start of reception of the first octet of the
  *	timestamp field of the frame. The time is the TSF of the BSS specified
  *	by %parent_bssid.
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
new file mode 100644
index 000000000000..2e302c0f41f7
--- /dev/null
+++ b/include/vdso/datapage.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_DATAPAGE_H
+#define __VDSO_DATAPAGE_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/bits.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#define VDSO_BASES	(CLOCK_TAI + 1)
+#define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
+			 BIT(CLOCK_MONOTONIC)		| \
+			 BIT(CLOCK_BOOTTIME)		| \
+			 BIT(CLOCK_TAI))
+#define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
+			 BIT(CLOCK_MONOTONIC_COARSE))
+#define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
+
+#define CS_HRES_COARSE	0
+#define CS_RAW		1
+#define CS_BASES	(CS_RAW + 1)
+
+/**
+ * struct vdso_timestamp - basetime per clock_id
+ * @sec:	seconds
+ * @nsec:	nanoseconds
+ *
+ * There is one vdso_timestamp object in vvar for each vDSO-accelerated
+ * clock_id. For high-resolution clocks, this encodes the time
+ * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
+ * the actual time.
+ *
+ * To be noticed that for highres clocks nsec is left-shifted by
+ * vdso_data.cs[x].shift.
+ */
+struct vdso_timestamp {
+	u64	sec;
+	u64	nsec;
+};
+
+/**
+ * struct vdso_data - vdso datapage representation
+ * @seq:		timebase sequence counter
+ * @clock_mode:		clock mode
+ * @cycle_last:		timebase at clocksource init
+ * @mask:		clocksource mask
+ * @mult:		clocksource multiplier
+ * @shift:		clocksource shift
+ * @basetime[clock_id]:	basetime per clock_id
+ * @tz_minuteswest:	minutes west of Greenwich
+ * @tz_dsttime:		type of DST correction
+ * @hrtimer_res:	hrtimer resolution
+ * @__unused:		unused
+ *
+ * vdso_data will be accessed by 64 bit and compat code at the same time
+ * so we should be careful before modifying this structure.
+ */
+struct vdso_data {
+	u32			seq;
+
+	s32			clock_mode;
+	u64			cycle_last;
+	u64			mask;
+	u32			mult;
+	u32			shift;
+
+	struct vdso_timestamp	basetime[VDSO_BASES];
+
+	s32			tz_minuteswest;
+	s32			tz_dsttime;
+	u32			hrtimer_res;
+	u32			__unused;
+};
+
+/*
+ * We use the hidden visibility to prevent the compiler from generating a GOT
+ * relocation. Not only is going through a GOT useless (the entry couldn't and
+ * must not be overridden by another library), it does not even work: the linker
+ * cannot generate an absolute address to the data page.
+ *
+ * With the hidden visibility, the compiler simply generates a PC-relative
+ * relocation, and this is what we need.
+ */
+extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __VDSO_DATAPAGE_H */
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
new file mode 100644
index 000000000000..01641dbb68ef
--- /dev/null
+++ b/include/vdso/helpers.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_HELPERS_H
+#define __VDSO_HELPERS_H
+
+#ifndef __ASSEMBLY__
+
+#include <vdso/datapage.h>
+
+static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
+{
+	u32 seq;
+
+	while ((seq = READ_ONCE(vd->seq)) & 1)
+		cpu_relax();
+
+	smp_rmb();
+	return seq;
+}
+
+static __always_inline u32 vdso_read_retry(const struct vdso_data *vd,
+					   u32 start)
+{
+	u32 seq;
+
+	smp_rmb();
+	seq = READ_ONCE(vd->seq);
+	return seq != start;
+}
+
+static __always_inline void vdso_write_begin(struct vdso_data *vd)
+{
+	/*
+	 * WRITE_ONCE it is required otherwise the compiler can validly tear
+	 * updates to vd[x].seq and it is possible that the value seen by the
+	 * reader it is inconsistent.
+	 */
+	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
+	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
+	smp_wmb();
+}
+
+static __always_inline void vdso_write_end(struct vdso_data *vd)
+{
+	smp_wmb();
+	/*
+	 * WRITE_ONCE it is required otherwise the compiler can validly tear
+	 * updates to vd[x].seq and it is possible that the value seen by the
+	 * reader it is inconsistent.
+	 */
+	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
+	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __VDSO_HELPERS_H */
diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
new file mode 100644
index 000000000000..2c6134e0c23d
--- /dev/null
+++ b/include/vdso/vsyscall.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_VSYSCALL_H
+#define __VDSO_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __VDSO_VSYSCALL_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 42d17f730780..5b30f8baaf02 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1668,7 +1668,7 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (err < 0)
 		goto free_prog;
 
-	prog->aux->load_time = ktime_get_boot_ns();
+	prog->aux->load_time = ktime_get_boottime_ns();
 	err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name);
 	if (err)
 		goto free_prog;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..e2d014395fc6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10680,11 +10680,11 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 		break;
 
 	case CLOCK_BOOTTIME:
-		event->clock = &ktime_get_boot_ns;
+		event->clock = &ktime_get_boottime_ns;
 		break;
 
 	case CLOCK_TAI:
-		event->clock = &ktime_get_tai_ns;
+		event->clock = &ktime_get_clocktai_ns;
 		break;
 
 	default:
diff --git a/kernel/fork.c b/kernel/fork.c
index 75675b9bf6df..4722f1a320bf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2139,7 +2139,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 
 	p->start_time = ktime_get_ns();
-	p->real_start_time = ktime_get_boot_ns();
+	p->real_start_time = ktime_get_boottime_ns();
 
 	/*
 	 * Make it visible to the rest of the system, but dont wake it up yet.
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index f1e46f338a9c..1867044800bb 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -16,5 +16,6 @@ ifeq ($(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST),y)
 endif
 obj-$(CONFIG_GENERIC_SCHED_CLOCK)		+= sched_clock.o
 obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
+obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 0519a8805aab..57518efc3810 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -233,7 +233,6 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 /**
  * alarmtimer_suspend - Suspend time callback
  * @dev: unused
- * @state: unused
  *
  * When we are going into suspend, we look through the bases
  * to see which is the soonest timer to expire. We then
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3bcc19ceb073..fff5f64981c6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -105,12 +105,12 @@ static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
 
-static void inline clocksource_watchdog_lock(unsigned long *flags)
+static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
 	spin_lock_irqsave(&watchdog_lock, *flags);
 }
 
-static void inline clocksource_watchdog_unlock(unsigned long *flags)
+static inline void clocksource_watchdog_unlock(unsigned long *flags)
 {
 	spin_unlock_irqrestore(&watchdog_lock, *flags);
 }
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 41dfff23c1f9..5ee77f1a8a92 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -30,7 +30,6 @@
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
 #include <linux/tick.h>
-#include <linux/seq_file.h>
 #include <linux/err.h>
 #include <linux/debugobjects.h>
 #include <linux/sched/signal.h>
@@ -1115,9 +1114,10 @@ EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
  * @timer:	hrtimer to stop
  *
  * Returns:
- *  0 when the timer was not active
- *  1 when the timer was active
- * -1 when the timer is currently executing the callback function and
+ *
+ *  *  0 when the timer was not active
+ *  *  1 when the timer was active
+ *  * -1 when the timer is currently executing the callback function and
  *    cannot be stopped
  */
 int hrtimer_try_to_cancel(struct hrtimer *timer)
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 8de4f789dc1b..65eb796610dc 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -43,6 +43,7 @@ static u64			tick_length_base;
 #define MAX_TICKADJ		500LL		/* usecs */
 #define MAX_TICKADJ_SCALED \
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
+#define MAX_TAI_OFFSET		100000
 
 /*
  * phase-lock loop variables
@@ -691,7 +692,8 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_constant = max(time_constant, 0l);
 	}
 
-	if (txc->modes & ADJ_TAI && txc->constant >= 0)
+	if (txc->modes & ADJ_TAI &&
+			txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
 		*time_tai = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET)
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 29176635991f..d7f2d91acdac 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -980,23 +980,16 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
  */
 static void itimer_delete(struct k_itimer *timer)
 {
-	unsigned long flags;
-
 retry_delete:
-	spin_lock_irqsave(&timer->it_lock, flags);
+	spin_lock_irq(&timer->it_lock);
 
 	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		unlock_timer(timer, flags);
+		spin_unlock_irq(&timer->it_lock);
 		goto retry_delete;
 	}
 	list_del(&timer->list);
-	/*
-	 * This keeps any tasks waiting on the spin lock from thinking
-	 * they got something (see the lock code above).
-	 */
-	timer->it_signal = NULL;
 
-	unlock_timer(timer, flags);
+	spin_unlock_irq(&timer->it_lock);
 	release_posix_timer(timer, IT_ID_SET);
 }
 
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 7f7d6914ddd5..5c54ca632d08 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -251,6 +251,10 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 	if (tv) {
 		if (compat_get_timeval(&user_tv, tv))
 			return -EFAULT;
+
+		if (!timeval_valid(&user_tv))
+			return -EINVAL;
+
 		new_ts.tv_sec = user_tv.tv_sec;
 		new_ts.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
 	}
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 44b726bab4bd..d911c8470149 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -819,7 +819,7 @@ ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return base + nsecs;
+	return ktime_add_ns(base, nsecs);
 }
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 98ba50dcb1b2..acb326f5f50a 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -282,23 +282,6 @@ static inline void timer_list_header(struct seq_file *m, u64 now)
 	SEQ_printf(m, "\n");
 }
 
-static int timer_list_show(struct seq_file *m, void *v)
-{
-	struct timer_list_iter *iter = v;
-
-	if (iter->cpu == -1 && !iter->second_pass)
-		timer_list_header(m, iter->now);
-	else if (!iter->second_pass)
-		print_cpu(m, iter->cpu, iter->now);
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-	else if (iter->cpu == -1 && iter->second_pass)
-		timer_list_show_tickdevices_header(m);
-	else
-		print_tickdevice(m, tick_get_device(iter->cpu), iter->cpu);
-#endif
-	return 0;
-}
-
 void sysrq_timer_list_show(void)
 {
 	u64 now = ktime_to_ns(ktime_get());
@@ -317,6 +300,24 @@ void sysrq_timer_list_show(void)
 	return;
 }
 
+#ifdef CONFIG_PROC_FS
+static int timer_list_show(struct seq_file *m, void *v)
+{
+	struct timer_list_iter *iter = v;
+
+	if (iter->cpu == -1 && !iter->second_pass)
+		timer_list_header(m, iter->now);
+	else if (!iter->second_pass)
+		print_cpu(m, iter->cpu, iter->now);
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	else if (iter->cpu == -1 && iter->second_pass)
+		timer_list_show_tickdevices_header(m);
+	else
+		print_tickdevice(m, tick_get_device(iter->cpu), iter->cpu);
+#endif
+	return 0;
+}
+
 static void *move_iter(struct timer_list_iter *iter, loff_t offset)
 {
 	for (; offset; offset--) {
@@ -376,3 +377,4 @@ static int __init init_timer_list_procfs(void)
 	return 0;
 }
 __initcall(init_timer_list_procfs);
+#endif
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
new file mode 100644
index 000000000000..a80893180826
--- /dev/null
+++ b/kernel/time/vsyscall.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 ARM Ltd.
+ *
+ * Generic implementation of update_vsyscall and update_vsyscall_tz.
+ *
+ * Based on the x86 specific implementation.
+ */
+
+#include <linux/hrtimer.h>
+#include <linux/timekeeper_internal.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
+#include <vdso/vsyscall.h>
+
+static inline void update_vdso_data(struct vdso_data *vdata,
+				    struct timekeeper *tk)
+{
+	struct vdso_timestamp *vdso_ts;
+	u64 nsec;
+
+	vdata[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
+	vdata[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
+	vdata[CS_HRES_COARSE].mult		= tk->tkr_mono.mult;
+	vdata[CS_HRES_COARSE].shift		= tk->tkr_mono.shift;
+	vdata[CS_RAW].cycle_last		= tk->tkr_raw.cycle_last;
+	vdata[CS_RAW].mask			= tk->tkr_raw.mask;
+	vdata[CS_RAW].mult			= tk->tkr_raw.mult;
+	vdata[CS_RAW].shift			= tk->tkr_raw.shift;
+
+	/* CLOCK_REALTIME */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
+	vdso_ts->sec	= tk->xtime_sec;
+	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;
+
+	/* CLOCK_MONOTONIC */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];
+	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+
+	nsec = tk->tkr_mono.xtime_nsec;
+	nsec += ((u64)tk->wall_to_monotonic.tv_nsec << tk->tkr_mono.shift);
+	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
+		nsec -= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
+		vdso_ts->sec++;
+	}
+	vdso_ts->nsec	= nsec;
+
+	/* CLOCK_MONOTONIC_RAW */
+	vdso_ts		= &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
+	vdso_ts->sec	= tk->raw_sec;
+	vdso_ts->nsec	= tk->tkr_raw.xtime_nsec;
+
+	/* CLOCK_BOOTTIME */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
+	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec = tk->tkr_mono.xtime_nsec;
+	nsec += ((u64)(tk->wall_to_monotonic.tv_nsec +
+		       ktime_to_ns(tk->offs_boot)) << tk->tkr_mono.shift);
+	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
+		nsec -= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
+		vdso_ts->sec++;
+	}
+	vdso_ts->nsec	= nsec;
+
+	/* CLOCK_TAI */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_TAI];
+	vdso_ts->sec	= tk->xtime_sec + (s64)tk->tai_offset;
+	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;
+
+	/*
+	 * Read without the seqlock held by clock_getres().
+	 * Note: No need to have a second copy.
+	 */
+	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
+}
+
+void update_vsyscall(struct timekeeper *tk)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+	struct vdso_timestamp *vdso_ts;
+	u64 nsec;
+
+	if (__arch_update_vdso_data()) {
+		/*
+		 * Some architectures might want to skip the update of the
+		 * data page.
+		 */
+		return;
+	}
+
+	/* copy vsyscall data */
+	vdso_write_begin(vdata);
+
+	vdata[CS_HRES_COARSE].clock_mode	= __arch_get_clock_mode(tk);
+	vdata[CS_RAW].clock_mode		= __arch_get_clock_mode(tk);
+
+	/* CLOCK_REALTIME_COARSE */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
+	vdso_ts->sec	= tk->xtime_sec;
+	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+
+	/* CLOCK_MONOTONIC_COARSE */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
+	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
+	while (nsec >= NSEC_PER_SEC) {
+		nsec = nsec - NSEC_PER_SEC;
+		vdso_ts->sec++;
+	}
+	vdso_ts->nsec	= nsec;
+
+	if (__arch_use_vsyscall(vdata))
+		update_vdso_data(vdata, tk);
+
+	__arch_update_vsyscall(vdata, tk);
+
+	vdso_write_end(vdata);
+
+	__arch_sync_vdso_data(vdata);
+}
+
+void update_vsyscall_tz(void)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+
+	if (__arch_use_vsyscall(vdata)) {
+		vdata[CS_HRES_COARSE].tz_minuteswest = sys_tz.tz_minuteswest;
+		vdata[CS_HRES_COARSE].tz_dsttime = sys_tz.tz_dsttime;
+	}
+
+	__arch_sync_vdso_data(vdata);
+}
diff --git a/lib/Kconfig b/lib/Kconfig
index 90623a0e1942..8c8eefc5e54c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -576,6 +576,11 @@ config OID_REGISTRY
 config UCS2_STRING
         tristate
 
+#
+# generic vdso
+#
+source "lib/vdso/Kconfig"
+
 source "lib/fonts/Kconfig"
 
 config SG_SPLIT
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
new file mode 100644
index 000000000000..cc00364bd2c2
--- /dev/null
+++ b/lib/vdso/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config HAVE_GENERIC_VDSO
+	bool
+
+if HAVE_GENERIC_VDSO
+
+config GENERIC_GETTIMEOFDAY
+	bool
+	help
+	  This is a generic implementation of gettimeofday vdso.
+	  Each architecture that enables this feature has to
+	  provide the fallback implementation.
+
+config GENERIC_VDSO_32
+	bool
+	depends on GENERIC_GETTIMEOFDAY && !64BIT
+	help
+	  This config option helps to avoid possible performance issues
+	  in 32 bit only architectures.
+
+config GENERIC_COMPAT_VDSO
+	bool
+	help
+	  This config option enables the compat VDSO layer.
+
+config CROSS_COMPILE_COMPAT_VDSO
+	string "32 bit Toolchain prefix for compat vDSO"
+	default ""
+	depends on GENERIC_COMPAT_VDSO
+	help
+	  Defines the cross-compiler prefix for compiling compat vDSO.
+	  If a 64 bit compiler (i.e. x86_64) can compile the VDSO for
+	  32 bit, it does not need to define this parameter.
+
+endif
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
new file mode 100644
index 000000000000..c415a685d61b
--- /dev/null
+++ b/lib/vdso/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+
+GENERIC_VDSO_MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
+GENERIC_VDSO_DIR := $(dir $(GENERIC_VDSO_MK_PATH))
+
+c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) := $(addprefix $(GENERIC_VDSO_DIR), gettimeofday.c)
+
+# This cmd checks that the vdso library does not contain absolute relocation
+# It has to be called after the linking of the vdso library and requires it
+# as a parameter.
+#
+# $(ARCH_REL_TYPE_ABS) is defined in the arch specific makefile and corresponds
+# to the absolute relocation types printed by "objdump -R" and accepted by the
+# dynamic linker.
+ifndef ARCH_REL_TYPE_ABS
+$(error ARCH_REL_TYPE_ABS is not set)
+endif
+
+quiet_cmd_vdso_check = VDSOCHK $@
+      cmd_vdso_check = if $(OBJDUMP) -R $@ | egrep -h "$(ARCH_REL_TYPE_ABS)"; \
+		       then (echo >&2 "$@: dynamic relocations are not supported"; \
+			     rm -f $@; /bin/false); fi
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
new file mode 100644
index 000000000000..2d1c1f241fd9
--- /dev/null
+++ b/lib/vdso/gettimeofday.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic userspace implementations of gettimeofday() and similar.
+ */
+#include <linux/compiler.h>
+#include <linux/math64.h>
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/hrtimer_defs.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
+
+/*
+ * The generic vDSO implementation requires that gettimeofday.h
+ * provides:
+ * - __arch_get_vdso_data(): to get the vdso datapage.
+ * - __arch_get_hw_counter(): to get the hw counter based on the
+ *   clock_mode.
+ * - gettimeofday_fallback(): fallback for gettimeofday.
+ * - clock_gettime_fallback(): fallback for clock_gettime.
+ * - clock_getres_fallback(): fallback for clock_getres.
+ */
+#ifdef ENABLE_COMPAT_VDSO
+#include <asm/vdso/compat_gettimeofday.h>
+#else
+#include <asm/vdso/gettimeofday.h>
+#endif /* ENABLE_COMPAT_VDSO */
+
+#ifndef vdso_calc_delta
+/*
+ * Default implementation which works for all sane clocksources. That
+ * obviously excludes x86/TSC.
+ */
+static __always_inline
+u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+{
+	return ((cycles - last) & mask) * mult;
+}
+#endif
+
+static int do_hres(const struct vdso_data *vd, clockid_t clk,
+		   struct __kernel_timespec *ts)
+{
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	u64 cycles, last, sec, ns;
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vd);
+		cycles = __arch_get_hw_counter(vd->clock_mode);
+		ns = vdso_ts->nsec;
+		last = vd->cycle_last;
+		if (unlikely((s64)cycles < 0))
+			return clock_gettime_fallback(clk, ts);
+
+		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
+		ns >>= vd->shift;
+		sec = vdso_ts->sec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
+static void do_coarse(const struct vdso_data *vd, clockid_t clk,
+		      struct __kernel_timespec *ts)
+{
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vd);
+		ts->tv_sec = vdso_ts->sec;
+		ts->tv_nsec = vdso_ts->nsec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+}
+
+static __maybe_unused int
+__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+	u32 msk;
+
+	/* Check for negative values or invalid clocks */
+	if (unlikely((u32) clock >= MAX_CLOCKS))
+		goto fallback;
+
+	/*
+	 * Convert the clockid to a bitmask and use it to check which
+	 * clocks are handled in the VDSO directly.
+	 */
+	msk = 1U << clock;
+	if (likely(msk & VDSO_HRES)) {
+		return do_hres(&vd[CS_HRES_COARSE], clock, ts);
+	} else if (msk & VDSO_COARSE) {
+		do_coarse(&vd[CS_HRES_COARSE], clock, ts);
+		return 0;
+	} else if (msk & VDSO_RAW) {
+		return do_hres(&vd[CS_RAW], clock, ts);
+	}
+
+fallback:
+	return clock_gettime_fallback(clock, ts);
+}
+
+static __maybe_unused int
+__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
+{
+	struct __kernel_timespec ts;
+	int ret;
+
+	if (res == NULL)
+		goto fallback;
+
+	ret = __cvdso_clock_gettime(clock, &ts);
+
+	if (ret == 0) {
+		res->tv_sec = ts.tv_sec;
+		res->tv_nsec = ts.tv_nsec;
+	}
+
+	return ret;
+
+fallback:
+	return clock_gettime_fallback(clock, (struct __kernel_timespec *)res);
+}
+
+static __maybe_unused int
+__cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+
+	if (likely(tv != NULL)) {
+		struct __kernel_timespec ts;
+
+		if (do_hres(&vd[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+			return gettimeofday_fallback(tv, tz);
+
+		tv->tv_sec = ts.tv_sec;
+		tv->tv_usec = (u32)ts.tv_nsec / NSEC_PER_USEC;
+	}
+
+	if (unlikely(tz != NULL)) {
+		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
+		tz->tz_dsttime = vd[CS_HRES_COARSE].tz_dsttime;
+	}
+
+	return 0;
+}
+
+#ifdef VDSO_HAS_TIME
+static __maybe_unused time_t __cvdso_time(time_t *time)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+	time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+
+	if (time)
+		*time = t;
+
+	return t;
+}
+#endif /* VDSO_HAS_TIME */
+
+#ifdef VDSO_HAS_CLOCK_GETRES
+static __maybe_unused
+int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+	u64 ns;
+	u32 msk;
+	u64 hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
+
+	/* Check for negative values or invalid clocks */
+	if (unlikely((u32) clock >= MAX_CLOCKS))
+		goto fallback;
+
+	/*
+	 * Convert the clockid to a bitmask and use it to check which
+	 * clocks are handled in the VDSO directly.
+	 */
+	msk = 1U << clock;
+	if (msk & VDSO_HRES) {
+		/*
+		 * Preserves the behaviour of posix_get_hrtimer_res().
+		 */
+		ns = hrtimer_res;
+	} else if (msk & VDSO_COARSE) {
+		/*
+		 * Preserves the behaviour of posix_get_coarse_res().
+		 */
+		ns = LOW_RES_NSEC;
+	} else if (msk & VDSO_RAW) {
+		/*
+		 * Preserves the behaviour of posix_get_hrtimer_res().
+		 */
+		ns = hrtimer_res;
+	} else {
+		goto fallback;
+	}
+
+	if (res) {
+		res->tv_sec = 0;
+		res->tv_nsec = ns;
+	}
+
+	return 0;
+
+fallback:
+	return clock_getres_fallback(clock, res);
+}
+
+static __maybe_unused int
+__cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
+{
+	struct __kernel_timespec ts;
+	int ret;
+
+	if (res == NULL)
+		goto fallback;
+
+	ret = __cvdso_clock_getres(clock, &ts);
+
+	if (ret == 0) {
+		res->tv_sec = ts.tv_sec;
+		res->tv_nsec = ts.tv_nsec;
+	}
+
+	return ret;
+
+fallback:
+	return clock_getres_fallback(clock, (struct __kernel_timespec *)res);
+}
+#endif /* VDSO_HAS_CLOCK_GETRES */
diff --git a/tools/testing/selftests/timers/freq-step.c b/tools/testing/selftests/timers/freq-step.c
index 8cd10662ffba..4b76450d78d1 100644
--- a/tools/testing/selftests/timers/freq-step.c
+++ b/tools/testing/selftests/timers/freq-step.c
@@ -21,9 +21,9 @@
 #define SAMPLE_READINGS 10
 #define MEAN_SAMPLE_INTERVAL 0.1
 #define STEP_INTERVAL 1.0
-#define MAX_PRECISION 100e-9
-#define MAX_FREQ_ERROR 10e-6
-#define MAX_STDDEV 1000e-9
+#define MAX_PRECISION 500e-9
+#define MAX_FREQ_ERROR 0.02e-6
+#define MAX_STDDEV 50e-9
 
 #ifndef ADJ_SETOFFSET
   #define ADJ_SETOFFSET 0x0100

