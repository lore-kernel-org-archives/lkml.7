Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6A8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974D023400
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FKh/vFDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393378AbfHWJEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:04:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfHWJEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9cQsUvRbVJtataqOfN6iQbn2fBG30RoMEN/hL/9Pz5I=; b=FKh/vFDv6KEiQtT4OSQTgyRW0
        kAIf1tRwE6OrnpSolQwPFFaRWHyoMj/AuW7RFZc64TbtAh6lfh8KLCQFDed5WLCTf6pQXHWUchgBU
        nzhF+YI81jJ95qGJmNHXJfY726ODyiH3HPdAFCOF7mrAH2UzeDAnd1oz7Zqh1/yIaLMMPdGC9Q1BQ
        O42yrSVBOl+oufgtlZCENUqUjlg2nAB8zaRAp1zNdIhPx+Zj7yswTrZJw6XfIDrrZzntDfLGygoqh
        pb7UoJaWwwsIrt0R1w3+A2npwHd+SN5hep53p6Yte4B6paxhyQu7+bnsbVuicHG2sIydbWXu3LCCv
        rTQR69SIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i15U7-0000c5-0x; Fri, 23 Aug 2019 09:03:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3DEA305F65;
        Fri, 23 Aug 2019 11:03:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62970202D580B; Fri, 23 Aug 2019 11:03:48 +0200 (CEST)
Date:   Fri, 23 Aug 2019 11:03:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@intel.com>
Subject: Re: [PATCH] x86/cpu: Add new Airmont variant to Intel family
Message-ID: <20190823090348.GG2369@hirez.programming.kicks-ass.net>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
 <20190820122233.GN2332@hirez.programming.kicks-ass.net>
 <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
 <20190820145735.GW2332@hirez.programming.kicks-ass.net>
 <20190821201845.GA29589@agluck-desk2.amr.corp.intel.com>
 <20190822102955.GS2369@hirez.programming.kicks-ass.net>
 <20190822185347.GA8933@agluck-desk2.amr.corp.intel.com>
 <20190822203544.GA10229@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822203544.GA10229@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 01:35:44PM -0700, Luck, Tony wrote:

> From: Tony Luck <tony.luck@intel.com>
> 
> One of the use cases for this processor is as a network
> processor. So give it an "_NP" tag for now. Could be changed
> later if it turns out to group with some other tag.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 5c05b2d389c3..23ed388a3a56 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -95,6 +95,7 @@
>  
>  #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
>  #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
> +#define INTEL_FAM6_ATOM_AIRMONT_NP	0x75 /* Lightning Mountain */
>  
>  #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
>  #define INTEL_FAM6_ATOM_GOLDMONT_D	0x5F /* Denverton */

Since it is 'just another airmont' with bits on, should we not then also
add it to all ATOM_AIRMONT sites already present in the kernel?

something like the below; except there were a few sites I skipped
because 'no clue'.

Also, while going over that, it looked like we missed AIRMONT_MID from a
few sites.

I'm thinking we want to add as many of these sites as possible and
correct when adding a new define; esp. for older microarchs that are
already well supported.

---

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 648260b5f367..56e6875b6882 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4647,6 +4647,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ATOM_SILVERMONT_MID:
 	case INTEL_FAM6_ATOM_AIRMONT:
 	case INTEL_FAM6_ATOM_AIRMONT_MID:
+	case INTEL_FAM6_ATOM_AIRMONT_NP:
 		memcpy(hw_cache_event_ids, slm_hw_cache_event_ids,
 			sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, slm_hw_cache_extra_regs,
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 688592b34564..1e999092de22 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -602,6 +602,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT, slm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_X, slm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT,     slm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT_NP,  slm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_CORE,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_XEON_D, snb_cstates),
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 9431447541e9..fe2323f114c0 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -72,6 +72,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ATOM_SILVERMONT:
 	case INTEL_FAM6_ATOM_SILVERMONT_X:
 	case INTEL_FAM6_ATOM_AIRMONT:
