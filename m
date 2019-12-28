Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFCEC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF8E208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4aLciAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfL1Ur5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:47:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36598 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfL1Urj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:47:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so29879286ljg.3;
        Sat, 28 Dec 2019 12:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIEJVFrrx4gky/ZOSTsCbKeEbeTJKbAx8QcAIMAQtco=;
        b=Z4aLciAa4SH3GG56GphUFmI5dvcpPOPdLZ2vY6B+ZTlLzIi/myT5WxIgydTE7FwEm7
         N5jZNZurvRCXXJe+Y6WD7o7fJlUKeEK4tJjEAbbmiHrNbR5e62mLcDmORYPA81phwlxG
         kOvhXL2G3lWdXYiHU0F8JJs6BksLojoMXSsM+74XgAgB6eKyIAHSOSB316ibUnQzf6IL
         a8gsRIHMyQ3/c/oq18rR9uOtPSOL/7d7j+MboNC2VO5ML76NvnnoYmwtYCKAZJnlru1L
         muUycFZ2SHEk4FxmfrR3mvsBPFkf18Jjzegm2FWn00yS5lIbBWnUq9H7FjF+4kU6Xd0f
         CM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIEJVFrrx4gky/ZOSTsCbKeEbeTJKbAx8QcAIMAQtco=;
        b=JCwMVcG7OANIwicFVOuubmHr/5aBIN+FNnG41xVfVzMF71oYc9HfEnyULodZWgkpts
         /GE/XkPSk0EK3nVXxBkz0UBUECR4E39ZAGnu15ZLw+bT1vvq7WubhemoQME8Z2S++/XM
         +tICgerlM18SzBI5IL81Ng3R+rxSkPaNfpMIqBlyR21lzeiSy/A+7oKrx2AjojDrv63k
         UaXhjsJhuNmJ+Ay0PQkBXvav7qj18SeUyFgwwE/eXx8lUsdwKVtre2BFRxdy6z+EOUA3
         PHUlq54aFm0SNOs3NEXQ9bD3dvfqWYI9vlR9uvOZc7JiiaKYYTZD8LSCsEQQYPUBvJ7p
         nIdg==
X-Gm-Message-State: APjAAAV1NABO543ex+gXzlUvsLPnvE8o1e2qRIsGzLTI/kZuNTmncxxY
        Cc3lc/d3ocOUqMCHxU4Syoo+YBkf
X-Google-Smtp-Source: APXvYqyEIX2Bqkh3D/lYkO4osanHP8eNOJOErqxIxITuHT47wuICMUHMUeaP6Xz35otnapNs6N/Oag==
X-Received: by 2002:a2e:721a:: with SMTP id n26mr32498950ljc.128.1577566057155;
        Sat, 28 Dec 2019 12:47:37 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm10571219ljl.10.2019.12.28.12.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:47:36 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/7] dmaengine: tegra-apb: Use devm_request_irq
Date:   Sat, 28 Dec 2019 23:46:39 +0300
Message-Id: <20191228204640.25163-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228204640.25163-1-digetx@gmail.com>
References: <20191228204640.25163-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use resource-managed variant of request_irq for brevity.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index d2353f23b201..194a7faf12ba 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -182,7 +182,6 @@ struct tegra_dma_channel {
 	char			name[12];
 	bool			config_init;
 	int			id;
-	int			irq;
 	void __iomem		*chan_addr;
 	spinlock_t		lock;
 	bool			busy;
@@ -1383,7 +1382,6 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
 
 static int tegra_dma_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct tegra_dma *tdma;
 	int ret;
 	int i;
@@ -1449,25 +1447,27 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < cdata->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
+		int irq;
 
 		tdc->chan_addr = tdma->base_addr +
 				 TEGRA_APBDMA_CHANNEL_BASE_ADD_OFFSET +
 				 (i * cdata->channel_reg_size);
 
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!res) {
-			ret = -EINVAL;
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			ret = irq;
 			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
-			goto err_irq;
+			goto err_pm_disable;
 		}
-		tdc->irq = res->start;
+
 		snprintf(tdc->name, sizeof(tdc->name), "apbdma.%d", i);
-		ret = request_irq(tdc->irq, tegra_dma_isr, 0, tdc->name, tdc);
+		ret = devm_request_irq(&pdev->dev, irq, tegra_dma_isr, 0,
+				       tdc->name, tdc);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"request_irq failed with err %d channel %d\n",
 				ret, i);
-			goto err_irq;
+			goto err_pm_disable;
 		}
 
 		tdc->dma_chan.device = &tdma->dma_dev;
@@ -1520,7 +1520,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Tegra20 APB DMA driver registration failed %d\n", ret);
-		goto err_irq;
+		goto err_pm_disable;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
@@ -1537,13 +1537,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma_dev:
 	dma_async_device_unregister(&tdma->dma_dev);
-err_irq:
-	while (--i >= 0) {
-		struct tegra_dma_channel *tdc = &tdma->channels[i];
-
-		free_irq(tdc->irq, tdc);
-	}
-
+err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_dma_runtime_suspend(&pdev->dev);
@@ -1553,16 +1547,9 @@ static int tegra_dma_probe(struct platform_device *pdev)
 static int tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
-	int i;
-	struct tegra_dma_channel *tdc;
 
 	dma_async_device_unregister(&tdma->dma_dev);
 
-	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
-		tdc = &tdma->channels[i];
-		free_irq(tdc->irq, tdc);
-	}
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_dma_runtime_suspend(&pdev->dev);
-- 
2.24.0

