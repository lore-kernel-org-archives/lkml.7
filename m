Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F586C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC0E22CEB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ogFuypR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFXBlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfFXBk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNtQFc2860161
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:55:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNtQFc2860161
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334127;
        bh=gR9OFfUcOnfJibFmcWCh+CMH0/qQv6/EAKDSv2rvdpI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ogFuypR2e+rT0PIPlJrW0yzptZNZZYc55CeYYLCvIZbJiumvDcTHp7q8+N9egZnSJ
         x0Ucn3FcqLMKSbfB4QbBW8RUEpaEGWmWV/MprknKLKdXIbTx/SFuJ4IvF9+c+StV1z
         RDKza5VQGkLaOITOwlbuLYortyY5JCDxnUbK9/WZNhdZjhQDLuQ8f6SgM93o9B6AhO
         MwSbrwte24oXV1Mr9CzJ9Co/kdX3GZBJvgwqZBjbts7Rpr1DVC8vASMdQvjZBBMUOk
         7trYxNwWfx1i0qR7RxcqjkPo0jorGKP31A10svmu7Rdz0WjMVRFV0HFdEz5yXVYhJ5
         WXYGCMHk5Rw4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNtPSt2860158;
        Sun, 23 Jun 2019 16:55:25 -0700
Date:   Sun, 23 Jun 2019 16:55:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-7ac8707479886c75f353bfb6a8273f423cfccb23@git.kernel.org>
Cc:     ralf@linux-mips.org, mingo@kernel.org, andre.przywara@arm.com,
        huw@codeweavers.com, catalin.marinas@arm.com, paul.burton@mips.com,
        vincenzo.frascino@arm.com, shuah@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, linux@armlinux.org.uk, arnd@arndb.de,
        0x7f454c46@gmail.com, salyzyn@android.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, pcc@google.com, sthotton@marvell.com,
        linux@rasmusvillemoes.dk, will.deacon@arm.com
Reply-To: arnd@arndb.de, linux@armlinux.org.uk, 0x7f454c46@gmail.com,
          salyzyn@android.com, sthotton@marvell.com,
          linux@rasmusvillemoes.dk, pcc@google.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          will.deacon@arm.com, andre.przywara@arm.com, ralf@linux-mips.org,
          mingo@kernel.org, huw@codeweavers.com, catalin.marinas@arm.com,
          vincenzo.frascino@arm.com, paul.burton@mips.com,
          shuah@kernel.org, daniel.lezcano@linaro.org, hpa@zytor.com
In-Reply-To: <20190621095252.32307-23-vincenzo.frascino@arm.com>
References: <20190621095252.32307-23-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] x86/vdso: Switch to generic vDSO implementation
Git-Commit-ID: 7ac8707479886c75f353bfb6a8273f423cfccb23
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7ac8707479886c75f353bfb6a8273f423cfccb23
Gitweb:     https://git.kernel.org/tip/7ac8707479886c75f353bfb6a8273f423cfccb23
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:49 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:10 +0200

x86/vdso: Switch to generic vDSO implementation

The x86 vDSO library requires some adaptations to take advantage of the
newly introduced generic vDSO library.

Introduce the following changes:
 - Modification of vdso.c to be compliant with the common vdso datapage
 - Use of lib/vdso for gettimeofday

[ tglx: Massaged changelog and cleaned up the function signature formatting ]

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Huw Davies <huw@codeweavers.com>
Cc: Shijith Thotton <sthotton@marvell.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Link: https://lkml.kernel.org/r/20190621095252.32307-23-vincenzo.frascino@arm.com

