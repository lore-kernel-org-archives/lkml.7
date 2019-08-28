Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C92C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C274F2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfH1NEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:04:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47102 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfH1NER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:04:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2xcE-0003gM-3O; Wed, 28 Aug 2019 15:03:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 97D0A1C07D2;
        Wed, 28 Aug 2019 15:03:57 +0200 (CEST)
Date:   Wed, 28 Aug 2019 13:03:57 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/intel: Aggregate big core client naming
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190827195122.513945586@infradead.org>
References: <20190827195122.513945586@infradead.org>
MIME-Version: 1.0
Message-ID: <156699743743.784.11575156992290212839.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c66f78a6de4de6cb520b15cf6a1b586617b9add5
Gitweb:        https://git.kernel.org/tip/c66f78a6de4de6cb520b15cf6a1b586617b9add5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 27 Aug 2019 21:48:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Aug 2019 11:29:31 +02:00

x86/intel: Aggregate big core client naming

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
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190827195122.513945586@infradead.org
---
 arch/x86/events/intel/core.c                 | 26 +++++++++---------
 arch/x86/events/intel/cstate.c               | 22 +++++++--------
 arch/x86/events/intel/pt.c                   |  2 +-
 arch/x86/events/intel/rapl.c                 | 10 +++----
 arch/x86/events/intel/uncore.c               | 12 ++++----
 arch/x86/events/msr.c                        |  8 ++---
 arch/x86/include/asm/intel-family.h          | 10 +++----
 arch/x86/kernel/apic/apic.c                  |  8 ++---
 arch/x86/kernel/cpu/bugs.c                   |  8 ++---
 arch/x86/kernel/cpu/intel.c                  | 10 +++----
 drivers/cpufreq/intel_pstate.c               | 12 ++++----
 drivers/idle/intel_idle.c                    | 10 +++----
 drivers/platform/x86/intel_pmc_core.c        |  4 +--
 drivers/platform/x86/intel_pmc_core_pltdrv.c |  4 +--
 drivers/powercap/intel_rapl_common.c         | 10 +++----
 tools/power/x86/turbostat/turbostat.c        | 28 +++++++++----------
 16 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 648260b..76bff3a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3964,12 +3964,12 @@ static __init void intel_clovertown_quirk(void)
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
@@ -3979,16 +3979,16 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
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
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 688592b..3854400 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -593,40 +593,40 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
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
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index d3dc227..8cb9626 100644
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
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 64ab51f..c1278e2 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -720,27 +720,27 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
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
 
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 3694a5d..d5e0915 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1451,10 +1451,10 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
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
@@ -1465,14 +1465,14 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
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
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 9431447..08d320a 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -59,12 +59,12 @@ static bool test_intel(int idx, void *data)
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
@@ -85,10 +85,10 @@ static bool test_intel(int idx, void *data)
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
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index fe7c205..800dd17 100644
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
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index aa5495d..0527465 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -593,18 +593,18 @@ static const struct x86_cpu_id deadline_match[] = {
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
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c6fa3ef..6c611ab 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1184,15 +1184,15 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
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
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8d6d92e..ca62563 100644
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
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index cc27d4c..17cb9af 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1867,12 +1867,12 @@ static const struct pstate_funcs knl_funcs = {
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
@@ -1881,7 +1881,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
@@ -1900,13 +1900,13 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
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
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index fa5ff77..f458989 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1072,19 +1072,19 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
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
@@ -1311,7 +1311,7 @@ static void intel_idle_state_table_update(void)
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		bxt_idle_state_table_update();
 		break;
-	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_SKYLAKE:
 		sklh_idle_state_table_update();
 		break;
 	}
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index c510d0d..3a82df4 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -807,9 +807,9 @@ static inline void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 
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
diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel_pmc_core_pltdrv.c
index a8754a6..52f5bcb 100644
--- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
+++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
@@ -31,9 +31,9 @@ static struct platform_device pmc_core_device = {
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
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 6df4818..7c9eb78 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -957,24 +957,24 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
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
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb..8083a35 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3207,10 +3207,10 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
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
@@ -3403,10 +3403,10 @@ int has_config_tdp(unsigned int family, unsigned int model)
 
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
@@ -3840,9 +3840,9 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
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
@@ -4031,7 +4031,7 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 		return;
 
 	switch (model) {
-	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 		do_gfx_perf_limit_reasons = 1;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
@@ -4249,10 +4249,10 @@ int has_snb_msrs(unsigned int family, unsigned int model)
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
@@ -4284,8 +4284,8 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_HASWELL_CORE:
-	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
+	case INTEL_FAM6_HASWELL:
+	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
@@ -4569,16 +4569,16 @@ unsigned int intel_model_duplicates(unsigned int model)
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
