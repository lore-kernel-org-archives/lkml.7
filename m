Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F2CA9EAE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF7F2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfJUCcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:32:52 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48842 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfJUCcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:32:51 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A1C231A04CB;
        Mon, 21 Oct 2019 04:32:49 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D22EF1A085F;
        Mon, 21 Oct 2019 04:32:45 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 41597402B4;
        Mon, 21 Oct 2019 10:32:41 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        k.kozlowski.k@gmail.com, fabio.estevam@nxp.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [V2] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A platform
Date:   Mon, 21 Oct 2019 10:21:49 +0800
Message-Id: <20191021022149.37112-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our platforms(such as LS1021A, LS1012A, LS1043A, LS1046A, LS1028A) with below
registers(CHCFG0 - CHCFG15) of eDMA as follows:
*-----------------------------------------------------------*
|     Offset   |	OTHERS      |		LS1028A	    |
|--------------|--------------------|-----------------------|
|     0x0      |        CHCFG0      |           CHCFG3      |
|--------------|--------------------|-----------------------|
|     0x1      |        CHCFG1      |           CHCFG2      |
|--------------|--------------------|-----------------------|
|     0x2      |        CHCFG2      |           CHCFG1      |
|--------------|--------------------|-----------------------|
|     0x3      |        CHCFG3      |           CHCFG0      |
|--------------|--------------------|-----------------------|
|     ...      |        ......      |           ......      |
|--------------|--------------------|-----------------------|
|     0xC      |        CHCFG12     |           CHCFG15     |
|--------------|--------------------|-----------------------|
|     0xD      |        CHCFG13     |           CHCFG14     |
|--------------|--------------------|-----------------------|
|     0xE      |        CHCFG14     |           CHCFG13     |
|--------------|--------------------|-----------------------|
|     0xF      |        CHCFG15     |           CHCFG12     |
*-----------------------------------------------------------*

This patch is to improve edma driver to fit LS1028A platform.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
Changed for V2:
	- Explaining what's the "Our platforms"

 drivers/dma/fsl-edma-common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b1a7ca9..611186b 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/sys_soc.h>
 
 #include "fsl-edma-common.h"
 
@@ -42,6 +43,11 @@
 
 #define EDMA_TCD		0x1000
 
+static struct soc_device_attribute soc_fixup_tuning[] = {
+	{ .family = "QorIQ LS1028A"},
+	{ },
+};
+
 static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 {
 	struct edma_regs *regs = &fsl_chan->edma->regs;
@@ -109,10 +115,16 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 	void __iomem *muxaddr;
 	unsigned int chans_per_mux, ch_off;
+	int endian_diff[4] = {3, 1, -1, -3};
 	u32 dmamux_nr = fsl_chan->edma->drvdata->dmamuxs;
 
 	chans_per_mux = fsl_chan->edma->n_chans / dmamux_nr;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
+
+	if (!fsl_chan->edma->big_endian &&
+	    soc_device_match(soc_fixup_tuning))
+		ch_off += endian_diff[ch_off % 4];
+
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-- 
2.9.5

