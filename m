Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64360C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2684522CED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uUXoGr+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfFXBlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfFXBk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNkiQv2858667
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:46:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNkiQv2858667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333605;
        bh=tWNsDYKjm7OuwZ4ihPphc6KWeBre5kho7BOWhzqYIRQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uUXoGr+2hcd0B37pUaYejKhgDr3Hp8nuccYtRTYLD1ySBetFUSA88Ef8SuM30s+Q0
         PGO6N8iPfvzfzRELGlrEXNvY49Hz5BfKyUkDqoII9d4NECqthS+7XjEBjjJgxhzWzy
         bFJdmU9b/a4jKgeka7fK5L5xLf0ZHZzvc/J+15ivyZ6uPmIeYxeQ5EfLeeLfwqffwt
         mbwgojarXFOVJJuEGj1y8KqFDhpiRy7v79nY+0/yd2EOsOlFNuirWfKGuiqjc3oPta
         Mihy8ftfb2pJnEzA5cJ71dnT1JfrszsAAMrb6du2Rp8gl1GAZNfsk0Q7M3/OtdCcBv
         s1O1UXRgxWhFg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNkhUU2858664;
        Sun, 23 Jun 2019 16:46:43 -0700
Date:   Sun, 23 Jun 2019 16:46:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-44f57d788e7deecb504843534081d3449c2eede9@git.kernel.org>
Cc:     arnd@arndb.de, linux@rasmusvillemoes.dk, ralf@linux-mips.org,
        pcc@google.com, huw@codeweavers.com, will.deacon@arm.com,
        shuah@kernel.org, hpa@zytor.com, paul.burton@mips.com,
        sthotton@marvell.com, salyzyn@android.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        0x7f454c46@gmail.com, linux@armlinux.org.uk, mingo@kernel.org,
        catalin.marinas@arm.com, vincenzo.frascino@arm.com,
        andre.przywara@arm.com
Reply-To: 0x7f454c46@gmail.com, linux-kernel@vger.kernel.org,
          daniel.lezcano@linaro.org, mingo@kernel.org,
          linux@armlinux.org.uk, catalin.marinas@arm.com,
          vincenzo.frascino@arm.com, andre.przywara@arm.com,
          linux@rasmusvillemoes.dk, arnd@arndb.de, pcc@google.com,
          ralf@linux-mips.org, huw@codeweavers.com, paul.burton@mips.com,
          will.deacon@arm.com, shuah@kernel.org, hpa@zytor.com,
          sthotton@marvell.com, salyzyn@android.com, tglx@linutronix.de
In-Reply-To: <20190621095252.32307-4-vincenzo.frascino@arm.com>
References: <20190621095252.32307-4-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] timekeeping: Provide a generic update_vsyscall()
 implementation
Git-Commit-ID: 44f57d788e7deecb504843534081d3449c2eede9
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

Commit-ID:  44f57d788e7deecb504843534081d3449c2eede9
Gitweb:     https://git.kernel.org/tip/44f57d788e7deecb504843534081d3449c2eede9
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:30 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:06 +0200

timekeeping: Provide a generic update_vsyscall() implementation

The new generic VDSO library allows to unify the update_vsyscall[_tz]()
implementations.

Provide a generic implementation based on the x86 code and the bindings
which need to be implemented in architecture specific code.

[ tglx: Moved it into kernel/time where it belongs. Removed the pointless
  	line breaks in the stub functions. Massaged changelog ]

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
Link: https://lkml.kernel.org/r/20190621095252.32307-4-vincenzo.frascino@arm.com

---
 include/asm-generic/vdso/vsyscall.h |  50 ++++++++++++++
 include/vdso/vsyscall.h             |  11 +++
 kernel/time/Makefile                |   1 +
 kernel/time/vsyscall.c              | 133 ++++++++++++++++++++++++++++++++++++
 4 files changed, 195 insertions(+)

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
