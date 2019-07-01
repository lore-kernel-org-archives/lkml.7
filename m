Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12A2C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69D4212F5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfGAJsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:48:53 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33664 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfGAJsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:48:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 164042008E0;
        Mon,  1 Jul 2019 11:48:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 85B67200927;
        Mon,  1 Jul 2019 11:48:43 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3453B40297;
        Mon,  1 Jul 2019 17:48:34 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        p.zabel@pengutronix.de, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, daniel.baluta@nxp.com, ping.bai@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] reset: imx7: Add support for i.MX8MM SoC
Date:   Mon,  1 Jul 2019 17:39:43 +0800
Message-Id: <20190701093944.5540-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX8MM SoC has a subset of i.MX8MQ IP block variant, it can reuse
the i.MX8MQ reset controller driver and just skip those non-existing
IP blocks, add support for i.MX8MM SoC reset control.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/reset/reset-imx7.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 3ecd770..941131f 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -207,6 +207,26 @@ static int imx8mq_reset_set(struct reset_controller_dev *rcdev,
 	const unsigned int bit = imx7src->signals[id].bit;
 	unsigned int value = assert ? bit : 0;
 
+	if (of_machine_is_compatible("fsl,imx8mm")) {
+		switch (id) {
+		case IMX8MQ_RESET_HDMI_PHY_APB_RESET:
+		case IMX8MQ_RESET_PCIEPHY2: /* fallthrough */
+		case IMX8MQ_RESET_PCIEPHY2_PERST: /* fallthrough */
+		case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN: /* fallthrough */
+		case IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF: /* fallthrough */
+		case IMX8MQ_RESET_MIPI_CSI1_CORE_RESET: /* fallthrough */
+		case IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET: /* fallthrough */
+		case IMX8MQ_RESET_MIPI_CSI1_ESC_RESET: /* fallthrough */
+		case IMX8MQ_RESET_MIPI_CSI2_CORE_RESET: /* fallthrough */
+		case IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET: /* fallthrough */
+		case IMX8MQ_RESET_MIPI_CSI2_ESC_RESET: /* fallthrough */
+		case IMX8MQ_RESET_DDRC2_PHY_RESET: /* fallthrough */
+		case IMX8MQ_RESET_DDRC2_CORE_RESET: /* fallthrough */
+		case IMX8MQ_RESET_DDRC2_PRST: /* fallthrough */
+			return 0;
+		}
+	}
+
 	switch (id) {
 	case IMX8MQ_RESET_PCIEPHY:
 	case IMX8MQ_RESET_PCIEPHY2: /* fallthrough */
-- 
2.7.4

