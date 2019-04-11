Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ED2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BF52083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LZd9Rpxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDKSsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:48:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33782 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfDKSsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:48:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id d55so5346325ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBtAcqUe2/+GOz+Tww7cmmfM8WqU2iJOHg5iA/UrduI=;
        b=LZd9RpxbPNh8wdp84QXHEpMLI91fVRjDJTUTlZe8ZP5xqaukHdb/Vc768qVV8Y1yks
         vaaroQZV7xe6vXloA3mk+xG5x0zvGBDbYWF0BWJnuN82P1QIchiw4tQG0Wk4Vpon1fJN
         tqXk3aD4JBb35Iq1jcAm8IUuDWT9iIgJM4BBW32gAQXBl8Pncg2hAciW3TLwvIECtZPq
         55gnsjYhasEqTvNh41oAZ5XJyUupyw0BXjZnj+UO7saF2fDZYeCahLz9NJWZ1teMcjtw
         niwLWLoJMYfrFf2z8XjdSsm7iBNOX5yVfCatMP0xD46vR1r6IZTOue7XAnuvVOnOeANT
         hHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBtAcqUe2/+GOz+Tww7cmmfM8WqU2iJOHg5iA/UrduI=;
        b=hN2l1AwIDb7YtgDRyVh5N5cVtfjbDPkUgjxwvT2bSWhGmQAqcStGZXVgTjdS5nEQan
         peVvWWZfw6XlRWlPxzWFlqqa8f15rTfBQRMN9I9XVT3HCvhIvxmdRDuvxASFliEyAmBe
         JyceAtpWoFCO4uQSoZ8FSEGkOLmaNoUgmGGahauKqAzn5CXTnjUh74xy58W84M3gXu3H
         KZqhNlehEnv/brdxnfjsz9OUkv2zcZVPDmaZYjRyoew3bH1Y41PKfGZJo81NQqUO05h+
         COcpf29aWbaI4FkPTFeSMz9oxMrc8GF3k+lkWTUTumSVNN2PPRs/ZB4RODDvnYXrDqwo
         6pUA==
X-Gm-Message-State: APjAAAWTAS1LEZqvImpjCRVXS6rDadZiOji2rctfUN14P5UYYT7yTbUJ
        LbUolBNecMKal+bThxWZ4MqsBQ==
X-Google-Smtp-Source: APXvYqwQliYaTEetalcCwzYv+n0HpwRJdoNN5cySsZXKL/GejBbg1SKdoEvi00jzkezuKeMc/dmhIA==
X-Received: by 2002:a50:e844:: with SMTP id k4mr32014345edn.249.1555008510116;
        Thu, 11 Apr 2019 11:48:30 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
        by smtp.gmail.com with ESMTPSA id b10sm1285130edi.28.2019.04.11.11.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:48:29 -0700 (PDT)
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
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 0/9] iommu/amd: Convert the AMD iommu driver to the dma-iommu api
Date:   Thu, 11 Apr 2019 19:47:29 +0100
Message-Id: <20190411184741.27540-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the AMD iommu driver to the dma-iommu api and remove the iova
handling code from the AMD iommu driver.

Tom Murphy (9):
  iommu/dma-iommu: Add iommu_map_atomic
  iommu/dma-iommu: Add function to flush any cached not present IOTLB
    entries
  iommu/dma-iommu: Add iommu_dma_copy_reserved_iova,
    iommu_dma_apply_resv_region to the dma-iommu api
  iommu/dma-iommu: Add iommu_dma_map_page_coherent
  iommu/amd: Implement .flush_np_cache
  iommu/amd: Implement map_atomic
  iommu/amd: Use the dma-iommu api
  iommu/amd: Clean up unused functions
  iommu/amd: Add allocated domain to global list earlier

 drivers/iommu/Kconfig          |   1 +
 drivers/iommu/amd_iommu.c      | 468 ++++++++-------------------------
 drivers/iommu/arm-smmu-v3.c    |   1 +
 drivers/iommu/arm-smmu.c       |   1 +
 drivers/iommu/dma-iommu.c      |  68 ++++-
 drivers/iommu/exynos-iommu.c   |   1 +
 drivers/iommu/iommu.c          |  46 +++-
 drivers/iommu/ipmmu-vmsa.c     |   1 +
 drivers/iommu/mtk_iommu.c      |   1 +
 drivers/iommu/qcom_iommu.c     |   1 +
 drivers/iommu/rockchip-iommu.c |   1 +
 include/linux/dma-iommu.h      |  10 +
 include/linux/iommu.h          |  25 ++
 13 files changed, 253 insertions(+), 372 deletions(-)

-- 
2.17.1

