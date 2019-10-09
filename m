Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2DAECE596
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB8820B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfJIM73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:59:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbfJIM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:59:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIBYk-0002ml-P9; Wed, 09 Oct 2019 14:59:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6BD9B1C0270;
        Wed,  9 Oct 2019 14:59:18 +0200 (CEST)
Date:   Wed, 09 Oct 2019 12:59:18 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/cstate: Update C-state counters for Ice Lake
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1570549810-25049-7-git-send-email-kan.liang@linux.intel.com>
References: <1570549810-25049-7-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157062595835.9978.5500650354296201476.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     374f26643b3ce2bfab02053e292f16adf6e57aa1
Gitweb:        https://git.kernel.org/tip/374f26643b3ce2bfab02053e292f16adf6e57aa1
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 08 Oct 2019 08:50:07 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Oct 2019 12:44:16 +02:00

perf/x86/cstate: Update C-state counters for Ice Lake

There is no Core C3 C-State counter for Ice Lake.
Package C8/C9/C10 C-State counters are added for Ice Lake.

Introduce a new event list, icl_cstates, for Ice Lake.
Update the comments accordingly.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: f08c47d1f86c ("perf/x86/intel/cstate: Add Icelake support")
Link: https://lkml.kernel.org/r/1570549810-25049-7-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/cstate.c | 36 ++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 21c65e1..4d232ac 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -50,43 +50,44 @@
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
- *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML
+ *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
+ *						ICL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML
+ *						KBL,CML,ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL,KBL,CML
+ *						GLM,CNL,KBL,CML,ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
- *						SKL,KNL,GLM,CNL,KBL,CML
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML
+ *						KBL,CML,ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,KBL,CNL,CML
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL,CML
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,KBL,GLM,CNL,CML
+ *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL
  *			       Scope: Package (physical package)
  *
  */
@@ -546,6 +547,19 @@ static const struct cstate_model cnl_cstates __initconst = {
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
@@ -629,8 +643,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, icl_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   icl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
