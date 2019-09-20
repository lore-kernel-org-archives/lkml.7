Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BDAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5642120882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsYHpr0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394878AbfITG1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:27:42 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:33919 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394880AbfITG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:27:41 -0400
Received: by mail-qt1-f201.google.com with SMTP id y10so6902879qti.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 23:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CucnbTzStvcSIAgRMuzfV7pL2ynq6M2/TlEKsf9uX4w=;
        b=bsYHpr0XFWPiKYjovv3Vm02n9BUgmNaNZSZg2VDIoU0BYcP/TrtJXaCrFnMpsHIooY
         Eq+66t/3FUdko0cWY/eVQqH7ZHIl/TbBH43W3y8uOI8q4+GzmdbsWtMwRQMYwWC0446W
         vyPGQ+WE3Flzx0A848WSr/GfslkZ5VMhlUEzSuhxOWPZMSUUGpzcseLgGAszQtdl1i2q
         FcDiBM5wyDngAUMbr39JR4rzYscQut7vhw5HOqVoI04AHgaT7sIm5d992cfN39cuOiqS
         nIHUUQk8XwxEw2D5/sa+usYVZ17EVjNgTI4awW1F2mmtnSRJlTHc+e+XgyAe01l6q8eG
         D5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CucnbTzStvcSIAgRMuzfV7pL2ynq6M2/TlEKsf9uX4w=;
        b=HB2gdRwKnbXsOBX9atbUvPhUyAn2/rtv3ett027UG93EMbv3dz/3uE5GePsV/G2orq
         q4POugODNWKl+lQvAcm5zCf6A0YANR+MfahEbcmFoSbArXRX7v2QnVoyREbLZR2qyHDs
         ky4X59uv2N3UZaC2nzEzrmi8ZqQ89WIXPyL+MGDObl17xLXMlL1dzbQaUeFk7rtnPXpO
         9oBEG/xhju6bTLYCguDCsqRsr69wigFdSJjTyNk6WjE1yFIGw4skFW98kfelcLCyQSvl
         90DBoKMKgTGB9bWhy+c4RLpQRLpKvepcV7X+XpY+Ap1DMaabwDhCGSIeq24Vi7L/xq9p
         yCpA==
X-Gm-Message-State: APjAAAVjevie8E5r3bOqUq1Kb2E2iLE06CEvm0ep5++Ds45tDhB0pU9D
        0j7BtNE6cNEGrJPNZVa7S/uFQ/TLTi88Uw==
X-Google-Smtp-Source: APXvYqzrg03IpbCj13IBkNlMEaYZURlrk44PPVVELnwg1h+eklx0eOFDcPBCFusgE42xxp9jxy31c5/Lv2VhsA==
X-Received: by 2002:ac8:47d0:: with SMTP id d16mr1632218qtr.176.1568960859307;
 Thu, 19 Sep 2019 23:27:39 -0700 (PDT)
Date:   Fri, 20 Sep 2019 15:27:13 +0900
In-Reply-To: <20190920062713.78503-1-suleiman@google.com>
Message-Id: <20190920062713.78503-3-suleiman@google.com>
Mime-Version: 1.0
References: <20190920062713.78503-1-suleiman@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [RFC 2/2] x86/kvmclock: Use host timekeeping.
From:   Suleiman Souhlal <suleiman@google.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_KVMCLOCK_HOST_TIMEKEEPING is enabled, and the host
supports it, update our timekeeping parameters to be the same as
the host. This lets us have our time synchronized with the host's,
even in the presence of host NTP or suspend.

When enabled, kvmclock uses raw tsc instead of pvclock.

