Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C139AC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44312080A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfFNIQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:16:10 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58792 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfFNIPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:15:48 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5EDF42005DE;
        Fri, 14 Jun 2019 10:15:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 468F52005DF;
        Fri, 14 Jun 2019 10:15:40 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id ED35D402CA;
        Fri, 14 Jun 2019 16:15:32 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com, angelo@sysam.it
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v4 2/6] dmaengine: fsl-edma-common: move dmamux register to another single function
Date:   Fri, 14 Jun 2019 16:17:20 +0800
Message-Id: <20190614081724.13366-3-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614081724.13366-1-yibin.gong@nxp.com>
References: <20190614081724.13366-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Prepare for edmav2 on i.mx7ulp whose dmamux register is 32bit. No function
impacted.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 07d9689..ba74e10 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -77,6 +77,19 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 }
 EXPORT_SYMBOL_GPL(fsl_edma_disable_request);
 
+static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
+			   u32 off, u32 slot, bool enable)
+{
+	u8 val8;
+
+	if (enable)
+		val8 = EDMAMUX_CHCFG_ENBL | slot;
+	else
+		val8 = EDMAMUX_CHCFG_DIS;
+
+	iowrite8(val8, addr + off);
+}
+
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable)
 {
@@ -90,10 +103,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-	if (enable)
-		iowrite8(EDMAMUX_CHCFG_ENBL | slot, muxaddr + ch_off);
-	else
-		iowrite8(EDMAMUX_CHCFG_DIS, muxaddr + ch_off);
+	mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
 }
 EXPORT_SYMBOL_GPL(fsl_edma_chan_mux);
 
-- 
2.7.4

