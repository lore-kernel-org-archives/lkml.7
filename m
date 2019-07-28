Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F478C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D90216B7
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfG1NUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:20:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfG1NUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:20:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrj6T-0003q3-Kc; Sun, 28 Jul 2019 15:20:45 +0200
Message-Id: <20190728131648.879156507@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 28 Jul 2019 15:12:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: [patch 4/5] x86/vdso/32: Use 32bit syscall fallback
References: <20190728131251.622415456@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
seccomp setups because these syscalls might be not (yet) allowed.

Implement the 32bit variants which use the legacy syscalls and select the
variant in the core library.

The 64bit time variants are not removed because they are required for the
time64 based vdso accessors.

Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reported-by: Paul Bolle <pebolle@tiscali.nl>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Fixes: 7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/vdso/gettimeofday.h |   36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -96,6 +96,8 @@ long clock_getres_fallback(clockid_t _cl
 
 #else
 
+#define VDSO_HAS_32BIT_FALLBACK	1
+
 static __always_inline
 long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
@@ -114,6 +116,23 @@ long clock_gettime_fallback(clockid_t _c
 }
 
 static __always_inline
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
+static __always_inline
 long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 			   struct timezone *_tz)
 {
@@ -146,6 +165,23 @@ clock_getres_fallback(clockid_t _clkid,
 		: "edx");
 
 	return ret;
+}
+
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
 }
 
 #endif