When enabled, syscalls that can change time, such as settimeofday(2)
or adj_timex(2) are disabled in the guest.

Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
 arch/x86/Kconfig                |   9 +++
 arch/x86/include/asm/kvmclock.h |   2 +
 arch/x86/kernel/kvmclock.c      | 127 +++++++++++++++++++++++++++++++-
 kernel/time/timekeeping.c       |  21 ++++++
 4 files changed, 155 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4195f44c6a09..37299377d9d7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -837,6 +837,15 @@ config PARAVIRT_TIME_ACCOUNTING
 config PARAVIRT_CLOCK
 	bool
 
+config KVMCLOCK_HOST_TIMEKEEPING
+	bool "kvmclock uses host timekeeping"
+	depends on KVM_GUEST
+	---help---
+	  Select this option to make the guest use the same timekeeping
+	  parameters as the host. This means that time will be almost
+	  exactly the same between the two. Only works if the host uses "tsc"
+	  clocksource.
+
 config JAILHOUSE_GUEST
 	bool "Jailhouse non-root cell support"
 	depends on X86_64 && PCI
diff --git a/arch/x86/include/asm/kvmclock.h b/arch/x86/include/asm/kvmclock.h
index eceea9299097..cad7eae62b54 100644
--- a/arch/x86/include/asm/kvmclock.h
+++ b/arch/x86/include/asm/kvmclock.h
@@ -4,4 +4,6 @@
 
 extern struct clocksource kvm_clock;
 
+bool kvm_clock_copy_into_tk(struct timekeeper *tk);
+
 #endif /* _ASM_X86_KVM_CLOCK_H */
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 904494b924c1..e3a33dcaffc8 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/set_memory.h>
+#include <linux/timekeeper_internal.h>
 
 #include <asm/hypervisor.h>
 #include <asm/mem_encrypt.h>
@@ -29,6 +30,9 @@ static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
 static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
 static u64 kvm_sched_clock_offset __ro_after_init;
 
