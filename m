Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA398C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E2F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HdeKlOOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfG3WUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:20:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38703 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfG3WUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:20:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMJsV23399893
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:19:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMJsV23399893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564525194;
        bh=55HQgEdOvwROKEmUxG0QD03N8AMIn3OgSFYeHfP5Rqg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HdeKlOORbtOKhJ+0S8OaMse0ZJCwpKACvvWIZwuMMVAWx4brJgpLzkMhTMXRf2WGd
         tVzAQMHSjuGnEEWjYroZ0APzQNMvQjlNUa5OEfGYV5eUGnwXNaMFdq7i3x77ODkbvO
         R+s7OjY36rugN6HmwqF8aAbmBynJ3PEFSsXxIIFF1rhAl2kBrbXCGwrc06oN0J5E2j
         m6NuvDta2VRgT6MH6NhaRgznA30T3w8jcfbeXqUzGIlSB8+VL80oHmUP6/OTiPpuQM
         2c/CUqZ+qNlDfp4YXQr/dWT+B1tm1eWs/phzww67mxghKf8JUbkkPtoHfJn3KBLyBT
         c5Zo3RO55v6cw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMJrj13399890;
        Tue, 30 Jul 2019 15:19:53 -0700
Date:   Tue, 30 Jul 2019 15:19:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-502a590a170b3b3d0ad998ee0b639ac0b3db1dfa@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, mingo@kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, luto@kernel.org,
          tglx@linutronix.de, vincenzo.frascino@arm.com, mingo@kernel.org,
          hpa@zytor.com
In-Reply-To: <20190728131648.695579736@linutronix.de>
References: <20190728131648.695579736@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] lib/vdso: Move fallback invocation to the
 callers
Git-Commit-ID: 502a590a170b3b3d0ad998ee0b639ac0b3db1dfa
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

Commit-ID:  502a590a170b3b3d0ad998ee0b639ac0b3db1dfa
Gitweb:     https://git.kernel.org/tip/502a590a170b3b3d0ad998ee0b639ac0b3db1dfa
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 28 Jul 2019 15:12:53 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 31 Jul 2019 00:09:09 +0200

lib/vdso: Move fallback invocation to the callers

To allow syscall fallbacks using the legacy 32bit syscall for 32bit VDSO
builds, move the fallback invocation out into the callers.

Split the common code out of __cvdso_clock_gettime/getres() and invoke the
syscall fallback in the 64bit and 32bit variants.

Preparatory work for using legacy syscalls in 32bit VDSO. No functional
change.

Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/20190728131648.695579736@linutronix.de

---
 lib/vdso/gettimeofday.c | 53 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index e28f5a607a5f..a9e7fd029593 100644
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
 
-fallback:
-	return clock_gettime_fallback(clock, ts);
+static __maybe_unused int
+__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+	int ret = __cvdso_clock_gettime_common(clock, ts);
+
+	if (unlikely(ret))
+		return clock_gettime_fallback(clock, ts);
+	return 0;
 }
 
 static __maybe_unused int
@@ -115,9 +123,12 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 	struct __kernel_timespec ts;
 	int ret;
 
-	ret = __cvdso_clock_gettime(clock, &ts);
+	ret = __cvdso_clock_gettime_common(clock, &ts);
 
-	if (ret == 0) {
+	if (unlikely(ret))
+		ret = clock_gettime_fallback(clock, &ts);
+
+	if (likely(!ret)) {
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}
@@ -163,17 +174,18 @@ static __maybe_unused time_t __cvdso_time(time_t *time)
 
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
@@ -195,16 +207,22 @@ int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 		 */
 		ns = hrtimer_res;
 	} else {
-		goto fallback;
+		return -1;
 	}
 
 	res->tv_sec = 0;
 	res->tv_nsec = ns;
 
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
@@ -213,13 +231,14 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 	struct __kernel_timespec ts;
 	int ret;
 
-	ret = __cvdso_clock_getres(clock, &ts);
+	ret = __cvdso_clock_getres_common(clock, &ts);
+	if (unlikely(ret))
+		ret = clock_getres_fallback(clock, &ts);
 
-	if (ret == 0) {
+	if (likely(!ret)) {
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}
-
 	return ret;
 }
 #endif /* VDSO_HAS_CLOCK_GETRES */
