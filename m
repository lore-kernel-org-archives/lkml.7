Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B123EC32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4302171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfHALxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:53:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53382 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbfHALw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:52:57 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E3FD1A02A9;
        Thu,  1 Aug 2019 13:52:55 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 715C61A01FC;
        Thu,  1 Aug 2019 13:52:55 +0200 (CEST)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C39C205E3;
        Thu,  1 Aug 2019 13:52:55 +0200 (CEST)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     andrew@lunn.ch, Rob Herring <robh+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, alexandru.marginean@nxp.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/5] enetc: Clean up makefile
Date:   Thu,  1 Aug 2019 14:52:50 +0300
Message-Id: <1564660373-4607-3-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564660373-4607-1-git-send-email-claudiu.manoil@nxp.com>
References: <1564660373-4607-1-git-send-email-claudiu.manoil@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up overcomplicated makefile to make it more maintainable.
Basically, there's a set of common objects shared between
the PF and VF driver modules.  This can be implemented in a
simpler way, without conditionals, less repetition, allowing
also for easier updates in the future.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v5 - added this patch

 drivers/net/ethernet/freescale/enetc/Makefile | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 7139e414dccf..164453a5dc1d 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -1,19 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
+
+common-objs := enetc.o enetc_cbdr.o enetc_ethtool.o
+
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
-fsl-enetc-$(CONFIG_FSL_ENETC) += enetc.o enetc_cbdr.o enetc_ethtool.o \
-				 enetc_mdio.o
+fsl-enetc-y := enetc_pf.o enetc_mdio.o $(common-objs)
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
-fsl-enetc-objs := enetc_pf.o $(fsl-enetc-y)
 
 obj-$(CONFIG_FSL_ENETC_VF) += fsl-enetc-vf.o
-
-ifeq ($(CONFIG_FSL_ENETC)$(CONFIG_FSL_ENETC_VF), yy)
-fsl-enetc-vf-objs := enetc_vf.o
-else
-fsl-enetc-vf-$(CONFIG_FSL_ENETC_VF) += enetc.o enetc_cbdr.o \
-				       enetc_ethtool.o
-fsl-enetc-vf-objs := enetc_vf.o $(fsl-enetc-vf-y)
-endif
+fsl-enetc-vf-y := enetc_vf.o $(common-objs)
 
 obj-$(CONFIG_FSL_ENETC_PTP_CLOCK) += fsl-enetc-ptp.o
-fsl-enetc-ptp-$(CONFIG_FSL_ENETC_PTP_CLOCK) += enetc_ptp.o
+fsl-enetc-ptp-y := enetc_ptp.o
-- 
2.17.1

