Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C9C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679EE2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKRTFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:05:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:26776 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfKRTFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:05:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 11:05:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="215357907"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.161])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2019 11:05:49 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     vishwanath.somayaji@intel.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v1 2/2] platform/x86: intel_pmc_core: Add Comet Lake (CML) platform support to  intel_pmc_core driver
Date:   Mon, 18 Nov 2019 11:05:41 -0800
Message-Id: <8638b6f60474684b075fd4c88ec94e55bc2e1d8b.1574102528.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574102528.git.gayatri.kammela@intel.com>
References: <cover.1574102528.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1574102528.git.gayatri.kammela@intel.com>
References: <cover.1574102528.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Comet Lake to the list of the platforms that intel_pmc_core driver
supports for pmc_core device.

Just like Ice Lake, Comet Lake can also reuse all the Cannon Lake PCH
IPs. No additional effort is needed to enable but to simply reuse them.

Cc: Mario Limonciello <mario.limonciello@dell.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 6b6edc30f835..571b4754477c 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -160,6 +160,7 @@ static const struct pmc_reg_map spt_reg_map = {
 
 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
 static const struct pmc_bit_map cnp_pfear_map[] = {
+	/* Reserved for Cannon Lake but valid for Comet Lake */
 	{"PMC",                 BIT(0)},
 	{"OPI-DMI",             BIT(1)},
 	{"SPI/eSPI",            BIT(2)},
@@ -185,7 +186,7 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"SDX",                 BIT(4)},
 	{"SPE",                 BIT(5)},
 	{"Fuse",                BIT(6)},
-	/* Reserved for Cannon Lake but valid for Ice Lake */
+	/* Reserved for Cannon Lake but valid for Ice Lake and Comet Lake */
 	{"SBR8",		BIT(7)},
 
 	{"CSME_FSC",            BIT(0)},
@@ -229,7 +230,7 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"HDA_PGD4",            BIT(2)},
 	{"HDA_PGD5",            BIT(3)},
 	{"HDA_PGD6",            BIT(4)},
-	/* Reserved for Cannon Lake but valid for Ice Lake */
+	/* Reserved for Cannon Lake but valid for Ice Lake and Comet Lake */
 	{"PSF6",		BIT(5)},
 	{"PSF7",		BIT(6)},
 	{"PSF8",		BIT(7)},
@@ -813,6 +814,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	INTEL_CPU_FAM6(CANNONLAKE_L, cnp_reg_map),
 	INTEL_CPU_FAM6(ICELAKE_L, icl_reg_map),
 	INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
+	INTEL_CPU_FAM6(COMETLAKE, cnp_reg_map),
+	INTEL_CPU_FAM6(COMETLAKE_L, cnp_reg_map),
 	{}
 };
 
-- 
2.17.1

