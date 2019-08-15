Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AF0C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3D021855
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfHOJrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:47:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:58050 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfHOJrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:47:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 02:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; 
   d="scan'208";a="260773947"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2019 02:47:09 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 3/3] x86: arch: Add arch support for new Intel Atom CPU
Date:   Thu, 15 Aug 2019 17:46:47 +0800
Message-Id: <27efba07aac2eb9b9ed719cfa2154326d515faa4.1565856842.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1565856842.git.rahul.tanwar@linux.intel.com>
References: <cover.1565856842.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565856842.git.rahul.tanwar@linux.intel.com>
References: <cover.1565856842.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic arch support for a new variant of Intel Atom CPU
model used in a network processor SoC named Lightning Mountain.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 1 +
 arch/x86/kernel/cpu/intel.c  | 1 +
 arch/x86/kernel/tsc_msr.c    | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5cc2d51cc25e..c6b4a578b280 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1059,6 +1059,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_INTEL(CORE_YONAH,		NO_SSB),
 
 	VULNWL_INTEL(ATOM_AIRMONT_MID,		NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
+	VULNWL_INTEL(ATOM_AIRMONT_NP,		NO_L1TF | NO_SWAPGS),
 
 	VULNWL_INTEL(ATOM_GOLDMONT,		NO_MDS | NO_L1TF | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_GOLDMONT_X,		NO_MDS | NO_L1TF | NO_SWAPGS),
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0419fba1ea56..e989a8429390 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -268,6 +268,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		case INTEL_FAM6_ATOM_SALTWELL_MID:	/* Penwell */
 		case INTEL_FAM6_ATOM_SALTWELL_TABLET:	/* Cloverview */
 		case INTEL_FAM6_ATOM_SILVERMONT_MID:	/* Merrifield */
+		case INTEL_FAM6_ATOM_AIRMONT_NP:	/* Lightning Mountain */
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
2.11.0

