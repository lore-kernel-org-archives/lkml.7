Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2443A218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YcpbO7p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfC3LUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 07:20:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57398 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730683AbfC3LU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:28 -0400
Received: from zn.tnic (p200300EC2F148A00C43C95AA310C833A.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:c43c:95aa:310c:833a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E64C1EC097D;
        Sat, 30 Mar 2019 12:20:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553944826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=by3cHj7ff/5lUELGrHsXoDpuXXg5BYdhSdIkb+9kPjE=;
        b=YcpbO7p8q2X47TjjVxi0Rq+oH6OcO3oTb0upSxnUYuaiDwGUr8ibYxA3s3rYqCKRx98cid
        1KbLRvz2XduZHe4DcinP8MaISA3cyYQ/W0tpVlkK8BRUrqtk0+YmP/3YfrMS8hlPkvQxk2
        xp3Mf+GFosVHTQy7voHV62T6qwaBqFg=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/5] drivers/cpufreq: Convert some slow-path static_cpu_has() callers to boot_cpu_has()
Date:   Sat, 30 Mar 2019 12:20:22 +0100
Message-Id: <20190330112022.28888-6-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190330112022.28888-1-bp@alien8.de>
References: <20190330112022.28888-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Using static_cpu_has() is pointless on those paths, convert them to the
boot_cpu_has() variant.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/amd_freq_sensitivity.c |  2 +-
 drivers/cpufreq/intel_pstate.c         | 18 +++++++++---------
 drivers/cpufreq/powernow-k8.c          |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index 4ac7c3cf34be..6927a8c0e748 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -124,7 +124,7 @@ static int __init amd_freq_sensitivity_init(void)
 			PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
 
 	if (!pcidev) {
-		if (!static_cpu_has(X86_FEATURE_PROC_FEEDBACK))
+		if (!boot_cpu_has(X86_FEATURE_PROC_FEEDBACK))
 			return -ENODEV;
 	}
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e22f0dbaebb1..ea62e3f02d56 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -522,7 +522,7 @@ static s16 intel_pstate_get_epb(struct cpudata *cpu_data)
 	u64 epb;
 	int ret;
 
-	if (!static_cpu_has(X86_FEATURE_EPB))
+	if (!boot_cpu_has(X86_FEATURE_EPB))
 		return -ENXIO;
 
 	ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
@@ -536,7 +536,7 @@ static s16 intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_data)
 {
 	s16 epp;
 
-	if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		/*
 		 * When hwp_req_data is 0, means that caller didn't read
 		 * MSR_HWP_REQUEST, so need to read and get EPP.
@@ -561,7 +561,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
 	u64 epb;
 	int ret;
 
-	if (!static_cpu_has(X86_FEATURE_EPB))
+	if (!boot_cpu_has(X86_FEATURE_EPB))
 		return -ENXIO;
 
 	ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
@@ -609,7 +609,7 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
 	if (epp < 0)
 		return epp;
 
-	if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		if (epp == HWP_EPP_PERFORMANCE)
 			return 1;
 		if (epp <= HWP_EPP_BALANCE_PERFORMANCE)
@@ -618,7 +618,7 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
 			return 3;
 		else
 			return 4;
-	} else if (static_cpu_has(X86_FEATURE_EPB)) {
+	} else if (boot_cpu_has(X86_FEATURE_EPB)) {
 		/*
 		 * Range:
 		 *	0x00-0x03	:	Performance
@@ -646,7 +646,7 @@ static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
 
 	mutex_lock(&intel_pstate_limits_lock);
 
-	if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		u64 value;
 
 		ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, &value);
@@ -821,7 +821,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 		epp = cpu_data->epp_powersave;
 	}
 update_epp:
-	if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		value &= ~GENMASK_ULL(31, 24);
 		value |= (u64)epp << 24;
 	} else {
@@ -846,7 +846,7 @@ static void intel_pstate_hwp_force_min_perf(int cpu)
 	value |= HWP_MIN_PERF(min_perf);
 
 	/* Set EPP/EPB to min */
-	if (static_cpu_has(X86_FEATURE_HWP_EPP))
+	if (boot_cpu_has(X86_FEATURE_HWP_EPP))
 		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
 	else
 		intel_pstate_set_epb(cpu, HWP_EPP_BALANCE_POWERSAVE);
@@ -1194,7 +1194,7 @@ static void __init intel_pstate_sysfs_expose_params(void)
 static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 {
 	/* First disable HWP notification interrupt as we don't process them */
-	if (static_cpu_has(X86_FEATURE_HWP_NOTIFY))
+	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index fb77b39a4ce3..3c12e03fa343 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1178,7 +1178,7 @@ static int powernowk8_init(void)
 	unsigned int i, supported_cpus = 0;
 	int ret;
 
-	if (static_cpu_has(X86_FEATURE_HW_PSTATE)) {
+	if (boot_cpu_has(X86_FEATURE_HW_PSTATE)) {
 		__request_acpi_cpufreq();
 		return -ENODEV;
 	}
-- 
2.21.0

