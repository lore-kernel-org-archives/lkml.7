Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB1C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 15:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16FC2253D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 15:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="WkrW4Y9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfLUPEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 10:04:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39441 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfLUPEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 10:04:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id t17so11391818eds.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 07:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4dEmM8P1MkKKnNa6NcbuVyKrLsO9ZvL1WqSkd7MOXA=;
        b=WkrW4Y9gFyG7Qyoell6pvhgdKX7JRReMnuuB9atJoZy04C/ONzngI9MJcZe1C52tLI
         oAbpeUorXN0OuO/Eg0uTEPtK43geQL68lw4o7Ot8H5XsWGNoa1eKf/zWorwqA2LubWhP
         ocpyZSMtNUbr1NWS3tmsbNFojfO0KFn4+WKore4fioT3aEQ4/J+J2uZcNnl0dckx4Wul
         NRwfEfsYHCfN/A/PJf0LwxVas5fBCAxc6UJkeMBPTkWvH4AkfCBijNzpnj6o2cB8Gozf
         5sLHCOhpM/FGuPL/eZWe8ySg2l+HsNgX8TbOePQbTkrzEKNWd/Ih3KEJxTQ88SBthjQ7
         3K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4dEmM8P1MkKKnNa6NcbuVyKrLsO9ZvL1WqSkd7MOXA=;
        b=pj56d5N3u4n5BuCcFBuOPJ4ypdJ8zNqADIYTGT3JOJl9nP+TlPTstOqXq5ixa0W8Mg
         AkiFXc/UWv0a98LFbJmBT5xCLkppolTKakfH/OEZt25WXcwxOrT8m0Rbq8u+MLYrDfp0
         sYXIO6hiztDSZKna3oWixKN6+rqSW5Xr5EBLFfENIkbZdoM8JzVzXhWuHUMriKA30G7Z
         FhDTf/qL8WXT/yzlJDx1N0Nrq4Vn0DCIqg9NNBaGpCfvzie0Jq2ycsrC9T9/vwDx252l
         vz+7ukDhAHfJgvsz03bwHkQvuaNF8UjIMNmas3BpaHzR3hvfUnRNoIAWLaSUO42aVguH
         kkGg==
X-Gm-Message-State: APjAAAU+5IYoneskJzxE2S6bktiI5AhxbNTuIftJ5FL2dSziqkWAP/h4
        UddB19X/7LWW7p2zW+I7ObGgVA==
X-Google-Smtp-Source: APXvYqzXACa8CmCe+lm4PqHAgWDF0JjnrRxrrR2y7kN6n1yqsWvuOaXwCLqKegFsZD4yWY1Pcx2X8g==
X-Received: by 2002:a05:6402:2c3:: with SMTP id b3mr22084523edx.207.1576940686355;
        Sat, 21 Dec 2019 07:04:46 -0800 (PST)
Received: from localhost.localdomain ([80.233.37.20])
        by smtp.googlemail.com with ESMTPSA id u13sm1517639ejz.69.2019.12.21.07.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 07:04:45 -0800 (PST)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [PATCH 5/8] iommu: Add iommu_dma_free_cpu_cached_iovas function
Date:   Sat, 21 Dec 2019 15:03:57 +0000
Message-Id: <20191221150402.13868-6-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191221150402.13868-1-murphyt7@tcd.ie>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to dma-iommu ops

Add a iommu_dma_free_cpu_cached_iovas function to allow drivers which
use the dma-iommu ops to free cached cpu iovas.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 9 +++++++++
 include/linux/dma-iommu.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index df28facdfb8b..4eac3cd35443 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -50,6 +50,15 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+
+	free_cpu_cached_iovas(cpu, iovad);
+}
+
 static void iommu_dma_entry_dtor(unsigned long data)
 {
 	struct page *freelist = (struct page *)data;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2112f21f73d8..316d22a4a860 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,6 +37,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
-- 
2.20.1

