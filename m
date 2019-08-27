Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D10C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A04E22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vn9c/c6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfH0TwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:52:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbfH0TwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AntrakEZuSkw6w5VnRuWPTJv9e7fkMhh0uFRp8xJycY=; b=Vn9c/c6ye4ghSFAceT0JQFaFuq
        xkeZRiSiFOab1vSnX+zrfzA/4nVg9nCYP9uHH2pRnLeUL8wMoO8z+Ua4+7gPB/mQV4AoDCa6ez1U8
        H1gTn+MWsw7620xo8kFFB0zn/+mkF2ZuSvyV7Kubfg1fyLtS6pzch8cr3N5IMMHIbii4VERGjHLya
        Wx/4h0Q1crGqK0q8UG2E6mGssyr/v4i+A0CrdSYaftfbWW4XekGBzC0PIV9nwIbj8I8OfSMICZB/T
        lhd0b/tgIefvaH8dZ7ApJ23mAC+hMEeg9fDkUUyAw+ZDA+ZtwClosTmOzrKk0TjjQtXzvEtKqt1Ci
        Mvp4BLeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2hVR-0005Sb-Gy; Tue, 27 Aug 2019 19:51:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38D8630768E;
        Tue, 27 Aug 2019 21:51:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E36F12022F84C; Tue, 27 Aug 2019 21:51:50 +0200 (CEST)
Message-Id: <20190827195122.513945586@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 27 Aug 2019 21:48:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -v2 1/5] x86/intel: Aggregate big core client naming
References: <20190827194820.378516765@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the big core client models either have:

 - no OPTDIFF
 - _CORE
 - _DESKTOP

Make it uniformly: 'no OPTDIFF'.

for i in `git grep -l "\(INTEL_FAM6_\|VULNWL_INTEL\|INTEL_CPU_FAM6\).*_\(CORE\|DESKTOP\)"`
do
	sed -i -e 's/\(\(INTEL_FAM6_\|VULNWL_INTEL\|INTEL_CPU_FAM6\).*\)_\(CORE\|DESKTOP\)/\1/g' ${i}
done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/events/intel/core.c                 |   26 ++++++++++++-------------
 arch/x86/events/intel/cstate.c               |   22 ++++++++++-----------
 arch/x86/events/intel/pt.c                   |    2 -
 arch/x86/events/intel/rapl.c                 |   10 ++++-----
 arch/x86/events/intel/uncore.c               |   12 +++++------
 arch/x86/events/msr.c                        |    8 +++----
 arch/x86/include/asm/intel-family.h          |   10 ++++-----
 arch/x86/kernel/apic/apic.c                  |    8 +++----
 arch/x86/kernel/cpu/bugs.c                   |    8 +++----
 arch/x86/kernel/cpu/intel.c                  |   10 ++++-----
 drivers/cpufreq/intel_pstate.c               |   12 +++++------
 drivers/idle/intel_idle.c                    |   10 ++++-----
 drivers/platform/x86/intel_pmc_core.c        |    4 +--
 drivers/platform/x86/intel_pmc_core_pltdrv.c |    4 +--
 drivers/powercap/intel_rapl_common.c         |   10 ++++-----
 tools/power/x86/turbostat/turbostat.c        |   28 +++++++++++++--------------
 16 files changed, 92 insertions(+), 92 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3964,12 +3964,12 @@ static __init void intel_clovertown_quir
 }
 
 static const struct x86_cpu_desc isolation_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_CORE,		 3, 0x0000001f),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL,		 3, 0x0000001f),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_ULT,		 1, 0x0000001e),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_GT3E,		 1, 0x00000015),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_CORE,	 4, 0x00000023),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL,		 4, 0x00000023),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_GT3E,	 1, 0x00000014),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 2, 0x00000010),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 3, 0x07000009),
@@ -3979,16 +3979,16 @@ static const struct x86_cpu_desc isolati
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_MOBILE,	 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_DESKTOP,	 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE,		 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		 9, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	10, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	11, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	13, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		13, 0x0000004e),
 	{}
 };
 
@@ -4857,7 +4857,7 @@ __init int intel_pmu_init(void)
 		break;
 
 
-	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_ULT:
 	case INTEL_FAM6_HASWELL_GT3E:
@@ -4890,7 +4890,7 @@ __init int intel_pmu_init(void)
 		name = "haswell";
 		break;
 
-	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_BROADWELL_X:
@@ -4956,9 +4956,9 @@ __init int intel_pmu_init(void)
 		pmem = true;
 		/* fall through */
 	case INTEL_FAM6_SKYLAKE_MOBILE:
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
-	case INTEL_FAM6_KABYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
@@ -5006,7 +5006,7 @@ __init int intel_pmu_init(void)
 		pmem = true;
 		/* fall through */
 	case INTEL_FAM6_ICELAKE_MOBILE:
