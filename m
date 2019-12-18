Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18BCC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9878A218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSSU4VP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfLRNmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:42:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52510 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfLRNmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:42:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so1890464wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4mZXGCvD+6EnbswTu7ksRYdm4UYDrB4ruC6F1AgNC8=;
        b=vSSU4VP4UooPjqt2LRy/or7Vt22ojWOll9hfB0oO9Yqo5lrx5x4OyxENz29e4lG5xP
         UjrKNruwA59k3B7ckYCAd4uCMOmSz4WX75DkvPcftr40JhiLaR72BkNZ3v1bOzCnYjfH
         YE6JWzHOrYZ3iMIj6Fo0O2HDBRix8VbFfgr9kAxNLeZgpI3rZ1AFgsFYvb6ldyV5Y6XA
         cnHmc8LMP47OlrgjHj8AZsBI3t8mi2eOVAbNuDXTn//RisePxjzez7wLCXn7svuQO5rV
         0Q6cKXOJ6OfuaUGsztmLfdEGIwaLIF8q12EOZbswX3wqzqA4Z6YzcYHKI40vvr4Ocuiy
         HQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4mZXGCvD+6EnbswTu7ksRYdm4UYDrB4ruC6F1AgNC8=;
        b=d9GTYHcirJaEJjCYSD6V2hwafLKgLyXU4kpB1hyT5UtG3ffzuZl7xNtaW9z09xJYwr
         kCL8OG8V2Ybha14Ns/uIYdL1+zBeGs6knP7VXCX4+ct2klMPjdBkMo2pNuKnqLZUxQhW
         tu77LV8TBPvAXKCi4t/IO/B/1/y/MMQOTS9rjEf9ryWxuCNXhWAsGSa4rPdwgHMkJgFJ
         nMwvIr+cmUPwraDTxzeucu2LMAQZbj1UeDvbB37sK0CWnmCziRE3ZmYCaaLa3oLaxyFn
         QYKn6T7XXgru9pzELD7cvtz3T/XJvXUKs15CDbZGapHL32yiedcvE3yGx+T0kLjfJAQ1
         V13w==
X-Gm-Message-State: APjAAAVZAQySuSi4BseoYNAvOxx6TwlVCIxGkLw6WD1QmAzRykGMjXWO
        g4Y7yPcfVdEqrx0dhfx5JSs=
X-Google-Smtp-Source: APXvYqx00MAdrTJa0b/IcwkLqVUMHW/YwCHT1c0x+FeTNgKpQh9jqa/Uvj/6SYnkwv03WobwQ56A3g==
X-Received: by 2002:a05:600c:22c8:: with SMTP id 8mr3210705wmg.178.1576676531417;
        Wed, 18 Dec 2019 05:42:11 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id t5sm2577688wrr.35.2019.12.18.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:42:10 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] iommu: Implement generic_iommu_put_resv_regions()
Date:   Wed, 18 Dec 2019 14:42:00 +0100
Message-Id: <20191218134205.1271740-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Most IOMMU drivers only need to free the memory allocated for each
reserved region. Instead of open-coding the loop to do this in each
driver, extract the code into a common function that can be used by
all these drivers.

Changes in v3:
- add Reviewed-by from Jean-Philippe Brucker on virtio patch
- add Acked-by from Will Deacon on ARM SMMU patch
- rename to generic_iommu_put_resv_regions()

Changes in v2:
- change subject prefix to "iommu: virtio: " for virtio-iommu.c driver

Thierry

Thierry Reding (5):
  iommu: Implement generic_iommu_put_resv_regions()
  iommu: arm: Use generic_iommu_put_resv_regions()
  iommu: amd: Use generic_iommu_put_resv_regions()
  iommu: intel: Use generic_iommu_put_resv_regions()
  iommu: virtio: Use generic_iommu_put_resv_regions()

 drivers/iommu/amd_iommu.c    | 11 +----------
 drivers/iommu/arm-smmu-v3.c  | 11 +----------
 drivers/iommu/arm-smmu.c     | 11 +----------
 drivers/iommu/intel-iommu.c  | 11 +----------
 drivers/iommu/iommu.c        | 19 +++++++++++++++++++
 drivers/iommu/virtio-iommu.c | 14 +++-----------
 include/linux/iommu.h        |  2 ++
 7 files changed, 28 insertions(+), 51 deletions(-)

-- 
2.24.1

