Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A404DC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C19C23405
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LIyv+81g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbfHVK1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:27:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732978AbfHVK1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K+8shEmO+pbB5uHLaBfMa6pCwO2tATlhpolQyhfZIlM=; b=LIyv+81gbblyDHvRzBAeuknLf1
        LDW0C270AvbxTxR+9eKCkHYgwAcicbPB/agyKyIe1k9DT07JwIX3IpScCZwKAkaEFVc5KLFD9RKmu
        wm6TPELu1uh0bxsyW8twLSqOoL2r0lk4rZ/4cHrRHVu+kHBCZzUFeXZI8VYz0KbgeapST/aCmDas+
        +pcRvDQ5n0iIedLRYH9EkMY2CRE26ezRzTQDJErIRuGjtNXSPBCt808Fk4u/0cQxNBQJF03auJSV9
        TnA/qqzK5rLPt5/sDVHQ3Yenuwwj71JusUsQeeZ+kmgPny6JoWt/8j26xpDmqBisESy3ZREgWZ87g
        OnmTYUMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0kIu-0008DO-Ne; Thu, 22 Aug 2019 10:26:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A152307765;
        Thu, 22 Aug 2019 12:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 69B36202D5814; Thu, 22 Aug 2019 12:26:50 +0200 (CEST)
Message-Id: <20190822102411.337145504@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 22 Aug 2019 12:23:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4/5] x86/intel: Aggregate microserver naming
References: <20190822102306.109718810@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently big microservers have _XEON_D while small microservers have
_X, Make it uniformly: _D.

for i in `git grep -l "INTEL_FAM6_.*_\(X\|XEON_D\)"`
do
	sed -i -e 's/\(INTEL_FAM6_ATOM_.*\)_X/\1_D/g' \
               -e 's/\(INTEL_FAM6_.*\)_XEON_D/\1_D/g' ${i}
done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/events/intel/core.c          |   20 ++++++++++----------
 arch/x86/events/intel/cstate.c        |   12 ++++++------
 arch/x86/events/intel/pt.c            |    2 +-
 arch/x86/events/intel/rapl.c          |    4 ++--
 arch/x86/events/intel/uncore.c        |    4 ++--
 arch/x86/events/msr.c                 |    6 +++---
 arch/x86/include/asm/intel-family.h   |   10 +++++-----
 arch/x86/kernel/apic/apic.c           |    2 +-
 arch/x86/kernel/cpu/intel.c           |    4 ++--
 arch/x86/kernel/cpu/mce/intel.c       |    2 +-
 arch/x86/kernel/tsc.c                 |    2 +-
 drivers/cpufreq/intel_pstate.c        |    6 +++---
 drivers/edac/i10nm_base.c             |    4 ++--
 drivers/edac/pnd2_edac.c              |    2 +-
 tools/power/x86/turbostat/turbostat.c |   22 +++++++++++-----------
 15 files changed, 51 insertions(+), 51 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3971,10 +3971,10 @@ static const struct x86_cpu_desc isolati
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL,		 4, 0x00000023),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_G,		 1, 0x00000014),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 2, 0x00000010),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 3, 0x07000009),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 4, 0x0f000009),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 5, 0x0e000002),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 2, 0x00000010),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 3, 0x07000009),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 4, 0x0f000009),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 5, 0x0e000002),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 2, 0x0b000014),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
@@ -4146,7 +4146,7 @@ static const struct x86_cpu_desc counter
 	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT,	 2, 0x0000000e),
 	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT,	 9, 0x0000002e),
 	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT,	10, 0x00000008),
-	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_X,	 1, 0x00000028),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_D,	 1, 0x00000028),
 	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	 1, 0x00000028),
 	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	 8, 0x00000006),
 	{}
@@ -4643,7 +4643,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_SILVERMONT:
-	case INTEL_FAM6_ATOM_SILVERMONT_X:
+	case INTEL_FAM6_ATOM_SILVERMONT_D:
 	case INTEL_FAM6_ATOM_SILVERMONT_MID:
 	case INTEL_FAM6_ATOM_AIRMONT:
 	case INTEL_FAM6_ATOM_AIRMONT_MID:
