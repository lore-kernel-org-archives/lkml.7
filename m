Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3458CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025312054F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="dGL/WWnb";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="dGL/WWnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfC2PVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:21:54 -0400
Received: from node.akkea.ca ([192.155.83.177]:59006 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729046AbfC2PVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:21:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id D6EF74E2056;
        Fri, 29 Mar 2019 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553872901; bh=c+Umh29DYkRqBlFcskVZzYgx4V4hBQqUQ5qRjU2h++k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dGL/WWnbjzX1Dql4+JMFqe+uF7xECjWpnznXbFQU3PSfbr97l976V+kNVWuiXxVOw
         g2q4aWD5jlTDsr8HaYTfjCOeKdAP2tRp8fGnCYmT/6AT5Jl//oicLwbJ+epjTqgXZ7
         6kTIjw+jPTlG6+gYOBFzs6AQ7ORkq6cG3O+VlQzk=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Aix0FLtboPkI; Fri, 29 Mar 2019 15:21:41 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id C00074E204B;
        Fri, 29 Mar 2019 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553872901; bh=c+Umh29DYkRqBlFcskVZzYgx4V4hBQqUQ5qRjU2h++k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dGL/WWnbjzX1Dql4+JMFqe+uF7xECjWpnznXbFQU3PSfbr97l976V+kNVWuiXxVOw
         g2q4aWD5jlTDsr8HaYTfjCOeKdAP2tRp8fGnCYmT/6AT5Jl//oicLwbJ+epjTqgXZ7
         6kTIjw+jPTlG6+gYOBFzs6AQ7ORkq6cG3O+VlQzk=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v2 2/3] dmaengine: imx-sdma: Only check ratio on parts that support 1:1
Date:   Fri, 29 Mar 2019 08:21:29 -0700
Message-Id: <20190329152130.18411-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329152130.18411-1-angus@akkea.ca>
References: <20190328133828.20999-1-angus@akkea.ca>
 <20190329152130.18411-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On imx8mq B0 chip, AHB/SDMA clock ratio 2:1 can't be supported,
since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
to 500Mhz, so use 1:1 instead.

To limit this change to the imx8mq for now this patch also adds an
im8mq-sdma compatible string.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5f3c1378b90e..99d9f431ae2c 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -419,6 +419,7 @@ struct sdma_driver_data {
 	int chnenbl0;
 	int num_events;
 	struct sdma_script_start_addrs	*script_addrs;
+	bool check_ratio;
 };
 
 struct sdma_engine {
@@ -557,6 +558,13 @@ static struct sdma_driver_data sdma_imx7d = {
 	.script_addrs = &sdma_script_imx7d,
 };
 
+static struct sdma_driver_data sdma_imx8mq = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx7d,
+	.check_ratio = 1,
+};
+
 static const struct platform_device_id sdma_devtypes[] = {
 	{
 		.name = "imx25-sdma",
@@ -579,6 +587,9 @@ static const struct platform_device_id sdma_devtypes[] = {
 	}, {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
+	}, {
+		.name = "imx8mq-sdma",
+		.driver_data = (unsigned long)&sdma_imx8mq,
 	}, {
 		/* sentinel */
 	}
@@ -593,6 +604,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
@@ -1852,7 +1864,8 @@ static int sdma_init(struct sdma_engine *sdma)
 	if (ret)
 		goto disable_clk_ipg;
 
-	if (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg))
+	if (sdma->drvdata->check_ratio &&
+	    (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg)))
 		sdma->clk_ratio = 1;
 
 	/* Be sure SDMA has not started yet */
-- 
2.17.1

