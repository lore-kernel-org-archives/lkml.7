Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C71C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B423E21841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbfGRKZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:25:24 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45742 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389846AbfGRKZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:25:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5D32D2002D6;
        Thu, 18 Jul 2019 12:25:23 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 50B092000B9;
        Thu, 18 Jul 2019 12:25:23 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BBA77205C7;
        Thu, 18 Jul 2019 12:25:22 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, =kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, paul.olaru@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 2/3] firmware: imx: scu-pd: Add mu13 b side PD range
Date:   Thu, 18 Jul 2019 13:25:18 +0300
Message-Id: <20190718102519.31855-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718102519.31855-1-daniel.baluta@nxp.com>
References: <20190718102519.31855-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSIO subsystem contains 14 MU instances.

5 MUs to communicate between AP <-> SCU
  - side-A PD range managed by AP
  - side-B PD range managed by SCU

9 MUs to communicate between all cores (AP/M4/DSP).
  - side-A PD range managed by core-A (AP/M4/DSP)
  - side-B PD range managed by core-B (AP/M4/DSP).

Communication between AP <-> DSP is done through the
assigned MU number 13.

So, we power up side-A by the AP and we decide to
power up side-B also from AP. This is because powering
it up from DSP would be painful.

Powering up side B from DSP would require the DSP to
communicate with SCU and to keep things simple we don't
want that now.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 950d30238186..eb9700b66a76 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -93,6 +93,7 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "kpp", IMX_SC_R_KPP, 1, false, 0 },
 	{ "fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
 	{ "mu_a", IMX_SC_R_MU_0A, 14, true, 0 },
+	{ "mu_b", IMX_SC_R_MU_13B, 1, true, 13 },
 
 	/* CONN SS */
 	{ "usb", IMX_SC_R_USB_0, 2, true, 0 },
-- 
2.17.1

