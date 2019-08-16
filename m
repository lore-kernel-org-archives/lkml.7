Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DBC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23632077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfHPTxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:53:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33206 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfHPTxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:53:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C1EB20055D;
        Fri, 16 Aug 2019 21:53:02 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 322202004E3;
        Fri, 16 Aug 2019 21:53:02 +0200 (CEST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.32.174])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id B435D40CB6;
        Fri, 16 Aug 2019 12:53:01 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] updates to soc/fsl drivers for v5.4
Date:   Fri, 16 Aug 2019 14:53:01 -0500
Message-Id: <20190816195301.26660-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please look into the following changes and merge them if they
look good.

Regards,
Leo

The following changes since commit 157eed91b374c42eb264157366daf3dabc8bc816:

  Merge tag 'tee-optee-for-5.4' of git://git.linaro.org/people/jens.wiklander/linux-tee into arm/drivers (2019-08-15 14:29:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.4

for you to fetch changes up to eadf0b17b43db4e73a6bdde1ad745d3b582a71c5:

  bus: fsl-mc: remove explicit device_link_del (2019-08-16 14:17:35 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.4

DPAA2 DPIO/MC driver
- Remove explicit device_link_remove() and device_link_del() calls due to
framework change

DPAA QBman driver
- Various changes to make it working with kexec
- Remove dev_err() usage after platform_get_irq()

GUTS driver
- Add LS1028 SoC support

----------------------------------------------------------------
Ioana Ciornei (2):
      soc: fsl: dpio: remove explicit device_link_remove
      bus: fsl-mc: remove explicit device_link_del

Roy Pledge (7):
      soc/fsl/qbman: Rework QBMan private memory setup
      soc/fsl/qbman: Cleanup buffer pools if BMan was initialized prior to bootup
      soc/fsl/qbman: Cleanup QMan queues if device was already initialized
      soc/fsl/qbman: Fix drain_mr_fqni()
      soc/fsl/qbman: Disable interrupts during portal recovery
      soc/fsl/qbman: Fixup qman_shutdown_fq()
      soc/fsl/qbman: Update device tree with reserved memory

Stephen Boyd (1):
      soc: fsl: qbman: Remove dev_err() usage after platform_get_irq()

Yinbo Zhu (1):
      soc: fsl: guts: Add definition for LS1028A

 drivers/bus/fsl-mc/fsl-mc-allocator.c |  1 -
 drivers/bus/fsl-mc/mc-io.c            |  1 -
 drivers/soc/fsl/dpio/dpio-service.c   |  2 -
 drivers/soc/fsl/guts.c                |  6 +++
 drivers/soc/fsl/qbman/bman.c          | 17 +++----
 drivers/soc/fsl/qbman/bman_ccsr.c     | 36 ++++++++++++++-
 drivers/soc/fsl/qbman/bman_portal.c   | 22 ++++++++--
 drivers/soc/fsl/qbman/bman_priv.h     |  5 +++
 drivers/soc/fsl/qbman/dpaa_sys.c      | 63 +++++++++++++++-----------
 drivers/soc/fsl/qbman/qman.c          | 83 ++++++++++++++++++++++++++++-------
 drivers/soc/fsl/qbman/qman_ccsr.c     | 68 +++++++++++++++++++++++++---
 drivers/soc/fsl/qbman/qman_portal.c   | 22 ++++++++--
 drivers/soc/fsl/qbman/qman_priv.h     |  8 ++++
 13 files changed, 263 insertions(+), 71 deletions(-)
