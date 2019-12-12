Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB22C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C415206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfLLSkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:40:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:22235 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730506AbfLLSkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:40:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 10:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="211205409"
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
Subject: [PATCH v4 2/5] platform/x86: intel_pmc_core: Create platform dependent pmc bitmap structs
Date:   Thu, 12 Dec 2019 10:38:44 -0800
Message-Id: <b7f470de22a073d935a24d4161dde2f59d826508.1576105486.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576105486.git.gayatri.kammela@intel.com>
References: <cover.1576105486.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1576105486.git.gayatri.kammela@intel.com>
References: <cover.1576105486.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of pmc_core driver allows to reuse, but does
not reflect the exact number and names of IPs for a newer platform which
does not necessarily support all the IPs in the entries. The names and
number of these IPs might differ from its previous platforms. The number
of PCH IPs per platform is calculated based on PPFEAR_NUM_ENTRIES
defined, where each entry represents a bucket (8 bits). The platform can
support 'n' entries, but not necessarily all 'n*8' IPs.

Create platform dependent bitmap structures to specify the exact number,
names of IPs while reusing the existing IPs.

The changes in this patch are preparatory to accommodate future SoCs
that might reuse the CNL/ICL PCH IPs, and to reflect the exact number of
IPs with its names.

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
 drivers/platform/x86/intel_pmc_core.c | 46 ++++++++++++++++++++-------
 drivers/platform/x86/intel_pmc_core.h |  2 +-
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index f7256168bb8f..2449756434db 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -116,6 +116,11 @@ static const struct pmc_bit_map spt_pfear_map[] = {
 	{}
 };
 
+static const struct pmc_bit_map *ext_spt_pfear_map[] = {
+	spt_pfear_map,
+	NULL
+};
+
 static const struct pmc_bit_map spt_ltr_show_map[] = {
 	{"SOUTHPORT_A",		SPT_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		SPT_PMC_LTR_SPB},
@@ -142,7 +147,7 @@ static const struct pmc_bit_map spt_ltr_show_map[] = {
 };
 
 static const struct pmc_reg_map spt_reg_map = {
-	.pfear_sts = spt_pfear_map,
+	.pfear_sts = ext_spt_pfear_map,
 	.mphy_sts = spt_mphy_map,
 	.pll_sts = spt_pll_map,
 	.ltr_show_sts = spt_ltr_show_map,
@@ -234,7 +239,15 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"PSF6",		BIT(5)},
 	{"PSF7",		BIT(6)},
 	{"PSF8",		BIT(7)},
+	{}
+};
+
+static const struct pmc_bit_map *ext_cnp_pfear_map[] = {
+	cnp_pfear_map,
+	NULL
+};
 
+static const struct pmc_bit_map icl_pfear_map[] = {
 	/* Ice Lake generation onwards only */
 	{"RES_65",		BIT(0)},
 	{"RES_66",		BIT(1)},
@@ -247,6 +260,12 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{}
 };
 
+static const struct pmc_bit_map *ext_icl_pfear_map[] = {
+	cnp_pfear_map,
+	icl_pfear_map,
+	NULL
+};
+
 static const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
 	{"AUDIO_D3",		BIT(0)},
 	{"OTG_D3",		BIT(1)},
@@ -334,7 +353,7 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
 };
 
 static const struct pmc_reg_map cnp_reg_map = {
-	.pfear_sts = cnp_pfear_map,
+	.pfear_sts = ext_cnp_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slps0_dbg_maps = cnp_slps0_dbg_maps,
 	.ltr_show_sts = cnp_ltr_show_map,
@@ -350,7 +369,7 @@ static const struct pmc_reg_map cnp_reg_map = {
 };
 
 static const struct pmc_reg_map icl_reg_map = {
-	.pfear_sts = cnp_pfear_map,
+	.pfear_sts = ext_icl_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slps0_dbg_maps = cnp_slps0_dbg_maps,
 	.ltr_show_sts = cnp_ltr_show_map,
@@ -412,20 +431,20 @@ static int pmc_core_check_read_lock_bit(void)
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 static bool slps0_dbg_latch;
 
-static void pmc_core_display_map(struct seq_file *s, int index,
-				 u8 pf_reg, const struct pmc_bit_map *pf_map)
+static void pmc_core_display_map(struct seq_file *s, int index, int idx, int ip,
+				 u8 pf_reg, const struct pmc_bit_map **pf_map)
 {
 	seq_printf(s, "PCH IP: %-2d - %-32s\tState: %s\n",
-		   index, pf_map[index].name,
-		   pf_map[index].bit_mask & pf_reg ? "Off" : "On");
+		   ip, pf_map[idx][index].name,
+		   pf_map[idx][index].bit_mask & pf_reg ? "Off" : "On");
 }
 
 static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	const struct pmc_bit_map *map = pmcdev->map->pfear_sts;
+	const struct pmc_bit_map **maps = pmcdev->map->pfear_sts;
 	u8 pf_regs[PPFEAR_MAX_NUM_ENTRIES];
-	int index, iter;
+	int index, iter, idx, ip = 0;
 
 	iter = pmcdev->map->ppfear0_offset;
 
@@ -433,9 +452,12 @@ static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 	     index < PPFEAR_MAX_NUM_ENTRIES; index++, iter++)
 		pf_regs[index] = pmc_core_reg_read_byte(pmcdev, iter);
 
-	for (index = 0; map[index].name &&
-	     index < pmcdev->map->ppfear_buckets * 8; index++)
-		pmc_core_display_map(s, index, pf_regs[index / 8], map);
+	for (idx = 0; maps[idx]; idx++) {
+		for (index = 0; maps[idx][index].name &&
+		     index < pmcdev->map->ppfear_buckets * 8; ip++, index++)
+			pmc_core_display_map(s, index, idx, ip,
+					     pf_regs[index / 8], maps);
+	}
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index fdee5772e532..4b9f9ad6b692 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -213,7 +213,7 @@ struct pmc_bit_map {
  * captures them to have a common implementation.
  */
 struct pmc_reg_map {
-	const struct pmc_bit_map *pfear_sts;
+	const struct pmc_bit_map **pfear_sts;
 	const struct pmc_bit_map *mphy_sts;
 	const struct pmc_bit_map *pll_sts;
 	const struct pmc_bit_map **slps0_dbg_maps;
-- 
2.17.1

