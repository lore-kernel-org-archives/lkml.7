Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A638C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5992C206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="F8ni7Q2r";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="F8ni7Q2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfC1NjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:39:06 -0400
Received: from node.akkea.ca ([192.155.83.177]:39770 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfC1NjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:39:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id C5A3F4E2056;
        Thu, 28 Mar 2019 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553780341; bh=fNaIjWRIVnNMd6AISqrruiGJSzIQ1OoNjKoWTTC2aP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=F8ni7Q2rx0UA3xwgVS5efat2OPTLBxc89ym7saobZTHXkasSNeS6utFCeMhvdtDLH
         sV6jQbJg+DB9TCjqbK9hlgHrhKTA23BE5QCpGy/qmf/wkOxnVAdzvqdBhE3oXdgbzV
         9aIcJZewBOkc+MFt+5u+yxKf4Mi3E0joTxO6whfU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IbBzRuv9lKjr; Thu, 28 Mar 2019 13:39:01 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id A03CE4E204B;
        Thu, 28 Mar 2019 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553780341; bh=fNaIjWRIVnNMd6AISqrruiGJSzIQ1OoNjKoWTTC2aP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=F8ni7Q2rx0UA3xwgVS5efat2OPTLBxc89ym7saobZTHXkasSNeS6utFCeMhvdtDLH
         sV6jQbJg+DB9TCjqbK9hlgHrhKTA23BE5QCpGy/qmf/wkOxnVAdzvqdBhE3oXdgbzV
         9aIcJZewBOkc+MFt+5u+yxKf4Mi3E0joTxO6whfU=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
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
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 2/4] dmaengine: imx-sdma: Add clock ratio 1:1 check
Date:   Thu, 28 Mar 2019 06:38:26 -0700
Message-Id: <20190328133828.20999-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190328133828.20999-1-angus@akkea.ca>
References: <20190328133828.20999-1-angus@akkea.ca>
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
 drivers/dma/imx-sdma.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 7fae4bf885d5..99d9f431ae2c 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -419,6 +419,7 @@ struct sdma_driver_data {
 	int chnenbl0;
 	int num_events;
 	struct sdma_script_start_addrs	*script_addrs;
+	bool check_ratio;
 };
 
 struct sdma_engine {
@@ -441,6 +442,8 @@ struct sdma_engine {
 	unsigned int			irq;
 	dma_addr_t			bd0_phys;
 	struct sdma_buffer_descriptor	*bd0;
+	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
+	bool				clk_ratio;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -555,6 +558,13 @@ static struct sdma_driver_data sdma_imx7d = {
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
@@ -577,6 +587,9 @@ static const struct platform_device_id sdma_devtypes[] = {
 	}, {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
+	}, {
+		.name = "imx8mq-sdma",
+		.driver_data = (unsigned long)&sdma_imx8mq,
 	}, {
 		/* sentinel */
 	}
@@ -591,6 +604,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
@@ -663,8 +677,11 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
 
 	/* Set bits of CONFIG register with dynamic context switching */
-	if (readl(sdma->regs + SDMA_H_CONFIG) == 0)
-		writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
+	reg = readl(sdma->regs + SDMA_H_CONFIG);
+	if ((reg & SDMA_H_CONFIG_CSM) == 0) {
+		reg |= SDMA_H_CONFIG_CSM;
+		writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
+	}
 
 	return ret;
 }
@@ -1847,6 +1864,10 @@ static int sdma_init(struct sdma_engine *sdma)
 	if (ret)
 		goto disable_clk_ipg;
 
+	if (sdma->drvdata->check_ratio &&
+	    (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg)))
+		sdma->clk_ratio = 1;
+
 	/* Be sure SDMA has not started yet */
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
 
@@ -1887,8 +1908,10 @@ static int sdma_init(struct sdma_engine *sdma)
 	writel_relaxed(0x4050, sdma->regs + SDMA_CHN0ADDR);
 
 	/* Set bits of CONFIG register but with static context switching */
-	/* FIXME: Check whether to set ACR bit depending on clock ratios */
-	writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
+	if (sdma->clk_ratio)
+		writel_relaxed(SDMA_H_CONFIG_ACR, sdma->regs + SDMA_H_CONFIG);
+	else
+		writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
 
 	writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
 
-- 
2.17.1