+static bool pv_timekeeper_enabled;
+static bool pv_timekeeper_present;
+
 static int __init parse_no_kvmclock(char *arg)
 {
 	kvmclock = 0;
@@ -54,6 +58,8 @@ static struct pvclock_wall_clock wall_clock __bss_decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 static struct pvclock_vsyscall_time_info *hvclock_mem;
 
+struct pvclock_timekeeper pv_timekeeper;
+
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
 {
 	return &this_cpu_read(hv_clock_per_cpu)->pvti;
@@ -94,7 +100,10 @@ static u64 kvm_clock_read(void)
 
 static u64 kvm_clock_get_cycles(struct clocksource *cs)
 {
-	return kvm_clock_read();
+	if (pv_timekeeper_present)
+		return rdtsc_ordered();
+	else
+		return kvm_clock_read();
 }
 
 static u64 kvm_sched_clock_read(void)
@@ -159,9 +168,26 @@ bool kvm_check_and_clear_guest_paused(void)
 	return ret;
 }
 
+int
+kvm_clock_enable(struct clocksource *cs)
+{
+	if (pv_timekeeper_present)
+		pv_timekeeper_enabled = 1;
+
+	return 0;
+}
+
+void
+kvm_clock_disable(struct clocksource *cs)
+{
+	pv_timekeeper_enabled = 0;
+}
+
 struct clocksource kvm_clock = {
 	.name	= "kvm-clock",
 	.read	= kvm_clock_get_cycles,
+	.enable = kvm_clock_enable,
+	.disable = kvm_clock_disable,
 	.rating	= 400,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -197,6 +223,86 @@ static void kvm_setup_secondary_clock(void)
 }
 #endif
 
+#ifdef CONFIG_KVMCLOCK_HOST_TIMEKEEPING
+static void
+pvclock_copy_into_read_base(struct pvclock_timekeeper *pvtk,
+    struct tk_read_base *tkr, struct pvclock_read_base *pvtkr)
+{
+	int shift_diff;
+
+	tkr->mask = pvtkr->mask;
+	tkr->cycle_last = pvtkr->cycle_last + pvtk->tsc_offset;
+	tkr->mult = pvtkr->mult;
+	shift_diff = tkr->shift - pvtkr->shift;
+	tkr->shift = pvtkr->shift;
+	tkr->xtime_nsec = pvtkr->xtime_nsec;
+	tkr->base = pvtkr->base;
+}
+
+static u64
+pvtk_read_begin(struct pvclock_timekeeper *pvtk)
+{
+	u64 gen;
+
+	gen = pvtk->gen & ~1;
+	/* Make sure that the gen count is read before the data. */
+	virt_rmb();
+
+	return gen;
+}
+
+static bool
+pvtk_read_retry(struct pvclock_timekeeper *pvtk, u64 gen)
+{
+	/* Make sure that the gen count is re-read after the data. */
+	virt_rmb();
+	return unlikely(gen != pvtk->gen);
+}
+
+bool
+kvm_clock_copy_into_tk(struct timekeeper *tk)
+{
+	struct pvclock_timekeeper *pvtk;
+	u64 gen;
+
+	if (!pv_timekeeper_enabled)
+		return false;
+
+	pvtk = &pv_timekeeper;
+	do {
+		gen = pvtk_read_begin(pvtk);
+		if (!(pv_timekeeper.flags & PVCLOCK_TIMEKEEPER_ENABLED))
+			return false;
+
+		pvclock_copy_into_read_base(pvtk, &tk->tkr_mono,
+		    &pvtk->tkr_mono);
+		pvclock_copy_into_read_base(pvtk, &tk->tkr_raw, &pvtk->tkr_raw);
+
+		tk->xtime_sec = pvtk->xtime_sec;
+		tk->ktime_sec = pvtk->ktime_sec;
+		tk->wall_to_monotonic.tv_sec = pvtk->wall_to_monotonic_sec;
+		tk->wall_to_monotonic.tv_nsec = pvtk->wall_to_monotonic_nsec;
+		tk->offs_real = pvtk->offs_real;
+		tk->offs_boot = pvtk->offs_boot;
+		tk->offs_tai = pvtk->offs_tai;
+		tk->raw_sec = pvtk->raw_sec;
+	} while (pvtk_read_retry(pvtk, gen));
+
+	return true;
+}
+
+static void
+kvm_register_timekeeper(void)
+{
+	unsigned long pa;
+
+	pa = __pa(&pv_timekeeper);
+	wrmsrl(MSR_KVM_TIMEKEEPER_EN, pa);
+	if (pv_timekeeper.flags & PVCLOCK_TIMEKEEPER_ENABLED)
+		pv_timekeeper_present = 1;
+}
+#endif /* CONFIG_KVMCLOCK_HOST_TIMEKEEPING */
+
 /*
  * After the clock is registered, the host will keep writing to the
  * registered memory location. If the guest happens to shutdown, this memory
@@ -271,8 +377,10 @@ static int __init kvm_setup_vsyscall_timeinfo(void)
 	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	if (!(flags & PVCLOCK_TSC_STABLE_BIT))
 		return 0;
-
-	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
+	if (pv_timekeeper_present)
+		kvm_clock.archdata.vclock_mode = VCLOCK_TSC;
+	else
+		kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
 #endif
 
 	kvmclock_init_mem();
@@ -312,6 +420,10 @@ void __init kvmclock_init(void)
 	if (!kvm_para_available() || !kvmclock)
 		return;
 
+#ifdef CONFIG_KVMCLOCK_HOST_TIMEKEEPING
+	kvm_register_timekeeper();
+#endif
+
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
 		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
 		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
@@ -360,11 +472,18 @@ void __init kvmclock_init(void)
 	 * can use TSC as clocksource.
 	 *
 	 */
+#ifndef CONFIG_KVMCLOCK_HOST_TIMEKEEPING
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    !check_tsc_unstable())
 		kvm_clock.rating = 299;
+#endif
+
+	if (pv_timekeeper_present)
+		clocksource_register_khz(&kvm_clock,
+		    pvclock_tsc_khz(this_cpu_pvti()));
+	else
+		clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
 
