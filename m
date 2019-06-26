Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D984C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9962146E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AaiMosiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfFZMiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:38:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53899 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:38:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QCcFFv4104794
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 05:38:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QCcFFv4104794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561552695;
        bh=XEYCA3vQc6FHmSM/ghRpCRXb5lwdekWXabaFoToGNeE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AaiMosiZgJBkcuzlJ7XXUKaUb3XjqZTv1kOGYqYvVEYwis+8PN/2FIRJxaEPIKO8T
         KnCr92vtEsaQGjTf9SAJYicI8OwVb5u0wpmBi12vCXh/FuJgS2vP/SzQDkK+FVPV45
         UBCWJTTHHekO/cucAPCau7ecTaSo65HhteqWkL8RnLcvmmy7JWzyIiz2VBK71d/9et
         RZbww2ZleuLx/IJe9D9JWY7ut+bQ20ddBNHKLliuPS94qcJWT7cOVLSlDBT89yBSYg
         iRZm344fpRSX1/B94cPODBKQqfa67nJircPxmVL9MZUtRHG7/rVxXadYPCmP7YdTnQ
         m7DJUSqzvQvPw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QCcEoW4104791;
        Wed, 26 Jun 2019 05:38:14 -0700
Date:   Wed, 26 Jun 2019 05:38:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-27e11a9fe2e2e7e0d13f854e89a71e488678fb17@git.kernel.org>
Cc:     will.deacon@arm.com, vincenzo.frascino@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: catalin.marinas@arm.com, will.deacon@arm.com, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, vincenzo.frascino@arm.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190625161804.38713-2-vincenzo.frascino@arm.com>
References: <20190625161804.38713-2-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: Fix __arch_get_hw_counter() implementation
Git-Commit-ID: 27e11a9fe2e2e7e0d13f854e89a71e488678fb17
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

Commit-ID:  27e11a9fe2e2e7e0d13f854e89a71e488678fb17
Gitweb:     https://git.kernel.org/tip/27e11a9fe2e2e7e0d13f854e89a71e488678fb17
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Tue, 25 Jun 2019 17:18:03 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 14:26:54 +0200

arm64: Fix __arch_get_hw_counter() implementation

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
Link: https://lkml.kernel.org/r/20190625161804.38713-2-vincenzo.frascino@arm.com

---
 arch/arm64/include/asm/vdso/gettimeofday.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index 447ef417de45..b08f476b72b4 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -10,6 +10,8 @@
 #include <asm/unistd.h>
 #include <uapi/linux/time.h>
 
+#define __VDSO_USE_SYSCALL		ULLONG_MAX
+
 #define VDSO_HAS_CLOCK_GETRES		1
 
 static __always_inline
@@ -68,7 +70,24 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
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
+	isb();
 	asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
+	/*
+	 * This isb() is required to prevent that the seq lock is
+	 * speculated.#
+	 */
+	isb();
 
 	return res;
 }
