Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000E3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E73217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="QBMldSGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDKStA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:49:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39154 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfDKSs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:48:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id k45so6141033edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AUkwsqPqLpOQmNdW6Zo0mGf3wmD2BJmU+zJegMbV/Cw=;
        b=QBMldSGXvc5UwIGLNlY32ptO/VQea8opvEhsRdSzFj4NeN+2G0brH1f/8UVXoDmFzp
         vgXq8kR+NdanSwtvOTUwpCkm2QCKmWJ4W86KO5tQnP14gTIyY6jfmkyqnM3PIjU1mTrt
         RDRIQ3bZewU8rrugmcD7S8kRSviGvRiF9zV4bsr6eB83nCXNebkP2SIudff9lbHkRgMS
         jtauEkPGJgc+fdQv9IWyCVoKtXmY9AvPYOF2tkN2bpTztPvH+bZN2z5g44aD0CJPVIjp
         Jfs1P1M2x6/FXn9kRoiH7d82Jzo159phG6Ce+OItl5XQo6MoCtkdx/N7GlvqiQu50XsS
         3gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AUkwsqPqLpOQmNdW6Zo0mGf3wmD2BJmU+zJegMbV/Cw=;
        b=MMuv9WjvQVjLITshWTuTWrY0k6SrdzYmbKg2JxDTVIU0XznZth9c8gVCmMBbLsEA/B
         P6BJ7FIloZQn+aoc+M3PvqYQg+JitoC9oCgZ7hZXxmWU/V+2SI9WFA2BhVULY6VC52wN
         lwWjbdyQzn3RALSFPdqF4ItI53Glscs6cDpDxwDBp/deRMVg3cEDfS49Dw7EYWtetc3j
         oKm56RdcQt849PnJV6i8TpgjLBWEvmvP4eXzI7oIsDSV00AuhH3HIpVSdLXKB7olhs5l
         /JH+I3DFpBtW8nA3McBJrZDYVv2oFYxRbKiPDMrHknAF9szr5ii62Abk5zpAPBIsQ8Kl
         lPrA==
X-Gm-Message-State: APjAAAXzen/4zwk8DwVE4rE3iAob8zvq41vRk+7ZRIErGkQCxKQKd+lr
        HKt+gTz7lYYEvQRXFks5Gn7kQA==
X-Google-Smtp-Source: APXvYqzL/CeoYgUz/dL+UCoRPB57kS8k+K0AU3mwSjtkIW0qzE0UGCl3M97UgeKZ/ZqnWNSSEOk5sg==
X-Received: by 2002:a17:906:f0f:: with SMTP id z15mr12761935eji.125.1555008537548;
        Thu, 11 Apr 2019 11:48:57 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
        by smtp.gmail.com with ESMTPSA id b10sm1285130edi.28.2019.04.11.11.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:48:57 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie,
        Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 3/9] iommu/dma-iommu: Add iommu_dma_copy_reserved_iova, iommu_dma_apply_resv_region to the dma-iommu api
Date:   Thu, 11 Apr 2019 19:47:32 +0100
Message-Id: <20190411184741.27540-4-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To convert the AMD iommu driver to the dma-iommu we need to wrap some of
the iova reserve functions.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 27 +++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  7 +++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cc5da30d6e58..613d181e78a9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -162,6 +162,33 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+static struct iova *iommu_dma_reserve_iova(struct iommu_domain *domain,
+		dma_addr_t iova_lo, dma_addr_t iova_hi)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	unsigned long order = __ffs(domain->pgsize_bitmap);
+
+	return reserve_iova(iovad, iova_lo >> order, iova_hi >> order);
+}
+
+void iommu_dma_copy_reserved_iova(struct iova_domain *from,
+		struct iommu_domain *to)
+{
+	struct iommu_dma_cookie *cookie = to->iova_cookie;
+	struct iova_domain *to_iovad = &cookie->iovad;
+
+	copy_reserved_iova(from, to_iovad);
+}
+
+void iommu_dma_apply_resv_region(struct device *dev,
+		 struct iommu_domain *domain, struct iommu_resv_region *region)
+{
+	dma_addr_t end = region->start + region->length - 1;
+
+	WARN_ON_ONCE(iommu_dma_reserve_iova(domain, region->start, end) == NULL);
+}
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..c527ded5c41c 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -23,6 +23,7 @@
 #ifdef CONFIG_IOMMU_DMA
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
+#include <linux/iova.h>
 #include <linux/msi.h>
 
 int iommu_dma_init(void);
@@ -57,6 +58,12 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, int prot);
 
+/* These are wrappers around some iova functions */
+void iommu_dma_apply_resv_region(struct device *dev,
+		struct iommu_domain *domain, struct iommu_resv_region *region);
+void iommu_dma_copy_reserved_iova(struct iova_domain *from,
+		struct iommu_domain *to);
+
 /*
  * Arch code with no special attribute handling may use these
  * directly as DMA mapping callbacks for simplicity
-- 
2.17.1

