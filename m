Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95CC22D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kwrJNN0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfICDaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 23:30:39 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6080 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfICDaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:30:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6dde5c0000>; Mon, 02 Sep 2019 20:30:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Sep 2019 20:30:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Sep 2019 20:30:33 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Sep
 2019 03:30:33 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Sep
 2019 03:30:33 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Sep 2019 03:30:33 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6dde590000>; Mon, 02 Sep 2019 20:30:33 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>, <thomasz@nvidia.com>,
        <olof@lixom.net>, <jtukkinen@nvidia.com>, <mperttunen@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v2 0/7] Nvidia Arm SMMUv2 Implementation
Date:   Mon, 2 Sep 2019 20:32:01 -0700
Message-ID: <1567481528-31163-1-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567481436; bh=T9BbTYlYBfuyCj1sNd2063D0NTKNlCCYjU+ccrUrfNA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=kwrJNN0Z9MVA02HH4Wy53rTiwgJNHARlt4xypssjUsxFSJGrizKy75cuamg/sjrg/
         E9Pt+9meLVYnXR+dl1zRa3/lARZKXWQPX8inmBCdazmVCjUQ2G7Z0tVlpNHzHSxIF1
         sZ3oxbnNo77T4+yOPP8NVlvsHwfpUiUeLS0C5nddFZRZShOhuRw4Xv9nktMOChFLo5
         df5dH2Pn6HUbQ1ZnxM1VpoUcfFVGIg7+50ecCIQ3HenSasr61ED+8pVkITeCqA+Tpm
         ChB56uDR2DUhGWujtOHo3TuJRUi9W6KPYzUA+gL5KZglno04DaFZD6McHvjhSW+3ff
         enfvdybAwqu4Q==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- Prepare arm_smu_flush_ops for override.
- Remove NVIDIA_SMMUv2 and use ARM_SMMUv2 model as T194 SMMU hasn't modified ARM MMU-500.
- Add T194 specific compatible string - "nvidia,tegra194-smmu"
- Remove tlb_sync hook added in v1 and Override arm_smmu_flush_ops->tlb_sync() from implementation.
- Register implementation specific context/global fault hooks directly for irq handling.
- Update global/context interrupt list in DT and releant fault handling code in arm-smmu-nvidia.c.
- Implement reset hook in arm-smmu-nvidia.c to clear irq status and sync tlb.

v1 - https://lkml.org/lkml/2019/8/29/1588

Krishna Reddy (7):
  iommu/arm-smmu: prepare arm_smmu_flush_ops for override
  iommu/arm-smmu: add NVIDIA implementation for dual ARM MMU-500 usage
  dt-bindings: arm-smmu: Add binding for Tegra194 SMMU
  iommu/arm-smmu: Add global/context fault implementation hooks
  arm64: tegra: Add Memory controller DT node on T194
  arm64: tegra: Add DT node for T194 SMMU
  arm64: tegra: enable SMMU for SDHCI and EQOS on T194

 .../devicetree/bindings/iommu/arm,smmu.txt         |   4 +
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  88 +++++++
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/arm-smmu-impl.c                      |   3 +
 drivers/iommu/arm-smmu-nvidia.c                    | 287 +++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           |  27 +-
 drivers/iommu/arm-smmu.h                           |   8 +-
 9 files changed, 413 insertions(+), 12 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c

-- 
2.1.4

