Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE0DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F40524672
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlM4L+5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLTAcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:32:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45437 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfLTAce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:32:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so3314708pls.12;
        Thu, 19 Dec 2019 16:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uQbeCCqbXt+TANvd9D2T1EUoXbYPHKnFq/HMhRHqLLk=;
        b=KlM4L+5/d17GS8edHbVCqPbHiJlES5jOQEPTRygl9a/rcXjJSULDlWnn3CnxoCNDxX
         iK6Re9a4D/xw67PH/qceV8QHfN5uq0ynVl/YID62PAERj1thJ2LTF0Fx23bi9QPqJ1gm
         Gj8iD/szjoOaQsDWV7yVwMnYTJ6sihPSD5ONPsF4SorBE6BwDAHl4EnoXT8xNgT94r0C
         mi882Zb75Az80Wu0BoYaLiZywfxp6Cb9HNX9mexMI1bfOyIPaIcVg9dNpU3gUr0CoLDX
         JAW5buDBnWUNFiqoBOiO9/HTffRveKFlvfHtKf/ty+AY3Wfy+Of+PqcvWWgYiWVosfal
         vK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uQbeCCqbXt+TANvd9D2T1EUoXbYPHKnFq/HMhRHqLLk=;
        b=owS9LAW24AByczixpuCF3cTfvev0wE0sgjDF78oKelbeYK9/wiPq60cyU1YCNfhODq
         83yOrmD/ezxZZMsJ0jQkRZsv9qCHCCR3unhkYZOQKL0ArCq2GQS0JRfd68UKved0pJZI
         wrJaDi8v5ARXSG++q5uH4VxrmYmV94mgMqlUfakt+XLJU31zoD0dS/QSvZWky86Rg/93
         Dap/SW7qRLyxX/J5dU3HG5IbmyoWcrEs0VN5FJbWnIaNQTwWl6RtQiZxf+mkYV2cTZAT
         sLRH+hr6HFiTli/SCoFl+Pc0xbgA30JcAtBGfbT1GZcNGFU+ssJURxgg6C2sL2K7PerX
         G4Pg==
X-Gm-Message-State: APjAAAUYEoeBz4eOzguzpA6qZdLYX7Ti6yCOJWKoLVuoSNVj0vI6YyiL
        EwbO59UUv7q6sYCw3OmMqdQ=
X-Google-Smtp-Source: APXvYqwRPFEm1HepTdAK1icU4d6knUegC4DnaNNyJNEVD+B/H2wm8meL7y1fed/osKoMs9+ttxYvUA==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr11816011plt.223.1576801953545;
        Thu, 19 Dec 2019 16:32:33 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a23sm10145845pfg.82.2019.12.19.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 16:32:33 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
Date:   Thu, 19 Dec 2019 16:29:12 -0800
Message-Id: <20191220002914.19043-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002914.19043-1-nicoleotsuka@gmail.com>
References: <20191220002914.19043-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_SHIFT and PAGE_MASK are defined corresponding to the page size
for CPU virtual addresses, which means PAGE_SHIFT could be a number
other than 12, but tegra-smmu maintains fixed 4KB IOVA pages and has
fixed [21:12] bit range for PTE entries.

So this patch replaces all PAGE_SHIFT/PAGE_MASK references with the
macros defined with SMMU_PTE_SHIFT.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 63a147b623e6..5594b47a88bf 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -127,6 +127,11 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define SMMU_PDE_SHIFT 22
 #define SMMU_PTE_SHIFT 12
 
+#define SMMU_PAGE_MASK		(~(SMMU_SIZE_PT-1))
+#define SMMU_OFFSET_IN_PAGE(x)	((unsigned long)(x) & ~SMMU_PAGE_MASK)
+#define SMMU_PFN_PHYS(x)	((phys_addr_t)(x) << SMMU_PTE_SHIFT)
+#define SMMU_PHYS_PFN(x)	((unsigned long)((x) >> SMMU_PTE_SHIFT))
+
 #define SMMU_PD_READABLE	(1 << 31)
 #define SMMU_PD_WRITABLE	(1 << 30)
 #define SMMU_PD_NONSECURE	(1 << 29)
@@ -644,7 +649,7 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 			       u32 *pte, dma_addr_t pte_dma, u32 val)
 {
 	struct tegra_smmu *smmu = as->smmu;
-	unsigned long offset = offset_in_page(pte);
+	unsigned long offset = SMMU_OFFSET_IN_PAGE(pte);
 
 	*pte = val;
 
@@ -680,7 +685,7 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 		pte_attrs |= SMMU_PTE_WRITABLE;
 
 	tegra_smmu_set_pte(as, iova, pte, pte_dma,
-			   __phys_to_pfn(paddr) | pte_attrs);
+			   SMMU_PHYS_PFN(paddr) | pte_attrs);
 
 	return 0;
 }
@@ -716,7 +721,7 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 
 	pfn = *pte & as->smmu->pfn_mask;
 
-	return PFN_PHYS(pfn);
+	return SMMU_PFN_PHYS(pfn);
 }
 
 static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
@@ -1034,7 +1039,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	smmu->dev = dev;
 	smmu->mc = mc;
 
-	smmu->pfn_mask = BIT_MASK(mc->soc->num_address_bits - PAGE_SHIFT) - 1;
+	smmu->pfn_mask =
+		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
 	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
 		mc->soc->num_address_bits, smmu->pfn_mask);
 	smmu->tlb_mask = (smmu->soc->num_tlb_lines << 1) - 1;
-- 
2.17.1

