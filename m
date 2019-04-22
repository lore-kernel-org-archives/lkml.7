Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBCAC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A293206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="rTI3RgfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfDVKPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:15:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46892 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDVKPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:15:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id o7so3368574pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bysn7oCINEeNZ6Dh0Nin7SdC/vAmDSm2VxRgeqEpdAw=;
        b=rTI3RgfX95HQ7/JKW25ztsnjljOUjNeiJli3HFDyslB3wkJ6Y2RSdfUQlQSx7lMBAa
         XXGwg66bl0aM6F6DhOoTan+5qtLzpliYqnkPB+jizIXcNzAN5oi6SxCnGdAX+EFded5p
         mn1sl6zxk4r6IcEOlNnbcyzqhx0Wjzb5pPBv3EbDJtJKQ5Nf2NHjVczGt+cFMH2Kkq1P
         vsYoXEsWtLuPIdW3xGcdQ84/ZtBmXQQwFV9Y9tPNCC1SB4Jgm+JiclRH29NZ9pXLY+QB
         CdUAcMcIEnBnr1vSnTQoBcG5I94nhHs4+b5+7F6m8Iy3IiZnUm1lGXXRjh0H0QT61q+R
         CJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bysn7oCINEeNZ6Dh0Nin7SdC/vAmDSm2VxRgeqEpdAw=;
        b=KxyZZskOUlKD3d8OgLvopXu8cgPOTHWR741IjybEd6fzZvaksAPQHRnR9SpRUOm82r
         2vvlnVKTrCE+l5raE73iJC4lMYQOetSoiSgrEI1LEJ6P6qpyAIWVssg+A1Oe0L3HfeBa
         UGgcfpmjS9dl1QjgFeMsMH4jcU9XUQ7C8Eu6fZLaseZNuqbAqB/clcwuoSFnZY/xNCVK
         ZIpiRuGpCsZ5NSExR5yDRSr/UFMaSyeBOvfyv1GIY5J5cAfnXAKsFHk0USsACmzHKIOs
         mqNnlTmfqvidvxB43WNLgeXcbXR9YhUAbF5fyDKE7LZCWCEYfTWuT0vWApivcJsAtClX
         fN3g==
X-Gm-Message-State: APjAAAVEWsA+7hqgpqO7l3VS24oKphaMHNv7DV7iY0/40YD/RhI31frw
        D5+irPTQXceEozwqGdHFzpyoFQ==
X-Google-Smtp-Source: APXvYqzk3h3q4TvQCl4IB3sJIhbnpPZzjb41i3hPVMPnQveWLjme7RWwxbpMFRYf3kxI/JK8oIcqig==
X-Received: by 2002:a17:902:b481:: with SMTP id y1mr19610914plr.161.1555928132423;
        Mon, 22 Apr 2019 03:15:32 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id 128sm14945573pgb.47.2019.04.22.03.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 03:15:31 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, rafael.j.wysocki@intel.com, linux@endlessm.com
Subject: [PATCH 1/2] x86/tsc: use CPUID.0x16 to calculate missing crystal frequency
Date:   Mon, 22 Apr 2019 18:15:25 +0800
Message-Id: <20190422101526.28415-1-drake@endlessm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

native_calibrate_tsc() had a hardcoded table of Intel CPU families
and crystal clock, but we have found that it is possible to
calculate the crystal clock speed, and this is preferred to a hardcoded
table.

Where crystal clock frequency was not reported by CPUID.0x15,
use CPUID.0x16 data to calculate the crystal clock.

Using CPUID dump data from http://instlatx64.atw.hu/, the calculation
results can be seen to be sufficiently close to the previously hardcoded
values:
SKYLAKE_MOBILE: 24074074 Hz
SKYLAKE_DESKTOP: 23913043 Hz
KABYLAKE_MOBILE: 23893805 Hz
KABYLAKE_DESKTOP: 24050632 Hz
GOLDMONT: 19.2MHz crystal clock correctly reported by CPUID.0x15

Additionally, crystal clock frequency for platforms that were missing
from the list (e.g. SKYLAKE_X) will now be provided.

GOLDMONT_X was left as a hardcoded value, as the CPUID data on that site
indicates that the hardware does not report crystal clock nor CPUID.0x16
data.

Going forward, Intel have hopefully now started providing crystal
frequency in CPUID.0x15. At least ApolloLake, GeminiLake and CannonLake
CPUs all provide the relevant data directly.

Link: https://lkml.kernel.org/r/20190419083533.32388-1-drake@endlessm.com
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 arch/x86/kernel/tsc.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3fae23834069..3971c837584a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -629,23 +629,26 @@ unsigned long native_calibrate_tsc(void)
 
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
+	/*
+	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
+	 * clock, but we can easily calculate it by considering the crystal
+	 * ratio and the CPU speed.
+	 */
+	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= 0x16) {
+		unsigned int eax_base_mhz, ebx, ecx, edx;
+		cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
+		crystal_khz = eax_base_mhz * 1000 * \
+			eax_denominator / ebx_numerator;
 	}
 
+	/*
+	 * Denverton SoCs don't report crystal clock, and also don't support
+	 * CPUID.0x16, so hardcode the 25MHz crystal clock.
+	 */
+	if (crystal_khz == 0 &&
+			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_X)
+		crystal_khz = 25000;
+
 	if (crystal_khz == 0)
 		return 0;
 	/*
-- 
2.19.1

