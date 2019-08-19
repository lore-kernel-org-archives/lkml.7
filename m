Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F96C3A5A3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C212F2183F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfHSNXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:23:05 -0400
Received: from 8bytes.org ([81.169.241.247]:50386 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfHSNXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:23:02 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BE68257D; Mon, 19 Aug 2019 15:22:59 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 06/11] x86/dma: Get rid of iommu_pass_through
Date:   Mon, 19 Aug 2019 15:22:51 +0200
Message-Id: <20190819132256.14436-7-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819132256.14436-1-joro@8bytes.org>
References: <20190819132256.14436-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This variable has no users anymore. Remove it and tell the
IOMMU code via its new functions about requested DMA modes.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/iommu.h |  1 -
 arch/x86/kernel/pci-dma.c    | 20 +++-----------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index baedab8ac538..b91623d521d9 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -4,7 +4,6 @@
 
 extern int force_iommu, no_iommu;
 extern int iommu_detected;
-extern int iommu_pass_through;
 
 /* 10 seconds */
 #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index f62b498b18fb..fa4352dce491 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/dma-direct.h>
 #include <linux/dma-debug.h>
+#include <linux/iommu.h>
 #include <linux/dmar.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
@@ -34,21 +35,6 @@ int no_iommu __read_mostly;
 /* Set this to 1 if there is a HW IOMMU in the system */
 int iommu_detected __read_mostly = 0;
 
-/*
- * This variable becomes 1 if iommu=pt is passed on the kernel command line.
- * If this variable is 1, IOMMU implementations do no DMA translation for
- * devices and allow every device to access to whole physical memory. This is
- * useful if a user wants to use an IOMMU only for KVM device assignment to
- * guests and not for driver dma translation.
- * It is also possible to disable by default in kernel config, and enable with
- * iommu=nopt at boot time.
- */
-#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
-int iommu_pass_through __read_mostly = 1;
-#else
-int iommu_pass_through __read_mostly;
-#endif
-
 extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
 
 void __init pci_iommu_alloc(void)
@@ -120,9 +106,9 @@ static __init int iommu_setup(char *p)
 			swiotlb = 1;
 #endif
 		if (!strncmp(p, "pt", 2))
-			iommu_pass_through = 1;
+			iommu_set_default_passthrough(true);
 		if (!strncmp(p, "nopt", 4))
-			iommu_pass_through = 0;
+			iommu_set_default_translated(true);
 
 		gart_parse_options(p);
 
-- 
2.16.4

