Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F58FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4532626316
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfFCNmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:42:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:13096 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbfFCNme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:42:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 06:42:33 -0700
X-ExtLoop1: 1
Received: from otc-icl-cdi-210.jf.intel.com ([10.54.55.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2019 06:42:33 -0700
From:   kan.liang@linux.intel.com
To:     mingo@redhat.com, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     qiuxu.zhuo@intel.com, tony.luck@intel.com, rui.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/3] perf/x86/intel: Add Icelake desktop CPUID
Date:   Mon,  3 Jun 2019 06:41:22 -0700
Message-Id: <20190603134122.13853-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190603134122.13853-1-kan.liang@linux.intel.com>
References: <20190603134122.13853-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add new Icelake desktop CPUID for RAPL, CSTATE and UNCORE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 1 +
 arch/x86/events/intel/rapl.c   | 1 +
 arch/x86/events/intel/uncore.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 6072f92cb8ea..e6dc61fcfd97 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -580,6 +580,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_MOBILE, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_DESKTOP, snb_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 37ebf6fc5415..6892e38cfdaf 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -777,6 +777,7 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS, hsw_rapl_init),
 
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE,  skl_rapl_init),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP, skl_rapl_init),
 	{},
 };
 
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index fc40a1473058..56b2cbc0ddaf 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1399,6 +1399,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP, icl_uncore_init),
 	{},
 };
 
-- 
2.14.5

