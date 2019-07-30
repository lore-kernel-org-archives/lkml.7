Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC70C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D94B206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tw8voost"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388122AbfG3WWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:22:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53899 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbfG3WWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:22:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMMAhZ3400365
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:22:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMMAhZ3400365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564525331;
        bh=DnWhyBKaua3wh3UQ/jQ38IYE5gCixys6e9btLg496H0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tw8voostHl3Us3vK6P6gYHnRXi1ish3ZWWzZeh5lG3gUrH+G9Z+zyGCjKtqSrskEP
         ojRYHXTe0NawuCOWwb1szp4mrbCQsIHgoOXwXdoE0hkTCugdERv/TbL3jq5Eq65MVZ
         hUS3QMTkDPFwxSupUUOgUedBLH5Zb95D3Tr7Un0R+4KD4rX9AhspN72lT/QYjOl/iB
         8MuhPuO7q4UVvENHSbbJHH8I0cobmHcs7Kv8BTQ5FCWmvUfX+g1PgTPuLsLVpe3H6K
         vhZaZ8cZniXzxQq770G0A3pI85g7NXxYWs82WUI88qecOC+ZfChQllBsAFiDEAE1MZ
         9FHGX22KanXpQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMMAJc3400362;
        Tue, 30 Jul 2019 15:22:10 -0700
Date:   Tue, 30 Jul 2019 15:22:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-33a58980ff3cc5dbf0bb1b325746ac69223eda0b@git.kernel.org>
Cc:     pebolle@tiscali.nl, luto@kernel.org, hpa@zytor.com,
        vincenzo.frascino@arm.com, tglx@linutronix.de,
        sean.j.christopherson@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: pebolle@tiscali.nl, hpa@zytor.com, luto@kernel.org,
          tglx@linutronix.de, vincenzo.frascino@arm.com,
          sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20190728131648.971361611@linutronix.de>
References: <20190728131648.971361611@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] arm64: compat: vdso: Use legacy syscalls as
 fallback
Git-Commit-ID: 33a58980ff3cc5dbf0bb1b325746ac69223eda0b
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

Commit-ID:  33a58980ff3cc5dbf0bb1b325746ac69223eda0b
Gitweb:     https://git.kernel.org/tip/33a58980ff3cc5dbf0bb1b325746ac69223eda0b
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 28 Jul 2019 15:12:56 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 31 Jul 2019 00:09:10 +0200

arm64: compat: vdso: Use legacy syscalls as fallback

The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
seccomp setups because these syscalls might be not (yet) allowed.

Implement the 32bit variants which use the legacy syscalls and select the
variant in the core library.

The 64bit time variants are not removed because they are required for the
time64 based vdso accessors.

Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reported-by: Paul Bolle <pebolle@tiscali.nl>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/20190728131648.971361611@linutronix.de

---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

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
