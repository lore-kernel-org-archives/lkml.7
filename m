Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71475C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B192173C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfE0Iud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:50:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53394 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfE0IuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:50:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D28BD200079;
        Mon, 27 May 2019 10:50:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A179200AF0;
        Mon, 27 May 2019 10:50:00 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B2FD7402FB;
        Mon, 27 May 2019 16:49:52 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 4/7] dmaengine: fsl-edma-common: version check for v2 instead
Date:   Mon, 27 May 2019 16:51:15 +0800
Message-Id: <20190527085118.40423-5-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527085118.40423-1-yibin.gong@nxp.com>
References: <20190527085118.40423-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

The next v3 i.mx7ulp edma is based on v1, so change version
check logic for v2 instead.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index bb24251..45d70d3 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -657,26 +657,26 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 	edma->regs.erql = edma->membase + EDMA_ERQ;
 	edma->regs.eeil = edma->membase + EDMA_EEI;
 
-	edma->regs.serq = edma->membase + ((edma->version == v1) ?
-			EDMA_SERQ : EDMA64_SERQ);
-	edma->regs.cerq = edma->membase + ((edma->version == v1) ?
-			EDMA_CERQ : EDMA64_CERQ);
-	edma->regs.seei = edma->membase + ((edma->version == v1) ?
-			EDMA_SEEI : EDMA64_SEEI);
-	edma->regs.ceei = edma->membase + ((edma->version == v1) ?
-			EDMA_CEEI : EDMA64_CEEI);
-	edma->regs.cint = edma->membase + ((edma->version == v1) ?
-			EDMA_CINT : EDMA64_CINT);
-	edma->regs.cerr = edma->membase + ((edma->version == v1) ?
-			EDMA_CERR : EDMA64_CERR);
-	edma->regs.ssrt = edma->membase + ((edma->version == v1) ?
-			EDMA_SSRT : EDMA64_SSRT);
-	edma->regs.cdne = edma->membase + ((edma->version == v1) ?
-			EDMA_CDNE : EDMA64_CDNE);
-	edma->regs.intl = edma->membase + ((edma->version == v1) ?
-			EDMA_INTR : EDMA64_INTL);
-	edma->regs.errl = edma->membase + ((edma->version == v1) ?
-			EDMA_ERR : EDMA64_ERRL);
+	edma->regs.serq = edma->membase + ((edma->version == v2) ?
+			EDMA64_SERQ : EDMA_SERQ);
+	edma->regs.cerq = edma->membase + ((edma->version == v2) ?
+			EDMA64_CERQ : EDMA_CERQ);
+	edma->regs.seei = edma->membase + ((edma->version == v2) ?
+			EDMA64_SEEI : EDMA_SEEI);
+	edma->regs.ceei = edma->membase + ((edma->version == v2) ?
+			EDMA64_CEEI : EDMA_CEEI);
+	edma->regs.cint = edma->membase + ((edma->version == v2) ?
+			EDMA64_CINT : EDMA_CINT);
+	edma->regs.cerr = edma->membase + ((edma->version == v2) ?
+			EDMA64_CERR : EDMA_CERR);
+	edma->regs.ssrt = edma->membase + ((edma->version == v2) ?
+			EDMA64_SSRT : EDMA_SSRT);
+	edma->regs.cdne = edma->membase + ((edma->version == v2) ?
+			EDMA64_CDNE : EDMA_CDNE);
+	edma->regs.intl = edma->membase + ((edma->version == v2) ?
+			EDMA64_INTL : EDMA_INTR);
+	edma->regs.errl = edma->membase + ((edma->version == v2) ?
+			EDMA64_ERRL : EDMA_ERR);
 
 	if (edma->version == v2) {
 		edma->regs.erqh = edma->membase + EDMA64_ERQH;
-- 
2.7.4

