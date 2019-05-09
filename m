Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F5AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EBA216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="FwNys07q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfEIFy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 01:54:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46938 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEIFy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 01:54:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so691012pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 22:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imoKp9JuiJEQQrERMHSHA/nmMTQQOgAMM5q2Pymqq9c=;
        b=FwNys07qzls52gZevH6vBD9KYUaRUy8Z5uj1DW56bcDHPnzRfWd4QQMjBNvTOmfQsp
         gFsKK8kwfpckL/qiuTmkyy64uAXKVvjfQ/mFm2++8nCo0NHXSYfHlhIQDgpLMRgrV0Ng
         UVI3MSunEOVydxc1GXAsgspc/t0+itLz6XdDrBNchh8qKVWzRSiWOYAP7GNBx8A+11dO
         XsfQrA8ig8NI5Nu2OerxGtkBp/uU/uXexxWh9REU/DcRrE0Yqlcr5JKDVAF37AMdHG3V
         27/dBd/Ey8i8BxtETFN9HgdGPVXsC8NH2k7gYs3Z3swV0Yt8s/579IMIbgh1DSMztqER
         dA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imoKp9JuiJEQQrERMHSHA/nmMTQQOgAMM5q2Pymqq9c=;
        b=W/rytzR8DuFszKCv96iuTvQZaqTLUQhpkhs4pUf2Kf3niK4oGDHgPxKcLagzOEZskn
         sPrbNI3Kz7SCudhY5EzN3WBSQqATkRJOM6jInv9cwQeg5vaAyl3lOu+jC53BpM/0pOEk
         Vovvv40vjzEmC3oOzJPcj7ALl0XZUbNV3aT0iMs1DuUsRZdWtk66QqM5t2Juy3hkvbfC
         xl3JWtGG0aJEdYTDXeDS9bKAIHvR5+P8VBj1/mClfV15keImPvHrq4sG/AHrH7QYLXN4
         J0+7K/iNvXqWvadzs8vCxFYhABmLx/RywFDfNrJQF+sUSqK5cKnEHMMD4pjMHpNp7E0a
         pGmw==
X-Gm-Message-State: APjAAAXzH3szBdqXrQ5/1poSmm0QvBMtnqsog7RiCsW/DVANl18IxO80
        JMKR7qjCofsItWnL4QJfTyn5Ow==
X-Google-Smtp-Source: APXvYqyF8kmEKyn18cOblna/CpyIEcoPR+HptdM9H6IcZlve2X9Mno53I8kePzk7HDnUpmholMYTIQ==
X-Received: by 2002:a63:8dc8:: with SMTP id z191mr3195571pgd.9.1557381267872;
        Wed, 08 May 2019 22:54:27 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id f20sm1363137pff.176.2019.05.08.22.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 22:54:27 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, rafael.j.wysocki@intel.com,
        linux@endlessm.com, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 2/3] x86/apic: rename lapic_timer_frequency to lapic_timer_period
Date:   Thu,  9 May 2019 13:54:16 +0800
Message-Id: <20190509055417.13152-2-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509055417.13152-1-drake@endlessm.com>
References: <20190509055417.13152-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is a period unit (number of clock cycles per jiffy),
not a frequency (which is number of cycles per second).

Give it a more appropriate name.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 arch/x86/include/asm/apic.h    |  2 +-
 arch/x86/kernel/apic/apic.c    | 20 ++++++++++----------
 arch/x86/kernel/cpu/mshyperv.c |  4 ++--
 arch/x86/kernel/cpu/vmware.c   |  2 +-
 arch/x86/kernel/jailhouse.c    |  2 +-
 arch/x86/kernel/tsc_msr.c      |  4 ++--
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 130e81e10fc7..fc505a84aa93 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -52,7 +52,7 @@ extern unsigned int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
 extern int disable_apic;
-extern unsigned int lapic_timer_frequency;
+extern unsigned int lapic_timer_period;
 
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ab6af775f06c..93de7862eef8 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -194,7 +194,7 @@ static struct resource lapic_resource = {
 	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
 };
 
-unsigned int lapic_timer_frequency = 0;
+unsigned int lapic_timer_period = 0;
 
 static void apic_pm_activate(void);
 
@@ -500,7 +500,7 @@ lapic_timer_set_periodic_oneshot(struct clock_event_device *evt, bool oneshot)
 	if (evt->features & CLOCK_EVT_FEAT_DUMMY)
 		return 0;
 
-	__setup_APIC_LVTT(lapic_timer_frequency, oneshot, 1);
+	__setup_APIC_LVTT(lapic_timer_period, oneshot, 1);
 	return 0;
 }
 
