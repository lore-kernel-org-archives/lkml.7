Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC13C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19A620674
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8Ri4oDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfH2LR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:17:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35191 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2LRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:17:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id t50so3670015edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qw9TI/oO75bsTCfpr+cHjs+CGmEWrEJqDhW1Nr5mPhI=;
        b=S8Ri4oDngL/CuKTznOuFJut4kaqtLc9m6OEPBmcrmC9PTg98R4l6Ntojeqare4DfFw
         Ue+QAiofTOSeEn3E0/BxjOQLgEcmVTFzWxXf/RbFaYze8UQYLYXsmo8idr+2My4VQVHO
         xiQyF7kbM5iv+RsDvCU/qFLiwosQ4qE2PgBErmbwLqhtHhVnhy9ZxvLpK5PvWZK8+ra5
         TqQdfoKN+BbrZfXu4iysVRj4aZPP5GWU7rDJ2seuoGic6i98kGKTZABTaRT9p4b2Clsk
         wvL2evwLuZbxEu0B6knoORNMtSB0oGq3Ul3kTNAEVFmJUdo/iu0piqtwO8RTCzpdtAta
         +sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qw9TI/oO75bsTCfpr+cHjs+CGmEWrEJqDhW1Nr5mPhI=;
        b=l7s5YAZ5QYznTH2EG/H4HqSLIt91YqptPUy8a6GbjWD4kg297Ezm01w6UB9NPtfAZ2
         tj7Tw21BIwtLUh9gUY/Lp5/XkbXKiP85avchyQn8UZp+d3WHa/b1u7iIJrokpZO/tlPM
         yGDpZIW/T52fwlzU4Ewf4qzlZYl1KF07NKOjowHF8P4QYZNfQ5SDQGkFZFmxxl5L480Y
         onC1zreGP3EF7/YYbN//WKXAG/S4OpvdAf+lTStWo1fhNqub8zU2nLTZWAPhxkCdZc5t
         Q45Qt6P7JhaqWbqQUEvbuZIa0a6RVacSzcSKQlUIQ0m9Ey0uk9zh9InvSr71t0ZY6Orj
         sk+w==
X-Gm-Message-State: APjAAAVPNfaXaf48dpTC1m+j4s8Atx9CIM4HTMXzK3S094pvSG3x7AtA
        KII6hFIrPjtTHfZsdaxNu5oSZPOd
X-Google-Smtp-Source: APXvYqzf3VpKDNdxCgnDwyw+83rYA047IH5YU4ry9v57vAHMKEZsuLCcwInPPOQgF729h0A10YkaTw==
X-Received: by 2002:aa7:c81a:: with SMTP id a26mr9175586edt.26.1567077473918;
        Thu, 29 Aug 2019 04:17:53 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id y19sm385592edu.90.2019.08.29.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:17:53 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] iommu: Implement iommu_put_resv_regions_simple()
Date:   Thu, 29 Aug 2019 13:17:47 +0200
Message-Id: <20190829111752.17513-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
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

Thierry

Thierry Reding (5):
  iommu: Implement iommu_put_resv_regions_simple()
  iommu: arm: Use iommu_put_resv_regions_simple()
  iommu: amd: Use iommu_put_resv_regions_simple()
  iommu: intel: Use iommu_put_resv_regions_simple()
  iommu: virt: Use iommu_put_resv_regions_simple()

 drivers/iommu/amd_iommu.c    | 11 +----------
 drivers/iommu/arm-smmu-v3.c  | 11 +----------
 drivers/iommu/arm-smmu.c     | 11 +----------
 drivers/iommu/intel-iommu.c  | 11 +----------
 drivers/iommu/iommu.c        | 19 +++++++++++++++++++
 drivers/iommu/virtio-iommu.c | 14 +++-----------
 include/linux/iommu.h        |  2 ++
 7 files changed, 28 insertions(+), 51 deletions(-)

-- 
2.22.0

