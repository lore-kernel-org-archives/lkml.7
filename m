Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E6C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CAF208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfFNKjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:39:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36034 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbfFNKjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:39:13 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BCFD12003DA;
        Fri, 14 Jun 2019 12:39:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C9E0200E7C;
        Fri, 14 Jun 2019 12:39:07 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 451ED4029F;
        Fri, 14 Jun 2019 18:39:01 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 1/6] ptp: add QorIQ PTP support for DPAA2
Date:   Fri, 14 Jun 2019 18:40:50 +0800
Message-Id: <20190614104055.43998-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614104055.43998-1-yangbo.lu@nxp.com>
References: <20190614104055.43998-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add QorIQ PTP support for DPAA2.
Although dpaa2-ptp.c driver is a fsl_mc_driver which
is using MC APIs for register accessing, it's same
IP block with eTSEC/DPAA/ENETC 1588 timer. We will
convert to reuse ptp_qoriq driver by using register
ioremap and dropping related MC APIs.
Also allow to compile ptp_qoriq with COMPILE_TEST.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Allowed to compile with COMPILE_TEST.
---
 drivers/ptp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 9b8fee5..960961f 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -44,7 +44,7 @@ config PTP_1588_CLOCK_DTE
 
 config PTP_1588_CLOCK_QORIQ
 	tristate "Freescale QorIQ 1588 timer as PTP clock"
-	depends on GIANFAR || FSL_DPAA_ETH || FSL_ENETC || FSL_ENETC_VF
+	depends on GIANFAR || FSL_DPAA_ETH || FSL_DPAA2_ETH || FSL_ENETC || FSL_ENETC_VF || COMPILE_TEST
 	depends on PTP_1588_CLOCK
 	default y
 	help
-- 
2.7.4

