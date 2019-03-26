Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A842075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEl0Z5Ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbfCZXBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:01:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36908 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732889AbfCZXBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:01:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so8760512pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pbdwi/63Agi4s6Tt6RAM0FtL+bzJWgpn5Dncpfelpvo=;
        b=VEl0Z5RabQr/GpMe+VeLFsQb1j8S9dkjTJrD73RCdjoxt/+64vqdmHwA3oCGAU3Rao
         muG6Fg1gGNy4yTM2ISm6Gf3H5J7n1jKEiVHPSGMKodZ0bbiuQWDa8gw1fkXV8HsU5ery
         mpeAb6v/5rSdYG4hg+7ZETItqEadoofzRSDWxISNsQUrrUVE7NPHPampAmcd89uvOBnV
         ILhZtuXSENh2o4CATQZwLUHukCRjgN4ODRK3DJXp21AKe0LehF7+/VJaueNzwuYtNAkD
         OQ53fK3oOGDrCaQw0Syk2v6ZUm+nJiznA+UTVRMM49uxpitTBcIJ45aavdT9RDkG7MNG
         OkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pbdwi/63Agi4s6Tt6RAM0FtL+bzJWgpn5Dncpfelpvo=;
        b=KKAgACKIyEU4dZhxmew3JfQwUpyoMaHyEnuzwI5rsNFwZHX8GYP+ofXE288Vcl0H50
         KQ17J0csYhGQZZZ2xE1Pd9La44ay5rU4kluVGBikt109y3ar7O+ke7nQeGRC1xLRz2Sa
         DHYChzpqosZMlSPVgZ0RNxbGd2IDv3AD9JDggya8RejqoJFpdNBSQF4l4jqUUT5DAqnA
         yZ0gBCV+NAE2DP593FX3JGC4B+LEQwymILy0DSDCxSfrJOOEASO0OW0UnjkkHNnknCCA
         ASz4b1iRIaurrIsaS3WYwMbPGXwr2LdtmSS3pz5MVwgimogHTtMwkxJIPyJXze0zFOS4
         2BNw==
X-Gm-Message-State: APjAAAWkPsV6CKcGCV4m7HNDT4PJzpQq5ddDgy/TPIhnodt8jx4RHJKY
        3+MBIfQ7nwFAE8HwaHGXMHg=
X-Google-Smtp-Source: APXvYqzI4KLCbPz8UxICZ051Zm3uWTFPxOlGhyODzocBuOSnWTYCxGRTIeA0rPSHp3VHcl/fsSnMcw==
X-Received: by 2002:a62:388d:: with SMTP id f135mr17894178pfa.103.1553641301996;
        Tue, 26 Mar 2019 16:01:41 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n24sm43832587pfi.123.2019.03.26.16.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 16:01:41 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH v2 RFC/RFT 3/5] iommu: amd_iommu: Add fallback normal page allocations
Date:   Tue, 26 Mar 2019 16:01:29 -0700
Message-Id: <20190326230131.16275-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326230131.16275-1-nicoleotsuka@gmail.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CMA allocation will skip allocations of single pages to save CMA
resource. This requires its callers to rebound those page allocations
from normal area. So this patch adds fallback routines.

Note: amd_iommu driver uses dma_alloc_from_contiguous() as a fallback
      allocation and uses alloc_pages() as its first round allocation.
      This's in reverse order than other callers. So the alloc_pages()
      added by this change becomes a second fallback, though it likely
      won't succeed since the alloc_pages() has failed once.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/amd_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 21cb088d6687..2aa4818f5249 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2701,6 +2701,9 @@ static void *alloc_coherent(struct device *dev, size_t size,
 
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
 					get_order(size), flag & __GFP_NOWARN);
+		if (!page)
+			page = alloc_pages(flag | __GFP_NOWARN,
+					   get_order(size));
 		if (!page)
 			return NULL;
 	}
-- 
2.17.1

