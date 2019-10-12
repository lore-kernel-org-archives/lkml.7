Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FEAC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 13:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AE5206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570887109;
	bh=2crrkV+B7+p1GyNVBaiNSz1lEt2h2DGyZw4XDOfOu/w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GBIyirIwXvGdaFO9zrCPnp5BRn04sf7R5GoEFDdD0PvwrhVVrA6YC9LF5Hr0pOtDB
	 Qu1biyyzCaCCi2xZDfBEixMbLOlqPSkmCFRF1KQw/+2ZNnoVhvSt9u7txoRllF9bkb
	 iyl6cNk2fEVBROUhRAx/bovz7dtOda3s7V1qT4oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfJLNbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 09:31:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43819 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfJLNbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 09:31:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so14717592wrq.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ve8fO89aR8DjdfZc7j3bq7WABU4KVJmL9IH3+AlHg2I=;
        b=Yul3DDHYzQ4ybUUgwu74mVs5+4wjfCx4bUpho1/VO5sZsIVdU9wDCNneoIs05i6jdi
         mR0T4Z+61gMu5Lc9bqZIh7hGEHNCnaajk/u7t9Em01dNj5uge0ESpqS0YKiCeoSh33V+
         esXcy4S1vk5HMrmq+kBgoM38WsW6MNoIJ9Ybpg2A/kH9n+/sO0F0Bcw2gGIC5W60hspz
         AoqWN9PO4WAVA1d4FC2wF5I6sllI/1ZV1ykuoTcK3yg5M14lA7rf2TW9CYG/GauRM0kz
         0O2hygZcFdccfeAkZDddxVn4o7tkJSGtRkB4APM8jQ5kzYtxM/4P7oE3d5f7zlu8rJgX
         1jtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ve8fO89aR8DjdfZc7j3bq7WABU4KVJmL9IH3+AlHg2I=;
        b=ptZd2yw3+JlWiRH9drz/bKIpObThwyFudSceW7pl/0OJUBpPD6axl3UjpBewe5g1ko
         9W52JQA9vLLiYVulCICtT4KO7KJBr5XE8V4QVf/ibAKw3taDUneNPDz+X3TjmwEuNXvs
         Cjt2pi1PEBYI8a2PxvUVmr2u8zW3BhL2KfwMAdu34uM1R4tXRHqakiFvBM9q9ZV1xsR7
         cOA9a26msauyrK2aTc9vuKNG1vzANl1MXXIFvvPk1trPfGsQaA6OV1vhAG2MiYF0zdc0
         UCrHdaYcfG6s2zJSZEXJPptTbYg5J7ivPWJltqGitpQI/pJIvxLOi3ZKH5Bednlymhwc
         LEOw==
X-Gm-Message-State: APjAAAX3RPB5aeO8Lqac+NpJQ8QyQO5gV4sfp3TxqZ474y6Qb6zBU/EK
        B2yglt8CziRBq4jhXGaBujA=
X-Google-Smtp-Source: APXvYqwtlEInyPqUIWmOUdZCW/hsmcv5FbKwd3F3akNzkz93v3SpNlwuMw2ElZ7N3ISzKBW8NGTvdA==
X-Received: by 2002:adf:ed02:: with SMTP id a2mr4367662wro.11.1570887097259;
        Sat, 12 Oct 2019 06:31:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m16sm9142906wml.11.2019.10.12.06.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 06:31:36 -0700 (PDT)
Date:   Sat, 12 Oct 2019 15:31:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20191012133134.GA101218@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 52e92f409dede388b7dc3ee13491fbf7a80db935 perf/x86/cstate: Add Tiger Lake CPU support

Mostly tooling fixes, but also a couple of updates for new Intel models 
(which are technically hw-enablement, but to users it's a fix to perf 
behavior on those new CPUs - hope this is fine), an AUX inheritance fix, 
event time-sharing fix, and a fix for lost non-perf NMI events on AMD 
systems.

 Thanks,

	Ingo

------------------>
Alexander Shishkin (1):
      perf/core: Fix inheritance of aux_output groups

Andi Kleen (2):
      perf script brstackinsn: Fix recovery from LBR/binary mismatch
      perf jevents: Fix period for Intel fixed counters

Arnaldo Carvalho de Melo (13):
      tools headers uapi: Sync drm/i915_drm.h with the kernel sources
      tools headers uapi: Sync asm-generic/mman-common.h with the kernel
      tools headers uapi: Sync linux/usbdevice_fs.h with the kernel sources
      tools headers uapi: Sync linux/fs.h with the kernel sources
      tools headers kvm: Sync kvm headers with the kernel sources
      perf tools: Propagate get_cpuid() error
      perf evsel: Fall back to global 'perf_env' in perf_evsel__env()
      perf annotate: Propagate perf_env__arch() error
      perf annotate: Fix the signedness of failure returns
      perf annotate: Propagate the symbol__annotate() error return
      perf annotate: Fix arch specific ->init() failure errors
      perf annotate: Return appropriate error code for allocation failures
      perf annotate: Don't return -1 for error when doing BPF disassembly

Ian Rogers (4):
      libsubcmd: Make _FORTIFY_SOURCE defines dependent on the feature
      perf tests: Avoid raising SEGV using an obvious NULL dereference
      perf docs: Allow man page date to be specified
      perf llvm: Don't access out-of-scope array

Kan Liang (8):
      perf/x86/intel: Add Comet Lake CPU support
      perf/x86/msr: Add Comet Lake CPU support
      perf/x86/cstate: Add Comet Lake CPU support
      perf/x86/msr: Add new CPU model numbers for Ice Lake
      perf/x86/cstate: Update C-state counters for Ice Lake
      perf/x86/intel: Add Tiger Lake CPU support
      perf/x86/msr: Add Tiger Lake CPU support
      perf/x86/cstate: Add Tiger Lake CPU support

Song Liu (2):
      perf/core: Rework memory accounting in perf_mmap()
      perf/core: Fix corner case in perf_rotate_context()

Steve MacLean (3):
      perf map: Fix overlapped map handling
      perf inject jit: Fix JIT_CODE_MOVE filename
      perf docs: Correct and clarify jitdump spec

Thomas Richter (2):
      perf vendor events s390: Add JSON transaction for machine type 8561
      perf vendor events s390: Use s390 machine name instead of type 8561

Tom Lendacky (1):
      perf/x86/amd: Change/fix NMI latency mitigation to use a timestamp


 arch/x86/events/amd/core.c                         |  30 ++--
 arch/x86/events/intel/core.c                       |   4 +
 arch/x86/events/intel/cstate.c                     |  44 +++--
 arch/x86/events/msr.c                              |   7 +
 kernel/events/core.c                               |  43 ++++-
 tools/arch/arm/include/uapi/asm/kvm.h              |   4 +-
 tools/arch/arm64/include/uapi/asm/kvm.h            |   4 +-
 tools/arch/s390/include/uapi/asm/kvm.h             |   6 +
 tools/arch/x86/include/uapi/asm/vmx.h              |   2 +
 tools/include/uapi/asm-generic/mman-common.h       |   3 +
 tools/include/uapi/drm/i915_drm.h                  |   1 +
 tools/include/uapi/linux/fs.h                      |  55 +------
 tools/include/uapi/linux/fscrypt.h                 | 181 +++++++++++++++++++++
 tools/include/uapi/linux/kvm.h                     |   3 +
 tools/include/uapi/linux/usbdevice_fs.h            |   4 +
 tools/lib/subcmd/Makefile                          |   8 +-
 tools/perf/Documentation/asciidoc.conf             |   3 +
 tools/perf/Documentation/jitdump-specification.txt |   4 +-
 tools/perf/arch/arm/annotate/instructions.c        |   4 +-
 tools/perf/arch/arm64/annotate/instructions.c      |   4 +-
 tools/perf/arch/powerpc/util/header.c              |   3 +-
 tools/perf/arch/s390/annotate/instructions.c       |   6 +-
 tools/perf/arch/s390/util/header.c                 |   9 +-
 tools/perf/arch/x86/annotate/instructions.c        |   6 +-
 tools/perf/arch/x86/util/header.c                  |   3 +-
 tools/perf/builtin-kvm.c                           |   7 +-
 tools/perf/builtin-script.c                        |   6 +-
 tools/perf/check-headers.sh                        |   1 +
 .../arch/s390/{cf_m8561 => cf_z15}/basic.json      |   0
 .../arch/s390/{cf_m8561 => cf_z15}/crypto.json     |   0
 .../arch/s390/{cf_m8561 => cf_z15}/crypto6.json    |   0
 .../arch/s390/{cf_m8561 => cf_z15}/extended.json   |   0
 .../pmu-events/arch/s390/cf_z15/transaction.json   |   7 +
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   2 +-
 tools/perf/pmu-events/jevents.c                    |  12 +-
 tools/perf/tests/perf-hooks.c                      |   3 +-
 tools/perf/util/annotate.c                         |  35 +++-
 tools/perf/util/annotate.h                         |   4 +
 tools/perf/util/evsel.c                            |   3 +-
 tools/perf/util/jitdump.c                          |   6 +-
 tools/perf/util/llvm-utils.c                       |   6 +-
 tools/perf/util/map.c                              |   3 +
 tools/perf/util/python.c                           |   6 +
 43 files changed, 411 insertions(+), 131 deletions(-)
 create mode 100644 tools/include/uapi/linux/fscrypt.h
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/basic.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto6.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/extended.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z15/transaction.json

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e7d35f60d53f..64c3e70b0556 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -5,12 +5,14 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <asm/apicdef.h>
 #include <asm/nmi.h>
 
 #include "../perf_event.h"
 
-static DEFINE_PER_CPU(unsigned int, perf_nmi_counter);
+static DEFINE_PER_CPU(unsigned long, perf_nmi_tstamp);
+static unsigned long perf_nmi_window;
 
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -641,11 +643,12 @@ static void amd_pmu_disable_event(struct perf_event *event)
  * handler when multiple PMCs are active or PMC overflow while handling some
  * other source of an NMI.
  *
- * Attempt to mitigate this by using the number of active PMCs to determine
- * whether to return NMI_HANDLED if the perf NMI handler did not handle/reset
- * any PMCs. The per-CPU perf_nmi_counter variable is set to a minimum of the
- * number of active PMCs or 2. The value of 2 is used in case an NMI does not
- * arrive at the LAPIC in time to be collapsed into an already pending NMI.
+ * Attempt to mitigate this by creating an NMI window in which un-handled NMIs
+ * received during this window will be claimed. This prevents extending the
+ * window past when it is possible that latent NMIs should be received. The
+ * per-CPU perf_nmi_tstamp will be set to the window end time whenever perf has
+ * handled a counter. When an un-handled NMI is received, it will be claimed
+ * only if arriving within that window.
  */
 static int amd_pmu_handle_irq(struct pt_regs *regs)
 {
@@ -663,21 +666,19 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	handled = x86_pmu_handle_irq(regs);
 
 	/*
-	 * If a counter was handled, record the number of possible remaining
-	 * NMIs that can occur.
+	 * If a counter was handled, record a timestamp such that un-handled
+	 * NMIs will be claimed if arriving within that window.
 	 */
 	if (handled) {
-		this_cpu_write(perf_nmi_counter,
-			       min_t(unsigned int, 2, active));
+		this_cpu_write(perf_nmi_tstamp,
+			       jiffies + perf_nmi_window);
 
 		return handled;
 	}
 
-	if (!this_cpu_read(perf_nmi_counter))
+	if (time_after(jiffies, this_cpu_read(perf_nmi_tstamp)))
 		return NMI_DONE;
 
-	this_cpu_dec(perf_nmi_counter);
-
 	return NMI_HANDLED;
 }
 
@@ -909,6 +910,9 @@ static int __init amd_core_pmu_init(void)
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
 		return 0;
 
+	/* Avoid calulating the value each time in the NMI handler */
+	perf_nmi_window = msecs_to_jiffies(100);
+
 	switch (boot_cpu_data.x86) {
 	case 0x15:
 		pr_cont("Fam15h ");
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 27ee47a7be66..fcef678c3423 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4983,6 +4983,8 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
+	case INTEL_FAM6_COMETLAKE_L:
+	case INTEL_FAM6_COMETLAKE:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
@@ -5031,6 +5033,8 @@ __init int intel_pmu_init(void)
 		/* fall through */
 	case INTEL_FAM6_ICELAKE_L:
 	case INTEL_FAM6_ICELAKE:
+	case INTEL_FAM6_TIGERLAKE_L:
+	case INTEL_FAM6_TIGERLAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9f2f39003d96..e1daf4151e11 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -45,46 +45,49 @@
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
-						CNL
+ *						CNL,KBL,CML
  *			       Scope: Core
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
- *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL
+ *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
+ *						ICL,TGL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
- *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL
+ *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
+ *						KBL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL
+ *						GLM,CNL,KBL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
- *						SKL,KNL,GLM,CNL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
- *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL
+ *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
+ *						KBL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,KBL,CNL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,KBL,GLM,CNL
+ *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL
  *			       Scope: Package (physical package)
  *
  */
@@ -544,6 +547,19 @@ static const struct cstate_model cnl_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model icl_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C6_RES) |
+				  BIT(PERF_CSTATE_CORE_C7_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C3_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES) |
+				  BIT(PERF_CSTATE_PKG_C7_RES) |
+				  BIT(PERF_CSTATE_PKG_C8_RES) |
+				  BIT(PERF_CSTATE_PKG_C9_RES) |
+				  BIT(PERF_CSTATE_PKG_C10_RES),
+};
+
 static const struct cstate_model slm_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -614,6 +630,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_L, hswult_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,   hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_COMETLAKE_L, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_COMETLAKE, hswult_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_L, cnl_cstates),
 
@@ -625,8 +643,10 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, icl_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   icl_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_TIGERLAKE_L, icl_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_TIGERLAKE, icl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index b1afc77f0704..6f86650b3f77 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -89,7 +89,14 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
+	case INTEL_FAM6_COMETLAKE_L:
+	case INTEL_FAM6_COMETLAKE:
 	case INTEL_FAM6_ICELAKE_L:
+	case INTEL_FAM6_ICELAKE:
+	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_ICELAKE_D:
+	case INTEL_FAM6_TIGERLAKE_L:
+	case INTEL_FAM6_TIGERLAKE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3f0cb82e4fbc..9ec0b0bfddbd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3779,11 +3779,23 @@ static void rotate_ctx(struct perf_event_context *ctx, struct perf_event *event)
 	perf_event_groups_insert(&ctx->flexible_groups, event);
 }
 
+/* pick an event from the flexible_groups to rotate */
 static inline struct perf_event *
-ctx_first_active(struct perf_event_context *ctx)
+ctx_event_to_rotate(struct perf_event_context *ctx)
 {
-	return list_first_entry_or_null(&ctx->flexible_active,
-					struct perf_event, active_list);
+	struct perf_event *event;
+
+	/* pick the first active flexible event */
+	event = list_first_entry_or_null(&ctx->flexible_active,
+					 struct perf_event, active_list);
+
+	/* if no active flexible event, pick the first event */
+	if (!event) {
+		event = rb_entry_safe(rb_first(&ctx->flexible_groups.tree),
+				      typeof(*event), group_node);
+	}
+
+	return event;
 }
 
 static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
@@ -3808,9 +3820,9 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
 	perf_pmu_disable(cpuctx->ctx.pmu);
 
 	if (task_rotate)
-		task_event = ctx_first_active(task_ctx);
+		task_event = ctx_event_to_rotate(task_ctx);
 	if (cpu_rotate)
-		cpu_event = ctx_first_active(&cpuctx->ctx);
+		cpu_event = ctx_event_to_rotate(&cpuctx->ctx);
 
 	/*
 	 * As per the order given at ctx_resched() first 'pop' task flexible
@@ -5668,7 +5680,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 * undo the VM accounting.
 	 */
 
-	atomic_long_sub((size >> PAGE_SHIFT) + 1, &mmap_user->locked_vm);
+	atomic_long_sub((size >> PAGE_SHIFT) + 1 - mmap_locked,
+			&mmap_user->locked_vm);
 	atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
 	free_uid(mmap_user);
 
@@ -5812,8 +5825,20 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 	user_locked = atomic_long_read(&user->locked_vm) + user_extra;
 
-	if (user_locked > user_lock_limit)
+	if (user_locked <= user_lock_limit) {
+		/* charge all to locked_vm */
+	} else if (atomic_long_read(&user->locked_vm) >= user_lock_limit) {
+		/* charge all to pinned_vm */
+		extra = user_extra;
+		user_extra = 0;
+	} else {
+		/*
+		 * charge locked_vm until it hits user_lock_limit;
+		 * charge the rest from pinned_vm
+		 */
 		extra = user_locked - user_lock_limit;
+		user_extra -= extra;
+	}
 
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
 	lock_limit >>= PAGE_SHIFT;
@@ -11862,6 +11887,10 @@ static int inherit_group(struct perf_event *parent_event,
 					    child, leader, child_ctx);
 		if (IS_ERR(child_ctr))
 			return PTR_ERR(child_ctr);
+
+		if (sub->aux_event == parent_event &&
+		    !perf_get_aux_event(child_ctr, leader))
+			return -EINVAL;
 	}
 	return 0;
 }
diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index a4217c1a5d01..2769360f195c 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -266,8 +266,10 @@ struct kvm_vcpu_events {
 #define   KVM_DEV_ARM_ITS_CTRL_RESET		4
 
 /* KVM_IRQ_LINE irq field index values */
+#define KVM_ARM_IRQ_VCPU2_SHIFT		28
+#define KVM_ARM_IRQ_VCPU2_MASK		0xf
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
-#define KVM_ARM_IRQ_TYPE_MASK		0xff
+#define KVM_ARM_IRQ_TYPE_MASK		0xf
 #define KVM_ARM_IRQ_VCPU_SHIFT		16
 #define KVM_ARM_IRQ_VCPU_MASK		0xff
 #define KVM_ARM_IRQ_NUM_SHIFT		0
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 9a507716ae2f..67c21f9bdbad 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -325,8 +325,10 @@ struct kvm_vcpu_events {
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
 
 /* KVM_IRQ_LINE irq field index values */
+#define KVM_ARM_IRQ_VCPU2_SHIFT		28
+#define KVM_ARM_IRQ_VCPU2_MASK		0xf
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
-#define KVM_ARM_IRQ_TYPE_MASK		0xff
+#define KVM_ARM_IRQ_TYPE_MASK		0xf
 #define KVM_ARM_IRQ_VCPU_SHIFT		16
 #define KVM_ARM_IRQ_VCPU_MASK		0xff
 #define KVM_ARM_IRQ_NUM_SHIFT		0
diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 47104e5b47fd..436ec7636927 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -231,6 +231,12 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_GSCB   (1UL << 9)
 #define KVM_SYNC_BPBC   (1UL << 10)
 #define KVM_SYNC_ETOKEN (1UL << 11)
+
+#define KVM_SYNC_S390_VALID_FIELDS \
+	(KVM_SYNC_PREFIX | KVM_SYNC_GPRS | KVM_SYNC_ACRS | KVM_SYNC_CRS | \
+	 KVM_SYNC_ARCH0 | KVM_SYNC_PFAULT | KVM_SYNC_VRS | KVM_SYNC_RICCB | \
+	 KVM_SYNC_FPRS | KVM_SYNC_GSCB | KVM_SYNC_BPBC | KVM_SYNC_ETOKEN)
+
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index f0b0c90dd398..f01950aa7fae 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -31,6 +31,7 @@
 #define EXIT_REASON_EXCEPTION_NMI       0
 #define EXIT_REASON_EXTERNAL_INTERRUPT  1
 #define EXIT_REASON_TRIPLE_FAULT        2
+#define EXIT_REASON_INIT_SIGNAL			3
 
 #define EXIT_REASON_PENDING_INTERRUPT   7
 #define EXIT_REASON_NMI_WINDOW          8
@@ -90,6 +91,7 @@
 	{ EXIT_REASON_EXCEPTION_NMI,         "EXCEPTION_NMI" }, \
 	{ EXIT_REASON_EXTERNAL_INTERRUPT,    "EXTERNAL_INTERRUPT" }, \
 	{ EXIT_REASON_TRIPLE_FAULT,          "TRIPLE_FAULT" }, \
+	{ EXIT_REASON_INIT_SIGNAL,           "INIT_SIGNAL" }, \
 	{ EXIT_REASON_PENDING_INTERRUPT,     "PENDING_INTERRUPT" }, \
 	{ EXIT_REASON_NMI_WINDOW,            "NMI_WINDOW" }, \
 	{ EXIT_REASON_TASK_SWITCH,           "TASK_SWITCH" }, \
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 63b1f506ea67..c160a5354eb6 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -67,6 +67,9 @@
 #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
+#define MADV_COLD	20		/* deactivate these pages */
+#define MADV_PAGEOUT	21		/* reclaim these pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 328d05e77d9f..469dc512cca3 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -521,6 +521,7 @@ typedef struct drm_i915_irq_wait {
 #define   I915_SCHEDULER_CAP_PRIORITY	(1ul << 1)
 #define   I915_SCHEDULER_CAP_PREEMPTION	(1ul << 2)
 #define   I915_SCHEDULER_CAP_SEMAPHORES	(1ul << 3)
+#define   I915_SCHEDULER_CAP_ENGINE_BUSY_STATS	(1ul << 4)
 
 #define I915_PARAM_HUC_STATUS		 42
 
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 2a616aa3f686..379a612f8f1d 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -13,6 +13,9 @@
 #include <linux/limits.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
+#ifndef __KERNEL__
+#include <linux/fscrypt.h>
+#endif
 
 /* Use of MS_* flags within the kernel is restricted to core mount(2) code. */
 #if !defined(__KERNEL__)
@@ -212,57 +215,6 @@ struct fsxattr {
 #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
 #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
 
-/*
- * File system encryption support
- */
-/* Policy provided via an ioctl on the topmost directory */
-#define FS_KEY_DESCRIPTOR_SIZE	8
-
-#define FS_POLICY_FLAGS_PAD_4		0x00
-#define FS_POLICY_FLAGS_PAD_8		0x01
-#define FS_POLICY_FLAGS_PAD_16		0x02
-#define FS_POLICY_FLAGS_PAD_32		0x03
-#define FS_POLICY_FLAGS_PAD_MASK	0x03
-#define FS_POLICY_FLAG_DIRECT_KEY	0x04	/* use master key directly */
-#define FS_POLICY_FLAGS_VALID		0x07
-
-/* Encryption algorithms */
-#define FS_ENCRYPTION_MODE_INVALID		0
-#define FS_ENCRYPTION_MODE_AES_256_XTS		1
-#define FS_ENCRYPTION_MODE_AES_256_GCM		2
-#define FS_ENCRYPTION_MODE_AES_256_CBC		3
-#define FS_ENCRYPTION_MODE_AES_256_CTS		4
-#define FS_ENCRYPTION_MODE_AES_128_CBC		5
-#define FS_ENCRYPTION_MODE_AES_128_CTS		6
-#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7 /* Removed, do not use. */
-#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8 /* Removed, do not use. */
-#define FS_ENCRYPTION_MODE_ADIANTUM		9
-
-struct fscrypt_policy {
-	__u8 version;
-	__u8 contents_encryption_mode;
-	__u8 filenames_encryption_mode;
-	__u8 flags;
-	__u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
-};
-
-#define FS_IOC_SET_ENCRYPTION_POLICY	_IOR('f', 19, struct fscrypt_policy)
-#define FS_IOC_GET_ENCRYPTION_PWSALT	_IOW('f', 20, __u8[16])
-#define FS_IOC_GET_ENCRYPTION_POLICY	_IOW('f', 21, struct fscrypt_policy)
-
-/* Parameters for passing an encryption key into the kernel keyring */
-#define FS_KEY_DESC_PREFIX		"fscrypt:"
-#define FS_KEY_DESC_PREFIX_SIZE		8
-
-/* Structure that userspace passes to the kernel keyring */
-#define FS_MAX_KEY_SIZE			64
-
-struct fscrypt_key {
-	__u32 mode;
-	__u8 raw[FS_MAX_KEY_SIZE];
-	__u32 size;
-};
-
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
  *
@@ -306,6 +258,7 @@ struct fscrypt_key {
 #define FS_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
 #define FS_HUGE_FILE_FL			0x00040000 /* Reserved for ext4 */
 #define FS_EXTENT_FL			0x00080000 /* Extents */
+#define FS_VERITY_FL			0x00100000 /* Verity protected inode */
 #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
 #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
 #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
new file mode 100644
index 000000000000..39ccfe9311c3
--- /dev/null
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * fscrypt user API
+ *
+ * These ioctls can be used on filesystems that support fscrypt.  See the
+ * "User API" section of Documentation/filesystems/fscrypt.rst.
+ */
+#ifndef _UAPI_LINUX_FSCRYPT_H
+#define _UAPI_LINUX_FSCRYPT_H
+
+#include <linux/types.h>
+
+/* Encryption policy flags */
+#define FSCRYPT_POLICY_FLAGS_PAD_4		0x00
+#define FSCRYPT_POLICY_FLAGS_PAD_8		0x01
+#define FSCRYPT_POLICY_FLAGS_PAD_16		0x02
+#define FSCRYPT_POLICY_FLAGS_PAD_32		0x03
+#define FSCRYPT_POLICY_FLAGS_PAD_MASK		0x03
+#define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04
+#define FSCRYPT_POLICY_FLAGS_VALID		0x07
+
+/* Encryption algorithms */
+#define FSCRYPT_MODE_AES_256_XTS		1
+#define FSCRYPT_MODE_AES_256_CTS		4
+#define FSCRYPT_MODE_AES_128_CBC		5
+#define FSCRYPT_MODE_AES_128_CTS		6
+#define FSCRYPT_MODE_ADIANTUM			9
+#define __FSCRYPT_MODE_MAX			9
+
+/*
+ * Legacy policy version; ad-hoc KDF and no key verification.
+ * For new encrypted directories, use fscrypt_policy_v2 instead.
+ *
+ * Careful: the .version field for this is actually 0, not 1.
+ */
+#define FSCRYPT_POLICY_V1		0
+#define FSCRYPT_KEY_DESCRIPTOR_SIZE	8
+struct fscrypt_policy_v1 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+};
+#define fscrypt_policy	fscrypt_policy_v1
+
+/*
+ * Process-subscribed "logon" key description prefix and payload format.
+ * Deprecated; prefer FS_IOC_ADD_ENCRYPTION_KEY instead.
+ */
+#define FSCRYPT_KEY_DESC_PREFIX		"fscrypt:"
+#define FSCRYPT_KEY_DESC_PREFIX_SIZE	8
+#define FSCRYPT_MAX_KEY_SIZE		64
+struct fscrypt_key {
+	__u32 mode;
+	__u8 raw[FSCRYPT_MAX_KEY_SIZE];
+	__u32 size;
+};
+
+/*
+ * New policy version with HKDF and key verification (recommended).
+ */
+#define FSCRYPT_POLICY_V2		2
+#define FSCRYPT_KEY_IDENTIFIER_SIZE	16
+struct fscrypt_policy_v2 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 __reserved[4];
+	__u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+};
+
+/* Struct passed to FS_IOC_GET_ENCRYPTION_POLICY_EX */
+struct fscrypt_get_policy_ex_arg {
+	__u64 policy_size; /* input/output */
+	union {
+		__u8 version;
+		struct fscrypt_policy_v1 v1;
+		struct fscrypt_policy_v2 v2;
+	} policy; /* output */
+};
+
+/*
+ * v1 policy keys are specified by an arbitrary 8-byte key "descriptor",
+ * matching fscrypt_policy_v1::master_key_descriptor.
+ */
+#define FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR	1
+
+/*
+ * v2 policy keys are specified by a 16-byte key "identifier" which the kernel
+ * calculates as a cryptographic hash of the key itself,
+ * matching fscrypt_policy_v2::master_key_identifier.
+ */
+#define FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER	2
+
+/*
+ * Specifies a key, either for v1 or v2 policies.  This doesn't contain the
+ * actual key itself; this is just the "name" of the key.
+ */
+struct fscrypt_key_specifier {
+	__u32 type;	/* one of FSCRYPT_KEY_SPEC_TYPE_* */
+	__u32 __reserved;
+	union {
+		__u8 __reserved[32]; /* reserve some extra space */
+		__u8 descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+		__u8 identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+	} u;
+};
+
+/* Struct passed to FS_IOC_ADD_ENCRYPTION_KEY */
+struct fscrypt_add_key_arg {
+	struct fscrypt_key_specifier key_spec;
+	__u32 raw_size;
+	__u32 __reserved[9];
+	__u8 raw[];
+};
+
+/* Struct passed to FS_IOC_REMOVE_ENCRYPTION_KEY */
+struct fscrypt_remove_key_arg {
+	struct fscrypt_key_specifier key_spec;
+#define FSCRYPT_KEY_REMOVAL_STATUS_FLAG_FILES_BUSY	0x00000001
+#define FSCRYPT_KEY_REMOVAL_STATUS_FLAG_OTHER_USERS	0x00000002
+	__u32 removal_status_flags;	/* output */
+	__u32 __reserved[5];
+};
+
+/* Struct passed to FS_IOC_GET_ENCRYPTION_KEY_STATUS */
+struct fscrypt_get_key_status_arg {
+	/* input */
+	struct fscrypt_key_specifier key_spec;
+	__u32 __reserved[6];
+
+	/* output */
+#define FSCRYPT_KEY_STATUS_ABSENT		1
+#define FSCRYPT_KEY_STATUS_PRESENT		2
+#define FSCRYPT_KEY_STATUS_INCOMPLETELY_REMOVED	3
+	__u32 status;
+#define FSCRYPT_KEY_STATUS_FLAG_ADDED_BY_SELF   0x00000001
+	__u32 status_flags;
+	__u32 user_count;
+	__u32 __out_reserved[13];
+};
+
+#define FS_IOC_SET_ENCRYPTION_POLICY		_IOR('f', 19, struct fscrypt_policy)
+#define FS_IOC_GET_ENCRYPTION_PWSALT		_IOW('f', 20, __u8[16])
+#define FS_IOC_GET_ENCRYPTION_POLICY		_IOW('f', 21, struct fscrypt_policy)
+#define FS_IOC_GET_ENCRYPTION_POLICY_EX		_IOWR('f', 22, __u8[9]) /* size + version */
+#define FS_IOC_ADD_ENCRYPTION_KEY		_IOWR('f', 23, struct fscrypt_add_key_arg)
+#define FS_IOC_REMOVE_ENCRYPTION_KEY		_IOWR('f', 24, struct fscrypt_remove_key_arg)
+#define FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS	_IOWR('f', 25, struct fscrypt_remove_key_arg)
+#define FS_IOC_GET_ENCRYPTION_KEY_STATUS	_IOWR('f', 26, struct fscrypt_get_key_status_arg)
+
+/**********************************************************************/
+
+/* old names; don't add anything new here! */
+#ifndef __KERNEL__
+#define FS_KEY_DESCRIPTOR_SIZE		FSCRYPT_KEY_DESCRIPTOR_SIZE
+#define FS_POLICY_FLAGS_PAD_4		FSCRYPT_POLICY_FLAGS_PAD_4
+#define FS_POLICY_FLAGS_PAD_8		FSCRYPT_POLICY_FLAGS_PAD_8
+#define FS_POLICY_FLAGS_PAD_16		FSCRYPT_POLICY_FLAGS_PAD_16
+#define FS_POLICY_FLAGS_PAD_32		FSCRYPT_POLICY_FLAGS_PAD_32
+#define FS_POLICY_FLAGS_PAD_MASK	FSCRYPT_POLICY_FLAGS_PAD_MASK
+#define FS_POLICY_FLAG_DIRECT_KEY	FSCRYPT_POLICY_FLAG_DIRECT_KEY
+#define FS_POLICY_FLAGS_VALID		FSCRYPT_POLICY_FLAGS_VALID
+#define FS_ENCRYPTION_MODE_INVALID	0	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_XTS	FSCRYPT_MODE_AES_256_XTS
+#define FS_ENCRYPTION_MODE_AES_256_GCM	2	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_CBC	3	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_CTS	FSCRYPT_MODE_AES_256_CTS
+#define FS_ENCRYPTION_MODE_AES_128_CBC	FSCRYPT_MODE_AES_128_CBC
+#define FS_ENCRYPTION_MODE_AES_128_CTS	FSCRYPT_MODE_AES_128_CTS
+#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7	/* removed */
+#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8	/* removed */
+#define FS_ENCRYPTION_MODE_ADIANTUM	FSCRYPT_MODE_ADIANTUM
+#define FS_KEY_DESC_PREFIX		FSCRYPT_KEY_DESC_PREFIX
+#define FS_KEY_DESC_PREFIX_SIZE		FSCRYPT_KEY_DESC_PREFIX_SIZE
+#define FS_MAX_KEY_SIZE			FSCRYPT_MAX_KEY_SIZE
+#endif /* !__KERNEL__ */
+
+#endif /* _UAPI_LINUX_FSCRYPT_H */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 5e3f12d5359e..233efbb1c81c 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -243,6 +243,8 @@ struct kvm_hyperv_exit {
 #define KVM_INTERNAL_ERROR_SIMUL_EX	2
 /* Encounter unexpected vm-exit due to delivery event. */
 #define KVM_INTERNAL_ERROR_DELIVERY_EV	3
+/* Encounter unexpected vm-exit reason */
+#define KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON	4
 
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
@@ -996,6 +998,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
 #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
 #define KVM_CAP_PMU_EVENT_FILTER 173
+#define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
index 78efe870c2b7..cf525cddeb94 100644
--- a/tools/include/uapi/linux/usbdevice_fs.h
+++ b/tools/include/uapi/linux/usbdevice_fs.h
@@ -158,6 +158,7 @@ struct usbdevfs_hub_portinfo {
 #define USBDEVFS_CAP_MMAP			0x20
 #define USBDEVFS_CAP_DROP_PRIVILEGES		0x40
 #define USBDEVFS_CAP_CONNINFO_EX		0x80
+#define USBDEVFS_CAP_SUSPEND			0x100
 
 /* USBDEVFS_DISCONNECT_CLAIM flags & struct */
 
@@ -223,5 +224,8 @@ struct usbdevfs_streams {
  * extending size of the data returned.
  */
 #define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
+#define USBDEVFS_FORBID_SUSPEND    _IO('U', 33)
+#define USBDEVFS_ALLOW_SUSPEND     _IO('U', 34)
+#define USBDEVFS_WAIT_FOR_RESUME   _IO('U', 35)
 
 #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index ed61fb3a46c0..5b2cd5e58df0 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -20,7 +20,13 @@ MAKEFLAGS += --no-print-directory
 LIBFILE = $(OUTPUT)libsubcmd.a
 
 CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fPIC
+CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
+
+ifeq ($(DEBUG),0)
+  ifeq ($(feature-fortify-source), 1)
+    CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
+  endif
+endif
 
 ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
diff --git a/tools/perf/Documentation/asciidoc.conf b/tools/perf/Documentation/asciidoc.conf
index 356b23a40339..2b62ba1e72b7 100644
--- a/tools/perf/Documentation/asciidoc.conf
+++ b/tools/perf/Documentation/asciidoc.conf
@@ -71,6 +71,9 @@ ifdef::backend-docbook[]
 [header]
 template::[header-declarations]
 <refentry>
+ifdef::perf_date[]
+<refentryinfo><date>{perf_date}</date></refentryinfo>
+endif::perf_date[]
 <refmeta>
 <refentrytitle>{mantitle}</refentrytitle>
 <manvolnum>{manvolnum}</manvolnum>
diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
index 4c62b0713651..52152d156ad9 100644
--- a/tools/perf/Documentation/jitdump-specification.txt
+++ b/tools/perf/Documentation/jitdump-specification.txt
@@ -36,8 +36,8 @@ III/ Jitdump file header format
 Each jitdump file starts with a fixed size header containing the following fields in order:
 
 
-* uint32_t magic     : a magic number tagging the file type. The value is 4-byte long and represents the string "JiTD" in ASCII form. It is 0x4A695444 or 0x4454694a depending on the endianness. The field can be used to detect the endianness of the file
-* uint32_t version   : a 4-byte value representing the format version. It is currently set to 2
+* uint32_t magic     : a magic number tagging the file type. The value is 4-byte long and represents the string "JiTD" in ASCII form. It written is as 0x4A695444. The reader will detect an endian mismatch when it reads 0x4454694a.
+* uint32_t version   : a 4-byte value representing the format version. It is currently set to 1
 * uint32_t total_size: size in bytes of file header
 * uint32_t elf_mach  : ELF architecture encoding (ELF e_machine value as specified in /usr/include/elf.h)
 * uint32_t pad1      : padding. Reserved for future use
diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
index e1d4b484cc4b..2ff6cedeb9c5 100644
--- a/tools/perf/arch/arm/annotate/instructions.c
+++ b/tools/perf/arch/arm/annotate/instructions.c
@@ -37,7 +37,7 @@ static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 
 	arm = zalloc(sizeof(*arm));
 	if (!arm)
-		return -1;
+		return ENOMEM;
 
 #define ARM_CONDS "(cc|cs|eq|ge|gt|hi|le|ls|lt|mi|ne|pl|vc|vs)"
 	err = regcomp(&arm->call_insn, "^blx?" ARM_CONDS "?$", REG_EXTENDED);
@@ -59,5 +59,5 @@ static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	regfree(&arm->call_insn);
 out_free_arm:
 	free(arm);
-	return -1;
+	return SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
 }
diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 43aa93ed8414..037e292ecd8e 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -95,7 +95,7 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 
 	arm = zalloc(sizeof(*arm));
 	if (!arm)
-		return -1;
+		return ENOMEM;
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
@@ -118,5 +118,5 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	regfree(&arm->call_insn);
 out_free_arm:
 	free(arm);
-	return -1;
+	return SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
 }
diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index b6b7bc7e31a1..3b4cdfc5efd6 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/types.h>
+#include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -30,7 +31,7 @@ get_cpuid(char *buffer, size_t sz)
 		buffer[nb-1] = '\0';
 		return 0;
 	}
-	return -1;
+	return ENOBUFS;
 }
 
 char *
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 89bb8f2c54ce..a50e70baf918 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -164,8 +164,10 @@ static int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	if (!arch->initialized) {
 		arch->initialized = true;
 		arch->associate_instruction_ops = s390__associate_ins_ops;
-		if (cpuid)
-			err = s390__cpuid_parse(arch, cpuid);
+		if (cpuid) {
+			if (s390__cpuid_parse(arch, cpuid))
+				err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+		}
 	}
 
 	return err;
diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 8b0b018d896a..7933f6871c81 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -8,6 +8,7 @@
  */
 
 #include <sys/types.h>
+#include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
@@ -54,7 +55,7 @@ int get_cpuid(char *buffer, size_t sz)
 
 	sysinfo = fopen(SYSINFO, "r");
 	if (sysinfo == NULL)
-		return -1;
+		return errno;
 
 	while ((read = getline(&line, &line_sz, sysinfo)) != -1) {
 		if (!strncmp(line, SYSINFO_MANU, strlen(SYSINFO_MANU))) {
@@ -89,7 +90,7 @@ int get_cpuid(char *buffer, size_t sz)
 
 	/* Missing manufacturer, type or model information should not happen */
 	if (!manufacturer[0] || !type[0] || !model[0])
-		return -1;
+		return EINVAL;
 
 	/*
 	 * Scan /proc/service_levels and return the CPU-MF counter facility
@@ -133,14 +134,14 @@ int get_cpuid(char *buffer, size_t sz)
 	else
 		nbytes = snprintf(buffer, sz, "%s,%s,%s", manufacturer, type,
 				  model);
-	return (nbytes >= sz) ? -1 : 0;
+	return (nbytes >= sz) ? ENOBUFS : 0;
 }
 
 char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *buf = malloc(128);
 
-	if (buf && get_cpuid(buf, 128) < 0)
+	if (buf && get_cpuid(buf, 128))
 		zfree(&buf);
 	return buf;
 }
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 44f5aba78210..7eb5621c021d 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -196,8 +196,10 @@ static int x86__annotate_init(struct arch *arch, char *cpuid)
 	if (arch->initialized)
 		return 0;
 
-	if (cpuid)
-		err = x86__cpuid_parse(arch, cpuid);
+	if (cpuid) {
+		if (x86__cpuid_parse(arch, cpuid))
+			err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+	}
 
 	arch->initialized = true;
 	return err;
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index 662ecf84a421..aa6deb463bf3 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/types.h>
+#include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -58,7 +59,7 @@ __get_cpuid(char *buffer, size_t sz, const char *fmt)
 		buffer[nb-1] = '\0';
 		return 0;
 	}
-	return -1;
+	return ENOBUFS;
 }
 
 int
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 2227e2f42c09..58a9e0989491 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -705,14 +705,15 @@ static int process_sample_event(struct perf_tool *tool,
 
 static int cpu_isa_config(struct perf_kvm_stat *kvm)
 {
-	char buf[64], *cpuid;
+	char buf[128], *cpuid;
 	int err;
 
 	if (kvm->live) {
 		err = get_cpuid(buf, sizeof(buf));
 		if (err != 0) {
-			pr_err("Failed to look up CPU type\n");
-			return err;
+			pr_err("Failed to look up CPU type: %s\n",
+			       str_error_r(err, buf, sizeof(buf)));
+			return -err;
 		}
 		cpuid = buf;
 	} else
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 286fc70d7402..67be8d31afab 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1063,7 +1063,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			continue;
 
 		insn = 0;
-		for (off = 0;; off += ilen) {
+		for (off = 0; off < (unsigned)len; off += ilen) {
 			uint64_t ip = start + off;
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
@@ -1074,6 +1074,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 					printed += print_srccode(thread, x.cpumode, ip);
 				break;
 			} else {
+				ilen = 0;
 				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
 						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
 				if (ilen == 0)
@@ -1083,6 +1084,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				insn++;
 			}
 		}
+		if (off != (unsigned)len)
+			printed += fprintf(fp, "\tmismatch of LBR data and executable\n");
 	}
 
 	/*
@@ -1123,6 +1126,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		goto out;
 	}
 	for (off = 0; off <= end - start; off += ilen) {
+		ilen = 0;
 		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", start + off,
 				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index e2e0f06c97d0..cea13cb987d0 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -8,6 +8,7 @@ include/uapi/drm/i915_drm.h
 include/uapi/linux/fadvise.h
 include/uapi/linux/fcntl.h
 include/uapi/linux/fs.h
+include/uapi/linux/fscrypt.h
 include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/in.h
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/basic.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/extended.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
new file mode 100644
index 000000000000..1a0034f79f73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index bd3fc577139c..61641a3480e0 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -4,4 +4,4 @@ Family-model,Version,Filename,EventType
 ^IBM.282[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_zec12,core
 ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
 ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
-^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_m8561,core
+^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 9e37287da924..e2837260ca4d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -450,12 +450,12 @@ static struct fixed {
 	const char *name;
 	const char *event;
 } fixed[] = {
-	{ "inst_retired.any", "event=0xc0" },
-	{ "inst_retired.any_p", "event=0xc0" },
-	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
-	{ "cpu_clk_unhalted.thread", "event=0x3c" },
-	{ "cpu_clk_unhalted.core", "event=0x3c" },
-	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
+	{ "inst_retired.any", "event=0xc0,period=2000003" },
+	{ "inst_retired.any_p", "event=0xc0,period=2000003" },
+	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03,period=2000003" },
+	{ "cpu_clk_unhalted.thread", "event=0x3c,period=2000003" },
+	{ "cpu_clk_unhalted.core", "event=0x3c,period=2000003" },
+	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1,period=2000003" },
 	{ NULL, NULL},
 };
 
diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
index dbc27199c65e..dd865e0bea12 100644
--- a/tools/perf/tests/perf-hooks.c
+++ b/tools/perf/tests/perf-hooks.c
@@ -19,12 +19,11 @@ static void sigsegv_handler(int sig __maybe_unused)
 static void the_hook(void *_hook_flags)
 {
 	int *hook_flags = _hook_flags;
-	int *p = NULL;
 
 	*hook_flags = 1234;
 
 	/* Generate a segfault, test perf_hooks__recover */
-	*p = 0;
+	raise(SIGSEGV);
 }
 
 int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unused)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e830eadfca2a..4036c7f7b0fb 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1631,6 +1631,19 @@ int symbol__strerror_disassemble(struct symbol *sym __maybe_unused, struct map *
 	case SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF:
 		scnprintf(buf, buflen, "Please link with binutils's libopcode to enable BPF annotation");
 		break;
+	case SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP:
+		scnprintf(buf, buflen, "Problems with arch specific instruction name regular expressions.");
+		break;
+	case SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING:
+		scnprintf(buf, buflen, "Problems while parsing the CPUID in the arch specific initialization.");
+		break;
+	case SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE:
+		scnprintf(buf, buflen, "Invalid BPF file: %s.", dso->long_name);
+		break;
+	case SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF:
+		scnprintf(buf, buflen, "The %s BPF file has no BTF section, compile with -g or use pahole -J.",
+			  dso->long_name);
+		break;
 	default:
 		scnprintf(buf, buflen, "Internal error: Invalid %d error code\n", errnum);
 		break;
@@ -1662,7 +1675,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 	build_id_path = strdup(filename);
 	if (!build_id_path)
-		return -1;
+		return ENOMEM;
 
 	/*
 	 * old style build-id cache has name of XX/XXXXXXX.. while
@@ -1713,13 +1726,13 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	char tpath[PATH_MAX];
 	size_t buf_size;
 	int nr_skip = 0;
-	int ret = -1;
 	char *buf;
 	bfd *bfdf;
+	int ret;
 	FILE *s;
 
 	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return -1;
+		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
 
 	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
 		  sym->name, sym->start, sym->end - sym->start);
@@ -1732,8 +1745,10 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	assert(bfd_check_format(bfdf, bfd_object));
 
 	s = open_memstream(&buf, &buf_size);
-	if (!s)
+	if (!s) {
+		ret = errno;
 		goto out;
+	}
 	init_disassemble_info(&info, s,
 			      (fprintf_ftype) fprintf);
 
@@ -1742,8 +1757,10 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 
 	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
 						 dso->bpf_prog.id);
-	if (!info_node)
+	if (!info_node) {
+		return SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 		goto out;
+	}
 	info_linear = info_node->info_linear;
 	sub_id = dso->bpf_prog.sub_id;
 
@@ -2071,11 +2088,11 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 	int err;
 
 	if (!arch_name)
-		return -1;
+		return errno;
 
 	args.arch = arch = arch__find(arch_name);
 	if (arch == NULL)
-		return -ENOTSUP;
+		return ENOTSUP;
 
 	if (parch)
 		*parch = arch;
@@ -2971,7 +2988,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct evsel *evsel,
 
 	notes->offsets = zalloc(size * sizeof(struct annotation_line *));
 	if (notes->offsets == NULL)
-		return -1;
+		return ENOMEM;
 
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
@@ -2997,7 +3014,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct evsel *evsel,
 
 out_free_offsets:
 	zfree(&notes->offsets);
-	return -1;
+	return err;
 }
 
 #define ANNOTATION__CFG(n) \
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d94be9140e31..d76fd0e81f46 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -370,6 +370,10 @@ enum symbol_disassemble_errno {
 
 	SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX	= __SYMBOL_ANNOTATE_ERRNO__START,
 	SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF,
+	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING,
+	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP,
+	SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE,
+	SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF,
 
 	__SYMBOL_ANNOTATE_ERRNO__END,
 };
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5591af81a070..abc7fda4a0fe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -30,6 +30,7 @@
 #include "counts.h"
 #include "event.h"
 #include "evsel.h"
+#include "util/env.h"
 #include "util/evsel_config.h"
 #include "util/evsel_fprintf.h"
 #include "evlist.h"
@@ -2512,7 +2513,7 @@ struct perf_env *perf_evsel__env(struct evsel *evsel)
 {
 	if (evsel && evsel->evlist)
 		return evsel->evlist->env;
-	return NULL;
+	return &perf_env;
 }
 
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 1bdf4c6ea3e5..e3ccb0ce1938 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -395,7 +395,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	size_t size;
 	u16 idr_size;
 	const char *sym;
-	uint32_t count;
+	uint64_t count;
 	int ret, csize, usize;
 	pid_t pid, tid;
 	struct {
@@ -418,7 +418,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 		return -1;
 
 	filename = event->mmap2.filename;
-	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%u.so",
+	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
 			jd->dir,
 			pid,
 			count);
@@ -529,7 +529,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 		return -1;
 
 	filename = event->mmap2.filename;
-	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%"PRIu64,
+	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
 	         jd->dir,
 	         pid,
 		 jr->move.code_index);
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 8d04e3d070b1..8b14e4a7f1dc 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -233,14 +233,14 @@ static int detect_kbuild_dir(char **kbuild_dir)
 	const char *prefix_dir = "";
 	const char *suffix_dir = "";
 
+	/* _UTSNAME_LENGTH is 65 */
+	char release[128];
+
 	char *autoconf_path;
 
 	int err;
 
 	if (!test_dir) {
-		/* _UTSNAME_LENGTH is 65 */
-		char release[128];
-
 		err = fetch_kernel_version(NULL, release,
 					   sizeof(release));
 		if (err)
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 5b83ed1ebbd6..eec9b282c047 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "symbol.h"
+#include <assert.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
@@ -850,6 +851,8 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 			}
 
 			after->start = map->end;
+			after->pgoff += map->end - pos->start;
+			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
 			__map_groups__insert(pos->groups, after);
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(after, fp);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 53f31053a27a..02460362256d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -14,6 +14,7 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
+#include "util/env.h"
 #include <internal/lib.h>
 #include "../perf-sys.h"
 
@@ -53,6 +54,11 @@ int parse_callchain_record(const char *arg __maybe_unused,
 	return 0;
 }
 
+/*
+ * Add this one here not to drag util/env.c
+ */
+struct perf_env perf_env;
+
 /*
  * Support debug printing even though util/debug.c is not linked.  That means
  * implementing 'verbose' and 'eprintf'.
