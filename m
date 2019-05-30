Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184ABC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD5C24D54
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbfE3Dt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:49:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18050 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387653AbfE3DtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:49:25 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BDE66C3CFC5D45E96D5B;
        Thu, 30 May 2019 11:49:22 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 30 May 2019 11:49:15 +0800
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
Subject: [PATCH v8 3/7] s390/pci: add support for IOMMU default DMA mode build options
Date:   Thu, 30 May 2019 11:48:27 +0800
Message-ID: <20190530034831.4184-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190530034831.4184-1-thunder.leizhen@huawei.com>
References: <20190530034831.4184-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default DMA mode is LAZY on s390, this patch make it can be set to
STRICT at build time. It can be overridden by boot option.

There is no functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/s390/pci/pci_dma.c | 2 +-
 drivers/iommu/Kconfig   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 9e52d1527f71495..784ad1e0acecfb1 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -17,7 +17,7 @@
 
 static struct kmem_cache *dma_region_table_cache;
 static struct kmem_cache *dma_page_table_cache;
-static int s390_iommu_strict;
+static int s390_iommu_strict = IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
 
 static int zpci_refresh_global(struct zpci_dev *zdev)
 {
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d6a1a45f80ffbf5..9b48c2fc20e14d3 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -78,6 +78,7 @@ config IOMMU_DEBUGFS
 choice
 	prompt "IOMMU default DMA mode"
 	depends on IOMMU_API
+	default IOMMU_DEFAULT_LAZY if S390_IOMMU
 	default IOMMU_DEFAULT_STRICT
 	help
 	  This option allows IOMMU DMA mode to be chose at build time, to
@@ -87,6 +88,7 @@ choice
 
 config IOMMU_DEFAULT_PASSTHROUGH
 	bool "passthrough"
+	depends on !S390_IOMMU
 	help
 	  In this mode, the DMA access through IOMMU without any addresses
 	  translation. That means, the wrong or illegal DMA access can not
-- 
1.8.3