-	case INTEL_FAM6_ICELAKE_DESKTOP:
+	case INTEL_FAM6_ICELAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -593,40 +593,40 @@ static const struct x86_cpu_id intel_cst
 	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE_X, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_CORE, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL,      snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X,	   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_GT3E, snb_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_ULT, hswult_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT, slm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT,   slm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_X, slm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT,     slm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT,      slm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_CORE,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL,        snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_XEON_D, snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_GT3E,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X,      snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_MOBILE,  snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_DESKTOP, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_MOBILE, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,        snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X,      snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  hswult_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,        hswult_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNL, knl_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT,   glm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_X, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_MOBILE, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_DESKTOP, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,        snb_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -204,7 +204,7 @@ static int __init pt_pmu_hw_init(void)
 
 	/* model-specific quirks */
 	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_BROADWELL_X:
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -720,27 +720,27 @@ static const struct x86_cpu_id rapl_mode
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X,		model_snbep),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,		model_snb),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE_X,		model_snbep),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_CORE,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_ULT,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_CORE,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_DESKTOP,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE,	model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,	model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE,		model_skl),
 	{},
 };
 
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1451,10 +1451,10 @@ static const struct x86_cpu_id intel_unc
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_WESTMERE_EP,	  nhm_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE,	  snb_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,	  ivb_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_CORE,	  hsw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_ULT,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,	  hsw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_CORE, bdw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL,	  bdw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E, bdw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X,  snbep_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM_EX,	  nhmex_uncore_init),
@@ -1465,14 +1465,14 @@ static const struct x86_cpu_id intel_unc
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D, bdx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,	  knl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_DESKTOP,skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,      skx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI, icl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_X, snr_uncore_init),
 	{},
 };
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -59,12 +59,12 @@ static bool test_intel(int idx, void *da
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE_X:
 
-	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_ULT:
 	case INTEL_FAM6_HASWELL_GT3E:
 
-	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_XEON_D:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_BROADWELL_X:
@@ -85,10 +85,10 @@ static bool test_intel(int idx, void *da
 		break;
 
 	case INTEL_FAM6_SKYLAKE_MOBILE:
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
-	case INTEL_FAM6_KABYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE:
 	case INTEL_FAM6_ICELAKE_MOBILE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -49,27 +49,27 @@
 #define INTEL_FAM6_IVYBRIDGE		0x3A
 #define INTEL_FAM6_IVYBRIDGE_X		0x3E
 
-#define INTEL_FAM6_HASWELL_CORE		0x3C
+#define INTEL_FAM6_HASWELL		0x3C
 #define INTEL_FAM6_HASWELL_X		0x3F
 #define INTEL_FAM6_HASWELL_ULT		0x45
 #define INTEL_FAM6_HASWELL_GT3E		0x46
 
-#define INTEL_FAM6_BROADWELL_CORE	0x3D
+#define INTEL_FAM6_BROADWELL		0x3D
 #define INTEL_FAM6_BROADWELL_GT3E	0x47
 #define INTEL_FAM6_BROADWELL_X		0x4F
 #define INTEL_FAM6_BROADWELL_XEON_D	0x56
 
 #define INTEL_FAM6_SKYLAKE_MOBILE	0x4E
-#define INTEL_FAM6_SKYLAKE_DESKTOP	0x5E
+#define INTEL_FAM6_SKYLAKE		0x5E
 #define INTEL_FAM6_SKYLAKE_X		0x55
 #define INTEL_FAM6_KABYLAKE_MOBILE	0x8E
-#define INTEL_FAM6_KABYLAKE_DESKTOP	0x9E
+#define INTEL_FAM6_KABYLAKE		0x9E
 
 #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
 
 #define INTEL_FAM6_ICELAKE_X		0x6A
 #define INTEL_FAM6_ICELAKE_XEON_D	0x6C
-#define INTEL_FAM6_ICELAKE_DESKTOP	0x7D
+#define INTEL_FAM6_ICELAKE		0x7D
 #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
 #define INTEL_FAM6_ICELAKE_NNPI		0x9D
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -593,18 +593,18 @@ static const struct x86_cpu_id deadline_
 	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_BROADWELL_XEON_D,	bdx_deadline_rev),
 	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_SKYLAKE_X,	skx_deadline_rev),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_CORE,	0x22),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL,		0x22),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_ULT,	0x20),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_GT3E,	0x17),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_CORE,	0x25),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL,	0x25),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_GT3E,	0x17),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_MOBILE,	0xb2),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_DESKTOP,	0xb2),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE,		0xb2),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_MOBILE,	0x52),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_DESKTOP,	0x52),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE,		0x52),
 
 	{},
 };
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1184,15 +1184,15 @@ static void override_cache_bits(struct c
 	case INTEL_FAM6_WESTMERE:
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_ULT:
 	case INTEL_FAM6_HASWELL_GT3E:
-	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_SKYLAKE_MOBILE:
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
-	case INTEL_FAM6_KABYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE:
 		if (c->x86_cache_bits < 44)
 			c->x86_cache_bits = 44;
 		break;
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -142,21 +142,21 @@ struct sku_microcode {
 	u32 microcode;
 };
 static const struct sku_microcode spectre_bad_microcodes[] = {
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x80 },
+	{ INTEL_FAM6_KABYLAKE,		0x0B,	0x80 },
+	{ INTEL_FAM6_KABYLAKE,		0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE,		0x09,	0x80 },
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x80 },
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
+	{ INTEL_FAM6_BROADWELL,		0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
 	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
 	{ INTEL_FAM6_HASWELL_ULT,	0x01,	0x21 },
 	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
-	{ INTEL_FAM6_HASWELL_CORE,	0x03,	0x23 },
+	{ INTEL_FAM6_HASWELL,		0x03,	0x23 },
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
 	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1867,12 +1867,12 @@ static const struct pstate_funcs knl_fun
 			(unsigned long)&policy }
 
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
-	ICPU(INTEL_FAM6_SANDYBRIDGE, 		core_funcs),
+	ICPU(INTEL_FAM6_SANDYBRIDGE,		core_funcs),
 	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		core_funcs),
 	ICPU(INTEL_FAM6_ATOM_SILVERMONT,	silvermont_funcs),
 	ICPU(INTEL_FAM6_IVYBRIDGE,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_CORE,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_CORE,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL,		core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL,		core_funcs),
 	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_ULT,		core_funcs),
