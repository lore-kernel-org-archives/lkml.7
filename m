Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCFBC2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1D62465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYODVoHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfLTAch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:32:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44567 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfLTAcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:32:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id az3so3316629plb.11;
        Thu, 19 Dec 2019 16:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=akrkBMpqRXFQPcCm5/1wYSUhWRwH2v6a1sHtRnKtplc=;
        b=UYODVoHi8JFnpKfFi7iMfwGGR517WAqt+lYnzVodSOBLM2zUwiOWvlJvNKEChhQXJ0
         PBFvkFCyErW+Rg2WPraOX/9oK1T/EbTUYZyige1JseNpRKndJBVFrw2+rf1ibXps0Hw1
         uWRi5eq+2ytYrFC5lxnq3/OPyoZguseK8X9E+vM3fTOxgMwfA/qKhGKjqKU75K7lsjZW
         zlecgfcIo0AEKzkI8CDJA5H2dCgBAez79yEcSJ52ED7rQbOe/XkBVLeiwTInPRQX871M
         kqOgHrdMJPrcPCs39xFTTAFkjmROEBZ4lsil5j15/swwiyT4HTenhlik1n2r3ZENk391
         BVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=akrkBMpqRXFQPcCm5/1wYSUhWRwH2v6a1sHtRnKtplc=;
        b=LN9+ByOKfhW8zagpoORozLBIGC4tl+Q5qu36AY+cYS4180kH1jmbNsDXSo6rd4nIf7
         yKQfGGhdeQ04q2Qcc5ykHCO0VTPsTY8S/c3a9MhLPm6oF+8SyYgFxDdVoHsnW+WqH79e
         VUqgTtsaz7eX9ftOaejeUw4MOzmYTcbfx8z9eezJqcE0BgyqQHJ9BRPIpyu6DMGGLd94
         dqKUs3EoUDh37ztAwzbgKLk/iVf5WqSoLFjVnAR0nLN1eOJMTOsjL2p++gaJeeDb/4rp
         DO5pI6NTBu0SDNM13/ETPTpRUvCNe4KJUVOP7+aJqSlvZlWQ6evF8wOb9WlIuPVQJeCB
         xFLQ==
X-Gm-Message-State: APjAAAUlkOY1S7gmX1B2Yj+ndfBp68GaClLNIn0rk1F0L/6OmXJzkBzn
        S33NDbKC2u8sy6PVOCprIdE=
X-Google-Smtp-Source: APXvYqyTPeiJwGFOX7bNSvc/YQlDxCfCUFmPP4tT6wpZ2HM3ivMg7wYXgSmvVnrMFp+NujRZOXkP2w==
X-Received: by 2002:a17:902:be07:: with SMTP id r7mr11660195pls.183.1576801954343;
        Thu, 19 Dec 2019 16:32:34 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a23sm10145845pfg.82.2019.12.19.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 16:32:33 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommu/tegra-smmu: Fix iova->phys translation
Date:   Thu, 19 Dec 2019 16:29:13 -0800
Message-Id: <20191220002914.19043-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002914.19043-1-nicoleotsuka@gmail.com>
References: <20191220002914.19043-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOVA might not be always 4KB aligned. So tegra_smmu_iova_to_phys
function needs to add on the lower 12-bit offset from input iova.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 5594b47a88bf..3999ecb63cfa 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -721,7 +721,7 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 
 	pfn = *pte & as->smmu->pfn_mask;
 
-	return SMMU_PFN_PHYS(pfn);
+	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
 static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
-- 
2.17.1

