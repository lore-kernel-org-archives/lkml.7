Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB8EC48BE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F4D22CEB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yD/hblzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfFXBlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfFXBk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNupjx2860305
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:56:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNupjx2860305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334212;
        bh=cU6U0DTDpzt3ITirMeTEFL0anIB+F/Sdmvp7TuSAZkc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yD/hblzZ86RHmH/i1/E9J/6kV/WgGChYHByBrVPwSRf5RaBWBsXLEzOtqT1glY58D
         P8G0qWTYlvNSR4B1Dsi9T0CPhm/zeFQQq1DNlkwRa9dSoQ6jWKTTWRq6wPgJlqeeC2
         bg11jqXxrfA5UORCI5bcXQ2lMO6T9hkxnyVe5fnjfXStK9lE+3XDisxXhurKo6RllX
         p0COtxe8lHBHQptYcPybfk4NaPis9UrUfyqzfi+A5NCyb3YVXih1OXW3+xeMpIt/0Y
         IOVn7WVrIJWm7kJpomRgi3xcZj8NsaweiPKSV+Y6vqcc8h+aXvDIeFOsswpvomrWon
         pmogFJiqyfIOg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNuokd2860302;
        Sun, 23 Jun 2019 16:56:50 -0700
Date:   Sun, 23 Jun 2019 16:56:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-22ca962288c0a1c9729e8e440b9bb9ad05df6db6@git.kernel.org>
Cc:     ralf@linux-mips.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux@rasmusvillemoes.dk, will.deacon@arm.com,
        0x7f454c46@gmail.com, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, andre.przywara@arm.com, daniel.lezcano@linaro.org,
        sthotton@marvell.com, vincenzo.frascino@arm.com, pcc@google.com,
        linux@armlinux.org.uk, salyzyn@android.com, paul.burton@mips.com,
        catalin.marinas@arm.com, huw@codeweavers.com
Reply-To: daniel.lezcano@linaro.org, sthotton@marvell.com,
          andre.przywara@arm.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, will.deacon@arm.com, 0x7f454c46@gmail.com,
          linux@rasmusvillemoes.dk, arnd@arndb.de, shuah@kernel.org,
          linux-kernel@vger.kernel.org, ralf@linux-mips.org,
          huw@codeweavers.com, paul.burton@mips.com,
          catalin.marinas@arm.com, salyzyn@android.com,
          linux@armlinux.org.uk, pcc@google.com, vincenzo.frascino@arm.com
In-Reply-To: <20190621095252.32307-25-vincenzo.frascino@arm.com>
References: <20190621095252.32307-25-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] x86/vdso: Add clock_gettime64() entry point
Git-Commit-ID: 22ca962288c0a1c9729e8e440b9bb9ad05df6db6
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

Commit-ID:  22ca962288c0a1c9729e8e440b9bb9ad05df6db6
Gitweb:     https://git.kernel.org/tip/22ca962288c0a1c9729e8e440b9bb9ad05df6db6
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:51 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:10 +0200

x86/vdso: Add clock_gettime64() entry point

Linux 5.1 gained the new clock_gettime64() syscall to address the Y2038
problem on 32bit systems. The x86 VDSO is missing support for this variant
of clock_gettime().

Update the x86 specific vDSO library accordingly so it exposes the new time
getter.

[ tglx: Massaged changelog ]

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
Link: https://lkml.kernel.org/r/20190621095252.32307-25-vincenzo.frascino@arm.com

---
 arch/x86/entry/vdso/vclock_gettime.c    | 8 ++++++++
 arch/x86/entry/vdso/vdso32/vdso32.lds.S | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 1a648b509d46..d9ff616bb0f6 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -67,6 +67,14 @@ int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 int clock_gettime(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int clock_gettime64(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime64")));
+
 int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
 {
 	return __cvdso_clock_getres_time32(clock, res);
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index 991b26cc855b..c7720995ab1a 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -27,6 +27,7 @@ VERSION
 		__vdso_gettimeofday;
 		__vdso_time;
 		__vdso_clock_getres;
+		__vdso_clock_gettime64;
 	};
 
 	LINUX_2.5 {
