Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B30C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAAE213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 12:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDGMsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 08:48:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726629AbfDGMsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 08:48:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EC456AAB0EF168CC75A7;
        Sun,  7 Apr 2019 20:48:15 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sun, 7 Apr 2019 20:48:06 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        x86 <x86@kernel.org>, linux-ia64 <linux-ia64@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v4 5/6] powernv/iommu: use common boot option iommu.dma_mode
Date:   Sun, 7 Apr 2019 20:41:46 +0800
Message-ID: <20190407124147.13576-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190407124147.13576-1-thunder.leizhen@huawei.com>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu=nobypass can be replaced with iommu.dma_mode=strict.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 --
 arch/powerpc/platforms/powernv/pci-ioda.c       | 23 +----------------------
 drivers/iommu/Kconfig                           |  1 +
 3 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a2df11945b33fc9..f88a8bff3c0caa0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1789,8 +1789,6 @@
 		soft
 		pt		[x86]
 		nopt		[x86]
-		nobypass	[PPC/POWERNV]
-			Disable IOMMU bypass, using IOMMU for PCI devices.
 
 
 	iommu.dma_mode= [ARM64] Configure default dma mode. if unset, use the
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3ead4c237ed0ec9..be0234c170316bc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -85,29 +85,8 @@ void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 	va_end(args);
 }
 
-static bool pnv_iommu_bypass_disabled __read_mostly;
 static bool pci_reset_phbs __read_mostly;
 
-static int __init iommu_setup(char *str)
-{
-	if (!str)
-		return -EINVAL;
-
-	while (*str) {
-		if (!strncmp(str, "nobypass", 8)) {
-			pnv_iommu_bypass_disabled = true;
-			pr_info("PowerNV: IOMMU bypass window disabled.\n");
-			break;
-		}
-		str += strcspn(str, ",");
-		if (*str == ',')
-			str++;
-	}
-
-	return 0;
-}
-early_param("iommu", iommu_setup);
-
 static int __init pci_reset_phbs_setup(char *str)
 {
 	pci_reset_phbs = true;
@@ -2456,7 +2435,7 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 		return rc;
 	}
 
-	if (!pnv_iommu_bypass_disabled)
+	if (IOMMU_DMA_MODE_IS_PASSTHROUGH())
 		pnv_pci_ioda2_set_bypass(pe, true);
 
 	return 0;
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d88dc44d60d88ea..b053eeaa82ebca8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -77,6 +77,7 @@ config IOMMU_DEBUGFS
 choice
 	prompt "IOMMU dma mode"
 	depends on IOMMU_API
+	default IOMMU_DMA_MODE_PASSTHROUGH if (PPC_POWERNV && PCI)
 	default IOMMU_DMA_MODE_LAZY if S390_IOMMU
 	default IOMMU_DMA_MODE_STRICT
 	help
-- 
1.8.3