@@ -1881,7 +1881,7 @@ static const struct x86_cpu_id intel_pst
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
@@ -1900,13 +1900,13 @@ static const struct x86_cpu_id intel_pst
 };
 
 static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
-	ICPU(INTEL_FAM6_KABYLAKE_DESKTOP, core_funcs),
+	ICPU(INTEL_FAM6_KABYLAKE, core_funcs),
 	{}
 };
 
 static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
 	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE, core_funcs),
 	{}
 };
 
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1072,19 +1072,19 @@ static const struct x86_cpu_id intel_idl
 	INTEL_CPU_FAM6(ATOM_AIRMONT,		idle_cpu_cht),
 	INTEL_CPU_FAM6(IVYBRIDGE,		idle_cpu_ivb),
 	INTEL_CPU_FAM6(IVYBRIDGE_X,		idle_cpu_ivt),
-	INTEL_CPU_FAM6(HASWELL_CORE,		idle_cpu_hsw),
+	INTEL_CPU_FAM6(HASWELL,			idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_X,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_ULT,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_GT3E,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_X,	idle_cpu_avn),
-	INTEL_CPU_FAM6(BROADWELL_CORE,		idle_cpu_bdw),
+	INTEL_CPU_FAM6(BROADWELL,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_GT3E,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_X,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_XEON_D,	idle_cpu_bdw),
 	INTEL_CPU_FAM6(SKYLAKE_MOBILE,		idle_cpu_skl),
-	INTEL_CPU_FAM6(SKYLAKE_DESKTOP,		idle_cpu_skl),
+	INTEL_CPU_FAM6(SKYLAKE,			idle_cpu_skl),
 	INTEL_CPU_FAM6(KABYLAKE_MOBILE,		idle_cpu_skl),
-	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	idle_cpu_skl),
+	INTEL_CPU_FAM6(KABYLAKE,		idle_cpu_skl),
 	INTEL_CPU_FAM6(SKYLAKE_X,		idle_cpu_skx),
 	INTEL_CPU_FAM6(XEON_PHI_KNL,		idle_cpu_knl),
 	INTEL_CPU_FAM6(XEON_PHI_KNM,		idle_cpu_knl),
@@ -1311,7 +1311,7 @@ static void intel_idle_state_table_updat
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		bxt_idle_state_table_update();
 		break;
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 		sklh_idle_state_table_update();
 		break;
 	}
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -807,9 +807,9 @@ static inline void pmc_core_dbgfs_unregi
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	INTEL_CPU_FAM6(SKYLAKE_MOBILE, spt_reg_map),
-	INTEL_CPU_FAM6(SKYLAKE_DESKTOP, spt_reg_map),
+	INTEL_CPU_FAM6(SKYLAKE, spt_reg_map),
 	INTEL_CPU_FAM6(KABYLAKE_MOBILE, spt_reg_map),
-	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, spt_reg_map),
+	INTEL_CPU_FAM6(KABYLAKE, spt_reg_map),
 	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
 	INTEL_CPU_FAM6(ICELAKE_MOBILE, icl_reg_map),
 	INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
--- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
+++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
@@ -31,9 +31,9 @@ static struct platform_device pmc_core_d
  */
 static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
 	INTEL_CPU_FAM6(SKYLAKE_MOBILE, pmc_core_device),
-	INTEL_CPU_FAM6(SKYLAKE_DESKTOP, pmc_core_device),
+	INTEL_CPU_FAM6(SKYLAKE, pmc_core_device),
 	INTEL_CPU_FAM6(KABYLAKE_MOBILE, pmc_core_device),
-	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, pmc_core_device),
+	INTEL_CPU_FAM6(KABYLAKE, pmc_core_device),
 	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, pmc_core_device),
 	INTEL_CPU_FAM6(ICELAKE_MOBILE, pmc_core_device),
 	{}
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -957,24 +957,24 @@ static const struct x86_cpu_id rapl_ids[
 	INTEL_CPU_FAM6(IVYBRIDGE, rapl_defaults_core),
 	INTEL_CPU_FAM6(IVYBRIDGE_X, rapl_defaults_core),
 
-	INTEL_CPU_FAM6(HASWELL_CORE, rapl_defaults_core),
+	INTEL_CPU_FAM6(HASWELL, rapl_defaults_core),
 	INTEL_CPU_FAM6(HASWELL_ULT, rapl_defaults_core),
 	INTEL_CPU_FAM6(HASWELL_GT3E, rapl_defaults_core),
 	INTEL_CPU_FAM6(HASWELL_X, rapl_defaults_hsw_server),
 
-	INTEL_CPU_FAM6(BROADWELL_CORE, rapl_defaults_core),
+	INTEL_CPU_FAM6(BROADWELL, rapl_defaults_core),
 	INTEL_CPU_FAM6(BROADWELL_GT3E, rapl_defaults_core),
 	INTEL_CPU_FAM6(BROADWELL_XEON_D, rapl_defaults_core),
 	INTEL_CPU_FAM6(BROADWELL_X, rapl_defaults_hsw_server),
 
-	INTEL_CPU_FAM6(SKYLAKE_DESKTOP, rapl_defaults_core),
+	INTEL_CPU_FAM6(SKYLAKE, rapl_defaults_core),
 	INTEL_CPU_FAM6(SKYLAKE_MOBILE, rapl_defaults_core),
 	INTEL_CPU_FAM6(SKYLAKE_X, rapl_defaults_hsw_server),
 	INTEL_CPU_FAM6(KABYLAKE_MOBILE, rapl_defaults_core),
-	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, rapl_defaults_core),
+	INTEL_CPU_FAM6(KABYLAKE, rapl_defaults_core),
 	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_MOBILE, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_DESKTOP, rapl_defaults_core),
+	INTEL_CPU_FAM6(ICELAKE, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_NNPI, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_X, rapl_defaults_hsw_server),
 	INTEL_CPU_FAM6(ICELAKE_XEON_D, rapl_defaults_hsw_server),
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3207,10 +3207,10 @@ int probe_nhm_msrs(unsigned int family,
 		pkg_cstate_limits = snb_pkg_cstate_limits;
 		has_misc_feature_control = 1;
 		break;
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
@@ -3403,10 +3403,10 @@ int has_config_tdp(unsigned int family,
 
 	switch (model) {
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
@@ -3840,9 +3840,9 @@ void rapl_probe_intel(unsigned int famil
 	switch (model) {
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		if (rapl_joules) {
@@ -4031,7 +4031,7 @@ void perf_limit_reasons_probe(unsigned i
 		return;
 
 	switch (model) {
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 		do_gfx_perf_limit_reasons = 1;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
@@ -4249,10 +4249,10 @@ int has_snb_msrs(unsigned int family, un
 	case INTEL_FAM6_SANDYBRIDGE_X:
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
 	case INTEL_FAM6_IVYBRIDGE_X:	/* IVB Xeon */
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
@@ -4284,8 +4284,8 @@ int has_hsw_msrs(unsigned int family, un
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_HASWELL_CORE:
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_HASWELL:
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
@@ -4569,16 +4569,16 @@ unsigned int intel_model_duplicates(unsi
 		return INTEL_FAM6_XEON_PHI_KNL;
 
 	case INTEL_FAM6_HASWELL_ULT:
-		return INTEL_FAM6_HASWELL_CORE;
+		return INTEL_FAM6_HASWELL;
 
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 		return INTEL_FAM6_BROADWELL_X;
 
 	case INTEL_FAM6_SKYLAKE_MOBILE:
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
-	case INTEL_FAM6_KABYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE:
 		return INTEL_FAM6_SKYLAKE_MOBILE;
 
 	case INTEL_FAM6_ICELAKE_MOBILE:


