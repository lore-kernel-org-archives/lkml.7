Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8BAC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AED721874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfIBDpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:45:05 -0400
Received: from [192.198.146.188] ([192.198.146.188]:15593 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726385AbfIBDpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:45:04 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Sep 2019 23:45:04 EDT
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id 76A30C16C0;
        Mon,  2 Sep 2019 11:35:13 +0800 (CST)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2] perf/x86/intel: Update ICL Core and Package C-state event counters
Date:   Mon,  2 Sep 2019 11:35:11 +0800
Message-Id: <20190902033511.826-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190726090846.6109-1-harry.pan@intel.com>
References: <20190726090846.6109-1-harry.pan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ice Lake microarchitecture inherits Cannon Lake, it has CC1/PC8/PC9/PC10
residency counters.

Update the list of Ice Lake PMU event counters from the snb_cstates[] list
of events to the cnl_cstates[] list of events, which keeps all previously
supported events and also adds the CORE_C1, PKG_C8, PKG_C9, and PKG_C10
residency counters.

This benefits users to profile them through the perf interface.

Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 arch/x86/events/intel/cstate.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 688592b34564..82fbc4c6e5e6 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -35,56 +35,58 @@
  *    The counters include PKG_C*_RESIDENCY.
  *
  * All of these counters are specified in the Intel® 64 and IA-32
- * Architectures Software Developer.s Manual Vol3b.
+ * Architectures Software Developer's Manual Vol4.
  *
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM,CNL
+ *			 Available model: SLM,AMT,GLM,CNL,ICL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
-						CNL
+ *						CNL,ICL
  *			       Scope: Core
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL
+ *						SKL,KNL,GLM,CNL,ICL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
- *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL
+ *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,ICL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
- *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL
+ *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
+ *						ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL
+ *						GLM,CNL,ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
- *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
- *						SKL,KNL,GLM,CNL
+ *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
+ *						SKL,KNL,GLM,CNL,ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
- *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL
+ *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
+ *						ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,KBL,CNL
+ *			       Available model: HSW ULT,KBL,CNL,ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL
+ *			       Available model: HSW ULT,KBL,CNL,ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,KBL,GLM,CNL
+ *			       Available model: HSW ULT,KBL,GLM,CNL,ICL
  *			       Scope: Package (physical package)
  *
  */
@@ -625,8 +627,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_MOBILE, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_DESKTOP, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_MOBILE, cnl_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_DESKTOP, cnl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.21.0

