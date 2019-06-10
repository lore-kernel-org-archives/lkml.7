Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A05C468BD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 03:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C952085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 03:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbfFJDTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 23:19:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57102 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbfFJDTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 23:19:33 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 952AC2006C2;
        Mon, 10 Jun 2019 05:19:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 731C32006C8;
        Mon, 10 Jun 2019 05:19:26 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 15731402D2;
        Mon, 10 Jun 2019 11:19:21 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 0/6] Reuse ptp_qoriq driver for dpaa2-ptp
Date:   Mon, 10 Jun 2019 11:21:02 +0800
Message-Id: <20190610032108.5791-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although dpaa2-ptp.c driver is a fsl_mc_driver which
is using MC APIs for register accessing, it's same IP
block with eTSEC/DPAA/ENETC 1588 timer.
This patch-set is to convert to reuse ptp_qoriq driver by
using register ioremap and dropping related MC APIs.
However the interrupts could only be handled by MC which
fires MSIs to ARM cores. So the interrupt enabling and
handling still rely on MC APIs. MC APIs for interrupt
and PPS event support are also added by this patch-set.

Yangbo Lu (6):
  ptp: add QorIQ PTP support for DPAA2
  dpaa2-ptp: reuse ptp_qoriq driver
  dt-binding: ptp_qoriq: support DPAA2 PTP compatible
  arm64: dts: fsl: add ptp timer node for dpaa2 platforms
  dpaa2-ptp: add interrupt support
  MAINTAINERS: maintain DPAA2 PTP driver in QorIQ PTP entry

 .../devicetree/bindings/ptp/ptp-qoriq.txt          |   3 +-
 MAINTAINERS                                        |   9 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |   8 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   8 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   8 +
 drivers/net/ethernet/freescale/dpaa2/Kconfig       |   3 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c   | 242 +++++++++++----------
 drivers/net/ethernet/freescale/dpaa2/dprtc-cmd.h   |  48 +++-
 drivers/net/ethernet/freescale/dpaa2/dprtc.c       | 191 ++++++++++++----
 drivers/net/ethernet/freescale/dpaa2/dprtc.h       |  62 ++++--
 drivers/ptp/Kconfig                                |   2 +-
 11 files changed, 386 insertions(+), 198 deletions(-)

-- 
2.7.4

