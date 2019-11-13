Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE10D2245C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NZ6mZRhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfKMJWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:22:03 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54264 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfKMJV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:21:56 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Lgvh056846;
        Wed, 13 Nov 2019 03:21:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573636902;
        bh=7J9dO2iGLJeSsQJV9q1KwAwKui5gqNqfEb8754dKT7w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NZ6mZRhQZmTg0Yt3cbGzmkys/diMbkoT3syjL4K84CyGaB0IYYgJLYg0V3UTMTk1S
         yHVbOCVFoVmdKL0jA6JDJyTn9C0WleWXJ+YoB+M8YPCu2g+7UH5HeZhaKRMshc7vIq
         9J7/fSnYv9mbyHMpB26K54n6IT7fRc1YKq3owfws=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9LfBq030622;
        Wed, 13 Nov 2019 03:21:41 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:21:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:21:24 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9LJ1K056807;
        Wed, 13 Nov 2019 03:21:37 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ludovic.desroches@microchip.com>, <agross@kernel.org>,
        <wsa+renesas@sang-engineering.com>, <ldewangan@nvidia.com>
CC:     <vkoul@kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <digetx@gmail.com>,
        <linux-tegra@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <bjorn.andersson@linaro.org>
Subject: [PATCH 4/4] i2c: tegra: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:22:35 +0200
Message-ID: <20191113092235.30440-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113092235.30440-1-peter.ujfalusi@ti.com>
References: <20191113092235.30440-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/i2c/busses/i2c-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index c1683f9338b4..a98bf31d0e5c 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -413,7 +413,7 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 		return 0;
 	}
 
-	chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
+	chan = dma_request_chan(i2c_dev->dev, "rx");
 	if (IS_ERR(chan)) {
 		err = PTR_ERR(chan);
 		goto err_out;
@@ -421,7 +421,7 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 
 	i2c_dev->rx_dma_chan = chan;
 
-	chan = dma_request_slave_channel_reason(i2c_dev->dev, "tx");
+	chan = dma_request_chan(i2c_dev->dev, "tx");
 	if (IS_ERR(chan)) {
 		err = PTR_ERR(chan);
 		goto err_out;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

