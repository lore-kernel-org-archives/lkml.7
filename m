Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7A7C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDA42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="crroid2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfFZMjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:39:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFZMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:39:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QCd1tc4104848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 05:39:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QCd1tc4104848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561552741;
        bh=dAaEZGvy9qdqJmr0mW2LtwUrDRbyw+2VWaF0BtcV8To=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=crroid2Dgj22+BpkZWbHE/qlKaaN/lssiG1by/i8iKQFgik50YrUecVCxa10acRqj
         NHLBAAb7/duOz0J7yiEuYxJehMBlLDYruBo/jLm/cLw4wVPwo0gbmgu6CpZBjncWdt
         qU1jTdzerwNhEVywc2uVD6qVXVFxq0vxWz341fCN8ni2EBJy+AmBwMqEV72OS4MyyI
         m3rQzF6p7KLliH6GqSdY0Fhz70NOZgs7r63BZHe8YR4lv/yRzwvREEKRro33S6tcco
         4pX6JA9w1a3xJ4XEfoDgCAGVbiukBfD5zhhnYxthykxqx+NkhcqsJWyBIYUcPYQB8l
         +pSz4+RYgfvhA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QCd0US4104845;
        Wed, 26 Jun 2019 05:39:00 -0700
Date:   Wed, 26 Jun 2019 05:39:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-6241c4dc6ec56a7627b972959da8b492b765b209@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        tglx@linutronix.de, vincenzo.frascino@arm.com, mingo@kernel.org,
        hpa@zytor.com, will.deacon@arm.com
Reply-To: hpa@zytor.com, will.deacon@arm.com, mingo@kernel.org,
          tglx@linutronix.de, vincenzo.frascino@arm.com,
          linux-kernel@vger.kernel.org, catalin.marinas@arm.com
In-Reply-To: <20190625161804.38713-3-vincenzo.frascino@arm.com>
References: <20190625161804.38713-3-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: compat: Fix __arch_get_hw_counter()
 implementation
Git-Commit-ID: 6241c4dc6ec56a7627b972959da8b492b765b209
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

Commit-ID:  6241c4dc6ec56a7627b972959da8b492b765b209
Gitweb:     https://git.kernel.org/tip/6241c4dc6ec56a7627b972959da8b492b765b209
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Tue, 25 Jun 2019 17:18:04 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 14:26:54 +0200

arm64: compat: Fix __arch_get_hw_counter() implementation

Provide the following fixes for the __arch_get_hw_counter()
implementation on arm64:
- Fallback on syscall when an unstable counter is detected.
- Introduce isb()s before and after the counter read to avoid
speculation of the counter value and of the seq lock
respectively.
The second isb() is a temporary solution that will be revisited
in 5.3-rc1.

These fixes restore the semantics that __arch_counter_get_cntvct()
had on arm64.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com
Cc: will.deacon@arm.com
Cc: arnd@arndb.de
Cc: linux@armlinux.org.uk
Cc: ralf@linux-mips.org
Cc: paul.burton@mips.com
Cc: daniel.lezcano@linaro.org
Cc: salyzyn@android.com
Cc: pcc@google.com
Cc: shuah@kernel.org
Cc: 0x7f454c46@gmail.com
Cc: linux@rasmusvillemoes.dk
Cc: huw@codeweavers.com
Cc: sthotton@marvell.com
Cc: andre.przywara@arm.com
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190625161804.38713-3-vincenzo.frascino@arm.com

---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 93dbd935b66d..f4812777f5c5 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -12,6 +12,8 @@
 
 #include <asm/vdso/compat_barrier.h>
 
+#define __VDSO_USE_SYSCALL		ULLONG_MAX
+
 #define VDSO_HAS_CLOCK_GETRES		1
 
 static __always_inline
@@ -74,8 +76,24 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 {
 	u64 res;
 
+	/*
+	 * clock_mode == 0 implies that vDSO are enabled otherwise
+	 * fallback on syscall.
+	 */
+	if (clock_mode)
+		return __VDSO_USE_SYSCALL;
+
+	/*
+	 * This isb() is required to prevent that the counter value
+	 * is speculated.
+	 */
 	isb();
 	asm volatile("mrrc p15, 1, %Q0, %R0, c14" : "=r" (res));
+	/*
+	 * This isb() is required to prevent that the seq lock is
+	 * speculated.
+	 */
+	isb();
 
 	return res;
 }
