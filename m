Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369F6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185E5206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfLLSkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:40:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:22236 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730519AbfLLSko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:40:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 10:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="211205415"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.172])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2019 10:40:42 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     vishwanath.somayaji@intel.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, mika.westerberg@intel.com,
        charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 4/5] platform/x86: intel_pmc_core: Add Tiger Lake (TGL) platform support to intel_pmc_core driver
Date:   Thu, 12 Dec 2019 10:38:46 -0800
Message-Id: <bb86c6cd394651363a40bdd5a8185b364079c0c3.1576105486.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576105486.git.gayatri.kammela@intel.com>
References: <cover.1576105486.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1576105486.git.gayatri.kammela@intel.com>
References: <cover.1576105486.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Tiger Lake to the list of the platforms that intel_pmc_core driver
supports for the pmc_core device.

Just like Ice Lake, Tiger Lake can also reuse all the Cannon Lake PCH
IPs. Since Tiger Lake has almost the same number of PCH IPs as Ice Lake,
reuse Ice Lake's PPFEAR_NUM_ENTRIES instead of defining a new macro.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 46 +++++++++++++++++++++++++--
 drivers/platform/x86/intel_pmc_core.h |  2 ++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 1ff28199b599..b18782e48a5d 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -191,7 +191,10 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"SDX",                 BIT(4)},
 	{"SPE",                 BIT(5)},
 	{"Fuse",                BIT(6)},
-	/* Reserved for Cannon Lake but valid for Ice Lake and Comet Lake */
+	/*
+	 * Reserved for Cannon Lake but valid for Ice Lake, Comet Lake
+	 * and Tiger Lake.
+	 */
 	{"SBR8",		BIT(7)},
 
 	{"CSME_FSC",            BIT(0)},
@@ -235,7 +238,10 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"HDA_PGD4",            BIT(2)},
 	{"HDA_PGD5",            BIT(3)},
 	{"HDA_PGD6",            BIT(4)},
-	/* Reserved for Cannon Lake but valid for Ice Lake and Comet Lake */
+	/*
+	 * Reserved for Cannon Lake but valid for Ice Lake, Comet Lake
+	 * and Tiger Lake.
+	 */
 	{"PSF6",		BIT(5)},
 	{"PSF7",		BIT(6)},
 	{"PSF8",		BIT(7)},
@@ -266,6 +272,24 @@ static const struct pmc_bit_map *ext_icl_pfear_map[] = {
 	NULL
 };
 
+static const struct pmc_bit_map tgl_pfear_map[] = {
+	/* Tiger Lake generation onwards only */
+	{"PSF9",		BIT(0)},
+	{"RES_66",		BIT(1)},
+	{"RES_67",		BIT(2)},
+	{"RES_68",		BIT(3)},
+	{"RES_69",		BIT(4)},
+	{"RES_70",		BIT(5)},
+	{"TBTLSX",		BIT(6)},
+	{}
+};
+
+static const struct pmc_bit_map *ext_tgl_pfear_map[] = {
+	cnp_pfear_map,
+	tgl_pfear_map,
+	NULL
+};
+
 static const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
 	{"AUDIO_D3",		BIT(0)},
 	{"OTG_D3",		BIT(1)},
@@ -384,6 +408,22 @@ static const struct pmc_reg_map icl_reg_map = {
 	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
 };
 
+static const struct pmc_reg_map tgl_reg_map = {
+	.pfear_sts = ext_tgl_pfear_map,
+	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slps0_dbg_maps = cnp_slps0_dbg_maps,
+	.ltr_show_sts = cnp_ltr_show_map,
+	.msr_sts = msr_map,
+	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = CNP_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
+};
+
 static inline u8 pmc_core_reg_read_byte(struct pmc_dev *pmcdev, int offset)
 {
 	return readb(pmcdev->regbase + offset);
@@ -839,6 +879,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
 	INTEL_CPU_FAM6(COMETLAKE, cnp_reg_map),
 	INTEL_CPU_FAM6(COMETLAKE_L, cnp_reg_map),
+	INTEL_CPU_FAM6(TIGERLAKE_L, tgl_reg_map),
+	INTEL_CPU_FAM6(TIGERLAKE, tgl_reg_map),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 4b9f9ad6b692..99acdc051342 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -186,6 +186,8 @@ enum ppfear_regs {
 #define ICL_NUM_IP_IGN_ALLOWED			20
 #define ICL_PMC_LTR_WIGIG			0x1BFC
 
+#define TGL_NUM_IP_IGN_ALLOWED			22
+
 struct pmc_bit_map {
 	const char *name;
 	u32 bit_mask;
-- 
2.17.1

