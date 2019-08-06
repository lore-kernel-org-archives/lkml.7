Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E0C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548B2216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbfHFG4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:56:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59398 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731557AbfHFG4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:56:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CA47C200052;
        Tue,  6 Aug 2019 08:56:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 40B9E200074;
        Tue,  6 Aug 2019 08:55:54 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AFB1840293;
        Tue,  6 Aug 2019 14:55:43 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, peng.fan@nxp.com, leonard.crestez@nxp.com,
        ping.bai@nxp.com, jun.li@nxp.com, chen.fang@nxp.com,
        agx@sigxcpu.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] clk: imx8mm: Unregister clks when of_clk_add_provider failed
Date:   Tue,  6 Aug 2019 14:46:13 +0800
Message-Id: <20190806064614.20294-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

When of_clk_add_provider failed, all clks should be unregistered.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index e494e99..49ad761 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -661,12 +661,17 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	ret = of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 	if (ret < 0) {
 		pr_err("failed to register clks for i.MX8MM\n");
-		return -EINVAL;
+		goto unregister_clks;
 	}
 
 	imx_register_uart_clocks(uart_clks);
 
 	return 0;
+
+unregister_clks:
+	imx_unregister_clocks(clks, ARRAY_SIZE(clks));
+
+	return ret;
 }
 
 static const struct of_device_id imx8mm_clk_of_match[] = {
-- 
2.7.4

