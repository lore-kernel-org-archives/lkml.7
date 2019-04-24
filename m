Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5730A218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfDXPUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:20:22 -0400
Received: from [101.14.163.243] ([101.14.163.243]:44162 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730476AbfDXPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:20:21 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 11:20:21 EDT
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id 29D72C0BD1;
        Wed, 24 Apr 2019 22:50:49 +0800 (+08)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] perf/x86/intel: Update KBL Package C-state events
Date:   Wed, 24 Apr 2019 22:50:33 +0800
Message-Id: <20190424145033.1924-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kaby Lake (and Coffee Lake) has PC8/PC9/PC10 residency counters.

This patch updates the list of PMU event counters that allows
user space tool to profile them through perf interface.

Signed-off-by: Harry Pan <harry.pan@intel.com>
---

 arch/x86/events/intel/cstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index d2e780705c5a..56194c571299 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -76,15 +76,15 @@
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,CNL
+ *			       Available model: HSW ULT,KBL,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,CNL
+ *			       Available model: HSW ULT,KBL,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,GLM,CNL
+ *			       Available model: HSW ULT,KBL,GLM,CNL
  *			       Scope: Package (physical package)
  *
  */
@@ -572,8 +572,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_DESKTOP, snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, hswult_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
 
-- 
2.20.1

