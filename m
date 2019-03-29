Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E97C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C9120651
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfC2OAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:00:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59874 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfC2OAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:00:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A4112001E2;
        Fri, 29 Mar 2019 15:00:17 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DDB8200034;
        Fri, 29 Mar 2019 15:00:17 +0100 (CET)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.74.120])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A101320606;
        Fri, 29 Mar 2019 15:00:16 +0100 (CET)
From:   laurentiu.tudor@nxp.com
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
        camelia.groza@nxp.com, leoyang.li@nxp.com
Cc:     davem@davemloft.net, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 00/13] Prerequisites for NXP LS104xA SMMU enablement
Date:   Fri, 29 Mar 2019 16:00:01 +0200
Message-Id: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
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

There are a couple of changes/fixes since then:
 - for consistency, renamed mmu node to smmu
 - new patch page aligning the sizes of the qbman reserved memory
 - rebased on 5.1.0-rc2

Laurentiu Tudor (13):
  soc/fsl/qman: fixup liodns only on ppc targets
  soc/fsl/bman: map FBPR area in the iommu
  soc/fsl/qman: map FQD and PFDR areas in the iommu
  soc/fsl/qman-portal: map CENA area in the iommu
  soc/fsl/bqman: page align iommu mapping sizes
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
 drivers/soc/fsl/qbman/bman_ccsr.c             |  11 ++
 drivers/soc/fsl/qbman/bman_portal.c           |  22 ++-
 drivers/soc/fsl/qbman/qman_ccsr.c             |  17 +++
 drivers/soc/fsl/qbman/qman_portal.c           |  40 +++++-
 include/soc/fsl/bman.h                        |   8 ++
 include/soc/fsl/qman.h                        |   9 ++
 11 files changed, 242 insertions(+), 56 deletions(-)

-- 
2.17.1