@@ -4665,7 +4665,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GOLDMONT_X:
+	case INTEL_FAM6_ATOM_GOLDMONT_D:
 		x86_add_quirk(intel_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glm_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
@@ -4721,7 +4721,7 @@ __init int intel_pmu_init(void)
 		name = "goldmont_plus";
 		break;
 
-	case INTEL_FAM6_ATOM_TREMONT_X:
+	case INTEL_FAM6_ATOM_TREMONT_D:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
@@ -4891,7 +4891,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_XEON_D:
+	case INTEL_FAM6_BROADWELL_D:
 	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 		x86_add_quirk(intel_pebs_isolation_quirk);
@@ -5002,7 +5002,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ICELAKE_X:
-	case INTEL_FAM6_ICELAKE_XEON_D:
+	case INTEL_FAM6_ICELAKE_D:
 		pmem = true;
 		/* fall through */
 	case INTEL_FAM6_ICELAKE_L:
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -600,13 +600,13 @@ static const struct x86_cpu_id intel_cst
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_L, hswult_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT,   slm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_X, slm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_D, slm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT,      slm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL,        snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_XEON_D, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_G,      snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X,      snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_D, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_G, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X, snb_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_L, snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,   snb_cstates),
@@ -621,7 +621,7 @@ static const struct x86_cpu_id intel_cst
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT,   glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_X, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_D, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -205,7 +205,7 @@ static int __init pt_pmu_hw_init(void)
 	/* model-specific quirks */
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_XEON_D:
+	case INTEL_FAM6_BROADWELL_D:
 	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 		/* not setting BRANCH_EN will #GP, erratum BDM106 */
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -727,7 +727,7 @@ static const struct x86_cpu_id rapl_mode
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_G,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_D,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_L,		model_skl),
@@ -737,7 +737,7 @@ static const struct x86_cpu_id rapl_mode
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X,	model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_D,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE,		model_skl),
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1462,7 +1462,7 @@ static const struct x86_cpu_id intel_unc
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE_X,	  ivbep_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_X,	  hswep_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,	  bdx_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D, bdx_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_D,	  bdx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE,	  skl_uncore_init),
@@ -1473,7 +1473,7 @@ static const struct x86_cpu_id intel_unc
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_X, snr_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_D, snr_uncore_init),
 	{},
 };
 
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -65,16 +65,16 @@ static bool test_intel(int idx, void *da
 	case INTEL_FAM6_HASWELL_G:
 
 	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_XEON_D:
+	case INTEL_FAM6_BROADWELL_D:
 	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 
 	case INTEL_FAM6_ATOM_SILVERMONT:
-	case INTEL_FAM6_ATOM_SILVERMONT_X:
+	case INTEL_FAM6_ATOM_SILVERMONT_D:
 	case INTEL_FAM6_ATOM_AIRMONT:
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GOLDMONT_X:
+	case INTEL_FAM6_ATOM_GOLDMONT_D:
 
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -57,7 +57,7 @@
 #define INTEL_FAM6_BROADWELL		0x3D
 #define INTEL_FAM6_BROADWELL_G		0x47
 #define INTEL_FAM6_BROADWELL_X		0x4F
-#define INTEL_FAM6_BROADWELL_XEON_D	0x56
+#define INTEL_FAM6_BROADWELL_D		0x56
 
 #define INTEL_FAM6_SKYLAKE_L		0x4E
 #define INTEL_FAM6_SKYLAKE		0x5E
@@ -68,7 +68,7 @@
 #define INTEL_FAM6_CANNONLAKE_L		0x66
 
 #define INTEL_FAM6_ICELAKE_X		0x6A
-#define INTEL_FAM6_ICELAKE_XEON_D	0x6C
+#define INTEL_FAM6_ICELAKE_D		0x6C
 #define INTEL_FAM6_ICELAKE		0x7D
 #define INTEL_FAM6_ICELAKE_L		0x7E
 #define INTEL_FAM6_ICELAKE_NNPI		0x9D
@@ -83,17 +83,17 @@
 #define INTEL_FAM6_ATOM_SALTWELL_TABLET	0x35 /* Cloverview */
 
 #define INTEL_FAM6_ATOM_SILVERMONT	0x37 /* Bay Trail, Valleyview */
-#define INTEL_FAM6_ATOM_SILVERMONT_X	0x4D /* Avaton, Rangely */
+#define INTEL_FAM6_ATOM_SILVERMONT_D	0x4D /* Avaton, Rangely */
 #define INTEL_FAM6_ATOM_SILVERMONT_MID	0x4A /* Merriefield */
 
 #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
 #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
 
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
-#define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denverton */
+#define INTEL_FAM6_ATOM_GOLDMONT_D	0x5F /* Denverton */
 #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
 
-#define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
+#define INTEL_FAM6_ATOM_TREMONT_D	0x86 /* Jacobsville */
 
 /* Xeon Phi */
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -590,7 +590,7 @@ static u32 skx_deadline_rev(void)
 static const struct x86_cpu_id deadline_match[] = {
 	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_HASWELL_X,	hsx_deadline_rev),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_X,	0x0b000020),
