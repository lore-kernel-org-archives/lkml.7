Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74C4C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCA92171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="nVjo5xZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfDSUKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:10:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34613 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfDSUKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:10:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so3050710plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AnbEvgYbLB+hJOHvUZIH4N8KzzjuyeRwAEQ6GiR1CDI=;
        b=nVjo5xZdoQ/umlHkT2dwnjYxkAnsVjZl78HUYfHD558L4a6QIodB2g8B/2Ut+E1uxS
         XA6ZGTtd1wyzvghQUEoe+ghPWTgUKltWCUkfNPiNPzxHOvnlX9ssZrPPZwbN43o9RvoM
         OvrPX3u8Zu5nEVPJB77HgwOGEBFvhnVqpDSchvO6dbbYZr3jQb1hOkpegVh45ngUWAbp
         wcKDrtV5pAc1Nem2ZqLr1CBsK40TkwJ1/SPyl7WlOv/bkcyKanuBdTI5oBPBAlwTtLE0
         m37cVaATm21bEMu9qdAfLezuatbKIEOk5eifHFijCEcH9BGU/BcRz9sHr9shpdX/7vu0
         qzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnbEvgYbLB+hJOHvUZIH4N8KzzjuyeRwAEQ6GiR1CDI=;
        b=HrN6vEPot0nCqlifKDVS2AZnr9+U96h72d31M1QoiGxrwZzW9r6bk2I9LxHf9/9o69
         UjpSjCV4H9F4CE0+k4BqmD2yHO7vykxqv49rZGdk8Ejtsc3QdkQUMrXJSyeegcOC3rHe
         8YJrs3MhTNXCthOo1umhL1ljLwirS/Ady9UA1hvuXMb6uJHiWpRnebg4iBwbafh9+BLD
         NcK3GB2dj/tsQtHMGpBN0fRyK2wtoC3+KN/k7CS8YuHi/vovO46DBscO7l3UjwgrX85P
         UjwyeCDq+86vlo47uzKuVXODa0FRXcsCLoFinZOHABxmWJm3FjSl2ZKhiXlKml3I5n4P
         Aiww==
X-Gm-Message-State: APjAAAWOynTnyN7rPFkojwY1SGj/VjqQWChGOp3R7EB/kJpEquDREAvk
        w8O9T/A/xCs/Rpn0GLo9Glz/dG4JZmw=
X-Google-Smtp-Source: APXvYqzh7G1eq4vozqPrZhrhi5x8K8z8lYWhZ6lE6VZf8H7iVPVqsAq3d6djVdp1DiUSNomdH76rVQ==
X-Received: by 2002:a17:902:7594:: with SMTP id j20mr2461240pll.272.1555662938201;
        Fri, 19 Apr 2019 01:35:38 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id k6sm8965141pfj.173.2019.04.19.01.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 01:35:37 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, lenb@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com,
        rjw@rjwysocki.net
Subject: Re: Detecting x86 LAPIC timer frequency from CPUID data
Date:   Fri, 19 Apr 2019 16:35:33 +0800
Message-Id: <20190419083533.32388-1-drake@endlessm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <alpine.DEB.2.21.1904182359360.3174@nanos.tec.linutronix.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 6:30 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>    Time Stamp Counter/Core Crystal Clock Information (0x15):
>       TSC/clock ratio = 168/2
>       nominal core crystal clock = 0 Hz
>
>    Processor Frequency Information (0x16):
>       Core Base Frequency (MHz) = 0x834 (2100)
>       Core Maximum Frequency (MHz) = 0xed8 (3800)
>       Bus (Reference) Frequency (MHz) = 0x64 (100)
>
> Assuming that TSC and local APIC timer run from the same frequency on these
> modern machines.
>
>        2100MHz * 2 / 168 = 25MHz
>
> and disabling the tsc deadline timer tells me:
>
>   ..... calibration result: 24999
>
> Close enough.

I tested all the Intel SoC generations we have on hand. The assumption that
the core crystal clock feeds the APIC seems to be consistently true.

(Please note that all the following results are done with CONFIG_HZ=250,
 which is why the "calibration result" is 4x higher than HZ=1000 as used
 in previous mails)

In the easy case, the low cost platforms do not support CPUID.0x16 (so no
CPU frequency reporting), but they do tell us the core crystal clock, which
is consistent with the APIC calibration result:

N5000 (Gemini Lake)
[    0.122948] ... lapic delta = 119999
[    0.122948] ... PM-Timer delta = 357950
[    0.122948] ... PM-Timer result ok
[    0.122948] ..... delta 119999
[    0.122948] ..... mult: 5153917
[    0.122948] ..... calibration result: 76799
[    0.122948] ..... CPU clock speed is 1094.1542 MHz.
[    0.122948] ..... host bus clock speed is 19.0799 MHz.
   Time Stamp Counter/Core Crystal Clock Information (0x15):
      TSC/clock ratio = 171/3
      nominal core crystal clock = 19200000 Hz
   Processor Frequency Information (0x16):
      Core Base Frequency (MHz) = 0x0 (0)
      Core Maximum Frequency (MHz) = 0x0 (0)
      Bus (Reference) Frequency (MHz) = 0x0 (0)

N3350 (Apollo Lake)
[    0.248894] ... lapic delta = 119999
[    0.248894] ... PM-Timer delta = 357949
[    0.248894] ... PM-Timer result ok
[    0.248894] ..... delta 119999
[    0.248894] ..... mult: 5153917
[    0.248894] ..... calibration result: 76799
[    0.248894] ..... CPU clock speed is 1094.1540 MHz.
[    0.248894] ..... host bus clock speed is 19.0799 MHz.
   Time Stamp Counter/Core Crystal Clock Information (0x15):
      TSC/clock ratio = 171/3
      nominal core crystal clock = 19200000 Hz
(CPUID 0x16 not supported at all)

And the 4 higher-end SoCs that we have available for testing all report
crystal clock 0Hz from CPUID 0x15, but by combining the CPUID.0x16 base
frequency with the CPUID.0x15 TSC/clock ratio, the crystal frequency can
be calculated as you describe, and it consistently matches the APIC timer
calibration result.

i9-9980HK (Coffee Lake HR)
[    0.379421] ... lapic delta = 149998
[    0.379421] ... PM-Timer delta = 357950
[    0.379421] ... PM-Timer result ok
[    0.379421] ..... delta 149998
[    0.379421] ..... mult: 6442365
[    0.379421] ..... calibration result: 95998
[    0.379421] ..... CPU clock speed is 2399.3902 MHz.
[    0.379421] ..... host bus clock speed is 23.3998 MHz.
   Time Stamp Counter/Core Crystal Clock Information (0x15):
      TSC/clock ratio = 200/2
      nominal core crystal clock = 0 Hz
   Processor Frequency Information (0x16):
      Core Base Frequency (MHz) = 0x960 (2400)
      Core Maximum Frequency (MHz) = 0x1388 (5000)
      Bus (Reference) Frequency (MHz) = 0x64 (100)

i7-8565U (Whiskey Lake)
[    0.173776] ... lapic delta = 149998
[    0.173776] ... PM-Timer delta = 357950
[    0.173776] ... PM-Timer result ok
[    0.173776] ..... delta 149998
[    0.173776] ..... mult: 6442365
[    0.173776] ..... calibration result: 95998
[    0.173776] ..... CPU clock speed is 1991.3903 MHz.
[    0.173776] ..... host bus clock speed is 23.3998 MHz.
   Time Stamp Counter/Core Crystal Clock Information (0x15):
      TSC/clock ratio = 166/2
      nominal core crystal clock = 0 Hz
   Processor Frequency Information (0x16):
      Core Base Frequency (MHz) = 0x7d0 (2000)
      Core Maximum Frequency (MHz) = 0x11f8 (4600)
      Bus (Reference) Frequency (MHz) = 0x64 (100)

i5-7200U (Kabylake)
[    0.219142] ... lapic delta = 149998
[    0.219142] ... PM-Timer delta = 357951
[    0.219142] ... PM-Timer result ok
[    0.219142] ..... delta 149998
[    0.219142] ..... mult: 6442365
[    0.219142] ..... calibration result: 95998
[    0.219142] ..... CPU clock speed is 2711.3880 MHz.
[    0.219142] ..... host bus clock speed is 23.3998 MHz.
   Time Stamp Counter/Core Crystal Clock Information (0x15):
      TSC/clock ratio = 226/2
      nominal core crystal clock = 0 Hz
   Processor Frequency Information (0x16):
      Core Base Frequency (MHz) = 0xa8c (2700)
      Core Maximum Frequency (MHz) = 0xc1c (3100)
      Bus (Reference) Frequency (MHz) = 0x64 (100)

