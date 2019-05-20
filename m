Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29628C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08343206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfETTwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:52:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47270 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETTwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:52:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CFFE4200281;
        Mon, 20 May 2019 21:52:16 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 961EA20027D;
        Mon, 20 May 2019 21:52:16 +0200 (CEST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.32.93])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id D956040CF2;
        Mon, 20 May 2019 12:52:15 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] updates to soc/fsl drivers for v5.3
Date:   Mon, 20 May 2019 14:52:15 -0500
Message-Id: <20190520195215.26515-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

This is a rebase of patches that missed 5.2 merge window.  Please
help to review and merge it.  Thanks.


Regards,
Leo

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.3

for you to fetch changes up to 5d1d046e2868fc876a69231eb2f24f000b521f1c:

  soc: fsl: qbman_portals: add APIs to retrieve the probing status (2019-05-20 14:28:16 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.3

DPAA2 Console driver
- Add driver to export two char devices to dump logs for MC and
  AIOP

DPAA2 DPIO driver
- Add support for memory backed QBMan portals
- Increase the timeout period to prevent false error
- Add APIs to retrieve QBMan portal probing status

DPAA Qman driver
- Only make liodn fixup on powerpc SoCs with PAMU iommu

----------------------------------------------------------------
Ioana Ciornei (2):
      Documentation: DT: Add entry for DPAA2 console
      soc: fsl: add DPAA2 console support

Laurentiu Tudor (2):
      soc: fsl: qman: fixup liodns only on ppc targets
      soc: fsl: qbman_portals: add APIs to retrieve the probing status

Roy Pledge (2):
      bus: mc-bus: Add support for mapping shareable portals
      soc: fsl: dpio: Add support for memory backed QBMan portals

Vabhav Sharma (1):
      soc: fsl: guts: Add definition for LX2160A

Youri Querry (1):
      soc: fsl: dpio: Increase timeout for QBMan Management Commands

 .../devicetree/bindings/misc/fsl,dpaa2-console.txt |  11 +
 MAINTAINERS                                        |   1 +
 drivers/bus/fsl-mc/dprc.c                          |  30 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  15 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                |  17 +-
 drivers/soc/fsl/Kconfig                            |  10 +
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/dpaa2-console.c                    | 329 +++++++++++++++++++++
 drivers/soc/fsl/dpio/dpio-driver.c                 |  23 +-
 drivers/soc/fsl/dpio/qbman-portal.c                | 148 +++++++--
 drivers/soc/fsl/dpio/qbman-portal.h                |   9 +-
 drivers/soc/fsl/guts.c                             |   6 +
 drivers/soc/fsl/qbman/bman_portal.c                |  20 +-
 drivers/soc/fsl/qbman/qman_ccsr.c                  |   2 +-
 drivers/soc/fsl/qbman/qman_portal.c                |  21 +-
 drivers/soc/fsl/qbman/qman_priv.h                  |   9 +-
 include/soc/fsl/bman.h                             |   8 +
 include/soc/fsl/qman.h                             |   9 +
 18 files changed, 618 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
 create mode 100644 drivers/soc/fsl/dpaa2-console.c
