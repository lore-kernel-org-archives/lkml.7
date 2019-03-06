Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46726C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1209620842
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrvJgeFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfCFWxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:53:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38504 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfCFWxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:53:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id 199so12451363ljj.5;
        Wed, 06 Mar 2019 14:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LU+7KlcPdiRXM22tm6ZTfBoq9D22fW/1cFTOdm3AMs=;
        b=jrvJgeFys0LogvIr1rYmE/gfdeMHfwy2e6UTMnD+oHXMBRsqXFcRFB2sthDm3KowtJ
         PbYGyXHfR1ZH/taR50jO04w5bC6jDXE159Eahv53WWTeYO8USEsrRvwkN6gO7T7+cfSn
         KHiDUmWR3Lh8J5KrjC1kRwK+W9/04q+4axWj1KrNOcCguaSnylmDrK19lHn5ensLLwOQ
         kpINx9xCAHRQAKO5rPeE7JzPk3MWmus3VcK6AuYShKDa4OJkIrYNjtb9vOn14wGGQXhz
         XqwM3grlRcytPInjw28lb080gQlAwz+oxk7x8ac0mTQIR0GI4LgvhWoTZNR4BPmGFVOb
         msiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LU+7KlcPdiRXM22tm6ZTfBoq9D22fW/1cFTOdm3AMs=;
        b=mRUNZWXhyelTKYYSYxFejr398XaOp2KruO+PTjm4ERML+BGZt1HVCp8TZsRDyARzrF
         6sIO2IRl+SGkED6+cZqINNcNUzHfLXINxcTD1trdkXPRlTDVHtqDKTiRHJQoYCYmeBCm
         Tpb5rMq4Q06/XDeQSHTReJBFBzRlt9XwTER8btNNJTDTALx4Ub5mE4Z5WDs0en14PeQq
         ziw61MLnPn4k4uKG2xUGbffQ3OwE7unGBuhoaZq/Biw1/CumI19uZ3dSUAMk48K9QayE
         d4qYYSomGHVY/P0Ke1d83Xk7PwlEcLDOVdNCAXzubnG/ZbjdU+DV4t/bZTXyNJY60HcI
         Qd6A==
X-Gm-Message-State: APjAAAWzLeOUStztiMizjcfjGYfSFMQRSgm5Vfr9Yi9CXHn2GCZ8Txb6
        kAjzYwGaZR2y/NMSXza4RRg=
X-Google-Smtp-Source: APXvYqxqmVRrdbQFWQ0vJ9fNcJKYDJuDA/o56tgWM6FEIZXfU+FP8xzDtwjxNyhChSbue6Lrucp7yw==
X-Received: by 2002:a2e:7e0f:: with SMTP id z15mr2554764ljc.145.1551912788154;
        Wed, 06 Mar 2019 14:53:08 -0800 (PST)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id x18sm536961ljc.67.2019.03.06.14.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:53:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] iommu/tegra-smmu: Respect IOMMU API read-write protections
Date:   Thu,  7 Mar 2019 01:50:09 +0300
Message-Id: <20190306225009.3391-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306225009.3391-1-digetx@gmail.com>
References: <20190306225009.3391-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set PTE read/write attributes accordingly to the the protections requested
by IOMMU API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 27b1249f0773..463ee08f7d3a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -145,8 +145,6 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 
 #define SMMU_PDE_ATTR		(SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
 				 SMMU_PDE_NONSECURE)
-#define SMMU_PTE_ATTR		(SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
-				 SMMU_PTE_NONSECURE)
 
 static unsigned int iova_pd_index(unsigned long iova)
 {
@@ -659,6 +657,7 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
+	u32 pte_attrs;
 	u32 *pte;
 
 	pte = as_get_pte(as, iova, &pte_dma);
@@ -669,8 +668,16 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (*pte == 0)
 		tegra_smmu_pte_get_use(as, iova);
 
+	pte_attrs = SMMU_PTE_NONSECURE;
+
+	if (prot & IOMMU_READ)
+		pte_attrs |= SMMU_PTE_READABLE;
+
+	if (prot & IOMMU_WRITE)
+		pte_attrs |= SMMU_PTE_WRITABLE;
+
 	tegra_smmu_set_pte(as, iova, pte, pte_dma,
-			   __phys_to_pfn(paddr) | SMMU_PTE_ATTR);
+			   __phys_to_pfn(paddr) | pte_attrs);
 
 	return 0;
 }
-- 
2.20.1

