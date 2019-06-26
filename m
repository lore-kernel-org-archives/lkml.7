Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A5FC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEE220645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KEVJVxh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFZMhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:37:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfFZMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:37:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QCbTAa4104723
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 05:37:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QCbTAa4104723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561552649;
        bh=qQ+/p+74nR/3MSLJYovBwBXHOcKhgV8JSEvpJjbn8TY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KEVJVxh4DR0ljHmNOwFVBEpljRoFQmnn+cHh6sL1aaWaVpqecik4b9fPMn3row3aZ
         gNPzBC3zq7qQVOfdaoHdAll6noLvf7A5s/vqc+BUuL5cchkxQfDVCLbSai1111pDPO
         Upt3/V6e6ty3DaPrQEhs3niNfIP7ls8N2ykSBoO9odHsDASYlTCV8EGlsblUrxwaz3
         WuCeBxfhCrBoIbEvB20vyYmNJUytpNWdH98uacd6Njq9Ku66s1Z3VKEVXIR2Wm+7HE
         w/yrc0d0GuPg6BZ/9JV9GUevNocC8GygdPKPv3gUQUcvINT5Oc5yDPXuGQE0yh/7yv
         vB+Ow26O5JO4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QCbS8I4104720;
        Wed, 26 Jun 2019 05:37:28 -0700
Date:   Wed, 26 Jun 2019 05:37:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-9d90b93bf325e015bbae31b83f16da5e4e17effa@git.kernel.org>
Cc:     hpa@zytor.com, vincenzo.frascino@arm.com, tglx@linutronix.de,
        mingo@kernel.org, linux-arm-kernel@lists.infradead.org,
        daniel.lezcano@linaro.org, arnd@arndb.de, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, ralf@linux-mips.org
Reply-To: hpa@zytor.com, vincenzo.frascino@arm.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
          daniel.lezcano@linaro.org, will.deacon@arm.com,
          ralf@linux-mips.org, luto@kernel.org
In-Reply-To: <alpine.DEB.2.21.1906261159230.32342@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1906261159230.32342@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] lib/vdso: Make delta calculation work correctly
Git-Commit-ID: 9d90b93bf325e015bbae31b83f16da5e4e17effa
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

Commit-ID:  9d90b93bf325e015bbae31b83f16da5e4e17effa
Gitweb:     https://git.kernel.org/tip/9d90b93bf325e015bbae31b83f16da5e4e17effa
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 26 Jun 2019 12:02:00 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 14:26:53 +0200

lib/vdso: Make delta calculation work correctly

The x86 vdso implementation on which the generic vdso library is based on
has subtle (unfortunately undocumented) twists:

 1) The code assumes that the clocksource mask is U64_MAX which means that
    no bits are masked. Which is true for any valid x86 VDSO clocksource.
    Stupidly it still did the mask operation for no reason and at the wrong
    place right after reading the clocksource.

 2) It contains a sanity check to catch the case where slightly
    unsynchronized TSC values can be observed which would cause the delta
    calculation to make a huge jump. It therefore checks whether the
    current TSC value is larger than the value on which the current
    conversion is based on. If it's not larger the base value is used to
    prevent time jumps.

#1 Is not only stupid for the X86 case because it does the masking for no
reason it is also completely wrong for clocksources with a smaller mask
which can legitimately wrap around during a conversion period. The core
timekeeping code does it correct by applying the mask after the delta
calculation:

	(now - base) & mask

#2 is equally broken for clocksources which have smaller masks and can wrap
around during a conversion period because there the now > base check is
just wrong and causes stale time stamps and time going backwards issues.

Unbreak it by:

  1) Removing the mask operation from the clocksource read which makes the
     fallback detection work for all clocksources

  2) Replacing the conditional delta calculation with a overrideable inline
     function.

#2 could reuse clocksource_delta() from the timekeeping code but that
results in a significant performance hit for the x86 VSDO. The timekeeping
core code must have the non optimized version as it has to operate
correctly with clocksources which have smaller masks as well to handle the
case where TSC is discarded as timekeeper clocksource and replaced by HPET
or pmtimer. For the VDSO there is no replacement clocksource. If TSC is
unusable the syscall is enforced which does the right thing.

To accommodate to the needs of various architectures provide an
override-able inline function which defaults to the regular delta
calculation with masking:

	(now - base) & mask

Override it for x86 with the non-masking and checking version.

This unbreaks the ARM64 syscall fallback operation, allows to use
clocksources with arbitrary width and preserves the performance
optimization for x86.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: LAK <linux-arm-kernel@lists.infradead.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux@armlinux.org.uk
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: paul.burton@mips.com
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: salyzyn@android.com
Cc: pcc@google.com
Cc: shuah@kernel.org
Cc: 0x7f454c46@gmail.com
Cc: linux@rasmusvillemoes.dk
Cc: huw@codeweavers.com
Cc: sthotton@marvell.com
Cc: andre.przywara@arm.com
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1906261159230.32342@nanos.tec.linutronix.de

---
 arch/x86/include/asm/vdso/gettimeofday.h | 27 +++++++++++++++++++++++++++
 lib/vdso/gettimeofday.c                  | 19 +++++++++++++++----
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 5b63f1f78a1f..a14039a59abd 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -229,6 +229,33 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 	return __vdso_data;
 }
 
+/*
+ * x86 specific delta calculation.
+ *
+ * The regular implementation assumes that clocksource reads are globally
+ * monotonic. The TSC can be slightly off across sockets which can cause
+ * the regular delta calculation (@cycles - @last) to return a huge time
+ * jump.
+ *
+ * Therefore it needs to be verified that @cycles are greater than
+ * @last. If not then use @last, which is the base time of the current
+ * conversion period.
+ *
+ * This variant also removes the masking of the subtraction because the
+ * clocksource mask of all VDSO capable clocksources on x86 is U64_MAX
+ * which would result in a pointless operation. The compiler cannot
+ * optimize it away as the mask comes from the vdso data and is not compile
+ * time constant.
+ */
+static __always_inline
+u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+{
+	if (cycles > last)
+		return (cycles - last) * mult;
+	return 0;
+}
+#define vdso_calc_delta vdso_calc_delta
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index ef28cc5d7bff..2d1c1f241fd9 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -26,6 +26,18 @@
 #include <asm/vdso/gettimeofday.h>
 #endif /* ENABLE_COMPAT_VDSO */
 
+#ifndef vdso_calc_delta
+/*
+ * Default implementation which works for all sane clocksources. That
+ * obviously excludes x86/TSC.
+ */
+static __always_inline
+u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+{
+	return ((cycles - last) & mask) * mult;
+}
+#endif
+
 static int do_hres(const struct vdso_data *vd, clockid_t clk,
 		   struct __kernel_timespec *ts)
 {
@@ -35,14 +47,13 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 
 	do {
 		seq = vdso_read_begin(vd);
-		cycles = __arch_get_hw_counter(vd->clock_mode) &
-			vd->mask;
+		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
 		if (unlikely((s64)cycles < 0))
 			return clock_gettime_fallback(clk, ts);
-		if (cycles > last)
-			ns += (cycles - last) * vd->mult;
+
+		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
 		ns >>= vd->shift;
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
