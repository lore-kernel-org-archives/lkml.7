Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A88BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB0520644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hiy8zBvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEIKe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:34:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55127 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEIKe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:34:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x49AY65T1505153
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 9 May 2019 03:34:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x49AY65T1505153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557398047;
        bh=SGWDjdrZbOS6ik55EpGhGZMAGYxk9ZssUnrt3S76Ke8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Hiy8zBvffJvfVcrgh08DBov3gxzctNVTEtExdce9eMG2hFg0Ol5A2MVETAHg1G4Kf
         7RPcjxJibQkloSx1S1dxZAIc7J+e9+uaTlF2GWzfKerP5YaunYVHGH57aPCuzJw1ON
         RGal+s4qi7G7xZXepUSXBZ6hwNdqN7L03kI8GFmaeJx5tWEj1z1TDcdWHVfkGg5qTP
         rkZxeY2cPN2nN96lQCPAreXypgP+CBFRnsMwEDpfc/dJmHQh+1YJPFgd56BdvtvJzN
         SZ5VmHygAll5bLMgm8XXwcZVAqdMvcnwEfoSDbWcuqHvs6sHk+wYOSjby96AsUh3J+
         DsA/5/HAHBnrg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x49AY6pS1505150;
        Thu, 9 May 2019 03:34:06 -0700
Date:   Thu, 9 May 2019 03:34:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Drake <tipbot@zytor.com>
Message-ID: <tip-604dc9170f2435d27da5039a3efd757dceadc684@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        drake@endlessm.com, torvalds@linux-foundation.org, luto@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, bp@alien8.de
Reply-To: hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
          drake@endlessm.com, torvalds@linux-foundation.org,
          luto@kernel.org
In-Reply-To: <20190419083533.32388-1-drake@endlessm.com>
References: <20190509055417.13152-1-drake@endlessm.com>
        <20190419083533.32388-1-drake@endlessm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/tsc: Use CPUID.0x16 to calculate missing crystal
 frequency
Git-Commit-ID: 604dc9170f2435d27da5039a3efd757dceadc684
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

Commit-ID:  604dc9170f2435d27da5039a3efd757dceadc684
Gitweb:     https://git.kernel.org/tip/604dc9170f2435d27da5039a3efd757dceadc684
Author:     Daniel Drake <drake@endlessm.com>
AuthorDate: Thu, 9 May 2019 13:54:15 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 9 May 2019 11:06:48 +0200

x86/tsc: Use CPUID.0x16 to calculate missing crystal frequency

native_calibrate_tsc() had a data mapping Intel CPU families
and crystal clock speed, but hardcoded tables are not ideal, and this
approach was already problematic at least in the Skylake X case, as
seen in commit:

  b51120309348 ("x86/tsc: Fix erroneous TSC rate on Skylake Xeon")

By examining CPUID data from http://instlatx64.atw.hu/ and units
in the lab, we have found that 3 different scenarios need to be dealt
with, and we can eliminate most of the hardcoded data using an approach a
little more advanced than before:

 1. ApolloLake, GeminiLake, CannonLake (and presumably all new chipsets
    from this point) report the crystal frequency directly via CPUID.0x15.
    That's definitive data that we can rely upon.

 2. Skylake, Kabylake and all variants of those two chipsets report a
    crystal frequency of zero, however we can calculate the crystal clock
    speed by condidering data from CPUID.0x16.

    This method correctly distinguishes between the two crystal clock
    frequencies present on different Skylake X variants that caused
    headaches before.

    As the calculations do not quite match the previously-hardcoded values
    in some cases (e.g. 23913043Hz instead of 24MHz), TSC refinement is
    enabled on all platforms where we had to calculate the crystal
    frequency in this way.

 3. Denverton (GOLDMONT_X) reports a crystal frequency of zero and does
    not support CPUID.0x16, so we leave this entry hardcoded.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: len.brown@intel.com
Cc: linux@endlessm.com
Cc: rafael.j.wysocki@intel.com
Link: http://lkml.kernel.org/r/20190509055417.13152-1-drake@endlessm.com
Link: https://lkml.kernel.org/r/20190419083533.32388-1-drake@endlessm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/tsc.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15b5e98a86f9..6e6d933fb99c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -631,31 +631,38 @@ unsigned long native_calibrate_tsc(void)
 
 	crystal_khz = ecx_hz / 1000;
 
-	if (crystal_khz == 0) {
-		switch (boot_cpu_data.x86_model) {
-		case INTEL_FAM6_SKYLAKE_MOBILE:
-		case INTEL_FAM6_SKYLAKE_DESKTOP:
-		case INTEL_FAM6_KABYLAKE_MOBILE:
-		case INTEL_FAM6_KABYLAKE_DESKTOP:
-			crystal_khz = 24000;	/* 24.0 MHz */
-			break;
-		case INTEL_FAM6_ATOM_GOLDMONT_X:
-			crystal_khz = 25000;	/* 25.0 MHz */
-			break;
-		case INTEL_FAM6_ATOM_GOLDMONT:
-			crystal_khz = 19200;	/* 19.2 MHz */
-			break;
-		}
-	}
+	/*
+	 * Denverton SoCs don't report crystal clock, and also don't support
+	 * CPUID.0x16 for the calculation below, so hardcode the 25MHz crystal
+	 * clock.
+	 */
+	if (crystal_khz == 0 &&
+			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_X)
+		crystal_khz = 25000;
 
-	if (crystal_khz == 0)
-		return 0;
 	/*
-	 * TSC frequency determined by CPUID is a "hardware reported"
+	 * TSC frequency reported directly by CPUID is a "hardware reported"
 	 * frequency and is the most accurate one so far we have. This
 	 * is considered a known frequency.
 	 */
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	if (crystal_khz != 0)
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
+	/*
+	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
+	 * clock, but we can easily calculate it to a high degree of accuracy
+	 * by considering the crystal ratio and the CPU speed.
+	 */
+	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= 0x16) {
+		unsigned int eax_base_mhz, ebx, ecx, edx;
+
+		cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
+		crystal_khz = eax_base_mhz * 1000 *
+			eax_denominator / ebx_numerator;
+	}
+
+	if (crystal_khz == 0)
+		return 0;
 
 	/*
 	 * For Atom SoCs TSC is the only reliable clocksource.
