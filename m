Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D6CC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA26205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Pk7vKXuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfG3WVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:21:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387946AbfG3WVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:21:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMLPl43400272
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:21:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMLPl43400272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564525286;
        bh=tkduzWFyZDtoSbRpU8Yr6l62nulF82JXTiAwpJF189o=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Pk7vKXuq7U+69fapLpMymmDIKWeW3bfA+1uBCw3LZvznUT+Q7dFBFdv7QiqYWRVj0
         ZCAwHhcEPYDQyOVo8piyhT2y1YDGodK5M6ot/RhANOQhTfv08NbemiUJVIo+wLQYTa
         MK4Pgw8NbXsb4pGFmRULpX1yeNI/+6FRzoe+ZBUbeEALkb2wwGPPhVizP9Q12Qxmx+
         BHY0tOYYcccrF02q/6nsR9uz/PsjMx4p1D8mQX8P+PrCN9B3Gw+Khmc7l5EtLg/5e4
         MS7Xa0gxAeXkbJJkkDL/qVCHuEy7BKs9P8QYj9MZ9zANF57JLJmKwjADFOmr3vdP1n
         qvQi9L1Go8n2A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMLO0I3400269;
        Tue, 30 Jul 2019 15:21:24 -0700
Date:   Tue, 30 Jul 2019 15:21:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-d2f5d3fa26196183adb44a413c44caa9872275b4@git.kernel.org>
Cc:     luto@kernel.org, mingo@kernel.org, sean.j.christopherson@intel.com,
        tglx@linutronix.de, vincenzo.frascino@arm.com, pebolle@tiscali.nl,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: vincenzo.frascino@arm.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, pebolle@tiscali.nl,
          luto@kernel.org, sean.j.christopherson@intel.com,
          mingo@kernel.org
In-Reply-To: <20190728131648.879156507@linutronix.de>
References: <20190728131648.879156507@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] x86/vdso/32: Use 32bit syscall fallback
Git-Commit-ID: d2f5d3fa26196183adb44a413c44caa9872275b4
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

Commit-ID:  d2f5d3fa26196183adb44a413c44caa9872275b4
Gitweb:     https://git.kernel.org/tip/d2f5d3fa26196183adb44a413c44caa9872275b4
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 28 Jul 2019 15:12:55 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 31 Jul 2019 00:09:10 +0200

x86/vdso/32: Use 32bit syscall fallback

The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
seccomp setups because these syscalls might be not (yet) allowed.

Implement the 32bit variants which use the legacy syscalls and select the
variant in the core library.

The 64bit time variants are not removed because they are required for the
time64 based vdso accessors.

Fixes: 7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reported-by: Paul Bolle <pebolle@tiscali.nl>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20190728131648.879156507@linutronix.de

---
 arch/x86/include/asm/vdso/gettimeofday.h | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

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