---
 arch/x86/Kconfig                         |   3 +
 arch/x86/entry/vdso/Makefile             |   9 ++
 arch/x86/entry/vdso/vclock_gettime.c     | 245 ++++---------------------------
 arch/x86/entry/vdso/vdsox32.lds.S        |   1 +
 arch/x86/entry/vsyscall/Makefile         |   2 -
 arch/x86/entry/vsyscall/vsyscall_gtod.c  |  83 -----------
 arch/x86/include/asm/pvclock.h           |   2 +-
 arch/x86/include/asm/vdso/gettimeofday.h | 191 ++++++++++++++++++++++++
 arch/x86/include/asm/vdso/vsyscall.h     |  44 ++++++
 arch/x86/include/asm/vgtod.h             |  75 +---------
 arch/x86/include/asm/vvar.h              |   7 +-
 arch/x86/kernel/pvclock.c                |   1 +
 12 files changed, 284 insertions(+), 379 deletions(-)

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
index 4aed41f638bb..f01a3f0787ca 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -1,251 +1,60 @@
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
-{
-	long ret;
-	asm ("syscall" : "=a" (ret), "=m" (*ts) :
-	     "0" (__NR_clock_gettime), "D" (clock), "S" (ts) :
-	     "rcx", "r11");
-	return ret;
-}
-
-#else
-
-notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
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
+	return __cvdso_gettimeofday(tv, tz);
 }
 
-#endif
-
-#ifdef CONFIG_PARAVIRT_CLOCK
-static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
-{
-	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
-}
+int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
+	__attribute__((weak, alias("__vdso_gettimeofday")));
 
-static notrace u64 vread_pvclock(void)
+time_t __vdso_time(time_t *t)
 {
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
+	return __cvdso_time(t);
 }
-#endif
-#ifdef CONFIG_HYPERV_TSCPAGE
-static notrace u64 vread_hvclock(void)
-{
-	const struct ms_hyperv_tsc_page *tsc_pg =
-		(const struct ms_hyperv_tsc_page *)&hvclock_page;
 
-	return hv_read_tsc_page(tsc_pg);
-}
-#endif
+time_t time(time_t *t)	__attribute__((weak, alias("__vdso_time")));
 
-notrace static inline u64 vgetcyc(int mode)
-{
-	if (mode == VCLOCK_TSC)
-		return (u64)rdtsc_ordered();
 
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
-}
+#if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
+/* both 64-bit and x32 use these */
+extern int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
 
-notrace static int do_hres(clockid_t clk, struct timespec *ts)
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
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
+	return __cvdso_clock_gettime(clock, ts);
 }
 
-notrace static void do_coarse(clockid_t clk, struct timespec *ts)
-{
-	struct vgtod_ts *base = &gtod->basetime[clk];
-	unsigned int seq;
+int clock_gettime(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-	do {
-		seq = gtod_read_begin(gtod);
-		ts->tv_sec = base->sec;
-		ts->tv_nsec = base->nsec;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-}
+#else
+/* i386 only */
+extern int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts);
 
-notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
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
-{
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
-}
-int gettimeofday(struct timeval *, struct timezone *)
-	__attribute__((weak, alias("__vdso_gettimeofday")));
-
-/*
- * This will break when the xtime seconds get inaccurate, but that is
- * unlikely
- */
-notrace time_t __vdso_time(time_t *t)
-{
-	/* This is atomic on x86 so we don't need any locks. */
-	time_t result = READ_ONCE(gtod->basetime[CLOCK_REALTIME].sec);
-
-	if (t)
-		*t = result;
-	return result;
-}
-time_t time(time_t *t)
-	__attribute__((weak, alias("__vdso_time")));
+#endif
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
index 000000000000..0e2650fc191b
--- /dev/null
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,191 @@
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
+#include <asm/mshyperv.h>
+
+#define __vdso_data (VVAR(_vdso_data))
+
+#define VDSO_HAS_TIME 1
+
+#ifdef CONFIG_PARAVIRT_CLOCK
+extern u8 pvclock_page[PAGE_SIZE]
+	__attribute__((visibility("hidden")));
+#endif
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+extern u8 hvclock_page[PAGE_SIZE]
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
+#endif
+
+#ifdef CONFIG_PARAVIRT_CLOCK
+static const struct pvclock_vsyscall_time_info *get_pvti0(void)
+{
+	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
+}
+
+static u64 vread_pvclock(void)
+{
+	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
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
+	const struct ms_hyperv_tsc_page *tsc_pg =
+		(const struct ms_hyperv_tsc_page *)&hvclock_page;
+
+	return hv_read_tsc_page(tsc_pg);
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
