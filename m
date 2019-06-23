Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C30C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E851122CED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TUKsgWp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFXBlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfFXBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNu8Q22860229
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:56:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNu8Q22860229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334169;
        bh=C0loTj/gJM3E6LeqWTO4cZ658sIJrg5v1gEhQqEsWQI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TUKsgWp49LtQCbE/1dui0MQq+iOocWjyJTWVBsXgJisRwxGn7zE9Nnn6qFOAXyi5k
         rbiNh+dSnwDWgspvBOv7i6uYZztGKnOzUyi1ys5DKEvLvb+68otF7kgbij+HVl6zHP
         CuOWya10OTw6kApxD7dwPk0WX5vtNt3oTgMZ+iBkHfIRCgHHpNwjl9PDSMfQZE2z7K
         wiPAwVfONIfCffYw1coA2sE2cajlXlOFEV4K9AK2D9ik6w1ylNlO9epzyzHyVqXrFb
         w0znDjufvVsdrt6tq/JHIY+E/KCW2e5t4wh5urstmmD9vlrqb3pi10qG+CbrUpgg7o
         alUonE3XYdcRA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNu7BY2860226;
        Sun, 23 Jun 2019 16:56:07 -0700
Date:   Sun, 23 Jun 2019 16:56:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-f66501dc53e72079045a6a17e023b41316ede220@git.kernel.org>
Cc:     pcc@google.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        0x7f454c46@gmail.com, salyzyn@android.com, andre.przywara@arm.com,
        vincenzo.frascino@arm.com, shuah@kernel.org, linux@armlinux.org.uk,
        linux@rasmusvillemoes.dk, paul.burton@mips.com, tglx@linutronix.de,
        catalin.marinas@arm.com, ralf@linux-mips.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, sthotton@marvell.com, arnd@arndb.de,
        will.deacon@arm.com, huw@codeweavers.com
Reply-To: hpa@zytor.com, catalin.marinas@arm.com, ralf@linux-mips.org,
          arnd@arndb.de, sthotton@marvell.com, daniel.lezcano@linaro.org,
          will.deacon@arm.com, huw@codeweavers.com, paul.burton@mips.com,
          tglx@linutronix.de, salyzyn@android.com, andre.przywara@arm.com,
          shuah@kernel.org, vincenzo.frascino@arm.com,
          linux@armlinux.org.uk, linux@rasmusvillemoes.dk,
          mingo@kernel.org, pcc@google.com, linux-kernel@vger.kernel.org,
          0x7f454c46@gmail.com
In-Reply-To: <20190621095252.32307-24-vincenzo.frascino@arm.com>
References: <20190621095252.32307-24-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] x86/vdso: Add clock_getres() entry point
Git-Commit-ID: f66501dc53e72079045a6a17e023b41316ede220
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

Commit-ID:  f66501dc53e72079045a6a17e023b41316ede220
Gitweb:     https://git.kernel.org/tip/f66501dc53e72079045a6a17e023b41316ede220
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:50 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:10 +0200

x86/vdso: Add clock_getres() entry point

The generic vDSO library provides an implementation of clock_getres()
that can be leveraged by each architecture.

Add the clock_getres() VDSO entry point on x86.

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
Link: https://lkml.kernel.org/r/20190621095252.32307-24-vincenzo.frascino@arm.com

---
 arch/x86/entry/vdso/vclock_gettime.c     | 17 +++++++++++++++++
 arch/x86/entry/vdso/vdso.lds.S           |  2 ++
 arch/x86/entry/vdso/vdso32/vdso32.lds.S  |  1 +
 arch/x86/include/asm/vdso/gettimeofday.h | 31 +++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index f01a3f0787ca..1a648b509d46 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -36,6 +36,7 @@ time_t time(time_t *t)	__attribute__((weak, alias("__vdso_time")));
 #if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
 /* both 64-bit and x32 use these */
 extern int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
+extern int __vdso_clock_getres(clockid_t clock, struct __kernel_timespec *res);
 
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
@@ -45,9 +46,18 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 int clock_gettime(clockid_t, struct __kernel_timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
+int __vdso_clock_getres(clockid_t clock,
+			struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock, res);
+}
+int clock_getres(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
+
 #else
 /* i386 only */
 extern int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts);
+extern int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res);
 
 int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 {
@@ -57,4 +67,11 @@ int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 int clock_gettime(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
+int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock, res);
+}
+
+int clock_getres(clockid_t, struct old_timespec32 *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
 #endif
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
index 422764a81d32..991b26cc855b 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -26,6 +26,7 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_time;
+		__vdso_clock_getres;
 	};
 
 	LINUX_2.5 {
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 0e2650fc191b..f92752d6cbcf 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -24,6 +24,8 @@
 
 #define VDSO_HAS_TIME 1
 
+#define VDSO_HAS_CLOCK_GETRES 1
+
 #ifdef CONFIG_PARAVIRT_CLOCK
 extern u8 pvclock_page[PAGE_SIZE]
 	__attribute__((visibility("hidden")));
@@ -60,6 +62,18 @@ long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 	return ret;
 }
 
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
 #else
 
 static __always_inline
@@ -97,6 +111,23 @@ long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 	return ret;
 }
 
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
 #endif
 
 #ifdef CONFIG_PARAVIRT_CLOCK
