Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4787AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CB920870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390574AbfIETad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:30:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:49262 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389110AbfIETaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:30:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 12:30:22 -0700
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="scan'208";a="177408337"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 12:30:21 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] x86/cpu: Update init data for new Airmont CPU model
Date:   Thu,  5 Sep 2019 12:30:20 -0700
Message-Id: <20190905193020.14707-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190905193020.14707-1-tony.luck@intel.com>
References: <20190905193020.14707-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul Tanwar <rahul.tanwar@linux.intel.com>

Update properties for newly added Airmont CPU variant.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/common.c | 1 +
 arch/x86/kernel/cpu/intel.c  | 1 +
 arch/x86/kernel/tsc_msr.c    | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5cedb679215e..9ae7d1bcd4f4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1059,6 +1059,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_INTEL(CORE_YONAH,		NO_SSB),
 
 	VULNWL_INTEL(ATOM_AIRMONT_MID,		NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
+	VULNWL_INTEL(ATOM_AIRMONT_NP,		NO_L1TF | NO_SWAPGS),
 
 	VULNWL_INTEL(ATOM_GOLDMONT,		NO_MDS | NO_L1TF | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_GOLDMONT_D,		NO_MDS | NO_L1TF | NO_SWAPGS),
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e2082ccccf13..c2fdc00df163 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -268,6 +268,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		case INTEL_FAM6_ATOM_SALTWELL_MID:
 		case INTEL_FAM6_ATOM_SALTWELL_TABLET:
 		case INTEL_FAM6_ATOM_SILVERMONT_MID:
+		case INTEL_FAM6_ATOM_AIRMONT_NP:
 			set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC_S3);
 			break;
 		default:
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 067858fe4db8..e0cbe4f2af49 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -58,6 +58,10 @@ static const struct freq_desc freq_desc_ann = {
 	1, { 83300, 100000, 133300, 100000, 0, 0, 0, 0 }
 };
 
+static const struct freq_desc freq_desc_lgm = {
+	1, { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 }
+};
+
 static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
 	INTEL_CPU_FAM6(ATOM_SALTWELL_MID,	freq_desc_pnw),
 	INTEL_CPU_FAM6(ATOM_SALTWELL_TABLET,	freq_desc_clv),
@@ -65,6 +69,7 @@ static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	freq_desc_tng),
 	INTEL_CPU_FAM6(ATOM_AIRMONT,		freq_desc_cht),
 	INTEL_CPU_FAM6(ATOM_AIRMONT_MID,	freq_desc_ann),
+	INTEL_CPU_FAM6(ATOM_AIRMONT_NP,		freq_desc_lgm),
 	{}
 };
 
-- 
2.20.1

