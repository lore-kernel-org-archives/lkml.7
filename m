Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A50C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA99A20874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfHZLqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:46:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39626 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbfHZLqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:46:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2DRu-00012a-Gj; Mon, 26 Aug 2019 13:46:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2B2011C0DDA;
        Mon, 26 Aug 2019 13:46:14 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:46:14 -0000
From:   tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/intel: Aggregate microserver naming
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190822102411.337145504@infradead.org>
References: <20190822102411.337145504@infradead.org>
MIME-Version: 1.0
Message-ID: <156681997408.3426.7574180044210476879.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d5e4ef22e053072ce03951a5beed0ce5244bee81
Gitweb:        https://git.kernel.org/tip/d5e4ef22e053072ce03951a5beed0ce5244bee81
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 22 Aug 2019 12:23:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Aug 2019 11:49:04 +02:00

x86/cpu/intel: Aggregate microserver naming

Currently big microservers have _XEON_D while small microservers have
_X, Make it uniformly: _D.

  for i in `git grep -l "INTEL_FAM6_.*_\(X\|XEON_D\)"`
  do
	sed -i -e 's/\(INTEL_FAM6_ATOM_.*\)_X/\1_D/g' \
               -e 's/\(INTEL_FAM6_.*\)_XEON_D/\1_D/g' ${i}
  done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Link: http://lkml.kernel.org/r/20190822102411.337145504@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c          | 20 ++++++++++----------
 arch/x86/events/intel/cstate.c        | 12 ++++++------
 arch/x86/events/intel/pt.c            |  2 +-
 arch/x86/events/intel/rapl.c          |  4 ++--
 arch/x86/events/intel/uncore.c        |  4 ++--
 arch/x86/events/msr.c                 |  6 +++---
 arch/x86/include/asm/intel-family.h   | 10 +++++-----
 arch/x86/kernel/apic/apic.c           |  2 +-
 arch/x86/kernel/cpu/common.c          |  4 ++--
 arch/x86/kernel/cpu/intel.c           |  4 ++--
 arch/x86/kernel/cpu/mce/intel.c       |  2 +-
 arch/x86/kernel/tsc.c                 |  2 +-
 drivers/cpufreq/intel_pstate.c        |  6 +++---
 drivers/edac/i10nm_base.c             |  4 ++--
 drivers/edac/pnd2_edac.c              |  2 +-
 drivers/edac/sb_edac.c                |  2 +-
 tools/power/x86/turbostat/turbostat.c | 22 +++++++++++-----------
 17 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 472b45c..dce329c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3971,10 +3971,10 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
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
@@ -4146,7 +4146,7 @@ static const struct x86_cpu_desc counter_freezing_ucodes[] = {
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
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 03d7a40..104c093 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -600,13 +600,13 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
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
@@ -621,7 +621,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT,   glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_X, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_D, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index d0195d1..26af1f1 100644
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
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 82e2c0e..22f5843 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -727,7 +727,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_G,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_D,		model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_L,		model_skl),
@@ -737,7 +737,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X,	model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_D,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE,		model_skl),
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 5a2f237..6fc2e06 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1462,7 +1462,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE_X,	  ivbep_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_X,	  hswep_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,	  bdx_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D, bdx_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_D,	  bdx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE,	  skl_uncore_init),
@@ -1473,7 +1473,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_X, snr_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_D, snr_uncore_init),
 	{},
 };
 
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index e11fbdb..ab79d31 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -65,16 +65,16 @@ static bool test_intel(int idx, void *data)
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
 
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 0bc7f39..76dc9ab 100644
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
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c297e6d..1026138 100644
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f125bf7..b6a9e27 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1050,7 +1050,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_INTEL(ATOM_BONNELL_MID,		NO_SPECULATION),
 
 	VULNWL_INTEL(ATOM_SILVERMONT,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
-	VULNWL_INTEL(ATOM_SILVERMONT_X,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
+	VULNWL_INTEL(ATOM_SILVERMONT_D,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_SILVERMONT_MID,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_AIRMONT,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 	VULNWL_INTEL(XEON_PHI_KNL,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
@@ -1061,7 +1061,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_INTEL(ATOM_AIRMONT_MID,		NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 
 	VULNWL_INTEL(ATOM_GOLDMONT,		NO_MDS | NO_L1TF | NO_SWAPGS),
-	VULNWL_INTEL(ATOM_GOLDMONT_X,		NO_MDS | NO_L1TF | NO_SWAPGS),
+	VULNWL_INTEL(ATOM_GOLDMONT_D,		NO_MDS | NO_L1TF | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_GOLDMONT_PLUS,	NO_MDS | NO_L1TF | NO_SWAPGS),
 
 	/*
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 1d2c64b..f4b795a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -151,8 +151,8 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
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
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index e43eb67..88cd959 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -479,7 +479,7 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
 	switch (c->x86_model) {
 	case INTEL_FAM6_IVYBRIDGE_X:
 	case INTEL_FAM6_HASWELL_X:
-	case INTEL_FAM6_BROADWELL_XEON_D:
+	case INTEL_FAM6_BROADWELL_D:
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_XEON_PHI_KNL:
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 57d87f7..c59454c 100644
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
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 99b9c01..8863240 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1882,7 +1882,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_SKYLAKE_L,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_D,		core_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		core_funcs),
@@ -1893,7 +1893,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
-	ICPU(INTEL_FAM6_BROADWELL_XEON_D, core_funcs),
+	ICPU(INTEL_FAM6_BROADWELL_D, core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X, core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
 	{}
@@ -2624,7 +2624,7 @@ static inline void intel_pstate_request_control_from_smm(void) {}
 
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
 	ICPU_HWP(INTEL_FAM6_BROADWELL_X, INTEL_PSTATE_HWP_BROADWELL),
-	ICPU_HWP(INTEL_FAM6_BROADWELL_XEON_D, INTEL_PSTATE_HWP_BROADWELL),
+	ICPU_HWP(INTEL_FAM6_BROADWELL_D, INTEL_PSTATE_HWP_BROADWELL),
 	ICPU_HWP(X86_MODEL_ANY, 0),
 	{}
 };
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 83392f2..c370d54 100644
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
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index ca25f8f..a6846be 100644
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
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 37746b0..f743502 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3429,7 +3429,7 @@ static const struct x86_cpu_id sbridge_cpuids[] = {
 	INTEL_CPU_FAM6(IVYBRIDGE_X,	  pci_dev_descr_ibridge_table),
 	INTEL_CPU_FAM6(HASWELL_X,	  pci_dev_descr_haswell_table),
 	INTEL_CPU_FAM6(BROADWELL_X,	  pci_dev_descr_broadwell_table),
-	INTEL_CPU_FAM6(BROADWELL_XEON_D,  pci_dev_descr_broadwell_table),
+	INTEL_CPU_FAM6(BROADWELL_D,	  pci_dev_descr_broadwell_table),
 	INTEL_CPU_FAM6(XEON_PHI_KNL,	  pci_dev_descr_knl_table),
 	INTEL_CPU_FAM6(XEON_PHI_KNM,	  pci_dev_descr_knl_table),
 	{ }
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 271cf18..6eef0ce 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2150,7 +2150,7 @@ int has_turbo_ratio_group_limits(int family, int model)
 	switch (model) {
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_SKYLAKE_X:
-	case INTEL_FAM6_ATOM_GOLDMONT_X:
+	case INTEL_FAM6_ATOM_GOLDMONT_D:
 		return 1;
 	}
 	return 0;
@@ -3224,7 +3224,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		break;
 	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
 		no_MSR_MISC_PWR_MGMT = 1;
-	case INTEL_FAM6_ATOM_SILVERMONT_X:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT_D:	/* AVN */
 		pkg_cstate_limits = slv_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_AIRMONT:	/* AMT */
@@ -3236,7 +3236,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
-	case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
 		pkg_cstate_limits = glm_pkg_cstate_limits;
 		break;
 	default:
@@ -3279,7 +3279,7 @@ int is_dnv(unsigned int family, unsigned int model)
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
@@ -3911,7 +3911,7 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 		}
 		break;
 	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
-	case INTEL_FAM6_ATOM_SILVERMONT_X:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT_D:	/* AVN */
 		do_rapl = RAPL_PKG | RAPL_CORES;
 		if (rapl_joules) {
 			BIC_PRESENT(BIC_Pkg_J);
@@ -3921,7 +3921,7 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 			BIC_PRESENT(BIC_CorWatt);
 		}
 		break;
-	case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO | RAPL_CORES_ENERGY_STATUS;
 		BIC_PRESENT(BIC_PKG__);
 		BIC_PRESENT(BIC_RAM__);
@@ -4260,7 +4260,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
-	case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
 		return 1;
 	}
 	return 0;
@@ -4322,7 +4322,7 @@ int is_slm(unsigned int family, unsigned int model)
 		return 0;
 	switch (model) {
 	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
-	case INTEL_FAM6_ATOM_SILVERMONT_X:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT_D:	/* AVN */
 		return 1;
 	}
 	return 0;
@@ -4572,7 +4572,7 @@ unsigned int intel_model_duplicates(unsigned int model)
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