m3-8110Y (Amber Lake)
[    0.102289] ... lapic delta = 149998
[    0.102289] ... PM-Timer delta = 357951
[    0.102289] ... PM-Timer result ok
[    0.102289] ..... delta 149998
[    0.102289] ..... mult: 6442365
[    0.102289] ..... calibration result: 95998
[    0.102289] ..... CPU clock speed is 1607.3930 MHz.
[    0.102289] ..... host bus clock speed is 23.3998 MHz.
   Time Stamp Counter/Core Crystal Clock Information (0x15):
      TSC/clock ratio = 134/2
      nominal core crystal clock = 0 Hz
   Processor Frequency Information (0x16):
      Core Base Frequency (MHz) = 0x640 (1600)
      Core Maximum Frequency (MHz) = 0xd48 (3400)
      Bus (Reference) Frequency (MHz) = 0x64 (100)

Is this data convincing enough or should we additionally wait for some
comments from Intel?

I came up with the patch below. However, upon testing, I realised that, at
least for the platforms I have in hand, only the first hunk is really needed.
We don't need to use your magic calculation to find the crystal frequency
because Intel already told us! native_calibrate_tsc() already hardcodes the
crystal frequency for Kabylake, and Amber/Whiskey/Coffee also report the
0x8e/0x9e Kabylake model codes. Plus ApolloLake/GeminiLake do report the
crystal frequency in CPUID.0x15 so that is covered too.

While looking around this code I also spotted something curious.
In calibrate_APIC_clock() for the case where lapic_timer_frequency has been
externally provided, we have:
		lapic_clockevent.max_delta_ns =
			clockevent_delta2ns(0x7FFFFF, &lapic_clockevent);
		lapic_clockevent.max_delta_ticks = 0x7FFFFF;

But in the case where we calibrate, we have:
	lapic_clockevent.max_delta_ns =
		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
	lapic_clockevent.max_delta_ticks = 0x7FFFFFFF;

0x7FFFFF vs 0x7FFFFFFF, is that intentional?

---
 arch/x86/kernel/tsc.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3fae23834069..8dcfd9a30b24 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -648,6 +648,23 @@ unsigned long native_calibrate_tsc(void)
 
 	if (crystal_khz == 0)
 		return 0;
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	/* The local APIC appears to be fed by the core crystal clock
+	 * (which sounds entirely sensible). We can set the global
+	 * lapic_timer_frequency here to avoid having to calibrate the APIC
+	 * timer later.
+	 *
+	 * This has been empirically verified on ApolloLake and GeminiLake:
+	 * the APIC calibration otherwise determines the same bus frequency
+	 * as the CPUID.0x15 crystal frequency.
+	 * It has also been empirically verified on KabyLake, where the
+	 * APIC calibration otherwise determines the same bus frequency
+	 * as the one hardcoded above.
+	 */
+	lapic_timer_frequency = (crystal_khz * 1000) / HZ;
+#endif
+
 	/*
 	 * TSC frequency determined by CPUID is a "hardware reported"
 	 * frequency and is the most accurate one so far we have. This
@@ -665,6 +682,38 @@ unsigned long native_calibrate_tsc(void)
 	return crystal_khz * ebx_numerator / eax_denominator;
 }
 
+static void set_lapic_timer_freq_from_cpu_freq(unsigned int base_mhz)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
+
+	/*
+	 * Use CPUID.0x16 CPU base frequency to calculate the global
+	 * lapic_timer_frequency, which avoids having to calibrate the
+	 * APIC timer later.
+	 *
+	 * Like in native_calibrate_tsc(), we rely on the observation
+	 * that the local APIC is fed by the core crystal clock.
+	 * Experimenting with KabyLake, CoffeeLake, WhiskeyLake and
+	 * AmberLake, the core crystal clock is not reported in CPUID.0x15,
+	 * but we can calculate it by considering the CPU base frequency
+	 * and the TSC/clock ratio. The result has been verified to closely
+	 * match the result that would otherwise be obtained through
+	 * APIC clock calibration.
+	 */
+
+	if (!base_mhz)
+		return;
+
+	cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+	if (!eax_denominator || !ebx_numerator)
+		return;
+
+	lapic_timer_frequency = (base_mhz * 1000000 * \
+				 eax_denominator / ebx_numerator) / HZ;
+#endif
+}
+
 static unsigned long cpu_khz_from_cpuid(void)
 {
 	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;
@@ -679,6 +728,8 @@ static unsigned long cpu_khz_from_cpuid(void)
 
 	cpuid(0x16, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
 
+	set_lapic_timer_freq_from_cpu_freq(eax_base_mhz);
+
 	return eax_base_mhz * 1000;
 }
 
-- 
2.19.1

