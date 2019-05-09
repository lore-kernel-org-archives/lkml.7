Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34491C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E882173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="WY8l8dc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfEIFyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 01:54:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35025 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEIFyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 01:54:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id h1so626940pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 22:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MOdd8WODSKAcoIO4YQx/Lh3fMGICrMESlcX7S3xlaIE=;
        b=WY8l8dc+g75Z1nXPaySHYzrv10cvaRv3g6XT1/Gx8dYFZKef/lQ1660+F+N0yDkIkV
         puVThSfQ2h7u3N3gXrgxcybLClNd73qlaCSNweokDlVX66bFIendMuM3qsh/2+g9IkPH
         MMeec0AYchWDJftg8XRwKfTCxU0PVULzf5bUnZWhaeTyDewBJiAHf1F1Ak2aGn5cTpVv
         bEq0Gk7IkGVaAo2qaNQxh8yG4PxBmW/lspWVIZHNiqDFrkOmzlXG1ybDksvqgSY9xJwq
         pfyBkrnOeduhnQ7buQ5QvAPNjHGIqfXAboBP5R8Jtcipr3qA1w50GXP+Dwcptc0WBVV/
         BpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MOdd8WODSKAcoIO4YQx/Lh3fMGICrMESlcX7S3xlaIE=;
        b=oQZOQodyPVQDCRcFV2RnNvXCwQT4FkbE8UX7w1jDMn+uaGU8PhH+/2bBJj1/FdVqDJ
         jyvWpcuKHiwwPgrVjvmhHqiHXQtkzphWFuBO+u3grnPYSrzaUICqkL36Uj30kamwk7ic
         LW00EigcHxEawqxKyfQPbiUReI5hRtneb4Sl1EQy6Y6YUX2se8c41+2C3CZEDFSKRYma
         3QIo92TcwcoPwfQRqfnwAPNsL92lQypVaJkl4pl2SLn8AecxyOiMr8BIyEI0CsKOBkdP
         CIBzs5kIgLHV09WkYaFK19zW88Epvv/3zU4CNPDFRmws5OpdCPuVcrulJC7usknlmOfI
         EuOw==
X-Gm-Message-State: APjAAAWgbsURtwZxfUL3nygWAwrSJOanGLa9pp4ae4+TSIrsGlpz0TEE
        Anwp4gqyWPHLTNMm+alH1KStUA==
X-Google-Smtp-Source: APXvYqwl6cBbjrCiiyFAlij5R8mG1qr4uX+A/6IpQ1mLq9cK6GeJ5adK0ex8ZUHucBoei8MQw97Iew==
X-Received: by 2002:a63:cf54:: with SMTP id b20mr3082109pgj.307.1557381270963;
        Wed, 08 May 2019 22:54:30 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id f20sm1363137pff.176.2019.05.08.22.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 22:54:30 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, rafael.j.wysocki@intel.com,
        linux@endlessm.com, peterz@infradead.org
Subject: [PATCH v2 3/3] x86/tsc: set LAPIC timer period to crystal clock frequency
Date:   Thu,  9 May 2019 13:54:17 +0800
Message-Id: <20190509055417.13152-3-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509055417.13152-1-drake@endlessm.com>
References: <20190509055417.13152-1-drake@endlessm.com>
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

Set lapic_timer_period based on the crystal clock frequency
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

Notes:
    v2:
     - remove unnecessary braces
     - use newly renamed variable lapic_timer_period

 arch/x86/kernel/tsc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6e6d933fb99c..8f47c4862c56 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -671,6 +671,16 @@ unsigned long native_calibrate_tsc(void)
 	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * The local APIC appears to be fed by the core crystal clock
+	 * (which sounds entirely sensible). We can set the global
+	 * lapic_timer_period here to avoid having to calibrate the APIC
+	 * timer later.
+	 */
+	lapic_timer_period = crystal_khz * 1000 / HZ;
+#endif
+
 	return crystal_khz * ebx_numerator / eax_denominator;
 }
 
-- 
2.20.1

