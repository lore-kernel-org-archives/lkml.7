Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E142C2D0CA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91AF2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfLLSkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:40:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:22235 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbfLLSko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:40:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 10:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="211205418"
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
Subject: [PATCH v4 5/5] platform/x86: intel_pmc_core: Add Atom based Elkhart Lake (EHL) platform support to intel_pmc_core driver
Date:   Thu, 12 Dec 2019 10:38:47 -0800
Message-Id: <672ca6d153dd714687ab990f9fe5327296e9a242.1576105486.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576105486.git.gayatri.kammela@intel.com>
References: <cover.1576105486.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1576105486.git.gayatri.kammela@intel.com>
References: <cover.1576105486.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Elkhart Lake to the list of the platforms that intel_pmc_core
driver supports for pmc_core device.

Just like Ice Lake and Tiger Lake, Elkhart Lake can also reuse all the
Cannon Lake PCH IPs. Also, it uses the same PCH IPs of Tiger Lake, no
additional effort is needed to enable but to simply reuse them.

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
 drivers/platform/x86/intel_pmc_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index b18782e48a5d..017776551cc5 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -192,8 +192,8 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"SPE",                 BIT(5)},
 	{"Fuse",                BIT(6)},
 	/*
-	 * Reserved for Cannon Lake but valid for Ice Lake, Comet Lake
-	 * and Tiger Lake.
+	 * Reserved for Cannon Lake but valid for Ice Lake, Comet Lake,
+	 * Tiger Lake and Elkhart Lake.
 	 */
 	{"SBR8",		BIT(7)},
 
@@ -239,8 +239,8 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"HDA_PGD5",            BIT(3)},
 	{"HDA_PGD6",            BIT(4)},
 	/*
-	 * Reserved for Cannon Lake but valid for Ice Lake, Comet Lake
-	 * and Tiger Lake.
+	 * Reserved for Cannon Lake but valid for Ice Lake, Comet Lake,
+	 * Tiger Lake and ELkhart Lake.
 	 */
 	{"PSF6",		BIT(5)},
 	{"PSF7",		BIT(6)},
@@ -273,7 +273,7 @@ static const struct pmc_bit_map *ext_icl_pfear_map[] = {
 };
 
 static const struct pmc_bit_map tgl_pfear_map[] = {
-	/* Tiger Lake generation onwards only */
+	/* Tiger Lake and Elkhart Lake generation onwards only */
 	{"PSF9",		BIT(0)},
 	{"RES_66",		BIT(1)},
 	{"RES_67",		BIT(2)},
@@ -881,6 +881,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	INTEL_CPU_FAM6(COMETLAKE_L, cnp_reg_map),
 	INTEL_CPU_FAM6(TIGERLAKE_L, tgl_reg_map),
 	INTEL_CPU_FAM6(TIGERLAKE, tgl_reg_map),
+	INTEL_CPU_FAM6(ATOM_TREMONT, tgl_reg_map),
 	{}
 };
 
-- 
2.17.1