-	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_BROADWELL_XEON_D,	bdx_deadline_rev),
+	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_BROADWELL_D,	bdx_deadline_rev),
 	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_SKYLAKE_X,	skx_deadline_rev),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL,		0x22),
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -151,8 +151,8 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
 	{ INTEL_FAM6_BROADWELL,		0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_G,	0x01,	0x1b },
-	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
-	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
+	{ INTEL_FAM6_BROADWELL_D,	0x02,	0x14 },
+	{ INTEL_FAM6_BROADWELL_D,	0x03,	0x07000011 },
 	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
 	{ INTEL_FAM6_HASWELL_L,		0x01,	0x21 },
 	{ INTEL_FAM6_HASWELL_G,		0x01,	0x18 },
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -479,7 +479,7 @@ static void intel_ppin_init(struct cpuin
 	switch (c->x86_model) {
 	case INTEL_FAM6_IVYBRIDGE_X:
 	case INTEL_FAM6_HASWELL_X:
-	case INTEL_FAM6_BROADWELL_XEON_D:
+	case INTEL_FAM6_BROADWELL_D:
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_XEON_PHI_KNL:
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -638,7 +638,7 @@ unsigned long native_calibrate_tsc(void)
 	 * clock.
 	 */
 	if (crystal_khz == 0 &&
-			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_X)
+			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_D)
 		crystal_khz = 25000;
 
 	/*
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1882,7 +1882,7 @@ static const struct x86_cpu_id intel_pst
 	ICPU(INTEL_FAM6_SKYLAKE_L,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_D,		core_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		core_funcs),
@@ -1893,7 +1893,7 @@ static const struct x86_cpu_id intel_pst
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
-	ICPU(INTEL_FAM6_BROADWELL_XEON_D, core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_D, core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X, core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
 	{}
@@ -2624,7 +2624,7 @@ static inline void intel_pstate_request_
 
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
 	ICPU_HWP(INTEL_FAM6_BROADWELL_X, INTEL_PSTATE_HWP_BROADWELL),
-	ICPU_HWP(INTEL_FAM6_BROADWELL_XEON_D, INTEL_PSTATE_HWP_BROADWELL),
+	ICPU_HWP(INTEL_FAM6_BROADWELL_D, INTEL_PSTATE_HWP_BROADWELL),
 	ICPU_HWP(X86_MODEL_ANY, 0),
 	{}
 };
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -123,9 +123,9 @@ static int i10nm_get_all_munits(void)
 }
 
 static const struct x86_cpu_id i10nm_cpuids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_TREMONT_X, 0, 0 },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_TREMONT_D, 0, 0 },
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ICELAKE_X, 0, 0 },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ICELAKE_XEON_D, 0, 0 },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ICELAKE_D, 0, 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1533,7 +1533,7 @@ static struct dunit_ops dnv_ops = {
 
 static const struct x86_cpu_id pnd2_cpuids[] = {
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_GOLDMONT, 0, (kernel_ulong_t)&apl_ops },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_GOLDMONT_X, 0, (kernel_ulong_t)&dnv_ops },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_GOLDMONT_D, 0, (kernel_ulong_t)&dnv_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, pnd2_cpuids);
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2150,7 +2150,7 @@ int has_turbo_ratio_group_limits(int fam
 	switch (model) {
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_SKYLAKE_X:
-	case INTEL_FAM6_ATOM_GOLDMONT_X:
+	case INTEL_FAM6_ATOM_GOLDMONT_D:
 		return 1;
 	}
 	return 0;
@@ -3224,7 +3224,7 @@ int probe_nhm_msrs(unsigned int family,
 		break;
 	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
 		no_MSR_MISC_PWR_MGMT = 1;
-	case INTEL_FAM6_ATOM_SILVERMONT_X:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT_D:	/* AVN */
 		pkg_cstate_limits = slv_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_AIRMONT:	/* AMT */
@@ -3236,7 +3236,7 @@ int probe_nhm_msrs(unsigned int family,
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
-	case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
 		pkg_cstate_limits = glm_pkg_cstate_limits;
 		break;
 	default:
@@ -3279,7 +3279,7 @@ int is_dnv(unsigned int family, unsigned
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_ATOM_GOLDMONT_X:
+	case INTEL_FAM6_ATOM_GOLDMONT_D:
 		return 1;
 	}
 	return 0;
@@ -3792,7 +3792,7 @@ double get_tdp_intel(unsigned int model)
 
 	switch (model) {
 	case INTEL_FAM6_ATOM_SILVERMONT:
-	case INTEL_FAM6_ATOM_SILVERMONT_X:
+	case INTEL_FAM6_ATOM_SILVERMONT_D:
 		return 30.0;
 	default:
 		return 135.0;
@@ -3911,7 +3911,7 @@ void rapl_probe_intel(unsigned int famil
 		}
 		break;
 	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
-	case INTEL_FAM6_ATOM_SILVERMONT_X:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT_D:	/* AVN */
 		do_rapl = RAPL_PKG | RAPL_CORES;
 		if (rapl_joules) {
 			BIC_PRESENT(BIC_Pkg_J);
@@ -3921,7 +3921,7 @@ void rapl_probe_intel(unsigned int famil
 			BIC_PRESENT(BIC_CorWatt);
 		}
 		break;
-	case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO | RAPL_CORES_ENERGY_STATUS;
 		BIC_PRESENT(BIC_PKG__);
 		BIC_PRESENT(BIC_RAM__);
@@ -4260,7 +4260,7 @@ int has_snb_msrs(unsigned int family, un
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
-	case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
 		return 1;
 	}
 	return 0;
@@ -4322,7 +4322,7 @@ int is_slm(unsigned int family, unsigned
 		return 0;
 	switch (model) {
 	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
-	case INTEL_FAM6_ATOM_SILVERMONT_X:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT_D:	/* AVN */
 		return 1;
 	}
 	return 0;
@@ -4572,7 +4572,7 @@ unsigned int intel_model_duplicates(unsi
 		return INTEL_FAM6_HASWELL;
 
 	case INTEL_FAM6_BROADWELL_X:
-	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
+	case INTEL_FAM6_BROADWELL_D:	/* BDX-DE */
 		return INTEL_FAM6_BROADWELL_X;
 
 	case INTEL_FAM6_SKYLAKE_L:
@@ -4734,7 +4734,7 @@ void process_cpuid()
 				case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 					crystal_hz = 24000000;	/* 24.0 MHz */
 					break;
-				case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
+				case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
 					crystal_hz = 25000000;	/* 25.0 MHz */
 					break;
 				case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */


