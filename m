Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6188AC3B1B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0767246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfLMMHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:07:05 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36626 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfLMMHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:07:03 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CB75F1A0079;
        Fri, 13 Dec 2019 13:07:01 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B4EB61A08FE;
        Fri, 13 Dec 2019 13:07:01 +0100 (CET)
Received: from fsr-ub1664-134.ea.freescale.net (fsr-ub1664-134.ea.freescale.net [10.171.74.111])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DA126203B1;
        Fri, 13 Dec 2019 13:07:00 +0100 (CET)
From:   Mirela Rabulea <mirela.rabulea@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl, shawnguo@kernel.org,
        robh+dt@kernel.org
Cc:     paul.kocialkowski@bootlin.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        daniel.baluta@nxp.com, leonard.crestez@nxp.com,
        robert.chiras@nxp.com, laurentiu.palcu@nxp.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se,
        dafna.hirschfeld@collabora.com,
        Mirela Rabulea <mirela.rabulea@nxp.com>
Subject: [PATCH v3 2/6] firmware: imx: scu-pd: Add power domains for imx-jpeg
Date:   Fri, 13 Dec 2019 14:06:17 +0200
Message-Id: <1576238781-5911-3-git-send-email-mirela.rabulea@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576238781-5911-1-git-send-email-mirela.rabulea@nxp.com>
References: <1576238781-5911-1-git-send-email-mirela.rabulea@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power domains are for imx8qxp/imx8qm JPEG encoder & decoder.
Each has 4 slots and a wrapper.

Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index b556612..e7bf48a 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -158,6 +158,12 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* DC SS */
 	{ "dc0", IMX_SC_R_DC_0, 1, false, 0 },
 	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
+
+	/* IMAGE SS */
+	{ "img-jpegdec-mp", IMX_SC_R_MJPEG_DEC_MP, 1, false, 0 },
+	{ "img-jpegdec-s0", IMX_SC_R_MJPEG_DEC_S0, 4, true, 0 },
+	{ "img-jpegenc-mp", IMX_SC_R_MJPEG_ENC_MP, 1, false, 0 },
+	{ "img-jpegenc-s0", IMX_SC_R_MJPEG_ENC_S0, 4, true, 0 },
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.7.4

