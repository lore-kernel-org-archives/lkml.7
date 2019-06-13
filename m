Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C427BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF14206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="Q7YqbkWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFMWjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:39:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45572 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFMWjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:39:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so456397edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcPKIz/cx9BuSCY4h5Jds9dddvg3WP5b4PjiRQaCMNk=;
        b=Q7YqbkWKog9myMLVKuEgSGV/QhFlPY8pqvqD3ElQJa5O+VupGahQ/2KWdmD42UChZU
         wPmlxSspSryqNb5xCB8JLtGZX6vRCzXM8xY7AmfA6QICBXISxNprKepOzIgPRJ0PmKvq
         lwOf3L9Aeaw9au+GkaXXU5HxIJQ1vxFfownqyJtqMjhF5SRbY4FdMVVh7ZLQ7hbQYj3Q
         iidXZkXXf0qlsVYk9WxwAFcMHH4IP3leZkOYhpAmRlGBv4K+6lmx2ZeQRojQOmlcq9FK
         mitiCFQNPcpZ74hbmAblxvrrqQFu7g6p6HGZuZiNBMXyyAAw52tc7SZA4bY0a5yZBSlR
         Rxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcPKIz/cx9BuSCY4h5Jds9dddvg3WP5b4PjiRQaCMNk=;
        b=DvDLmbKEumJZtPrz+BuorhJO/MHoZC6v2IFsloksY/G1ZHtfm1+kF69jJBIdRj1wVM
         4Z8HKhQh9/qLMUz8lf6mw0/hG5jN/ih3wEoD3R6eJyRE75QCrTMh0Jux1dDPqN5r1Q1Q
         5XK/ZduDUZb6rKEsHRtusj1z+jSpgA7zeOUmyQR0YFqIL3yI8g8lKo5iHH61u1NZD7Tq
         eJXb9kgA0BfnXUgvm05qdiutyMrFA8oobZqrddQnFOhu89NyVd3cVxRz8pMETe8jJ7sR
         DI4DwKmeU7btU3WVtfYCjpGVrvZv0DK35++rMEuiFw5HhY/tDrOZXKKui5HXEXyepu8D
         +vgA==
X-Gm-Message-State: APjAAAWRONNNux0Gjqmeq8Ys4RPs9UqjeP0h1efgbYHf6bEcdFfRIXer
        l7lHt/Za9kwc5rgkwwRHUrVChw==
X-Google-Smtp-Source: APXvYqznp1hHyw5PYwIoh2oTLD6q+OMGquaY21fb63SmdivVnsFdvFIZnOzRxPqoidZqkL4RdKrnQw==
X-Received: by 2002:a50:bdc2:: with SMTP id z2mr97240407edh.245.1560465555952;
        Thu, 13 Jun 2019 15:39:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:a0:bc00:8042:d435:a754:1f22])
        by smtp.googlemail.com with ESMTPSA id s16sm216522eji.27.2019.06.13.15.39.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 15:39:14 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 0/5] iommu/amd: Convert the AMD iommu driver to the dma-iommu api
Date:   Thu, 13 Jun 2019 23:38:55 +0100
Message-Id: <20190613223901.9523-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the AMD iommu driver to the dma-iommu api. Remove the iova
handling and reserve region code from the AMD iommu driver.

Change-log:
V4:
-Rebase on top of linux-next
-Split the removing of the unnecessary locking in the amd iommu driver into a seperate patch
-refactor the "iommu/dma-iommu: Handle deferred devices" patch and address comments
v3:
-rename dma_limit to dma_mask
-exit handle_deferred_device early if (!is_kdump_kernel())
-remove pointless calls to handle_deferred_device
v2:
-Rebase on top of this series:
 http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.3
-Add a gfp_t parameter to the iommu_ops::map function.
-Made use of the reserve region code inside the dma-iommu api

Tom Murphy (5):
  iommu/amd: Remove unnecessary locking from AMD iommu driver
  iommu: Add gfp parameter to iommu_ops::map
  iommu/dma-iommu: Handle deferred devices
  iommu/dma-iommu: Use the dev->coherent_dma_mask
  iommu/amd: Convert AMD iommu driver to the dma-iommu api

 drivers/iommu/Kconfig           |   1 +
 drivers/iommu/amd_iommu.c       | 690 ++++----------------------------
 drivers/iommu/amd_iommu_types.h |   1 -
 drivers/iommu/arm-smmu-v3.c     |   2 +-
 drivers/iommu/arm-smmu.c        |   2 +-
 drivers/iommu/dma-iommu.c       |  45 ++-
 drivers/iommu/exynos-iommu.c    |   2 +-
 drivers/iommu/intel-iommu.c     |   2 +-
 drivers/iommu/iommu.c           |  43 +-
 drivers/iommu/ipmmu-vmsa.c      |   2 +-
 drivers/iommu/msm_iommu.c       |   2 +-
 drivers/iommu/mtk_iommu.c       |   2 +-
 drivers/iommu/mtk_iommu_v1.c    |   2 +-
 drivers/iommu/omap-iommu.c      |   2 +-
 drivers/iommu/qcom_iommu.c      |   2 +-
 drivers/iommu/rockchip-iommu.c  |   2 +-
 drivers/iommu/s390-iommu.c      |   2 +-
 drivers/iommu/tegra-gart.c      |   2 +-
 drivers/iommu/tegra-smmu.c      |   2 +-
 drivers/iommu/virtio-iommu.c    |   2 +-
 include/linux/iommu.h           |  21 +-
 21 files changed, 179 insertions(+), 652 deletions(-)

-- 
2.20.1

