Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B39CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F842184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfHZLqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:46:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39619 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbfHZLqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:46:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2DRt-00011c-Gx; Mon, 26 Aug 2019 13:46:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 32C1F1C0DDA;
        Mon, 26 Aug 2019 13:46:13 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:46:13 -0000
From:   tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/intel: Aggregate big core mobile naming
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190822102411.225140918@infradead.org>
References: <20190822102411.225140918@infradead.org>
MIME-Version: 1.0
Message-ID: <156681997312.3420.12838990758084786057.tip-bot2@tip-bot2>
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

Commit-ID:     2c1ce2da5925a725fa6a4b9561304fb61ed1f31f
Gitweb:        https://git.kernel.org/tip/2c1ce2da5925a725fa6a4b9561304fb61ed1f31f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 22 Aug 2019 12:23:08 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Aug 2019 11:21:11 +02:00

x86/cpu/intel: Aggregate big core mobile naming

Currently big core mobile chips have either:

 - _L
 - _ULT
 - _MOBILE

Make it uniformly: _L.

  for i in `git grep -l "INTEL_FAM6_.*_\(MOBILE\|ULT\)"`
  do
	sed -i -e 's/\(INTEL_FAM6_.*\)_\(MOBILE\|ULT\)/\1_L/g' ${i}
  done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Link: http://lkml.kernel.org/r/20190822102411.225140918@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c          | 20 ++++++-------
 arch/x86/events/intel/cstate.c        | 18 ++++++------
 arch/x86/events/intel/rapl.c          | 10 +++----
 arch/x86/events/intel/uncore.c        |  8 ++---
 arch/x86/events/msr.c                 |  8 ++---
 arch/x86/include/asm/intel-family.h   | 10 +++----
 arch/x86/kernel/apic/apic.c           |  6 ++--
 arch/x86/kernel/cpu/bugs.c            |  6 ++--
 arch/x86/kernel/cpu/intel.c           |  6 ++--
 drivers/acpi/x86/utils.c              |  4 +--
 drivers/cpufreq/intel_pstate.c        |  4 +--
 tools/power/x86/turbostat/turbostat.c | 40 +++++++++++++-------------
 12 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 76bff3a..22ef9cc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3965,7 +3965,7 @@ static __init void intel_clovertown_quirk(void)
 
 static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL,		 3, 0x0000001f),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_ULT,		 1, 0x0000001e),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_L,		 1, 0x0000001e),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_GT3E,		 1, 0x00000015),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
 	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
@@ -3978,13 +3978,13 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 2, 0x0b000014),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_MOBILE,	 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_L,		 3, 0x0000007c),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE,		 3, 0x0000007c),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		12, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		10, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		11, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		12, 0x0000004e),
@@ -4859,7 +4859,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
-	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_L:
 	case INTEL_FAM6_HASWELL_GT3E:
 		x86_add_quirk(intel_ht_bug);
 		x86_add_quirk(intel_pebs_isolation_quirk);
@@ -4955,9 +4955,9 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_SKYLAKE_X:
 		pmem = true;
 		/* fall through */
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
@@ -5005,7 +5005,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ICELAKE_XEON_D:
 		pmem = true;
 		/* fall through */
-	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_L:
 	case INTEL_FAM6_ICELAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 3854400..9b014e8 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -597,7 +597,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X,	   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_GT3E, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_ULT, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_L, hswult_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT,   slm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_X, slm_cstates),
@@ -608,14 +608,14 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_GT3E,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X,      snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_MOBILE, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,        snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X,      snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_L, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE, hswult_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,        hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_L, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,   hswult_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_L, cnl_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNL, knl_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
@@ -625,8 +625,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_MOBILE, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,        snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   snb_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index c1278e2..70dcfe9 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -722,7 +722,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE_X,		model_snbep),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_X,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_ULT,		model_hsw),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_L,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E,		model_hsw),
@@ -730,16 +730,16 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,		model_knl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE,		model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE,		model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE,		model_skl),
 	{},
 };
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d5e0915..8428e28 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1452,7 +1452,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE,	  snb_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,	  ivb_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL,	  hsw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_ULT,	  hsw_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_L,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E,	  hsw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL,	  bdw_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E, bdw_uncore_init),
@@ -1466,11 +1466,11 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE,	  skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE, skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_L,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,      skx_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_L,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE,	  skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_X, snr_uncore_init),
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 08d320a..12265c1 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -61,7 +61,7 @@ static bool test_intel(int idx, void *data)
 
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_HASWELL_X:
-	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_L:
 	case INTEL_FAM6_HASWELL_GT3E:
 
 	case INTEL_FAM6_BROADWELL:
@@ -84,12 +84,12 @@ static bool test_intel(int idx, void *data)
 			return true;
 		break;
 
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_SKYLAKE_X:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
-	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_L:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 800dd17..25b71d4 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -51,7 +51,7 @@
 
 #define INTEL_FAM6_HASWELL		0x3C
 #define INTEL_FAM6_HASWELL_X		0x3F
-#define INTEL_FAM6_HASWELL_ULT		0x45
+#define INTEL_FAM6_HASWELL_L		0x45
 #define INTEL_FAM6_HASWELL_GT3E		0x46
 
 #define INTEL_FAM6_BROADWELL		0x3D