+	case INTEL_FAM6_ATOM_AIRMONT_NP:
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_ATOM_GOLDMONT_X:
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5cc2d51cc25e..a3ccee6a16a5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1053,6 +1053,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_INTEL(ATOM_SILVERMONT_X,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_SILVERMONT_MID,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_AIRMONT,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
+	VULNWL_INTEL(ATOM_AIRMONT_NP,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 	VULNWL_INTEL(XEON_PHI_KNL,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 	VULNWL_INTEL(XEON_PHI_KNM,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 067858fe4db8..bde7a0c8fa8b 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -64,6 +64,7 @@ static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
 	INTEL_CPU_FAM6(ATOM_SILVERMONT,		freq_desc_byt),
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	freq_desc_tng),
 	INTEL_CPU_FAM6(ATOM_AIRMONT,		freq_desc_cht),
+	INTEL_CPU_FAM6(ATOM_AIRMONT_NP,		freq_desc_cht),
 	INTEL_CPU_FAM6(ATOM_AIRMONT_MID,	freq_desc_ann),
 	{}
 };
diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index ee6b0780bea1..52990f68af70 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -125,6 +125,7 @@ static const struct x86_cpu_id intel_punit_cpu_ids[] = {
 	ICPU(INTEL_FAM6_ATOM_SILVERMONT, punit_device_byt),
 	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID,  punit_device_tng),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,	  punit_device_cht),
+	ICPU(INTEL_FAM6_ATOM_AIRMONT_NP,	  punit_device_cht),
 	{}
 };
 
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index d696f165a50e..4da3aef37836 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -313,6 +313,7 @@ static const struct lpss_device_desc bsw_spi_dev_desc = {
 static const struct x86_cpu_id lpss_cpu_ids[] = {
 	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	/* Valleyview, Bay Trail */
 	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry Trail */
+	ICPU(INTEL_FAM6_ATOM_AIRMONT_NP),	/* Braswell, Cherry Trail */
 	{}
 };
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index cc27d4c59dca..878f5dcce41b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1879,6 +1879,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_funcs),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
+	ICPU(INTEL_FAM6_ATOM_AIRMONT_NP,	airmont_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_funcs),
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index fa5ff77b8fe4..277757386ddc 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1070,6 +1070,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	INTEL_CPU_FAM6(ATOM_SILVERMONT,		idle_cpu_byt),
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	idle_cpu_tangier),
 	INTEL_CPU_FAM6(ATOM_AIRMONT,		idle_cpu_cht),
+	INTEL_CPU_FAM6(ATOM_AIRMONT_NP,		idle_cpu_cht),
 	INTEL_CPU_FAM6(IVYBRIDGE,		idle_cpu_ivb),
 	INTEL_CPU_FAM6(IVYBRIDGE_X,		idle_cpu_ivt),
 	INTEL_CPU_FAM6(HASWELL_CORE,		idle_cpu_hsw),
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 6df481896b5f..3104ada7d046 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -981,6 +981,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	INTEL_CPU_FAM6(ATOM_SILVERMONT, rapl_defaults_byt),
 	INTEL_CPU_FAM6(ATOM_AIRMONT, rapl_defaults_cht),
+	INTEL_CPU_FAM6(ATOM_AIRMONT_NP, rapl_defaults_cht),
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID, rapl_defaults_tng),
 	INTEL_CPU_FAM6(ATOM_AIRMONT_MID, rapl_defaults_ann),
 	INTEL_CPU_FAM6(ATOM_GOLDMONT, rapl_defaults_core),
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb9901c..3ba4f2a77d3e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3228,6 +3228,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = slv_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_AIRMONT:	/* AMT */
+	case INTEL_FAM6_ATOM_AIRMONT_NP:	/* AMT */
 		pkg_cstate_limits = amt_pkg_cstate_limits;
 		no_MSR_MISC_PWR_MGMT = 1;
 		break;
