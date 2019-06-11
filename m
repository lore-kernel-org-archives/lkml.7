Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923AEC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED47206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbfFKB3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 21:29:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34648 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390349AbfFKB3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 21:29:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E2A61A098E;
        Tue, 11 Jun 2019 03:29:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A3BA01A0990;
        Tue, 11 Jun 2019 03:29:43 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CA9EB402DD;
        Tue, 11 Jun 2019 09:29:37 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] soc: imx: Add i.MX8MN SoC driver support
Date:   Tue, 11 Jun 2019 09:31:25 +0800
Message-Id: <20190611013125.3434-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

This patch adds i.MX8MN SoC driver support:

root@imx8mnevk:~# cat /sys/devices/soc0/family
Freescale i.MX

root@imx8mnevk:~# cat /sys/devices/soc0/machine
NXP i.MX8MNano DDR4 EVK board

root@imx8mnevk:~# cat /sys/devices/soc0/soc_id
i.MX8MN

root@imx8mnevk:~# cat /sys/devices/soc0/revision
1.0

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/soc-imx8.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index 3842d09..02309a2 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -55,7 +55,12 @@ static u32 __init imx8mm_soc_revision(void)
 	void __iomem *anatop_base;
 	u32 rev;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
+	if (of_machine_is_compatible("fsl,imx8mm"))
+		np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
+	else if (of_machine_is_compatible("fsl,imx8mn"))
+		np = of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
+	else
+		np = NULL;
 	if (!np)
 		return 0;
 
@@ -79,9 +84,15 @@ static const struct imx8_soc_data imx8mm_soc_data = {
 	.soc_revision = imx8mm_soc_revision,
 };
 
+static const struct imx8_soc_data imx8mn_soc_data = {
+	.name = "i.MX8MN",
+	.soc_revision = imx8mm_soc_revision,
+};
+
 static const struct of_device_id imx8_soc_match[] = {
 	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
 	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
+	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
 	{ }
 };
 
-- 
2.7.4

