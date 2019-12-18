Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C0A2465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfRSQKT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfLRNmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:42:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51371 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfLRNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:42:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so1888912wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKV3MGTA/2/bfoWX89xXRBHVgU6rKIgrBLKBmEiF8i0=;
        b=lfRSQKT2ByflthOsB87RU7Gv/2PvSlciEuSa+25UiwhrLnL0iHnn4+2G+tmdPp6eIi
         8hHBOM9wp0okgjScFvYx5MLMnZCEA1TJeR39OBixx1o2ZnuxowVkjoeoO2DDOM4mt8ji
         fsCW3642Geo5wK1ektqMm7d3ZJxUKDc6qwCIiDzcnm+LMdzaYs+qxHNzNlZLqVXDSfKG
         DbkTv0PbLwZweD1bhIX0ug+7Z9kb9qmyACSOGMFISjfDtNe9DeJxvIQUmtd5xZ7N2Tgq
         CBX1HNtqdjmwRk/3NrQefKgfSxDTLW8img+98wK2TfAwYs6tSKsZBZzWgROCMNUri9KQ
         EIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKV3MGTA/2/bfoWX89xXRBHVgU6rKIgrBLKBmEiF8i0=;
        b=tr4qTB7tNR7MmlovY0iFSQ2W4SO6QLznoQ2GdFNmLQYxGqfmKfeH7/sML86hvgMPvE
         l0z3bSNRwuVb6xLIa7SUx7uj05lzLJKFm6K6Cja7DH1n5IMJhLyi6jvPnUwdzaoNP11F
         Vu7APFZV7qz2dwBgcABhDHk8KKX4CJRjdW7H6rrEWvKAAgXn6SJxB/ui4xjlSjzQrbGN
         l+hLzH0QzPCBaa2Gs091fy/Twqz5OwMYldvNoMNOwwXYSpBoMmAeqTyaOC7H91bldMTl
         3IiKnEQ8mOYGXpwGs0alBGgfJP+OyLwUjqFR04JOjBgiF54qK+ac0y1WORVnGCBsm7EV
         uxJQ==
X-Gm-Message-State: APjAAAVYdXP/mPAo57HbtsTBK8mzG0qSUKbwAVxPxQFgsIKkGUzPa415
        5SkLBk5eNdzXUB2tJ+rQCdU=
X-Google-Smtp-Source: APXvYqxmdcdJB1mXOevGjXDjzCqOvxzn0AuQ1Uyb5JkQ9iCe5BgU+bDq2ZCvGwKiujMBqMzfvOdIJQ==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr3619567wmc.42.1576676535246;
        Wed, 18 Dec 2019 05:42:15 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id j130sm2640695wmb.18.2019.12.18.05.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:42:14 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] iommu: arm: Use generic_iommu_put_resv_regions()
Date:   Wed, 18 Dec 2019 14:42:02 +0100
Message-Id: <20191218134205.1271740-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218134205.1271740-1-thierry.reding@gmail.com>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
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
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu-v3.c | 11 +----------
 drivers/iommu/arm-smmu.c    | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index effe72eb89e7..7f5b74a418de 100644
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
+	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 31ad3fe9a6d1..7a5978bbeca8 100644
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
+	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.24.1

