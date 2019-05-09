Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B18DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFE9216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="bbFlrxFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEIFyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 01:54:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33412 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEIFyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 01:54:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so722315pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 22:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyoriVMIilTeJ9qFpR6AU4DWacDTYEkqJme7/MxnVqg=;
        b=bbFlrxFYylFXUH5ZVeD6MYXyaFIdK+gVBVe+gfkSRidRYbDhicWM49Y/QrJRf8haYP
         Ataz1DsFGwFCLfELOnmvl00Ms6iR26Yp+aUUarVlWYz/ha1u6HPFM6xrKL5MDRz2unna
         KNPjMy0Zi1ZqKnjEkPI3OcbScAE3Nm6IEQUrOtoTsptqMX1namJuj0xKY5qpXB8HxWEU
         2M8HFtfjtNQLuuM8J2VAxSmMcJ21cvFLmS7jaucXvACmNswDtq1zXVdcQHekiZxo7Trp
         OlizbT7t8VFKyARiFE+vqVLPSwPDZvda7A1joUFIF/YzqpLWYpXzdgFwi/mQ8uzLjOLA
         7TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyoriVMIilTeJ9qFpR6AU4DWacDTYEkqJme7/MxnVqg=;
        b=i/zD9s9SeWUZQorz3DVs2vik+1p/I7118neUNHx1mAQgfjg5sca7FVtkuJW9BqzNj+
         bb94CG5TUR95GZr8wBqVGIxB5Yk28Zg/0YsWsJ6Yzuk2WO9JRAkdjV90ztAb5ZqTwSFe
         lek47FxOeE9DIQM9suAHcMzJdTvAtMReiW+K0rWxfNHCRby5mgVvgSQHjqF+1gkJlLHC
         741w475r56KKcO07RkcPjjhPm4xX9JRl9llIXx4Glo7dCZcRlL/qDZC3veXMTxFY0hJl
         MEK1SafPC8M/rwGRrPvPVnr7p0txRTB1v7C7+jidXmHZtDp50tblIN2P84RMbybO1itt
         jcuw==
X-Gm-Message-State: APjAAAXsqgbWo17AILlrF16qdwXbxPYNt+kVWikdB+d3TlLR/y0tZge0
        gNp82EA4Avpv2xvmDrRi9uDXGA==
X-Google-Smtp-Source: APXvYqxdmBN/lHsDvX6PGNtCQWDni9gx70ciWVTNJGJX9FO/ZuzKDfvfQ5f8fc0IdJFPM02/VoJjIA==
X-Received: by 2002:a62:6c88:: with SMTP id h130mr2573755pfc.106.1557381263835;
        Wed, 08 May 2019 22:54:23 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id f20sm1363137pff.176.2019.05.08.22.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 22:54:22 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, rafael.j.wysocki@intel.com,
        linux@endlessm.com, peterz@infradead.org
Subject: [PATCH v2 1/3] x86/tsc: use CPUID.0x16 to calculate missing crystal frequency
Date:   Thu,  9 May 2019 13:54:15 +0800
Message-Id: <20190509055417.13152-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

native_calibrate_tsc() had a data mapping Intel CPU families
and crystal clock speed, but hardcoded tables are not ideal, and this
approach was already problematic at least in the Skylake X case, as
seen in commit b51120309348 ("x86/tsc: Fix erroneous TSC rate on Skylake
Xeon").

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

Link: https://lkml.kernel.org/r/20190419083533.32388-1-drake@endlessm.com
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---

Notes:
    v2:
     - Clarify the situation around Skylake X better.
     - Enable TSC refinement when we had to calculate the crystal clock,
       in case slight differences in the calculation result cause problems
       similar to those reported earlier on Skylake X.

 arch/x86/kernel/tsc.c | 47 +++++++++++++++++++++++++------------------
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
-- 
2.20.1

