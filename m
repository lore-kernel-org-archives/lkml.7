Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199F0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E270220879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639921;
	bh=bieoZxUuM0eYUMgkc97RF8clTu3pxaHE+SnDROpgHX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RrCm/R0oR4Q0WHAb7fc4jmHkKS9Wbh2BlXGKxEVxLjJEcl/I0BnzmMygk2Y67868h
	 H7gRps2GUBwr3ce769Pzyjw3YvXy8S8e2avu+c8bATR0Jt7eW6NCCh1RE+BgfZQa4v
	 wsKuv/9wxiOL6HH3NpYkJepCCy0Vf1Xqu2tw8g8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403892AbfEWTcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391242AbfEWTbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:31:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A86802184E;
        Thu, 23 May 2019 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639869;
        bh=bieoZxUuM0eYUMgkc97RF8clTu3pxaHE+SnDROpgHX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAzSiODjBwELXeUVdWH14KY93rT+s3fbhNKB+CVW3javjVT2Xb4z2I8HmLzLyJ3F3
         CQB3nZn4caRWqxEmR5yMApCsHN3Qb4DyX8jBhrA5jgy6UVlWDH+1dNS+7hfM4HRddx
         qXe4+PWI85LZ3fb1xSID36ZZ1GcPDvnKl0ZGRVPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Robin Gong <yibin.gong@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 5.1 114/122] dmaengine: imx-sdma: Only check ratio on parts that support 1:1
Date:   Thu, 23 May 2019 21:07:16 +0200
Message-Id: <20190523181720.626436939@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angus Ainslie (Purism) <angus@akkea.ca>

commit 941acd566b1807b291bbdca31cc5158e26ffcf83 upstream.

On imx8mq B0 chip, AHB/SDMA clock ratio 2:1 can't be supported,
since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
to 500Mhz, so use 1:1 instead.

To limit this change to the imx8mq for now this patch also adds an
im8mq-sdma compatible string.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Acked-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Cc: Richard Leitner <richard.leitner@skidata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/imx-sdma.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -419,6 +419,7 @@ struct sdma_driver_data {
 	int chnenbl0;
 	int num_events;
 	struct sdma_script_start_addrs	*script_addrs;
+	bool check_ratio;
 };
 
 struct sdma_engine {
@@ -557,6 +558,13 @@ static struct sdma_driver_data sdma_imx7
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
@@ -580,6 +588,9 @@ static const struct platform_device_id s
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
 	}, {
+		.name = "imx8mq-sdma",
+		.driver_data = (unsigned long)&sdma_imx8mq,
+	}, {
 		/* sentinel */
 	}
 };
@@ -593,6 +604,7 @@ static const struct of_device_id sdma_dt
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
@@ -1852,7 +1864,8 @@ static int sdma_init(struct sdma_engine
 	if (ret)
 		goto disable_clk_ipg;
 
-	if (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg))
+	if (sdma->drvdata->check_ratio &&
+	    (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg)))
 		sdma->clk_ratio = 1;
 
 	/* Be sure SDMA has not started yet */


