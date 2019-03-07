Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28073C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFBF2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfCGQ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:58:48 -0500
Received: from mailoutvs33.siol.net ([185.57.226.224]:46004 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726269AbfCGQ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:58:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id D88495237D4;
        Thu,  7 Mar 2019 17:58:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id a4s5xj_GwEib; Thu,  7 Mar 2019 17:58:42 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 767F5523799;
        Thu,  7 Mar 2019 17:58:42 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id E83EA5237C3;
        Thu,  7 Mar 2019 17:58:39 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 2/6] dmaengine: sun6i: Add a quirk for additional mbus clock
Date:   Thu,  7 Mar 2019 17:58:25 +0100
Message-Id: <20190307165829.9086-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307165829.9086-1-jernej.skrabec@siol.net>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 DMA controller needs additional mbus clock to be enabled.

Add a quirk for it and handle it accordingly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/dma/sun6i-dma.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 0cd13f17fc11..761555080325 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -129,6 +129,7 @@ struct sun6i_dma_config {
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
+	bool mbus_clk;
 };
=20
 /*
@@ -182,6 +183,7 @@ struct sun6i_dma_dev {
 	struct dma_device	slave;
 	void __iomem		*base;
 	struct clk		*clk;
+	struct clk		*clk_mbus;
 	int			irq;
 	spinlock_t		lock;
 	struct reset_control	*rstc;
@@ -1208,6 +1210,14 @@ static int sun6i_dma_probe(struct platform_device =
*pdev)
 		return PTR_ERR(sdc->clk);
 	}
=20
+	if (sdc->cfg->mbus_clk) {
+		sdc->clk_mbus =3D devm_clk_get(&pdev->dev, "mbus");
+		if (IS_ERR(sdc->clk_mbus)) {
+			dev_err(&pdev->dev, "No mbus clock specified\n");
+			return PTR_ERR(sdc->clk_mbus);
+		}
+	}
+
 	sdc->rstc =3D devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(sdc->rstc)) {
 		dev_err(&pdev->dev, "No reset controller specified\n");
@@ -1312,11 +1322,19 @@ static int sun6i_dma_probe(struct platform_device=
 *pdev)
 		goto err_reset_assert;
 	}
=20
+	if (sdc->cfg->mbus_clk) {
+		ret =3D clk_prepare_enable(sdc->clk_mbus);
+		if (ret) {
+			dev_err(&pdev->dev, "Couldn't enable mbus clock\n");
+			goto err_clk_disable;
+		}
+	}
+
 	ret =3D devm_request_irq(&pdev->dev, sdc->irq, sun6i_dma_interrupt, 0,
 			       dev_name(&pdev->dev), sdc);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
-		goto err_clk_disable;
+		goto err_mbus_clk_disable;
 	}
=20
 	ret =3D dma_async_device_register(&sdc->slave);
@@ -1341,6 +1359,8 @@ static int sun6i_dma_probe(struct platform_device *=
pdev)
 	dma_async_device_unregister(&sdc->slave);
 err_irq_disable:
 	sun6i_kill_tasklet(sdc);
+err_mbus_clk_disable:
+	clk_disable_unprepare(sdc->clk_mbus);
 err_clk_disable:
 	clk_disable_unprepare(sdc->clk);
 err_reset_assert:
@@ -1359,6 +1379,7 @@ static int sun6i_dma_remove(struct platform_device =
*pdev)
=20
 	sun6i_kill_tasklet(sdc);
=20
+	clk_disable_unprepare(sdc->clk_mbus);
 	clk_disable_unprepare(sdc->clk);
 	reset_control_assert(sdc->rstc);
=20
--=20
2.21.0

