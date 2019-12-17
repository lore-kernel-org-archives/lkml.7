Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA007C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4392082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Shbo92/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLQKwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:52:38 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48270 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLQKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:52:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHAqSQ7021780;
        Tue, 17 Dec 2019 04:52:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576579948;
        bh=MnppYqWFagjABTCEaRtDQDACXWEBFJi+7m0e6X3GYEg=;
        h=From:To:CC:Subject:Date;
        b=Shbo92/qOmBGGLk11XqpYELmm0D1uRJRMJ9jCixaDdvt/SF+hVm12KhOJNKX0pUvP
         Uti6aZhRY8dfh0OpBi4Bzib0b6MVhex7jbCc+HdJB69nu4BcnwpgJQ5w+JPnrN6fBO
         d6hlpBLbcLhP20nUW4n9vMEfpK5HiZN+oKDIqAjQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHAqSPP068295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 04:52:28 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 04:52:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 04:52:28 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHAqP6G047872;
        Tue, 17 Dec 2019 04:52:26 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <fabrice.gasnier@st.com>, <lee.jones@linaro.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <vkoul@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: stm32-timers: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 12:52:40 +0200
Message-ID: <20191217105240.25648-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/stm32-timers.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index efcd4b980c94..34747e8a4a40 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -167,10 +167,11 @@ static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
 	regmap_write(ddata->regmap, TIM_ARR, 0x0);
 }
 
-static void stm32_timers_dma_probe(struct device *dev,
+static int stm32_timers_dma_probe(struct device *dev,
 				   struct stm32_timers *ddata)
 {
 	int i;
+	int ret = 0;
 	char name[4];
 
 	init_completion(&ddata->dma.completion);
@@ -179,14 +180,22 @@ static void stm32_timers_dma_probe(struct device *dev,
 	/* Optional DMA support: get valid DMA channel(s) or NULL */
 	for (i = STM32_TIMERS_DMA_CH1; i <= STM32_TIMERS_DMA_CH4; i++) {
 		snprintf(name, ARRAY_SIZE(name), "ch%1d", i + 1);
-		ddata->dma.chans[i] = dma_request_slave_channel(dev, name);
+		ddata->dma.chans[i] = dma_request_chan(dev, name);
 	}
-	ddata->dma.chans[STM32_TIMERS_DMA_UP] =
-		dma_request_slave_channel(dev, "up");
-	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] =
-		dma_request_slave_channel(dev, "trig");
-	ddata->dma.chans[STM32_TIMERS_DMA_COM] =
-		dma_request_slave_channel(dev, "com");
+	ddata->dma.chans[STM32_TIMERS_DMA_UP] = dma_request_chan(dev, "up");
+	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] = dma_request_chan(dev, "trig");
+	ddata->dma.chans[STM32_TIMERS_DMA_COM] = dma_request_chan(dev, "com");
+
+	for (i = STM32_TIMERS_DMA_CH1; i < STM32_TIMERS_MAX_DMAS; i++) {
+		if (IS_ERR(ddata->dma.chans[i])) {
+			if (PTR_ERR(ddata->dma.chans[i]) == -EPROBE_DEFER)
+				ret = -EPROBE_DEFER;
+
+			ddata->dma.chans[i] = NULL;
+		}
+	}
+
+	return ret;
 }
 
 static void stm32_timers_dma_remove(struct device *dev,
@@ -230,7 +239,11 @@ static int stm32_timers_probe(struct platform_device *pdev)
 
 	stm32_timers_get_arr_size(ddata);
 
-	stm32_timers_dma_probe(dev, ddata);
+	ret = stm32_timers_dma_probe(dev, ddata);
+	if (ret) {
+		stm32_timers_dma_remove(dev, ddata);
+		return ret;
+	}
 
 	platform_set_drvdata(pdev, ddata);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

