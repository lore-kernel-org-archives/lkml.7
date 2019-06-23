Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11538C48BE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF8922CEB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vzwMQXl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFXBlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfFXBlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:41:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNjFWu2858551
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:45:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNjFWu2858551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333517;
        bh=Evgqj95MxCdHmrZD9Gj/G1s1uNeyfycUHVgn0y35FwY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vzwMQXl6F/0bcG+i79Vt41249va70n6G8sVL0UTGykrAQHETTe5409WZUHxtbtLI2
         hDNzUCOtLYihLjMzJdPfbGROagn9dx/tVbRhidB8tbs1xleSDD6jbgW+R1OzRP90eo
         zBLf4Zo5z/yK39FydSmwOutTFFmaxUV7XIboRxYUDlCWAAJ/k3aVZbHrcb0g4s0w3f
         GGcHT35sK/q8tzhQEn3TtlL9zQLw50Vh/IqSU+2h2rjw4vqyXluApaPH0kYVuZlbLM
         t+f/766MdFefdi9z5QBAjTT/gUkXV1TJY0bunaeFEUN348D+DtNpMbI+7eVKLKdtNo
         Omx2Sni6p+VRg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNjFC22858548;
        Sun, 23 Jun 2019 16:45:15 -0700
Date:   Sun, 23 Jun 2019 16:45:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-00b26474c2f1613d7ab894c525f775c67c8a9e8f@git.kernel.org>
Cc:     pcc@google.com, salyzyn@android.com, linux@armlinux.org.uk,
        shuah@kernel.org, mingo@kernel.org, paul.burton@mips.com,
        0x7f454c46@gmail.com, huw@codeweavers.com, sthotton@marvell.com,
        hpa@zytor.com, andre.przywara@arm.com, vincenzo.frascino@arm.com,
        daniel.lezcano@linaro.org, catalin.marinas@arm.com,
        linux@rasmusvillemoes.dk, ralf@linux-mips.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com, arnd@arndb.de
Reply-To: pcc@google.com, linux@armlinux.org.uk, salyzyn@android.com,
          shuah@kernel.org, mingo@kernel.org, paul.burton@mips.com,
          0x7f454c46@gmail.com, huw@codeweavers.com, hpa@zytor.com,
          sthotton@marvell.com, vincenzo.frascino@arm.com,
          andre.przywara@arm.com, daniel.lezcano@linaro.org,
          linux@rasmusvillemoes.dk, catalin.marinas@arm.com,
          ralf@linux-mips.org, linux-kernel@vger.kernel.org,
          will.deacon@arm.com, tglx@linutronix.de, arnd@arndb.de
In-Reply-To: <20190621095252.32307-3-vincenzo.frascino@arm.com>
References: <20190621095252.32307-3-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] lib/vdso: Provide generic VDSO implementation
Git-Commit-ID: 00b26474c2f1613d7ab894c525f775c67c8a9e8f
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

Commit-ID:  00b26474c2f1613d7ab894c525f775c67c8a9e8f
Gitweb:     https://git.kernel.org/tip/00b26474c2f1613d7ab894c525f775c67c8a9e8f
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:29 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:05 +0200

lib/vdso: Provide generic VDSO implementation

In the last few years the kernel gained quite some architecture specific
vdso implementations which contain very similar code.

Introduce a generic VDSO implementation of gettimeofday() which will be
shareable between architectures once they are converted over.

The implementation is based on the current x86 VDSO code.

[ tglx: Massaged changelog and made the kernel doc tabular ]

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
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
Link: https://lkml.kernel.org/r/20190621095252.32307-3-vincenzo.frascino@arm.com

---
 include/vdso/helpers.h  |  56 ++++++++++++
 lib/Kconfig             |   5 ++
 lib/vdso/Kconfig        |  36 ++++++++
 lib/vdso/Makefile       |  22 +++++
 lib/vdso/gettimeofday.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 343 insertions(+)

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
index 000000000000..767d3a0bcb06
--- /dev/null
+++ b/lib/vdso/gettimeofday.c
@@ -0,0 +1,224 @@
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
+#include <asm/vdso/gettimeofday.h>
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
+		cycles = __arch_get_hw_counter(vd->clock_mode) &
+			vd->mask;
+		ns = vdso_ts->nsec;
+		last = vd->cycle_last;
+		if (unlikely((s64)cycles < 0))
+			return clock_gettime_fallback(clk, ts);
+		if (cycles > last)
+			ns += (cycles - last) * vd->mult;
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
