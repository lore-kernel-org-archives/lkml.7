Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C4ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FA021920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfJBP3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:29:50 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:60490 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfJBP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:29:49 -0400
Received: from ramsan ([84.194.98.4])
        by laurent.telenet-ops.be with bizsmtp
        id 8fVn2100n05gfCL01fVnvm; Wed, 02 Oct 2019 17:29:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iFgZX-0000sZ-LH; Wed, 02 Oct 2019 17:29:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iFgZX-00031d-Is; Wed, 02 Oct 2019 17:29:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] mmc: renesas_sdhi: Do not use platform_get_irq() to count interrupts
Date:   Wed,  2 Oct 2019 17:29:46 +0200
Message-Id: <20191002152946.11586-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As platform_get_irq() now prints an error when the interrupt does not
exist, counting interrupts by looping until failure causes the printing
of scary messages like:

    renesas_sdhi_internal_dmac ee140000.sd: IRQ index 1 not found

Fix this by using the platform_irq_count() helper to avoid touching
non-existent interrupts.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2:
  - Add Reviewed-by, Tested-by,
  - Return failure in case num_irqs is zero, as before.

This is a fix for v5.4-rc1.
---
 drivers/mmc/host/renesas_sdhi_core.c | 31 +++++++++++++++++-----------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index d4ada5cca2d14f6a..234551a68739b65b 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -646,8 +646,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	struct tmio_mmc_dma *dma_priv;
 	struct tmio_mmc_host *host;
 	struct renesas_sdhi *priv;
+	int num_irqs, irq, ret, i;
 	struct resource *res;
-	int irq, ret, i;
 	u16 ver;
 
 	of_data = of_device_get_match_data(&pdev->dev);
@@ -825,24 +825,31 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->hs400_complete = renesas_sdhi_hs400_complete;
 	}
 
-	i = 0;
-	while (1) {
+	num_irqs = platform_irq_count(pdev);
+	if (num_irqs < 0) {
+		ret = num_irqs;
+		goto eirq;
+	}
+
+	/* There must be at least one IRQ source */
+	if (!num_irqs) {
+		ret = -ENXIO;
+		goto eirq;
+	}
+
+	for (i = 0; i < num_irqs; i++) {
 		irq = platform_get_irq(pdev, i);
-		if (irq < 0)
-			break;
-		i++;
+		if (irq < 0) {
+			ret = irq;
+			goto eirq;
+		}
+
 		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
 				       dev_name(&pdev->dev), host);
 		if (ret)
 			goto eirq;
 	}
 
-	/* There must be at least one IRQ source */
-	if (!i) {
-		ret = irq;
-		goto eirq;
-	}
-
 	dev_info(&pdev->dev, "%s base at 0x%08lx max clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
-- 
2.17.1

