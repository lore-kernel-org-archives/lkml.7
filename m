Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44CAC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79752087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfG1NVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:21:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51646 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfG1NUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:20:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrj6T-0003q0-3c; Sun, 28 Jul 2019 15:20:45 +0200
Message-Id: <20190728131648.786513965@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 28 Jul 2019 15:12:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: [patch 3/5] lib/vdso/32: Provide legacy syscall fallbacks
References: <20190728131251.622415456@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address the regression which causes seccomp to deny applications the
access to clock_gettime64() and clock_getres64() syscalls because they
are not enabled in the existing filters.

That trips over the fact that 32bit VDSOs use the new clock_gettime64() and
clock_getres64() syscalls in the fallback path.

Implement a __cvdso_clock_get*time32() variants which invokes the legacy
32bit syscalls when the architecture requests it.

The conditional can go away once all architectures are converted.

Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/vdso/gettimeofday.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -117,6 +117,8 @@ static __maybe_unused int
 	return 0;
 }
 
+#ifndef VDSO_HAS_32BIT_FALLBACK
+
 static __maybe_unused int
 __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 {
@@ -132,10 +134,29 @@ static __maybe_unused int
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}
-
 	return ret;
 }
 
+#else
+
+static __maybe_unused int
+__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
+{
+	struct __kernel_timespec ts;
+	int ret;
+
+	ret = __cvdso_clock_gettime_common(clock, &ts);
+
+	if (likely(!ret)) {
+		res->tv_sec = ts.tv_sec;
+		res->tv_nsec = ts.tv_nsec;
+		return 0;
+	}
+	return clock_gettime32_fallback(clock, res);
+}
+
+#endif
+
 static __maybe_unused int
 __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
@@ -225,6 +246,8 @@ int __cvdso_clock_getres(clockid_t clock
 	return 0;
 }
 
+#ifndef VDSO_HAS_32BIT_FALLBACK
+
 static __maybe_unused int
 __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 {
@@ -241,4 +264,25 @@ static __maybe_unused int
 	}
 	return ret;
 }
+
+#else
+
+static __maybe_unused int
+__cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
+{
+	struct __kernel_timespec ts;
+	int ret;
+
+	ret = __cvdso_clock_getres_common(clock, &ts);
+
+	if (likely(!ret)) {
+		res->tv_sec = ts.tv_sec;
+		res->tv_nsec = ts.tv_nsec;
+		return 0;
+	}
+
+	return clock_getres32_fallback(clock, res);
+}
+#endif
+
 #endif /* VDSO_HAS_CLOCK_GETRES */


