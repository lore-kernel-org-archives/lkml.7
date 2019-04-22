Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5CFC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E56218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Kkb+yrDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDVKPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:15:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40365 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDVKPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:15:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so5655646pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AW0RHnKDHLN5TiGDQiHCeAcpbvq/vomWqBQhSmgvJvQ=;
        b=Kkb+yrDo+VEZf2FB+y89KhJXl9wWj6MbvGDKg33LzHICLayfTU9bakJvDN4LBTKOsu
         w1hSHonmbHdUmhCb8XsrD2TRxTlI0c6shQ+WTnS2jdgEsV1OEkYUv7+EOxOMjitLWNr5
         DxQntt50I9ButDcsY70fuGhMv5A5goTs1692sOUTcAce4jVOxo0N/qRLQd50dR/eD99j
         MzsQzV9PLT3QeVbGJZKaMpOyuDu2npOYFso78q6srpe67ZAfILGp/dN0/3wLcYN4KAHR
         l4pPZrxHaZWoBJM8jvvsJr4wZHMp+gp/Yvpxti3qafzpR3VIz9lBLE4LL1NvL4RQdnfe
         q1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AW0RHnKDHLN5TiGDQiHCeAcpbvq/vomWqBQhSmgvJvQ=;
        b=h24jSHnrhQ1q9yYLR8iWYk0zrsKET9jmibvTbFkLVX0iKbO979jLsNwi3J2WjD395N
         3R9CGnWH6gTMAlnbivqW89m2DKafc1aDkatppXEcUKN9QQS+B/MRZsniiLM5WKS0QNt0
         HYpHFDtM+2b17hDkpIFqRXzpbd+2xKW4FoK6b+E0IFbc1DFxaoUeywcXzI5NF/MisRNA
         2AqvsBV4TWbslAMj9KakBfJGYf0U3buHhjXs+k1n8ieTjcxICZ8cNlYuWSA7TRR0zWLv
         BZBiCeJ+iiSWSym6CKNq42Sn5pj/3aMkoo2XKiqunauQvF7XykmQcyfO2r8nsWECtDVc
         EpOw==
X-Gm-Message-State: APjAAAVCJDZsCrpe9cGcGbMp6/WOEd8cr1YE6i4S5XjkBRHCk9jIs4Q0
        VCGhE4H8CcSKftLZgRbh5hsjow==
X-Google-Smtp-Source: APXvYqw/jhhvtT9s+xrkM4w8A/k+a1WVd0RLgwa4rcTuB3OV9xDMLIjXufTu06bzaY1Uuc4MBU1Ouw==
X-Received: by 2002:a63:2c4a:: with SMTP id s71mr18070680pgs.373.1555928135116;
        Mon, 22 Apr 2019 03:15:35 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id 128sm14945573pgb.47.2019.04.22.03.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 03:15:34 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, rafael.j.wysocki@intel.com, linux@endlessm.com
Subject: [PATCH 2/2] x86/tsc: set LAPIC timer frequency to crystal clock frequency
Date:   Mon, 22 Apr 2019 18:15:26 +0800
Message-Id: <20190422101526.28415-2-drake@endlessm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422101526.28415-1-drake@endlessm.com>
References: <20190422101526.28415-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APIC timer calibration (calibrate_APIC_timer()) can be skipped
in cases where we know the APIC timer frequency. On Intel SoCs,
we believe that the APIC is fed by the crystal clock; this would make
sense, and the crystal clock frequency has been verified against the
APIC timer calibration result on ApolloLake, GeminiLake, Kabylake,
CoffeeLake, WhiskeyLake and AmberLake.

Set lapic_timer_frequency based on the crystal clock frequency
accordingly.

APIC timer calibration would normally be skipped on modern CPUs
by nature of the TSC deadline timer being used instead,
however this change is still potentially useful, e.g. if the
TSC deadline timer has been disabled with a kernel parameter.
calibrate_APIC_timer() uses the legacy timer, but we are seeing
new platforms that omit such legacy functionality, so avoiding
such codepaths is becoming more important.

Link: https://lkml.kernel.org/r/20190419083533.32388-1-drake@endlessm.com
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 arch/x86/kernel/tsc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3971c837584a..8750543287fc 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -665,6 +665,16 @@ unsigned long native_calibrate_tsc(void)
 	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * The local APIC appears to be fed by the core crystal clock
+	 * (which sounds entirely sensible). We can set the global
+	 * lapic_timer_frequency here to avoid having to calibrate the APIC
+	 * timer later.
+	 */
+	lapic_timer_frequency = (crystal_khz * 1000) / HZ;
+#endif
+
 	return crystal_khz * ebx_numerator / eax_denominator;
 }
 
-- 
2.19.1

