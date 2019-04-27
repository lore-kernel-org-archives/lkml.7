Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0261C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789012067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfD0HKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:10:38 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35458 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfD0HKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 03:10:37 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4FBB8200081;
        Sat, 27 Apr 2019 09:10:35 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 41E36200055;
        Sat, 27 Apr 2019 09:10:35 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B5345205ED;
        Sat, 27 Apr 2019 09:10:34 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
        camelia.groza@nxp.com, leoyang.li@nxp.com
Cc:     davem@davemloft.net, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 0/9] Prerequisites for NXP LS104xA SMMU enablement
Date:   Sat, 27 Apr 2019 10:10:22 +0300
Message-Id: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This patch series contains several fixes in preparation for SMMU
support on NXP LS1043A and LS1046A chips. Once these get picked up,
I'll submit the actual SMMU enablement patches consisting in the
required device tree changes.

This patch series contains only part of the previously submitted one,
(including also the device tree changes) available here:

    https://patchwork.kernel.org/cover/10634443/

Changes in v2:
 - dropped patches dealing with mapping reserved memory in iommu
 - changed logic for qman portal probe status (Leo)
 - moved "#ifdef CONFIG_PAMU" in header file (Leo)
 - rebased on v5.1.0-rc5

Laurentiu Tudor (9):
  soc/fsl/qman: fixup liodns only on ppc targets
  soc/fsl/qbman_portals: add APIs to retrieve the probing status
  fsl/fman: backup and restore ICID registers
  fsl/fman: add API to get the device behind a fman port
  dpaa_eth: defer probing after qbman
  dpaa_eth: base dma mappings on the fman rx port
  dpaa_eth: fix iova handling for contiguous frames
  dpaa_eth: fix iova handling for sg frames
  dpaa_eth: fix SG frame cleanup

 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 136 ++++++++++++------
 drivers/net/ethernet/freescale/fman/fman.c    |  35 ++++-
 drivers/net/ethernet/freescale/fman/fman.h    |   4 +
 .../net/ethernet/freescale/fman/fman_port.c   |  14 ++
 .../net/ethernet/freescale/fman/fman_port.h   |   2 +
 drivers/soc/fsl/qbman/bman_portal.c           |  20 ++-
 drivers/soc/fsl/qbman/qman_ccsr.c             |   2 +-
 drivers/soc/fsl/qbman/qman_portal.c           |  21 ++-
 drivers/soc/fsl/qbman/qman_priv.h             |   9 +-
 include/soc/fsl/bman.h                        |   8 ++
 include/soc/fsl/qman.h                        |   9 ++
 11 files changed, 202 insertions(+), 58 deletions(-)

-- 
2.17.1

