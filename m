Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA0CC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8552173C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE0Iui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:50:38 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53126 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfE0IuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:50:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB482200B01;
        Mon, 27 May 2019 10:50:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 22766200092;
        Mon, 27 May 2019 10:49:56 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DBCC8402E6;
        Mon, 27 May 2019 16:49:48 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 1/7] dmaengine: fsl-edma: add dmamux_nr for next version
Date:   Mon, 27 May 2019 16:51:12 +0800
Message-Id: <20190527085118.40423-2-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527085118.40423-1-yibin.gong@nxp.com>
References: <20190527085118.40423-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Next version of edma such as edmav2 on i.mx7ulp has only one dmamux.
Add dmamux_nr instead of static macro define 'DMAMUX_NR'. No any
function change here.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.h |  1 +
 drivers/dma/fsl-edma.c        | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index c53f76e..21a9cfd 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -145,6 +145,7 @@ struct fsl_edma_engine {
 	void __iomem		*membase;
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
+	u32			dmamux_nr;
 	struct mutex		fsl_edma_mutex;
 	u32			n_chans;
 	int			txirq;
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index d641ef8..7b65ef4 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -96,7 +96,7 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 	struct fsl_edma_engine *fsl_edma = ofdma->of_dma_data;
 	struct dma_chan *chan, *_chan;
 	struct fsl_edma_chan *fsl_chan;
-	unsigned long chans_per_mux = fsl_edma->n_chans / DMAMUX_NR;
+	unsigned long chans_per_mux = fsl_edma->n_chans / fsl_edma->dmamux_nr;
 
 	if (dma_spec->args_count != 2)
 		return NULL;
@@ -206,6 +206,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	fsl_edma->version = v1;
+	fsl_edma->dmamux_nr = DMAMUX_NR;
 	fsl_edma->n_chans = chans;
 	mutex_init(&fsl_edma->fsl_edma_mutex);
 
@@ -217,7 +218,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma_setup_regs(fsl_edma);
 	regs = &fsl_edma->regs;
 
-	for (i = 0; i < DMAMUX_NR; i++) {
+	for (i = 0; i < fsl_edma->dmamux_nr; i++) {
 		char clkname[32];
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1 + i);
@@ -295,7 +296,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
+		fsl_disable_clocks(fsl_edma, fsl_edma->dmamux_nr);
 		return ret;
 	}
 
@@ -304,7 +305,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
+		fsl_disable_clocks(fsl_edma, fsl_edma->dmamux_nr);
 		return ret;
 	}
 
@@ -323,7 +324,7 @@ static int fsl_edma_remove(struct platform_device *pdev)
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
-	fsl_disable_clocks(fsl_edma, DMAMUX_NR);
+	fsl_disable_clocks(fsl_edma, fsl_edma->dmamux_nr);
 
 	return 0;
 }
-- 
2.7.4

