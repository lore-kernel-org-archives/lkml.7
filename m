Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3103C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77D5217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfDWOeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:34:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:54833 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbfDWOeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:34:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP; 23 Apr 2019 07:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="136653885"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga008.jf.intel.com with ESMTP; 23 Apr 2019 07:34:13 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] EDAC, altera: Add Stratix10 OCRAM ECC support
Date:   Tue, 23 Apr 2019 09:36:34 -0500
Message-Id: <1556030197-24534-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556030197-24534-1-git-send-email-thor.thayer@linux.intel.com>
References: <1556030197-24534-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Use the newer ECC error injection method for Arria10 and
Stratix10 OCRAM.
If OCRAM has already been initialized during the boot and
OCRAM ECC is enabled, ensure the Single Bit Error IRQ is
enabled.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/altera_edac.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8816f74a22b4..b7bc8f020df8 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1223,8 +1223,31 @@ static const struct edac_device_prv_data ocramecc_data = {
 	.inject_fops = &altr_edac_device_inject_fops,
 };
 
+static int __maybe_unused
+altr_check_ocram_deps_init(struct altr_edac_device_dev *device)
+{
+	void __iomem  *base = device->base;
+	int ret;
+
+	ret = altr_check_ecc_deps(device);
+	if (ret)
+		return ret;
+
+	/* Verify OCRAM has been initialized */
+	if (!ecc_test_bits(ALTR_A10_ECC_INITCOMPLETEA,
+			   (base + ALTR_A10_ECC_INITSTAT_OFST)))
+		return -ENODEV;
+
+	/* Enable IRQ on Single Bit Error */
+	writel(ALTR_A10_ECC_SERRINTEN, (base + ALTR_A10_ECC_ERRINTENS_OFST));
+	/* Ensure all writes complete */
+	wmb();
+
+	return 0;
+}
+
 static const struct edac_device_prv_data a10_ocramecc_data = {
-	.setup = altr_check_ecc_deps,
+	.setup = altr_check_ocram_deps_init,
 	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
 	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
 	.irq_status_mask = A10_SYSMGR_ECC_INTSTAT_OCRAM,
@@ -1234,7 +1257,7 @@ static const struct edac_device_prv_data a10_ocramecc_data = {
 	.ue_set_mask = ALTR_A10_ECC_TDERRA,
 	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
 	.ecc_irq_handler = altr_edac_a10_ecc_irq,
-	.inject_fops = &altr_edac_a10_device_inject_fops,
+	.inject_fops = &altr_edac_a10_device_inject2_fops,
 	/*
 	 * OCRAM panic on uncorrectable error because sleep/resume
 	 * functions and FPGA contents are stored in OCRAM. Prefer
-- 
2.7.4

