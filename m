Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B954FC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B36320679
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbfHCQiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 12:38:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41007 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388249AbfHCQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 12:38:15 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htx2p-0000oi-I1; Sat, 03 Aug 2019 18:38:11 +0200
Date:   Sat, 03 Aug 2019 16:36:53 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.3-rc3
References: <156485021326.28964.12573754498454150320.tglx@nanos.tec.linutronix.de>
Message-ID: <156485021326.28964.11252649669292370361.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

up to:  33a58980ff3c: arm64: compat: vdso: Use legacy syscalls as fallback

A series of commits to deal with the regression caused by the generic VDSO
implementation. The usage of clock_gettime64() for 32bit compat fallback
syscalls, caused seccomp filters to kill innocent processes because they
only allow clock_gettime().

Handle the compat syscalls with clock_gettime() as before, which is not a
functional problem for the VDSO as the legacy compat application interface
is not y2038 safe anyway. It's just extra fallback code which needs to be
implemented on every architecture. It's opt in for now so that it does not
break the compile of already converted architectures in linux-next. Once
these are fixed, the #ifdeffery goes away.

So much for trying to be smart and reuse code...

Thanks,

	tglx

------------------>
Thomas Gleixner (5):
      lib/vdso/32: Remove inconsistent NULL pointer checks
      lib/vdso: Move fallback invocation to the callers
      lib/vdso/32: Provide legacy syscall fallbacks
      x86/vdso/32: Use 32bit syscall fallback
      arm64: compat: vdso: Use legacy syscalls as fallback


 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 40 ++++++++++++
 arch/x86/include/asm/vdso/gettimeofday.h          | 36 +++++++++++
 lib/vdso/gettimeofday.c                           | 79 ++++++++++++++---------
 3 files changed, 123 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index f4812777f5c5..c50ee1b7d5cd 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -16,6 +16,8 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
+#define VDSO_HAS_32BIT_FALLBACK		1
+
 static __always_inline
 int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 			  struct timezone *_tz)
@@ -51,6 +53,23 @@ long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	return ret;
 }
 
+static __always_inline
+long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_compat_clock_gettime;
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
 static __always_inline
 int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
@@ -72,6 +91,27 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	return ret;
 }
 
+static __always_inline
+int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_compat_clock_getres;
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
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 {
 	u64 res;
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index ae91429129a6..ba71a63cdac4 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -96,6 +96,8 @@ long clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 
 #else
 
+#define VDSO_HAS_32BIT_FALLBACK	1
+
 static __always_inline
 long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
@@ -113,6 +115,23 @@ long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	return ret;
 }
 
+static __always_inline
+long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+	long ret;
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (*_ts)
+		: "0" (__NR_clock_gettime), [clock] "g" (_clkid), "c" (_ts)
+		: "edx");
+
+	return ret;
+}
+
 static __always_inline
 long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 			   struct timezone *_tz)
@@ -148,6 +167,23 @@ clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	return ret;
 }
 
+static __always_inline
+long clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+	long ret;
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (*_ts)
+		: "0" (__NR_clock_getres), [clock] "g" (_clkid), "c" (_ts)
+		: "edx");
+
+	return ret;
+}
+
 #endif
 
 #ifdef CONFIG_PARAVIRT_CLOCK
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 2d1c1f241fd9..e630e7ff57f1 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -51,7 +51,7 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
 		if (unlikely((s64)cycles < 0))
-			return clock_gettime_fallback(clk, ts);
+			return -1;
 
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
 		ns >>= vd->shift;
@@ -82,14 +82,14 @@ static void do_coarse(const struct vdso_data *vd, clockid_t clk,
 }
 
 static __maybe_unused int
-__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+__cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
 	u32 msk;
 
 	/* Check for negative values or invalid clocks */
 	if (unlikely((u32) clock >= MAX_CLOCKS))
-		goto fallback;
+		return -1;
 
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
@@ -104,9 +104,17 @@ __cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 	} else if (msk & VDSO_RAW) {
 		return do_hres(&vd[CS_RAW], clock, ts);
 	}
+	return -1;
+}
+
+static __maybe_unused int
+__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+	int ret = __cvdso_clock_gettime_common(clock, ts);
 
-fallback:
-	return clock_gettime_fallback(clock, ts);
+	if (unlikely(ret))
+		return clock_gettime_fallback(clock, ts);
+	return 0;
 }
 
 static __maybe_unused int
@@ -115,20 +123,21 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 	struct __kernel_timespec ts;
 	int ret;
 
-	if (res == NULL)
-		goto fallback;
+	ret = __cvdso_clock_gettime_common(clock, &ts);
 
-	ret = __cvdso_clock_gettime(clock, &ts);
+#ifdef VDSO_HAS_32BIT_FALLBACK
+	if (unlikely(ret))
+		return clock_gettime32_fallback(clock, res);
+#else
+	if (unlikely(ret))
+		ret = clock_gettime_fallback(clock, &ts);
+#endif
 
-	if (ret == 0) {
+	if (likely(!ret)) {
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}
-
 	return ret;
-
-fallback:
-	return clock_gettime_fallback(clock, (struct __kernel_timespec *)res);
 }
 
 static __maybe_unused int
@@ -169,17 +178,18 @@ static __maybe_unused time_t __cvdso_time(time_t *time)
 
 #ifdef VDSO_HAS_CLOCK_GETRES
 static __maybe_unused
-int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
+int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
-	u64 ns;
+	u64 hrtimer_res;
 	u32 msk;
-	u64 hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
+	u64 ns;
 
 	/* Check for negative values or invalid clocks */
 	if (unlikely((u32) clock >= MAX_CLOCKS))
-		goto fallback;
+		return -1;
 
+	hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
 	 * clocks are handled in the VDSO directly.
@@ -201,18 +211,22 @@ int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 		 */
 		ns = hrtimer_res;
 	} else {
-		goto fallback;
+		return -1;
 	}
 
-	if (res) {
-		res->tv_sec = 0;
-		res->tv_nsec = ns;
-	}
+	res->tv_sec = 0;
+	res->tv_nsec = ns;
 
 	return 0;
+}
+
+int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
+{
+	int ret = __cvdso_clock_getres_common(clock, res);
 
-fallback:
-	return clock_getres_fallback(clock, res);
+	if (unlikely(ret))
+		return clock_getres_fallback(clock, res);
+	return 0;
 }
 
 static __maybe_unused int
@@ -221,19 +235,20 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 	struct __kernel_timespec ts;
 	int ret;
 
-	if (res == NULL)
-		goto fallback;
+	ret = __cvdso_clock_getres_common(clock, &ts);
 
-	ret = __cvdso_clock_getres(clock, &ts);
+#ifdef VDSO_HAS_32BIT_FALLBACK
+	if (unlikely(ret))
+		return clock_getres32_fallback(clock, res);
+#else
+	if (unlikely(ret))
+		ret = clock_getres_fallback(clock, &ts);
+#endif
 
-	if (ret == 0) {
+	if (likely(!ret)) {
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}
-
 	return ret;
-
-fallback:
-	return clock_getres_fallback(clock, (struct __kernel_timespec *)res);
 }
 #endif /* VDSO_HAS_CLOCK_GETRES */

