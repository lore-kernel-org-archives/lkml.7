Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE46C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA87221874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QpALE+ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfH2Wpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:45:44 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9632 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfH2Wpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:45:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6855980000>; Thu, 29 Aug 2019 15:45:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 29 Aug 2019 15:45:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 29 Aug 2019 15:45:42 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Aug
 2019 22:45:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 29 Aug 2019 22:45:42 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6855960001>; Thu, 29 Aug 2019 15:45:42 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>, <thomasz@nvidia.com>,
        <olof@lixom.net>, <jtukkinen@nvidia.com>, <mperttunen@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH 0/7] Nvidia Arm SMMUv2 Implementation
Date:   Thu, 29 Aug 2019 15:47:00 -0700
Message-ID: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567118744; bh=XViQuyFPXRUGjvQSy38KjNjazgSU9GgkmEMvuiC4IJI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=QpALE+evxkvz2t8B5iHVtf2dNEUPUWPvjULE+doad73wTU+7rj0j6O1bdNpVgq578
         1OBqgXS7PT0sQOHrrgIRx91SwEbqWNhDLPXLNxmmsZkZlTew9lHA6PnPoFunH0IP6i
         WzyjNcXU1WX7j0FiYtib2AjWSLhiWktGBh+jaIWE9bdZfsfnOSumlSntbGOE3QZbQu
         eJDuY3xzzQ7aj3Nb95YTQVgC8wLfW5X5ahSocRZGg+24yAVWrAhqnB1t4N7S50yTmG
         ywFwt6FKf7J4VgLBLFSQsq0n60zLBCYYwgYfgA4cHnqWmMpvguvVFuZGojRkOYs2qC
         gXhdlXukqQbCQ==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
Nvidia Arm SMMUv2 implementation has two ARM SMMU(MMU-500) instances
that are used together for SMMU translations. The IOVA accesses from
HW devices are interleaved across these two SMMU instances and need
to be programmed identical except during tlb sync and fault handling.

This patch set adds Nvidia Arm SMMUv2 Implementation on top of ARM SMMU
driver to handle Nvidia specific implementation. It is also adding
hooks for tlb sync and fault handling to allow vendor specific
implementation for the same.

Please review the patch set and provide the feedback.

This patch set is based on the following branch as it is dependent on the
Arm SMMU Refactor changes from Robin Murphy that are present in this branch.

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates


Krishna Reddy (7):
  iommu/arm-smmu: add Nvidia SMMUv2 implementation
  dt-bindings: arm-smmu: Add binding for nvidia,smmu-v2
  iommu/arm-smmu: Add tlb_sync implementation hook
  iommu/arm-smmu: Add global/context fault implementation hooks
  arm64: tegra: Add Memory controller DT node on T194
  arm64: tegra: Add DT node for T194 SMMU
  arm64: tegra: enable SMMU for SDHCI and EQOS

 .../devicetree/bindings/iommu/arm,smmu.txt         |   1 +
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  86 +++++++
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/arm-smmu-impl.c                      |   2 +
 drivers/iommu/arm-smmu-nvidia.c                    | 256 +++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           |  16 +-
 drivers/iommu/arm-smmu.h                           |  10 +
 9 files changed, 375 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c

-- 
2.1.4