@@ -59,18 +59,18 @@
 #define INTEL_FAM6_BROADWELL_X		0x4F
 #define INTEL_FAM6_BROADWELL_XEON_D	0x56
 
-#define INTEL_FAM6_SKYLAKE_MOBILE	0x4E
+#define INTEL_FAM6_SKYLAKE_L		0x4E
 #define INTEL_FAM6_SKYLAKE		0x5E
 #define INTEL_FAM6_SKYLAKE_X		0x55
-#define INTEL_FAM6_KABYLAKE_MOBILE	0x8E
+#define INTEL_FAM6_KABYLAKE_L		0x8E
 #define INTEL_FAM6_KABYLAKE		0x9E
 
-#define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
+#define INTEL_FAM6_CANNONLAKE_L		0x66
 
 #define INTEL_FAM6_ICELAKE_X		0x6A
 #define INTEL_FAM6_ICELAKE_XEON_D	0x6C
 #define INTEL_FAM6_ICELAKE		0x7D
-#define INTEL_FAM6_ICELAKE_MOBILE	0x7E
+#define INTEL_FAM6_ICELAKE_L		0x7E
 #define INTEL_FAM6_ICELAKE_NNPI		0x9D
 
 /* "Small Core" Processors (Atom) */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 0527465..adf001d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -594,16 +594,16 @@ static const struct x86_cpu_id deadline_match[] = {
 	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_SKYLAKE_X,	skx_deadline_rev),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL,		0x22),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_ULT,	0x20),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_L,	0x20),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_GT3E,	0x17),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL,	0x25),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_GT3E,	0x17),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_MOBILE,	0xb2),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_L,	0xb2),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE,		0xb2),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_MOBILE,	0x52),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_L,	0x52),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE,		0x52),
 
 	{},
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6c611ab..f435780 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1185,13 +1185,13 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL:
-	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_L:
 	case INTEL_FAM6_HASWELL_GT3E:
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_GT3E:
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
 		if (c->x86_cache_bits < 44)
 			c->x86_cache_bits = 44;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index ca62563..bafa273 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -145,8 +145,8 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
 	{ INTEL_FAM6_KABYLAKE,		0x0B,	0x80 },
 	{ INTEL_FAM6_KABYLAKE,		0x0A,	0x80 },
 	{ INTEL_FAM6_KABYLAKE,		0x09,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_L,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_L,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
 	{ INTEL_FAM6_BROADWELL,		0x04,	0x28 },
@@ -154,7 +154,7 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
 	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
-	{ INTEL_FAM6_HASWELL_ULT,	0x01,	0x21 },
+	{ INTEL_FAM6_HASWELL_L,		0x01,	0x21 },
 	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
 	{ INTEL_FAM6_HASWELL,		0x03,	0x23 },
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index ba277cd..697a6b1 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -69,11 +69,11 @@ static const struct always_present_id always_present_ids[] = {
 	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
 	 * *and* _STA has been called at least 3 times since.
 	 */
-	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
+	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_L), {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
-	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
+	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_L), {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
 	      }),
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17cb9af..6e393aa 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1875,11 +1875,11 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_BROADWELL,		core_funcs),
 	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_X,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_ULT,		core_funcs),
+	ICPU(INTEL_FAM6_HASWELL_L,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_funcs),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE_L,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8083a35..bb1bef6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3213,8 +3213,8 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 		pkg_cstate_limits = hsw_pkg_cstate_limits;
 		has_misc_feature_control = 1;
 		break;
@@ -3409,8 +3409,8 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 
 	case INTEL_FAM6_XEON_PHI_KNL:	/* Knights Landing */
@@ -3863,8 +3863,8 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 		else
 			BIC_PRESENT(BIC_PkgWatt);
 		break;
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		BIC_PRESENT(BIC_PKG__);
 		BIC_PRESENT(BIC_RAM__);
@@ -4255,8 +4255,8 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
@@ -4286,8 +4286,8 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 	switch (model) {
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		return 1;
@@ -4309,8 +4309,8 @@ int has_skl_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 		return 1;
 	}
 	return 0;
@@ -4345,7 +4345,7 @@ int is_cnl(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_CANNONLAKE_MOBILE: /* CNL */
+	case INTEL_FAM6_CANNONLAKE_L: /* CNL */
 		return 1;
 	}
 
@@ -4568,21 +4568,21 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_XEON_PHI_KNM:
 		return INTEL_FAM6_XEON_PHI_KNL;
 
-	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_L:
 		return INTEL_FAM6_HASWELL;
 
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 		return INTEL_FAM6_BROADWELL_X;
 
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
-		return INTEL_FAM6_SKYLAKE_MOBILE;
+		return INTEL_FAM6_SKYLAKE_L;
 
-	case INTEL_FAM6_ICELAKE_MOBILE:
-		return INTEL_FAM6_CANNONLAKE_MOBILE;
+	case INTEL_FAM6_ICELAKE_L:
+		return INTEL_FAM6_CANNONLAKE_L;
 	}
 	return model;
 }
@@ -4731,7 +4731,7 @@ void process_cpuid()
 
 			if (crystal_hz == 0)
 				switch(model) {
-				case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
+				case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 					crystal_hz = 24000000;	/* 24.0 MHz */
 					break;
 				case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