-	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
 	pv_info.name = "KVM";
 }
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ca69290bee2a..c6e4785babb1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -23,6 +23,10 @@
 #include <linux/compiler.h>
 #include <linux/audit.h>
 
+#ifdef CONFIG_KVMCLOCK_HOST_TIMEKEEPING
+#include <asm/kvmclock.h>
+#endif
+
 #include "tick-internal.h"
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -1223,6 +1227,7 @@ EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
  */
 int do_settimeofday64(const struct timespec64 *ts)
 {
+#ifndef CONFIG_KVMCLOCK_HOST_TIMEKEEPING
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct timespec64 ts_delta, xt;
 	unsigned long flags;
@@ -1261,9 +1266,13 @@ int do_settimeofday64(const struct timespec64 *ts)
 		audit_tk_injoffset(ts_delta);
 
 	return ret;
+#else /* CONFIG_KVMCLOCK_HOST_TIMEKEEPING */
+	return -EINVAL;
+#endif /* CONFIG_KVMCLOCK_HOST_TIMEKEEPING */
 }
 EXPORT_SYMBOL(do_settimeofday64);
 
+#ifndef CONFIG_KVMCLOCK_HOST_TIMEKEEPING
 /**
  * timekeeping_inject_offset - Adds or subtracts from the current time.
  * @tv:		pointer to the timespec variable containing the offset
@@ -1307,6 +1316,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 
 	return ret;
 }
+#endif /* CONFIG_KVMCLOCK_HOST_TIMEKEEPING */
 
 /*
  * Indicates if there is an offset between the system clock and the hardware
@@ -1332,6 +1342,7 @@ int persistent_clock_is_local;
  */
 void timekeeping_warp_clock(void)
 {
+#ifndef CONFIG_KVMCLOCK_HOST_TIMEKEEPING
 	if (sys_tz.tz_minuteswest != 0) {
 		struct timespec64 adjust;
 
@@ -1340,6 +1351,7 @@ void timekeeping_warp_clock(void)
 		adjust.tv_nsec = 0;
 		timekeeping_inject_offset(&adjust);
 	}
+#endif /* CONFIG_KVMCLOCK_HOST_TIMEKEEPING */
 }
 
 /**
@@ -2107,6 +2119,9 @@ static void timekeeping_advance(enum timekeeping_adv_mode mode)
 	clock_set |= accumulate_nsecs_to_secs(tk);
 
 	write_seqcount_begin(&tk_core.seq);
+#ifdef CONFIG_KVMCLOCK_HOST_TIMEKEEPING
+	kvm_clock_copy_into_tk(tk);
+#endif
 	/*
 	 * Update the real timekeeper.
 	 *
@@ -2241,6 +2256,7 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 	return base;
 }
 
+#ifndef CONFIG_KVMCLOCK_HOST_TIMEKEEPING
 /**
  * timekeeping_validate_timex - Ensures the timex is ok for use in do_adjtimex
  */
@@ -2305,6 +2321,7 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc)
 
 	return 0;
 }
+#endif /* CONFIG_KVMCLOCK_HOST_TIMEKEEPING */
 
 
 /**
@@ -2312,6 +2329,7 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc)
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
+#ifndef CONFIG_KVMCLOCK_HOST_TIMEKEEPING
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct audit_ntp_data ad;
 	unsigned long flags;
@@ -2368,6 +2386,9 @@ int do_adjtimex(struct __kernel_timex *txc)
 	ntp_notify_cmos_timer();
 
 	return ret;
+#else /* CONFIG_KVMCLOCK_HOST_TIMEKEEPING */
+	return -EINVAL;
+#endif /* CONFIG_KVMCLOCK_HOST_TIMEKEEPING */
 }
 
 #ifdef CONFIG_NTP_PPS
-- 
2.23.0.237.gc6a4ce50a0-goog

