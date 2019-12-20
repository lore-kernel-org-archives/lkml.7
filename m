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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ACCC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6ED2465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD5NDXyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLTAcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:32:41 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55149 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLTAcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:32:36 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep17so3300792pjb.4;
        Thu, 19 Dec 2019 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rDhGn3D52iJxkHzCP3mTsRd2P8WhMkWO8X9jAcOeSIA=;
        b=rD5NDXyY4kT+DdfDWZH8k1yYtROAbNunav4TSQ9Gv/YSit70QvTlQegpXR9zvanMuC
         HGp2laefH3s6V/OjKnbqjZyMcbSQMMK+VUtdgdkngVv9QddZ0qDEIMK/xlfAXG5GK2H8
         kfbgxvDETi43cEpELuVN1NEgtzPGAIS9TIxd3rgNWDS/21v3TjQ7EeFGRQ1ctCepo23t
         eyUqjCIAJ9GqAWX3DkSXDGM1rFfFjU9RaVM7V1AdrZMxOIx6oH5weNS1uN+SaKwgqwDk
         ocYnxbDjpgUTSrMnHlHdPk9IzbsESESoBIWOsPlOiwcF77BWJM4Yh/89nZ8zbmHLSpHo
         Bcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rDhGn3D52iJxkHzCP3mTsRd2P8WhMkWO8X9jAcOeSIA=;
        b=ANC4IiqMTigDzxNQhdbc3fghGZ7D2QS70WScqYp6LLZMS/U1dfq2t5WrlUmvdeo63v
         0ygVf7aOdc/HntqJuvwkoVwvyWT/8uhhuQFgQSsp71h8JdXuvvdfJjr4t9MuSJ4HEL5F
         zzLuE+DN6rbTfMfwlVeOlpqnR6wC1N1UlZdlMKlWwyBNoGW5aSZw/57xlQqdykPRwnXd
         +5HVjTzXhLXBaLqU/9l2ieOqKViFkf6mFrxlwY8z4DCVzzKjgHtbQPsmZayk1nQyX1qP
         BvgxS3PmnKjbcZS1ZeanjRsMYxnGgojfi0gCRvya9TDvq31jUTq/T0E3r3e+lZtBYXfb
         5/pQ==
X-Gm-Message-State: APjAAAXGUzWfskAY7TW9GXbMbFyvGPxEdelDzcUUJrgMD3pF3Z1dfLyr
        QlSx8vgtCLwKObO2Eydbr6c=
X-Google-Smtp-Source: APXvYqwSC6mIbKaAEPt+A8fSzCMKI1FstUpdwYnmK1yyvlti7s/8B2Pujsxd38trVP4lxkn8zJHh7A==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr11031641plk.209.1576801955160;
        Thu, 19 Dec 2019 16:32:35 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a23sm10145845pfg.82.2019.12.19.16.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 16:32:34 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iommu/tegra-smmu: Prevent race condition between map and unmap
Date:   Thu, 19 Dec 2019 16:29:14 -0800
Message-Id: <20191220002914.19043-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002914.19043-1-nicoleotsuka@gmail.com>
References: <20191220002914.19043-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing with ethernet downloading, "EMEM address decode error"
happens due to race condition between map() and unmap() functions.

This patch adds a spin lock to protect content within as->[count]
and as->pts[pde] references, since a function call might be atomic.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 3999ecb63cfa..236bc6d6d238 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -37,6 +37,7 @@ struct tegra_smmu {
 
 	unsigned long *asids;
 	struct mutex lock;
+	spinlock_t as_lock;
 
 	struct list_head list;
 
@@ -664,17 +665,23 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
+	struct tegra_smmu *smmu = as->smmu;
+	unsigned long flags;
 	dma_addr_t pte_dma;
 	u32 pte_attrs;
 	u32 *pte;
 
+	spin_lock_irqsave(&smmu->as_lock, flags);
 	pte = as_get_pte(as, iova, &pte_dma);
-	if (!pte)
+	if (!pte) {
+		spin_unlock_irqrestore(&smmu->as_lock, flags);
 		return -ENOMEM;
+	}
 
 	/* If we aren't overwriting a pre-existing entry, increment use */
 	if (*pte == 0)
 		tegra_smmu_pte_get_use(as, iova);
+	spin_unlock_irqrestore(&smmu->as_lock, flags);
 
 	pte_attrs = SMMU_PTE_NONSECURE;
 
@@ -694,6 +701,8 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
+	struct tegra_smmu *smmu = as->smmu;
+	unsigned long flags;
 	dma_addr_t pte_dma;
 	u32 *pte;
 
@@ -702,7 +711,10 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 		return 0;
 
 	tegra_smmu_set_pte(as, iova, pte, pte_dma, 0);
+
+	spin_lock_irqsave(&smmu->as_lock, flags);
 	tegra_smmu_pte_put_use(as, iova);
+	spin_unlock_irqrestore(&smmu->as_lock, flags);
 
 	return size;
 }
@@ -1033,6 +1045,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 
 	INIT_LIST_HEAD(&smmu->groups);
 	mutex_init(&smmu->lock);
+	spin_lock_init(&smmu->as_lock);
 
 	smmu->regs = mc->regs;
 	smmu->soc = soc;
-- 
2.17.1

