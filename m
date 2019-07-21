Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA2C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44402147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfGUU7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:59:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52544 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfGUU7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:59:24 -0400
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hpIvR-00079E-Q3; Sun, 21 Jul 2019 20:59:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: tioca: fix spelling mistake in macros CA_APERATURE_{BASE|SIZE}
Date:   Sun, 21 Jul 2019 21:59:21 +0100
Message-Id: <20190721205921.9960-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The two macros CA_APERATURE_BASE and CA_APERATURE_SIZE contain
a spelling mistake, APERATURE should be APERTURE, so fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/ia64/include/asm/sn/tioca.h  |  4 ++--
 arch/ia64/sn/pci/tioca_provider.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/include/asm/sn/tioca.h b/arch/ia64/include/asm/sn/tioca.h
index 666222d7f0f6..4529fb11c86c 100644
--- a/arch/ia64/include/asm/sn/tioca.h
+++ b/arch/ia64/include/asm/sn/tioca.h
@@ -590,7 +590,7 @@ struct tioca {
 #define CA_AGP_DIRECT_BASE	0x40000000UL	/* 2GB */
 #define CA_AGP_DIRECT_SIZE	0x40000000UL
 
-#define CA_APERATURE_BASE	(CA_AGP_MAPPED_BASE)
-#define CA_APERATURE_SIZE	(CA_AGP_MAPPED_SIZE+CA_PCI32_MAPPED_SIZE)
+#define CA_APERTURE_BASE	(CA_AGP_MAPPED_BASE)
+#define CA_APERTURE_SIZE	(CA_AGP_MAPPED_SIZE+CA_PCI32_MAPPED_SIZE)
 
 #endif  /* _ASM_IA64_SN_TIO_TIOCA_H */
diff --git a/arch/ia64/sn/pci/tioca_provider.c b/arch/ia64/sn/pci/tioca_provider.c
index a70b11fd57d6..07832f5e8718 100644
--- a/arch/ia64/sn/pci/tioca_provider.c
+++ b/arch/ia64/sn/pci/tioca_provider.c
@@ -55,7 +55,7 @@ tioca_gart_init(struct tioca_kernel *tioca_kern)
 	 * Validate aperature size
 	 */
 
-	switch (CA_APERATURE_SIZE >> 20) {
+	switch (CA_APERTURE_SIZE >> 20) {
 	case 4:
 		ap_reg |= (0x3ff << CA_GART_AP_SIZE_SHFT);	/* 4MB */
 		break;
@@ -90,8 +90,8 @@ tioca_gart_init(struct tioca_kernel *tioca_kern)
 		ap_reg |= (0x000 << CA_GART_AP_SIZE_SHFT);	/* 4 GB */
 		break;
 	default:
-		printk(KERN_ERR "%s:  Invalid CA_APERATURE_SIZE "
-		       "0x%lx\n", __func__, (ulong) CA_APERATURE_SIZE);
+		printk(KERN_ERR "%s:  Invalid CA_APERTURE_SIZE "
+		       "0x%lx\n", __func__, (ulong) CA_APERTURE_SIZE);
 		return -1;
 	}
 
@@ -106,8 +106,8 @@ tioca_gart_init(struct tioca_kernel *tioca_kern)
 		tioca_kern->ca_ap_pagesize = 4096;
 	}
 
-	tioca_kern->ca_ap_size = CA_APERATURE_SIZE;
-	tioca_kern->ca_ap_bus_base = CA_APERATURE_BASE;
+	tioca_kern->ca_ap_size = CA_APERTURE_SIZE;
+	tioca_kern->ca_ap_bus_base = CA_APERTURE_BASE;
 	tioca_kern->ca_gart_entries =
 	    tioca_kern->ca_ap_size / tioca_kern->ca_ap_pagesize;
 
@@ -141,7 +141,7 @@ tioca_gart_init(struct tioca_kernel *tioca_kern)
 	 * Compute PCI/AGP convenience fields 
 	 */
 
-	offset = CA_PCI32_MAPPED_BASE - CA_APERATURE_BASE;
+	offset = CA_PCI32_MAPPED_BASE - CA_APERTURE_BASE;
 	tioca_kern->ca_pciap_base = CA_PCI32_MAPPED_BASE;
 	tioca_kern->ca_pciap_size = CA_PCI32_MAPPED_SIZE;
 	tioca_kern->ca_pcigart_start = offset / tioca_kern->ca_ap_pagesize;
@@ -159,7 +159,7 @@ tioca_gart_init(struct tioca_kernel *tioca_kern)
 		return -1;
 	}
 
-	offset = CA_AGP_MAPPED_BASE - CA_APERATURE_BASE;
+	offset = CA_AGP_MAPPED_BASE - CA_APERTURE_BASE;
 	tioca_kern->ca_gfxap_base = CA_AGP_MAPPED_BASE;
 	tioca_kern->ca_gfxap_size = CA_AGP_MAPPED_SIZE;
 	tioca_kern->ca_gfxgart_start = offset / tioca_kern->ca_ap_pagesize;
-- 
2.20.1

