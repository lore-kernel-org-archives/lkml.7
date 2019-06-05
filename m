Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6D1C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984AC2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFETpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 15:45:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40390 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfFETpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 15:45:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D7FEC200860;
        Wed,  5 Jun 2019 21:45:12 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80DDD20085A;
        Wed,  5 Jun 2019 21:45:12 +0200 (CEST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.32.81])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id CC2CD40A55;
        Wed,  5 Jun 2019 12:45:11 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL v2] updates to soc/fsl drivers for next(v5.3)
Date:   Wed,  5 Jun 2019 14:45:11 -0500
Message-Id: <20190605194511.12127-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

This is a rebase of patches that missed 5.2 merge window together with
some new patches for QE.  Please help to review and merge it.  We would
like this to be merged earlier because there are other patches depending
on patches in this pull request.  After this is merged in arm-soc, we can
ask other sub-system maintainers to pull from this tag and apply additional
patches.  Thanks.

Regards,
Leo

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.3-2

for you to fetch changes up to 21560067fb1f5e87abedc3ecec5d46f67ac0c019:

  soc: fsl: qe: fold qe_get_num_of_snums into qe_snums_init (2019-06-05 14:26:52 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.3 (take 2)

DPAA2 Console driver
- Add driver to export two char devices to dump logs for MC and
  AIOP

DPAA2 DPIO driver
- Add support for memory backed QBMan portals
- Increase the timeout period to prevent false error
- Add APIs to retrieve QBMan portal probing status

DPAA Qman driver
- Only make liodn fixup on powerpc SoCs with PAMU iommu

QUICC Engine
- Add support for importing qe-snums through device tree
- Some cleanups and foot print optimzation

----------------------------------------------------------------
Colin Ian King (1):
      soc: fsl: fix spelling mistake "Firmaware" -> "Firmware"

Ioana Ciornei (2):
      Documentation: DT: Add entry for DPAA2 console
      soc: fsl: add DPAA2 console support

Laurentiu Tudor (2):
      soc: fsl: qman: fixup liodns only on ppc targets
      soc: fsl: qbman_portals: add APIs to retrieve the probing status

Rasmus Villemoes (6):
      soc: fsl: qe: drop useless static qualifier
      soc: fsl: qe: reduce static memory footprint by 1.7K
      soc: fsl: qe: introduce qe_get_device_node helper
      dt-bindings: soc: fsl: qe: document new fsl,qe-snums binding
      soc: fsl: qe: support fsl,qe-snums property
      soc: fsl: qe: fold qe_get_num_of_snums into qe_snums_init

Roy Pledge (2):
      bus: mc-bus: Add support for mapping shareable portals
      soc: fsl: dpio: Add support for memory backed QBMan portals

Vabhav Sharma (1):
      soc: fsl: guts: Add definition for LX2160A

Youri Querry (1):
      soc: fsl: dpio: Increase timeout for QBMan Management Commands

 .../devicetree/bindings/misc/fsl,dpaa2-console.txt |  11 +
 .../devicetree/bindings/soc/fsl/cpm_qe/qe.txt      |  13 +-
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
 drivers/soc/fsl/qe/qe.c                            | 163 ++++------
 include/soc/fsl/bman.h                             |   8 +
 include/soc/fsl/qman.h                             |   9 +
 20 files changed, 695 insertions(+), 150 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
 create mode 100644 drivers/soc/fsl/dpaa2-console.c
