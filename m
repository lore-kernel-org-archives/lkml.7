Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F473C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B7F218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfGVMs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:48:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51358 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfGVMs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:48:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C5251A01FE;
        Mon, 22 Jul 2019 14:48:56 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F1E11A00AA;
        Mon, 22 Jul 2019 14:48:56 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5D54E205DB;
        Mon, 22 Jul 2019 14:48:55 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     festevam@gmail.com, perex@perex.cz, tiwai@suse.com,
        Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de,
        l.stach@pengutronix.de, viorel.suman@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 10/10] ASoC: fsl_sai: Add support for imx7ulp/imx8mq
Date:   Mon, 22 Jul 2019 15:48:33 +0300
Message-Id: <20190722124833.28757-11-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722124833.28757-1-daniel.baluta@nxp.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAI module on imx7ulp/imx8m features 2 new registers (VERID and PARAM)
at the beginning of register address space.

On imx7ulp FIFOs can held up to 16 x 32 bit samples.
On imx8mq FIFOs can held up to 128 x 32 bit samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index f2441b84877e..b05837465b5a 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1065,10 +1065,24 @@ static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.reg_offset = 0,
 };
 
+static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 16,
+	.reg_offset = 8,
+};
+
+static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 128,
+	.reg_offset = 8,
+};
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
 	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
 	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
+	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
+	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
-- 
2.17.1

