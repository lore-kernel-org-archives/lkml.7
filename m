Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424ADC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1654A2068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+zUhOwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfLIOuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:50:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39832 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIOuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:50:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so16492862wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irY1spgwK2zJfffTq8hx9QkgkytRwMbw4YTsIN/qTSs=;
        b=p+zUhOwB6ukKqHU1wRnWzmuH1Syry5ctKEBh4K/KnTuMWlFphp+kHl1BAjCMzE8bUn
         JbitSWNYgIJs1Er1uTZ1En5urRIyaOTjdzHSFqWqc6PNayKiJfVSjxdVCnuENRIsqGdZ
         x29ePNxjRxb7+2m0SLIjPgfiL35pn/FNg8zbhtqmtSzgVLotzYNhu0j9rT6izICcYOJ9
         D7obuCApHHIprX+PvKaHEOuN3f94riINTAds1kDs95ws/34M1XPS33udUgaQs9ZdlhvB
         NUixRBi/sfBfmORbHV3VsUJ8qvyPKTYy5ife5AH6b1OYstx8p1mmh3N3omkpyvpvw+1X
         W/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irY1spgwK2zJfffTq8hx9QkgkytRwMbw4YTsIN/qTSs=;
        b=mzFjykd8XZwNpktsp4v5OAXkkuAiMLeiou0HmmM6a0XYgVOWg4f2nlUxdZeVTjpsxK
         hO2ugnecM05Fx4+m/z+Me3oF5KNnGU0yH6KpIT4l575KFTmGu7rPWTg0geqNZ/tiE55T
         zHJeFs03D3K+2QMVJ5kiGD48eHPh/RNhi8PHCUS8ULpPvCjWwq3CGSXls/9mdesaBq+f
         mkSj/W/RoVzZQ8w4HIJT3+RDLSTQqI3FQ+iODCux9IOkK/rqhj0Ifvi4m7CYoOXn9xEr
         Qkdi38C47GfdxKOdPbnFm1Y9Fo3zx5/g8HGU4Ok4Wu9RNBVXrn0rJ3z2qCXpov2rNrRd
         /uWw==
X-Gm-Message-State: APjAAAXoxJKkWPB49B+ywh7KZOnpvMiIcIt4dfzGYi78qB8FtrX9ODww
        cb4QkHyBpd8junKgmdcpoHA=
X-Google-Smtp-Source: APXvYqwsN0YOpBRkErf/6RtkAtfpULTvJ5FiPJAY1U9wSh3s2TnoIO21C8Ievdu6ssFmIdevGhFIbA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr2587731wro.334.1575903014734;
        Mon, 09 Dec 2019 06:50:14 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id g9sm27179539wro.67.2019.12.09.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:50:13 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] iommu: arm: Use iommu_put_resv_regions_simple()
Date:   Mon,  9 Dec 2019 15:50:04 +0100
Message-Id: <20191209145007.2433144-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209145007.2433144-1-thierry.reding@gmail.com>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use the new standard function instead of open-coding it.

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu-v3.c | 11 +----------
 drivers/iommu/arm-smmu.c    | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index effe72eb89e7..eebf6086080f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2710,15 +2710,6 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static void arm_smmu_put_resv_regions(struct device *dev,
-				      struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2736,7 +2727,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 31ad3fe9a6d1..d1aef07bb784 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1576,15 +1576,6 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static void arm_smmu_put_resv_regions(struct device *dev,
-				      struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -1602,7 +1593,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.23.0

