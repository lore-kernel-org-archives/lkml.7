Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13399C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D38222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfDSSVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:21:06 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58650 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbfDSSVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED4D0200176;
        Fri, 19 Apr 2019 10:53:32 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C3C572000D0;
        Fri, 19 Apr 2019 10:53:29 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 857E9402BB;
        Fri, 19 Apr 2019 16:53:25 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     leoyang.li@nxp.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Ma <peng.ma@nxp.com>
Subject: [PATCH] dmaengine: fsl-qdma: fixed the source/destination descriptior format
Date:   Fri, 19 Apr 2019 08:46:29 +0000
Message-Id: <20190419084629.41742-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMD of Source/Destination descriptior format should be lower of
struct fsl_qdma_engine number data address.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 drivers/dma/fsl-qdma.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index aa1d0ae..542765a 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -113,6 +113,7 @@
 /* Field definition for Descriptor offset */
 #define QDMA_CCDF_STATUS		20
 #define QDMA_CCDF_OFFSET		20
+#define QDMA_SDDF_CMD(x)		(((u64)(x)) << 32)
 
 /* Field definition for safe loop count*/
 #define FSL_QDMA_HALT_COUNT		1500
@@ -214,6 +215,12 @@ struct fsl_qdma_engine {
 
 };
 
+static inline void
+qdma_sddf_set_cmd(struct fsl_qdma_format *sddf, u32 val)
+{
+	sddf->data = QDMA_SDDF_CMD(val);
+}
+
 static inline u64
 qdma_ccdf_addr_get64(const struct fsl_qdma_format *ccdf)
 {
@@ -341,6 +348,7 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
 static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 				      dma_addr_t dst, dma_addr_t src, u32 len)
 {
+	u32 cmd;
 	struct fsl_qdma_format *sdf, *ddf;
 	struct fsl_qdma_format *ccdf, *csgf_desc, *csgf_src, *csgf_dest;
 
@@ -353,6 +361,7 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 
 	memset(fsl_comp->virt_addr, 0, FSL_QDMA_COMMAND_BUFFER_SIZE);
 	memset(fsl_comp->desc_virt_addr, 0, FSL_QDMA_DESCRIPTOR_BUFFER_SIZE);
+
 	/* Head Command Descriptor(Frame Descriptor) */
 	qdma_desc_addr_set64(ccdf, fsl_comp->bus_addr + 16);
 	qdma_ccdf_set_format(ccdf, qdma_ccdf_get_offset(ccdf));
@@ -369,14 +378,14 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 	/* This entry is the last entry. */
 	qdma_csgf_set_f(csgf_dest, len);
 	/* Descriptor Buffer */
-	sdf->data =
-		cpu_to_le64(FSL_QDMA_CMD_RWTTYPE <<
-			    FSL_QDMA_CMD_RWTTYPE_OFFSET);
-	ddf->data =
-		cpu_to_le64(FSL_QDMA_CMD_RWTTYPE <<
-			    FSL_QDMA_CMD_RWTTYPE_OFFSET);
-	ddf->data |=
-		cpu_to_le64(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
+	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
+			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
+	qdma_sddf_set_cmd(sdf, cmd);
+
+	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
+			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
+	cmd |= cpu_to_le32(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
+	qdma_sddf_set_cmd(ddf, cmd);
 }
 
 /*
@@ -701,10 +710,8 @@ static irqreturn_t fsl_qdma_error_handler(int irq, void *dev_id)
 
 	intr = qdma_readl(fsl_qdma, status + FSL_QDMA_DEDR);
 
-	if (intr) {
+	if (intr)
 		dev_err(fsl_qdma->dma_dev.dev, "DMA transaction error!\n");
-		return IRQ_NONE;
-	}
 
 	qdma_writel(fsl_qdma, FSL_QDMA_DEDR_CLEAR, status + FSL_QDMA_DEDR);
 	return IRQ_HANDLED;
-- 
1.7.1