@@ -804,11 +804,11 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 
 static int __init lapic_init_clockevent(void)
 {
-	if (!lapic_timer_frequency)
+	if (!lapic_timer_period)
 		return -1;
 
 	/* Calculate the scaled math multiplication factor */
-	lapic_clockevent.mult = div_sc(lapic_timer_frequency/APIC_DIVISOR,
+	lapic_clockevent.mult = div_sc(lapic_timer_period/APIC_DIVISOR,
 					TICK_NSEC, lapic_clockevent.shift);
 	lapic_clockevent.max_delta_ns =
 		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
@@ -838,7 +838,7 @@ static int __init calibrate_APIC_clock(void)
 	 */
 	if (!lapic_init_clockevent()) {
 		apic_printk(APIC_VERBOSE, "lapic timer already calibrated %d\n",
-			    lapic_timer_frequency);
+			    lapic_timer_period);
 		/*
 		 * Direct calibration methods must have an always running
 		 * local APIC timer, no need for broadcast timer.
@@ -883,13 +883,13 @@ static int __init calibrate_APIC_clock(void)
 	pm_referenced = !calibrate_by_pmtimer(lapic_cal_pm2 - lapic_cal_pm1,
 					&delta, &deltatsc);
 
-	lapic_timer_frequency = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
+	lapic_timer_period = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
 	lapic_init_clockevent();
 
 	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
 	apic_printk(APIC_VERBOSE, "..... mult: %u\n", lapic_clockevent.mult);
 	apic_printk(APIC_VERBOSE, "..... calibration result: %u\n",
-		    lapic_timer_frequency);
+		    lapic_timer_period);
 
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
 		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
@@ -900,13 +900,13 @@ static int __init calibrate_APIC_clock(void)
 
 	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
 		    "%u.%04u MHz.\n",
-		    lapic_timer_frequency / (1000000 / HZ),
-		    lapic_timer_frequency % (1000000 / HZ));
+		    lapic_timer_period / (1000000 / HZ),
+		    lapic_timer_period % (1000000 / HZ));
 
 	/*
 	 * Do a sanity check on the APIC calibration result
 	 */
-	if (lapic_timer_frequency < (1000000 / HZ)) {
+	if (lapic_timer_period < (1000000 / HZ)) {
 		local_irq_enable();
 		pr_warning("APIC frequency too slow, disabling apic timer\n");
 		return -1;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3fa238a137d2..faae6115ddef 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -270,9 +270,9 @@ static void __init ms_hyperv_init_platform(void)
 
 		rdmsrl(HV_X64_MSR_APIC_FREQUENCY, hv_lapic_frequency);
 		hv_lapic_frequency = div_u64(hv_lapic_frequency, HZ);
-		lapic_timer_frequency = hv_lapic_frequency;
+		lapic_timer_period = hv_lapic_frequency;
 		pr_info("Hyper-V: LAPIC Timer Frequency: %#x\n",
-			lapic_timer_frequency);
+			lapic_timer_period);
 	}
 
 	register_nmi_handler(NMI_UNKNOWN, hv_nmi_unknown, NMI_FLAG_FIRST,
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 0eda91f8eeac..3c648476d4fb 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -157,7 +157,7 @@ static void __init vmware_platform_setup(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
-		lapic_timer_frequency = ecx / HZ;
+		lapic_timer_period = ecx / HZ;
 		pr_info("Host bus clock speed read from hypervisor : %u Hz\n",
 			ecx);
 #endif
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 1b2ee55a2dfb..ba95bc70460d 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -45,7 +45,7 @@ static void jailhouse_get_wallclock(struct timespec64 *now)
 
 static void __init jailhouse_timer_init(void)
 {
-	lapic_timer_frequency = setup_data.apic_khz * (1000 / HZ);
+	lapic_timer_period = setup_data.apic_khz * (1000 / HZ);
 }
 
 static unsigned long jailhouse_get_tsc(void)
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 3d0e9aeea7c8..067858fe4db8 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -71,7 +71,7 @@ static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
 /*
  * MSR-based CPU/TSC frequency discovery for certain CPUs.
  *
- * Set global "lapic_timer_frequency" to bus_clock_cycles/jiffy
+ * Set global "lapic_timer_period" to bus_clock_cycles/jiffy
  * Return processor base frequency in KHz, or 0 on failure.
  */
 unsigned long cpu_khz_from_msr(void)
@@ -104,7 +104,7 @@ unsigned long cpu_khz_from_msr(void)
 	res = freq * ratio;
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	lapic_timer_frequency = (freq * 1000) / HZ;
+	lapic_timer_period = (freq * 1000) / HZ;
 #endif
 
 	/*
-- 
2.20.1

