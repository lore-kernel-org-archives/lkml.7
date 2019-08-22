Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0E1C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B26C233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rh+oG76p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfHVK1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:27:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731841AbfHVK07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aEhP+2EPPkbKe7nZxkOr8qN7wlbSjPk3XiNlz29XUHw=; b=rh+oG76pkhsBemRPJja9yN8x+S
        V4NpWoMoqH+MxTOnB0mbfpk+ybfBBTJ8V6dn6KzX8cgKtmK9KgnADi/Ofv0cRWdzwuV9DIrtuVHRq
        +hJPxxrOvDvmhj9T1sE6Db10tnb10jUe/OqG4n/WJyt9IAfblbt+/aVmSiEtuKD8XHUlVSvh6royF
        oEFaXmz7LEklFQuyzUPRwUEQ1OJ6eM+LjbF9WXv7TIdz26TidgT2xfDgvMDYTP054HVxPLqLTRIWJ
        TAdFMgPsC2fp27PsekBYfNfOVthsx+Hf+bOrvxvhfKND31Swvc/6Axw6CVmYOUspphmWJnBIK51yo
        CzjQl+FA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0kIu-0008DN-NT; Thu, 22 Aug 2019 10:26:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 864503077F6;
        Thu, 22 Aug 2019 12:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6547020BD78EE; Thu, 22 Aug 2019 12:26:50 +0200 (CEST)
Message-Id: <20190822102411.281169113@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 22 Aug 2019 12:23:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 3/5] x86/intel: Aggregate big core graphics naming
References: <20190822102306.109718810@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently big core clients with extra graphics on have:

 - _G
 - _GT3E

Make it uniformly: _G

for i in  `git grep -l "INTEL_FAM6_.*_GT3E"`
do
	sed -i -e 's/\(INTEL_FAM6_.*\)_GT3E/\1_G/g' ${i}
done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/events/intel/core.c          |    8 ++++----
 arch/x86/events/intel/cstate.c        |    8 ++++----
 arch/x86/events/intel/pt.c            |    2 +-
 arch/x86/events/intel/rapl.c          |    4 ++--
 arch/x86/events/intel/uncore.c        |    4 ++--
 arch/x86/events/msr.c                 |    4 ++--
 arch/x86/include/asm/intel-family.h   |    4 ++--
 arch/x86/kernel/apic/apic.c           |    4 ++--
 arch/x86/kernel/cpu/bugs.c            |    4 ++--
 arch/x86/kernel/cpu/intel.c           |    4 ++--
 drivers/cpufreq/intel_pstate.c        |    4 ++--
 tools/power/x86/turbostat/turbostat.c |   14 +++++++-------
 12 files changed, 32 insertions(+), 32 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3966,11 +3966,11 @@ static __init void intel_clovertown_quir
 static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL,		 3, 0x0000001f),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_L,		 1, 0x0000001e),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_GT3E,		 1, 0x00000015),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_G,		 1, 0x00000015),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL,		 4, 0x00000023),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_GT3E,	 1, 0x00000014),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_G,		 1, 0x00000014),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 2, 0x00000010),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 3, 0x07000009),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 4, 0x0f000009),
@@ -4860,7 +4860,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_HASWELL_G:
 		x86_add_quirk(intel_ht_bug);
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
@@ -4892,7 +4892,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -593,9 +593,9 @@ static const struct x86_cpu_id intel_cst
 	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE_X, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL,      snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X,	   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_GT3E, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_G, snb_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_L, hswult_cstates),
 
@@ -605,7 +605,7 @@ static const struct x86_cpu_id intel_cst
 
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL,        snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_XEON_D, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_GT3E,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_G,      snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X,      snb_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_L, snb_cstates),
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -206,7 +206,7 @@ static int __init pt_pmu_hw_init(void)
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 		/* not setting BRANCH_EN will #GP, erratum BDM106 */
 		pt_pmu.branch_en_always_on = true;
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -723,9 +723,9 @@ static const struct x86_cpu_id rapl_mode
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_L,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_G,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_G,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1453,9 +1453,9 @@ static const struct x86_cpu_id intel_unc
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,	  ivb_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_L,	  hsw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,	  hsw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_G,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL,	  bdw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E, bdw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_G,	  bdw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X,  snbep_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM_EX,	  nhmex_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_WESTMERE_EX,	  nhmex_uncore_init),
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -62,11 +62,11 @@ static bool test_intel(int idx, void *da
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_HASWELL_G:
 
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 
 	case INTEL_FAM6_ATOM_SILVERMONT:
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -52,10 +52,10 @@
 #define INTEL_FAM6_HASWELL		0x3C
 #define INTEL_FAM6_HASWELL_X		0x3F
 #define INTEL_FAM6_HASWELL_L		0x45
-#define INTEL_FAM6_HASWELL_GT3E		0x46
+#define INTEL_FAM6_HASWELL_G		0x46
 
 #define INTEL_FAM6_BROADWELL		0x3D
-#define INTEL_FAM6_BROADWELL_GT3E	0x47
+#define INTEL_FAM6_BROADWELL_G		0x47
 #define INTEL_FAM6_BROADWELL_X		0x4F
 #define INTEL_FAM6_BROADWELL_XEON_D	0x56
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -595,10 +595,10 @@ static const struct x86_cpu_id deadline_
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL,		0x22),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_L,	0x20),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_GT3E,	0x17),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_G,	0x17),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL,	0x25),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_GT3E,	0x17),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_G,	0x17),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_L,	0xb2),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE,		0xb2),
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1186,9 +1186,9 @@ static void override_cache_bits(struct c
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_HASWELL_G:
 	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_L:
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -150,12 +150,12 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
 	{ INTEL_FAM6_BROADWELL,		0x04,	0x28 },
-	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
+	{ INTEL_FAM6_BROADWELL_G,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
 	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
 	{ INTEL_FAM6_HASWELL_L,		0x01,	0x21 },
-	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
+	{ INTEL_FAM6_HASWELL_G,		0x01,	0x18 },
 	{ INTEL_FAM6_HASWELL,		0x03,	0x23 },
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1876,8 +1876,8 @@ static const struct x86_cpu_id intel_pst
 	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_L,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL_G,		core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_G,		core_funcs),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_L,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3209,9 +3209,9 @@ int probe_nhm_msrs(unsigned int family,
 		break;
 	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
@@ -3841,9 +3841,9 @@ void rapl_probe_intel(unsigned int famil
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL:	/* HSW */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		if (rapl_joules) {
 			BIC_PRESENT(BIC_Pkg_J);
@@ -4032,7 +4032,7 @@ void perf_limit_reasons_probe(unsigned i
 
 	switch (model) {
 	case INTEL_FAM6_HASWELL:	/* HSW */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 		do_gfx_perf_limit_reasons = 1;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
 		do_core_perf_limit_reasons = 1;
@@ -4251,9 +4251,9 @@ int has_snb_msrs(unsigned int family, un
 	case INTEL_FAM6_IVYBRIDGE_X:	/* IVB Xeon */
 	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSW */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */


