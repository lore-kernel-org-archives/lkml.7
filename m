Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8EFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED1A23429
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+xj84R5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfH2LOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:14:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55326 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfH2LOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:14:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id f72so3260742wmf.5;
        Thu, 29 Aug 2019 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaiScEIM2pI3Ga2qURu31RnQ0vP3+posJvio/TvHvqg=;
        b=F+xj84R55A1bQiWth2fqIYGo6UX6UgizupUvoLz120sQwCOcC4uXrlMfUAgcXj24TI
         +ictMX5b1GqoSUahPBQMokCooAzTr3wSMGpPceFi8ChyQILgqg/XiKu47sm6eO+k/2zO
         jD6zqWPf1Oz8eXvpidcfVoJe505sZPr99n9GmW/NluuemBu+j5tNN81z4G7rU/BaVXiO
         6Ls+OoqMSfZSlKaBq2chZJBP8WXng29zEIhaOt5TLB+kQp0xCQ/4AYq+9RHLu+4P7YOF
         BAt/X3om9seoBn0GBvShIun4Hdkb0EeQRZlv4/sI/MBS6XxB48gGZIAvMvE5cn/If/y/
         TyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaiScEIM2pI3Ga2qURu31RnQ0vP3+posJvio/TvHvqg=;
        b=GfYKcvjFl6EyzbTksyUGy9QSawmd8KKS9GT+I8RRoSBIBTtnV3KkTLYcAOPAHvXqmJ
         zBrI9BnZPq1ntdU/FA6IoX2tg6G2RfROxgQHmVIZFq7lMBhhYzghA5PnqArAdaGGHrfc
         KX0cndza8mekLqMaGkZ01JAqqrzBuEDHamDzIhSJ2b01BnrvdqNTLEfFJorNh4y72+9J
         UVd9UB67MkJdpgXiYD6F6NK0RdK4mRnFbkfhhJHiYBSrNsT/QOTvXQO1vz20mRdjuy9x
         o9MEIm8UeKDvfDq8nMrimVAbaGsx/H7kW1ifOZPbL4E7M8WaRuBSDOOEC2hK7+3f00YG
         s4DQ==
X-Gm-Message-State: APjAAAW0rGZQuG9+WI7uLEi/XU6iCO5efQECkBmDLcl61a+FlCBsfWz8
        ASaqgJBNNyH8eZaPA7ZDrXI=
X-Google-Smtp-Source: APXvYqxxJAd9VKSbtqu650m3xr1fElGjWbcWB3LkSAuhJv9Q6X+YMJCxf4QK1m44yZLZh+CImBf3Ng==
X-Received: by 2002:a1c:f703:: with SMTP id v3mr10575246wmh.107.1567077252984;
        Thu, 29 Aug 2019 04:14:12 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id j9sm1823662wrx.66.2019.08.29.04.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:14:11 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
Date:   Thu, 29 Aug 2019 13:14:07 +0200
Message-Id: <20190829111407.17191-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829111407.17191-1-thierry.reding@gmail.com>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

For device tree nodes, use the standard of_iommu_get_resv_regions()
implementation to obtain the reserved memory regions associated with a
device.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index de68b4a02aea..31d48e55ab55 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -164,6 +165,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
 
+	if (dev->of_node)
+		of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.22.0

