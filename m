Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9216C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA59F21479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="YkxKYH/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfIHQ46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:56:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33588 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfIHQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:56:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so6390670pgn.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E2f3KSrZxRio8/FeHv28ONTThNhL2TjtH0LaTd/eJz4=;
        b=YkxKYH/ERWEtBHeMoD9KlshTjhFsDszVa0tiICeohlWVLEzIcG2mdKPWfiiXIAB9Ep
         h6QalfbgiFdxT1gwzIyDJP5nWISKWpTHIpT1fN2L7ULPQG419Bbi7XY3FDT2eqv7Pdio
         H1K5BfueRIQBGq3EqACgol7GvzJZ1eAgnKKZmazjR0LQiP65cCb17u0sJuotvVHS33a6
         qj4J0lq3fFjn9VBtqa6a2jkRAsYTa2rETqDhPFBFFdRonhlNDlwxzNcmQUhBH77kLi7U
         AS1qIGirCQTlRgJu1+io8rSZUnDci9vM9xSPVt3khu+byAO8nhRLsYoEOS2YUMuEme9n
         8jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E2f3KSrZxRio8/FeHv28ONTThNhL2TjtH0LaTd/eJz4=;
        b=XVR9SGDZty3Zirakdwm/dSzQjxSYhaL18dSVX+zwwcYWN2pIW75HCa69X4XPG9gWGH
         Ve2A1QdYcx7+RC5lDlQ1l2WCjBzZuZ/kviQexx5jhFdw0hXIdMjq5AGXPW60eSw+5Jgc
         iI6V4YiDqP5Q5qupm33gc4PI6qLyPWsubX44U5+fkvgM1CppJXh1Ftwm7YeJPibh8fPW
         ShVyVyZuI6l3AfsID8x6XpfA+rPt4jRNMiyzEPOnnAWKB9rUjI3CDnxhS6nGjGk12IOv
         93l43OGeAaKB53ybquAWoNqd93cnWGoUzHCKog/eM7l9esG4EH7mB7+F5egZW1+k98NJ
         +6HA==
X-Gm-Message-State: APjAAAX7UDwx97MUvCHAioa8vLZ4HI1eae7OslecZq5rQ83Ngb3NvYMd
        IJQdyOjZcv+GQkmK/7OARyWdeQ==
X-Google-Smtp-Source: APXvYqycW5UHspFXzTlIh/iOGVx+SWpR9vq4XdyDpuh90LK48tRDCdIIhjamCNmUiV+Y56F7gJ75Lw==
X-Received: by 2002:a63:7d05:: with SMTP id y5mr17861065pgc.425.1567961816386;
        Sun, 08 Sep 2019 09:56:56 -0700 (PDT)
Received: from localhost.localdomain ([24.244.23.109])
        by smtp.googlemail.com with ESMTPSA id f188sm13834631pfa.170.2019.09.08.09.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 09:56:55 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 0/5] iommu/amd: Convert the AMD iommu driver to the dma-iommu api
Date:   Sun,  8 Sep 2019 09:56:36 -0700
Message-Id: <20190908165642.22253-1-murphyt7@tcd.ie>
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
V6:
-add more details to the description of patch 001-iommu-amd-Remove-unnecessary-locking-from-AMD-iommu-.patch
-rename handle_deferred_device to iommu_dma_deferred_attach
-fix double tabs in 0003-iommu-dma-iommu-Handle-deferred-devices.patch
V5:
-Rebase on top of linux-next
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
 drivers/iommu/dma-iommu.c       |  43 +-
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
 21 files changed, 178 insertions(+), 651 deletions(-)

-- 
2.20.1

