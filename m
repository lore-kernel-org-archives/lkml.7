Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E8BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F370214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKGT7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:59:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:34947 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfKGT7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:59:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 11:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,279,1569308400"; 
   d="scan'208";a="233379310"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2019 11:59:43 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 1/2] EDAC/altera: Cleanup the ECC Manager
Date:   Thu,  7 Nov 2019 14:01:29 -0600
Message-Id: <1573156890-26891-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573156890-26891-1-git-send-email-thor.thayer@linux.intel.com>
References: <1573156890-26891-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Cleanup the ECC Manager peripheral test in probe function as
suggested by James.
Remove the check for Stratix10.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/altera_edac.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index fbda4b876afd..e893ff8731cb 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1013,11 +1013,6 @@ static int socfpga_is_a10(void)
 	return of_machine_is_compatible("altr,socfpga-arria10");
 }
 
-static int socfpga_is_s10(void)
-{
-	return of_machine_is_compatible("altr,socfpga-stratix10");
-}
-
 static __init int __maybe_unused
 altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 			u32 ecc_ctrl_en_mask, bool dual_port)
@@ -1125,9 +1120,6 @@ static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
 	int irq;
 	struct device_node *child, *np;
 
-	if (!socfpga_is_a10() && !socfpga_is_s10())
-		return -ENODEV;
-
 	np = of_find_compatible_node(NULL, NULL,
 				     "altr,socfpga-a10-ecc-manager");
 	if (!np) {
@@ -2270,18 +2262,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		if (!of_device_is_available(child))
 			continue;
 
-		if (of_device_is_compatible(child, "altr,socfpga-a10-l2-ecc") || 
-		    of_device_is_compatible(child, "altr,socfpga-a10-ocram-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-eth-mac-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-nand-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-dma-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-usb-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-qspi-ecc") ||
-#ifdef CONFIG_EDAC_ALTERA_SDRAM
-		    of_device_is_compatible(child, "altr,sdram-edac-s10") ||
-#endif
-		    of_device_is_compatible(child, "altr,socfpga-sdmmc-ecc"))
-
+		if (of_match_node(altr_edac_a10_device_of_match, child))
 			altr_edac_a10_device_add(edac, child);
 
 #ifdef CONFIG_EDAC_ALTERA_SDRAM
-- 
2.7.4

